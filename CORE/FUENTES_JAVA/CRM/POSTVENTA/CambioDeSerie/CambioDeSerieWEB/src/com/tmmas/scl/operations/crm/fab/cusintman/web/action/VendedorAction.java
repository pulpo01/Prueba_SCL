package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.VendedorForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;

public class VendedorAction extends Action {

	private final Logger logger = Logger.getLogger(VendedorAction.class);

	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();

	/* forward name="success" path="/pages/welcome.jsp" */
	private final static String SUCCESS = "success";

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();	
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);

		logger.debug("execute():start");
		
		VendedorForm forma = (VendedorForm)form;
		String codigoVendedor = forma.getCodVendedor();
		String ind_interno = forma.getInd_interno();
		
		logger.debug("codigoVendedor[" + codigoVendedor + "]");
		logger.debug("ind_interno[" + ind_interno + "]");
		
		VendedorDTO dto = new VendedorDTO();
		dto.setCod_vendedor(codigoVendedor);		
		if (ind_interno.equalsIgnoreCase("1")) {
			dto.setInd_interno(true);
		}
		else {
			dto.setInd_interno(false);
		}
		

		VendedorDTO resultado = null;
		ActionMessages messages = new ActionMessages( );

		request.setAttribute("flagVendedor", "NO");
		try {
			logger.debug("recuperarInformacionVendedor():antes");
			resultado = delegate.recuperarInformacionVendedor(dto);
			request.setAttribute("flagVendedor", "SI");
			logger.debug("recuperarInformacionVendedor():despues");			
		} catch (Exception e) {
			 logger.debug("Exception", e);
			 logger.debug("Removiendo vendedor de la session...");
			 session.removeAttribute("Vendedor");
			 if (e.getCause()!= null ) {
				 logger.debug("Causa error["+ e.getCause().getClass().getName()+ "]");
				 if (e instanceof VendedorException) {
					 VendedorException ex = (VendedorException) e.getCause();
					 logger.debug("Instancia de VendedorException");
					 logger.debug("descripcionEvento[" + ex.getDescripcionEvento() + "]");
					 ActionMessage msg = new ActionMessage(ex.getDescripcionEvento(), false);
					 messages.add(ActionMessages.GLOBAL_MESSAGE , msg);
				 }
				 else {
					 logger.debug("No es instancia de VendedorException");
					 messages.add(ActionMessages.GLOBAL_MESSAGE ,new ActionMessage("error.vendedor"));
				 }				 
			 }
			 else {
				 logger.debug("No es instancia de VendedorException");
				 messages.add(ActionMessages.GLOBAL_MESSAGE ,new ActionMessage("error.vendedor"));				 
			 }

             logger.debug("saveMessages antes");
             if (!messages.isEmpty( )) {
                 saveMessages( request, messages );
             }
             logger.debug("saveMessages");
             return mapping.getInputForward();
		}

		
		logger.debug("getCod_vendedor()[" + resultado.getCod_vendedor() + "]");
		logger.debug("getNom_vendedor()[" + resultado.getNom_vendedor() + "]");	
		logger.debug("getCod_vendealer()[" + resultado.getCod_vendealer() + "]");
		logger.debug("getNom_vendealer()[" + resultado.getNom_vendealer() + "]");				
		logger.debug("isInd_interno()[" + resultado.isInd_interno() + "]");				
		
		logger.debug("getCod_oficina()[" + resultado.getCod_oficina() + "]");
		logger.debug("getNom_oficina()[" + resultado.getNom_oficina() + "]");
		logger.debug("getCod_tipcomis()[" + resultado.getCod_tipcomis() + "]");	
		logger.debug("getNom_tipcomis()[" + resultado.getNom_tipcomis() + "]");
		
		logger.debug("getNumOOSS()[" + resultado.getNumOOSS() + "]");	
		logger.debug("getUsuario()[" + resultado.getUsuario() + "]");
		logger.debug("getFecha()[" + resultado.getFecha() + "]");
		logger.debug("getCod_os()[" + resultado.getCod_os() + "]");
		logger.debug("getSub_tipo()[" + resultado.getSub_tipo() + "]");		
		
		logger.debug("getCod_region()[" + resultado.getCod_region() + "]");	
		logger.debug("getDes_region()[" + resultado.getDes_region() + "]");
		logger.debug("getCod_provincia()[" + resultado.getCod_provincia() + "]");
		logger.debug("getDes_provincia()[" + resultado.getDes_provincia() + "]");
		logger.debug("getCod_ciudad()[" + resultado.getCod_ciudad() + "]");					
		logger.debug("getDes_ciudad()[" + resultado.getDes_ciudad() + "]");		
		

		ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		logger.debug("Seteando datos faltantes del vendedor...");
		logger.debug("getCodOrdenServicio()[" + sessionData.getCodOrdenServicio() + "]");		
		resultado.setCod_os(String.valueOf(sessionData.getCodOrdenServicio()));
		
		logger.debug("getNumOrdenServicio()[" + sessionData.getNumOrdenServicio() + "]");		
		resultado.setNumOOSS(String.valueOf(sessionData.getNumOrdenServicio()));
		
		logger.debug("getUsuario()[" + sessionData.getUsuario() + "]");		
		resultado.setUsuario(String.valueOf(sessionData.getUsuario()));		
		
		resultado.setFecha(Calendar.getInstance().getTime());
		logger.debug("getSub_tipo()[" + resultado.getSub_tipo() + "]");	
		
		session.setAttribute("Vendedor", resultado);
		logger.debug("execute():end");
		return mapping.findForward(SUCCESS);
	}
}
