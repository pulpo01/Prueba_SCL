package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FacturaDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String folio;
	private String nombrePDF;
	private String rutaPDF;
	private String codigoCiclo; 
	
	public String getCodigoCiclo() {
		return codigoCiclo;
	}
	public void setCodigoCiclo(String codigoCiclo) {
		this.codigoCiclo = codigoCiclo;
	}
	public String getNombrePDF() {
		return nombrePDF;
	}
	public void setNombrePDF(String nombrePDF) {
		this.nombrePDF = nombrePDF;
	}
	public String getRutaPDF() {
		return rutaPDF;
	}
	public void setRutaPDF(String rutaPDF) {
		this.rutaPDF = rutaPDF;
	}
	public String getFolio() {
		return folio;
	}
	public void setFolio(String folio) {
		this.folio = folio;
	}
	
}
