package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ParametrosCargoTerminalDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String numeroSerie;
	private String codigoArticulo;
	private String codigoUso;
	private String tipoStock;
	private String estado;
	private String indiceRecambio;
	private String codigoCategoria;
	private String modalidadVenta;
	private String tipoContrato;
	private String planTarifario;
	private String codigoUsoPrepago;
	private String indicadorEquipo;
	
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
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	public String getCodigoUsoPrepago() {
		return codigoUsoPrepago;
	}
	public void setCodigoUsoPrepago(String codigoUsoPrepago) {
		this.codigoUsoPrepago = codigoUsoPrepago;
	}
	public String getIndicadorEquipo() {
		return indicadorEquipo;
	}
	public void setIndicadorEquipo(String indicadorEquipo) {
		this.indicadorEquipo = indicadorEquipo;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}

}//fin ParametrosCargoTerminalDTO
