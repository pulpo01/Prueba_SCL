package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsDatosProfecionalesInDTO implements Serializable{
	

	private static final long serialVersionUID = 1L;
	private String codigoActividad;
	private String nombreEmpresa;
	private String ocupacion;
	private String ingresosBrutosAnuales;
	
	
	public String getCodigoActividad() {
		return codigoActividad;
	}
	public void setCodigoActividad(String codigoActividad) {
		this.codigoActividad = codigoActividad;
	}
	public String getIngresosBrutosAnuales() {
		return ingresosBrutosAnuales;
	}
	public void setIngresosBrutosAnuales(String ingresosBrutosAnuales) {
		this.ingresosBrutosAnuales = ingresosBrutosAnuales;
	}
	public String getNombreEmpresa() {
		return nombreEmpresa;
	}
	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}
	public String getOcupacion() {
		return ocupacion;
	}
	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}

	
	

}
