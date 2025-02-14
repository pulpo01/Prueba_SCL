package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class ListadoSSInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String codigoPlan;
	private String indCompatible;
	private String codTecnologica;
	private String codActAbo;
	
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodTecnologica() {
		return codTecnologica;
	}
	public void setCodTecnologica(String codTecnologica) {
		this.codTecnologica = codTecnologica;
	}
	public String getCodigoPlan() {
		return codigoPlan;
	}
	public void setCodigoPlan(String codigoPlan) {
		this.codigoPlan = codigoPlan;
	}
	public String getIndCompatible() {
		return indCompatible;
	}
	public void setIndCompatible(String indCompatible) {
		this.indCompatible = indCompatible;
	}
	
}
