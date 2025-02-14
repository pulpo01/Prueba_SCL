package com.tmmas.scl.wsportal.consultas.servlet;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.dto.ListadoProvinciasDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;

/**
 * Servlet implementation class for Servlet: ConsultaProvincias
 * 
 */
public class ConsultaProvincias extends com.tmmas.scl.wsportal.consultas.servlet.base.ConsultasBaseServlet implements
		javax.servlet.Servlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3742123976278297037L;

	private static Logger logger = Logger.getLogger(ConsultaProvincias.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ConsultaProvincias()
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
		ListadoProvinciasDTO r = null;

		ServletOutputStream out = response.getOutputStream();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);

			logger.debug("request.setCharacterEncoding(" + CHARSET_DEL_REQUEST + ")");
			request.setCharacterEncoding(CHARSET_DEL_REQUEST);
			logger.debug("response.setContentType(" + CONTENT_TYPE_DEL_RESPONSE + ")");
			response.setContentType(CONTENT_TYPE_DEL_RESPONSE);

			boolean existe = existeParametro(request.getParameterNames(), "codRegion");
			if (!existe)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.5009"),
						config.getString("DES.ERR_SAC.5009"), 0);
			}
			String codRegion = request.getParameter("codRegion");
			logger.debug("codRegion recibido [" + codRegion + "]");
			codRegion = URLDecoder.decode(codRegion, "UTF-8");
			logger.debug("codRegion decodificado UTF-8 [" + codRegion + "]");

			WSPortalSrv srv = new WSPortalSrv();
			r = srv.obtenerProvincias(codRegion);
			
			if (r.getCodError() != null)
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

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request,
	 *      HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException
	{
		doGet(request, response);
	}
}