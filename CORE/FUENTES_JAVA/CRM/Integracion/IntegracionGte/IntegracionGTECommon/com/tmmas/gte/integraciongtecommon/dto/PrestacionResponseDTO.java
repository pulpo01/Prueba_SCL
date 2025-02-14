package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class PrestacionResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private PrestacionOutDTO[]  listadoPrestaciones;
	private RespuestaDTO respuesta;
	
	public PrestacionOutDTO[] getListadoPrestaciones() {
		return listadoPrestaciones;
	}
	public void setListadoPrestaciones(
			PrestacionOutDTO[] listadoPrestaciones) {
		this.listadoPrestaciones = listadoPrestaciones;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
}
