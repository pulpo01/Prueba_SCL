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
 * 16/03/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class PlanTarifarioDistDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String codigoPlanTarifario;
	private String descripcionPlanTarifario;
	DistribucionBolsaDTO distribucionBolsa;
	private int freeUnits;
	private boolean distribucionPlanRealizada;
	private String estilo="";
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDescripcionPlanTarifario() {
		return descripcionPlanTarifario;
	}
	public void setDescripcionPlanTarifario(String descripcionPlanTarifario) {
		this.descripcionPlanTarifario = descripcionPlanTarifario;
	}
	public int getFreeUnits() {
		return freeUnits;
	}
	public void setFreeUnits(int freeUnits) {
		this.freeUnits = freeUnits;
	}
	public boolean isDistribucionPlanRealizada() {
		return distribucionPlanRealizada;
	}
	public void setDistribucionPlanRealizada(boolean distribucionPlanRealizada) {
		this.distribucionPlanRealizada = distribucionPlanRealizada;
	}
	public String getEstilo() {
		return estilo;
	}
	public void setEstilo(String estilo) {
		this.estilo = estilo;
	}
	public DistribucionBolsaDTO getDistribucionBolsa() {
		return distribucionBolsa;
	}
	public void setDistribucionBolsa(DistribucionBolsaDTO distribucionBolsa) {
		this.distribucionBolsa = distribucionBolsa;
	}


}
