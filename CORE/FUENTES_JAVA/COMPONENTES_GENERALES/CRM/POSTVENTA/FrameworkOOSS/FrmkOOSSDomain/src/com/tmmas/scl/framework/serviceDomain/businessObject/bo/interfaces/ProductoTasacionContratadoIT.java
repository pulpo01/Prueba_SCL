/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 03-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public interface ProductoTasacionContratadoIT 
{
	public RetornoDTO informar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException;
	public RetornoDTO eliminar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException;
	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws ServiceException;
	public RetornoDTO eliminar(ProductoContratadoListDTO listProductoContratado) throws ServiceException;
	public SaldoProductoTasacionListDTO saldos(SaldoProductoCliente clienteProducto) throws ServiceException;
}
