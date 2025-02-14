package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

public class WsRespuestaImasDDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String descripcionErro;
	private String codigoError;
	private String lineaError;
	
	
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	public String getDescripcionErro() {
		return descripcionErro;
	}
	public void setDescripcionErro(String descripcionErro) {
		this.descripcionErro = descripcionErro;
	}
	public String getLineaError() {
		return lineaError;
	}
	public void setLineaError(String lineaError) {
		this.lineaError = lineaError;
	}
	

}
