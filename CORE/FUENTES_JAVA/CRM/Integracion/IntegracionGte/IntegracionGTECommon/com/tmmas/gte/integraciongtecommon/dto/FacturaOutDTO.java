package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class FacturaOutDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private FechaReporteConsumoDTO[]  lstListadoFechasConsumos;
	private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public FechaReporteConsumoDTO[] getLstListadoFechasConsumos() {
		return lstListadoFechasConsumos;
	}

	public void setLstListadoFechasConsumos(
			FechaReporteConsumoDTO[] lstListadoFechasConsumos) {
		this.lstListadoFechasConsumos = lstListadoFechasConsumos;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}


}