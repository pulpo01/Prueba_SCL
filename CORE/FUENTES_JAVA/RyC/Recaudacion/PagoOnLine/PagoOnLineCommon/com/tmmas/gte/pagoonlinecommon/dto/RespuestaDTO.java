package com.tmmas.gte.pagoonlinecommon.dto;

public class RespuestaDTO implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int codigoError;
	private String mensajeError;
	private String numeroEvento;

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

	public String getNumeroEvento() {
	return numeroEvento;
	}

	public void setNumeroEvento(String numeroEvento) {
	this.numeroEvento = numeroEvento;
	}

	}

