package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class ParametrosCargosAccesoriosDTO implements Serializable{
	
	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	private String codigoArticulo;
	private String tipoStock;
	private String codigoUso;
	private String estado;
	private String indiceRecambio;
	private String codigoCategoria;
	
	
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getIndiceRecambio() {
		return indiceRecambio;
	}
	public void setIndiceRecambio(String indiceRecambio) {
		this.indiceRecambio = indiceRecambio;
	}
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}

	
	
}
