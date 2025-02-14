package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class CargosSimcarPrepagoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private float impTarifa;
	private String codConcepto;
	private String codMoneda;
	
	
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public float getImpTarifa() {
		return impTarifa;
	}
	public void setImpTarifa(float impTarifa) {
		this.impTarifa = impTarifa;
	}

	
	
}
