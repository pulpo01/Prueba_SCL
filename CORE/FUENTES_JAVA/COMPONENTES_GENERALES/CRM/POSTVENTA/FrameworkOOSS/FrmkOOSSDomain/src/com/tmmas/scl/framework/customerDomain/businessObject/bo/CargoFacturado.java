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
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CargoFacturadoIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.CargoFacturadoDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CargoFacturadoDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;

public class CargoFacturado implements CargoFacturadoIT
{
	private CargoFacturadoDAOIT cargoFacturadoDAO=new CargoFacturadoDAO();
		
	private final Logger logger = Logger.getLogger(CargoFacturado.class);
	private Global global = Global.getInstance();

	public RetornoDTO informar(CargoOcasionalListDTO cargoOcacional) throws CustomerBillException 
	{		
		RetornoDTO retorno = null;
		try {
			logger.debug("informar():start");
			for(int i=0;i<cargoOcacional.getCargoOcasional().length;i++)
			{
				retorno = cargoFacturadoDAO.informar(cargoOcacional.getCargoOcasional()[i]);
				
				if(cargoOcacional.getCargoOcasional()[i].getDescuentos()!=null)
				{
					DescuentoProductoListDTO descuentos=cargoOcacional.getCargoOcasional()[i].getDescuentos();
					DescuentoProductoDTO dto=null;
					
					for(int j=0;j<descuentos.getDescuentoList().length;j++)					
					{
						dto=descuentos.getDescuentoList()[j];
						dto.setCodConcerel(cargoOcacional.getCargoOcasional()[i].getCodConcepto());
						dto.setCodConcepto(dto.getCodConceptoDescuento());
						dto.setNumAbonado(cargoOcacional.getCargoOcasional()[i].getNumAbonado());
						dto.setCodCliente(cargoOcacional.getCargoOcasional()[i].getCodCliente());
						dto.setCodProdContratado(cargoOcacional.getCargoOcasional()[i].getCodProdContratado());
						dto.setIdCargo(cargoOcacional.getCargoOcasional()[i].getIdCargo());
						dto.setFecAlta(cargoOcacional.getCargoOcasional()[i].getFecAlta());
						dto.setImpCargo(dto.getValDescuento());
						dto.setNumVenta(cargoOcacional.getCargoOcasional()[i].getNumVenta());
						dto.setCodTecnologia(cargoOcacional.getCargoOcasional()[i].getCodTecnologia());
						dto.setCodCiclFact(cargoOcacional.getCargoOcasional()[i].getCodTecnologia());
						
						retorno= cargoFacturadoDAO.informarDescuentos(dto);						
					}
				}
			}				
			logger.debug("informar():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;	
	}

	public RetornoDTO informar(CargoRecurrenteListDTO cargoRecurrente) throws CustomerBillException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("informar():start");
			for(int i=0;i<cargoRecurrente.getCargoRecurrente().length;i++)
			{
				retorno = cargoFacturadoDAO.informar(cargoRecurrente.getCargoRecurrente()[i]);			
			}				
			logger.debug("informar():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;			
	}

	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws CustomerBillException {
		RetornoDTO retorno = null;
		try {
			logger.debug("informar():start");
			retorno = cargoFacturadoDAO.obtenerEstado(ventaDTO);
			logger.debug("informar():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;			
	}

	public RetornoDTO eliminar(ProductoContratadoListDTO listProductosContratados) throws CustomerBillException 
	{
		RetornoDTO retorno = new RetornoDTO();
		try 
		{
			logger.debug("eliminar():start");
			for(int i=0;i<listProductosContratados.getProductosContratadosDTO().length;i++)
			{				
				retorno=cargoFacturadoDAO.eliminarRecurrente(listProductosContratados.getProductosContratadosDTO()[i]);
				retorno=cargoFacturadoDAO.eliminarOcasionales(listProductosContratados.getProductosContratadosDTO()[i]);
			}			
			
			logger.debug("eliminar():end");
		}
		catch (CustomerBillException e) 
		{
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;		
	}
	
	public RetornoDTO desactivar(ProductoContratadoListDTO listProductosContratados) throws CustomerBillException 
	{
		RetornoDTO retorno = new RetornoDTO();
		try 
		{
			logger.debug("eliminar():start");
			for(int i=0;i<listProductosContratados.getProductosContratadosDTO().length;i++)
			{				
				retorno = cargoFacturadoDAO.eliminarRecurrente(listProductosContratados.getProductosContratadosDTO()[i]);
			}			
			
			logger.debug("eliminar():end");
		}
		catch (CustomerBillException e) 
		{
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;		
	}
}
