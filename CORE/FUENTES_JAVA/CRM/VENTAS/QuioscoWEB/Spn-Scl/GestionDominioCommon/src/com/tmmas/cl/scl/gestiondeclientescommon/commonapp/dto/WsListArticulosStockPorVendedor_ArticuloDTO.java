package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsListArticulosStockPorVendedor_ArticuloDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codArticulo;
	private String desArticulo;
	private long codModelo;
	private long canStock;
	private long codBodega;
	private long canReservada;
	
	
	public long getCanReservada() {
		return canReservada;
	}
	public void setCanReservada(long canReservada) {
		this.canReservada = canReservada;
	}
	public long getCanStock() {
		return canStock;
	}
	public void setCanStock(long canStock) {
		this.canStock = canStock;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}
	public long getCodModelo() {
		return codModelo;
	}
	public void setCodModelo(long codModelo) {
		this.codModelo = codModelo;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	
}
