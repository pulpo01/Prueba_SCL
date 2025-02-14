package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsDireccionQuioscoInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoDireccion;
	private String codigoProvincia;
	private String codigoRegion;
	private String codigoCiudad;  //codigo de ciudad
	private String codigoComuna;
	private String ZIP;	
	private String nombreCalle;
	private String numeroCalle;
	private String piso;
    private String casilla;
    private String pueblo;
    private String observacionDescripcion;
    private String descripcionDireccion1;
    private String descripcionDireccion2;
    private String estado;
    private String tipoCalle;
	
	
	public String getPiso() {
		return piso;
	}
	public void setPiso(String piso) {
		this.piso = piso;
	}
	public String getCasilla() {
		return casilla;
	}
	public void setCasilla(String casilla) {
		this.casilla = casilla;
	}
	public String getPueblo() {
		return pueblo;
	}
	public void setPueblo(String pueblo) {
		this.pueblo = pueblo;
	}
	public String getObservacionDescripcion() {
		return observacionDescripcion;
	}
	public void setObservacionDescripcion(String observacionDescripcion) {
		this.observacionDescripcion = observacionDescripcion;
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
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getTipoCalle() {
		return tipoCalle;
	}
	public void setTipoCalle(String tipoCalle) {
		this.tipoCalle = tipoCalle;
	}
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
	public String getZIP() {
		return ZIP;
	}
	public void setZIP(String zip) {
		ZIP = zip;
	}
	public String getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(String codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}
	
	
	
}
