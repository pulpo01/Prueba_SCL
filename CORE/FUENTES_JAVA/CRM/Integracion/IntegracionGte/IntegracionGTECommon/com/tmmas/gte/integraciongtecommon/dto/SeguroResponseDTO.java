package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class SeguroResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private SeguroOutDTO[]  lstListadoSeguros;
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

	public SeguroOutDTO[] getLstListadoSeguros() {
		return lstListadoSeguros;
	}

	public void setLstListadoSeguros(SeguroOutDTO[] lstListadoSeguros) {
		this.lstListadoSeguros = lstListadoSeguros;
	}
    
	

}