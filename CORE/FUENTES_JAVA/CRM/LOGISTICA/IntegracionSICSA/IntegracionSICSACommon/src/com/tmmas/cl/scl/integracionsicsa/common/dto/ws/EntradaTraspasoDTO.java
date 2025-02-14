package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieTraspasoDTO;;

public class EntradaTraspasoDTO extends EntradaIntegracionSICSADTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numTraspaso;
	private SerieTraspasoDTO[] serieTraspasoDTOs;
	
	public SerieTraspasoDTO[] getSerieTraspasoDTOs() {
		return serieTraspasoDTOs;
	}
	public void setSerieTraspasoDTOs(SerieTraspasoDTO[] serieTraspasoDTOs) {
		this.serieTraspasoDTOs = serieTraspasoDTOs;
	}
	public String getNumTraspaso() {
		return numTraspaso;
	}
	public void setNumTraspaso(String numTraspaso) {
		this.numTraspaso = numTraspaso;
	}	
}
