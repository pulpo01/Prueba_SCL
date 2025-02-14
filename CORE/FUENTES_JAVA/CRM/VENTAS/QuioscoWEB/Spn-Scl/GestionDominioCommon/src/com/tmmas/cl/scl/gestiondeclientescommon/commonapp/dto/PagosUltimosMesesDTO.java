package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class PagosUltimosMesesDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long anioPago;
	private long mesPago;
	private float impPago;
	public long getAnioPago() {
		return anioPago;
	}
	public void setAnioPago(long anioPago) {
		this.anioPago = anioPago;
	}
	public float getImpPago() {
		return impPago;
	}
	public void setImpPago(float impPago) {
		this.impPago = impPago;
	}
	public long getMesPago() {
		return mesPago;
	}
	public void setMesPago(long mesPago) {
		this.mesPago = mesPago;
	}
	
	
}
