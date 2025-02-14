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
package com.tmmas.cl.scl.commonbusinessentities.dto;

import com.tmmas.cl.scl.commonbusinessentities.interfaz.Direccion;

public class DireccionDTO implements Direccion {
	
	private static final long serialVersionUID = 1L;
	private Integer tipo;
	private Integer formato;
	private long codigoDirecion;
	private String codigoOperadora;
	private String tablaZipCode;
	
	private ConceptoDireccionDTO[] conceptoDireccionDTOs;
	
	public long getCodigoDirecion() {
		return codigoDirecion;
	}
	public void setCodigoDirecion(long codigoDirecion) {
		this.codigoDirecion = codigoDirecion;
	}
	public ConceptoDireccionDTO[] getConceptoDireccionDTOs() {
		return conceptoDireccionDTOs;
	}
	public void setConceptoDireccionDTOs(
			ConceptoDireccionDTO[] conceptoDireccionDTOs) {
		this.conceptoDireccionDTOs = conceptoDireccionDTOs;
	}
	public Integer getFormato() {
		return formato;
	}
	public void setFormato(Integer formato) {
		this.formato = formato;
	}
	public Integer getTipo() {
		return tipo;
	}
	public void setTipo(Integer tipo) {
		this.tipo = tipo;
	}
	public String getCodigoOperadora() {
		return codigoOperadora;
	}
	public void setCodigoOperadora(String codigoOperadora) {
		this.codigoOperadora = codigoOperadora;
	}
	public String getTablaZipCode() {
		return tablaZipCode;
	}
	public void setTablaZipCode(String tablaZipCode) {
		this.tablaZipCode = tablaZipCode;
	}
	

}
