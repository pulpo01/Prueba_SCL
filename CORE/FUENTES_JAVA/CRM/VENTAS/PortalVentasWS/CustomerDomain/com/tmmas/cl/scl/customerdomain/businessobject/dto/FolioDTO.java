package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FolioDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private String codOficina;
	private long codTipDocum;
	private String desTipDocum;
	private String folio;
	
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public long getCodTipDocum() {
		return codTipDocum;
	}
	public void setCodTipDocum(long codTipDocum) {
		this.codTipDocum = codTipDocum;
	}
	public String getDesTipDocum() {
		return desTipDocum;
	}
	public void setDesTipDocum(String desTipDocum) {
		this.desTipDocum = desTipDocum;
	}
	public String getFolio() {
		return folio;
	}
	public void setFolio(String folio) {
		this.folio = folio;
	}	
		
}
