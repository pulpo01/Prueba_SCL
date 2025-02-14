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
 * 13/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

public class CargaPdfForm extends ActionForm {
	private String accion;
	private boolean flgIniciado;
	private long intervaloMilisegundos;
	private int maxIntentos;
	private int numIntento;

	public int getNumIntento() {
		return numIntento;
	}

	public void setNumIntento(int numIntento) {
		this.numIntento = numIntento;
	}

	public long getIntervaloMilisegundos() {
		return intervaloMilisegundos;
	}

	public void setIntervaloMilisegundos(long intervaloMilisegundos) {
		this.intervaloMilisegundos = intervaloMilisegundos;
	}

	public int getMaxIntentos() {
		return maxIntentos;
	}

	public void setMaxIntentos(int maxIntentos) {
		this.maxIntentos = maxIntentos;
	}

	public boolean isFlgIniciado() {
		return flgIniciado;
	}

	public void setFlgIniciado(boolean flgIniciado) {
		this.flgIniciado = flgIniciado;
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}	
	

}
