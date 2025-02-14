package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsVendedorStockInDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codVendedor;
	private long codUso;
	private String tipTerminal;
	private String indInterno;
	
	public String getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(String indInterno) {
		this.indInterno = indInterno;
	}
	public long getCodUso() {
		return codUso;
	}
	public void setCodUso(long codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	
	
}
