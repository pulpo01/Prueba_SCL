package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class NumeroRangoAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String numDesde;
	private String numHasta;
	private String categoria;
	
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getNumDesde() {
		return numDesde;
	}
	public void setNumDesde(String numDesde) {
		this.numDesde = numDesde;
	}
	public String getNumHasta() {
		return numHasta;
	}
	public void setNumHasta(String numHasta) {
		this.numHasta = numHasta;
	}
}
