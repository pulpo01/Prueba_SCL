package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class PvGaImpenalizaQTDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String des_Penaliza;
	private double imp_Penaliza;	
	private String des_Moneda;
	private long   cod_Concepto;
	private String cod_Moneda;
	private long   sw_Penaliza;
	private long   cod_Producto;
	private long   cod_Penaliza;
	
	   
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
	public long getCod_Penaliza() {
		return cod_Penaliza;
	}
	public void setCod_Penaliza(long cod_Penaliza) {
		this.cod_Penaliza = cod_Penaliza;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getDes_Moneda() {
		return des_Moneda;
	}
	public void setDes_Moneda(String des_Moneda) {
		this.des_Moneda = des_Moneda;
	}
	public String getDes_Penaliza() {
		return des_Penaliza;
	}
	public void setDes_Penaliza(String des_Penaliza) {
		this.des_Penaliza = des_Penaliza;
	}
	public double getImp_Penaliza() {
		return imp_Penaliza;
	}
	public void setImp_Penaliza(double imp_Penaliza) {
		this.imp_Penaliza = imp_Penaliza;
	}
	public long getSw_Penaliza() {
		return sw_Penaliza;
	}
	public void setSw_Penaliza(long sw_Penaliza) {
		this.sw_Penaliza = sw_Penaliza;
	}

}
