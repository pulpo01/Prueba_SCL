package com.tmmas.scl.wsportal.consultas.servlet;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.dto.ListadoComunasDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;

/**
 * Servlet implementation class for Servlet: ConsultaComunas
 * 
 */
public class ConsultaComunas extends com.tmmas.scl.wsportal.consultas.servlet.base.ConsultasBaseServlet implements
		javax.servlet.Servlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6907270184281577762L;

	private static Logger logger = Logger.getLogger(ConsultaComunas.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ConsultaComunas()
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
		ListadoComunasDTO r = null;

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

			existe = existeParametro(request.getParameterNames(), "codProvincia");
			if (!existe)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.5010"),
						config.getString("DES.ERR_SAC.5010"), 0);
			}
			String codProvincia = request.getParameter("codProvincia");
			logger.debug("codProvincia recibido [" + codProvincia + "]");
			codProvincia = URLDecoder.decode(codProvincia, "UTF-8");
			logger.debug("codProvincia decodificado UTF-8 [" + codProvincia + "]");

			existe = existeParametro(request.getParameterNames(), "codCiudad");
			if (!existe)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.5011"),
						config.getString("DES.ERR_SAC.5011"), 0);
			}
			String codCiudad = request.getParameter("codCiudad");
			logger.debug("codCiudad recibido [" + codCiudad + "]");
			codCiudad = URLDecoder.decode(codCiudad, "UTF-8");
			logger.debug("codCiudad decodificado UTF-8 [" + codCiudad + "]");

			WSPortalSrv srv = new WSPortalSrv();
			r = srv.obtenerComunas(codRegion, codProvincia, codCiudad);
			
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