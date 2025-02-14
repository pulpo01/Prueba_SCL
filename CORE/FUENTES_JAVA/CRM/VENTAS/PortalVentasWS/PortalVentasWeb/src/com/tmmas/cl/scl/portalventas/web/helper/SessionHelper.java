package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class SessionHelper {
	
	private static final Logger logger = Logger.getLogger(SessionHelper.class);

	/**
	 * @author JIB
	 * @param httpSession
	 * @return
	 */
	public static boolean validarSesion(HttpSession httpSession) {
		logger.info("validarSesion, inicio");
		if (httpSession == null) {
			logger.debug("validarSesion [false], fin");
			return false;
		}
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) httpSession.getAttribute("paramGlobal");
		if (sessionData == null) {
			logger.debug("validarSesion [false], fin");
			return false;
		}
		logger.info("validarSesion [true], fin");
		return true;
	}
}
