package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class TraficoResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private TraficoDTO[]  lstListadoLlamados;
	private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public TraficoDTO[] getLstListadoLlamados() {
		return lstListadoLlamados;
	}

	public void setLstListadoLlamados(TraficoDTO[] lstListadoLlamados) {
		this.lstListadoLlamados = lstListadoLlamados;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}

}