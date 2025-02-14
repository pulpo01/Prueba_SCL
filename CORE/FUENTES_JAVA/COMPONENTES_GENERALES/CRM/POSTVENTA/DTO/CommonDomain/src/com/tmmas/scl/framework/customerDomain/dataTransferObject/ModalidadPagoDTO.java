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
 * 24/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ModalidadPagoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoModalidadPago;
	private String descripcionModalidadPago;
	private int indicadorCuotas;
	
	public String getCodigoModalidadPago() {
		return codigoModalidadPago;
	}
	public void setCodigoModalidadPago(String codigoModalidadPago) {
		this.codigoModalidadPago = codigoModalidadPago;
	}
	public String getDescripcionModalidadPago() {
		return descripcionModalidadPago;
	}
	public void setDescripcionModalidadPago(String descripcionModalidadPago) {
		this.descripcionModalidadPago = descripcionModalidadPago;
	}
	public int getIndicadorCuotas() {
		return indicadorCuotas;
	}
	public void setIndicadorCuotas(int indicadorCuotas) {
		this.indicadorCuotas = indicadorCuotas;
	}

}
