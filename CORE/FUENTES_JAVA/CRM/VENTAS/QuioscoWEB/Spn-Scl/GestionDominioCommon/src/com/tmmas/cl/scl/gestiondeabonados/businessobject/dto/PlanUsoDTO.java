package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class PlanUsoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codPlanTarif;
	private Long codUso;
	
	private String numSerie;	
	
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public Long getCodUso() {
		return codUso;
	}
	public void setCodUso(Long codUso) {
		this.codUso = codUso;
	}	
	
}//fin class PlanUsoDTO