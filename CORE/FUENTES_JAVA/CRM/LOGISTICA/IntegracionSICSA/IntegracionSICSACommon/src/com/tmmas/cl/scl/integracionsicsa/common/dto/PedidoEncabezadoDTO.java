package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class PedidoEncabezadoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codPedido;
	private String totalPedido;
	private PedidoLineaDTO[] pedidoLineasDTOs;
	
	public String getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(String codPedido) {
		this.codPedido = codPedido;
	}
	public String getTotalPedido() {
		return totalPedido;
	}
	public void setTotalPedido(String totalPedido) {
		this.totalPedido = totalPedido;
	}
	public PedidoLineaDTO[] getPedidoLineasDTOs() {
		return pedidoLineasDTOs;
	}
	public void setPedidoLineasDTOs(PedidoLineaDTO[] pedidoLineasDTOs) {
		this.pedidoLineasDTOs = pedidoLineasDTOs;
	}
}
