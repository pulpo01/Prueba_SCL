package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListClienteOutDTO extends RetornoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private WsClienteOutDTO[] WsClienteArrOutDTO;

	public WsClienteOutDTO[] getWsClienteArrOutDTO() {
		return WsClienteArrOutDTO;
	}

	public void setWsClienteArrOutDTO(WsClienteOutDTO[] wsClienteArrOutDTO) {
		WsClienteArrOutDTO = wsClienteArrOutDTO;
	}
}
