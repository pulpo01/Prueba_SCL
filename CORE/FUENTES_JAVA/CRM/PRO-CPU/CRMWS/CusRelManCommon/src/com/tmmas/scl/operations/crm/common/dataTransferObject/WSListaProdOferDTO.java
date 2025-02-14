package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class WSListaProdOferDTO extends RetornoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProdOfertableDTO[] prodOfertableDTO ;

	public ProdOfertableDTO[] getProdOfertableDTO() {
		return prodOfertableDTO;
	}

	public void setProdOfertableDTO(ProdOfertableDTO[] prodOfertableDTO) {
		this.prodOfertableDTO = prodOfertableDTO;
	}
	
	 
	

}
