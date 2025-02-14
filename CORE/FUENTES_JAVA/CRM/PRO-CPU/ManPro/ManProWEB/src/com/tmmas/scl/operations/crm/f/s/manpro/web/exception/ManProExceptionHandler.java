/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 03/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.f.s.manpro.web.exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;

import com.tmmas.cl.framework.util.StackTraceUtl;

public class ManProExceptionHandler extends ExceptionHandler {
	private final Logger logger = Logger.getLogger(ManProExceptionHandler.class);

	public ActionForward execute(Exception e, ExceptionConfig eC, ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws ServletException {
		logger.debug("execute():start");
		logger.debug("execute():end");
		return super.execute(e, eC, mapping, form, req, resp);
	}

	/**
	 * Loguea la excepcion
	 */
	protected void logException(Exception e) {
		logger.debug("logException():start");
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("logException[" + log + "]");		
		logger.debug("logException():end");
		super.logException(e);
	}

	protected void storeException(HttpServletRequest req, String property, ActionMessage error, ActionForward forward, String scope) {
		logger.debug("storeException():start");
		logger.debug("storeException():end");
		super.storeException(req, property, error, forward, scope);
	}

}
