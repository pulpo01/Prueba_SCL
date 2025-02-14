package com.tmmas.cl.scl.portalventas.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;

public class DocDigitalizadoArchivoServlet extends DocDigitalizadoServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = -8145621479828309838L;

	Logger logger = Logger.getLogger(this.getClass());

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("doGet, inicio");
		final Long numCorrelativo = new Long(request.getParameter("numCorrelativo"));
		final Long numSolScoring = new Long(request.getParameter("numSolScoring"));
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		logger.debug("numSolScoring [" + numSolScoring + "]");
		DocDigitalizadoScoringDTO dto = null;
		try {
			dto = delegate.obtenerDocDigitalizadoScoring(numCorrelativo, numSolScoring);
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
}