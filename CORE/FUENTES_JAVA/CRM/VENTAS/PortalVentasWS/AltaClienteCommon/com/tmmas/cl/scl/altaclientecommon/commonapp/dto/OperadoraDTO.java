package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class OperadoraDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoOperadora;
	private String descripcionOperadora;
	
	public String getCodigoOperadora() {
		return codigoOperadora;
	}
	public void setCodigoOperadora(String codigoOperadora) {
		this.codigoOperadora = codigoOperadora;
	}
	public String getDescripcionOperadora() {
		return descripcionOperadora;
	}
	public void setDescripcionOperadora(String descripcionOperadora) {
		this.descripcionOperadora = descripcionOperadora;
	}
	
}//fin class OperadoraDTO