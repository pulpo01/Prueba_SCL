package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

public class WsRespuestaOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoRespuesta;
	private String[] codigosError;
	
	public String getCodigoRespuesta() {
		return codigoRespuesta;
	}
	public void setCodigoRespuesta(String codigoRespuesta) {
		this.codigoRespuesta = codigoRespuesta;
	}
	public String[] getCodigosError() {
		return codigosError;
	}
	public void setCodigosError(String[] codigosError) {
		this.codigosError = codigosError;
	}
		
}
