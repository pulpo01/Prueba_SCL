package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class DetallePresupuestoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String codigoArticulo;
	private String descripcionArticulo;
	private double cargo;
	private double impuestos;
	private double descuentos;
	private String numeroTerminal;
	
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getDescripcionArticulo() {
		return descripcionArticulo;
	}
	public void setDescripcionArticulo(String descripcionArticulo) {
		this.descripcionArticulo = descripcionArticulo;
	}	
	public String getNumeroTerminal() {
		return numeroTerminal;
	}
	public void setNumeroTerminal(String numeroTerminal) {
		this.numeroTerminal = numeroTerminal;
	}
	public double getDescuentos() {
		return descuentos;
	}
	public void setDescuentos(double descuentos) {
		this.descuentos = descuentos;
	}
	public double getImpuestos() {
		return impuestos;
	}
	public void setImpuestos(double impuestos) {
		this.impuestos = impuestos;
	}
	public double getCargo() {
		return cargo;
	}
	public void setCargo(double cargo) {
		this.cargo = cargo;
	}

}
