package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable; 
public class SimcardOutDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Long codError;	
	private String msgError;
	private Long codEvento;
	
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