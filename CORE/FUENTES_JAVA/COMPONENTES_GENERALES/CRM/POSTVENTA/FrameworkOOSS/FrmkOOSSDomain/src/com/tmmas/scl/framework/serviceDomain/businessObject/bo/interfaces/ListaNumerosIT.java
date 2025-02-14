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
 * 25-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public interface ListaNumerosIT 
{
	public RetornoDTO actualizarNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException;
	
	public RetornoDTO actualizarNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException;
	
	public RetornoDTO crearNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException;
	
	public RetornoDTO crearNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException;
	
	public RetornoDTO eliminar(ProductoContratadoListDTO listaProductosContratados) throws ServiceException;
	
	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado) throws ServiceException;
	
	public RetornoDTO crear(NumeroListDTO listaNumeros) throws ServiceException;
	
	public RetornoDTO eliminaListaNumeros(ProductoContratadoListDTO productoContratadoList) throws ServiceException;
	
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ServiceException;
	
	public RetornoDTO eliminaListaNumeros(NumeroListDTO listaNumeros) throws ServiceException;
}
