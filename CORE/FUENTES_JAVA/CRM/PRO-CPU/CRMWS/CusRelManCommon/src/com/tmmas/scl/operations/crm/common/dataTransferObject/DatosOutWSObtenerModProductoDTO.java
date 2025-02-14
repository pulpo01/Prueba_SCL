package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;

public class DatosOutWSObtenerModProductoDTO extends RetornoDTO implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private NumeroDTO numeroDTO;

	public NumeroDTO getNumeroDTO() {
		return numeroDTO;
	}

	public void setNumeroDTO(NumeroDTO numeroDTO) {
		this.numeroDTO = numeroDTO;
	}

	
}
