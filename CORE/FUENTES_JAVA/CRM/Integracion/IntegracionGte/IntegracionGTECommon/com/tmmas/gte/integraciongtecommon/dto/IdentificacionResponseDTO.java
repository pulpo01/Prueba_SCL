package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class IdentificacionResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//private IdentificacionDTO[] lstIdentificaciones;
	private String desIdentificacion;
	private RespuestaDTO respuesta;
	
	public String getDesIdentificacion() {
		return desIdentificacion;
	}
	public void setDesIdentificacion(String desIdentificacion) {
		this.desIdentificacion = desIdentificacion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
	
	
}
