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
 * 05/05/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ProcesoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private boolean  estadoValidacion;
	private boolean estadoEjecucion;
	private long codigoError;
	private long evento;
	private String tipoProceso;
	private long identificadorProceso;
	private String mensajeError;
	
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(long codigoError) {
		this.codigoError = codigoError;
	}
	public boolean isEstadoEjecucion() {
		return estadoEjecucion;
	}
	public void setEstadoEjecucion(boolean estadoEjecucion) {
		this.estadoEjecucion = estadoEjecucion;
	}
	public boolean isEstadoValidacion() {
		return estadoValidacion;
	}
	public void setEstadoValidacion(boolean estadoValidacion) {
		this.estadoValidacion = estadoValidacion;
	}
	public long getEvento() {
		return evento;
	}
	public void setEvento(long evento) {
		this.evento = evento;
	}
	public long getIdentificadorProceso() {
		return identificadorProceso;
	}
	public void setIdentificadorProceso(long identificadorProceso) {
		this.identificadorProceso = identificadorProceso;
	}
	public String getTipoProceso() {
		return tipoProceso;
	}
	public void setTipoProceso(String tipoProceso) {
		this.tipoProceso = tipoProceso;
	}
	
	
	

}
