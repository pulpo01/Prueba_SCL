package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class DetalleFacturaVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String 	descripArticulo = "";
	private String 	numCantidad = "";
	private String 	serieArticulo = "";
	private String	numCelular = "";
	private Float 	precioUnitario = new Float("0");
	private double  descuentoPrecio = 0;
	
	public String getDescripArticulo() {
		return descripArticulo;
	}
	public void setDescripArticulo(String descripArticulo) {
		this.descripArticulo = descripArticulo;
	}

	public String getNumCantidad() {
		return numCantidad;
	}
	public void setNumCantidad(String numCantidad) {
		this.numCantidad = numCantidad;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}

	public Float getPrecioUnitario() {
		return precioUnitario;
	}
	public void setPrecioUnitario(Float precioUnitario) {
		this.precioUnitario = precioUnitario;
	}
	public String getSerieArticulo() {
		return serieArticulo;
	}
	public void setSerieArticulo(String serieArticulo) {
		this.serieArticulo = serieArticulo;
	}
	public double getDescuentoPrecio() {
		return descuentoPrecio;
	}
	public void setDescuentoPrecio(double descuentoPrecio) {
		this.descuentoPrecio = descuentoPrecio;
	}	
}
