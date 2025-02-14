package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ClienteTelInDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private long numeroTelefono;
	
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}

}
