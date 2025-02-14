package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsContSSuplementariosInDTO implements Serializable{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numeroCelular;
	private String uso;
	private String codigoVendedor;
	private String codigoComercialServicio;
	
	
	public String getCodigoComercialServicio() {
		return codigoComercialServicio;
	}
	public void setCodigoComercialServicio(String codigoComercialServicio) {
		this.codigoComercialServicio = codigoComercialServicio;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getUso() {
		return uso;
	}
	public void setUso(String uso) {
		this.uso = uso;
	}


}
