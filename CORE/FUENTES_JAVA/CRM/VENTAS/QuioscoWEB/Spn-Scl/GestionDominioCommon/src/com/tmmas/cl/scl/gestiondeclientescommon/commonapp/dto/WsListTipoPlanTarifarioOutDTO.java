package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsListTipoPlanTarifarioOutDTO extends RetornoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private WsTipoPlanTarifarioOutDTO[] wsTipoPlanTarifarioArrOutDTO;

	public WsTipoPlanTarifarioOutDTO[] getWsTipoPlanTarifarioArrOutDTO() {
		return wsTipoPlanTarifarioArrOutDTO;
	}

	public void setWsTipoPlanTarifarioArrOutDTO(
			WsTipoPlanTarifarioOutDTO[] wsTipoPlanTarifarioArrOutDTO) {
		this.wsTipoPlanTarifarioArrOutDTO = wsTipoPlanTarifarioArrOutDTO;
	}

}
