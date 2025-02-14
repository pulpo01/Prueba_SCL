/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.config.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.config.servlet.base.ConfigBaseServlet;

public class PortalSACConfig extends ConfigBaseServlet implements javax.servlet.Servlet
{
	private static Logger logger = Logger.getLogger(PortalSACConfig.class);

	private static final long serialVersionUID = -4067068653801898206L;

	private static String RUTA_NOMBRE_ARCHIVO = RUTA_ARCHIVOS + "/PortalSAC.config.xml";

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request,
	 *      HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			logger.debug("Archivo de configuración a mostrar [" + RUTA_NOMBRE_ARCHIVO + "]");
			muestraArchivo(response, RUTA_NOMBRE_ARCHIVO);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
		}
		logger.info(MENSAJE_FIN_LOG);
	}

}
