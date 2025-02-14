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
 * 20/06/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsConsultaPlanTarifarioOutDTO extends RetornoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;   //



	
	private String codCargoBasico;  //COD_CARGOBASICO      	VARCHAR2(3 BYTE)
	private String desCargoBasico;  //DES_CARGOBASICO      	VARCHAR2(30 BYTE)
	private float impCargoBasico;  //IMP_CARGOBASICO  		NUMBER(12,4)
	private String codMoneda;		//COD_MONEDA			VARCHAR2(3 BYTE)
	private String tipUnidades;		//TIP_UNIDADES			VARCHAR2(1 BYTE)
	private String tipUnitas;		//TIP_UNITAS			VARCHAR2(1 BYTE)
	private int numUnidades;		//NUM_UNIDADES			NUMBER(6)
	private String codPlanTarif;	//COD_PLANTARIF			VARCHAR2(3 BYTE)
	private String desPlantarif;	//DES_PLANTARIF			VARCHAR2(30 BYTE)
	private String codTipPlan;		//COD_TIPLAN			VARCHAR2(5 BYTE)
	
	
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodTipPlan() {
		return codTipPlan;
	}
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}
	public String getDesPlantarif() {
		return desPlantarif;
	}
	public void setDesPlantarif(String desPlantarif) {
		this.desPlantarif = desPlantarif;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesCargoBasico() {
		return desCargoBasico;
	}
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}
	public float getImpCargoBasico() {
		return impCargoBasico;
	}
	public void setImpCargoBasico(float impCargoBasico) {
		this.impCargoBasico = impCargoBasico;
	}
	public int getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(int numUnidades) {
		this.numUnidades = numUnidades;
	}
	public String getTipUnidades() {
		return tipUnidades;
	}
	public void setTipUnidades(String tipUnidades) {
		this.tipUnidades = tipUnidades;
	}
	public String getTipUnitas() {
		return tipUnitas;
	}
	public void setTipUnitas(String tipUnitas) {
		this.tipUnitas = tipUnitas;
	}
}
