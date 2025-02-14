package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class OutWsModalidadVentaDTO extends RetornoDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GeModVentaDTO[] geModVentaDTO;

	public GeModVentaDTO[] getGeModVentaDTO() {
		return geModVentaDTO;
	}

	public void setGeModVentaDTO(GeModVentaDTO[] geModVentaDTO) {
		this.geModVentaDTO = geModVentaDTO;
	}
}
