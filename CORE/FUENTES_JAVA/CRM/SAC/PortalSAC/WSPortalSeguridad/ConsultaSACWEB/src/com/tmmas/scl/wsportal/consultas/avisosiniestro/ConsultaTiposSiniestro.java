package com.tmmas.scl.wsportal.consultas.avisosiniestro;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSiniestroDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;

/**
 * Servlet implementation class for Servlet: ConsultaTiposSiniestro
 * 
 */
public class ConsultaTiposSiniestro extends com.tmmas.scl.wsportal.consultas.servlet.base.ConsultasBaseServlet
		implements javax.servlet.Servlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7940529556935742725L;

	private static Logger logger = Logger.getLogger(ConsultaTiposSiniestro.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ConsultaTiposSiniestro()
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
		ListadoTiposSiniestroDTO r = null;

		ServletOutputStream out = response.getOutputStream();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);

			logger.debug("request.setCharacterEncoding(" + CHARSET_DEL_REQUEST + ")");
			request.setCharacterEncoding(CHARSET_DEL_REQUEST);
			logger.debug("response.setContentType(" + CONTENT_TYPE_DEL_RESPONSE + ")");
			response.setContentType(CONTENT_TYPE_DEL_RESPONSE);

			WSPortalSrv srv = new WSPortalSrv();
			r = srv.consultaTiposSiniestro();

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