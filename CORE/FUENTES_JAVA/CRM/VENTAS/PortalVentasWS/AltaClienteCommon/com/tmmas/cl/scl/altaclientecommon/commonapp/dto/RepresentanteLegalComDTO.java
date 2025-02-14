/* Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class RepresentanteLegalComDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoTipoIdentificacion;
	private String numeroTipoIdentificacion;
	private String nombre;
	
    //valores nuevos GUATEMALA - EL SALVADOR	
	private String apellido1;
	private String apellido2;
	private String codigoTipoRepresentante;
	
	
	
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumeroTipoIdentificacion() {
		return numeroTipoIdentificacion;
	}
	public void setNumeroTipoIdentificacion(String numeroTipoIdentificacion) {
		this.numeroTipoIdentificacion = numeroTipoIdentificacion;
	}
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public String getCodigoTipoRepresentante() {
		return codigoTipoRepresentante;
	}
	public void setCodigoTipoRepresentante(String codigoTipoRepresentante) {
		this.codigoTipoRepresentante = codigoTipoRepresentante;
	}

}
