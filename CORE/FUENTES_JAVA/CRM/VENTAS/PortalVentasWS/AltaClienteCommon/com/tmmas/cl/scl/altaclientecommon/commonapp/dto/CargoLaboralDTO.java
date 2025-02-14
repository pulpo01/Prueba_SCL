package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class CargoLaboralDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoOcupacion;
	private String descripcionOcupacion;
	
	public String getCodigoOcupacion() {
		return codigoOcupacion;
	}
	public void setCodigoOcupacion(String codigoOcupacion) {
		this.codigoOcupacion = codigoOcupacion;
	}
	public String getDescripcionOcupacion() {
		return descripcionOcupacion;
	}
	public void setDescripcionOcupacion(String descripcionOcupacion) {
		this.descripcionOcupacion = descripcionOcupacion;
	}
		
}//fin class OperadoraDTO