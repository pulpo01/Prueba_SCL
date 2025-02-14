package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListadoTiposIdentificacionOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private IdentificadorCivilDTO[] identificadorCivilDTOs;

	public IdentificadorCivilDTO[] getIdentificadorCivilDTOs() {
		return identificadorCivilDTOs;
	}

	public void setIdentificadorCivilDTOs(
			IdentificadorCivilDTO[] identificadorCivilDTOs) {
		this.identificadorCivilDTOs = identificadorCivilDTOs;
	}

	


}
