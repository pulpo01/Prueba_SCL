package com.tmmas.cl.scl.integracionexterna.bo;

import com.tmmas.cl.scl.integracionexterna.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.dao.GeneralDAO;

public class GeneralBO extends IntegracionExternaBO {

	private GeneralDAO generalDAO = new GeneralDAO();

	/**
	 * Metodo que consulta los datos para el envio de correo
	 * 
	 * @throws IntegracionExternaException
	 */
	public DatosCorreoDTO getDatosCorreo(String paramCorreo)throws IntegracionExternaException {
		DatosCorreoDTO outDTO;
		loggerDebug("getDatosCorreo: inicio");
		outDTO = generalDAO.getDatosCorreo(paramCorreo);
		loggerDebug("getDatosCorreo: fin");
		return outDTO;
	}
}
