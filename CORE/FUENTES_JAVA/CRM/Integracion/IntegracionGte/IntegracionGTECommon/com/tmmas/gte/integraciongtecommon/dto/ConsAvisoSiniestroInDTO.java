package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsAvisoSiniestroInDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private long numeroTelefono;
	private String codSiniestro;
	
	public String getCodSiniestro() {
		return codSiniestro;
	}
	public void setCodSiniestro(String codSiniestro) {
		this.codSiniestro = codSiniestro;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	
	

}
