package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AperturaRangoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class RespuestaImasDAperturaRangoDTO extends AperturaRangoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	private RetornoDTO error;	
		
	public RetornoDTO getError() {
		return error;
	}
	public void setError(RetornoDTO error) {
		this.error = error;
	}

}
