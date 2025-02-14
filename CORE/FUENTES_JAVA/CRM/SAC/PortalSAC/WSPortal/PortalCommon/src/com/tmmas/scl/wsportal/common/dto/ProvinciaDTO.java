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

public class ProvinciaDTO implements Serializable
{
	
	private static final long serialVersionUID = 1293208483826910392L;

	private String codProvincia;

	private String desProvincia;

	public final String getCodProvincia()
	{
		return codProvincia;
	}

	public final void setCodProvincia(String codRegion)
	{
		this.codProvincia = codRegion;
	}

	public final String getDesProvincia()
	{
		return desProvincia;
	}

	public final void setDesProvincia(String desProvincia)
	{
		this.desProvincia = desProvincia;
	}
	
	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<ProvinciaDTO>");
		b.append("<codProvincia>");
		b.append(getCodProvincia());
		b.append("</codProvincia>");
		b.append("<desProvincia>");
		b.append(getDesProvincia());
		b.append("</desProvincia>");
		b.append("</ProvinciaDTO>");
		return b.toString();
	}

}
