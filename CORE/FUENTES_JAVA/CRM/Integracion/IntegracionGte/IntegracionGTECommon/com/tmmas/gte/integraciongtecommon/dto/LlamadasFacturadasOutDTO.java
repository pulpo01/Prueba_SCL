package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LlamadasFacturadasOutDTO implements Serializable {
	/**
	 * Autor : Juan Muñoz Queupul
	 * Modificando: Para solucionar el problema del caso de uso 19
	 */
	private static final long serialVersionUID = 1L;
	private LlamadaFacturadaDTO[]  lstLlamadasFact;
	private RespuestaDTO respuesta;
	
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public LlamadaFacturadaDTO[] getLstLlamadasFact() {
		return lstLlamadasFact;
	}
	public void setLstLlamadasFact(LlamadaFacturadaDTO[] lstLlamadasFact) {
		this.lstLlamadasFact = lstLlamadasFact;
	}

	
	
	

}
