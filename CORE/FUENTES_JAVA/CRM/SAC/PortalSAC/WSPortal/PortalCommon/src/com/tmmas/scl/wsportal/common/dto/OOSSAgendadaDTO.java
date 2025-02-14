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

public class OOSSAgendadaDTO implements Serializable{
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_005
	 * Caso de uso: CU-009 Obtener OOSS Agendadas 
	 * Developer: Jorge González N.
	 * Fecha: 13/07/2010
	 * 
	 */	
	private static final long serialVersionUID = 7244286643540151259L;
	
	private Long 	numOOSS;
	private String 	descripcionOOSS;
	private Integer codEstado;
	private	String 	fechaIngreso;
	private	String 	fechaEjecucion;
	private String 	usuario;
	private String 	comentario;
	private String 	descripcion;
	private String 	status;
	private String 	desProceso;
	
	public Long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(Long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getDescripcionOOSS() {
		return descripcionOOSS;
	}
	public void setDescripcionOOSS(String descripcionOOSS) {
		this.descripcionOOSS = descripcionOOSS;
	}
	public Integer getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(Integer codEstado) {
		this.codEstado = codEstado;
	}
	public String getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(String fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	public String getFechaEjecucion() {
		return fechaEjecucion;
	}
	public void setFechaEjecucion(String fechaEjecucion) {
		this.fechaEjecucion = fechaEjecucion;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDesProceso() {
		return desProceso;
	}
	public void setDesProceso(String desProceso) {
		this.desProceso = desProceso;
	}
}
