package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 * Modificado :Juan Muñoz
 */

public class PlanTarifarioResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private PlanTarifarioDTO[] listPlanTarifario;
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
	public PlanTarifarioDTO[] getListPlanTarifario() {
		return listPlanTarifario;
	}
	public void setListPlanTarifario(PlanTarifarioDTO[] listPlanTarifario) {
		this.listPlanTarifario = listPlanTarifario;
	}
	
	
	
}