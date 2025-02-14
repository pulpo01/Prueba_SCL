package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class NumeroCuotasListOutDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		
	
	public NumeroCuotasListOutDTO() {

	}
	
	private NumeroCuotasDTO allNumeroCuotasDTO[];
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	

	public NumeroCuotasDTO[] getallNumeroCuotasDTO() {
		return allNumeroCuotasDTO;
	}

	public void setallNumeroCuotasDTO(NumeroCuotasDTO iAllNumeroCuotasDTO[]) {
		this.allNumeroCuotasDTO = iAllNumeroCuotasDTO;
	}
	
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public Long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

}
