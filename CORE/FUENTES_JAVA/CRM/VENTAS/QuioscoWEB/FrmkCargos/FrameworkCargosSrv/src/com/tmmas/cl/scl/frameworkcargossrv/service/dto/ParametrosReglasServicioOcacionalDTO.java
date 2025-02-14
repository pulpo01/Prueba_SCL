package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;


public class ParametrosReglasServicioOcacionalDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private String codigoProducto;
	private String codigoPlanTarifario;
	private String codigoActuacion;
	private String codigoArticulo;
	private String codigoUso;
	private String modalidadVenta;
	private String numeroMeses;
	private String tipoStock;
	private String indicadorComodato;
	private String esComodato;
	
	public String getCodigoActuacion() {
		return codigoActuacion;
	}

	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}

	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}

	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}

	public String getCodigoProducto() {
		return codigoProducto;
	}

	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}

	public String getCodigoArticulo() {
		return codigoArticulo;
	}

	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}

	public String getCodigoUso() {
		return codigoUso;
	}

	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}

	public String getIndicadorComodato() {
		return indicadorComodato;
	}

	public void setIndicadorComodato(String indicadorComodato) {
		this.indicadorComodato = indicadorComodato;
	}

	public String getModalidadVenta() {
		return modalidadVenta;
	}

	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}

	public String getNumeroMeses() {
		return numeroMeses;
	}

	public void setNumeroMeses(String numeroMeses) {
		this.numeroMeses = numeroMeses;
	}

	public String getTipoStock() {
		return tipoStock;
	}

	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}

	public String getEsComodato() {
		return esComodato;
	}

	public void setEsComodato(String esComodato) {
		this.esComodato = esComodato;
	}
	
}//fin ParametrosReglasServicioOcacionalDTO
