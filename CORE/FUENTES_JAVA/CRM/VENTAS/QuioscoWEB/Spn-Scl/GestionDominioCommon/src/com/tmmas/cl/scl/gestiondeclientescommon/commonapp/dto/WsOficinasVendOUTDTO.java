package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsOficinasVendOUTDTO extends RetornoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OficinaVendedorDTO[]  oficinasVendedorDTO;
	public OficinaVendedorDTO[] getOficinasVendedorDTO() {
		return oficinasVendedorDTO;
	}
	public void setOficinasVendedorDTO(OficinaVendedorDTO[] oficinasVendedorDTO) {
		this.oficinasVendedorDTO = oficinasVendedorDTO;
	}

}
