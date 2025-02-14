package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class VendedorAjaxDTO  implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codigoVendedor;
	private String nombreVendedor;
	
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
}
