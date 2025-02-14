package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsPlanTarifarioInDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String tipPlanTarif;  //TIP_PLANTARIF      VARCHAR2(1 BYTE)   entrada
	private String codigoTiplan;
	private String indicaodorFamiliar;
	private String tipoRed;
	private String codigoTecnologia;
	
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}	
	public String getCodigoTiplan() {
		return codigoTiplan;
	}
	public void setCodigoTiplan(String codigoTiplan) {
		this.codigoTiplan = codigoTiplan;
	}
	public String getIndicaodorFamiliar() {
		return indicaodorFamiliar;
	}
	public void setIndicaodorFamiliar(String indicaodorFamiliar) {
		this.indicaodorFamiliar = indicaodorFamiliar;
	}
	public String getTipoRed() {
		return tipoRed;
	}
	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
}






