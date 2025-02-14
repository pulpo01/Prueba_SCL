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
 * 09/08/2007     		 Raúl Lozano              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;


import java.io.Serializable;

public class RegCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	//private CargoDTO[] cargos;
	private CargoFrameworkCargosDTO[] cargos;
	private CabeceraArchivoDTO objetoSesion;
	/*Rango de descuento del vendedor*/
	private float puntoDesctoInferior;
	private float puntoDesctoSuperior;
	private float porcentajeDesctoInferior;
	private float porcentajeDesctoSuperior;
	private boolean aplicaDescuentoVendedor;
	private boolean aplicaTipoCargo;
	
	public CargoFrameworkCargosDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargoFrameworkCargosDTO[] cargos) {
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

}
