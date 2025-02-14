package com.tmmas.cl.scl.integracionexterna.common.dto;

import java.io.Serializable;

public class SerieErrorDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String numSerie;
	private String desErrorSerie;
	
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getDesErrorSerie() {
		return desErrorSerie;
	}
	public void setDesErrorSerie(String desErrorSerie) {
		this.desErrorSerie = desErrorSerie;
	}
}
