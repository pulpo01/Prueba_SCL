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

public class UmtsAbonadoDTO implements Serializable
{

	static final long serialVersionUID = 1L;

	private String codTipoPlan;

	private String desTipoPlan;

	private String codTecnologia;

	private String desTecnologia;

	private String codSituacion;

	private String desSituacion;

	private int total;

	String codError;

	String desError;

	public void setCodSituacion(String codSituacion)
	{
		this.codSituacion = codSituacion;
	}

	public String getCodSituacion()
	{
		return codSituacion;
	}

	public void setDesSituacion(String desSituacion)
	{
		this.desSituacion = desSituacion;
	}

	public String getDesSituacion()
	{
		return desSituacion;
	}

	public void setCodError(String codError)
	{
		this.codError = codError;
	}

	public String getCodError()
	{
		return codError;
	}

	public void setDesError(String desError)
	{
		this.desError = desError;
	}

	public String getDesError()
	{
		return desError;
	}

	public void setCodTipoPlan(String codTipoPlan)
	{
		this.codTipoPlan = codTipoPlan;
	}

	public String getCodTipoPlan()
	{
		return codTipoPlan;
	}

	public void setDesTipoPlan(String desTipoPlan)
	{
		this.desTipoPlan = desTipoPlan;
	}

	public String getDesTipoPlan()
	{
		return desTipoPlan;
	}

	public void setCodTecnologia(String codTecnologia)
	{
		this.codTecnologia = codTecnologia;
	}

	public String getCodTecnologia()
	{
		return codTecnologia;
	}

	public void setDesTecnologia(String desTecnologia)
	{
		this.desTecnologia = desTecnologia;
	}

	public String getDesTecnologia()
	{
		return desTecnologia;
	}

	public void setTotal(int total)
	{
		this.total = total;
	}

	public int getTotal()
	{
		return total;
	}
}
