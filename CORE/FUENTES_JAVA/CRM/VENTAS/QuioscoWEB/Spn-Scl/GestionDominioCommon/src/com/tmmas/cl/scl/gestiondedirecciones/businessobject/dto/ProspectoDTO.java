package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

import java.io.Serializable;

public class ProspectoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int codigoProspecto;
	
	/*-- Prospecto Cliente --*/
	private String codigoTipoIdent;
    private String numeroIdent;
    private String nombre;
    private String apellido1;
    private String apellido2;
    private String numeroTelefono1;
    private String numeroTelefono2;
    private String numeroFax;
    private String nombreReprLegal;
    private String codigoTipoIdentRepr;
    private String numeroIdentRepr;
	private int    codigoRubro;
 	private String codigoBanco;
	private String numeroCuenta;
	private String codigoTipotarjeta;
	private String numeroTarjeta;

	/*-- Prospecto Direccion --*/
	private String tipoDireccion;
	private int codigoDireccion;
	
	public int getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(int codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}
	public int getCodigoProspecto() {
		return codigoProspecto;
	}
	public void setCodigoProspecto(int codigoProspecto) {
		this.codigoProspecto = codigoProspecto;
	}
	public String getTipoDireccion() {
		return tipoDireccion;
	}
	public void setTipoDireccion(String tipoDireccion) {
		this.tipoDireccion = tipoDireccion;
	}
	public String getCodigoBanco() {
		return codigoBanco;
	}
	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}
	public int getCodigoRubro() {
		return codigoRubro;
	}
	public void setCodigoRubro(int codigoRubro) {
		this.codigoRubro = codigoRubro;
	}
	public String getCodigoTipoIdent() {
		return codigoTipoIdent;
	}
	public void setCodigoTipoIdent(String codigoTipoIdent) {
		this.codigoTipoIdent = codigoTipoIdent;
	}
	public String getCodigoTipoIdentRepr() {
		return codigoTipoIdentRepr;
	}
	public void setCodigoTipoIdentRepr(String codigoTipoIdentRepr) {
		this.codigoTipoIdentRepr = codigoTipoIdentRepr;
	}
	public String getCodigoTipotarjeta() {
		return codigoTipotarjeta;
	}
	public void setCodigoTipotarjeta(String codigoTipotarjeta) {
		this.codigoTipotarjeta = codigoTipotarjeta;
	}
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNombreReprLegal() {
		return nombreReprLegal;
	}
	public void setNombreReprLegal(String nombreReprLegal) {
		this.nombreReprLegal = nombreReprLegal;
	}
	public String getNumeroCuenta() {
		return numeroCuenta;
	}
	public void setNumeroCuenta(String numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}
	public String getNumeroFax() {
		return numeroFax;
	}
	public void setNumeroFax(String numeroFax) {
		this.numeroFax = numeroFax;
	}
	public String getNumeroIdent() {
		return numeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		this.numeroIdent = numeroIdent;
	}
	public String getNumeroIdentRepr() {
		return numeroIdentRepr;
	}
	public void setNumeroIdentRepr(String numeroIdentRepr) {
		this.numeroIdentRepr = numeroIdentRepr;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public String getNumeroTelefono1() {
		return numeroTelefono1;
	}
	public void setNumeroTelefono1(String numeroTelefono1) {
		this.numeroTelefono1 = numeroTelefono1;
	}
	public String getNumeroTelefono2() {
		return numeroTelefono2;
	}
	public void setNumeroTelefono2(String numeroTelefono2) {
		this.numeroTelefono2 = numeroTelefono2;
	}
	
}//fin class ProspectoDTO
