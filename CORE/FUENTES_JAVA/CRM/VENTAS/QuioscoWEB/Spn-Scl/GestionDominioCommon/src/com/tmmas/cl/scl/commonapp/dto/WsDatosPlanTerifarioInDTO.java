package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsDatosPlanTerifarioInDTO implements Serializable{
	

	private static final long serialVersionUID = 1L;
	//private String usoLínea;
	private String planTarifario;
	
	
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	/*public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}*/
/*	public String getUsoLínea() {
		return usoLínea;
	}
	public void setUsoLínea(String usoLínea) {
		this.usoLínea = usoLínea;
	}*/
	

}
