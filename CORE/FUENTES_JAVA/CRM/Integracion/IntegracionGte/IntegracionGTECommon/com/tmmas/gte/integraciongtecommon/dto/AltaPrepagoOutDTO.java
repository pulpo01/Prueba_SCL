package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
public class AltaPrepagoOutDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String fechaAlta;
	private RespuestaDTO respuesta;

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(String fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
}
