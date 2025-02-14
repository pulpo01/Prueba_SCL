package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class OOSSProcesoDTO implements Serializable{
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_009
	 * Caso de uso: CU-016 Desplegar OOSS en ejecución 
	 * Developer: Jorge González N.
	 * Fecha: 13/07/2010
	 * 
	 */	
	private static final long serialVersionUID = 7244286643540151259L;
	
	private Long 	numOOSS;
	private String 	codOOSS;
	private String 	descripcionOOSS;
	private Integer tipEstado;
	private String 	descripcion;
	private String 	fechaIngreso;
	private String 	status;
	private String 	comentario;
	
	public Long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(Long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getDescripcionOOSS() {
		return descripcionOOSS;
	}
	public void setDescripcionOOSS(String descripcionOOSS) {
		this.descripcionOOSS = descripcionOOSS;
	}
	public Integer getTipEstado() {
		return tipEstado;
	}
	public void setTipEstado(Integer tipEstado) {
		this.tipEstado = tipEstado;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(String fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
}
