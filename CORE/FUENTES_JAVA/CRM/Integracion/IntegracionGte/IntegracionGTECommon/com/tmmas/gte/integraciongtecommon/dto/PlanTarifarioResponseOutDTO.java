package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 * Modificado :Juan Muñoz
 */

public class PlanTarifarioResponseOutDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private PlanTarifarioOutDTO  planTarifario;
	private RespuestaDTO respuesta;
	
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public PlanTarifarioOutDTO getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(PlanTarifarioOutDTO planTarifario) {
		this.planTarifario = planTarifario;
	}

	
}