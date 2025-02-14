package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListArticuloStockOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsArticuloStockOutDTO[] wsArticuloStockArrOutDTO;

	public WsArticuloStockOutDTO[] getWsArticuloStockArrOutDTO() {
		return wsArticuloStockArrOutDTO;
	}

	public void setWsArticuloStockArrOutDTO(
			WsArticuloStockOutDTO[] wsArticuloStockArrOutDTO) {
		this.wsArticuloStockArrOutDTO = wsArticuloStockArrOutDTO;
	}


}