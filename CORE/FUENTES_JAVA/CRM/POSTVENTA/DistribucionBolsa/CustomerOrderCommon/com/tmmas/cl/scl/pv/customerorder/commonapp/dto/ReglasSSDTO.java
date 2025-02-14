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
 * 23/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class ReglasSSDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codServicio;
	private int codProducto;
	private String codServDef;
	private String nomUsuario;
	private String codServOrig;
	private int tipoRelacion;
	private String codActAbo;
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServDef() {
		return codServDef;
	}
	public void setCodServDef(String codServDef) {
		this.codServDef = codServDef;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getCodServOrig() {
		return codServOrig;
	}
	public void setCodServOrig(String codServOrig) {
		this.codServOrig = codServOrig;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public int getTipoRelacion() {
		return tipoRelacion;
	}
	public void setTipoRelacion(int tipoRelacion) {
		this.tipoRelacion = tipoRelacion;
	}
	
	

}
