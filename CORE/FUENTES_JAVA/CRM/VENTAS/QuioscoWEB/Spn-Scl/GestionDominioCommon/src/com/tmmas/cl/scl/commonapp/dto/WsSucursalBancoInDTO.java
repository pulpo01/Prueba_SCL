package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsSucursalBancoInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String CodigoSucursal;
	
	
	public String getCodigoSucursal() {
		return CodigoSucursal;
	}
	public void setCodigoSucursal(String codigoSucursal) {
		CodigoSucursal = codigoSucursal;
	}

}
