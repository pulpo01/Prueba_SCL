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

public class SiniestroSACDTO implements Serializable
{

	private static final long serialVersionUID = 1490274177352492268L;

	String respuestaEstado;

	long numCelular;

	long numOoss;

	String usuario;

	private String codError;

	private String desError;

	public long getNumCelular()
	{
		return numCelular;
	}

	public long getNumOoss()
	{
		return numOoss;
	}

	public String getRespuestaEstado()
	{
		return respuestaEstado;
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

	public void setRespuestaEstado(String respuestaEstado)
	{
		this.respuestaEstado = respuestaEstado;
	}

	public void setUsuario(String usuario)
	{
		this.usuario = usuario;
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

}
