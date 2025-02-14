package com.tmmas.cl.scl.crmcommon.commonapp.dto;


import java.io.Serializable;

public class DetalleInformePresupuestoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String codigoArticulo;
	private String descripcionArticulo;
	private String numeroTerminal;
	private double cargos;
	private double impuestos;
	private double descuentos;
	private double total;
	private long numAbonado;
	
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
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
	public double getCargos() {
		return cargos;
	}
	public void setCargos(double cargos) {
		this.cargos = cargos;
	}

}
