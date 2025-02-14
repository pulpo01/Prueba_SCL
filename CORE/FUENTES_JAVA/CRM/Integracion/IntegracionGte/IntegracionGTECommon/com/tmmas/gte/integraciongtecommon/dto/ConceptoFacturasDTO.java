package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConceptoFacturasDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codConcepto;
	private String desConcepto;
	private double importeDebe;
	private double importeHaber;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getDesConcepto() {
		return desConcepto;
	}
	public void setDesConcepto(String desConcepto) {
		this.desConcepto = desConcepto;
	}
	public double getImporteDebe() {
		return importeDebe;
	}
	public void setImporteDebe(double importeDebe) {
		this.importeDebe = importeDebe;
	}
	public double getImporteHaber() {
		return importeHaber;
	}
	public void setImporteHaber(double importeHaber) {
		this.importeHaber = importeHaber;
	}
	
	
}
