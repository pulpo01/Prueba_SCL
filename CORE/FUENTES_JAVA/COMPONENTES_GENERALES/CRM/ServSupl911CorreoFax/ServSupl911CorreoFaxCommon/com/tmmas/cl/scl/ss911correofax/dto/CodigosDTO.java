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
 * 13/03/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class CodigosDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigoValor;
	private String descripcionValor;
	
	private String codigoModulo;
	private String tabla;
	private String columna;
	
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getCodigoValor() {
		return codigoValor;
	}
	public void setCodigoValor(String codigoValor) {
		this.codigoValor = codigoValor;
	}
	public String getColumna() {
		return columna;
	}
	public void setColumna(String columna) {
		this.columna = columna;
	}
	public String getDescripcionValor() {
		return descripcionValor;
	}
	public void setDescripcionValor(String descripcionValor) {
		this.descripcionValor = descripcionValor;
	}
	public String getTabla() {
		return tabla;
	}
	public void setTabla(String tabla) {
		this.tabla = tabla;
	}
	
	
}
