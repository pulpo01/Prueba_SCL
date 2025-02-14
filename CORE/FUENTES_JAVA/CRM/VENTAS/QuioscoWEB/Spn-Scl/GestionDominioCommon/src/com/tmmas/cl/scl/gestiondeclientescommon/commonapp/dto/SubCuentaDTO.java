package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class SubCuentaDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codSubCuenta;
	private String desSubcuenta;
	public String getCodSubCuenta() {
		return codSubCuenta;
	}
	public void setCodSubCuenta(String codSubCuenta) {
		this.codSubCuenta = codSubCuenta;
	}
	public String getDesSubcuenta() {
		return desSubcuenta;
	}
	public void setDesSubcuenta(String desSubcuenta) {
		this.desSubcuenta = desSubcuenta;
	}
}
