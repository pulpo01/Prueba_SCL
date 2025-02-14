package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConPlanResponseDTO implements Serializable {
/*
 * Autor : Juan Muñoz Queupul
 * */	
	private static final long serialVersionUID = 1L;
	private String codigoPlanTarifario;
	private String DescripcionPlanTarifario;
	private RespuestaDTO respuesta;
	
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDescripcionPlanTarifario() {
		return DescripcionPlanTarifario;
	}
	public void setDescripcionPlanTarifario(String descripcionPlanTarifario) {
		DescripcionPlanTarifario = descripcionPlanTarifario;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
}
