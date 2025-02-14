package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class SSuplementarioDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_servicio;	
	private String des_servicio;
	private long   cod_servsupl;
	private long   cod_nivel;
	private float   imp_tarifa_ss;	
	private String des_moneda_ss;
	private long   cod_concepto_ss;
	private float   imp_tarifa_fa;	
	private String des_moneda_fa;
	private long   cod_concepto_fa;	
	private String  estado_servicio;
	private long   ind_altamira;
	
	
	
	public long getCod_concepto_fa() {
		return cod_concepto_fa;
	}
	public void setCod_concepto_fa(long cod_concepto_fa) {
		this.cod_concepto_fa = cod_concepto_fa;
	}
	public long getCod_concepto_ss() {
		return cod_concepto_ss;
	}
	public void setCod_concepto_ss(long cod_concepto_ss) {
		this.cod_concepto_ss = cod_concepto_ss;
	}
	public long getCod_nivel() {
		return cod_nivel;
	}
	public void setCod_nivel(long cod_nivel) {
		this.cod_nivel = cod_nivel;
	}
	public String getCod_servicio() {
		return cod_servicio;
	}
	public void setCod_servicio(String cod_servicio) {
		this.cod_servicio = cod_servicio;
	}
	public long getCod_servsupl() {
		return cod_servsupl;
	}
	public void setCod_servsupl(long cod_servsupl) {
		this.cod_servsupl = cod_servsupl;
	}
	public String getDes_moneda_fa() {
		return des_moneda_fa;
	}
	public void setDes_moneda_fa(String des_moneda_fa) {
		this.des_moneda_fa = des_moneda_fa;
	}
	public String getDes_moneda_ss() {
		return des_moneda_ss;
	}
	public void setDes_moneda_ss(String des_moneda_ss) {
		this.des_moneda_ss = des_moneda_ss;
	}
	public String getDes_servicio() {
		return des_servicio;
	}
	public void setDes_servicio(String des_servicio) {
		this.des_servicio = des_servicio;
	}
	public String getEstado_servicio() {
		return estado_servicio;
	}
	public void setEstado_servicio(String estado_servicio) {
		this.estado_servicio = estado_servicio;
	}
	
	public float getImp_tarifa_ss() {
		return imp_tarifa_ss;
	}
	public void setImp_tarifa_ss(float imp_tarifa_ss) {
		this.imp_tarifa_ss = imp_tarifa_ss;
	}
	public float getImp_tarifa_fa() {
		return imp_tarifa_fa;
	}
	public void setImp_tarifa_fa(float imp_tarifa_fa) {
		this.imp_tarifa_fa = imp_tarifa_fa;
	}
	public long getInd_altamira() {
		return ind_altamira;
	}
	public void setInd_altamira(long ind_altamira) {
		this.ind_altamira = ind_altamira;
	}
	
	
}
