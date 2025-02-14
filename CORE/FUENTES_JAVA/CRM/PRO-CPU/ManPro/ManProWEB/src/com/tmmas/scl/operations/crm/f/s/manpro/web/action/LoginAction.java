package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ForwardOS;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.Global;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductosContradosFrecUtil;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.SecurityHandler;

public class LoginAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(LoginAction.class);
	private Global global = Global.getInstance();
	
	protected ActionForward executeAction(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("executeAction():start");

		HttpSession session = request.getSession(false);
		if (session != null) {
            logger.debug("Session existente en pagina de login");
            logger.debug("Invalidando session existente");
			session.removeAttribute("ClienteOOSS");
			//session.invalidate();
		}
		
	   // *********************DATOS DUMMY DE PRUEBA*********************************
		/*Long cliente = new Long(2699486);
		Long abonado = new Long(0);
		String codOS = "40006"; //codigo orden de servicio ej. 40006, 40007, 40008
		Long numOS = new Long(1234); //no va
		String usua = "COL_06011"; //usuario oracle
		String clav = "CLAVE";
		log2("userName--------------------->usua "+usua);
		request.setAttribute("usuario", usua);
		request.setAttribute("clave", clav);
		request.setAttribute("codCliente", cliente);
		request.setAttribute("numAbonado", abonado);
		request.setAttribute("codOrdenServicio", codOS);
		//request.setAttribute("numOrdenServicio", numOS);*/

		logger.debug("Creando session...");
		session = request.getSession(true);
		

		SecurityHandler seguridad = new SecurityHandler();
		ClienteOSSesionDTO sessionData = null;
		
		logger.debug("Invocando proceso de validacion de seguridad antes...");
		try
		{
			sessionData = seguridad.validarSeguridad(request, response);
			logger.debug("Invocando proceso de validacion de seguridad despues...");
			
			logger.debug("Creando session...");
			session = request.getSession(true);
			session.setAttribute("ClienteOOSS", sessionData);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		//Object 
		ProductoContratadoFrecDTO [] productoContratadoFrecList = (ProductoContratadoFrecDTO [])session.getAttribute("ProductoContratadoFrecList");
		log2("-----------------------------------------------------------------------------------------------------------------------------------");
		if(productoContratadoFrecList == null)
		{
			log2("productoContratadoFrecList ======= null");
			ProductosContradosFrecUtil pcfU = new ProductosContradosFrecUtil();
			session.setAttribute("ProductoContratadoFrecList", pcfU.generaProductoContratadoList());//generaProductoContratadoList());	
		}
		else
		{
			log2("productoContratadoFrecList != null");
		}
		
		
					
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 2);
	    logger.debug("forward : "+forward); 
		logger.debug("executeAction():end");
		return mapping.findForward(forward);
	}
	public void log2(Object o)
	{
		
	}
}
