package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class ConsultaBodegaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codVendedor;
	private String codOperadora;
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

}
