/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba,
 * Santiago de Chile, Chile Todos los derechos reservados. Este software es informaci&oacute;n propietaria y
 * confidencial de TM-mAs SA. Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia con los
 * t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs. Fecha ------------------- Autor
 * ------------------------- Cambios ---------- 04/04/2007 Héctor Hermosilla Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ReglaSSDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int codProducto;
	private String codServicio;
	private String CodServDef;
	private String CodServOrig;
	private int tipoRelacion;
	private String codActAbo;
	private String nomUsuario;
	
	private String codCentral;
	private String tipTerminal;
	private String codTecnologia;
	
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}	
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}	
	public int getTipoRelacion() {
		return tipoRelacion;
	}
	public void setTipoRelacion(int tipoRelacion) {
		this.tipoRelacion = tipoRelacion;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServDef() {
		return CodServDef;
	}
	public void setCodServDef(String codServDef) {
		CodServDef = codServDef;
	}
	public String getCodServOrig() {
		return CodServOrig;
	}
	public void setCodServOrig(String codServOrig) {
		CodServOrig = codServOrig;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	
}
