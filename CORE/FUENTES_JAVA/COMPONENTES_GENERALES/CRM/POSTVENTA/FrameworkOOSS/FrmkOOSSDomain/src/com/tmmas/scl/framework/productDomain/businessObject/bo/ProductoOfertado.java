package com.tmmas.scl.framework.productDomain.businessObject.bo;


import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ProductoOfertadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;

public class ProductoOfertado implements ProductoOfertadoIT {

	private ProductoOfertadoDAO prodOfertadoDAO = new ProductoOfertadoDAO();
	private EspecificacionProducto espProd = new EspecificacionProducto();
	
	private final Logger logger = Logger.getLogger(ProductoOfertado.class);
	private Global global = Global.getInstance();
		



	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException {
		
		ProductoOfertadoListDTO prodOfertables = new ProductoOfertadoListDTO();
		ProductoOfertadoListDTO resultado = new ProductoOfertadoListDTO();
		
			logger.debug("Inicio:obtenerProductosOfertables()");
			prodOfertables = prodOfertadoDAO.obtenerProductosOfertables(abonado);
			logger.debug("Fin:obtenerProductosOfertables()");
		try
		{
			logger.debug("Inicio:obtenerEspecificacionProducto()");
			resultado = espProd.obtenerEspecificacionProducto(prodOfertables);
			logger.debug("Fin:obtenerEspecificacionProducto()");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}
		return resultado;
	}

	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException 
	{	
		logger.debug("Inicio:obtenerDetalleProductos()");
		ProductoOfertadoListDTO resultado = new ProductoOfertadoListDTO();		
		resultado = prodOfertadoDAO.obtenerDetalleProductos(listaProductos);				
		
		try 
		{
			resultado = espProd.obtenerEspecificacionProducto(resultado);			
		}
		catch (ProductSpecificationException e) 
		{
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}
		
		
		logger.debug("Fin:obtenerDetalleProductos()");
		return resultado;
	}

	public ReglasListaNumerosListDTO obtenerRestriccionesLista(EspecServicioListaDTO especServicioLista) throws ProductOfferingException {
		
		ReglasListaNumerosListDTO resultado = new ReglasListaNumerosListDTO();
		try{
			logger.debug("Inicio:obtenerRestriccionesLista()");
			resultado = espProd.obtenerEspecificacionLista(especServicioLista);
			logger.debug("Fin:obtenerRestriccionesLista()");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}
		return resultado;
	}
	
	

	
}
