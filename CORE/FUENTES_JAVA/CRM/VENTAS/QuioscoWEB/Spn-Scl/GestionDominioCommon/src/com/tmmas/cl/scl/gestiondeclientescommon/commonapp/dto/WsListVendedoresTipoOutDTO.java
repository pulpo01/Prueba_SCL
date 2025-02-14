package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListVendedoresTipoOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private WsVendedorInterDealerOutDTO[] wsVendedorInterDealerArrOutDTO;

	public WsVendedorInterDealerOutDTO[] getWsVendedorInterDealerArrOutDTO() {
		return wsVendedorInterDealerArrOutDTO;
	}

	public void setWsVendedorInterDealerArrOutDTO(
			WsVendedorInterDealerOutDTO[] wsVendedorInterDealerArrOutDTO) {
		this.wsVendedorInterDealerArrOutDTO = wsVendedorInterDealerArrOutDTO;
	}

	
	

}
