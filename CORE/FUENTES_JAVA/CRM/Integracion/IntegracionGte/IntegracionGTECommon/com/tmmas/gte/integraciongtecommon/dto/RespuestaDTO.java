package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class RespuestaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int codigoError;
	private String mensajeError;
	private long numeroEvento;
	public int getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(int codigoError) {
		this.codigoError = codigoError;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public long getNumeroEvento() {
		return numeroEvento;
	}
	public void setNumeroEvento(long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}
	
	
	
	

}
