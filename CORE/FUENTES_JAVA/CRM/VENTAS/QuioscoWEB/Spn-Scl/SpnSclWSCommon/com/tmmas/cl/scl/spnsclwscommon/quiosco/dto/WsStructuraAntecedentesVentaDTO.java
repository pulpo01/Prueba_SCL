package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraAntecedentesVentaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoVendedor;		

	
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}

}
