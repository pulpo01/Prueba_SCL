package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class LineaErrorDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String codArticulo;
	private String desErrorLinea;
	private String cantidadIngresada;
	private String cantidadEsperada;
	
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getDesErrorLinea() {
		return desErrorLinea;
	}
	public void setDesErrorLinea(String desErrorLinea) {
		this.desErrorLinea = desErrorLinea;
	}
	public String getCantidadIngresada() {
		return cantidadIngresada;
	}
	public void setCantidadIngresada(String cantidadIngresada) {
		this.cantidadIngresada = cantidadIngresada;
	}
	public String getCantidadEsperada() {
		return cantidadEsperada;
	}
	public void setCantidadEsperada(String cantidadEsperada) {
		this.cantidadEsperada = cantidadEsperada;
	}
}


