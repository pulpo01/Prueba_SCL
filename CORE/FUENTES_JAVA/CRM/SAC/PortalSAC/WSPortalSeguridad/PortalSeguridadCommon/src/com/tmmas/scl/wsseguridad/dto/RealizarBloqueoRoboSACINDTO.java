/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.dto;

import java.io.Serializable;

public class RealizarBloqueoRoboSACINDTO implements Serializable
{

	private static final long serialVersionUID = 531815378552014337L;

	long numCelular;

	String tipoSiniestro;

	long tipoSusp;

	long causaSiniestro;

	String usuario;

	public long getCausaSiniestro()
	{
		return causaSiniestro;
	}

	public void setCausaSiniestro(long causaSiniestro)
	{
		this.causaSiniestro = causaSiniestro;
	}

	public long getNumCelular()
	{
		return numCelular;
	}

	public void setNumCelular(long numCelular)
	{
		this.numCelular = numCelular;
	}

	public String getTipoSiniestro()
	{
		return tipoSiniestro;
	}

	public void setTipoSiniestro(String tipoSiniestro)
	{
		this.tipoSiniestro = tipoSiniestro;
	}

	public long getTipoSusp()
	{
		return tipoSusp;
	}

	public void setTipoSusp(long tipoSusp)
	{
		this.tipoSusp = tipoSusp;
	}

	public String getUsuario()
	{
		return usuario;
	}

	public void setUsuario(String usuario)
	{
		this.usuario = usuario;
	}

}
