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

public class ParametrosCargoKitDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String numeroSerie;
	private String codigoArticulo;
	private String codigoUso;
	private String tipoStock;
	private String estado;
	private String modalidadVenta;
	private String tipoContrato;
	private String planTarifario;
	private String indiceRecambio;
	private String codigoCategoria;
	private String codigoUsoPrepago;
	private String indicadorEquipo;
	private long numAbonado;
	
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
	public String getCodigoUsoPrepago() {
		return codigoUsoPrepago;
	}
	public void setCodigoUsoPrepago(String codigoUsoPrepago) {
		this.codigoUsoPrepago = codigoUsoPrepago;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getIndicadorEquipo() {
		return indicadorEquipo;
	}
	public void setIndicadorEquipo(String indicadorEquipo) {
		this.indicadorEquipo = indicadorEquipo;
	}
	public String getIndiceRecambio() {
		return indiceRecambio;
	}
	public void setIndiceRecambio(String indiceRecambio) {
		this.indiceRecambio = indiceRecambio;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
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
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	
	
}
