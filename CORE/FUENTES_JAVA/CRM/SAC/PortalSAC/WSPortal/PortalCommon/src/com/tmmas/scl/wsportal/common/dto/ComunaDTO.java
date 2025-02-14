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

public class ComunaDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8907494353423784778L;

	private String codComuna;

	private String desComuna;

	public final String getCodComuna()
	{
		return codComuna;
	}

	public final void setCodComuna(String codComuna)
	{
		this.codComuna = codComuna;
	}

	public final String getDesComuna()
	{
		return desComuna;
	}

	public final void setDesComuna(String desComuna)
	{
		this.desComuna = desComuna;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<ComunaDTO>");
		b.append("<codComuna>");
		b.append(getCodComuna());
		b.append("</codComuna>");
		b.append("<desComuna>");
		b.append(getDesComuna());
		b.append("</desComuna>");
		b.append("</ComunaDTO>");
		return b.toString();
	}

}
