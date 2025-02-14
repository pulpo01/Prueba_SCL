package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class ConsultaPedidoUsuarioDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codPedido;
	private String estadoPedido;
	private String fecPedido;
	
	public String getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(String codPedido) {
		this.codPedido = codPedido;
	}
	public String getEstadoPedido() {
		return estadoPedido;
	}
	public void setEstadoPedido(String estadoPedido) {
		this.estadoPedido = estadoPedido;
	}
	public String getFecPedido() {
		return fecPedido;
	}
	public void setFecPedido(String fecPedido) {
		this.fecPedido = fecPedido;
	}
	

}
