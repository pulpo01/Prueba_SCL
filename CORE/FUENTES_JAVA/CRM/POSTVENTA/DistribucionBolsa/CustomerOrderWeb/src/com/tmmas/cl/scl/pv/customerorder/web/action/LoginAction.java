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
package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;
import com.tmmas.cl.scl.pv.customerorder.web.helper.SecurityHandler;

import org.apache.log4j.Category;
import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.*;
	

public class LoginAction extends BaseAction {
	private Category logger = Category.getInstance(LoginAction.class);
	
	private CompositeConfiguration config;
	
	
	protected ActionForward executeAction(ActionMapping mapping,ActionForm form, HttpServletRequest request,HttpServletResponse response) 
		throws Exception 
	{
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio ActionForward");
		// fin MA

		HttpSession session = request.getSession(false);
		if (session != null) {
			logger.debug("Session existente en pagina de login");
			logger.debug("Invalidando session existente");
			session.removeAttribute("CustomerOrder");
			session.invalidate();
		}

		SecurityHandler seguridad = new SecurityHandler();
		CustomerOrderSessionDTO sessionData = null;
		
		logger.debug("Invocando proceso de validacion de seguridad antes...");
		sessionData = seguridad.validarSeguridad(request, response);
		logger.debug("Invocando proceso de validacion de seguridad despues...");

		logger.debug("Creando session...");
		logger.debug("--------CustomerOrderWebEAR.ear CREADO 07/01/2010 15:20 : PV--------");
		session = request.getSession(true);
		session.setAttribute("CustomerOrder", sessionData);

		logger.debug("Codigo de cliente[" + sessionData.getCode()+ "]");
		logger.debug("nombre           [" + sessionData.getNames()+ "]");
		logger.debug("plan tarifario   [" + sessionData.getCodePlanRate()+ "]");
		logger.debug("numero de orden  [" + sessionData.getNumeroOrdenServicio()+ "]");
		
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 1);
		logger.debug("forward          [" + forward + "]");
		logger.debug("executeAction():end");
		return mapping.findForward(forward);
	}

}
