package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class SubCuentaListDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private SubCuentaDTO listaSubCuentas[];
	
	public SubCuentaDTO[] getListaSubCuentas() {
		return listaSubCuentas;
	}
	public void setListaSubCuentas(SubCuentaDTO[] listaSubCuentas) {
		this.listaSubCuentas = listaSubCuentas;
	}
}
