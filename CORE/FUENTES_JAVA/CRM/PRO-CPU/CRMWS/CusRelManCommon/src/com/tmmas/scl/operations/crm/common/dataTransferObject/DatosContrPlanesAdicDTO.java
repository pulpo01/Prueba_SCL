package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class DatosContrPlanesAdicDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String numCelular;
	private String nivelAplicacion;
	private String codCanal;
	private String numVenta;
	private String numCelularBenef;
	private String[] listaProductos;
	
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}
	public String getNumCelularBenef() {
		return numCelularBenef;
	}
	public void setNumCelularBenef(String numCelularBenef) {
		this.numCelularBenef = numCelularBenef;
	}
	public String[] getListaProductos() {
		return listaProductos;
	}
	public void setListaProductos(String[] listaProductos) {
		this.listaProductos = listaProductos;
	}
	public String getNivelAplicacion() {
		return nivelAplicacion;
	}
	public void setNivelAplicacion(String nivelAplicacion) {
		this.nivelAplicacion = nivelAplicacion;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	
		
}
