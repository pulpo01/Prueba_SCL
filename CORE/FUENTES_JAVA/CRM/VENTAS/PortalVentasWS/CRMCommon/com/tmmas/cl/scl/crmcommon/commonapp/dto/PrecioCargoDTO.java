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
 * 09/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class PrecioCargoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private float monto;
	private String codigoConcepto;
	private String descripcionConcepto;
	private String codigoMoneda;
	private String descripcionMoneda;
	private String FechaAplicacion;

	private String valorMinimo;
	private String valorMaximo;

	//VALORES CONSTANTES EN QUERY
	private String indicadorAutMan;
	private String numeroUnidades;
	private String indicadorEquipo;
	private String indicadorPaquete;
	private String mesGarantia;
	private String indicadorAccesorio;
	private String codigoArticulo;
	private String codigoStock;
	private String codigoEstado;	
	private String indiceVenta;
	private String tipoCobro; //A:Adelantado - V:Vencido
	
	public String getTipoCobro() {
		return tipoCobro;
	}
	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}
	public String getIndiceVenta() {
		return indiceVenta;
	}
	public void setIndiceVenta(String indiceVenta) {
		this.indiceVenta = indiceVenta;
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
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public String getDescripcionMoneda() {
		return descripcionMoneda;
	}
	public void setDescripcionMoneda(String descripcionMoneda) {
		this.descripcionMoneda = descripcionMoneda;
	}
	public String getFechaAplicacion() {
		return FechaAplicacion;
	}
	public void setFechaAplicacion(String fechaAplicacion) {
		FechaAplicacion = fechaAplicacion;
	}
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getCodigoStock() {
		return codigoStock;
	}
	public void setCodigoStock(String codigoStock) {
		this.codigoStock = codigoStock;
	}
	public String getIndicadorAccesorio() {
		return indicadorAccesorio;
	}
	public void setIndicadorAccesorio(String indicadorAccesorio) {
		this.indicadorAccesorio = indicadorAccesorio;
	}
	public String getIndicadorAutMan() {
		return indicadorAutMan;
	}
	public void setIndicadorAutMan(String indicadorAutMan) {
		this.indicadorAutMan = indicadorAutMan;
	}
	public String getIndicadorEquipo() {
		return indicadorEquipo;
	}
	public void setIndicadorEquipo(String indicadorEquipo) {
		this.indicadorEquipo = indicadorEquipo;
	}
	public String getIndicadorPaquete() {
		return indicadorPaquete;
	}
	public void setIndicadorPaquete(String indicadorPaquete) {
		this.indicadorPaquete = indicadorPaquete;
	}
	public String getMesGarantia() {
		return mesGarantia;
	}
	public void setMesGarantia(String mesGarantia) {
		this.mesGarantia = mesGarantia;
	}
	public String getNumeroUnidades() {
		return numeroUnidades;
	}
	public void setNumeroUnidades(String numeroUnidades) {
		this.numeroUnidades = numeroUnidades;
	}
	public String getValorMaximo() {
		return valorMaximo;
	}
	public void setValorMaximo(String valorMaximo) {
		this.valorMaximo = valorMaximo;
	}
	public String getValorMinimo() {
		return valorMinimo;
	}
	public void setValorMinimo(String valorMinimo) {
		this.valorMinimo = valorMinimo;
	}

}
