package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsultaPukResponseDTO implements Serializable{
	
	/**
	 * Autor : Leonardo Muñoz R.
	**/
	
	private static final long serialVersionUID = 1L;
	private long numeroPuk;
	private RespuestaDTO respuesta;
	
	public long getNumeroPuk() {
		return numeroPuk;
	}
	public void setNumeroPuk(long numeroPuk) {
		this.numeroPuk = numeroPuk;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
