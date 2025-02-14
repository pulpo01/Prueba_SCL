package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ResultadoValidacionLineaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codigoPlanTarifario;
	private String numeroSerie;
	private String numeroSerieTerminal;
	private String numeroCelular;
	private String estado;
	private String detalleEstado;
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDetalleEstado() {
		return detalleEstado;
	}
	public void setDetalleEstado(String detalleEstado) {
		this.detalleEstado = detalleEstado;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getNumeroSerieTerminal() {
		return numeroSerieTerminal;
	}
	public void setNumeroSerieTerminal(String numeroSerieTerminal) {
		this.numeroSerieTerminal = numeroSerieTerminal;
	}

}
