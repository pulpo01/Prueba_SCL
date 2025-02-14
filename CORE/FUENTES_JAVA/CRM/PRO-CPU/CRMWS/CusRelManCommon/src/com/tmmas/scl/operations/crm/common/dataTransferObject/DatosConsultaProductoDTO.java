package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class DatosConsultaProductoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String numCelularContr;
	private String codProducto;
	private String codCanal;
	
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getNumCelularContr() {
		return numCelularContr;
	}
	public void setNumCelularContr(String numCelularContr) {
		this.numCelularContr = numCelularContr;
	}
	
	
}
