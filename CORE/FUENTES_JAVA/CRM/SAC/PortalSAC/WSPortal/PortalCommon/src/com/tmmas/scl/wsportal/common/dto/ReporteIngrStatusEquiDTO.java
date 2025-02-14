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

public class ReporteIngrStatusEquiDTO implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String fecIngr;
	private String equipo;
	private String equiMarca;
	private String equiModelo;
	private String equiSerie;
	private String abonado;
	private String celular;
	private String codCliente;
	private String status;
	private String stsFecha;
	private String stsStatus;
	private String stsUsuario;
	private String etapa;
	private String tipTerminal;
	
	public String getFecIngr() {
		return fecIngr;
	}
	public void setFecIngr(String fecIngr) {
		this.fecIngr = fecIngr;
	}
	public String getEquipo() {
		return equipo;
	}
	public void setEquipo(String equipo) {
		this.equipo = equipo;
	}
	public String getEquiMarca() {
		return equiMarca;
	}
	public void setEquiMarca(String equiMarca) {
		this.equiMarca = equiMarca;
	}
	public String getEquiModelo() {
		return equiModelo;
	}
	public void setEquiModelo(String equiModelo) {
		this.equiModelo = equiModelo;
	}
	public String getEquiSerie() {
		return equiSerie;
	}
	public void setEquiSerie(String equiSerie) {
		this.equiSerie = equiSerie;
	}
	public String getAbonado() {
		return abonado;
	}
	public void setAbonado(String abonado) {
		this.abonado = abonado;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStsFecha() {
		return stsFecha;
	}
	public void setStsFecha(String stsFecha) {
		this.stsFecha = stsFecha;
	}
	public String getStsStatus() {
		return stsStatus;
	}
	public void setStsStatus(String stsStatus) {
		this.stsStatus = stsStatus;
	}
	public String getStsUsuario() {
		return stsUsuario;
	}
	public void setStsUsuario(String stsUsuario) {
		this.stsUsuario = stsUsuario;
	}
	public String getEtapa() {
		return etapa;
	}
	public void setEtapa(String etapa) {
		this.etapa = etapa;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	
}
