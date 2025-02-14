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

public class EquipoSimcardDetalleDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	// Datos del equipo
	private String numSerieEquipo;

	private String codModeloEquipo;

	private Long codArticuloEquipo;

	private String desArticuloEquipo;

	private String indProcEquipo;

	private String fechaAltaEquipo;

	private String indEquipoPrestado;

	// DatosSimcard
	private String numSerieSimcard;

	private String numImei;

	private String codModeloSimcard;

	private Long codArticuloSimcard;

	private String desArticuloSimcard;

	private String indProcSimcard;

	private String fechaAltaSimcard;

	private Long codGama;

	private String desGama;
	
	private String desTecnologia;

	private String codError;

	private String desError;

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

	public String getIndProcEquipo()
	{
		return indProcEquipo;
	}

	public void setIndProcEquipo(String indProcEquipo)
	{
		this.indProcEquipo = indProcEquipo;
	}

	public String getIndProcSimcard()
	{
		return indProcSimcard;
	}

	public void setIndProcSimcard(String indProcSimcard)
	{
		this.indProcSimcard = indProcSimcard;
	}

	public Long getCodArticuloEquipo()
	{
		return codArticuloEquipo;
	}

	public void setCodArticuloEquipo(Long codArticuloEquipo)
	{
		this.codArticuloEquipo = codArticuloEquipo;
	}

	public Long getCodArticuloSimcard()
	{
		return codArticuloSimcard;
	}

	public void setCodArticuloSimcard(Long codArticuloSimcard)
	{
		this.codArticuloSimcard = codArticuloSimcard;
	}

	public String getCodModeloEquipo()
	{
		return codModeloEquipo;
	}

	public void setCodModeloEquipo(String codModeloEquipo)
	{
		this.codModeloEquipo = codModeloEquipo;
	}

	public String getCodModeloSimcard()
	{
		return codModeloSimcard;
	}

	public void setCodModeloSimcard(String codModeloSimcard)
	{
		this.codModeloSimcard = codModeloSimcard;
	}

	public String getDesArticuloEquipo()
	{
		return desArticuloEquipo;
	}

	public void setDesArticuloEquipo(String desArticuloEquipo)
	{
		this.desArticuloEquipo = desArticuloEquipo;
	}

	public String getDesArticuloSimcard()
	{
		return desArticuloSimcard;
	}

	public void setDesArticuloSimcard(String desArticuloSimcard)
	{
		this.desArticuloSimcard = desArticuloSimcard;
	}

	public String getFechaAltaEquipo()
	{
		return fechaAltaEquipo;
	}

	public void setFechaAltaEquipo(String fechaAltaEquipo)
	{
		this.fechaAltaEquipo = fechaAltaEquipo;
	}

	public String getFechaAltaSimcard()
	{
		return fechaAltaSimcard;
	}

	public void setFechaAltaSimcard(String fechaAltaSimcard)
	{
		this.fechaAltaSimcard = fechaAltaSimcard;
	}

	public String getNumImei()
	{
		return numImei;
	}

	public void setNumImei(String numImei)
	{
		this.numImei = numImei;
	}

	public String getNumSerieEquipo()
	{
		return numSerieEquipo;
	}

	public void setNumSerieEquipo(String numSerieEquipo)
	{
		this.numSerieEquipo = numSerieEquipo;
	}

	public String getNumSerieSimcard()
	{
		return numSerieSimcard;
	}

	public void setNumSerieSimcard(String numSerieSimcard)
	{
		this.numSerieSimcard = numSerieSimcard;
	}

	public String getIndEquipoPrestado()
	{
		return indEquipoPrestado;
	}

	public void setIndEquipoPrestado(String indEquipoPrestado)
	{
		this.indEquipoPrestado = indEquipoPrestado;
	}

	public void setCodGama(Long codGama)
	{
		this.codGama = codGama;
	}

	public Long getCodGama()
	{
		return codGama;
	}

	public void setDesGama(String desGama)
	{
		this.desGama = desGama;
	}

	public String getDesGama()
	{
		return desGama;
	}

	public final String getDesTecnologia()
	{
		return desTecnologia;
	}

	public final void setDesTecnologia(String desTecnologia)
	{
		this.desTecnologia = desTecnologia;
	}

}
