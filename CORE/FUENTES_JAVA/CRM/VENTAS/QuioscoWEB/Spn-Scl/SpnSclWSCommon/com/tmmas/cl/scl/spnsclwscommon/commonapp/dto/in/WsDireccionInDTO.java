package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsDireccionInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
		
	private String codigoProvincia;
	private String codigoRegion;
	private String codigoCanton;  //codigo de ciudad
	private String codigoComuna;
	private String nombreCalle;
	private String numeroCalle;
	private String numeroPiso;
	private String numeroCasilla;
	private String observacionDireccion;
	private String descripcionDireccion1;
	private String descripcionDireccion2;
	private String codigoPueblo;
	private String codigoEstado;
	private String ZIP;
	private int tipoDireccion;
	
	
	
	public int getTipoDireccion() {
		return tipoDireccion;
	}
	public void setTipoDireccion(int tipoDireccion) {
		this.tipoDireccion = tipoDireccion;
	}
	public String getCodigoCanton() {
		return codigoCanton;
	}
	public void setCodigoCanton(String codigoCanton) {
		this.codigoCanton = codigoCanton;
	}
	public String getCodigoComuna() {
		return codigoComuna;
	}
	public void setCodigoComuna(String codigoComuna) {
		this.codigoComuna = codigoComuna;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getCodigoProvincia() {
		return codigoProvincia;
	}
	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}
	public String getCodigoPueblo() {
		return codigoPueblo;
	}
	public void setCodigoPueblo(String codigoPueblo) {
		this.codigoPueblo = codigoPueblo;
	}
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
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
	public String getNumeroCasilla() {
		return numeroCasilla;
	}
	public void setNumeroCasilla(String numeroCasilla) {
		this.numeroCasilla = numeroCasilla;
	}
	public String getNumeroPiso() {
		return numeroPiso;
	}
	public void setNumeroPiso(String numeroPiso) {
		this.numeroPiso = numeroPiso;
	}
	public String getObservacionDireccion() {
		return observacionDireccion;
	}
	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}
	public String getZIP() {
		return ZIP;
	}
	public void setZIP(String zip) {
		ZIP = zip;
	}	
	
	
	

}
