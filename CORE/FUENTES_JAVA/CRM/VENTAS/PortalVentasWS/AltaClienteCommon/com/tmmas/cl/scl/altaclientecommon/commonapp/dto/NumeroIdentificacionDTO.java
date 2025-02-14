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
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class NumeroIdentificacionDTO  implements Serializable{	
	
	private static final long serialVersionUID = 1L;
	
	private String codigoModulo;
	private Long correlativo;
	private String numIdentif;
	private String tipoIdentif;	
	private String formatoNIT; 
	
	public String getFormatoNIT() {
		return formatoNIT;
	}
	public void setFormatoNIT(String formatoNIT) {
		this.formatoNIT = formatoNIT;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public Long getCorrelativo() {
		return correlativo;
	}
	public void setCorrelativo(Long correlativo) {
		this.correlativo = correlativo;
	}
	public String getNumIdentif() {
		return numIdentif;
	}
	public void setNumIdentif(String numIdentif) {
		this.numIdentif = numIdentif;
	}
	public String getTipoIdentif() {
		return tipoIdentif;
	}
	public void setTipoIdentif(String tipoIdentif) {
		this.tipoIdentif = tipoIdentif;
	}
	
	
	
	
}
