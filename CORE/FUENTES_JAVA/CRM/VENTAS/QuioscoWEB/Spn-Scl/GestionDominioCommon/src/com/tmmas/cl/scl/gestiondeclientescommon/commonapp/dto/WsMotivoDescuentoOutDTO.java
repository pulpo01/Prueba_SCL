package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsMotivoDescuentoOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codDescuento;
	private String desDescuento;
	public String getCodDescuento() {
		return codDescuento;
	}
	public void setCodDescuento(String codDescuento) {
		this.codDescuento = codDescuento;
	}
	public String getDesDescuento() {
		return desDescuento;
	}
	public void setDesDescuento(String desDescuento) {
		this.desDescuento = desDescuento;
	}
}
