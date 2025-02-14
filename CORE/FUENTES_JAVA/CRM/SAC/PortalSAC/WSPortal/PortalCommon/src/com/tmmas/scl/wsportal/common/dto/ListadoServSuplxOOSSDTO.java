package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ListadoServSuplxOOSSDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ServSuplXOOSSDTO[] arrayServSupl;
	
	private String codError;

	private String desError;

	public ServSuplXOOSSDTO[] getArrayServSupl() {
		return arrayServSupl;
	}

	public void setArrayServSupl(ServSuplXOOSSDTO[] arrayServSupl) {
		this.arrayServSupl = arrayServSupl;
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
}
