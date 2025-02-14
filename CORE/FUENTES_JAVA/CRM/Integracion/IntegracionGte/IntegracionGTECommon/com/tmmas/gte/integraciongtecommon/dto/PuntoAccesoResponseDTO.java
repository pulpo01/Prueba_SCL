package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class PuntoAccesoResponseDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String desPuntoAcceso;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getDesPuntoAcceso() {
		return desPuntoAcceso;
	}
	public void setDesPuntoAcceso(String desPuntoAcceso) {
		this.desPuntoAcceso = desPuntoAcceso;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
		
	
}
