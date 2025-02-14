package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class WsVentaAccesoriosDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String 			nombreUsuario;
	
	private ArticuloDTO[] 	articulo;
	private long 			codVendedor;	
	private int				codModVenta;
	private double			impVenta;
	private ClienteDTO		cliente;
	
	public ArticuloDTO[] getArticulo() {
		return articulo;
	}
	public void setArticulo(ArticuloDTO[] articulo) {
		this.articulo = articulo;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public int getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public double getImpVenta() {
		return impVenta;
	}
	public void setImpVenta(double impVenta) {
		this.impVenta = impVenta;
	}	
}
