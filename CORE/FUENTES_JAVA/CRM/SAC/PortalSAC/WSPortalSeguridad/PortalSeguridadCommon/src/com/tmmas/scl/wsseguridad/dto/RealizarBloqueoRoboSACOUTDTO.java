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

public class RealizarBloqueoRoboSACOUTDTO implements Serializable
{

	private static final long serialVersionUID = 4727778792020996093L;

	private long numCelular;

	private String tipoSiniestro;

	private long tipoSusp;

	private long causaSiniestro;

	String usuario;

	private String codError;

	private String desError;

	private long numSolEqu;

	private long numSolSim;

	public long getCausaSiniestro()
	{
		return causaSiniestro;
	}

	public void setCausaSiniestro(long causaSiniestro)
	{
		this.causaSiniestro = causaSiniestro;
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

	public long getNumCelular()
	{
		return numCelular;
	}

	public void setNumCelular(long numCelular)
	{
		this.numCelular = numCelular;
	}

	public long getNumSolEqu()
	{
		return numSolEqu;
	}

	public void setNumSolEqu(long numSolEqu)
	{
		this.numSolEqu = numSolEqu;
	}

	public long getNumSolSim()
	{
		return numSolSim;
	}

	public void setNumSolSim(long numSolSim)
	{
		this.numSolSim = numSolSim;
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
