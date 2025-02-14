package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListMotivoDescuentoOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsMotivoDescuentoOutDTO[] WsMotivoDescuentoArrOutDTO;

	public WsMotivoDescuentoOutDTO[] getWsMotivoDescuentoArrOutDTO() {
		return WsMotivoDescuentoArrOutDTO;
	}

	public void setWsMotivoDescuentoArrOutDTO(
			WsMotivoDescuentoOutDTO[] wsMotivoDescuentoArrOutDTO) {
		WsMotivoDescuentoArrOutDTO = wsMotivoDescuentoArrOutDTO;
	}


}
