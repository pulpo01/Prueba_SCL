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
 * 10/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class DesbordeDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codigoDesborde;
	private String descripcionDesborde;
	

	public String getCodigoDesborde() {
		return codigoDesborde;
	}

	public void setCodigoDesborde(String codigoDesborde) {
		this.codigoDesborde = codigoDesborde;
	}

	public String getDescripcionDesborde() {
		return descripcionDesborde;
	}

	public void setDescripcionDesborde(String descripcionDesborde) {
		this.descripcionDesborde = descripcionDesborde;
	}	

}
