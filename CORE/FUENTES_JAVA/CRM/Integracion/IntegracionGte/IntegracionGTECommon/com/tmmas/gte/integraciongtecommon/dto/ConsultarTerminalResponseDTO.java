package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultarTerminalResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 * modificado por JDMQ
	 */
	private static final long serialVersionUID = 1L;
	private long codArticulo;
	private String descEquipo;

	private RespuestaDTO respuesta;
	
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getDescEquipo() {
		return descEquipo;
	}
	public void setDescEquipo(String descEquipo) {
		this.descEquipo = descEquipo;
	}
	
	
}
