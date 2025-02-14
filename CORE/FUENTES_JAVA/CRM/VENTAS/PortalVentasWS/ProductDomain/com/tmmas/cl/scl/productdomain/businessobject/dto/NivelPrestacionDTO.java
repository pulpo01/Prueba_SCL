package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class NivelPrestacionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codPrestacion;
	private int codNivel;
	private String descripcionNivel;
	
	public int getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(int codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getDescripcionNivel() {
		return descripcionNivel;
	}
	public void setDescripcionNivel(String descripcionNivel) {
		this.descripcionNivel = descripcionNivel;
	}
	
}
