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
 * 15/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsTarjetaOutDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String codTarjeta;
	private String desTarjeta;
	public String getCodTarjeta() {
		return codTarjeta;
	}
	public void setCodTarjeta(String codTarjeta) {
		this.codTarjeta = codTarjeta;
	}
	public String getDesTarjeta() {
		return desTarjeta;
	}
	public void setDesTarjeta(String desTarjeta) {
		this.desTarjeta = desTarjeta;
	}

}
