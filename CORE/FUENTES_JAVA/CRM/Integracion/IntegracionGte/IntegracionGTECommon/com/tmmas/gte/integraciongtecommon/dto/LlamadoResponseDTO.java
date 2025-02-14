package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class LlamadoResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private LlamadaDTO[]  lstListadoLlamados;
	private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public LlamadaDTO[] getLstListadoLlamados() {
		return lstListadoLlamados;
	}

	public void setLstListadoLlamados(LlamadaDTO[] lstListadoLlamados) {
		this.lstListadoLlamados = lstListadoLlamados;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}

}