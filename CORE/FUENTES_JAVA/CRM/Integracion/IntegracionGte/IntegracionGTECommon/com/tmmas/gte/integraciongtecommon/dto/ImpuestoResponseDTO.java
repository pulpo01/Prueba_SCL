package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
public class ImpuestoResponseDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private double impuesto;
	private RespuestaDTO respuesta;
	

	public double getImpuesto() {
		return impuesto;
	}
	public void setImpuesto(double impuesto) {
		this.impuesto = impuesto;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
}
