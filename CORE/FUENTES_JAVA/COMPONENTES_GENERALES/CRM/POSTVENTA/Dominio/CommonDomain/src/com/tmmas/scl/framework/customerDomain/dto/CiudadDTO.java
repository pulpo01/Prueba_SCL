package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;

public class CiudadDTO  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_ciudad; 
	private String des_ciudad;
	
	
	public String getCod_ciudad() {
		return cod_ciudad;
	}
	public void setCod_ciudad(String cod_ciudad) {
		this.cod_ciudad = cod_ciudad;
	}
	public String getDes_ciudad() {
		return des_ciudad;
	}
	public void setDes_ciudad(String des_ciudad) {
		this.des_ciudad = des_ciudad;
	} 
	
	
}
