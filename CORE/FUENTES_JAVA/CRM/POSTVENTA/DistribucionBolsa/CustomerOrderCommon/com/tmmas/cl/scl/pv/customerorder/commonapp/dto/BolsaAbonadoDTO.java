package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class BolsaAbonadoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String num_celular;
	private int num_abonado;
	private float prc_unidad;	
	private int cnt_unidad;
	private int ind_venta;

	public int getCnt_unidad() {
		return cnt_unidad;
	}
	public void setCnt_unidad(int cnt_unidad) {
		this.cnt_unidad = cnt_unidad;
	}

	public int getInd_venta() {
		return ind_venta;
	}
	public void setInd_venta(int ind_venta) {
		this.ind_venta = ind_venta;
	}
	public int getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(int num_abonado) {
		this.num_abonado = num_abonado;
	}
	public float getPrc_unidad() {
		return prc_unidad;
	}
	public void setPrc_unidad(float prc_unidad) {
		this.prc_unidad = prc_unidad;
	}
	public String getNum_celular() {
		return num_celular;
	}
	public void setNum_celular(String num_celular) {
		this.num_celular = num_celular;
	}
}
