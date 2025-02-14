package com.tmmas.cl.scl.parametrosgenerales.businessobject.dto;

import java.io.Serializable;

public class EstadoCivilDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codEstado;
	private String desEstado;
	
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getDesEstado() {
		return desEstado;
	}
	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}
}
