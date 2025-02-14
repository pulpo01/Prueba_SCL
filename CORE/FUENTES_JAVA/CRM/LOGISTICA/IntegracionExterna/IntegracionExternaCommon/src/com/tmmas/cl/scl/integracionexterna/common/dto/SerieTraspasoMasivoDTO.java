package com.tmmas.cl.scl.integracionexterna.common.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.EntradaIntegracionExternaDTO;

public class SerieTraspasoMasivoDTO extends EntradaIntegracionExternaDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tipStock;
	private String codUso;
	private String codEstado;
	private String numSerie;
	private String codArticulo;
	
	public String getTipStock() {
		return tipStock;
	}
	public void setTipStock(String tipStock) {
		this.tipStock = tipStock;
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
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
}
