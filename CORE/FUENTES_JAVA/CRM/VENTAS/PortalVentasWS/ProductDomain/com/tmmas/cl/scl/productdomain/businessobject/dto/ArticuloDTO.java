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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ArticuloDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private long  codigo;
	private String descripcion;
	private String tipo;
	private int codigoConceptoArticulo;
	private String codigoConceptoDescuento;
	
	/*-- Reserva de Articulos --*/
	private int numeroLinea;
	private int numeroOrden;
	private int codigoProducto;
	private int tipoStock;
	private int codigoUso;
	private int codigoEstado;
	private int codigoBodega;
	private String nombreUsuario;
	private String numeroSerie;
	
	/*-- Actualiza Stock --*/
	private String numeroMovimiento;
	private String tipoMovimiento;
	private String numeroVenta;
	
	/*-- MAYORISTA --*/
	private String indicadorValorar;
	private String descripcionUso;
		
	public String getDescripcionUso() {
		return descripcionUso;
	}
	public void setDescripcionUso(String descripcionUso) {
		this.descripcionUso = descripcionUso;
	}
	public String getIndicadorValorar() {
		return indicadorValorar;
	}
	public void setIndicadorValorar(String indicadorValorar) {
		this.indicadorValorar = indicadorValorar;
	}
	public int getCodigoConceptoArticulo() {
		return codigoConceptoArticulo;
	}
	public void setCodigoConceptoArticulo(int codigoConceptoArticulo) {
		this.codigoConceptoArticulo = codigoConceptoArticulo;
	}
	public long getCodigo() {
		return codigo;
	}
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public int getNumeroLinea() {
		return numeroLinea;
	}
	public void setNumeroLinea(int numeroLinea) {
		this.numeroLinea = numeroLinea;
	}
	public int getNumeroOrden() {
		return numeroOrden;
	}
	public void setNumeroOrden(int numeroOrden) {
		this.numeroOrden = numeroOrden;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public int getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(int codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public int getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(int codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public int getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(int codigoUso) {
		this.codigoUso = codigoUso;
	}
	public int getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(int tipoStock) {
		this.tipoStock = tipoStock;
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
	public String getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(String codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
}
