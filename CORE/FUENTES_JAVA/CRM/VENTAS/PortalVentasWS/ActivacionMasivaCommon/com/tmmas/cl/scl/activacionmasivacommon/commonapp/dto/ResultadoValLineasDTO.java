package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;
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
 * 14/05/2007     H&eacute;ctor Hermosilla              					Versión Inicial
 */

public class ResultadoValLineasDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigoPlanTarifario;
	private String numeroSerie;
	private String numeroSerieTerminal;
	private String numeroCelular;
	private String estado;
	private String detalleEstado;
	
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDetalleEstado() {
		return detalleEstado;
	}
	public void setDetalleEstado(String detalleEstado) {
		this.detalleEstado = detalleEstado;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getNumeroSerieTerminal() {
		return numeroSerieTerminal;
	}
	public void setNumeroSerieTerminal(String numeroSerieTerminal) {
		this.numeroSerieTerminal = numeroSerieTerminal;
	}

}

