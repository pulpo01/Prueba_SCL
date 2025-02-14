package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsVendedorInterDealerOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int codVendedor;
	private String nomVendedor;
	private int codDealer;
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
	public int getCodDealer() {
		return codDealer;
	}
	public void setCodDealer(int codDealer) {
		this.codDealer = codDealer;
	}
	

}
