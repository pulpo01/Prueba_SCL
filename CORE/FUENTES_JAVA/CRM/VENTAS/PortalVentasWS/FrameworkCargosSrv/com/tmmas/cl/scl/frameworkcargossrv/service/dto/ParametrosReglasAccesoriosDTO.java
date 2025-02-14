package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasAccesoriosDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private String codigoProducto;

	public String getCodigoProducto() {
		return codigoProducto;
	}

	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}

}//fin ParametrosReglasAccesoriosDTO
