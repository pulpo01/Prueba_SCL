package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class DireccionCentralDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codRegion;
	private String codProvincia;
	private String codCiudad;
	
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	
	

}
