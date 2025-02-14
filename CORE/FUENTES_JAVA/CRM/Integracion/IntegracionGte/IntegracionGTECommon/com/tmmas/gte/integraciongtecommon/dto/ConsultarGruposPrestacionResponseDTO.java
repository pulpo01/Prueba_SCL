package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultarGruposPrestacionResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private ConsultarGruposPrestacionDTO[]  listadoPrestaciones;
	private RespuestaDTO respuesta;
	
	public ConsultarGruposPrestacionDTO[] getListadoPrestaciones() {
		return listadoPrestaciones;
	}
	public void setListadoPrestaciones(
			ConsultarGruposPrestacionDTO[] listadoPrestaciones) {
		this.listadoPrestaciones = listadoPrestaciones;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
}
