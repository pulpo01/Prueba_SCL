package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

public class WsAltaCuentaSubCuentaInDTO implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String descripcionCuenta;
    private String tipoDeCuenta; /* (P = Particular, E = Empresa)*/
    private String nombreResponsable;
    private String tipoDeIdentificacion;
    private String numeroIdentificacion;
    private String codigoDireccion;
    private String categoriaTributaria;
    private String codigoComisionista1raVenta;
    private String fechaNacimiento;
    private String codigoClasificacion;
    private String telefonoContacto;
    private String codigoCategoria;
    
    
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoClasificacion() {
		return codigoClasificacion;
	}
	public void setCodigoClasificacion(String codigoClasificacion) {
		this.codigoClasificacion = codigoClasificacion;
	}
	public String getCodigoComisionista1raVenta() {
		return codigoComisionista1raVenta;
	}
	public void setCodigoComisionista1raVenta(String codigoComisionista1raVenta) {
		this.codigoComisionista1raVenta = codigoComisionista1raVenta;
	}
	public String getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(String codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}
	public String getDescripcionCuenta() {
		return descripcionCuenta;
	}
	public void setDescripcionCuenta(String descripcionCuenta) {
		this.descripcionCuenta = descripcionCuenta;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getNombreResponsable() {
		return nombreResponsable;
	}
	public void setNombreResponsable(String nombreResponsable) {
		this.nombreResponsable = nombreResponsable;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getTelefonoContacto() {
		return telefonoContacto;
	}
	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}
	public String getTipoDeCuenta() {
		return tipoDeCuenta;
	}
	public void setTipoDeCuenta(String tipoDeCuenta) {
		this.tipoDeCuenta = tipoDeCuenta;
	}
	public String getTipoDeIdentificacion() {
		return tipoDeIdentificacion;
	}
	public void setTipoDeIdentificacion(String tipoDeIdentificacion) {
		this.tipoDeIdentificacion = tipoDeIdentificacion;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
}
