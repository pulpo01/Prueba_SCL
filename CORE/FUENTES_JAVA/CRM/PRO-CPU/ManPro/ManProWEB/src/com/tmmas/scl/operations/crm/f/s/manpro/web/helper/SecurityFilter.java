package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

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

import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;

public class SecurityFilter implements Filter {

	private String errorPage1 = "error1.jsp";//"WebContent/error.jsp";

	private String loginAction = "/LoginAction.do";
	String buscaCliente = "/pages/BuscaCliente.jsp";
	String ventaAction = "/Contratar.do";
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
		if (path.equals(errorPage) || path.equals(loginAction) || path.equals(buscaCliente)|| path.equals(ventaAction) || esBoton(path)) {// 
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
				VentaDTO sessionData = (VentaDTO) session.getAttribute("VentaDTO");
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
	String btSalir = "/botones/btn_salir.gif";             /*sessionTimeout*/
	String btSali2 = "/botones/btn_salir_roll.gif";        /*sessionTimeout*/

	String btAcept = "/img/botones/btn_aceptar_roll.gif";  //JClienAfinesDWR,NumerosFrecAJAX
	String btBuscr = "/img/botones/btn_buscar_roll.gif";
	String btContr = "/img/botones/btn_contratar_roll.gif";
	String btElimr = "/img/botones/btn_eliminar_roll.gif";
	String btFinlz = "/img/botones/btn_finalizar_roll.gif";//JCargosDWR
	String btGrabr = "/img/botones/btn_grabar_roll.gif";
	String btIngsr = "/img/botones/btn_ingresar_roll.gif";
	String btSali3 = "/img/botones/btn_salir_roll.gif";
	String btAcep2 = "/botones/btn_aceptar_roll.gif";
	String btAgrgr = "/botones/btn_agregar_roll.gif";     //NumerosFrecAJAX
	//String btFrect = "/botones/btn_salir_roll.gif";
	String btSigte = "/botones/btn_siguiente_roll.gif";

	
	private boolean esBoton(String path)
	{
		if(
			   path.equals(styShet) || path.equals(btSalir) ||
			   path.equals(btSali2) || path.equals(btAcept) ||
			   path.equals(btBuscr) || path.equals(btContr) ||
			   path.equals(btElimr) || path.equals(btFinlz) ||
			   path.equals(btGrabr) || path.equals(btIngsr) ||
			   path.equals(btSali3) || path.equals(btAcep2) ||
			   path.equals(btAgrgr) || path.equals(btSigte)
			   
		)
		{	
			return true;
		}
		return false;
	}
}
