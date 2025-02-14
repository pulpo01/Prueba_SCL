package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraSucursalBancoClieDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String CodigoSucursal;

	public String getCodigoSucursal() {
		return CodigoSucursal;
	}

	public void setCodigoSucursal(String codigoSucursal) {
		CodigoSucursal = codigoSucursal;
	}

}
