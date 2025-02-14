package com.tmmas.cl.scl.altacliente.presentacion.dto;

import java.io.Serializable;

public class RetornoAltaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoCuenta;
	private String codigoCliente;
	private String nombreCliente;
	
	public RetornoAltaDTO() {
		this.codigoCuenta="";
		this.codigoCliente="";
		this.nombreCliente="";
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	

}
