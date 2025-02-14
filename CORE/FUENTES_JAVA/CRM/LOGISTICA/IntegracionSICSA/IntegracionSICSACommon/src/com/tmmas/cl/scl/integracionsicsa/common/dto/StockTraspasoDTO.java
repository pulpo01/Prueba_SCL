package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class StockTraspasoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tipStock;
	private String codArticulo;
	private String codUso;
	private String codEstado;
	private String cantTraspaso;
	private String fecEntrada;
	private String numGuia;
	private String indSeriado;
	
	public String getTipStock() {
		return tipStock;
	}
	public void setTipStock(String tipStock) {
		this.tipStock = tipStock;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCantTraspaso() {
		return cantTraspaso;
	}
	public void setCantTraspaso(String cantTraspaso) {
		this.cantTraspaso = cantTraspaso;
	}
	public String getFecEntrada() {
		return fecEntrada;
	}
	public void setFecEntrada(String fecEntrada) {
		this.fecEntrada = fecEntrada;
	}
	public String getNumGuia() {
		return numGuia;
	}
	public void setNumGuia(String numGuia) {
		this.numGuia = numGuia;
	}
	public String getIndSeriado() {
		return indSeriado;
	}
	public void setIndSeriado(String indSeriado) {
		this.indSeriado = indSeriado;
	}
}
