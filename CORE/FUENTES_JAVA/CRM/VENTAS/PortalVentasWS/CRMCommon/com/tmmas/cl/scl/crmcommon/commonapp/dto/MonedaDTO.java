/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba,
 * Santiago de Chile, Chile Todos los derechos reservados. Este software es informaci&oacute;n propietaria y
 * confidencial de TM-mAs SA. Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia con los
 * t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs. Fecha ------------------- Autor
 * ------------------------- Cambios ---------- 04/04/2007 H�ctor Hermosilla Versi�n Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class MonedaDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codigo;

	private String descripcion;

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer b = new StringBuffer();

		b.append("MonedaDTO ( ").append(super.toString()).append(newLine);
		b.append("codigo = ").append(this.codigo).append(newLine);
		b.append("descripcion = ").append(this.descripcion).append(newLine);
		b.append(" )");

		return b.toString();
	}

}
