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
 * 09/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class FormadePagoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String tipoValor;
	private String descripcionTipoValor;
	public String getDescripcionTipoValor() {
		return descripcionTipoValor;
	}
	public void setDescripcionTipoValor(String descripcionTipoValor) {
		this.descripcionTipoValor = descripcionTipoValor;
	}
	public String getTipoValor() {
		return tipoValor;
	}
	public void setTipoValor(String tipoValor) {
		this.tipoValor = tipoValor;
	}

}
