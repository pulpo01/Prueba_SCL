package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;

public class RegionDTO  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_region;
	private String des_region;
	private ProvinciaDTO provincia;
	
	
	public String getCod_region() {
		return cod_region;
	}
	public void setCod_region(String cod_region) {
		this.cod_region = cod_region;
	}
	public String getDes_region() {
		return des_region;
	}
	public void setDes_region(String des_region) {
		this.des_region = des_region;
	}
	public ProvinciaDTO getProvincia() {
		return provincia;
	}
	public void setProvincia(ProvinciaDTO provincia) {
		this.provincia = provincia;
	}
	
}
