/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class DatosDireccionClienteINDTO implements Serializable
{

	private static final long serialVersionUID = 1L;

	private String codCliente;

	private Integer tipSujeto;

	private Integer codTipDireccion;
	
	private Integer codDisplay;
	
	private Boolean conDescripcion;

	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public Integer getTipSujeto() {
		return tipSujeto;
	}

	public void setTipSujeto(Integer tipSujeto) {
		this.tipSujeto = tipSujeto;
	}

	public Integer getCodTipDireccion() {
		return codTipDireccion;
	}

	public void setCodTipDireccion(Integer codTipDireccion) {
		this.codTipDireccion = codTipDireccion;
	}

	public Integer getCodDisplay() {
		return codDisplay;
	}

	public void setCodDisplay(Integer codDisplay) {
		this.codDisplay = codDisplay;
	}

	public Boolean getConDescripcion() {
		return conDescripcion;
	}

	public void setConDescripcion(Boolean conDescripcion) {
		this.conDescripcion = conDescripcion;
	}


} // DocCtaCteClienteDTO
