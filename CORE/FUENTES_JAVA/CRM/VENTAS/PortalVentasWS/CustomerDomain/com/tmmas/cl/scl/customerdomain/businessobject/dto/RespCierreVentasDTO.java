package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class RespCierreVentasDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long numVenta;
	private String numContrato;//
	private String nombreCliente;
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
}
