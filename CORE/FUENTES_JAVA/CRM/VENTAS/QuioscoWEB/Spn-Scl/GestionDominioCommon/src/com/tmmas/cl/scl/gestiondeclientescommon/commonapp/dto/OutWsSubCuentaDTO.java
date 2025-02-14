package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class OutWsSubCuentaDTO extends RetornoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SubCuentaDTO[] subCuentasDTO;

	public SubCuentaDTO[] getSubCuentasDTO() {
		return subCuentasDTO;
	}

	public void setSubCuentasDTO(SubCuentaDTO[] subCuentasDTO) {
		this.subCuentasDTO = subCuentasDTO;
	}
}
