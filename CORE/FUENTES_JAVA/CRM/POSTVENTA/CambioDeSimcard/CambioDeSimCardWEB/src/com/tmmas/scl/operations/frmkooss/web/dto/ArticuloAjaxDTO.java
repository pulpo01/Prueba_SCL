package com.tmmas.scl.operations.frmkooss.web.dto;

import java.io.Serializable;

public class ArticuloAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codArticulo;
	private String desArticulo;
	private String tipoArticulo;
	
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	public String getTipoArticulo() {
		return tipoArticulo;
	}
	public void setTipoArticulo(String tipoArticulo) {
		this.tipoArticulo = tipoArticulo;
	}
	
}
