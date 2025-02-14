package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsListContratoOutDTO extends RetornoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private WsContratoVigenciaOutDTO[] wsContratoVigenciaArrOutDTO;

	public WsContratoVigenciaOutDTO[] getWsContratoVigenciaArrOutDTO() {
		return wsContratoVigenciaArrOutDTO;
	}

	public void setWsContratoVigenciaArrOutDTO(
			WsContratoVigenciaOutDTO[] wsContratoVigenciaArrOutDTO) {
		this.wsContratoVigenciaArrOutDTO = wsContratoVigenciaArrOutDTO;
	}

}
