package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;

public class WsListadoComunasOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ComunaSPNDTO[] comunaSPNDTOs;

	public ComunaSPNDTO[] getComunaSPNDTOs() {
		return comunaSPNDTOs;
	}

	public void setComunaSPNDTOs(ComunaSPNDTO[] comunaSPNDTOs) {
		this.comunaSPNDTOs = comunaSPNDTOs;
	}








	


}
