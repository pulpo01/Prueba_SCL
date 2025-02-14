package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class TecnologiaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codTecnologia;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
}
