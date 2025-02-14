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

public class ListadoTiposSiniestroDTO implements Serializable
{
	private static final long serialVersionUID = 2055399249532008965L;

	private TipoSiniestroDTO[] listado;

	private String codError;

	private String desError;

	public TipoSiniestroDTO[] getListado()
	{
		return listado;
	}

	public void setListado(TipoSiniestroDTO[] listado)
	{
		this.listado = listado;
	}

	public String getCodError()
	{
		return codError;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}

	public String toXml()
	{
		StringBuffer b = new StringBuffer();
		b.append("<ListadoTiposSiniestroDTO>");
		TipoSiniestroDTO dto = null;
		for (int i = 0; i < getListado().length; i++)
		{
			dto = (TipoSiniestroDTO) getListado()[i];
			b.append(dto.toXml());
		}
		b.append("</ListadoTiposSiniestroDTO>");
		return b.toString();
	}

}
