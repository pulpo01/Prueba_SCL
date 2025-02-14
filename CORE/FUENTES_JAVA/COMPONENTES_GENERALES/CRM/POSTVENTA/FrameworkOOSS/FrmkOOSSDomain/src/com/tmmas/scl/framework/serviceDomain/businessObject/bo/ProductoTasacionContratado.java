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
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.ProductoTasacionContratadoIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.ProductoTasacionContratadoDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.ProductoTasacionContratadoTOLDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.ProductoTasacionContratadoTOLServiceDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoTOLDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoTOLServiceDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ProductoTasacionContratado implements ProductoTasacionContratadoIT
{
	private final Logger logger = Logger.getLogger(ListaNumeros.class);
	private Global global = Global.getInstance();
	private ProductoTasacionContratadoDAOIT productoTasConDAO = new ProductoTasacionContratadoDAO();
	private ProductoTasacionContratadoTOLDAOIT productoTasConTOLDAO= new ProductoTasacionContratadoTOLDAO();
	private ProductoTasacionContratadoTOLServiceDAOIT productoTasConTOLServiceDAO= new ProductoTasacionContratadoTOLServiceDAO();
	
	public RetornoDTO eliminar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminar():start");
			retorno = productoTasConDAO.eliminar(productoTasacion);
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

	public RetornoDTO informar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("informar():start");
			retorno = productoTasConTOLDAO.informar(productoTasacion);
			
			for(int i=0;i<productoTasacion.getProductosTasacionContratados().length;i++)
			{
				if(productoTasacion.getProductosTasacionContratados()[i].getListaNumeros()!=null && productoTasacion.getProductosTasacionContratados()[i].getListaNumeros().getNumerosDTO().length>0)
				{
					NumeroListDTO listaNumeros=productoTasacion.getProductosTasacionContratados()[i].getListaNumeros();
					listaNumeros.setCodCliente(productoTasacion.getCodCliente());
					listaNumeros.setIdProducto(productoTasacion.getProductosTasacionContratados()[i].getCodProductoContratado());
					listaNumeros.setNumAbonado(productoTasacion.getProductosTasacionContratados()[i].getIdAbonado());
					listaNumeros.setTipoComportamiento(productoTasacion.getProductosTasacionContratados()[i].getTipoComp());					
					retorno = productoTasConTOLServiceDAO.informarListaNumeros(listaNumeros);
				}
			}
			logger.debug("informar():end");
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

	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("obtenerEstado():start");
			retorno = productoTasConDAO.obtenerEstado(ventaDTO);
			logger.debug("obtenerEstado():end");
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

	public RetornoDTO eliminar(ProductoContratadoListDTO listProductoContratado) throws ServiceException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminar():start");
			retorno = productoTasConTOLDAO.eliminar(listProductoContratado);
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

	public SaldoProductoTasacionListDTO saldos(SaldoProductoCliente productoCliente) throws ServiceException {
		SaldoProductoTasacionListDTO retorno = null;
		try {
			logger.debug("saldos():start");
			retorno = productoTasConTOLDAO.saldos(productoCliente);
			logger.debug("saldos():end");
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
