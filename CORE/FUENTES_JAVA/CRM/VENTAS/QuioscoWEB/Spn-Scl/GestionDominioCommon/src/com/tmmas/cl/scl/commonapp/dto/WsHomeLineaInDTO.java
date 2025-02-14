package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsHomeLineaInDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigCentral;
	private String celda;
	
	
	
	public String getCelda() {
		return celda;
	}
	public void setCelda(String celda) {
		this.celda = celda;
	}
	public String getCodigCentral() {
		return codigCentral;
	}
	public void setCodigCentral(String codigCentral) {
		this.codigCentral = codigCentral;
	}
	



}
