package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsLineaOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String numCelular;
	private String NumAboando;
	private String numSerie;
	private String numImei;
	
	public String getNumAboando() {
		return NumAboando;
	}
	public void setNumAboando(String numAboando) {
		NumAboando = numAboando;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	
	

}
