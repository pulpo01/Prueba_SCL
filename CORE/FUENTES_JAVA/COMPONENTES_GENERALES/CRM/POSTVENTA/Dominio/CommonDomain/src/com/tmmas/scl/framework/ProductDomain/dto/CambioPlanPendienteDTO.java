package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class CambioPlanPendienteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long cod_cliente;
	private long num_abonado;
	private String cod_ooss;
	private String cod_plantarif;
	private String cod_retorno;
	private String glosa_retorno;
	private String plan_nuevo;
	private long num_ooss;
	
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public String getCod_ooss() {
		return cod_ooss;
	}
	public void setCod_ooss(String cod_ooss) {
		this.cod_ooss = cod_ooss;
	}
	public String getCod_plantarif() {
		return cod_plantarif;
	}
	public void setCod_plantarif(String cod_plantarif) {
		this.cod_plantarif = cod_plantarif;
	}
	public String getCod_retorno() {
		return cod_retorno;
	}
	public void setCod_retorno(String cod_retorno) {
		this.cod_retorno = cod_retorno;
	}
	public String getGlosa_retorno() {
		return glosa_retorno;
	}
	public void setGlosa_retorno(String glosa_retorno) {
		this.glosa_retorno = glosa_retorno;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public long getNum_ooss() {
		return num_ooss;
	}
	public void setNum_ooss(long num_ooss) {
		this.num_ooss = num_ooss;
	}
	public String getPlan_nuevo() {
		return plan_nuevo;
	}
	public void setPlan_nuevo(String plan_nuevo) {
		this.plan_nuevo = plan_nuevo;
	}
	

}
