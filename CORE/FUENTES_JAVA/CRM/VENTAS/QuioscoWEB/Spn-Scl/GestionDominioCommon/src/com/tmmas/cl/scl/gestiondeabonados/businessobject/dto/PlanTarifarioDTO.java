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
 * 16/03/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class PlanTarifarioDTO implements Serializable{
	
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
	private float importeCargoBasico;
	private String codigoMonedaCargoBasico;
    private String codigoConcepto;
	private String descripcionConcepto;
	private String codigoCategoria;
	private int indFamiliar;
	
    /*-- Limite de Consumo --*/
	private String formatoFecha1; 
	private String formatoFecha2; 
	private String descripcionLimiteConsumo;
	private double importeLimite;
	private String indicadorUnidades;
	private String indicadorDefault;
	private String fechaDesde;
	private String fechaHasta;

    /*-- Indicadore Comercializable --*/
	private int indicadorComercializable;

    /*-- Para consulta en evaluacion de riesgo --*/
	private String codigoTipoIdentificador;
	private String numeroIdentificador;
	private String numeroSolicitud;
	private String tipoSolicitud;
	private int numeroAbonados;
	private String planComverse;
	
	public String getTipoSolicitud() {
		return tipoSolicitud;
	}
	public void setTipoSolicitud(String tipoSolicitud) {
		this.tipoSolicitud = tipoSolicitud;
	}
	public String getCodigoTipoIdentificador() {
		return codigoTipoIdentificador;
	}
	public void setCodigoTipoIdentificador(String codigoTipoIdentificador) {
		this.codigoTipoIdentificador = codigoTipoIdentificador;
	}
	public String getNumeroIdentificador() {
		return numeroIdentificador;
	}
	public void setNumeroIdentificador(String numeroIdentificador) {
		this.numeroIdentificador = numeroIdentificador;
	}
	public String getNumeroSolicitud() {
		return numeroSolicitud;
	}
	public void setNumeroSolicitud(String numeroSolicitud) {
		this.numeroSolicitud = numeroSolicitud;
	}
	public int getIndicadorComercializable() {
		return indicadorComercializable;
	}
	public void setIndicadorComercializable(int indicadorComercializable) {
		this.indicadorComercializable = indicadorComercializable;
	}
	public String getCodigoMonedaCargoBasico() {
		return codigoMonedaCargoBasico;
	}
	public void setCodigoMonedaCargoBasico(String codigoMonedaCargoBasico) {
		this.codigoMonedaCargoBasico = codigoMonedaCargoBasico;
	}
	public String getDescripcionCargoBasico() {
		return descripcionCargoBasico;
	}
	public void setDescripcionCargoBasico(String descripcionCargoBasico) {
		this.descripcionCargoBasico = descripcionCargoBasico;
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
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}
	public float getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(float importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
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
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}
	public String getIndicadorCargoHabilitacion() {
		return indicadorCargoHabilitacion;
	}
	public void setIndicadorCargoHabilitacion(String indicadorCargoHabilitacion) {
		this.indicadorCargoHabilitacion = indicadorCargoHabilitacion;
	}
	public String getCodigoTipoPlan() {
		return codigoTipoPlan;
	}
	public void setCodigoTipoPlan(String codigoTipoPlan) {
		this.codigoTipoPlan = codigoTipoPlan;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getDescripcionLimiteConsumo() {
		return descripcionLimiteConsumo;
	}
	public void setDescripcionLimiteConsumo(String descripcionLimiteConsumo) {
		this.descripcionLimiteConsumo = descripcionLimiteConsumo;
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
	public double getImporteLimite() {
		return importeLimite;
	}
	public void setImporteLimite(double importeLimite) {
		this.importeLimite = importeLimite;
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
	public int getIndFamiliar() {
		return indFamiliar;
	}
	public void setIndFamiliar(int indFamiliar) {
		this.indFamiliar = indFamiliar;
	}
	public String getDescripcionPlanTarifario() {
		return descripcionPlanTarifario;
	}
	public void setDescripcionPlanTarifario(String descripcionPlanTarifario) {
		this.descripcionPlanTarifario = descripcionPlanTarifario;
	}
	public int getNumeroAbonados() {
		return numeroAbonados;
	}
	public void setNumeroAbonados(int numeroAbonados) {
		this.numeroAbonados = numeroAbonados;
	}
	public String getPlanComverse() {
		return planComverse;
	}
	public void setPlanComverse(String planComverse) {
		this.planComverse = planComverse;
	}
	

}
