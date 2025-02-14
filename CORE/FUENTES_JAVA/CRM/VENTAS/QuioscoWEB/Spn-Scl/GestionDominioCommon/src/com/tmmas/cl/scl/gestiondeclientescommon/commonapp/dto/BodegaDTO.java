package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class BodegaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codigoBodega;
	private String descripcionBodega;
	
	
	public String getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public String getDescripcionBodega() {
		return descripcionBodega;
	}
	public void setDescripcionBodega(String descripcionBodega) {
		this.descripcionBodega = descripcionBodega;
	}
	
	
}
