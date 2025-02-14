package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;

public class ConceptoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long codConceptoOrig;
	private float montoConcepto;
	private String descripcion;
	
	public float getMontoConcepto() {
		return montoConcepto;
	}
	public void setMontoConcepto(float montoConcepto) {
		this.montoConcepto = montoConcepto;
	}
	public long getCodConceptoOrig() {
		return codConceptoOrig;
	}
	public void setCodConceptoOrig(long codConceptoOrig) {
		this.codConceptoOrig = codConceptoOrig;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	

}
