package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;

public class DatosOutWSListaPLanesDTO extends RetornoDTO implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ProductoOfertadoListDTO productoOfertadoListDTO;

	public ProductoOfertadoListDTO getProductoOfertadoListDTO() {
		return productoOfertadoListDTO;
	}

	public void setProductoOfertadoListDTO(
			ProductoOfertadoListDTO productoOfertadoListDTO) {
		this.productoOfertadoListDTO = productoOfertadoListDTO;
	}
	
}
