package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class CajaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
		
	private String codCaja;
	private String desCaja;
	
	public String getCodCaja() {
		return codCaja;
	}
	public void setCodCaja(String codCaja) {
		this.codCaja = codCaja;
	}
	public String getDesCaja() {
		return desCaja;
	}
	public void setDesCaja(String desCaja) {
		this.desCaja = desCaja;
	}
}
