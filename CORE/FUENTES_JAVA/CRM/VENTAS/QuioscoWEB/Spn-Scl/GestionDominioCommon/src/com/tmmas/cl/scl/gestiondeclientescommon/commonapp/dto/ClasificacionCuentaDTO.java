package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ClasificacionCuentaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codClasCuenta;
	private String desClasCuenta;
	
	public String getCodClasCuenta() {
		return codClasCuenta;
	}
	public void setCodClasCuenta(String codClasCuenta) {
		this.codClasCuenta = codClasCuenta;
	}
	public String getDesClasCuenta() {
		return desClasCuenta;
	}
	public void setDesClasCuenta(String desClasCuenta) {
		this.desClasCuenta = desClasCuenta;
	}
	
	

}
