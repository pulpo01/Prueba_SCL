package com.tmmas.scl.operations.crm.fab.cim.manreq.web.filter;

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

import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;

public class SecurityFilter implements Filter {

	private String errorPage1 = "error1.jsp";//"WebContent/error.jsp";

	private String loginAction = "/LoginAction.do";
	//private String errorAction = "/ErrorAction.do";
	//private final Category cat = Category.getInstance(SecurityFilter.class);
	private final Logger cat = Logger.getLogger(SecurityFilter.class);
	public void destroy() {
		cat.debug("destroy():start");
		cat.debug("destroy():end");
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		String errorPage = "/sessionTimeOut.jsp";
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		
		// El recurso llamado es la pagina de error o el login o acciones provocados por los tag src o dwr. 
		// Debo dejar procesarla
		String path = request.getServletPath();
		if (path.equals(errorPage) || path.equals(loginAction) || esBoton(path)) {
			lc("Entrando por pagina sessionTimeOut o loginAction [" + path + "]");
			chain.doFilter(request, response);
			return;
		}
		else {
			lc("Sirviendo otro recurso distinto de login action y pagina de error [" + path + "]");
			boolean isSessionInvalida = request.isRequestedSessionIdValid();
			HttpSession session = request.getSession(false);
			if (session == null) {
				lc("\tNo existe sesion.");
				String pagina = errorPage;
				lc("\t(session=null)Redireccionando a pagina de error[" + pagina + "]");
				request.getRequestDispatcher(pagina).forward(request, response );
			} else {
				lc("\tSession existente");
				ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
				if (sessionData == null) {
					String pagina = errorPage;
					lc("\t(sessionData=null)Redireccionando a pagina de error[" + pagina + "]");
					request.getRequestDispatcher(pagina).forward(request, response );
				}else
				{
					lc("\tFiltrando el request...");
					chain.doFilter(request, response);
					lc("\tFiltrando la respuesta...");
				}
			}
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		lc("init()SecurityFilter:start");
		cat.debug("init()SecurityFilter:start");
		//this.errorPage = filterConfig.getInitParameter("errorPage");
		cat.debug("init()SecurityFilter:end");
		lc("init()SecurityFilter:start");
	}
	
	public void lc(String s)
	{
		cat.debug(s);
	}
	
	String styShet = "/css/mas.css";
	String styShe2 = "/cpu/css/mas.css";
	String styShe3 = "/anulaSolicitud/css/mas.css";
	
	String btSalir = "/botones/btn_salir.gif";/*sessionTimeout*/
	String btSali2 = "/botones/btn_salir_roll.gif";
	
	String btSali5 = "/anulaSolicitud/botones/btn_salir.gif";
	String btSali6 = "/anulaSolicitud/botones/btn_salir_roll.gif";
	String btAnte1= "/anulaSolicitud/botones/btn_anterior.gif";
	String btAnte2 = "/anulaSolicitud/botones/btn_anterior_roll.gif";
	String btFinl1 = "/anulaSolicitud/botones/btn_finalizar.gif";
	String btFinl2 = "/anulaSolicitud/botones/btn_finalizar_roll.gif";
	
	String btSigte =  "/botones/btn_siguiente.gif";
	String btSigte1 = "/botones/btn_siguiente_roll.gif";/*cpu*/
	
	String btSali3 = "/cpu/botones/btn_salir.gif";/*sessionTimeout*/
	String btFinlz = "/cpu/botones/btn_finalizar.gif";
	String btFinlz1 = "/cpu/botones/btn_finalizar_roll.gif";
	String btFrect = "/botones/btn_listafrecuentes.gif";
	String btFrect1 = "/botones/btn_listafrecuentes_roll.gif";
	String btImpCt = "/cpu/botones/btn_imprimircarta.gif";
	String btImpCt1 = "/cpu/botones/btn_imprimircarta_roll.gif";
	String btAntes = "/cpu/botones/btn_anterior.gif";
	String btAntes1 = "/cpu/botones/btn_anterior_roll.gif";
	String btSigt1 = "/cpu/botones/btn_siguiente.gif";
	String btSigt2 = "/cpu/botones/btn_siguiente_roll.gif";
	String btSali4 = "/cpu/botones/btn_salir.gif";
	String btSali7 = "/cpu/botones/btn_salir_roll.gif";
	
	
	
	private boolean esBoton(String path)
	{
		if(
			   path.equals(styShet) || path.equals(styShe2) ||
			   path.equals(styShe3) || path.equals(btSalir) ||
			   path.equals(btSali2) || path.equals(btSali5) ||
			   path.equals(btSali6) || path.equals(btSigte) ||
			   path.equals(btSali3) || path.equals(btFinlz) ||
			   path.equals(btImpCt) || path.equals(btAntes) ||
			   path.equals(btSigt2) || path.equals(btSali4) ||
			   path.equals(btAnte2) || path.equals(btFinl2) ||
			   path.equals(btFrect) || path.equals(btAnte1) ||
			   path.equals(btFinl1) || path.equals(btSigte1) ||
			   path.equals(btFinlz1) || path.equals(btFrect1) ||
			   path.equals(btImpCt1) || path.equals(btAntes1) ||
			   path.equals(btSigt1) || path.equals(btSali7) 
			   
		)
		{	
			return true;
		}
		return false;
	}
}
