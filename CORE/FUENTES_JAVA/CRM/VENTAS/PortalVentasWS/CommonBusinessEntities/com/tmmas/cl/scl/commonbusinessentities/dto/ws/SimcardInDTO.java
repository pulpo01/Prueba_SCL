package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable; 
public class SimcardInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String nro_icc;
	private String cod_vendedor;
	private String cod_canal;
	private String forma_pago;
	private String tipo_producto;
	
	public String getCod_canal() {
		return cod_canal;
	}
	public void setCod_canal(String cod_canal) {
		this.cod_canal = cod_canal;
	}
	public String getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(String cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public String getForma_pago() {
		return forma_pago;
	}
	public void setForma_pago(String forma_pago) {
		this.forma_pago = forma_pago;
	}
	public String getNro_icc() {
		return nro_icc;
	}
	public void setNro_icc(String nro_icc) {
		this.nro_icc = nro_icc;
	}
	public String getTipo_producto() {
		return tipo_producto;
	}
	public void setTipo_producto(String tipo_producto) {
		this.tipo_producto = tipo_producto;
	}
	
}