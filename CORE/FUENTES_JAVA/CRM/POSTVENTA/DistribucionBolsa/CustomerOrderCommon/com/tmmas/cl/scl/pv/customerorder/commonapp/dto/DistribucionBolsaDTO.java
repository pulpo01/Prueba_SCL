package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class DistribucionBolsaDTO  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long cod_cliente;
	private String cod_plan;
	private String cod_bolsa;
	private String ind_unidad;
	private String des_planTarif;
	private String glosa_Parametro;
	private long cantidad_bolsa;
	private String limite_consumo;
	private BolsaAbonadoDTO bolsa[];
	private OrdenServicioDTO serviceOrder;
	private boolean creaLCAbonado = false;
		
	public BolsaAbonadoDTO[] getBolsa() {
		return bolsa;
	}


	public boolean isCreaLCAbonado() {
		return creaLCAbonado;
	}
	public void setCreaLCAbonado(boolean creaLCAbonado) {
		this.creaLCAbonado = creaLCAbonado;
	}
	public void setBolsa(BolsaAbonadoDTO bolsa[]) {
		this.bolsa = bolsa;
	}
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public String getCod_bolsa() {
		return cod_bolsa;
	}
	public void setCod_bolsa(String cod_bolsa) {
		this.cod_bolsa = cod_bolsa;
	}
	public String getCod_plan() {
		return cod_plan;
	}
	public void setCod_plan(String cod_plan) {
		this.cod_plan = cod_plan;
	}
	public String getInd_unidad() {
		return ind_unidad;
	}
	public void setInd_unidad(String ind_unidad) {
		this.ind_unidad = ind_unidad;
	}
	public OrdenServicioDTO getServiceOrder() {
		return serviceOrder;
	}
	public void setServiceOrder(OrdenServicioDTO serviceOrder) {
		this.serviceOrder = serviceOrder;
	}
	public String getLimite_consumo() {
		return limite_consumo;
	}
	public void setLimite_consumo(String limite_consumo) {
		this.limite_consumo = limite_consumo;
	}
	public String getDes_planTarif() {
		return des_planTarif;
	}
	public void setDes_planTarif(String des_planTarif) {
		this.des_planTarif = des_planTarif;
	}
	public String getGlosa_Parametro() {
		return glosa_Parametro;
	}
	public void setGlosa_Parametro(String glosa_Parametro) {
		this.glosa_Parametro = glosa_Parametro;
	}
	public long getCantidad_bolsa() {
		return cantidad_bolsa;
	}
	public void setCantidad_bolsa(long cantidad_bolsa) {
		this.cantidad_bolsa = cantidad_bolsa;
	}	
}
