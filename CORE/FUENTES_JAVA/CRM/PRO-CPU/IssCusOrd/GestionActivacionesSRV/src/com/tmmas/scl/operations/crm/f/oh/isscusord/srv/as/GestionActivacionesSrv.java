package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF;

public class GestionActivacionesSrv implements GestionActivacionesSrvIF {

	private final Logger logger = Logger.getLogger(GestionActivacionesSrv.class);
	
	private ProductoContratadoBOFactoryIT factoryBO1 = new ProductoContratadoBOFactory();	
	private ProductoContratadoIT productoBO = factoryBO1.getBusinessObject1();
		
	
	private Global global = Global.getInstance();

	/**
	 * @param productos
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 */
	public RetornoDTO activarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("activarProductoContratado():start");			
			retorno = productoBO.activar(productos);			
			logger.debug("activarProductoContratado():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}
//--------------------------------------------------------------------	
	
	/**
	 * @param productos
	 * @return RetornoDTO 
	 * @throws IssCusOrdException 
	 */
	public RetornoDTO enviarCorreo(ProductoContratadoListDTO productos) throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("enviarCorreo():start");			
			retorno = productoBO.enviarCorreo(productos);		
			logger.debug("enviarCorreo():end");			
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}
//--------------------------------------------------------------------	
	
	/**
	 * @param paquetes
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 */	
	public RetornoDTO activarPaqueteContratado(PaqueteContratadoListDTO paquetes) throws IssCusOrdException 
	{
		RetornoDTO retorno=new RetornoDTO();
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("activarPaqueteContratado():start");			
			retorno = productoBO.activar(paquetes);			
			logger.debug("activarPaqueteContratado():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}
//	--------------------------------------------------------------------
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws IssCusOrdException 
	{
		ProductoContratadoListDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("obtenerProductosContratadosVenta():start");			
			retorno = productoBO.obtenerProductosContratadosVenta(venta);			
			logger.debug("obtenerProductosContratadosVenta():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}
//	--------------------------------------------------------------------
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws IssCusOrdException 
	{
		ProductoContratadoListDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("obtenerProductoContratado():start");			
			retorno = productoBO.obtenerProductoContratado(ordenServicio);			
			logger.debug("obtenerProductoContratado():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}	
//	--------------------------------------------------------------------
	
	/**
	 * @param productos
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 */	
	public RetornoDTO desactivarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException 
	{
		RetornoDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("desactivarProductoContratado():start");			
			retorno = productoBO.desactivar(productos);		
			logger.debug("desactivarProductoContratado():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}
//	--------------------------------------------------------------------	
	/**
	 * @param productos
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 */	
	public RetornoDTO descontratarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException 
	{
		RetornoDTO retorno = null;
		try {			
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);			
			logger.debug("desactivarProductoContratado():start");
			//public RetornoDTO descontratar(ProductoContratadoListDTO listaProductosContratados) throws ProductException;
			retorno = productoBO.descontratar(productos);
			logger.debug("desactivarProductoContratado():end");			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}	
//	--------------------------------------------------------------------
}
