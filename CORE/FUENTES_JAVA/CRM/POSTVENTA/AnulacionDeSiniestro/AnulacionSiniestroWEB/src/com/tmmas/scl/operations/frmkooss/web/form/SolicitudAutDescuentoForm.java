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
 * 05/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.frmkooss.web.form;

import org.apache.struts.action.ActionForm;

public class SolicitudAutDescuentoForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
	private String numAutorizacion = " ";
	private String estadoSolicitud = " ";
	private String estadoSolicitudGlosa = " ";
	private String accion = " ";
	private String estadoSolicitudPendiente = " ";
	private String estadoSolicitudAutorizada = " ";
	private String estadoSolicitudCancelada = " ";
	private boolean flgIniciado;

	public String getEstadoSolicitudGlosa() {
		return estadoSolicitudGlosa;
	}
	public void setEstadoSolicitudGlosa(String estadoSolicitudGlosa) {
		this.estadoSolicitudGlosa = estadoSolicitudGlosa;
	}
	public boolean isFlgIniciado() {
		return flgIniciado;
	}
	public void setFlgIniciado(boolean flgIniciado) {
		this.flgIniciado = flgIniciado;
	}
	public String getEstadoSolicitudAutorizada() {
		return estadoSolicitudAutorizada;
	}
	public void setEstadoSolicitudAutorizada(String estadoSolicitudAutorizada) {
		this.estadoSolicitudAutorizada = estadoSolicitudAutorizada;
	}
	public String getEstadoSolicitudCancelada() {
		return estadoSolicitudCancelada;
	}
	public void setEstadoSolicitudCancelada(String estadoSolicitudCancelada) {
		this.estadoSolicitudCancelada = estadoSolicitudCancelada;
	}
	public String getEstadoSolicitudPendiente() {
		return estadoSolicitudPendiente;
	}
	public void setEstadoSolicitudPendiente(String estadoSolicitudPendiente) {
		this.estadoSolicitudPendiente = estadoSolicitudPendiente;
	}
	public String getAccion() {
		return accion;
	}
	public void setAccion(String accion) {
		this.accion = accion;
	}
	public String getNumAutorizacion() {
		return numAutorizacion;
	}
	public void setNumAutorizacion(String numAutorizacion) {
		this.numAutorizacion = numAutorizacion;
	}
	public String getEstadoSolicitud() {
		return estadoSolicitud;
	}
	public void setEstadoSolicitud(String estadoSolicitud) {
		this.estadoSolicitud = estadoSolicitud;
	}
	
}
