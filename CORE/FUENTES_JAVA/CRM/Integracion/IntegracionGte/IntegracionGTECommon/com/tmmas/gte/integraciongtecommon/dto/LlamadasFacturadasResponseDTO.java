package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LlamadasFacturadasResponseDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 * Modificando: Para solucionar el problema del caso de uso 19
	 */
	private static final long serialVersionUID = 1L;
	private TraficoDTO[]  lstLlamadasFact;
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
	public TraficoDTO[] getLstLlamadasFact() {
		return lstLlamadasFact;
	}
	public void setLstLlamadasFact(TraficoDTO[] lstLlamadasFact) {
		this.lstLlamadasFact = lstLlamadasFact;
	}
	
	
	

}
