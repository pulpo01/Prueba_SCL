package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultaLlamadasFacturadasResponseDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private ConsultaLlamadasFacturadasDTO[]  lstLlamadasFact;
	private RespuestaDTO respuesta;
	
	public ConsultaLlamadasFacturadasDTO[] getLstLlamadasFact() {
		return lstLlamadasFact;
	}
	public void setLstLlamadasFact(ConsultaLlamadasFacturadasDTO[] lstLlamadasFact) {
		this.lstLlamadasFact = lstLlamadasFact;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
	

}
