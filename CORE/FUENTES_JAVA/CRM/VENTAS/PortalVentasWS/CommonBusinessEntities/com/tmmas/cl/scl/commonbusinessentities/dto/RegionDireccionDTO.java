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
 * 06/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.commonbusinessentities.dto;

import com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO;

public class RegionDireccionDTO extends ConceptoDireccionDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoRegion;
	private String descripcionRegion;
	
	public String indiceDefecto = "-1";
	public String getCodigoRegion() {
		return codigoRegion;
	}
	public void setCodigoRegion(String codigoRegion) {
		this.codigoRegion = codigoRegion;
	}
	public String getDescripcionRegion() {
		return descripcionRegion;
	}
	public void setDescripcionRegion(String descripcionRegion) {
		this.descripcionRegion = descripcionRegion;
	}
	

}
