package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListVendedoresOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsVendedorOutDTO[] wsVendedoresArrOutDTO;

	public WsVendedorOutDTO[] getWsVendedoresArrOutDTO() {
		return wsVendedoresArrOutDTO;
	}

	public void setWsVendedoresArrOutDTO(WsVendedorOutDTO[] wsVendedoresArrOutDTO) {
		this.wsVendedoresArrOutDTO = wsVendedoresArrOutDTO;
	}

}
