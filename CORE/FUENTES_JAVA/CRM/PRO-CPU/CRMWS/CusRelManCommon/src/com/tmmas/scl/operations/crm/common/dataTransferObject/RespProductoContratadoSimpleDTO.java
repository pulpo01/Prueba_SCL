package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class RespProductoContratadoSimpleDTO  extends RetornoDTO implements Serializable 
{
	private ProductoContratadoSimpleDTO[] productoContratadoSimpleDTO;

	public ProductoContratadoSimpleDTO[] getProductoContratadoSimpleDTO() {
		return productoContratadoSimpleDTO;
	}

	public void setProductoContratadoSimpleDTO(
			ProductoContratadoSimpleDTO[] productoContratadoSimpleDTO) {
		this.productoContratadoSimpleDTO = productoContratadoSimpleDTO;
	}

}
