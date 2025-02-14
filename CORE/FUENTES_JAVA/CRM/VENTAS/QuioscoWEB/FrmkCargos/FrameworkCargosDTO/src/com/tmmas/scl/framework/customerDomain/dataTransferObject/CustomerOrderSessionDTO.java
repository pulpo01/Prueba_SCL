package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CustomerOrderSessionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String nombres;
	private long numeroOrdenServicio;
	private long codigoCliente;
	
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public long getNumeroOrdenServicio() {
		return numeroOrdenServicio;
	}
	public void setNumeroOrdenServicio(long numeroOrdenServicio) {
		this.numeroOrdenServicio = numeroOrdenServicio;
	}
	

}
