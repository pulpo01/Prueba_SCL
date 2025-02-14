package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class SucursalBancoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codBanco;
	private String codSucursal;
	private String desSucursal;
	private String codDireccion;
	
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
	public String getCodSucursal() {
		return codSucursal;
	}
	public void setCodSucursal(String codSucursal) {
		this.codSucursal = codSucursal;
	}
	public String getDesSucursal() {
		return desSucursal;
	}
	public void setDesSucursal(String desSucursal) {
		this.desSucursal = desSucursal;
	}
	
	
}
