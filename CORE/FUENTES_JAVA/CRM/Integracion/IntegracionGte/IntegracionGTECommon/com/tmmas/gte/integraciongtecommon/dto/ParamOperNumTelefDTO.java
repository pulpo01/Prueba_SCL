package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ParamOperNumTelefDTO extends NumeroTelefonoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String codOperadora;

	public String getCodOperadora() {
		return codOperadora;
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

}
