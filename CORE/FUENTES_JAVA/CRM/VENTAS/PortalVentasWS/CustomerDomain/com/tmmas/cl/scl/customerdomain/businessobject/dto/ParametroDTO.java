package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class ParametroDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codigoParametro;
	private String valorParametro;
	private String codigoModulo;
	private String codigoProducto;
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoParametro() {
		return codigoParametro;
	}
	public void setCodigoParametro(String codigoParametro) {
		this.codigoParametro = codigoParametro;
	}
	public String getValorParametro() {
		return valorParametro;
	}
	public void setValorParametro(String valorParametro) {
		this.valorParametro = valorParametro;
	}

}
