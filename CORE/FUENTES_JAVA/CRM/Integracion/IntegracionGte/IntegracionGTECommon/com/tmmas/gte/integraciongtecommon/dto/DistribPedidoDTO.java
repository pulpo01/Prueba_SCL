package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DistribPedidoDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

	private double mtoNetoPedido;
	private long cantTotalPedido;
	private double mtoTotalPedido;
    private long codBodega;
    private String desBodega;
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}
	public String getDesBodega() {
		return desBodega;
	}
	public void setDesBodega(String desBodega) {
		this.desBodega = desBodega;
	}
	public long getCantTotalPedido() {
		return cantTotalPedido;
	}
	public void setCantTotalPedido(long cantTotalPedido) {
		this.cantTotalPedido = cantTotalPedido;
	}
	public double getMtoNetoPedido() {
		return mtoNetoPedido;
	}
	public void setMtoNetoPedido(double mtoNetoPedido) {
		this.mtoNetoPedido = mtoNetoPedido;
	}
	public double getMtoTotalPedido() {
		return mtoTotalPedido;
	}
	public void setMtoTotalPedido(double mtoTotalPedido) {
		this.mtoTotalPedido = mtoTotalPedido;
	}
	
}