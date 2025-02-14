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
 * 05/06/2007     Sergio Muñoz      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.dto;

import java.io.Serializable;

public class EstadoAsincDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	//-- PARAMETROS
	private int numCel;
	private String codEstado;
	private String operaOrigen;
	private String operaDestino;
	private String spnPortId;
	private String numProceso;
	private String tipProceso;

	
	
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getTipProceso() {
		return tipProceso;
	}
	public void setTipProceso(String tipProceso) {
		this.tipProceso = tipProceso;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public int getNumCel() {
		return numCel;
	}
	public void setNumCel(int numCel) {
		this.numCel = numCel;
	}
	public String getOperaDestino() {
		return operaDestino;
	}
	public void setOperaDestino(String operaDestino) {
		this.operaDestino = operaDestino;
	}
	public String getOperaOrigen() {
		return operaOrigen;
	}
	public void setOperaOrigen(String operaOrigen) {
		this.operaOrigen = operaOrigen;
	}
	public String getSpnPortId() {
		return spnPortId;
	}
	public void setSpnPortId(String spnPortId) {
		this.spnPortId = spnPortId;
	}
	
}
