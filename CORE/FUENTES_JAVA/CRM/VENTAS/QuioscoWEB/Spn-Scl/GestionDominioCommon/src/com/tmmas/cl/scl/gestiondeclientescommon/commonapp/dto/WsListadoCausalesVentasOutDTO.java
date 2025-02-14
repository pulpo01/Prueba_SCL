package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListadoCausalesVentasOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsCausalesVentasOutDTO[] WsMotivoDescuentoArrOutDTO;

	public WsCausalesVentasOutDTO[] getWsMotivoDescuentoArrOutDTO() {
		return WsMotivoDescuentoArrOutDTO;
	}

	public void setWsMotivoDescuentoArrOutDTO(
			WsCausalesVentasOutDTO[] wsMotivoDescuentoArrOutDTO) {
		WsMotivoDescuentoArrOutDTO = wsMotivoDescuentoArrOutDTO;
	}


}
