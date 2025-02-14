package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraCuentaInDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private WsStructuraClienteDTO cliente;
	
	/* Datos DTO CUENTA */
	private String codigoCuenta;

	public WsStructuraClienteDTO getCliente() {
		return cliente;
	}

	public void setCliente(WsStructuraClienteDTO cliente) {
		this.cliente = cliente;
	}

	public String getCodigoCuenta() {
		return codigoCuenta;
	}

	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
}
