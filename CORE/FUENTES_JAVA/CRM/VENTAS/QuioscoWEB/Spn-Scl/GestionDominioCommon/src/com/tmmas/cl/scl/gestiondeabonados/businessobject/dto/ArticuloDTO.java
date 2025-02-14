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
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

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
	private String numeroTransaccion;
	
	/*-- Actualiza Stock --*/
	private String numeroMovimiento;
	private String tipoMovimiento;
	private String numeroVenta;
	private long cantStock;
	private String indRecambio;
	private String codCategoria;
	private long numMeses;
	private long codPromedio;
	private long codAntiguedad;
	private long codModVenta;
	private long codVendedor;
	private String tipTerminal;
	private String codTecnologia;
	private String codCentral;
	private String codHLR;
	private String codPlaza;
	private String codSubAlm;
	
	public String getCodSubAlm() {
		return codSubAlm;
	}
	public void setCodSubAlm(String codSubAlm) {
		this.codSubAlm = codSubAlm;
	}
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
	}
	public String getCodHLR() {
		return codHLR;
	}
	public void setCodHLR(String codHLR) {
		this.codHLR = codHLR;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(long codModVenta) {
		this.codModVenta = codModVenta;
	}
	public long getCodAntiguedad() {
		return codAntiguedad;
	}
	public void setCodAntiguedad(long codAntiguedad) {
		this.codAntiguedad = codAntiguedad;
	}
	public long getCodPromedio() {
		return codPromedio;
	}
	public void setCodPromedio(long codPromedio) {
		this.codPromedio = codPromedio;
	}
	public long getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(long numMeses) {
		this.numMeses = numMeses;
	}
	public String getIndRecambio() {
		return indRecambio;
	}
	public void setIndRecambio(String indRecambio) {
		this.indRecambio = indRecambio;
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
	public String getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(String numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
	}
	public long getCantStock() {
		return cantStock;
	}
	public void setCantStock(long cantStock) {
		this.cantStock = cantStock;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
}
