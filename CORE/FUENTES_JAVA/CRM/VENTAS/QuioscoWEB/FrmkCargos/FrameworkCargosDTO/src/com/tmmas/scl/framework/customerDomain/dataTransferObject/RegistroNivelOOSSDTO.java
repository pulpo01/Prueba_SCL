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
 * 09/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class RegistroNivelOOSSDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String tipSujeto;
	private long numAbonado;
	private long codCliente;
	private String codTipMod;
	private Date fecModifica;
	private String nomUsuaOra;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodTipMod() {
		return codTipMod;
	}
	public void setCodTipMod(String codTipMod) {
		this.codTipMod = codTipMod;
	}
	public Date getFecModifica() {
		return fecModifica;
	}
	public void setFecModifica(Date fecModifica) {
		this.fecModifica = fecModifica;
	}
	public String getNomUsuaOra() {
		return nomUsuaOra;
	}
	public void setNomUsuaOra(String nomUsuaOra) {
		this.nomUsuaOra = nomUsuaOra;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipSujeto() {
		return tipSujeto;
	}
	public void setTipSujeto(String tipSujeto) {
		this.tipSujeto = tipSujeto;
	}


	
}
