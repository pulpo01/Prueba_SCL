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
 * 19/07/2007              Raúl Lozano      					Versión Inicial
 */

package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ServicioSuplementarioDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codigoServicio;
	private String numeroAbonado;
	private String codigoPlan;
	private String codigoServSupl;
	private String codigoNivel;
	private String codigoConcepto;
	private String numeroTerminal;
	private String codigoProducto;
	private String codigoPlanServicio;
	private String codigoActuacion;
	//-- PARA CENTRAL
	private int indicadorEstado;
		
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	
	public Long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(Long codigoError) {
		this.codigoError = codigoError;
	}
	public String getCodigoPlan() {
		return codigoPlan;
	}
	public void setCodigoPlan(String codigoPlan) {
		this.codigoPlan = codigoPlan;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}
	public String getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public Long getNumeroEvento() {
		return numeroEvento;
	}
	public void setNumeroEvento(Long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}
	public String getNumeroTerminal() {
		return numeroTerminal;
	}
	public void setNumeroTerminal(String numeroTerminal) {
		this.numeroTerminal = numeroTerminal;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoNivel() {
		return codigoNivel;
	}
	public void setCodigoNivel(String codigoNivel) {
		this.codigoNivel = codigoNivel;
	}
	public String getCodigoServSupl() {
		return codigoServSupl;
	}
	public void setCodigoServSupl(String codigoServSupl) {
		this.codigoServSupl = codigoServSupl;
	}
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoActuacion() {
		return codigoActuacion;
	}
	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	public int getIndicadorEstado() {
		return indicadorEstado;
	}
	public void setIndicadorEstado(int indicadorEstado) {
		this.indicadorEstado = indicadorEstado;
	}

}//fin ServicioSuplementarioDTO
