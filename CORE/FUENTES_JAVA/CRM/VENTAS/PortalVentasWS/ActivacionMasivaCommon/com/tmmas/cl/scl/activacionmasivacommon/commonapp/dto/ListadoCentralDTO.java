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
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
 */

package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class ListadoCentralDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoCentral;
	private String descripcionCentral;
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getDescripcionCentral() {
		return descripcionCentral;
	}
	public void setDescripcionCentral(String descripcionCentral) {
		this.descripcionCentral = descripcionCentral;
	}

}
