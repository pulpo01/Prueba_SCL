package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class PagoOutResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private PagoOutDTO[]  lstListadoPagos;
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


	public PagoOutDTO[] getLstListadoPagos() {
		return lstListadoPagos;
	}


	public void setLstListadoPagos(PagoOutDTO[] lstListadoPagos) {
		this.lstListadoPagos = lstListadoPagos;
	}


}