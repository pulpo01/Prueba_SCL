package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;

public class SalidaConsultaTraspasoDTO extends SalidaIntegracionSICSADTO implements Serializable{
	
	/**
     * 
     */
	private static final long serialVersionUID = 1L;
	private String numTraspaso;
	private String estadoTraspaso;
	private String mesajeError;
	private SerieErrorDTO[] seriesError;
	
	public SerieErrorDTO[] getSeriesError() {
		return seriesError;
	}
	public void setSeriesError(SerieErrorDTO[] seriesError) {
		this.seriesError = seriesError;
	}
	public String getNumTraspaso() {
		return numTraspaso;
	}
	public void setNumTraspaso(String numTraspaso) {
		this.numTraspaso = numTraspaso;
	}
	public String getEstadoTraspaso() {
		return estadoTraspaso;
	}
	public void setEstadoTraspaso(String estadoTraspaso) {
		this.estadoTraspaso = estadoTraspaso;
	}
	public String getMesajeError() {
		return mesajeError;
	}
	public void setMesajeError(String mesajeError) {
		this.mesajeError = mesajeError;
	}	
}
