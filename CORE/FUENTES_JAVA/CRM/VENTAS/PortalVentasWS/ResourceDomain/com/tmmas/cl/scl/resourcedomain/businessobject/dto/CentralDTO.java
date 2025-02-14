/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
 */

package com.tmmas.cl.scl.resourcedomain.businessobject.dto;

import java.io.Serializable;

public class CentralDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoCentral;
	private String descripcionCentral;
	private String codigoTecnologia;
	//-- OTROS
	private int codigoProducto;
	private int codigoSistema;
	
	private String codigoHlr;
	private String codigoSubAlm;
	private String codActabo;
	
		
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getDescripcionCentral() {
		return descripcionCentral;
	}
	public void setDescripcionCentral(String descripcionCentral) {
		this.descripcionCentral = descripcionCentral;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public int getCodigoSistema() {
		return codigoSistema;
	}
	public void setCodigoSistema(int codigoSistema) {
		this.codigoSistema = codigoSistema;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoHlr() {
		return codigoHlr;
	}
	public void setCodigoHlr(String codigoHlr) {
		this.codigoHlr = codigoHlr;
	}
	public String getCodigoSubAlm() {
		return codigoSubAlm;
	}
	public void setCodigoSubAlm(String codigoSubAlm) {
		this.codigoSubAlm = codigoSubAlm;
	}

}
