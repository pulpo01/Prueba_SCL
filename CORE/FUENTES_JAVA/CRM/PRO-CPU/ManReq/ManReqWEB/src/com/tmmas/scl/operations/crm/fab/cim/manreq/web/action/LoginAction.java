package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StrUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ForwardOS;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.SecurityHandler;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;

public class LoginAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(LoginAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	protected ActionForward executeAction(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("---- LoginAction  ----");
		logger.debug("executeAction():start");
		
		RetornoDTO retornoDTO=new RetornoDTO();
		retornoDTO.setCodigo("0");		
		String fwdError = null;		

		HttpSession session = request.getSession(false);
		if (session != null) {
            logger.debug("Session existente en pagina de login. Invalidando session existente");            
			session.removeAttribute("ClienteOOSS");
			session.invalidate();
		}
		
	   // *********************DATOS DUMMY DE PRUEBA*********************************
		/*
		Long cliente = new Long(2699486);
		Long abonado = new Long(0);
		String codOS = "40006"; //codigo orden de servicio ej. 40006, 40007, 40008
		Long numOS = new Long(1234); //no va
		String usua = "COL_06011"; //usuario oracle
		String clav = "CLAVE";
			
		request.setAttribute("codCliente", cliente);
		request.setAttribute("numAbonado", abonado);
		request.setAttribute("codOrdenServicio", codOS);
		request.setAttribute("numOrdenServicio", numOS);
		request.setAttribute("usuario", usua);
		request.setAttribute("clave", clav); */ 
		// *******************************************************
		
		logger.debug("Creando session...");
		 logger.debug("--------ManageRequestWEBEAR.ear CREADO 11/06/2010 11:39 : PV--------");

		session = request.getSession(true);
		
		SecurityHandler seguridad = new SecurityHandler();
		ClienteOSSesionDTO sessionData = null;
		
				
		try {			
			logger.debug("Se llama al metodo SecurityHandler.validarSeguridad(request, response)");
			sessionData = seguridad.validarSeguridad(request, response);
		} catch (ManReqException e){			
	    	session.setAttribute("error", e.getDescripcionEvento());
	    	fwdError = "ValidacionAbonado";
			logger.error(e.getDescripcionEvento(), e);			
		} catch (Exception e) {			
			retornoDTO.setCodigo("No hay código para esta excepción");
			retornoDTO.setDescripcion(e.getMessage());
			retornoDTO.setResultado(true);			
			if (e instanceof ManReqException) {				
				ManReqException me =(ManReqException)e.getCause();		
				if (me!=null && me.getCodigo()!=null && !(me.getCodigo().equals(""))){
					retornoDTO.setCodigo(me.getCodigo());
					retornoDTO.setDescripcion(me.getDescripcionEvento());
					retornoDTO.setResultado(true);		
				} 
			}		
	    	String mensajeError = retornoDTO.getDescripcion();
	    	session.setAttribute("error", mensajeError);
	    	fwdError="ValidacionAbonado";	
			logger.error(e.getMessage(), e);
		}
		if(sessionData == null)
		{
			sessionData = new ClienteOSSesionDTO();
		}	
		// INI AVC; 05-12-2008
		// Se obtiene el nombre de la OOSS a ejecutar dejandola en la sesion, para pintarla en la pagina.
		    
		   //String codOrdenServicio = StrUtl.isNullCero(request.getParameter("codOrdenServicio"));
		   String codOrdenServicio = String.valueOf(sessionData.getCodOrdenServicio()); //ini p-mix-09003 ocb
		
		    String NombreOss = global.getValor(codOrdenServicio+".name");
		    logger.debug("Nombre OOSS:" + NombreOss);
		    
		    String version = global.getValor("version.manreq");
		    logger.debug("Version:" + version);
		    
		    session.setAttribute("NombreOss", NombreOss);
			session.setAttribute("Version", version);
		// FIN AVC; 05-12-2008
		
		if (fwdError!=null){
			//(+) EV 12/08/08
			//codOrdenServicio = StrUtl.isNullCero(request.getParameter("codOrdenServicio"));
			codOrdenServicio = String.valueOf(sessionData.getCodOrdenServicio());//ini p-mix-09003 ocb
			
			NombreOss = global.getValor(codOrdenServicio+".name");
			
			logger.debug("Nombre OOSS (Dentro del If):" + NombreOss);
			if(NombreOss == null) NombreOss = "CPU";
			ClienteOSSesionDTO sessionDataAux = new ClienteOSSesionDTO();
			sessionDataAux.setNombOss(NombreOss);
			session.setAttribute("ClienteOOSS", sessionDataAux);
			//(-)
			logger.debug("Ocurrio un error en el metodo validarSeguridad(request, response). Se hace Forward a :" + fwdError);
			return mapping.findForward(fwdError);
		}
		
		logger.debug("Invocando proceso de validacion de seguridad despues...");
		
		//(+)02/06/10 Parametro que indica si se habilita precalificacion de prepagos
		try {
			ParametroDTO param = new ParametroDTO();
			param.setCodModulo(global.getValor("codigo.modulo.GA"));
			param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
			param.setNomParametro(global.getValor("parametro.aplica.precalificado"));
			ParametroDTO paramGral = delegate.obtenerParametroGeneral(param);
			logger.debug("APLICA_PRECALIFICACION="+paramGral.getValor());
			sessionData.setAplicaPrecalificacion(paramGral.getValor());
		} catch (Exception e) {
			logger.debug("Error al obtener parametro APLICA_PRECALIFICA");
			sessionData.setAplicaPrecalificacion("N");
			e.printStackTrace();
		}
		//(-)02/06/10 Parametro que indica si se habilita precalificacion de prepagos
		
		session.setAttribute("ClienteOOSS", sessionData);

		String forward = ForwardOS.forwardOS(sessionData.getForward(), 1);
	    logger.debug("forward : " + forward); 
		logger.debug("executeAction():end");
				
		return mapping.findForward(forward);
	}

}
