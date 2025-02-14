package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String idProducto;
	private int cantidad;
    private PrecioDTO precio;
	private DescuentoDTO[] descuento;
	private AtributosCargoDTO atributo;
	
	public AtributosCargoDTO getAtributo() {
		return atributo;
	}
	public void setAtributo(AtributosCargoDTO atributo) {
		this.atributo = atributo;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	public DescuentoDTO[] getDescuento() {
		return descuento;
	}
	public void setDescuento(DescuentoDTO[] descuento) {
		this.descuento = descuento;
	}
	public PrecioDTO getPrecio() {
		return precio;
	}
	public void setPrecio(PrecioDTO precio) {
		this.precio = precio;
	}
	
	
	
	
}
