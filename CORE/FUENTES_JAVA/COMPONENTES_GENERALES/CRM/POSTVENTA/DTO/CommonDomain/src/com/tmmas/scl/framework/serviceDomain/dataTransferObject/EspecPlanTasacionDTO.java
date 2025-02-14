/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class EspecPlanTasacionDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPlanTasacion;
	private String nombre;
	private String descripcion;
	private String tipoPlataforma;
	private String tipoComportamiento;
	
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getIdPlanTasacion() {
		return idPlanTasacion;
	}
	public void setIdPlanTasacion(String idPlanTasacion) {
		this.idPlanTasacion = idPlanTasacion;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	public String getTipoPlataforma() {
		return tipoPlataforma;
	}
	public void setTipoPlataforma(String tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}
}
