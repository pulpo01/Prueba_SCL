package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class SubCuentaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long codCuenta;
	private String codSubCuenta;
	private String desSubCuenta;
	
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodSubCuenta() {
		return codSubCuenta;
	}
	public void setCodSubCuenta(String codSubCuenta) {
		this.codSubCuenta = codSubCuenta;
	}
	public String getDesSubCuenta() {
		return desSubCuenta;
	}
	public void setDesSubCuenta(String desSubCuenta) {
		this.desSubCuenta = desSubCuenta;
	}
	
	
	
}
