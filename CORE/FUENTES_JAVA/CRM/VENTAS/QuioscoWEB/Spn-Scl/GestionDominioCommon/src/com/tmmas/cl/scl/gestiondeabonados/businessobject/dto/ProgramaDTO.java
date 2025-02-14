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
 * 16/03/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ProgramaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigoPrograma;
	private int numeroVersion;
	private int numeroSubVersion;
	private boolean resultadoValidacion;
	private String mensajeValidacion;
	
	
	
	public String getCodigoPrograma() {
		return codigoPrograma;
	}
	public void setCodigoPrograma(String codigoPrograma) {
		this.codigoPrograma = codigoPrograma;
	}
	public int getNumeroSubVersion() {
		return numeroSubVersion;
	}
	public void setNumeroSubVersion(int numeroSubVersion) {
		this.numeroSubVersion = numeroSubVersion;
	}
	public int getNumeroVersion() {
		return numeroVersion;
	}
	public void setNumeroVersion(int numeroVersion) {
		this.numeroVersion = numeroVersion;
	}
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
	public boolean getResultadoValidacion() {
		return resultadoValidacion;
	}
	public void setResultadoValidacion(boolean resultadoValidacion) {
		this.resultadoValidacion = resultadoValidacion;
	}
}
