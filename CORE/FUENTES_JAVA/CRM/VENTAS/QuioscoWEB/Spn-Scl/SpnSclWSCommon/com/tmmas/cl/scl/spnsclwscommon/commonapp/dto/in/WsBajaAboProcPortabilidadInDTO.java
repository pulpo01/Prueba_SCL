package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsBajaAboProcPortabilidadInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numeroLinea;
	private String codigoCausaBaja;
	private String uso;
	private String codigoVendedor;
	private String tipoBaja;
	
	
	public String getCodigoCausaBaja() {
		return codigoCausaBaja;
	}
	public void setCodigoCausaBaja(String codigoCausaBaja) {
		this.codigoCausaBaja = codigoCausaBaja;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNumeroLinea() {
		return numeroLinea;
	}
	public void setNumeroLinea(String numeroLinea) {
		this.numeroLinea = numeroLinea;
	}
	public String getTipoBaja() {
		return tipoBaja;
	}
	public void setTipoBaja(String tipoBaja) {
		this.tipoBaja = tipoBaja;
	}
	public String getUso() {
		return uso;
	}
	public void setUso(String uso) {
		this.uso = uso;
	}


}
