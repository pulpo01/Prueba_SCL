package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;


public interface GestionActivacionesSrvIF 
{	
	public RetornoDTO activarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException;			
	public RetornoDTO activarPaqueteContratado(PaqueteContratadoListDTO paquetes) throws IssCusOrdException;
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws IssCusOrdException;
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws IssCusOrdException;
	public RetornoDTO desactivarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException;
	public RetornoDTO descontratarProductoContratado(ProductoContratadoListDTO productoContratadoList) throws IssCusOrdException;
	public RetornoDTO enviarCorreo(ProductoContratadoListDTO productos) throws IssCusOrdException;
}
