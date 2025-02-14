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
 * 08/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class InterfazCentralDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long numeroMovimiento;
	private String numeroMovtoAnterior;
	private long numeroAbonado;
	private int codigoEstado;
	private String codActabo;
	private String codigoModulo;
	private String codigoActuacion;
	private String codigoUsuario;
	private Timestamp fechaIngreso;
	private String tipoTerminal;
	private int codigoCentral;
	private long numeroCelular;
	private String numeroSerie;
	private String codigoServicio;
	private String numMin;
	private String tipoTecnologia;
	private String imsi;
	private String imei;
	private String icc;
	private String plan;
	private float valorPlan;
	private String carga;
	private long numFax;
	
	public long getNumFax() {
		return numFax;
	}
	public void setNumFax(long numFax) {
		this.numFax = numFax;
	}
	public String getNumeroMovtoAnterior() {
		return numeroMovtoAnterior;
	}
	public void setNumeroMovtoAnterior(String numeroMovtoAnterior) {
		this.numeroMovtoAnterior = numeroMovtoAnterior;
	}
	public int getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(int codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getIcc() {
		return icc;
	}
	public void setIcc(String icc) {
		this.icc = icc;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getImsi() {
		return imsi;
	}
	public void setImsi(String imsi) {
		this.imsi = imsi;
	}
	public long getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getNumMin() {
		return numMin;
	}
	public void setNumMin(String numMin) {
		this.numMin = numMin;
	}
	public String getTipoTecnologia() {
		return tipoTecnologia;
	}
	public void setTipoTecnologia(String tipoTecnologia) {
		this.tipoTecnologia = tipoTecnologia;
	}
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodigoActuacion() {
		return codigoActuacion;
	}
	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	public int getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(int codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(String codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}	
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getNumeroMovimiento() {
		return numeroMovimiento;
	}
	public void setNumeroMovimiento(long numeroMovimiento) {
		this.numeroMovimiento = numeroMovimiento;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public Timestamp getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(Timestamp fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	public String getCarga() {
		return carga;
	}
	public void setCarga(String carga) {
		this.carga = carga;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public float getValorPlan() {
		return valorPlan;
	}
	public void setValorPlan(float valorPlan) {
		this.valorPlan = valorPlan;
	}
	
	

}
