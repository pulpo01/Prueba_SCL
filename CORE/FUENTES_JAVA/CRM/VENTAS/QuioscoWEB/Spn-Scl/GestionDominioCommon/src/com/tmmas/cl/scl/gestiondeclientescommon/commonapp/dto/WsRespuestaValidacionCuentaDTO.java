package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsRespuestaValidacionCuentaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoRespuesta;
	private String descripcion;
	private String numLinea;
	
	
	public String getNumLinea() {
		return numLinea;
	}
	public void setNumLinea(String numLinea) {
		this.numLinea = numLinea;
	}
	public String getCodigoRespuesta() {
		return codigoRespuesta;
	}
	public void setCodigoRespuesta(String codigoRespuesta) {
		this.codigoRespuesta = codigoRespuesta;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	

}
