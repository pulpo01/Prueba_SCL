package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class ResultadoAltaCarrierPasilloLDIDTO implements Serializable {


	private static final long serialVersionUID = -6979462773076701907L;

	private String numVenta;

	private String codCliente;

	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public String getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(String numeroVenta) {
		this.numVenta = numeroVenta;
	}
}
