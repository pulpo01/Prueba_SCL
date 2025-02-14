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

public class DetalleLlamadaDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String fechaLlamada;

	private String celularOrig;

	private String celularDest;

	private Long duracion;

	private Double valor;

	private String horario;

	public String getCelularDest()
	{
		return celularDest;
	}

	public void setCelularDest(String celularDest)
	{
		this.celularDest = celularDest;
	}

	public String getCelularOrig()
	{
		return celularOrig;
	}

	public void setCelularOrig(String celularOrig)
	{
		this.celularOrig = celularOrig;
	}

	public Long getDuracion()
	{
		return duracion;
	}

	public void setDuracion(Long duracion)
	{
		this.duracion = duracion;
	}

	public String getHorario()
	{
		return horario;
	}

	public void setHorario(String horario)
	{
		this.horario = horario;
	}

	public Double getValor()
	{
		return valor;
	}

	public void setValor(Double valor)
	{
		this.valor = valor;
	}

	public String getFechaLlamada()
	{
		return fechaLlamada;
	}

	public void setFechaLlamada(String fechaLlamada)
	{
		this.fechaLlamada = fechaLlamada;
	}

}
