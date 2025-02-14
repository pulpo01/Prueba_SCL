package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class ProfesionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoActividad;
	private String descripcionActividad;
	
	public String getCodigoActividad() {
		return codigoActividad;
	}
	public void setCodigoActividad(String codigoActividad) {
		this.codigoActividad = codigoActividad;
	}
	public String getDescripcionActividad() {
		return descripcionActividad;
	}
	public void setDescripcionActividad(String descripcionActividad) {
		this.descripcionActividad = descripcionActividad;
	}
		
}//fin class OperadoraDTO