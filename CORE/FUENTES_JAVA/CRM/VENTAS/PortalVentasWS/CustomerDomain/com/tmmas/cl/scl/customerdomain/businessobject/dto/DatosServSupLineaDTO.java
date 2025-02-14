package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosServSupLineaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String nomSS;
	private String valSS;
	
	public String getNomSS() {
		return nomSS;
	}
	public void setNomSS(String nomSS) {
		this.nomSS = nomSS;
	}
	public String getValSS() {
		return valSS;
	}
	public void setValSS(String valSS) {
		this.valSS = valSS;
	}
}

