package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListCuotaOutDTO extends RetornoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private WsCuotaOutDTO[] WsCuotaArrOutDTO;

	public WsCuotaOutDTO[] getWsCuotaArrOutDTO() {
		return WsCuotaArrOutDTO;
	}

	public void setWsCuotaArrOutDTO(WsCuotaOutDTO[] wsCuotaArrOutDTO) {
		WsCuotaArrOutDTO = wsCuotaArrOutDTO;
	}

}