package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosArticulosDscDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codArticulo;
	private float descuentoArticulo;
	private String tipArticulo;
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getTipArticulo() {
		return tipArticulo;
	}
	public void setTipArticulo(String tipArticulo) {
		this.tipArticulo = tipArticulo;
	}
	public float getDescuentoArticulo() {
		return descuentoArticulo;
	}
	public void setDescuentoArticulo(float descuentoArticulo) {
		this.descuentoArticulo = descuentoArticulo;
	}
}
