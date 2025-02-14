package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class ContratoAjaxDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codigoTipoContrato;
	private String descripcionTipoContrato;
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public String getDescripcionTipoContrato() {
		return descripcionTipoContrato;
	}
	public void setDescripcionTipoContrato(String descripcionTipoContrato) {
		this.descripcionTipoContrato = descripcionTipoContrato;
	}

}
