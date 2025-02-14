package com.tmmas.scl.framework.customerDomain.dataTransferObject;

public class ResultadoValidacionVentaDTO extends ResultadoValidacionDTO{
	private static final long serialVersionUID = 1L;
	private String mensajeValidacion;
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
}
