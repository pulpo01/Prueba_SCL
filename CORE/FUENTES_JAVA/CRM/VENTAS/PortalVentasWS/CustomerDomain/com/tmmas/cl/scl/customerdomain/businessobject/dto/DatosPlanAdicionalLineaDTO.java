package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosPlanAdicionalLineaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String 	nomPlanAdi;
	private String  valPlanAdi;
	
	public String getNomPlanAdi() {
		return nomPlanAdi;
	}
	public void setNomPlanAdi(String nomPlanAdi) {
		this.nomPlanAdi = nomPlanAdi;
	}
	public String getValPlanAdi() {
		return valPlanAdi;
	}
	public void setValPlanAdi(String valPlanAdi) {
		this.valPlanAdi = valPlanAdi;
	}	
}