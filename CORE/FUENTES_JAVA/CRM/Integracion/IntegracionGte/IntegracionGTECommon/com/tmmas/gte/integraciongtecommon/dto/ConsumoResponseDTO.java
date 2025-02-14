package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsumoResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private ConsumoDTO[]  lstListadoConsumosMensajesCortos;
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

	public ConsumoDTO[] getLstListadoConsumosMensajesCortos() {
		return lstListadoConsumosMensajesCortos;
	}

	public void setLstListadoConsumosMensajesCortos(
			ConsumoDTO[] lstListadoConsumosMensajesCortos) {
		this.lstListadoConsumosMensajesCortos = lstListadoConsumosMensajesCortos;
	}


}