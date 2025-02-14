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
 * 30/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class TipoComisionistaDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoTipoComisionista;
	private String descripcionTipoComisionista;
	private String indExterno;
	public String getIndExterno() {
		return indExterno;
	}
	public void setIndExterno(String indExterno) {
		this.indExterno = indExterno;
	}
	public String getCodigoTipoComisionista() {
		return codigoTipoComisionista;
	}
	public void setCodigoTipoComisionista(String codigoTipoComisionista) {
		this.codigoTipoComisionista = codigoTipoComisionista;
	}
	public String getDescripcionTipoComisionista() {
		return descripcionTipoComisionista;
	}
	public void setDescripcionTipoComisionista(String descripcionTipoComisionista) {
		this.descripcionTipoComisionista = descripcionTipoComisionista;
	}
}
