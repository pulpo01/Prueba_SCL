package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class BloqueoResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private BloqueoOutDTO[]  lstListadoBloqueos;
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

	public BloqueoOutDTO[] getLstListadoBloqueos() {
		return lstListadoBloqueos;
	}

	public void setLstListadoBloqueos(BloqueoOutDTO[] lstListadoBloqueos) {
		this.lstListadoBloqueos = lstListadoBloqueos;
	}





	

}