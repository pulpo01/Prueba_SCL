package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsParametrosResponseDTO  implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private String  valParametro;
	private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}

	public String getValParametro() {
		return valParametro;
	}

	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}

}