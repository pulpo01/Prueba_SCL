package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class LimiteClienteDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long cod_cliente;
	private long num_abonado;
	private String cod_plan;
	private LimiteConsumoDTO[] limites;
	private OrdenServicioDTO ooss;
	
	
	public String getCod_plan() {
		return cod_plan;
	}
	public void setCod_plan(String cod_plan) {
		this.cod_plan = cod_plan;
	}
	public OrdenServicioDTO getOoss() {
		return ooss;
	}
	public void setOoss(OrdenServicioDTO ooss) {
		this.ooss = ooss;
	}
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public LimiteConsumoDTO[] getLimites() {
		return limites;
	}
	public void setLimites(LimiteConsumoDTO[] limites) {
		this.limites = limites;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	



	
}
