package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosInBeneficioDTO;

public class ProdOfertablesBenefDTO extends DatosInBeneficioDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoriaDTO;

	public AuditoriaDTO getAuditoriaDTO() {
		return auditoriaDTO;
	}

	public void setAuditoriaDTO(AuditoriaDTO auditoriaDTO) {
		this.auditoriaDTO = auditoriaDTO;
	} 

}
