package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class RoamingDTO implements Serializable{

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	private String numCelular;
	private String uso;
	public String getUso() {
		return uso;
	}
	public void setUso(String uso) {
		this.uso = uso;
	}
	
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	
	
}
