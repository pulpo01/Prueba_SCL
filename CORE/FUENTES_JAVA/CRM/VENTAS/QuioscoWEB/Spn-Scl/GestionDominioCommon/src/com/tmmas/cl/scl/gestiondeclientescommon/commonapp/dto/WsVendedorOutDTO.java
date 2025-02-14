package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsVendedorOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int codVendedor;
	private String nomVendedor;
	private int codVendeRaiz;
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	
	public String getNomVendedor() {
		return nomVendedor;
	}
	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}
	public int getCodVendeRaiz() {
		return codVendeRaiz;
	}
	public void setCodVendeRaiz(int codVendeRaiz) {
		this.codVendeRaiz = codVendeRaiz;
	}

}
