package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;

public class ComunaDTO implements Serializable {


	private static final long serialVersionUID = 1L;
	private String cod_comuna;
	private String des_comuna;
	
	public String getCod_comuna() {
		return cod_comuna;
	}
	public void setCod_comuna(String cod_comuna) {
		this.cod_comuna = cod_comuna;
	}
	public String getDes_comuna() {
		return des_comuna;
	}
	public void setDes_comuna(String des_comuna) {
		this.des_comuna = des_comuna;
	}	
}
