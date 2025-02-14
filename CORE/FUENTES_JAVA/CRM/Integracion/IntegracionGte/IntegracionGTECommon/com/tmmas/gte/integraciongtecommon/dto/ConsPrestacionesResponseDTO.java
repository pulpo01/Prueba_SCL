package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */

public class ConsPrestacionesResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private ConsPrestacionesDTO[] listPrestaciones;
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
	public ConsPrestacionesDTO[] getListPrestaciones() {
		return listPrestaciones;
	}
	public void setListPrestaciones(ConsPrestacionesDTO[] listPrestaciones) {
		this.listPrestaciones = listPrestaciones;
	}

	
	
}