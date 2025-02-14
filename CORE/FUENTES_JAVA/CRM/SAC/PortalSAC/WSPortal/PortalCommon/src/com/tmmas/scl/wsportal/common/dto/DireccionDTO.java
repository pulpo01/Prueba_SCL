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

public class DireccionDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codTipDireccion;

	private String desTipDireccion;

	private Long codDireccion;

	public Long getCodDireccion()
	{
		return codDireccion;
	}

	public void setCodDireccion(Long codDireccion)
	{
		this.codDireccion = codDireccion;
	}

	public String getCodTipDireccion()
	{
		return codTipDireccion;
	}

	public void setCodTipDireccion(String codTipDireccion)
	{
		this.codTipDireccion = codTipDireccion;
	}

	public String getDesTipDireccion()
	{
		return desTipDireccion;
	}

	public void setDesTipDireccion(String desTipDireccion)
	{
		this.desTipDireccion = desTipDireccion;
	}

}
