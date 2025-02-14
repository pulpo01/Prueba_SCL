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
 * 09/08/2007	     	Raúl Lozano        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;


import java.io.Serializable;

public class ResultadoRegCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private float totalCargos;
	private float totalDescuentos;
	private float totalImpuestos;
	private String numeroProceso;
	private FormaPagoDTO[] arregloFormasdePago;
	
	public FormaPagoDTO[] getArregloFormasdePago() {
		return arregloFormasdePago;
	}
	public void setArregloFormasdePago(FormaPagoDTO[] arregloFormasdePago) {
		this.arregloFormasdePago = arregloFormasdePago;
	}
	public String getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(String numeroProceso) {
		this.numeroProceso = numeroProceso;
	}
	public float getTotalCargos() {
		return totalCargos;
	}
	public void setTotalCargos(float totalCargos) {
		this.totalCargos = totalCargos;
	}
	public float getTotalDescuentos() {
		return totalDescuentos;
	}
	public void setTotalDescuentos(float totalDescuentos) {
		this.totalDescuentos = totalDescuentos;
	}
	public float getTotalImpuestos() {
		return totalImpuestos;
	}
	public void setTotalImpuestos(float totalImpuestos) {
		this.totalImpuestos = totalImpuestos;
	}

}
