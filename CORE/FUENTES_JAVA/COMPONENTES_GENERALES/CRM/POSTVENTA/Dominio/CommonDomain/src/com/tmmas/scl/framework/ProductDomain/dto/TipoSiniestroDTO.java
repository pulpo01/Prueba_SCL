package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class TipoSiniestroDTO implements Serializable {
	

	private static final long serialVersionUID = 1L;
	private String cod_TipoSiniestro;
	private String des_TipoSiniestro;
	
	public String getCod_TipoSiniestro() {
		return cod_TipoSiniestro;
	}
	public void setCod_TipoSiniestro(String cod_TipoSiniestro) {
		this.cod_TipoSiniestro = cod_TipoSiniestro;
	}
	public String getDes_TipoSiniestro() {
		return des_TipoSiniestro;
	}
	public void setDes_TipoSiniestro(String des_TipoSiniestro) {
		this.des_TipoSiniestro = des_TipoSiniestro;
	}
	

}
