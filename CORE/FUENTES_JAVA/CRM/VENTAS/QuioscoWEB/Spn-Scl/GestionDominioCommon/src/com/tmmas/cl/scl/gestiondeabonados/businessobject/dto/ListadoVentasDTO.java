/* Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;


public class ListadoVentasDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long codigoVendedor;
	private String descVendedor;
	private String nombreVendedor;
	private String fechaDesde;
	private String fechaHasta;
	private Long nroVenta;
	private String fechaVenta;
	private String codOficina;
	private String descOficina;
	private Long cantidadVendida;
	private Long monto;
	
	
	public Long getCantidadVendida() {
		return cantidadVendida;
	}
	public void setCantidadVendida(Long cantidadVendida) {
		this.cantidadVendida = cantidadVendida;
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
	public String getFechaVenta() {
		return fechaVenta;
	}
	public void setFechaVenta(String fechaVenta) {
		this.fechaVenta = fechaVenta;
	}
	public Long getMonto() {
		return monto;
	}
	public void setMonto(Long monto) {
		this.monto = monto;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public Long getNroVenta() {
		return nroVenta;
	}
	public void setNroVenta(Long nroVenta) {
		this.nroVenta = nroVenta;
	}	
	public Long getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(Long codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	
	
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getDescOficina() {
		return descOficina;
	}
	public void setDescOficina(String descOficina) {
		this.descOficina = descOficina;
	}
	public String getDescVendedor() {
		return descVendedor;
	}
	public void setDescVendedor(String descVendedor) {
		this.descVendedor = descVendedor;
	}
	
	
}