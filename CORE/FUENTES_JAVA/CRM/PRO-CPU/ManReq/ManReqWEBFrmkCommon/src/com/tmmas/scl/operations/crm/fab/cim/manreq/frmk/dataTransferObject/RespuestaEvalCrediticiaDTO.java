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
 * 25/07/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

public class RespuestaEvalCrediticiaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoError;
	private String mensajeError;
	private String continuaVenta;
	private String calidadVenta;
	private String calidadCifra;
	private String limiteConsumo;
	private String limiteCliente;
	private boolean resultado;
	
	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public String getCalidadCifra() {
		return calidadCifra;
	}
	public void setCalidadCifra(String calidadCifra) {
		this.calidadCifra = calidadCifra;
	}
	public String getCalidadVenta() {
		return calidadVenta;
	}
	public void setCalidadVenta(String calidadVenta) {
		this.calidadVenta = calidadVenta;
	}
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	public String getContinuaVenta() {
		return continuaVenta;
	}
	public void setContinuaVenta(String continuaVenta) {
		this.continuaVenta = continuaVenta;
	}
	public String getLimiteCliente() {
		return limiteCliente;
	}
	public void setLimiteCliente(String limiteCliente) {
		this.limiteCliente = limiteCliente;
	}
	public String getLimiteConsumo() {
		return limiteConsumo;
	}
	public void setLimiteConsumo(String limiteConsumo) {
		this.limiteConsumo = limiteConsumo;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	
}
