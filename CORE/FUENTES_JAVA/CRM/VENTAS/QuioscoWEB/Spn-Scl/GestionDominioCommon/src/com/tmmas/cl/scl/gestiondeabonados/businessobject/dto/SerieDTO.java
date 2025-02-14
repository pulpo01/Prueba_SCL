package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class SerieDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String numSerie;
	private String nomUsuario;
	private String numPorceso;
	private String numMovimiento;
	
	
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(String numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public String getNumPorceso() {
		return numPorceso;
	}
	public void setNumPorceso(String numPorceso) {
		this.numPorceso = numPorceso;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	

}
