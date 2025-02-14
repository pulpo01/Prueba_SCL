package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class SerieTraspasoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String linTraspaso;
	private String numSerie;
	
	public String getLinTraspaso() {
		return linTraspaso;
	}
	public void setLinTraspaso(String linTraspaso) {
		this.linTraspaso = linTraspaso;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
}
