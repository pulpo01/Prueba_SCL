package com.tmmas.scl.operations.frmkooss.web.dto;

import java.io.Serializable;

public class RetornoListaAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Object[] lista;
	private String codError;
	private String msgError;
	
	public RetornoListaAjaxDTO() {
		this.codError = "";
		this.msgError = "";
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public Object[] getLista() {
		return lista;
	}
	public void setLista(Object[] lista) {
		this.lista = lista;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

}
