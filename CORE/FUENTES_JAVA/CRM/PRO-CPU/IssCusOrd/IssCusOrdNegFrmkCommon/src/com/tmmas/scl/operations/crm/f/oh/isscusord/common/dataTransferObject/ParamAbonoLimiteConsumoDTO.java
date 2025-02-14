package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;

public class ParamAbonoLimiteConsumoDTO extends OrdenServicioBaseDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AbonoLimiteConsumoListDTO listaAbonosLc;
	
	public AbonoLimiteConsumoListDTO getListaAbonosLc() {
		return listaAbonosLc;
	}
	public void setListaAbonosLc(AbonoLimiteConsumoListDTO listaAbonosLc) {
		this.listaAbonosLc = listaAbonosLc;
	}

}
