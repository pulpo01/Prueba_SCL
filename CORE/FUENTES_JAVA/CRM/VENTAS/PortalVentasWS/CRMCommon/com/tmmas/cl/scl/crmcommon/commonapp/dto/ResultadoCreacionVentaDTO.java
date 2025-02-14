package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ResultadoCreacionVentaDTO extends ResultadoValidacionDTO{
	private static final long serialVersionUID = 1L;

	private String mensajeValidacion;
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
}//fin class ResultadoCreacionVentaDTO
