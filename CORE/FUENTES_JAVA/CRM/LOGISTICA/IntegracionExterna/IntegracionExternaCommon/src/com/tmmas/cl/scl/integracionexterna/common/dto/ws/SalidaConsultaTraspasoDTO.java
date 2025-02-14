package com.tmmas.cl.scl.integracionexterna.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionexterna.common.dto.SerieErrorDTO;

public class SalidaConsultaTraspasoDTO extends SalidaIntegracionExternaDTO implements Serializable{
	/**
     * 
     */
	private static final long serialVersionUID = 1L;
	private String numTraspasoMasivo;
	private String estadoTraspaso;
	private String mensajeError;
	private String validacionOk;
	private SerieErrorDTO[] seriesError;
	
	public String getNumTraspasoMasivo() {
		return numTraspasoMasivo;
	}
	public void setNumTraspasoMasivo(String numTraspasoMasivo) {
		this.numTraspasoMasivo = numTraspasoMasivo;
	}
	public String getEstadoTraspaso() {
		return estadoTraspaso;
	}
	public void setEstadoTraspaso(String estadoTraspaso) {
		this.estadoTraspaso = estadoTraspaso;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getValidacionOk() {
		return validacionOk;
	}
	public void setValidacionOk(String validacionOk) {
		this.validacionOk = validacionOk;
	}
	public SerieErrorDTO[] getSeriesError() {
		return seriesError;
	}
	public void setSeriesError(SerieErrorDTO[] seriesError) {
		this.seriesError = seriesError;
	}
}
