package com.tmmas.cl.scl.commonbusinessentities.dto;

public class CodigoPostalDireccionDTO extends ConceptoDireccionDTO { 
	
	private static final long serialVersionUID = 1L;
	private String codigoZona;
	private String codigoZip;
	public  String indiceDefecto = "-1";
	
	public String getCodigoZip() {
		return codigoZip;
	}
	public void setCodigoZip(String codigoZip) {
		this.codigoZip = codigoZip;
	}
	public String getCodigoZona() {
		return codigoZona;
	}
	public void setCodigoZona(String codigoZona) {
		this.codigoZona = codigoZona;
	}

}
