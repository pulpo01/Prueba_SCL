package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class RetornoLineaDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codError = "0";
	private String MensajseError = "0";
	private String numLinea;
	
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getMensajseError() {
		return MensajseError;
	}
	public void setMensajseError(String mensajseError) {
		MensajseError = mensajseError;
	}
	public String getNumLinea() {
		return numLinea;
	}
	public void setNumLinea(String numLinea) {
		this.numLinea = numLinea;
	}
	

}
