package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class DireccionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codRegion;
	private String codProvincia;
	private String codCiudad;
	private String codPlaza;
	
	
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
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
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	
}
