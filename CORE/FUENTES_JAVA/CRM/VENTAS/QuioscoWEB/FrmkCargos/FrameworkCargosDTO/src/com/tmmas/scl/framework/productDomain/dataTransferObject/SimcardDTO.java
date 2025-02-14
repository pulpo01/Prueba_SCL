/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/07/2007              Raúl Lozano      					Versión Inicial
 */

package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class SimcardDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String numeroSerie;
	private String codigoArticulo;
	private String descripcionArticulo;
	private String tipoArticulo;
	private String indProcEq;
	private String codigoUso;
	private String codigoBodega;
	private String capCode;
	private String estado;
	private String codigoCentral;
	private String codigoSubAlm;
	private String indicadorProgramado;
	private String numeroCelular;
	private String tipoStock;
	private String codigoCategoria;
	private String indiceRecambio;
	private String indicadorValorar;
	private String indicadorTelefono;
	/*--utilizados para buscar imsi asociado a la simcard--*/
	private String codigoImsi;
	private String valorImsi;
	/*--utilizados para actualizar stock --*/
	private int    codigoError;
	private String numeroVenta;
	private String numeroMovimiento;
	private String tipoMovimiento;
	private String indSerConTel;
	
	
	public String getIndSerConTel() {
		return indSerConTel;
	}
	public void setIndSerConTel(String indSerConTel) {
		this.indSerConTel = indSerConTel;
	}
	public String getNumeroMovimiento() {
		return numeroMovimiento;
	}
	public void setNumeroMovimiento(String numeroMovimiento) {
		this.numeroMovimiento = numeroMovimiento;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoMovimiento() {
		return tipoMovimiento;
	}
	public void setTipoMovimiento(String tipoMovimiento) {
		this.tipoMovimiento = tipoMovimiento;
	}
	public String getCodigoImsi() {
		return codigoImsi;
	}
	public void setCodigoImsi(String codigoImsi) {
		this.codigoImsi = codigoImsi;
	}
	public String getValorImsi() {
		return valorImsi;
	}
	public void setValorImsi(String valorImsi) {
		this.valorImsi = valorImsi;
	}
	public String getIndicadorTelefono() {
		return indicadorTelefono;
	}
	public void setIndicadorTelefono(String indicadorTelefono) {
		this.indicadorTelefono = indicadorTelefono;
	}
	public String getIndicadorValorar() {
		return indicadorValorar;
	}
	public void setIndicadorValorar(String indicadorValorar) {
		this.indicadorValorar = indicadorValorar;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
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
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getIndicadorProgramado() {
		return indicadorProgramado;
	}
	public void setIndicadorProgramado(String indicadorProgramado) {
		this.indicadorProgramado = indicadorProgramado;
	}
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getCodigoSubAlm() {
		return codigoSubAlm;
	}
	public void setCodigoSubAlm(String codigoSubAlm) {
		this.codigoSubAlm = codigoSubAlm;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getDescripcionArticulo() {
		return descripcionArticulo;
	}
	public void setDescripcionArticulo(String descripcionArticulo) {
		this.descripcionArticulo = descripcionArticulo;
	}
	public String getIndProcEq() {
		return indProcEq;
	}
	public void setIndProcEq(String indProcEq) {
		this.indProcEq = indProcEq;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getTipoArticulo() {
		return tipoArticulo;
	}
	public void setTipoArticulo(String tipoArticulo) {
		this.tipoArticulo = tipoArticulo;
	}
	public String getCapCode() {
		return capCode;
	}
	public void setCapCode(String capCode) {
		this.capCode = capCode;
	}
	public int getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(int codigoError) {
		this.codigoError = codigoError;
	}
	
	
	
	

}
