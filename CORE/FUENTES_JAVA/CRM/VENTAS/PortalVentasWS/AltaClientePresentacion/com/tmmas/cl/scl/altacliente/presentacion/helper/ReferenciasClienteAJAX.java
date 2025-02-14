package com.tmmas.cl.scl.altacliente.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class ReferenciasClienteAJAX {

	private static final String SESION_EXPIRADA = "Su sesión ha expirado";

	private final Logger logger = Logger.getLogger(ReferenciasClienteAJAX.class);

	public RetornoValidacionAjaxDTO validarTelefonoReferencia(String telefono, String tipo) {
		logger.info("validarTelefonoReferencia, inicio");
		logger.debug("telefono: " + telefono);
		logger.debug("tipo: " + tipo);
		RetornoValidacionAjaxDTO r = new RetornoValidacionAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError(SESION_EXPIRADA);
			logger.error(r.getMsgError());
			return r;
		}
		AltaClienteDelegate d = AltaClienteDelegate.getInstance();
		boolean valido = false;
		try {
			valido = d.validarTelefonoReferencia(telefono, tipo);
		}
		catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error(e.getClass().getName() + ": " + log);
		}
		r.setValido(valido);
		logger.info("validarTelefonoReferencia [" + valido + "] , fin");
		return r;
	}

	private boolean validarSesion(HttpSession sesion) {
		if (sesion == null) {
			return false;
		}
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		if (sessionData == null) {
			return false;
		}
		return true;
	}

}
