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
 * 07/11/2007     Mario Tigua    					Versión Inicial
 */
package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class DatosConexionServidorDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String nombreIPServidor;
	private String puerto;
	private String codigoRegistroDireccion;

	public String getCodigoRegistroDireccion() {
		return codigoRegistroDireccion;
	}
	
	public void setCodigoRegistroDireccion(String codigoRegistroDireccion) {
		this.codigoRegistroDireccion = codigoRegistroDireccion;
	}
	
	public String getNombreIPServidor() {
		return nombreIPServidor;
	}
	
	public void setNombreIPServidor(String nombreIPServidor) {
		this.nombreIPServidor = nombreIPServidor;
	}
	
	public String getPuerto() {
		return puerto;
	}
	
	public void setPuerto(String puerto) {
		this.puerto = puerto;
	}
	
}
