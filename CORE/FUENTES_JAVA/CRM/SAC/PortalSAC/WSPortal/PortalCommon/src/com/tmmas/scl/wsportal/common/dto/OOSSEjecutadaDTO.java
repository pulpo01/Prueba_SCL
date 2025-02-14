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

public class OOSSEjecutadaDTO implements Serializable
{
	private static final long serialVersionUID = 7244286643540151259L;

	private Long numOOSS;

	private String descripcion;

	private String nomUsuario;
	
	String textoDetalle;
	
	String codigo;

	private String fechaEjecucion;

	private String status;
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_004
	 * Caso de uso: CU-007 Desplegar Comentario para OOSS Ejecutadas de Clientes
	 * Developer: Gabriel Moraga L.
	 * Fecha: 12/07/2010
	 * 
	 */
	
	private String comentario;
	
	//Es para el ordenamiento de la tabla
	private String fechaEjecucionOrd;

	public String getDescripcion()
	{
		return descripcion;
	}

	public void setDescripcion(String descripcion)
	{
		this.descripcion = descripcion;
	}

	public String getFechaEjecucion()
	{
		return fechaEjecucion;
	}

	public void setFechaEjecucion(String fechaEjecucion)
	{
		this.fechaEjecucion = fechaEjecucion;
	}

	public String getNomUsuario()
	{
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario)
	{
		this.nomUsuario = nomUsuario;
	}

	public Long getNumOOSS()
	{
		return numOOSS;
	}

	public void setNumOOSS(Long numOOSS)
	{
		this.numOOSS = numOOSS;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}


	public final String getTextoDetalle()
	{
		return textoDetalle;
	}

	public final void setTextoDetalle(String textoDetalle)
	{
		this.textoDetalle = textoDetalle;
	}


	public final String getCodigo()
	{
		return codigo;
	}

	public final void setCodigo(String codOS)
	{
		this.codigo = codOS;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public String getFechaEjecucionOrd() {
		return fechaEjecucionOrd;
	}

	public void setFechaEjecucionOrd(String fechaEjecucionOrd) {
		this.fechaEjecucionOrd = fechaEjecucionOrd;
	}
	
}