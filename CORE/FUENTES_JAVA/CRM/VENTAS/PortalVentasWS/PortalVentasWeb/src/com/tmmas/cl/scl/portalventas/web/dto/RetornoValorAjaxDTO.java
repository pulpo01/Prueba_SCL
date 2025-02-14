package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class RetornoValorAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String resultado;
	private String codError;
	private String msgError;
	
	public RetornoValorAjaxDTO() {
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
	public String getResultado() {
		return resultado;
	}
	public void setResultado(String resultado) {
		this.resultado = resultado;
	}

}
