package com.tmmas.cl.scl.portalventas.web.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;

/**
 * @author JIB
 */
public class DocDigitalizadoServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = 5049838513921143864L;

	protected Logger logger = Logger.getLogger(this.getClass());

	protected PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("doGet, inicio");
		final Long numCorrelativo = new Long(request.getParameter("numCorrelativo"));
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		try {
			DocDigitalizadoDTO dto = delegate.obtenerDocDigitalizado(numCorrelativo);
			if (dto != null && dto.getBinArchivo() != null) {
				desplegarResponse(response, dto.getValorContentType(), dto.getBinArchivo());
			}
			else {
				throw new VentasException("No se encontró el archivo en la base de datos.");
			}
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			desplegarHTML(response, "No se pudo desplegar el documento: " + e.getMessage());
		}
		logger.info("doGet, fin");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		logger.info("doPost, inicio");
		doGet(request, response);
		logger.info("doPost, fin");
	}

	/**
	 * @param response
	 * @param dto
	 * @throws IOException
	 * Incidencia 149265. No se ven los documentos asociados a las ventas
	 */
	protected void desplegarResponse(HttpServletResponse response, String contentType, byte[] bytes) throws IOException {
		final String nombreMetodo = "desplegarResponse";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("contentType [" + contentType + "]");
		response.setContentType(contentType);
		OutputStream outputStream = response.getOutputStream();
		outputStream.write(bytes);
		outputStream.flush();
		outputStream.close();
		logger.info(nombreMetodo + ", fin");
	}

	/**
	 * @param response
	 * @param dto
	 * @throws IOException
	 */
	protected void desplegarResponse(HttpServletResponse response, final String contentType, final String nombreArchivo)
			throws IOException {
		final String nombreMetodo = "desplegarResponse";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("contentType [" + contentType + "]");
		logger.debug("nombreArchivo [" + nombreArchivo + "]");
		response.setContentType(contentType);
		File file = new File(nombreArchivo);
		response.setContentLength((int) file.length());
		FileInputStream inputStream = new FileInputStream(file);
		OutputStream outputStream = response.getOutputStream();
		byte[] buf = new byte[1024];
		int i = 0;
		while ((i = inputStream.read(buf)) >= 0) {
			outputStream.write(buf, 0, i);
		}
		inputStream.close();
		outputStream.close();
		logger.info(nombreMetodo + ", fin");
	}

	/**
	 * @param response
	 * @param textoADesplegar
	 * @throws IOException
	 */
	protected void desplegarHTML(HttpServletResponse response, String textoADesplegar) throws IOException {
		final String nombreMetodo = "desplegarHTML";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("texto [" + textoADesplegar + "]");
		response.setContentType("text/html");
		final PrintWriter writer = response.getWriter();
		writer.write("<html><head></head><body>");
		writer.write(textoADesplegar);
		writer.write("</body></html>");
		writer.flush();
		writer.close();
		logger.info(nombreMetodo + ", fin");
	}

}