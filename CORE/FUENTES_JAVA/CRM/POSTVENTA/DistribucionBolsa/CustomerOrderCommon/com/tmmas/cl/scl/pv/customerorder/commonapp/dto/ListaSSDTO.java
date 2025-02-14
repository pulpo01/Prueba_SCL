package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;


public class ListaSSDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private long cod_cliente;
	private long num_abonado;
	private boolean aciclo;   //Indica si el servicio se ejecuta en forma aciclo o inmediato 
	private ProductDTO productos[];

	public boolean isAciclo() {
		return aciclo;
	}
	public void setAciclo(boolean aciclo) {
		this.aciclo = aciclo;
	}
	
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public ProductDTO[] getProductos() {
		return productos;
	}
	public void setProductos(ProductDTO[] productos) {
		this.productos = productos;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}

}
