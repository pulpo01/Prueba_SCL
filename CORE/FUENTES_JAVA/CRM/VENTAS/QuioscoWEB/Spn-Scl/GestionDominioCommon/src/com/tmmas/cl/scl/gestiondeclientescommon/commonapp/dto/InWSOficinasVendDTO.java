package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class InWSOficinasVendDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codVendedor;
	private String indInterno;
	
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(String indInterno) {
		this.indInterno = indInterno;
	}
}
