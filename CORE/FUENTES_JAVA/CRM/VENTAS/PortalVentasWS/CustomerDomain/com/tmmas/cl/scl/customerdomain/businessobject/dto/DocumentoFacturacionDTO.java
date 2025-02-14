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
 * 12/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DocumentoFacturacionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String indiceCiclo;
	private String codigoCliente;
	private String fechaEmision;
	
	private float promedioFacturado;
	private int numeroMeses;
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getFechaEmision() {
		return fechaEmision;
	}
	public void setFechaEmision(String fechaEmision) {
		this.fechaEmision = fechaEmision;
	}
	public String getIndiceCiclo() {
		return indiceCiclo;
	}
	public void setIndiceCiclo(String indiceCiclo) {
		this.indiceCiclo = indiceCiclo;
	}
	public int getNumeroMeses() {
		return numeroMeses;
	}
	public void setNumeroMeses(int numeroMeses) {
		this.numeroMeses = numeroMeses;
	}
	public float getPromedioFacturado() {
		return promedioFacturado;
	}
	public void setPromedioFacturado(float promedioFacturado) {
		this.promedioFacturado = promedioFacturado;
	}
	
	

}
