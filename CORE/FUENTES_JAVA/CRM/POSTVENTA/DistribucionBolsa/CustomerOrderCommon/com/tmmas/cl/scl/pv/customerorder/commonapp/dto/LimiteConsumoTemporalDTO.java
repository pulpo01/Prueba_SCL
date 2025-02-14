package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class LimiteConsumoTemporalDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoServicio;
	private String nombreServicio;
	private String codigoLimiteConsumo;
	private String limiteActual;
	private String limiteConsumido;
	private String cod_plan;
	
	public String getCod_plan() {
		return cod_plan;
	}
	public void setCod_plan(String cod_plan) {
		this.cod_plan = cod_plan;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getLimiteActual() {
		return limiteActual;
	}
	public void setLimiteActual(String limiteActual) {
		this.limiteActual = limiteActual;
	}
	public String getLimiteConsumido() {
		return limiteConsumido;
	}
	public void setLimiteConsumido(String limiteConsumido) {
		this.limiteConsumido = limiteConsumido;
	}
	public String getNombreServicio() {
		return nombreServicio;
	}
	public void setNombreServicio(String nombreServicio) {
		this.nombreServicio = nombreServicio;
	}
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}

	

}
