package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class FreeUnitStockDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	long COD_CLIENTE;
	long NUM_ABONADO;
	String COD_PLAN;
	String COD_BOLSA;
	String IND_UNIDAD;
	float PRC_UNIDAD;
	long CNT_UNIDAD;
	long IND_VENTA;
	
	public long getCNT_UNIDAD() {
		return CNT_UNIDAD;
	}
	public void setCNT_UNIDAD(long cnt_unidad) {
		CNT_UNIDAD = cnt_unidad;
	}
	public String getCOD_BOLSA() {
		return COD_BOLSA;
	}
	public void setCOD_BOLSA(String cod_bolsa) {
		COD_BOLSA = cod_bolsa;
	}
	public long getCOD_CLIENTE() {
		return COD_CLIENTE;
	}
	public void setCOD_CLIENTE(long cod_cliente) {
		COD_CLIENTE = cod_cliente;
	}
	public String getCOD_PLAN() {
		return COD_PLAN;
	}
	public void setCOD_PLAN(String cod_plan) {
		COD_PLAN = cod_plan;
	}
	public String getIND_UNIDAD() {
		return IND_UNIDAD;
	}
	public void setIND_UNIDAD(String ind_unidad) {
		IND_UNIDAD = ind_unidad;
	}
	public long getIND_VENTA() {
		return IND_VENTA;
	}
	public void setIND_VENTA(long ind_venta) {
		IND_VENTA = ind_venta;
	}
	public long getNUM_ABONADO() {
		return NUM_ABONADO;
	}
	public void setNUM_ABONADO(long num_abonado) {
		NUM_ABONADO = num_abonado;
	}
	public float getPRC_UNIDAD() {
		return PRC_UNIDAD;
	}
	public void setPRC_UNIDAD(float prc_unidad) {
		PRC_UNIDAD = prc_unidad;
	}
	
}
