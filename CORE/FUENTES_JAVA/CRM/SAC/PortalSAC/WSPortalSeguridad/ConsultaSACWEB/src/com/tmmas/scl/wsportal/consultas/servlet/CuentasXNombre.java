/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.consultas.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rsa.certj.provider.pki.URLDecoder;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;

public class CuentasXNombre extends com.tmmas.scl.wsportal.consultas.servlet.base.ConsultasBaseServlet implements
		javax.servlet.Servlet
{
	private static final long serialVersionUID = 6458243402571508131L;

	private static Logger logger = Logger.getLogger(CuentasXNombre.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public CuentasXNombre()
	{
		super();
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request,
	 *      HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		ListadoCuentasDTO r = null;

		ServletOutputStream out = response.getOutputStream();
		try
		{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			
			logger.debug("request.setCharacterEncoding(" + CHARSET_DEL_REQUEST + ")");
			request.setCharacterEncoding(CHARSET_DEL_REQUEST);
			logger.debug("response.setContentType(" + CONTENT_TYPE_DEL_RESPONSE + ")");
			response.setContentType(CONTENT_TYPE_DEL_RESPONSE);
			
			boolean existe = existeParametro(request.getParameterNames(), "descCuenta");
			if (!existe)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.5001"),
						config.getString("DES.ERR_SAC.5001"), 0);
			}

			WSPortalSrv srv = new WSPortalSrv();
			String descCuenta = request.getParameter("descCuenta");
			logger.debug("descCuenta recibido [" + descCuenta + "]");
			descCuenta = URLDecoder.decode(descCuenta);
			logger.debug("descCuenta decodificado UTF-8 [" + descCuenta + "]");
			descCuenta = descCuenta.toUpperCase();
			logger.debug("descCuenta.toUpperCase() [" + descCuenta + "]");
			r = srv.cuentasXNombre(descCuenta);
			if (r.getArrayCuentas().length == 0)
			{
				throw new PortalSACException(r.getCodError(), r.getDesError(), 0);
			}
			out.print(XML_HEADER);
			out.print(r.toXml());
			logger.info(FIN_LOG);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			out.print(XML_HEADER);
			out.print(pe.toXml());
		}
		finally
		{
			out.close();
		}

	}
}