/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class GedParametrosDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String codModulo;

	private Integer codProducto;

	private String nomParametro;


	public String getCodModulo() {
		return codModulo;
	}

	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	public Integer getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(Integer codProducto) {
		this.codProducto = codProducto;
	}

	public String getNomParametro() {
		return nomParametro;
	}

	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<gedParametrosDTO>");
		b.append("<codModulo>");
		b.append(getCodModulo());
		b.append("</codModulo>");
		b.append("<codProducto>");
		b.append(getCodProducto());
		b.append("</codProducto>");
		b.append("<nomParametro>");
		b.append(getNomParametro());
		b.append("</nomParametro>");
		b.append("</gedParametrosDTO>");
		return b.toString();
	}
}
