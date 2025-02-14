package com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;

public interface GestionActivacionServiciosSrvIF 
{
	public RetornoDTO informarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException;
	public RetornoDTO desactivarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException;
	public RetornoDTO desactivarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException;
	public RetornoDTO eliminarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException;
	public EspecPlanTasacionListDTO obtenerPlanesTasacion( ) throws IssSerOrdException;

}
