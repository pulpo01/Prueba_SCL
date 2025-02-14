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

public class EntidadAuditoria implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String tipEntidad;

	private Long valEntidad;

	public String getTipEntidad()
	{
		return tipEntidad;
	}

	public void setTipEntidad(String tipEntidad)
	{
		this.tipEntidad = tipEntidad;
	}

	public Long getValEntidad()
	{
		return valEntidad;
	}

	public void setValEntidad(Long valEntidad)
	{
		this.valEntidad = valEntidad;
	}

}
