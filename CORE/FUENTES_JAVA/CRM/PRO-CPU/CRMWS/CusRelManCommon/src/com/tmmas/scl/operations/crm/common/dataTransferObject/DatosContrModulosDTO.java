package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class DatosContrModulosDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String nivelAplicacion;
	private String numCelularContr;
	private String numCelularBenef;
	private String cantidad;
	private String codModulo;
	private String codCanal;
	private String usuario;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getNivelAplicacion() {
		return nivelAplicacion;
	}
	public void setNivelAplicacion(String nivelAplicacion) {
		this.nivelAplicacion = nivelAplicacion;
	}
	public String getNumCelularBenef() {
		return numCelularBenef;
	}
	public void setNumCelularBenef(String numCelularBenef) {
		this.numCelularBenef = numCelularBenef;
	}
	public String getNumCelularContr() {
		return numCelularContr;
	}
	public void setNumCelularContr(String numCelularContr) {
		this.numCelularContr = numCelularContr;
	}
	

	
	
}
