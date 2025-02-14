package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class CargoIndemnizQTDTO  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String cod_Actabo;
	   private long cod_Concepto;
	   private String cod_Moneda;
	   private long cod_Producto;
	   private String cod_TipServ;
	   private String cod_Servicio;
	   private String des_Moneda;
	   private String des_Servicio;
	   private long meses_Contrato;
	   private long num_Meses;
	   private double valor;
	
	   public String getCod_Actabo() {
		return cod_Actabo;
	}
	public void setCod_Actabo(String cod_Actabo) {
		this.cod_Actabo = cod_Actabo;
	}
	public long getCod_Concepto() {
		return cod_Concepto;
	}
	public void setCod_Concepto(long cod_Concepto) {
		this.cod_Concepto = cod_Concepto;
	}
	public String getCod_Moneda() {
		return cod_Moneda;
	}
	public void setCod_Moneda(String cod_Moneda) {
		this.cod_Moneda = cod_Moneda;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_Servicio() {
		return cod_Servicio;
	}
	public void setCod_Servicio(String cod_Servicio) {
		this.cod_Servicio = cod_Servicio;
	}
	public String getCod_TipServ() {
		return cod_TipServ;
	}
	public void setCod_TipServ(String cod_TipServ) {
		this.cod_TipServ = cod_TipServ;
	}
	public String getDes_Moneda() {
		return des_Moneda;
	}
	public void setDes_Moneda(String des_Moneda) {
		this.des_Moneda = des_Moneda;
	}
	public String getDes_Servicio() {
		return des_Servicio;
	}
	public void setDes_Servicio(String des_Servicio) {
		this.des_Servicio = des_Servicio;
	}
	public long getMeses_Contrato() {
		return meses_Contrato;
	}
	public void setMeses_Contrato(long meses_Contrato) {
		this.meses_Contrato = meses_Contrato;
	}
	public long getNum_Meses() {
		return num_Meses;
	}
	public void setNum_Meses(long num_Meses) {
		this.num_Meses = num_Meses;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}

}
