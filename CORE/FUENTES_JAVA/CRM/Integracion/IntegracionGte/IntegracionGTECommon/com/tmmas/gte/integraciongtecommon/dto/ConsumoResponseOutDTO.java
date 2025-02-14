package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsumoResponseOutDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private ConsumoOutDTO[]  lstListadoConsumosMensajesCortos;
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

	public ConsumoOutDTO[] getLstListadoConsumosMensajesCortos() {
		return lstListadoConsumosMensajesCortos;
	}

	public void setLstListadoConsumosMensajesCortos(
			ConsumoOutDTO[] lstListadoConsumosMensajesCortos) {
		this.lstListadoConsumosMensajesCortos = lstListadoConsumosMensajesCortos;
	}
}