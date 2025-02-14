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
 * 01/05/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;


public class RegCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private CargoDTO[] cargos;
	private CabeceraArchivoDTO objetoSesion;
	/*Rango de descuento del vendedor*/
	private float puntoDesctoInferior;
	private float puntoDesctoSuperior;
	private float porcentajeDesctoInferior;
	private float porcentajeDesctoSuperior;
	private boolean aplicaDescuentoVendedor;
	private boolean aplicaTipoCargo;
	
	private Long num_terminal;
	private Long num_abonado;
	private String num_Simcard;
	
	public String getNum_Simcard() {
		return num_Simcard;
	}
	public void setNum_Simcard(String num_Simcard) {
		this.num_Simcard = num_Simcard;
	}
	public CargoDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargoDTO[] cargos) {
		this.cargos = cargos;
	}
	public CabeceraArchivoDTO getObjetoSesion() {
		return objetoSesion;
	}
	public void setObjetoSesion(CabeceraArchivoDTO objetoSesion) {
		this.objetoSesion = objetoSesion;
	}
	public boolean isAplicaDescuentoVendedor() {
		return aplicaDescuentoVendedor;
	}
	public void setAplicaDescuentoVendedor(boolean aplicaDescuentoVendedor) {
		this.aplicaDescuentoVendedor = aplicaDescuentoVendedor;
	}
	public float getPorcentajeDesctoInferior() {
		return porcentajeDesctoInferior;
	}
	public void setPorcentajeDesctoInferior(float porcentajeDesctoInferior) {
		this.porcentajeDesctoInferior = porcentajeDesctoInferior;
	}
	public float getPorcentajeDesctoSuperior() {
		return porcentajeDesctoSuperior;
	}
	public void setPorcentajeDesctoSuperior(float porcentajeDesctoSuperior) {
		this.porcentajeDesctoSuperior = porcentajeDesctoSuperior;
	}
	public float getPuntoDesctoInferior() {
		return puntoDesctoInferior;
	}
	public void setPuntoDesctoInferior(float puntoDesctoInferior) {
		this.puntoDesctoInferior = puntoDesctoInferior;
	}
	public float getPuntoDesctoSuperior() {
		return puntoDesctoSuperior;
	}
	public void setPuntoDesctoSuperior(float puntoDesctoSuperior) {
		this.puntoDesctoSuperior = puntoDesctoSuperior;
	}
	public boolean isAplicaTipoCargo() {
		return aplicaTipoCargo;
	}
	public void setAplicaTipoCargo(boolean aplicaTipoCargo) {
		this.aplicaTipoCargo = aplicaTipoCargo;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
	}

}
