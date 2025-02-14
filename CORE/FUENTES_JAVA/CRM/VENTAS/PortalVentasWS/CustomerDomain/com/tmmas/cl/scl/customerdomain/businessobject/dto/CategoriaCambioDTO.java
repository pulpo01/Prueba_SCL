package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class CategoriaCambioDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codCategoria;
	private String desCategoria;
	
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getDesCategoria() {
		return desCategoria;
	}
	public void setDesCategoria(String desCategoria) {
		this.desCategoria = desCategoria;
	}
	
	
}
