package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;

public class InWsClasifClienteDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private AuditoriaDTO auditoriaDTO;
	private String numCelular;
	
	public AuditoriaDTO getAuditoriaDTO() {
		return auditoriaDTO;
	}
	public void setAuditoriaDTO(AuditoriaDTO auditoriaDTO) {
		this.auditoriaDTO = auditoriaDTO;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	
	
	

}
