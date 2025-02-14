package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ConceptoVenta implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int codigo;
	private String descripcion;
	

	public ConceptoVenta(int codigo, String descripcion) {
		super();
		this.codigo = codigo;
		this.descripcion = descripcion;
	}

	public int getCodigo() {
		return codigo;
	}
	
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

}
