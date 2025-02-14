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

public class TipoSuspensionDTO implements Serializable
{
	private static final long serialVersionUID = 8892335720430098509L;

	private String codValor;

	private String desValor;

	public final String getCodValor()
	{
		return codValor;
	}

	public final void setCodValor(String codValor)
	{
		this.codValor = codValor;
	}

	public final String getDesValor()
	{
		return desValor;
	}

	public final void setDesValor(String desValor)
	{
		this.desValor = desValor;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<TipoSuspensionDTO>");
		b.append("<codValor>");
		b.append(getCodValor());
		b.append("</codValor>");
		b.append("<desValor>");
		b.append(getDesValor());
		b.append("</desValor>");
		b.append("</TipoSuspensionDTO>");
		return b.toString();
	}

}
