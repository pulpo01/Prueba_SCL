package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosOutBeneficioDTO;


public class OutWsDatosOutBeneficioDTO  implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private RetornoDTO retornoDTO;
	private DatosOutBeneficioDTO []datosOutBeneficioDTO;
	
	public DatosOutBeneficioDTO[] getDatosOutBeneficioDTO() {
		return datosOutBeneficioDTO;
	}
	public void setDatosOutBeneficioDTO(DatosOutBeneficioDTO[] datosOutBeneficioDTO) {
		this.datosOutBeneficioDTO = datosOutBeneficioDTO;
	}
	public RetornoDTO getRetornoDTO() {
		return retornoDTO;
	}
	public void setRetornoDTO(RetornoDTO retornoDTO) {
		this.retornoDTO = retornoDTO;
	} 

}
