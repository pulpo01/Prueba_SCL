package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class CelularDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long   numeroCelular;
	private long   numeroTransaccion;
	private String tipoCelular;
	private String categoria;
	private String codSubAlm;
	private String central;
	private String codigoUso;
	private String numeroLinea;
	private String numeroOrden;
	private String indProcNumero;
	private String fecBajaCelular;
	private String nomUsuarioOra;
	
	
	private String codActabo;
	
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public long getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getTipoCelular() {
		return tipoCelular;
	}
	public void setTipoCelular(String tipoCelular) {
		this.tipoCelular = tipoCelular;
	}
	public String getCentral() {
		return central;
	}
	public void setCentral(String central) {
		this.central = central;
	}
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getCodSubAlm() {
		return codSubAlm;
	}
	public void setCodSubAlm(String codSubAlm) {
		this.codSubAlm = codSubAlm;
	}
	public String getFecBajaCelular() {
		return fecBajaCelular;
	}
	public void setFecBajaCelular(String fecBajaCelular) {
		this.fecBajaCelular = fecBajaCelular;
	}
	public String getIndProcNumero() {
		return indProcNumero;
	}
	public void setIndProcNumero(String indProcNumero) {
		this.indProcNumero = indProcNumero;
	}
	public String getNumeroLinea() {
		return numeroLinea;
	}
	public void setNumeroLinea(String numeroLinea) {
		this.numeroLinea = numeroLinea;
	}
	public String getNumeroOrden() {
		return numeroOrden;
	}
	public void setNumeroOrden(String numeroOrden) {
		this.numeroOrden = numeroOrden;
	}
	public long getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(long numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
	}
	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}

}//fin CelularDTO
