package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosProcesadorCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoCliente;
	private String numeroProceso;
	private String usuario;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(String numeroProceso) {
		this.numeroProceso = numeroProceso;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	
}
