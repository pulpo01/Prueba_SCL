package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class RespBooleanDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private boolean respBoolean;
	private RespuestaDTO respuesta;

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public boolean isRespBoolean() {
		return respBoolean;
	}
	public void setRespBoolean(boolean respBoolean) {
		this.respBoolean = respBoolean;
	}

}
