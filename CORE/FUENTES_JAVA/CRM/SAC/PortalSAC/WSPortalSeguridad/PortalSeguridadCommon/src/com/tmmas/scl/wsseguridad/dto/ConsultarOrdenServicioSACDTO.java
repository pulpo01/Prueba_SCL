package com.tmmas.scl.wsseguridad.dto;


/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 07/07/2008     Héctor Hermosilla      			Versión Inicial 
 * 
 *
 * 
 * 
 * @author Héctor Hermosilla
 * @version 1.0
 **/

public class ConsultarOrdenServicioSACDTO {

	private static final long serialVersionUID = 1L;
	
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;	
	public int servicio;
	
	
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}
	public long getNroOOSS() {
		return nroOOSS;
	}
	public void setNroOOSS(long nroOOSS) {
		this.nroOOSS = nroOOSS;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	
	
}
