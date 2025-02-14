/**
 * Copyright © 2005 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25/08/2006     Jimmy Lopez              		Versión Inicial
 */


package com.tmmas.cl.scl.pv.customerorder.web.requestprocessor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Category;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.RequestProcessor;

public class RequestProcessorCustomOrder extends RequestProcessor {
	private final Category cat = Category
			.getInstance(RequestProcessorCustomOrder.class);
	
	protected ActionForward processActionPerform(HttpServletRequest request,HttpServletResponse response, Action action, ActionForm form,
			ActionMapping mapping) throws IOException, ServletException 
	{
		cat.debug("processActionPerform():start");
		cat.debug("processActionPerform():end");
		return super.processActionPerform(request, response, action, form,	mapping);
	}
}
