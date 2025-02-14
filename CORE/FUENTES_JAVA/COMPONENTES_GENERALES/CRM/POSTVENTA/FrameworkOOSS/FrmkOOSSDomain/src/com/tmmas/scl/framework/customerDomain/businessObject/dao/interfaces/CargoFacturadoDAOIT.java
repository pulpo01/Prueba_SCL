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
 * 29-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;


public interface CargoFacturadoDAOIT 
{
	public RetornoDTO informar(CargoOcasionalDTO cargoOcacional) throws CustomerBillException;
	public RetornoDTO informar(CargoRecurrenteDTO cargoRecurrente) throws CustomerBillException;
	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws CustomerBillException;
	public RetornoDTO eliminarRecurrente(ProductoContratadoDTO productoContratado) throws CustomerBillException;
	public RetornoDTO eliminarOcasionales(ProductoContratadoDTO productoContratado) throws CustomerBillException;
	public RetornoDTO informarDescuentos(DescuentoProductoDTO descuento) throws CustomerBillException;
}
