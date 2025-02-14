package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CuentaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long codCuenta;
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	
}
