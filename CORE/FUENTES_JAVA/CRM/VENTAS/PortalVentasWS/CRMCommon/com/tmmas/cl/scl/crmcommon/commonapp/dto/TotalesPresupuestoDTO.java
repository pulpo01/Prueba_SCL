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

public class TotalesPresupuestoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private float totalCargos;
	private float totalDescuentos;
	private float totalImpuestos;
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
