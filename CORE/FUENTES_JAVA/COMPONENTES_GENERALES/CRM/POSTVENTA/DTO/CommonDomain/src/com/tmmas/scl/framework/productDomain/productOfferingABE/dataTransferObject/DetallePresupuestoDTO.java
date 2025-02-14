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
 * 25/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class DetallePresupuestoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String desConceptoRep;
	private int numUnidades;
	private float impBase;
	private float impImpuesto;
	private float impDcto;
	private float impTotal;
	
	public String getDesConceptoRep() {
		return desConceptoRep;
	}
	public void setDesConceptoRep(String desConceptoRep) {
		this.desConceptoRep = desConceptoRep;
	}
	public float getImpBase() {
		return impBase;
	}
	public void setImpBase(float impBase) {
		this.impBase = impBase;
	}
	public float getImpDcto() {
		return impDcto;
	}
	public void setImpDcto(float impDcto) {
		this.impDcto = impDcto;
	}
	public float getImpImpuesto() {
		return impImpuesto;
	}
	public void setImpImpuesto(float impImpuesto) {
		this.impImpuesto = impImpuesto;
	}
	public float getImpTotal() {
		return impTotal;
	}
	public void setImpTotal(float impTotal) {
		this.impTotal = impTotal;
	}
	public int getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(int numUnidades) {
		this.numUnidades = numUnidades;
	}
	
}
