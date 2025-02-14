package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

public class ResultadoValidacionVentaDTO extends ResultadoValidacionDTO{
	private static final long serialVersionUID = 1L;
	private String mensajeValidacion;
	private String codigoCentral;
	
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
}
