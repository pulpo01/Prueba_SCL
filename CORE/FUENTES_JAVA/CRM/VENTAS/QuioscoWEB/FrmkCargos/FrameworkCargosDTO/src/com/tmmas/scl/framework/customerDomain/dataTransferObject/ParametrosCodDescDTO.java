package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosCodDescDTO implements Serializable {
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 private String numAbonado;
	 private String codigoCausaDescuento;
	 
	
	public String getCodigoCausaDescuento() {
		return codigoCausaDescuento;
	}
	public void setCodigoCausaDescuento(String codigoCausaDescuento) {
		this.codigoCausaDescuento = codigoCausaDescuento;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
}
