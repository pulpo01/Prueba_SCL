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

public class ObtenerEstadoSiniestroSACINDTO
{
	private static final long serialVersionUID = -645842021579340994L;

	long numCelular;

	long numOoss;

	String usuario;

	public long getNumCelular()
	{
		return numCelular;
	}

	public long getNumOoss()
	{
		return numOoss;
	}

	public String getUsuario()
	{
		return usuario;
	}

	public void setNumCelular(long numCelular)
	{
		this.numCelular = numCelular;
	}

	public void setNumOoss(long numOoss)
	{
		this.numOoss = numOoss;
	}

	public void setUsuario(String usuario)
	{
		this.usuario = usuario;
	}

}
