package com.tmmas.cl.scl.parametrosgenerales.businessobject.dto;

import java.io.Serializable;

public class OcupacionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codOcupacion;
	private String desOcupacion;
	
	public String getCodOcupacion() {
		return codOcupacion;
	}
	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}
	public String getDesOcupacion() {
		return desOcupacion;
	}
	public void setDesOcupacion(String desOcupacion) {
		this.desOcupacion = desOcupacion;
	}
	
	

}
