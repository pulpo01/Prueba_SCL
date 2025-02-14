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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class GrupoPrestacionDTO implements Serializable{

	private static final long serialVersionUID = 1L;
    
	private String codGrupoPrestacion;
	private String desGrupoPrestacion;
	
	public String getCodGrupoPrestacion() {
		return codGrupoPrestacion;
	}
	public void setCodGrupoPrestacion(String codGrupoPrestacion) {
		this.codGrupoPrestacion = codGrupoPrestacion;
	}
	public String getDesGrupoPrestacion() {
		return desGrupoPrestacion;
	}
	public void setDesGrupoPrestacion(String desGrupoPrestacion) {
		this.desGrupoPrestacion = desGrupoPrestacion;
	}
	
	
}
