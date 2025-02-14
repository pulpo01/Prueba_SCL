package com.tmmas.cl.scl.direccioncommon.commonapp.dto;

import java.io.Serializable;

public class DireccionOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String cod_tipdireccion;
	private String des_tipdireccion;	
	private String cod_provincia;
	private String des_provincia;	
	private String cod_ciudad;
	private String des_ciudad;	
	private String direccion;
	private String observacion;
	
	private String cod_region;
	private String des_region;
	private String cod_comuna;
	private String des_comuna;
	private String cod_tipoCalle;
	private String des_tipoCalle;
	
	public String getDes_tipoCalle() {
		return des_tipoCalle;
	}
	public void setDes_tipoCalle(String des_tipoCalle) {
		this.des_tipoCalle = des_tipoCalle;
	}
	public String getCod_ciudad() {
		return cod_ciudad;
	}
	public void setCod_ciudad(String cod_ciudad) {
		this.cod_ciudad = cod_ciudad;
	}	
	public String getCod_provincia() {
		return cod_provincia;
	}
	public void setCod_provincia(String cod_provincia) {
		this.cod_provincia = cod_provincia;
	}
	public String getCod_tipdireccion() {
		return cod_tipdireccion;
	}
	public void setCod_tipdireccion(String cod_tipdireccion) {
		this.cod_tipdireccion = cod_tipdireccion;
	}
	public String getDes_ciudad() {
		return des_ciudad;
	}
	public void setDes_ciudad(String des_ciudad) {
		this.des_ciudad = des_ciudad;
	}
	public String getDes_provincia() {
		return des_provincia;
	}
	public void setDes_provincia(String des_provincia) {
		this.des_provincia = des_provincia;
	}
	public String getDes_tipdireccion() {
		return des_tipdireccion;
	}
	public void setDes_tipdireccion(String des_tipdireccion) {
		this.des_tipdireccion = des_tipdireccion;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public String getCod_comuna() {
		return cod_comuna;
	}
	public void setCod_comuna(String cod_comuna) {
		this.cod_comuna = cod_comuna;
	}
	public String getCod_region() {
		return cod_region;
	}
	public void setCod_region(String cod_region) {
		this.cod_region = cod_region;
	}
	public String getCod_tipoCalle() {
		return cod_tipoCalle;
	}
	public void setCod_tipoCalle(String cod_tipoCalle) {
		this.cod_tipoCalle = cod_tipoCalle;
	}
	public String getDes_comuna() {
		return des_comuna;
	}
	public void setDes_comuna(String des_comuna) {
		this.des_comuna = des_comuna;
	}
	public String getDes_region() {
		return des_region;
	}
	public void setDes_region(String des_region) {
		this.des_region = des_region;
	}
	
}
