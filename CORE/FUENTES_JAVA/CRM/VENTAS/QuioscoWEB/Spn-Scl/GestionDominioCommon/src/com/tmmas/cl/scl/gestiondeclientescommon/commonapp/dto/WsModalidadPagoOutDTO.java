/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 15/06/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsModalidadPagoOutDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int codSisPago;
	private String desSisPago;
	private int indInterno;
	private int indManual;
	public int getCodSisPago() {
		return codSisPago;
	}
	public void setCodSisPago(int codSisPago) {
		this.codSisPago = codSisPago;
	}
	public String getDesSisPago() {
		return desSisPago;
	}
	public void setDesSisPago(String desSisPago) {
		this.desSisPago = desSisPago;
	}
	public int getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(int indInterno) {
		this.indInterno = indInterno;
	}
	public int getIndManual() {
		return indManual;
	}
	public void setIndManual(int indManual) {
		this.indManual = indManual;
	}

}
