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

public class CiudadDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 38544579892351894L;

	private String codCiudad;

	private String desCiudad;

	public final String getCodCiudad()
	{
		return codCiudad;
	}

	public final void setCodCiudad(String codCiudad)
	{
		this.codCiudad = codCiudad;
	}

	public final String getDesCiudad()
	{
		return desCiudad;
	}

	public final void setDesCiudad(String desCiudad)
	{
		this.desCiudad = desCiudad;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<CiudadDTO>");
		b.append("<codCiudad>");
		b.append(getCodCiudad());
		b.append("</codCiudad>");
		b.append("<desCiudad>");
		b.append(getDesCiudad());
		b.append("</desCiudad>");
		b.append("</CiudadDTO>");
		return b.toString();
	}

}
