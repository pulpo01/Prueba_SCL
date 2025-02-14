package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class TerminalDTO implements Serializable {

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
	private String indicadorValorar;
	private String codigoCategoria;
	private String procedenciaInterna;
	private String procedenciaExterna;
	/*--utilizados para actualizar stock --*/
	private int    codigoError;
	private String numeroVenta;
	private String numeroMovimiento;
	private String tipoMovimiento;
	private String indSerConTel; 	
	private String indicadorTelefono;
	private String estadoAnterior;

	//-- MAYORISTA
	private String canalVendedor;
	private String modalidadVenta;
	
	public String getIndicadorTelefono() {
		return indicadorTelefono;
	}
	public void setIndicadorTelefono(String indicadorTelefono) {
		this.indicadorTelefono = indicadorTelefono;
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
	public String getProcedenciaExterna() {
		return procedenciaExterna;
	}
	public void setProcedenciaExterna(String procedenciaExterna) {
		this.procedenciaExterna = procedenciaExterna;
	}
	public String getProcedenciaInterna() {
		return procedenciaInterna;
	}
	public void setProcedenciaInterna(String procedenciaInterna) {
		this.procedenciaInterna = procedenciaInterna;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getIndicadorValorar() {
		return indicadorValorar;
	}
	public void setIndicadorValorar(String indicadorValorar) {
		this.indicadorValorar = indicadorValorar;
	}
	public String getCapCode() {
		return capCode;
	}
	public void setCapCode(String capCode) {
		this.capCode = capCode;
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
	public String getDescripcionArticulo() {
		return descripcionArticulo;
	}
	public void setDescripcionArticulo(String descripcionArticulo) {
		this.descripcionArticulo = descripcionArticulo;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getIndicadorProgramado() {
		return indicadorProgramado;
	}
	public void setIndicadorProgramado(String indicadorProgramado) {
		this.indicadorProgramado = indicadorProgramado;
	}
	public String getIndProcEq() {
		return indProcEq;
	}
	public void setIndProcEq(String indProcEq) {
		this.indProcEq = indProcEq;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
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
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	public int getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(int codigoError) {
		this.codigoError = codigoError;
	}
	public String getEstadoAnterior() {
		return estadoAnterior;
	}
	public void setEstadoAnterior(String estadoAnterior) {
		this.estadoAnterior = estadoAnterior;
	}
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
	public int getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(int codigoUso) {
		this.codigoUso = codigoUso;
	}

}
