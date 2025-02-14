package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class HomeLineaDTO implements Serializable {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	
	private String codCentral;
	private String nomCentral;
	private String codCelda;
	
	public String getCodCelda() {
		return codCelda;
	}
	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getNomCentral() {
		return nomCentral;
	}
	public void setNomCentral(String nomCentral) {
		this.nomCentral = nomCentral;
	}
	
	

}
