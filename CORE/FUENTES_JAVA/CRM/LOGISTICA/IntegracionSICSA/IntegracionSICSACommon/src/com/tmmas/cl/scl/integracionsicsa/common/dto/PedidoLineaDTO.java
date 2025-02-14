package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class PedidoLineaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int  linPedido;
	private long canDetallePedido;
	private long codArticulo;
	
	public int getLinPedido() {
		return linPedido;
	}
	public void setLinPedido(int linPedido) {
		this.linPedido = linPedido;
	}
	public long getCanDetallePedido() {
		return canDetallePedido;
	}
	public void setCanDetallePedido(long canDetallePedido) {
		this.canDetallePedido = canDetallePedido;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
}
