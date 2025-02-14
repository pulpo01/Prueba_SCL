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
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.ListaNumerosIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.ListaNumerosDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ListaNumerosDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ListaNumeros implements ListaNumerosIT
{
	private ListaNumerosDAOIT listaNumerosDAO = new ListaNumerosDAO();
	
	private final Logger logger = Logger.getLogger(ListaNumeros.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO actualizarNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarNumerosAfines():start");
			retorno = listaNumerosDAO.actualizarNumerosAfines(listaNumeros);
			logger.debug("actualizarNumerosAfines():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO actualizarNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarNumerosFrecuentes():start");
			retorno = listaNumerosDAO.actualizarNumerosFrecuentes(listaNumeros);
			logger.debug("actualizarNumerosFrecuentes():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO crearNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("crearNumerosAfines():start");
			retorno = listaNumerosDAO.crearNumerosAfines(listaNumeros);
			logger.debug("crearNumerosAfines():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO crearNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("crearNumerosFrecuentes():start");
			retorno = listaNumerosDAO.crearNumerosFrecuentes(listaNumeros);
			logger.debug("crearNumerosFrecuentes():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO eliminar(ProductoContratadoListDTO listaProductosContratados) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminar():start");
			retorno = listaNumerosDAO.eliminar(listaProductosContratados);
			logger.debug("eliminar():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado) throws ServiceException 
	{
		NumeroListDTO retorno = null;
		try {
			logger.debug("eliminar():start");
			retorno = listaNumerosDAO.obtenerListaNumeros(productoContratado);
			logger.debug("eliminar():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO crear(NumeroListDTO listaNumeros) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("crear():start");			
			retorno = listaNumerosDAO.crear(listaNumeros);
			logger.debug("crear():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO eliminaListaNumeros(ProductoContratadoListDTO productoContratadoList) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminaListaNumeros():start");
			retorno = listaNumerosDAO.eliminaListaNumeros(productoContratadoList);
			logger.debug("eliminaListaNumeros():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}
	
//---------------------------------------------------------------------------------------------------
	
	public RetornoDTO eliminaListaNumeros(NumeroListDTO listaNumeros) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminaListaNumeros():start");
			for(int i=0;i<listaNumeros.getNumerosDTO().length;i++)
			{
				retorno = listaNumerosDAO.eliminaNumero(listaNumeros.getNumerosDTO()[i]);
			}
			logger.debug("eliminaListaNumeros():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}
	
//	---------------------------------------------------------------------------------------------------
	
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ServiceException {
		NumeroDTO retorno = null;
		try 
		{
			logger.debug("obtieneModificacionesProducto():start");
			retorno = listaNumerosDAO.obtieneModificacionesProducto(productoContratado);
			logger.debug("obtieneModificacionesProducto():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;		
	}
	
}
