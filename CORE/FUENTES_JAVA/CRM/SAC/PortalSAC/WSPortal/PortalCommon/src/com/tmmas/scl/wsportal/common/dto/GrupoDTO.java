/**
 * Copyright � 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class GrupoDTO implements Serializable
{
	private static final long serialVersionUID = -1759349871246973588L;

	private String codGrupo;

	private String desGrupo;

	public void setCodGrupo(String codGrupo)
	{
		this.codGrupo = codGrupo;
	}

	public String getCodGrupo()
	{
		return codGrupo;
	}

	public void setDesGrupo(String desGrupo)
	{
		this.desGrupo = desGrupo;
	}

	public String getDesGrupo()
	{
		return desGrupo;
	}

}
