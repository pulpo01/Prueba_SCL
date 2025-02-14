package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class AlPetiGuiasAboDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Double val_linea; 
	private Long num_telefono; 
	private Long cod_concepto; 
	private Long num_orden; 
	private Long cod_bodega; 
	private Long cod_articulo; 
	private Long num_abonado; 
	private Long cod_cliente; 
	private Long num_venta; 
	private Long num_peticion; 
	private Long num_cantidad; 
	private Long num_cargo; 
	private String cod_oficina; 
	private String num_serie; 
	private String cod_moneda;
	private boolean transaccionOK;
	
	public boolean isTransaccionOK() {
		return transaccionOK;
	}
	public void setTransaccionOK(boolean transaccionOK) {
		this.transaccionOK = transaccionOK;
	}
	public Long getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(Long _cod_articulo) {
		this.cod_articulo = _cod_articulo;
	}
	public Long getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(Long _cod_bodega) {
		this.cod_bodega = _cod_bodega;
	}
	public Long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(Long _cod_cliente) {
		this.cod_cliente = _cod_cliente;
	}
	public Long getCod_concepto() {
		return cod_concepto;
	}
	public void setCod_concepto(Long _cod_concepto) {
		this.cod_concepto = _cod_concepto;
	}
	public String getCod_moneda() {
		return cod_moneda;
	}
	public void setCod_moneda(String _cod_moneda) {
		this.cod_moneda = _cod_moneda;
	}
	public String getCod_oficina() {
		return cod_oficina;
	}
	public void setCod_oficina(String _cod_oficina) {
		this.cod_oficina = _cod_oficina;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long _num_abonado) {
		this.num_abonado = _num_abonado;
	}
	public Long getNum_cantidad() {
		return num_cantidad;
	}
	public void setNum_cantidad(Long _num_cantidad) {
		this.num_cantidad = _num_cantidad;
	}
	public Long getNum_cargo() {
		return num_cargo;
	}
	public void setNum_cargo(Long _num_cargo) {
		this.num_cargo = _num_cargo;
	}
	public Long getNum_orden() {
		return num_orden;
	}
	public void setNum_orden(Long _num_orden) {
		this.num_orden = _num_orden;
	}
	public Long getNum_peticion() {
		return num_peticion;
	}
	public void setNum_peticion(Long _num_peticion) {
		this.num_peticion = _num_peticion;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String _num_serie) {
		this.num_serie = _num_serie;
	}
	public Long getNum_telefono() {
		return num_telefono;
	}
	public void setNum_telefono(Long _num_telefono) {
		this.num_telefono = _num_telefono;
	}
	public Long getNum_venta() {
		return num_venta;
	}
	public void setNum_venta(Long _num_venta) {
		this.num_venta = _num_venta;
	}
	public Double getVal_linea() {
		return val_linea;
	}
	public void setVal_linea(Double _val_linea) {
		this.val_linea = _val_linea;
	}

}
