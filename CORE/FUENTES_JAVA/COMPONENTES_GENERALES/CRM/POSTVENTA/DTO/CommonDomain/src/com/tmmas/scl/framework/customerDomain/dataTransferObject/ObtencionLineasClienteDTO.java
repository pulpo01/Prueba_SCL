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
 * 20/11/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ObtencionLineasClienteDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String codTipIdent;
	private String numIdent;
	private long codCuenta;
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}

}
