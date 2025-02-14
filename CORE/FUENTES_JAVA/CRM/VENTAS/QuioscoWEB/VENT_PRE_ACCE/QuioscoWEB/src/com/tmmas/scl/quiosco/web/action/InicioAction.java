package com.tmmas.scl.quiosco.web.action;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.rpc.ServiceException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;

public class InicioAction extends Action {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(this.getClass());
	CompositeConfiguration config;
	//SpnSclWSProxy proxy;
	//SpnSclWS_Stub proxy;
	
	public InicioAction() throws ServiceException{
		
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");											
		String log = config.getString("QuioscoWEB.log");
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		String target=new String();
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		//SpnSclWSProxy proxy = new SpnSclWSProxy(config.getString("ruta.webservice"));
		
		String rolUsuario = new String();
		try {
			SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
			SpnSclWS port = service.getSpnSclWSSoapPort();
			
			WsTiendaVendedorOutDTO tiendaVendedorOutDTO = new WsTiendaVendedorOutDTO();
									
			logger.error("tiendaVO.getCodTienda() : "+ (String)session.getAttribute("tienda"));
			tiendaVendedorOutDTO = port.getTiendaVendedor((String)session.getAttribute("tienda"));
						
			
			
			if(tiendaVendedorOutDTO.getCodError()!=0){
				logger.error("Error : "+ tiendaVendedorOutDTO.getMsgError());
				request.setAttribute("desError", tiendaVendedorOutDTO.getMsgError());
				target="globalErrorInesperado";
				return mapping.findForward(target);
			}
			
			session.setAttribute("tiendaVendedor", tiendaVendedorOutDTO);
			System.out.println("APLICAPAGIO:::::> "+tiendaVendedorOutDTO.getIndApliPAgo());

			if(request.isUserInRole(config.getString("rol.super.usuarios").trim()))
				rolUsuario=config.getString("rol.super.usuarios").trim();
			else if(request.isUserInRole(config.getString("rol.mantenedor.usuarios").trim()))
				rolUsuario=config.getString("rol.mantenedor.usuarios").trim();
			else if(request.isUserInRole(config.getString("rol.vendedor.usuarios").trim()))
				rolUsuario=config.getString("rol.vendedor.usuarios").trim();
			
			request.setAttribute("rolUsuario", rolUsuario);
			logger.error("Usuario: "+ request.getUserPrincipal());
			session.setAttribute("usuarioPrincipal", request.getUserPrincipal().getName());
			logger.error("Usuario Con Rol: "+ rolUsuario);
			
			target="inicio";
			
			logger.error("target ["+target+"]");
						
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error Exception[" + log + "]");
			request.setAttribute("desError","Error Inesperado.");
			target="globalErrorInesperado";
			return mapping.findForward(target);
		}catch (Throwable e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error Throwable[" + log + "]");
			request.setAttribute("desError","Error Inesperado.");
			target="globalErrorInesperado";
			return mapping.findForward(target);
		}
		return mapping.findForward(target);
	}
}
