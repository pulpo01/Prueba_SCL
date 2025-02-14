package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class ConsultaDevolucionUsuarioDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codDevolucion;
	private String estadoPedido;
	private String fecDevolucion;
	public String getCodDevolucion() {
		return codDevolucion;
	}
	public void setCodDevolucion(String codDevolucion) {
		this.codDevolucion = codDevolucion;
	}
	public String getEstadoPedido() {
		return estadoPedido;
	}
	public void setEstadoPedido(String estadoPedido) {
		this.estadoPedido = estadoPedido;
	}
	public String getFecDevolucion() {
		return fecDevolucion;
	}
	public void setFecDevolucion(String fecDevolucion) {
		this.fecDevolucion = fecDevolucion;
	}

	
	

}
