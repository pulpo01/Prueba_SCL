package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class RetornoValidacionAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private boolean valido;
	private String codError;
	private String msgError;
	private String identificadorFormateado;

	public boolean isValido() {
		return valido;
	}

	public void setValido(boolean valido) {
		this.valido = valido;
	}

	public RetornoValidacionAjaxDTO() {
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

	public String getIdentificadorFormateado() {
		return identificadorFormateado;
	}

	public void setIdentificadorFormateado(String identificadorFormateado) {
		this.identificadorFormateado = identificadorFormateado;
	}




}
