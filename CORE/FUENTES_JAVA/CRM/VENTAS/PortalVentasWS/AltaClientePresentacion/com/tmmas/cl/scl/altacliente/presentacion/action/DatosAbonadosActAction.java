package com.tmmas.cl.scl.altacliente.presentacion.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosAbonadosActForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;


public class DatosAbonadosActAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosAbonadosActAction.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	
	
	public DatosAbonadosActAction(){		
		logger.debug("AltaClienteInicioAction():Begin");
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
		logger.debug("AltaClienteInicioAction():End");
	}
	
	public ActionForward buscarAbonados(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("DatosAbonadosActAction:inicio");		
		
		DatosAbonadosActForm formulario = (DatosAbonadosActForm) form;
		logger.info("getStrNumIdentConsAbo: "+formulario.getStrNumIdentConsAbo());
		logger.info("getStrTipIdentConsAbo: "+formulario.getStrTipIdentConsAbo());
		AbonadoDTO[] listaAbonados = delegate.getAbonadosActvos(formulario.getStrTipIdentConsAbo(), formulario.getStrNumIdentConsAbo());
		request.getSession().setAttribute("listaAbonados", listaAbonados);	
		

		logger.info("DatosAbonadosActAction:fin");		
		return mapping.findForward("inicio");
	}
	
}
