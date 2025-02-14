/* Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.commonbusinessentities.dto;

import com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO;

public class CiudadDireccionDTO extends ConceptoDireccionDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoRegion;
	private String codigoProvincia;
	private String codigoCiudad;
	private String descripcionCiudad;
	public  String indiceDefecto = "-1";
	
	public String getCodigoCiudad() {
		return codigoCiudad;
	}
	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
	}
	public String getDescripcionCiudad() {
		return descripcionCiudad;
	}
	public void setDescripcionCiudad(String descripcionCiudad) {
		this.descripcionCiudad = descripcionCiudad;
	}
	public String getCodigoProvincia() {
		return codigoProvincia;
	}
	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
	}
	

}
