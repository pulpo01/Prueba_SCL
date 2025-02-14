package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CuentaPersonalDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numCelular;
	private long numCelularCorp;

	public long getNumCelularCorp() {
		return numCelularCorp;
	}

	public void setNumCelularCorp(long numCelularCorp) {
		this.numCelularCorp = numCelularCorp;
	}

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
}
