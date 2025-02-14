package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

public class ComunaDireccionDTO extends ConceptoDireccionDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoRegion;
	private String codigoProvincia;
	private String codigoCiudad;
	private String codigoComuna;
	public static String indiceDefecto = "-1";
	public String getCodigoComuna() {
		return codigoComuna;
	}
	public void setCodigoComuna(String codigoComuna) {
		this.codigoComuna = codigoComuna;
	}
	public String getCodigoCiudad() {
		return codigoCiudad;
	}
	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
	}
	public String getCodigoProvincia() {
		return codigoProvincia;
	}
	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
	}

}
