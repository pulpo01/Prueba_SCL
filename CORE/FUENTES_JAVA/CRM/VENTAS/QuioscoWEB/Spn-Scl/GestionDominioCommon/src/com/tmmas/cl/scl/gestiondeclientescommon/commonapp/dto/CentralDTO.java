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

package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CentralDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoCentral;
	private String descripcionCentral;
	private String codigoTecnologia;
	private int codigoProducto;
	private int codigoSistema;
	private String codigoSubAlm;
	private String codigoCelda;
	
	private String nomCentral;
	private String codNemotec;
	private String codAlm;
	private String numMaxintentos;	
	private String codCobertura;
	private String tieRespuesta;
	private String nodocom;	
	private String codHlr;
	
	private String codGrupoTecnologico;
		
	public String getCodigoCelda() {
		return codigoCelda;
	}
	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}
	public String getCodigoSubAlm() {
		return codigoSubAlm;
	}
	public void setCodigoSubAlm(String codigoSubAlm) {
		this.codigoSubAlm = codigoSubAlm;
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
	public String getCodAlm() {
		return codAlm;
	}
	public void setCodAlm(String codAlm) {
		this.codAlm = codAlm;
	}
	public String getCodCobertura() {
		return codCobertura;
	}
	public void setCodCobertura(String codCobertura) {
		this.codCobertura = codCobertura;
	}
	public String getCodHlr() {
		return codHlr;
	}
	public void setCodHlr(String codHlr) {
		this.codHlr = codHlr;
	}
	public String getCodNemotec() {
		return codNemotec;
	}
	public void setCodNemotec(String codNemotec) {
		this.codNemotec = codNemotec;
	}
	public String getNodocom() {
		return nodocom;
	}
	public void setNodocom(String nodocom) {
		this.nodocom = nodocom;
	}
	public String getNomCentral() {
		return nomCentral;
	}
	public void setNomCentral(String nomCentral) {
		this.nomCentral = nomCentral;
	}
	public String getNumMaxintentos() {
		return numMaxintentos;
	}
	public void setNumMaxintentos(String numMaxintentos) {
		this.numMaxintentos = numMaxintentos;
	}
	public String getTieRespuesta() {
		return tieRespuesta;
	}
	public void setTieRespuesta(String tieRespuesta) {
		this.tieRespuesta = tieRespuesta;
	}
	public String getCodGrupoTecnologico() {
		return codGrupoTecnologico;
	}
	public void setCodGrupoTecnologico(String codGrupoTecnologico) {
		this.codGrupoTecnologico = codGrupoTecnologico;
	}

}
