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

public class ContratoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoTipoContrato;
	private String descripcionTipoContrato;
	private int indComodato;
	private int codProducto;
	
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public String getDescripcionTipoContrato() {
		return descripcionTipoContrato;
	}
	public void setDescripcionTipoContrato(String descripcionTipoContrato) {
		this.descripcionTipoContrato = descripcionTipoContrato;
	}
	public int getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(int indComodato) {
		this.indComodato = indComodato;
	}
}
