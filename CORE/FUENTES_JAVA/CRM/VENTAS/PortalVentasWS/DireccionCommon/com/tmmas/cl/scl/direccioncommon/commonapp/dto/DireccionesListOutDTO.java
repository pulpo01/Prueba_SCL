package com.tmmas.cl.scl.direccioncommon.commonapp.dto;

import java.io.Serializable;

public class DireccionesListOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private DireccionOutDTO allDireccionOutDTO[];
	private Long codError;
	private String msgError;
	private Long codEvento;

	public DireccionesListOutDTO() {
	}
	
	public String getMsgError() {
		return msgError;
	}

	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

	public Long getCodEvento() {
		return codEvento;
	}

	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}

	public DireccionOutDTO[] getallDireccionOutDTO() {
		return allDireccionOutDTO;
	}

	public void setallDireccionOutDTO(DireccionOutDTO iAllDireccionOutDTO[]) {
		this.allDireccionOutDTO = iAllDireccionOutDTO;
	}

	public Long getCodError() {
		return codError;
	}

	public void setCodError(Long codError) {
		this.codError = codError;
	}

}
