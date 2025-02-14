package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloResDesOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long indPortado;
	private String cantidadStock;

	public long getIndPortado() {
		return indPortado;
	}

	public void setIndPortado(long indPortado) {
		this.indPortado = indPortado;
	}

	public String getCantidadStock() {
		return cantidadStock;
	}

	public void setCantidadStock(String cantidadStock) {
		this.cantidadStock = cantidadStock;
	}

}