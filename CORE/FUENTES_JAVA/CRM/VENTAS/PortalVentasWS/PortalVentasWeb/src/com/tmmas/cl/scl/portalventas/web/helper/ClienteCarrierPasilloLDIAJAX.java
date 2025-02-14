package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValidacionAjaxDTO;

public class ClienteCarrierPasilloLDIAJAX {

	private final Logger logger = Logger.getLogger(ClienteCarrierPasilloLDIAJAX.class);

	/**
	 * @author JIB
	 * @param telefono
	 * @return
	 */
	public RetornoValidacionAjaxDTO validarTelefonoLDI(String telefono) {
		logger.debug("validarTelefonoLDI, Inicio");
		logger.debug("telefono: " + telefono);
		RetornoValidacionAjaxDTO r = new RetornoValidacionAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		if (!validarSesion(sesion)) {
			logger.debug("Sesión expirada");
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}
		PortalVentasDelegate d = PortalVentasDelegate.getInstance();
		boolean valido = false;
		try {
			valido = d.validarTelefonoLDI(telefono);
		}
		catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error(e.getClass().getName() + ": " + log);
		}
		r.setValido(valido);
		logger.debug("validarTelefonoLDI, Fin");
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
