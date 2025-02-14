package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListadoCategoriasClienteOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ClienteDTO[] clienteDTOs;

	
	public ClienteDTO[] getClienteDTOs() {
		return clienteDTOs;
	}
	public void setClienteDTOs(ClienteDTO[] clienteDTOs) {
		this.clienteDTOs = clienteDTOs;
	}


}
