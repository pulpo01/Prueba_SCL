package com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.operations.rmo.rp.issresord.common.exception.IssResOrdException;

public interface GestionActivacionRecursosSrvIF 
{
	public RetornoDTO informarPerfilProvisionamiento(PerfilProvisionamientoListDTO perfilProv) throws IssResOrdException;
	public RetornoDTO informarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException;
	public RetornoDTO eliminarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException;
}
