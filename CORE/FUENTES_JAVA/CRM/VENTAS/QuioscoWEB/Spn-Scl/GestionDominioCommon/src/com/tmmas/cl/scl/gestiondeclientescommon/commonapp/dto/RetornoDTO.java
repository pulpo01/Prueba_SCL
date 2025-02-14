package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class RetornoDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//private String resultadoTransaccion="0";
	private String codError="0";
	private String MensajseError="0";
	
	public String getMensajseError() {
		return MensajseError;
	}
	public void setMensajseError(String mensajseError) {
		MensajseError = mensajseError;
	}
	public String getCodError() {
		return codError;
	}
	
	public void setCodError(String codError) {
		this.codError = codError;
	}
	/*public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}*/

}
