package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultaPukDTO implements Serializable{
	
	/**
	 * Modificado por Juan Mu�oz Q, sobre la implementacion del serial.
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Autor : Leonardo Mu�oz R.
	 */
	
	private long numeroTelefono;
	private RespuestaDTO respuesta;
	
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
