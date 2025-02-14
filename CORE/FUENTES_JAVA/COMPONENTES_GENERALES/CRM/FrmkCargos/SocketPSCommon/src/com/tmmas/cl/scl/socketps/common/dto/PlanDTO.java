package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class PlanDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String plan;
	private RespuestaPSDTO respuesta;
	
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public RespuestaPSDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaPSDTO respuesta) {
		this.respuesta = respuesta;
	}

}
