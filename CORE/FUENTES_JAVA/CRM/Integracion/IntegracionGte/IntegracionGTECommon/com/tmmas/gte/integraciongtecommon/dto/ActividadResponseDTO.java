package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ActividadResponseDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String desActividad;
	private RespuestaDTO respuesta;
	
	public String getDesActividad() {
		return desActividad;
	}
	public void setDesActividad(String desActividad) {
		this.desActividad = desActividad;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	
}
