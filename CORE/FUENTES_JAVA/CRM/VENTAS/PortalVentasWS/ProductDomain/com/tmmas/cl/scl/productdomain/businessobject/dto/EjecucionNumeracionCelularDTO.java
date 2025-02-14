/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 *
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;


public class EjecucionNumeracionCelularDTO	implements	Serializable 
{
	private static final long serialVersionUID = -5636393482107989433L;
	private Long numCelular;
	private String accion;
	private Long numAbonado;
	
	/**
	 * @return the accion
	 */
	public String getAccion() {
		return accion;
	}
	/**
	 * @param accion the accion to set
	 */
	public void setAccion(String accion) {
		this.accion = accion;
	}
	/**
	 * @return the numCelular
	 */
	public Long getNumCelular() {
		return numCelular;
	}
	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado() {
		return numAbonado;
	}
	/**
	 * @param numAbonado the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}


}
