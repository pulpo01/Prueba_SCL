package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class CausaSiniestroDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String des_causa;
	private String cod_causa;
	private String cod_servicio;
	private String lv_cod_servicio;
	private String cod_caususp;
	
	public String getCod_causa() {
		return cod_causa;
	}
	public void setCod_causa(String cod_causa) {
		this.cod_causa = cod_causa;
	}
	public String getCod_caususp() {
		return cod_caususp;
	}
	public void setCod_caususp(String cod_caususp) {
		this.cod_caususp = cod_caususp;
	}
	public String getCod_servicio() {
		return cod_servicio;
	}
	public void setCod_servicio(String cod_servicio) {
		this.cod_servicio = cod_servicio;
	}
	public String getDes_causa() {
		return des_causa;
	}
	public void setDes_causa(String des_causa) {
		this.des_causa = des_causa;
	}
	public String getLv_cod_servicio() {
		return lv_cod_servicio;
	}
	public void setLv_cod_servicio(String lv_cod_servicio) {
		this.lv_cod_servicio = lv_cod_servicio;
	}
	
	
}
