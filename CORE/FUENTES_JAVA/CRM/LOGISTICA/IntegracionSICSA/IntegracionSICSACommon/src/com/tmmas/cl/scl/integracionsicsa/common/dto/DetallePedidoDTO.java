package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DetallePedidoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String nroPedido;
	private String linPedido;
	private String desStock;
	private String desArticulo;
	private String desTecnologia;
	private String cantidad;
	private String cantidadAsig;
	private String mtoUnitario;
	private String mtoDescuento;
	private String porcDescuento;
	private String mtoNeto;
	
	public String getNroPedido() {
		return nroPedido;
	}
	public void setNroPedido(String nroPedido) {
		this.nroPedido = nroPedido;
	}
	public String getLinPedido() {
		return linPedido;
	}
	public void setLinPedido(String linPedido) {
		this.linPedido = linPedido;
	}
	public String getDesStock() {
		return desStock;
	}
	public void setDesStock(String desStock) {
		this.desStock = desStock;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	public String getDesTecnologia() {
		return desTecnologia;
	}
	public void setDesTecnologia(String desTecnologia) {
		this.desTecnologia = desTecnologia;
	}
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getCantidadAsig() {
		return cantidadAsig;
	}
	public void setCantidadAsig(String cantidadAsig) {
		this.cantidadAsig = cantidadAsig;
	}
	public String getMtoUnitario() {
		return mtoUnitario;
	}
	public void setMtoUnitario(String mtoUnitario) {
		this.mtoUnitario = mtoUnitario;
	}
	public String getMtoDescuento() {
		return mtoDescuento;
	}
	public void setMtoDescuento(String mtoDescuento) {
		this.mtoDescuento = mtoDescuento;
	}
	public String getPorcDescuento() {
		return porcDescuento;
	}
	public void setPorcDescuento(String porcDescuento) {
		this.porcDescuento = porcDescuento;
	}
	public String getMtoNeto() {
		return mtoNeto;
	}
	public void setMtoNeto(String mtoNeto) {
		this.mtoNeto = mtoNeto;
	}

	
}
