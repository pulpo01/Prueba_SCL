package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class ResultadoSolicitudVentaDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String numeroVenta;
	private String codCliente;
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
}
