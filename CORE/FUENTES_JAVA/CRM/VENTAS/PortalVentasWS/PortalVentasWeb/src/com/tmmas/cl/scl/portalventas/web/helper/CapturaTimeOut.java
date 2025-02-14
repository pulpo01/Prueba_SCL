package com.tmmas.cl.scl.portalventas.web.helper;

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

import org.apache.log4j.Category;
import org.apache.log4j.Logger;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;



public class CapturaTimeOut implements Filter {

	private final Logger cat = Logger.getLogger(CapturaTimeOut.class);
    
    public void init(FilterConfig config) throws ServletException {
    	//this.config = config;
    } 
    
    public void destroy() {
    	//config = null;
    }
    

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		String errorPage = "/sessionTimeOut.jsp";
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		
		// El recurso llamado es la pagina de error o el login o acciones provocados por los tag src o dwr. 
		// Debo dejar procesarla
		String path = request.getServletPath();
		if (path.equals("") || path.equals(errorPage) || path.equals("/login.jsp") || path.equals("/LoginAction.do")||esBoton(path) || path.equals("/ImpresionAction.do") || path.equals("/CargarLogin.do") ) { // P-CSR-11002 JLGN 04-04-2011
			lc("Entrando por pagina sessionTimeOut o loginAction [" + path + "]");
			chain.doFilter(request, response);
			return;
		}
		else {
			lc("Sirviendo otro recurso distinto de login action y pagina de error [" + path + "]");
			HttpSession session = request.getSession(false);
			if (session == null) {
				lc("\tNo existe sesion.");
				String pagina = errorPage;
				//lc("\t(session=null)Redireccionando a pagina de error[" + pagina + "]");
				request.getRequestDispatcher(pagina).forward(request, response );
			} else {
				lc("\tSession existente");
				ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)session.getAttribute("paramGlobal"); 
				if (sessionData == null) {
					String pagina = errorPage;
					lc("\t(sessionData=null)Redireccionando a pagina de error[" + pagina + "]");
					request.getRequestDispatcher(pagina).forward(request, response );
				}else
				{
					//lc("\tFiltrando el request...");
					chain.doFilter(request, response);
					//lc("\tFiltrando la respuesta...");
				}
			}
		}
	}
	
	public void lc(String s)
	{
		cat.debug(s);
	}
	
	String styShet = "/css/calendar.css";
	String styShe2 = "/css/mas.css";
	
	private boolean esBoton(String path)
	{
		if(path.equals(styShet) || path.equals(styShe2))
		{	
			return true;
		}
		return false;
	}
	
}
