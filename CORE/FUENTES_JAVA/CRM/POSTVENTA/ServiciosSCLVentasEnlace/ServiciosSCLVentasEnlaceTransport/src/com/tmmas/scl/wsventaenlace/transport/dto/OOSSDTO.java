package com.tmmas.scl.wsventaenlace.transport.dto;

import java.io.Serializable;
import java.sql.Timestamp;


public class OOSSDTO implements Serializable {	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;

	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String transaccion) {
		numTransaccion = transaccion;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	
	public long getNroOOSS() {
		return nroOOSS;
	}
	public void setNroOOSS(long nroOOSS) {
		this.nroOOSS = nroOOSS;
	}
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

}
