package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListadoCategoriaCambioDTO extends RetornoDTO implements Serializable{
	
	/**
	 * CSR-11002 - (AL) - 2011.07.27
	 */
	private static final long serialVersionUID = 1L;
	private CategoriaCambioDTO[] categoriaCambioDTO;

	public CategoriaCambioDTO[] getCategoriaCambioDTO() {
		return categoriaCambioDTO;
	}

	public void setCategoriaCambioDTO(CategoriaCambioDTO[] categoriaCambioDTO) {
		this.categoriaCambioDTO = categoriaCambioDTO;
	}
}
