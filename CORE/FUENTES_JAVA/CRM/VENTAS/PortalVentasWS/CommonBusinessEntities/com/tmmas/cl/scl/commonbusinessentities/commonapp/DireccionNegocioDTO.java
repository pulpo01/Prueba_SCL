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
 * 19/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.commonbusinessentities.commonapp;

import com.tmmas.cl.scl.commonbusinessentities.interfaz.Direccion;

public class DireccionNegocioDTO implements Direccion{
	private static final long serialVersionUID = 1L;
	private String codigo;
	private String pais;
	private String provincia;
	private String region;
	private String ciudad;
	private String comuna;
	private String calle;
	private String tipoCalle;
	private String numero;
	private String piso;
	private String casilla;
	private String pueblo;
	private String observacionDescripcion;
	private String descripcionDireccion1;
	private String descripcionDireccion2;
	private String zip;
	private String estado;
	private int tipo;
	
	/*-- Busqueda de Direcciones --*/
	private String codigoSujeto;
	private int tipoSujeto;
	private int tipoDireccion;
	private int tipoDisplay;	
	
	/*-Para saber si se llamo al servicio computec para esta direccion- */
	private boolean llamadaServicioComputec;
	
	
	public boolean isLlamadaServicioComputec() {
		return llamadaServicioComputec;
	}
	public void setLlamadaServicioComputec(boolean llamadaServicioComputec) {
		this.llamadaServicioComputec = llamadaServicioComputec;
	}
	public String getCalle() {
		return calle;
	}
	public void setCalle(String calle) {
		this.calle = calle;
	}
	public String getCasilla() {
		return casilla;
	}
	public void setCasilla(String casilla) {
		this.casilla = casilla;
	}
	public String getCiudad() {
		return ciudad;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getComuna() {
		return comuna;
	}
	public void setComuna(String comuna) {
		this.comuna = comuna;
	}
	public String getDescripcionDireccion1() {
		return descripcionDireccion1;
	}
	public void setDescripcionDireccion1(String descripcionDireccion1) {
		this.descripcionDireccion1 = descripcionDireccion1;
	}
	public String getDescripcionDireccion2() {
		return descripcionDireccion2;
	}
	public void setDescripcionDireccion2(String descripcionDireccion2) {
		this.descripcionDireccion2 = descripcionDireccion2;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getObservacionDescripcion() {
		return observacionDescripcion;
	}
	public void setObservacionDescripcion(String observacionDescripcion) {
		this.observacionDescripcion = observacionDescripcion;
	}
	public String getPiso() {
		return piso;
	}
	public void setPiso(String piso) {
		this.piso = piso;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getPueblo() {
		return pueblo;
	}
	public void setPueblo(String pueblo) {
		this.pueblo = pueblo;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPais() {
		return pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getCodigoSujeto() {
		return codigoSujeto;
	}
	public void setCodigoSujeto(String codigoSujeto) {
		this.codigoSujeto = codigoSujeto;
	}
	public int getTipoDireccion() {
		return tipoDireccion;
	}
	public void setTipoDireccion(int tipoDireccion) {
		this.tipoDireccion = tipoDireccion;
	}
	public int getTipoDisplay() {
		return tipoDisplay;
	}
	public void setTipoDisplay(int tipoDisplay) {
		this.tipoDisplay = tipoDisplay;
	}
	public int getTipoSujeto() {
		return tipoSujeto;
	}
	public void setTipoSujeto(int tipoSujeto) {
		this.tipoSujeto = tipoSujeto;
	}
	public String getTipoCalle() {
		return tipoCalle;
	}
	public void setTipoCalle(String tipoCalle) {
		this.tipoCalle = tipoCalle;
	}

}
