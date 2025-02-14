package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;

public class ParamMantencionLimiteConsumoDTO extends OrdenServicioBaseDTO {

	private static final long serialVersionUID = 1L;
	private ProductoContratadoListDTO listaProdContraMantenidosLC;
	
	public ProductoContratadoListDTO getListaProdContraMantenidosLC() {
		return listaProdContraMantenidosLC;
	}
	public void setListaProdContraMantenidosLC(
			ProductoContratadoListDTO listaProdContraMantenidosLC) {
		this.listaProdContraMantenidosLC = listaProdContraMantenidosLC;
	}
	
	
	
	
}
