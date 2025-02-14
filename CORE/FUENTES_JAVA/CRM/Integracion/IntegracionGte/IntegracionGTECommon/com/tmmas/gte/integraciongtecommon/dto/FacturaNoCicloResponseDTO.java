package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class FacturaNoCicloResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private FacturaNoCicloDTO[]  lstListadoFacturas;
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

	public FacturaNoCicloDTO[] getLstListadoFacturas() {
		return lstListadoFacturas;
	}

	public void setLstListadoFacturas(FacturaNoCicloDTO[] lstListadoFacturas) {
		this.lstListadoFacturas = lstListadoFacturas;
	}





	

}