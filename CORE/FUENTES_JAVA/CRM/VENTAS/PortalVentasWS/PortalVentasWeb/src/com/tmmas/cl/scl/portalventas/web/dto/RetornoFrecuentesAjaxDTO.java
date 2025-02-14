package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class RetornoFrecuentesAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String numero;
	private String tipo;
	private String codTipo;
	private String codError;
	private String msgError;
	
	public RetornoFrecuentesAjaxDTO() {
		this.codError = "";
		this.msgError = "";
	}
	
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	


}
