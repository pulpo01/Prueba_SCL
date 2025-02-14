/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.config.servlet.base;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public abstract class ConfigBaseServlet extends HttpServlet
{
	private static Logger logger = Logger.getLogger(ConfigBaseServlet.class);
	
	private static final String CLAVE_CONFIGURACION_LOG = "ConsultaSACWEB.archivo.config.log4j";

	private static final String PROPERTIES_EXTERNO = "ConsultaSACWEB.properties";
	
	protected static final String RUTA_ARCHIVOS = "/com/tmmas/cl/scl/propiedadesGeneral";

	private static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/ConsultaSACWEB.properties";

	protected static CompositeConfiguration config = UtilProperty.getConfiguration(PROPERTIES_EXTERNO,
			PROPERTIES_INTERNO);

	protected static String COD_ERROR = config.getString("COD.ERR_SAC.5000");

	protected static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	protected static final String CONTENT_TYPE = "text/xml;charset=UTF-8";

	protected static String DES_ERROR = config.getString("DES.ERR_SAC.5000");

	private static final String DIRECTORIO_EJECUCION = System.getProperty("user.dir");

	protected static final String MENSAJE_FIN_LOG = "Fin";

	protected static final String MENSAJE_INICIO_LOG = "Inicio";

	public ConfigBaseServlet()
	{
		super();
	}

	protected void muestraArchivo(HttpServletResponse response, String rutaArchivo) throws IOException
	{
		response.setContentType(CONTENT_TYPE);
		ServletOutputStream out = response.getOutputStream();
		FileInputStream fileInputStream = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			logger.debug("Directorio de Ejecucion [" + DIRECTORIO_EJECUCION + "]");
			fileInputStream = new FileInputStream(DIRECTORIO_EJECUCION + rutaArchivo);
			InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream);
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String linea;
			while ((linea = bufferedReader.readLine()) != null)
			{
				out.println(linea);
			}
		}
		finally
		{
			fileInputStream.close();
			out.close();
		}
		logger.info(MENSAJE_FIN_LOG);
	}

	protected PortalSACException procesarExcepcion(Exception e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				COD_ERROR, DES_ERROR, e);
		return pe;
	}
}