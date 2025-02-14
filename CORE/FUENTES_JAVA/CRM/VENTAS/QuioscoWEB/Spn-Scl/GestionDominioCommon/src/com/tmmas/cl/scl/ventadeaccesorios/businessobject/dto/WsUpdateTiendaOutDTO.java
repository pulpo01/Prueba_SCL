package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class WsUpdateTiendaOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private int	codError;
	private String msgError;	
	private int numEvento;
	
	//
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public int getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(int numEvento) {
		this.numEvento = numEvento;
	}
	
}
