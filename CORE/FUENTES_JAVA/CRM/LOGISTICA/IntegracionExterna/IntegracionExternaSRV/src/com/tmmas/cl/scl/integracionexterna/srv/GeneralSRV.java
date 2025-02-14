package com.tmmas.cl.scl.integracionexterna.srv;

import com.tmmas.cl.scl.integracionexterna.bo.GeneralBO;
import com.tmmas.cl.scl.integracionexterna.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;;

public class GeneralSRV extends IntegracionExternaSRV {

	private GeneralBO generalBO = new GeneralBO();
	
	/**
	 * Metodo que consulta los datos para el envio de correo
	 * 
	 * @throws IntegracionExternaException
	 */
	public DatosCorreoDTO getDatosCorreo(String paramCorreo) throws IntegracionExternaException {
		DatosCorreoDTO outDTO;
		loggerDebug("getDatosCorreo: inicio");
		outDTO = generalBO.getDatosCorreo(paramCorreo);
		loggerDebug("getDatosCorreo: fin");
		return outDTO;
	}
}