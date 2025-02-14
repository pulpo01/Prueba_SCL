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
 * 18/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class LimiteConsumoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String profileId;			//cod_limcons
	private String descProfileId;		//descripcion limite consumo
	private String ind_unidad;
	private double min_lc;
	private double mto_pago;
	private String cod_servicio;
	private String cod_plan;
	
	public String getInd_unidad() {
		return ind_unidad;
	}
	public void setInd_unidad(String ind_unidad) {
		this.ind_unidad = ind_unidad;
	}
	public double getMin_lc() {
		return min_lc;
	}
	public void setMin_lc(double min_lc) {
		this.min_lc = min_lc;
	}
	public double getMto_pago() {
		return mto_pago;
	}
	public void setMto_pago(double mto_pago) {
		this.mto_pago = mto_pago;
	}
	public String getDescProfileId() {
		return descProfileId;
	}
	public void setDescProfileId(String descProfileId) {
		this.descProfileId = descProfileId;
	}
	public String getProfileId() {
		return profileId;
	}
	public void setProfileId(String profileId) {
		this.profileId = profileId;
	}
	public String getCod_servicio() {
		return cod_servicio;
	}
	public void setCod_servicio(String cod_servicio) {
		this.cod_servicio = cod_servicio;
	}
	public String getCod_plan() {
		return cod_plan;
	}
	public void setCod_plan(String cod_plan) {
		this.cod_plan = cod_plan;
	}
	
}
