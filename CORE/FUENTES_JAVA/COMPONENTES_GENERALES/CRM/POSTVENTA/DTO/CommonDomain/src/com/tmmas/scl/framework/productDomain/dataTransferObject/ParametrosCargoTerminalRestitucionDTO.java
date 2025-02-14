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

public class ParametrosCargoTerminalRestitucionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String tipoStock;
	private String codigoArticulo;
	private String numeroSerie;
	private String codigoUso;
	private String estado;
	private long numAbonado;	
	private String modalidadVenta;
	
	private String indiceRecambio;
	private String codigoCategoria;
	private String tipoContrato;
	private String planTarifario;
	private String codigoUsoPrepago;
	private String indicadorEquipo;
	
	private String paramRenova; 	// INI P-MIX-09003 OCB;
	
	//CSR-11003
	private Integer codigoAntiguedad;
	private Integer numMeses;
	private String nombreUsuario;
	private Integer promoCelular;
	
	public Integer getCodigoAntiguedad() {
		return codigoAntiguedad;
	}
	public void setCodigoAntiguedad(Integer codigoAntiguedad) {
		this.codigoAntiguedad = codigoAntiguedad;
	}
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
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
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
	public Integer getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(Integer numMeses) {
		this.numMeses = numMeses;
	}
	public String getParamRenova() {
		return paramRenova;
	}
	public void setParamRenova(String paramRenova) {
		this.paramRenova = paramRenova;
	}
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	public Integer getPromoCelular() {
		return promoCelular;
	}
	public void setPromoCelular(Integer promoCelular) {
		this.promoCelular = promoCelular;
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
	
	//CSR-11003

	
	
}//fin ParametrosCargoTerminalDTO
