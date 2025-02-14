package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class NumeroCategDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String idProductoContratado;
	private String nro;
	private String codCategoriaDest;
	public String getCodCategoriaDest() {
		return codCategoriaDest;
	}
	public void setCodCategoriaDest(String codCategoriaDest) {
		this.codCategoriaDest = codCategoriaDest;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getNro() {
		return nro;
	}
	public void setNro(String nro) {
		this.nro = nro;
	}
}
