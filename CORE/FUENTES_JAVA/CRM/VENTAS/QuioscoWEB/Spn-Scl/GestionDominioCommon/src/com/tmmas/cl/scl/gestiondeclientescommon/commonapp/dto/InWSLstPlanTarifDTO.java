package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class InWSLstPlanTarifDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String tipPlanTarif;  //TIP_PLANTARIF      VARCHAR2(1 BYTE)   entrada
	
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
}
