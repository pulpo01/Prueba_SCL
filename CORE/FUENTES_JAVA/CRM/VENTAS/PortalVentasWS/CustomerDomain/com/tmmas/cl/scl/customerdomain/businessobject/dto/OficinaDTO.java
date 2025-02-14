package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class OficinaDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codigoOficina;

	private String descripcionOficina;

	private String codigoRegion;

	private String codigoProvincia;

	private String codigoCiudad;

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

	public String getCodigoOficina() {
		return codigoOficina;
	}

	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}

	public String getDescripcionOficina() {
		return descripcionOficina;
	}

	public void setDescripcionOficina(String descripcionOficina) {
		this.descripcionOficina = descripcionOficina;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer b = new StringBuffer();

		b.append("OficinaDTO ( ").append(super.toString()).append(newLine);
		b.append("codigoCiudad = ").append(this.codigoCiudad).append(newLine);
		b.append("codigoOficina = ").append(this.codigoOficina).append(newLine);
		b.append("codigoProvincia = ").append(this.codigoProvincia).append(newLine);
		b.append("codigoRegion = ").append(this.codigoRegion).append(newLine);
		b.append("descripcionOficina = ").append(this.descripcionOficina).append(newLine);
		b.append(" )");

		return b.toString();
	}

}// fin class OficinaDTO
