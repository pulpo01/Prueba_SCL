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

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.consultas.servlet.base.ConsultasBaseServlet;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;

public class AbonadosXCodCliente extends ConsultasBaseServlet implements javax.servlet.Servlet
{

	private static final String NOMBRE_PARAMETRO = "codCliente";

	private static final long serialVersionUID = 4414170783591415469L;

	private static Logger logger = Logger.getLogger(AbonadosXCodCliente.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public AbonadosXCodCliente()
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
		ListadoAbonadosDTO r = null;
		response.setContentType(CONTENT_TYPE_DEL_RESPONSE);
		ServletOutputStream out = response.getOutputStream();

		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);

			boolean existe = existeParametro(request.getParameterNames(), NOMBRE_PARAMETRO);
			if (!existe)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.5005"),
						config.getString("DES.ERR_SAC.5005"), 0);
			}

			WSPortalSrv srv = new WSPortalSrv();
			Long codCliente = new Long(request.getParameter(NOMBRE_PARAMETRO));
			logger.debug(NOMBRE_PARAMETRO + " [" + codCliente + "]");
			r = srv.abonadosXCodCliente(codCliente);

			if (r.getArrayAbonados().length == 0)
			{
				throw new PortalSACException(r.getCodError(), r.getDesError(), 0);
			}

			StringBuffer b = new StringBuffer();
			b.append("<abonados>");
			AbonadoDTO dto = null;
			for (int i = 0; i < r.getArrayAbonados().length; i++)
			{
				dto = (AbonadoDTO) r.getArrayAbonados()[i];
				b.append(dto.toXml());
			}
			b.append("</abonados>");
			out.print(XML_HEADER);
			out.print(b.toString());
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
