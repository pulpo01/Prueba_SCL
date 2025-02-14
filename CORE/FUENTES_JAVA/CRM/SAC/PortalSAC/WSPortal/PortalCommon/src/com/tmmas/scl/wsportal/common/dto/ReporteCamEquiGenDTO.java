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

public class ReporteCamEquiGenDTO implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String causalCambio;
	private String fecCambio;
	private String equiAnterior;
	private String equiAntMarca;
	private String equiAntModelo;
	private String equiAntSerie;
	private String equiCambio;
	private String equiCamMarca;
	private String equiCamModelo;
	private String equiCamSerie;
	private String abonado;
	private String celular;
	private String codCliente;
	private String tipTerminal;
	
	public String getCausalCambio() {
		return causalCambio;
	}
	public void setCausalCambio(String causalCambio) {
		this.causalCambio = causalCambio;
	}
	public String getFecCambio() {
		return fecCambio;
	}
	public void setFecCambio(String fecCambio) {
		this.fecCambio = fecCambio;
	}
	public String getEquiAnterior() {
		return equiAnterior;
	}
	public void setEquiAnterior(String equiAnterior) {
		this.equiAnterior = equiAnterior;
	}
	public String getEquiAntMarca() {
		return equiAntMarca;
	}
	public void setEquiAntMarca(String equiAntMarca) {
		this.equiAntMarca = equiAntMarca;
	}
	public String getEquiAntModelo() {
		return equiAntModelo;
	}
	public void setEquiAntModelo(String equiAntModelo) {
		this.equiAntModelo = equiAntModelo;
	}
	public String getEquiAntSerie() {
		return equiAntSerie;
	}
	public void setEquiAntSerie(String equiAntSerie) {
		this.equiAntSerie = equiAntSerie;
	}
	public String getEquiCambio() {
		return equiCambio;
	}
	public void setEquiCambio(String equiCambio) {
		this.equiCambio = equiCambio;
	}
	public String getEquiCamMarca() {
		return equiCamMarca;
	}
	public void setEquiCamMarca(String equiCamMarca) {
		this.equiCamMarca = equiCamMarca;
	}
	public String getEquiCamModelo() {
		return equiCamModelo;
	}
	public void setEquiCamModelo(String equiCamModelo) {
		this.equiCamModelo = equiCamModelo;
	}
	public String getEquiCamSerie() {
		return equiCamSerie;
	}
	public void setEquiCamSerie(String equiCamSerie) {
		this.equiCamSerie = equiCamSerie;
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
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	
}
