package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class GeModVentaDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codModVenta;
	private String desModVenta;
	public long getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(long codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getDesModVenta() {
		return desModVenta;
	}
	public void setDesModVenta(String desModVenta) {
		this.desModVenta = desModVenta;
	}

}
