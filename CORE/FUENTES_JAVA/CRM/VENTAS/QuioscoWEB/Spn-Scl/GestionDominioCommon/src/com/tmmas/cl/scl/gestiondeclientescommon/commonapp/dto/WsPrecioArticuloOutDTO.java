package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsPrecioArticuloOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private float precioVenta;

	public float getPrecioVenta() {
		return precioVenta;
	}

	public void setPrecioVenta(float precioVenta) {
		this.precioVenta = precioVenta;
	}

	
}
