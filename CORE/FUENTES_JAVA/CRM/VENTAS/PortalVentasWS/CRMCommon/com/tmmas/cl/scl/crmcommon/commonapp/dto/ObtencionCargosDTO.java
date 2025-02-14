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
 * 24/05/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ObtencionCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private CargosDTO[] cargos;
	/*Rango de descuento del vendedor*/
	private float puntoDesctoInferior;
	private float puntoDesctoSuperior;
	private float porcentajeDesctoInferior;
	private float porcentajeDesctoSuperior;
	private boolean aplicaDescuentoVendedor;
	public boolean isAplicaDescuentoVendedor() {
		return aplicaDescuentoVendedor;
	}
	public void setAplicaDescuentoVendedor(boolean aplicaDescuentoVendedor) {
		this.aplicaDescuentoVendedor = aplicaDescuentoVendedor;
	}
	public CargosDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargosDTO[] cargos) {
		this.cargos = cargos;
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
	

}
