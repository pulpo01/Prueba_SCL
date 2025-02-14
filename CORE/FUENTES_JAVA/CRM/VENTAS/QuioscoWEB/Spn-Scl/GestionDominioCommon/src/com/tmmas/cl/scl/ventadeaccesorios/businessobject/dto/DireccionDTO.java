package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class DireccionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoRegion;
	private String descripcionRegion;
	private String codigoProvincia;
	private String descripcionProvincia;
	private String codigoCiudad;
	private String descripcionCiudad;
	private String codigoComuna;
	private String descripcionComuna;
	private String nombreCalle;
	private String numeroCalle;
	private String zip;
	//INICIO CSR-11002
	private String numPiso;
	private String numCasilla;
	private String obsDireccion;
	private String desDirec1;
	private String desDirec2;
	private String codPueblo;
	private String codEstado;
	private String descripcionEstado;
	private String codTipoCalle;
	private String descripcionTipoCalle;
	//FIN CSR-11002
	
	public String getCodigoCiudad() {
		return codigoCiudad;
	}
	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
	}
	public String getCodigoComuna() {
		return codigoComuna;
	}
	public void setCodigoComuna(String codigoComuna) {
		this.codigoComuna = codigoComuna;
	}
	public String getCodigoProvincia() {
		return codigoProvincia;
	}
	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
	}
	public String getDescripcionCiudad() {
		return descripcionCiudad;
	}
	public void setDescripcionCiudad(String descripcionCiudad) {
		this.descripcionCiudad = descripcionCiudad;
	}
	public String getDescripcionComuna() {
		return descripcionComuna;
	}
	public void setDescripcionComuna(String descripcionComuna) {
		this.descripcionComuna = descripcionComuna;
	}
	public String getDescripcionProvincia() {
		return descripcionProvincia;
	}
	public void setDescripcionProvincia(String descripcionProvincia) {
		this.descripcionProvincia = descripcionProvincia;
	}
	public String getDescripcionRegion() {
		return descripcionRegion;
	}
	public void setDescripcionRegion(String descripcionRegion) {
		this.descripcionRegion = descripcionRegion;
	}
	public String getNombreCalle() {
		return nombreCalle;
	}
	public void setNombreCalle(String nombreCalle) {
		this.nombreCalle = nombreCalle;
	}
	public String getNumeroCalle() {
		return numeroCalle;
	}
	public void setNumeroCalle(String numeroCalle) {
		this.numeroCalle = numeroCalle;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodPueblo() {
		return codPueblo;
	}
	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}
	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}
	public String getDesDirec1() {
		return desDirec1;
	}
	public void setDesDirec1(String desDirec1) {
		this.desDirec1 = desDirec1;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
	public String getNumCasilla() {
		return numCasilla;
	}
	public void setNumCasilla(String numCasilla) {
		this.numCasilla = numCasilla;
	}
	public String getNumPiso() {
		return numPiso;
	}
	public void setNumPiso(String numPiso) {
		this.numPiso = numPiso;
	}
	public String getObsDireccion() {
		return obsDireccion;
	}
	public void setObsDireccion(String obsDireccion) {
		this.obsDireccion = obsDireccion;
	}
	public String getDescripcionEstado() {
		return descripcionEstado;
	}
	public void setDescripcionEstado(String descripcionEstado) {
		this.descripcionEstado = descripcionEstado;
	}
	public String getDescripcionTipoCalle() {
		return descripcionTipoCalle;
	}
	public void setDescripcionTipoCalle(String descripcionTipoCalle) {
		this.descripcionTipoCalle = descripcionTipoCalle;
	}
	
}
