package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;

public class ProvinciaDTO  implements Serializable {

	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_provincia;
	private String des_provincia;
	private CiudadDTO ciudad;
	private ComunaDTO comuna;
	
	
	public ComunaDTO getComuna() {
		return comuna;
	}
	public void setComuna(ComunaDTO comuna) {
		this.comuna = comuna;
	}
	public CiudadDTO getCiudad() {
		return ciudad;
	}
	public void setCiudad(CiudadDTO ciudad) {
		this.ciudad = ciudad;
	}
	public String getCod_provincia() {
		return cod_provincia;
	}
	public void setCod_provincia(String cod_provincia) {
		this.cod_provincia = cod_provincia;
	}
	public String getDes_provincia() {
		return des_provincia;
	}
	public void setDes_provincia(String des_provincia) {
		this.des_provincia = des_provincia;
	}
	  
}
