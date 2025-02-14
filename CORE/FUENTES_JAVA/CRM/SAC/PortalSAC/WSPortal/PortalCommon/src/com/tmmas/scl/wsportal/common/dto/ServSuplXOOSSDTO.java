package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ServSuplXOOSSDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codServSupl;
	
	private String desServSupl;
	
	private String accion;

	public String getCodServSupl() {
		return codServSupl;
	}

	public void setCodServSupl(String codServSupl) {
		this.codServSupl = codServSupl;
	}

	public String getDesServSupl() {
		return desServSupl;
	}

	public void setDesServSupl(String desServSupl) {
		this.desServSupl = desServSupl;
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}
}
