package com.tmmas.cl.scl.integracionexterna.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionexterna.common.dto.SerieTraspasoMasivoDTO;

public class TraspasoMasivoInDTO extends EntradaIntegracionExternaDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numSecuencia;
	private String codBodegaOrigen;
	private String codBodegaDestino;
	private String tipOperacion;
	private String codCliente;
	private SerieTraspasoMasivoDTO[] serieTraspasoMasivoDTO;
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumSecuencia() {
		return numSecuencia;
	}
	public void setNumSecuencia(String numSecuencia) {
		this.numSecuencia = numSecuencia;
	}
	public String getCodBodegaOrigen() {
		return codBodegaOrigen;
	}
	public void setCodBodegaOrigen(String codBodegaOrigen) {
		this.codBodegaOrigen = codBodegaOrigen;
	}
	public String getCodBodegaDestino() {
		return codBodegaDestino;
	}
	public void setCodBodegaDestino(String codBodegaDestino) {
		this.codBodegaDestino = codBodegaDestino;
	}
	public String getTipOperacion() {
		return tipOperacion;
	}
	public void setTipOperacion(String tipOperacion) {
		this.tipOperacion = tipOperacion;
	}
	public SerieTraspasoMasivoDTO[] getSerieTraspasoMasivoDTO() {
		return serieTraspasoMasivoDTO;
	}
	public void setSerieTraspasoMasivoDTO(
			SerieTraspasoMasivoDTO[] serieTraspasoMasivoDTO) {
		this.serieTraspasoMasivoDTO = serieTraspasoMasivoDTO;
	}
}
