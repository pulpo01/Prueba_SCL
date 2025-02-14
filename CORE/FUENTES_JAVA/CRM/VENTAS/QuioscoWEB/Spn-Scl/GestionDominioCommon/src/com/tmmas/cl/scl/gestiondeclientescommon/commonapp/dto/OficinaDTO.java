package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class OficinaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoOficina;
	private String descripcionOficina;
	private String codigoDireccion;
	private String region;
	private String provincia;
	private String ciudad;
	private String codigoRegion;
	private String codigoProvincia;
	private String codigoCiudad;
	
	public String getCiudad() {
		return ciudad;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	public String getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(String codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getDescripcionOficina() {
		return descripcionOficina;
	}
	public void setDescripcionOficina(String descripcionOficina) {
		this.descripcionOficina = descripcionOficina;
	}
	public String getCodigoCiudad() {
		return codigoCiudad;
	}
	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
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
	
}//fin class OficinaDTO