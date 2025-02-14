package com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject;

import java.io.Serializable;

public class RetornoValorDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String resultado;
	private String codError;
	private String msgError;
	
	public RetornoValorDTO() {
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
