package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListArticulosStockPorVendedorInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codVendedor;
	private long indInterno;
	private long codUso;
	private String tipTerminal;
	
	private long codArticulo;
	private long codBodega;
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
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
	public long getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(long indInterno) {
		this.indInterno = indInterno;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}


		
}
