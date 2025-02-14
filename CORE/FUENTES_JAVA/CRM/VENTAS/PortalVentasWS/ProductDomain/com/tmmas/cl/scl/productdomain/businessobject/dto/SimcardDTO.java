package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class SimcardDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String numeroSerie;
	private String codigoArticulo;
	private String descripcionArticulo;
	private String tipoArticulo;
	private String indProcEq;
	private int codigoUso;
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
		
	//-- MAYORISTA
	private String canalVendedor;
	private String modalidadVenta;
	
	private String carga;
		
	public String getCanalVendedor() {
		return canalVendedor;
	}
	public void setCanalVendedor(String canalVendedor) {
		this.canalVendedor = canalVendedor;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
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
	public String getCarga() {
		return carga;
	}
	public void setCarga(String carga) {
		this.carga = carga;
	}
	public int getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(int codigoUso) {
		this.codigoUso = codigoUso;
	}
	
	
	
	

}
