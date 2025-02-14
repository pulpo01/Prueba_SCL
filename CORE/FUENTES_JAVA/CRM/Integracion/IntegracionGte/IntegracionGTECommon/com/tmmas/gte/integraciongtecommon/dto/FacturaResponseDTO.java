package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class FacturaResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private FacturaDTO[]  lstListadoFacturas;
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
	public FacturaDTO[] getLstListadoFacturas() {
		return lstListadoFacturas;
	}
	public void setLstListadoFacturas(FacturaDTO[] lstListadoFacturas) {
		this.lstListadoFacturas = lstListadoFacturas;
	}





	

}