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

public class EvalCrediticiaDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long codCliente;
	private String tipoIdentificador;
	private String numIdentificador;
	private String usuarioLink;
	private String nombres;
	private String apellido1;
	private String apellido2;
	
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getNumIdentificador() {
		return numIdentificador;
	}
	public void setNumIdentificador(String numIdentificador) {
		this.numIdentificador = numIdentificador;
	}
	public String getTipoIdentificador() {
		return tipoIdentificador;
	}
	public void setTipoIdentificador(String tipoIdentificador) {
		this.tipoIdentificador = tipoIdentificador;
	}
	public String getUsuarioLink() {
		return usuarioLink;
	}
	public void setUsuarioLink(String usuarioLink) {
		this.usuarioLink = usuarioLink;
	}
	

	
}
