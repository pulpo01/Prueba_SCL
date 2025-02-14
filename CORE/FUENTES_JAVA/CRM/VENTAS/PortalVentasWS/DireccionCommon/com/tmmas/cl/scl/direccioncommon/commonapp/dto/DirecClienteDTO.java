package com.tmmas.cl.scl.direccioncommon.commonapp.dto;

import java.io.Serializable;

public class DirecClienteDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long codCliente;

	private Long codDireccion;

	private String codTipDireccion;

	private String desTipDireccion;

	public Long getcodCliente() {
		return codCliente;
	}

	public void setcodCliente(Long sv_codCliente) {
		this.codCliente = sv_codCliente;
	}

	public Long getcodDireccion() {
		return codDireccion;
	}

	public void setcodDireccion(Long sv_codDireccion) {
		this.codDireccion = sv_codDireccion;
	}

	public String getcodTipDireccion() {
		return codTipDireccion;
	}

	public void setcodTipDireccion(String sv_codTipDireccion) {
		this.codTipDireccion = sv_codTipDireccion;
	}

	public String getdesTipDireccion() {
		return desTipDireccion;
	}

	public void setdesTipDireccion(String sv_desTipDireccion) {
		this.desTipDireccion = sv_desTipDireccion;
	}

}
