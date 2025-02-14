package com.tmmas.cl.scl.pv.customerorder.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;

public class SecurityFilter implements Filter {

	private String errorPage = "error.jsp";

	private String loginAction = "/LoginAction.do";

	private final Category logger = Category.getInstance(SecurityFilter.class);

	private CompositeConfiguration config;
	
	
	private void setLogFile() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");	
	}
	
	private void SecurityFilter () {
		setLogFile();
	}
	
	public void destroy() {
		logger.debug("destroy():start");
		logger.debug("destroy():end");
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest req, ServletResponse resp,FilterChain chain) 
		throws IOException, ServletException 
	{
		logger.debug("doFilter():start");
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;

		// El recurso llamado es la pagina de error. Debo dejar procesarla

		String path = request.getServletPath();
		logger.debug("request[" + path + "]");
		if (path.equals(this.errorPage) || path.equals(this.loginAction)) {
			chain.doFilter(request, response);
			return;
		}

		HttpSession session = request.getSession(false);
		if (session == null) {
			logger.debug("No existe sesion");
			String pagina = request.getContextPath() + this.errorPage;
			logger.debug("Redireccionando a pagina de error[" + pagina + "]");
			response.sendError(0, "<b>La Sessión ha expirado</b><br><br>Por motivos de seguridad, la aplicaci&oacute;n espera un tiempo produntente antes de desconectarse, si este tiempo es superado la aplicaci&oacute;n cierra la secci&oacute;n para garantizar la integridad de la informaci&oacute;n.");
			response.sendRedirect(pagina);
 
		} else {
			logger.debug("Session existente");
			CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO) session
					.getAttribute("CustomerOrder");
			if (sessionData == null) {
				String pagina = request.getContextPath() + this.errorPage;
				logger.debug("Redireccionando a pagina de error[" + pagina + "]");
				response.sendRedirect(pagina);
			}
		}

		chain.doFilter(request, response);
		logger.debug("doFilter():end");
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		logger.debug("init():start");
		this.errorPage = filterConfig.getInitParameter("errorPage");
		logger.debug("init():end");
	}

}
