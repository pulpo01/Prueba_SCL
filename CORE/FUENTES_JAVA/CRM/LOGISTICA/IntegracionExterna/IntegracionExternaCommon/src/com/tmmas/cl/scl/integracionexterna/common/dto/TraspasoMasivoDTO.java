package com.tmmas.cl.scl.integracionexterna.common.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.TraspasoMasivoInDTO;

public class TraspasoMasivoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numTraspasoMasivo;
	private String numTraspaso;
	private TraspasoMasivoInDTO masivoInDTO;
	
	public TraspasoMasivoInDTO getMasivoInDTO() {
		return masivoInDTO;
	}
	public void setMasivoInDTO(TraspasoMasivoInDTO masivoInDTO) {
		this.masivoInDTO = masivoInDTO;
	}
	public String getNumTraspasoMasivo() {
		return numTraspasoMasivo;
	}
	public void setNumTraspasoMasivo(String numTraspasoMasivo) {
		this.numTraspasoMasivo = numTraspasoMasivo;
	}
	public String getNumTraspaso() {
		return numTraspaso;
	}
	public void setNumTraspaso(String numTraspaso) {
		this.numTraspaso = numTraspaso;
	}
}
