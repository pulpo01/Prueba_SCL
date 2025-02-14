/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.consultas.servlet.base;

import java.util.Enumeration;

import javax.servlet.http.HttpServlet;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public abstract class ConsultasBaseServlet extends HttpServlet
{
	private static Logger logger = Logger.getLogger(ConsultasBaseServlet.class);

	protected PortalSACException procesarExcepcion(Exception e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				COD_ERROR, DES_ERROR, e);
		return pe;
	}

	protected boolean existeParametro(Enumeration parameters, String nombreParametro)
	{
		logger.info(INICIO_LOG);
		boolean r = false;
		while (parameters.hasMoreElements())
		{
			Object o = parameters.nextElement();
			if (o.toString().equals(nombreParametro))
			{
				r = true;
			}
		}
		logger.debug("Valor de retorno [" + r + "]");
		logger.info(FIN_LOG);
		return r;
	}

	private static final String CLAVE_CONFIGURACION_LOG = "ConsultaSACWEB.archivo.config.log4j";

	protected static final String XML_HEADER = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

	protected static final String CONTENT_TYPE_DEL_RESPONSE = "text/xml;charset=UTF-8";
	
	protected static final String CHARSET_DEL_REQUEST = "UTF-8";

	protected static final String PROPERTIES_EXTERNO = "ConsultaSACWEB.properties";

	protected static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/ConsultaSACWEB.properties";

	protected static CompositeConfiguration config = UtilProperty.getConfiguration(PROPERTIES_EXTERNO,
			PROPERTIES_INTERNO);

	protected static String COD_ERROR = config.getString("COD.ERR_SAC.5000");

	protected static String DES_ERROR = config.getString("DES.ERR_SAC.5000");

	public ConsultasBaseServlet()
	{
		super();
	}

	protected static final String INICIO_LOG = "Inicio";

	protected static final String FIN_LOG = "Fin";

	protected static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

}