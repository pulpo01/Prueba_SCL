package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class VendedorComDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codTipComisionista;
	private String desTipComisionista;
	
	public String getCodTipComisionista() {
		return codTipComisionista;
	}
	public void setCodTipComisionista(String codTipComisionista) {
		this.codTipComisionista = codTipComisionista;
	}
	public String getDesTipComisionista() {
		return desTipComisionista;
	}
	public void setDesTipComisionista(String desTipComisionista) {
		this.desTipComisionista = desTipComisionista;
	}
	
}
