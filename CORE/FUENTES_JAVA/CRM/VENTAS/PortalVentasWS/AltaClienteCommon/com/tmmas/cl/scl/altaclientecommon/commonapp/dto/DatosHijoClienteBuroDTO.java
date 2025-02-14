package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class DatosHijoClienteBuroDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	//Inicio datos Hijo
	private String nombreHijo;
	private String nombreCompletoHijo;
	private String apellido1Hijo;
	private String apellido2Hijo;
	private String codParentesco;
	private String cedulaHijo;
	private String fallecidoHijo;
	private String codFallecidoHijo;
	private String edadHijo;
	private String fecNacimientoHijo;
	private String sexoHijo;
	//Fin datos Hijo
	
	public String getApellido1Hijo() {
		return apellido1Hijo;
	}
	public void setApellido1Hijo(String apellido1Hijo) {
		this.apellido1Hijo = apellido1Hijo;
	}
	public String getApellido2Hijo() {
		return apellido2Hijo;
	}
	public void setApellido2Hijo(String apellido2Hijo) {
		this.apellido2Hijo = apellido2Hijo;
	}
	public String getCedulaHijo() {
		return cedulaHijo;
	}
	public void setCedulaHijo(String cedulaHijo) {
		this.cedulaHijo = cedulaHijo;
	}
	public String getCodFallecidoHijo() {
		return codFallecidoHijo;
	}
	public void setCodFallecidoHijo(String codFallecidoHijo) {
		this.codFallecidoHijo = codFallecidoHijo;
	}
	public String getCodParentesco() {
		return codParentesco;
	}
	public void setCodParentesco(String codParentesco) {
		this.codParentesco = codParentesco;
	}
	public String getEdadHijo() {
		return edadHijo;
	}
	public void setEdadHijo(String edadHijo) {
		this.edadHijo = edadHijo;
	}
	public String getFallecidoHijo() {
		return fallecidoHijo;
	}
	public void setFallecidoHijo(String fallecidoHijo) {
		this.fallecidoHijo = fallecidoHijo;
	}
	public String getFecNacimientoHijo() {
		return fecNacimientoHijo;
	}
	public void setFecNacimientoHijo(String fecNacimientoHijo) {
		this.fecNacimientoHijo = fecNacimientoHijo;
	}
	public String getNombreCompletoHijo() {
		return nombreCompletoHijo;
	}
	public void setNombreCompletoHijo(String nombreCompletoHijo) {
		this.nombreCompletoHijo = nombreCompletoHijo;
	}
	public String getNombreHijo() {
		return nombreHijo;
	}
	public void setNombreHijo(String nombreHijo) {
		this.nombreHijo = nombreHijo;
	}
	public String getSexoHijo() {
		return sexoHijo;
	}
	public void setSexoHijo(String sexoHijo) {
		this.sexoHijo = sexoHijo;
	}
}
