package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraPlanTerifarioDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String planTarifario;

	public String getPlanTarifario() {
		return planTarifario;
	}

	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	
}
