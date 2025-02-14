/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ConversionMonetariaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
		
	private float totalCargosOrigen;
	private float totalCargosDestino;
	private long codCliente;
	private String fechaOrigen;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getFechaOrigen() {
		return fechaOrigen;
	}
	public void setFechaOrigen(String fechaOrigen) {
		this.fechaOrigen = fechaOrigen;
	}
	public float getTotalCargosDestino() {
		return totalCargosDestino;
	}
	public void setTotalCargosDestino(float totalCargosDestino) {
		this.totalCargosDestino = totalCargosDestino;
	}
	public float getTotalCargosOrigen() {
		return totalCargosOrigen;
	}
	public void setTotalCargosOrigen(float totalCargosOrigen) {
		this.totalCargosOrigen = totalCargosOrigen;
	}	
	
}