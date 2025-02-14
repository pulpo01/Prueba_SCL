package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class DatosDireccionComputecDTO extends DatosDireccionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String descripcionCiudad;
	private String codigoTipoCalle;
	private String descripcionCalle;
	
	public String getCodigoTipoCalle() {
		return codigoTipoCalle;
	}
	public void setCodigoTipoCalle(String codigoTipoCalle) {
		this.codigoTipoCalle = codigoTipoCalle;
	}
	public String getDescripcionCalle() {
		return descripcionCalle;
	}
	public void setDescripcionCalle(String descripcionCalle) {
		this.descripcionCalle = descripcionCalle;
	}
	public String getDescripcionCiudad() {
		return descripcionCiudad;
	}
	public void setDescripcionCiudad(String descripcionCiudad) {
		this.descripcionCiudad = descripcionCiudad;
	}
	

	
}
