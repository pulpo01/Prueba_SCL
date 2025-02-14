package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DetalleFichaSalidaBodegaDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private long numCelular;

	private String numSerie;

	private String numImei;

	private long codBodega;

	private String indProcEquipo;

	private String codArticulo;

	private String desArticulo;
	
	private String codPlanTarif;
	
	private String desPlanTarif;

	public String getDesArticulo() {
		return desArticulo;
	}

	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}

	public long getCodBodega() {
		return codBodega;
	}

	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}

	public String getCodArticulo() {
		return codArticulo;
	}

	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}

	public String getIndProcEquipo() {
		return indProcEquipo;
	}

	public void setIndProcEquipo(String indProcEquipo) {
		this.indProcEquipo = indProcEquipo;
	}

	public String getNumSerie() {
		return numSerie;
	}

	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}

	public String getNumImei() {
		return numImei;
	}

	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}

	public String toString() {
		final String bn = "\n";
		StringBuffer b = new StringBuffer();
		b.append("DetalleFichaSalidaBodegaDTO ( ").append(super.toString()).append(bn);
		b.append("codArticulo = ").append(this.codArticulo).append(bn);
		b.append("codPlanTarif = ").append(this.codPlanTarif).append(bn);
		b.append("codBodega = ").append(this.codBodega).append(bn);
		b.append("desArticulo = ").append(this.desArticulo).append(bn);
		b.append("desPlanTarif = ").append(this.desPlanTarif).append(bn);
		b.append("indProcEquipo = ").append(this.indProcEquipo).append(bn);
		b.append("numCelular = ").append(this.numCelular).append(bn);
		b.append("numImei = ").append(this.numImei).append(bn);
		b.append("numSerie = ").append(this.numSerie).append(bn);
		b.append(" )");
		return b.toString();
	}

	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	public String getDesPlanTarif() {
		return desPlanTarif;
	}

	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}

}
