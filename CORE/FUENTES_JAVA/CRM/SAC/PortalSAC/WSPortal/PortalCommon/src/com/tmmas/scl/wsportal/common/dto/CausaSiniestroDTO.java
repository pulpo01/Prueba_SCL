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

public class CausaSiniestroDTO implements Serializable
{
	private static final long serialVersionUID = -2759498150751879246L;

	private String codCausa;

	private String desCausa;

	public final String getCodCausa()
	{
		return codCausa;
	}

	public final void setCodCausa(String codCausa)
	{
		this.codCausa = codCausa;
	}

	public final String getDesCausa()
	{
		return desCausa;
	}

	public final void setDesCausa(String desCausa)
	{
		this.desCausa = desCausa;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<CausaSiniestroDTO>");
		b.append("<codCausa>");
		b.append(getCodCausa());
		b.append("</codCausa>");
		b.append("<desCausa>");
		b.append(getDesCausa());
		b.append("</desCausa>");
		b.append("</CausaSiniestroDTO>");
		return b.toString();
	}

}
