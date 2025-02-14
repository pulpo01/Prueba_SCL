package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

//TODO: Observacion : En ecuador esta clase toma el nombre de Direccion 

public class DireccionDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigo;
	private String provincia;
	private String region;
	private String ciudad;
	private String comuna;
	private String calle;
	private String numero;
	private String piso;
	private String casilla;
	private String pueblo;
	private String observacionDescripcion;
	private String descripcionDireccion1;
	private String descripcionDireccion2;
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

}
