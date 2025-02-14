package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsSimcardInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numeroSerie;
			
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}

}
