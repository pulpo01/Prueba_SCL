package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class LstComponentesDTO implements Serializable{
	/*
	 * Autor : Daniel Jara Oyarzún
	 * */
	private static final long serialVersionUID = 1L;
	
	private  ComponentesDTO[] SerciviosSuplementarios;      																								 
	private	 RespuestaDTO     respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public ComponentesDTO[] getSerciviosSuplementarios() {
		return SerciviosSuplementarios;
	}
	public void setSerciviosSuplementarios(ComponentesDTO[] serciviosSuplementarios) {
		SerciviosSuplementarios = serciviosSuplementarios;
	}

	
}
