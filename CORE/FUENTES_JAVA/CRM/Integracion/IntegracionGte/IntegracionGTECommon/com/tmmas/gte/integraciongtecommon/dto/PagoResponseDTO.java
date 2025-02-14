package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class PagoResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private PagoDTO[]  lstListadoPagos;
	private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public PagoDTO[] getLstListadoPagos() {
		return lstListadoPagos;
	}

	public void setLstListadoPagos(PagoDTO[] lstListadoPagos) {
		this.lstListadoPagos = lstListadoPagos;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}


}