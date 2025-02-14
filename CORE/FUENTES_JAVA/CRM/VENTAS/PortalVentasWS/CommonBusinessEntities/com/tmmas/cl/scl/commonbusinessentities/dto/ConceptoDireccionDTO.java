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

import java.io.Serializable;


public class ConceptoDireccionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int codigoConcepto;
	private String nombreColumna;
	private String caption;
	private String tipoControl;
	private int posicion;
	private boolean obligatoriedad;
	private Integer identificadorConcepto;
	private int largoMaximo;
	private int valorPorDefecto;
	private DatosDireccionDTO[] datosDireccionDTO;
	
	public DatosDireccionDTO[] getDatosDireccionDTO() {
		return datosDireccionDTO;
	}
	public void setDatosDireccionDTO(DatosDireccionDTO[] datosDireccionDTO) {
		this.datosDireccionDTO = datosDireccionDTO;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public Integer getIdentificadorConcepto() {
		return identificadorConcepto;
	}
	public void setIdentificadorConcepto(Integer identificadorConcepto) {
		this.identificadorConcepto = identificadorConcepto;
	}
	public boolean isObligatoriedad() {
		return obligatoriedad;
	}
	public void setObligatoriedad(boolean obligatoriedad) {
		this.obligatoriedad = obligatoriedad;
	}
	public int getPosicion() {
		return posicion;
	}
	public void setPosicion(int posicion) {
		this.posicion = posicion;
	}
	public String getTipoControl() {
		return tipoControl;
	}
	public void setTipoControl(String tipoControl) {
		this.tipoControl = tipoControl;
	}
	public int getLargoMaximo() {
		return largoMaximo;
	}
	public void setLargoMaximo(int largoMaximo) {
		this.largoMaximo = largoMaximo;
	}
	public int getValorPorDefecto() {
		return valorPorDefecto;
	}
	public void setValorPorDefecto(int valorPorDefecto) {
		this.valorPorDefecto = valorPorDefecto;
	}
	public int getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(int codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getNombreColumna() {
		return nombreColumna;
	}
	public void setNombreColumna(String nombreColumna) {
		this.nombreColumna = nombreColumna;
	}

}
