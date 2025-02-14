package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ArticuloListOutDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private ArticuloOutDTO allArticuloOutDTO[];
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	public ArticuloListOutDTO() {
	}
	
	public ArticuloOutDTO[] getallArticuloOutDTO() {
		return allArticuloOutDTO;
	}

	public void setallArticuloOutDTO(ArticuloOutDTO iAllArticuloOutDTO[]) {
		this.allArticuloOutDTO = iAllArticuloOutDTO;
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
