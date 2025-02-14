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
 * 12/06/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class PlanTarifarioComDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int numDias;
	private String codigoLimiteConsumo;
	private String tipoPlanTarifario;
	private String codigoPlanServicio;
	private String codigoPlanTarifario;
	private String descripcionPlanTarifario;
	private String codigoProducto;
	private String codigoTecnologia;
	private String indicadorCargoHabilitacion;
	private String codigoTipoPlan;
	private String codigoCargoBasico;
	private String descripcionCargoBasico;
	private double importeCargoBasico;
	private float impFinal;
	private String codigoMonedaCargoBasico;
    private String codigoConcepto;
	private String descripcionConcepto;
	private String codigoCategoria;
	
    /*-- Limite de Consumo --*/
	private String formatoFecha1; 
	private String formatoFecha2; 
	private String descripcionLimiteConsumo;
	private double importeLimite;
	private String indicadorUnidades;
	private String indicadorDefault;
	private String fechaDesde;
	private String fechaHasta;
	
	/*--Identifica si el valor es por defecto--*/
    private int valorPorDefecto;
    
    private String codigoCliente;
    
   	//Limite consumo
   	private double montoMinimo;
   	private double montoMaximo;
   	private int flgCorte;
	private double montoCons;
	
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}
	public String getCodigoMonedaCargoBasico() {
		return codigoMonedaCargoBasico;
	}
	public void setCodigoMonedaCargoBasico(String codigoMonedaCargoBasico) {
		this.codigoMonedaCargoBasico = codigoMonedaCargoBasico;
	}
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
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
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoTipoPlan() {
		return codigoTipoPlan;
	}
	public void setCodigoTipoPlan(String codigoTipoPlan) {
		this.codigoTipoPlan = codigoTipoPlan;
	}
	public String getDescripcionCargoBasico() {
		return descripcionCargoBasico;
	}
	public void setDescripcionCargoBasico(String descripcionCargoBasico) {
		this.descripcionCargoBasico = descripcionCargoBasico;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}
	public String getDescripcionLimiteConsumo() {
		return descripcionLimiteConsumo;
	}
	public void setDescripcionLimiteConsumo(String descripcionLimiteConsumo) {
		this.descripcionLimiteConsumo = descripcionLimiteConsumo;
	}
	public String getDescripcionPlanTarifario() {
		return descripcionPlanTarifario;
	}
	public void setDescripcionPlanTarifario(String descripcionPlanTarifario) {
		this.descripcionPlanTarifario = descripcionPlanTarifario;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public int getFlgCorte() {
		return flgCorte;
	}
	public void setFlgCorte(int flgCorte) {
		this.flgCorte = flgCorte;
	}
	public String getFormatoFecha1() {
		return formatoFecha1;
	}
	public void setFormatoFecha1(String formatoFecha1) {
		this.formatoFecha1 = formatoFecha1;
	}
	public String getFormatoFecha2() {
		return formatoFecha2;
	}
	public void setFormatoFecha2(String formatoFecha2) {
		this.formatoFecha2 = formatoFecha2;
	}
	public float getImpFinal() {
		return impFinal;
	}
	public void setImpFinal(float impFinal) {
		this.impFinal = impFinal;
	}
	public double getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}
	public double getImporteLimite() {
		return importeLimite;
	}
	public void setImporteLimite(double importeLimite) {
		this.importeLimite = importeLimite;
	}
	public String getIndicadorCargoHabilitacion() {
		return indicadorCargoHabilitacion;
	}
	public void setIndicadorCargoHabilitacion(String indicadorCargoHabilitacion) {
		this.indicadorCargoHabilitacion = indicadorCargoHabilitacion;
	}
	public String getIndicadorDefault() {
		return indicadorDefault;
	}
	public void setIndicadorDefault(String indicadorDefault) {
		this.indicadorDefault = indicadorDefault;
	}
	public String getIndicadorUnidades() {
		return indicadorUnidades;
	}
	public void setIndicadorUnidades(String indicadorUnidades) {
		this.indicadorUnidades = indicadorUnidades;
	}
	public double getMontoCons() {
		return montoCons;
	}
	public void setMontoCons(double montoCons) {
		this.montoCons = montoCons;
	}
	public double getMontoMaximo() {
		return montoMaximo;
	}
	public void setMontoMaximo(double montoMaximo) {
		this.montoMaximo = montoMaximo;
	}
	public double getMontoMinimo() {
		return montoMinimo;
	}
	public void setMontoMinimo(double montoMinimo) {
		this.montoMinimo = montoMinimo;
	}
	public int getNumDias() {
		return numDias;
	}
	public void setNumDias(int numDias) {
		this.numDias = numDias;
	}
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public int getValorPorDefecto() {
		return valorPorDefecto;
	}
	public void setValorPorDefecto(int valorPorDefecto) {
		this.valorPorDefecto = valorPorDefecto;
	}
	

}
