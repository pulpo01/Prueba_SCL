package com.tmmas.scl.operations.crm.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CantidadProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;

public class ManCusInvDelegate 
{
	private final Logger logger = Logger.getLogger(ManConFacadeDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public ManCusInvDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO productoList) throws ManCusInvException
	{
		logger.debug("obtenerDetalleProductoContratado():start");
		try
		{
			logger.debug("getManConFacade().obtenerDatosCliente():antes");
			productoList=this.facadeMaker.getManCusInvFacade().obtenerDetalleProductoContratado(productoList);
			logger.debug("getManConFacade().obtenerDatosCliente():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}	
		logger.debug("obtenerDetalleProductoContratado():end");
		return productoList;		
	}
	
	public ProductoContratadoListDTO obtenerProductoContratadoPorPaquete(ProductoContratadoDTO producto) throws ManCusInvException
	{
		logger.debug("obtenerProductoContratadoPorPaquete():start");
		ProductoContratadoListDTO productoList=null;
		try
		{
			PaqueteContratadoDTO paqueteContratado=new PaqueteContratadoDTO();
			paqueteContratado.setIdProdContratado(producto.getIdProdContratado());
			paqueteContratado.setNumAbonadoContratante(producto.getNumAbonadoContratante());
			paqueteContratado.setIdClienteContratante(producto.getIdClienteContratante());
			
			paqueteContratado.setCodProdPadre(String.valueOf(producto.getIdProdContratado().longValue()));
			logger.debug("getManCusInvFacade().obtenerProductoContratadoPorPaquete():antes");
			paqueteContratado=this.facadeMaker.getManCusInvFacade().obtenerProductoContratadoPorPaquete(paqueteContratado);
			logger.debug("getManCusInvFacade().obtenerProductoContratadoPorPaquete():despues");
			productoList=paqueteContratado.getListaProductosContratados();
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}	
		logger.debug("obtenerProductoContratadoPorPaquete():end");
		return productoList;		
	}
	
	public ProductoContratadoListDTO obtenerProductosContratados(AbonadoDTO abonado) throws ManCusInvException
	{
		logger.debug("obtenerProductosContratados():start");
		ProductoContratadoListDTO productos=null;
		try
		{
			OrdenServicioDTO ordenServicio=new OrdenServicioDTO();
			ClienteDTO cliente=new ClienteDTO();
			cliente.setCodCliente(abonado.getCodCliente());
			AbonadoListDTO listaAbonados=new AbonadoListDTO();
			AbonadoDTO[] arrAbon={abonado};
			listaAbonados.setAbonados(arrAbon);
			cliente.setAbonados(listaAbonados);
			ordenServicio.setCliente(cliente);
			logger.debug("getManCusInvFacade().obtenerProductoContratado():antes");
			productos=this.facadeMaker.getManCusInvFacade().obtenerProductoContratado(ordenServicio);
			logger.debug("getManCusInvFacade().obtenerProductoContratado():despes");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("obtenerProductosContratados():end");
		return productos;
	}
	
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ManCusInvException{
		NumeroDTO retValue = null;
		logger.debug("obtieneModificacionesProducto():start");
		try {
			logger.debug("getManCusInvFacade().obtieneModificacionesProducto():antes");
			retValue= this.facadeMaker.getManCusInvFacade().obtieneModificacionesProducto(productoContratado);
			logger.debug("getManCusInvFacade().obtieneModificacionesProducto():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e){
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("obtieneModificacionesProducto():end");
		return retValue;
		
	}
	

	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado) throws ManCusInvException
	{
		logger.debug("obtenerListaNumeros():start");
		NumeroListDTO lista=null;
		
		try
		{
			logger.debug("getManCusInvFacade().obtenerListaNumeros():antes");
			lista=this.facadeMaker.getManCusInvFacade().obtenerListaNumeros(productoContratado);
			logger.debug("getManCusInvFacade().obtenerListaNumeros():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("obtenerListaNumeros():end");
		return lista;
	}
	
	public CantidadProductoContratadoDTO obtieneCantidadProductosContratados(CantidadProductoContratadoDTO producto) throws ManCusInvException
	{
		logger.debug("obtieneCantidadProductosContratados():start");
		CantidadProductoContratadoDTO retorno=null;
		
		try
		{
			logger.debug("getManCusInvFacade().obtieneCantidadProductosContratados():antes");
			retorno=this.facadeMaker.getManCusInvFacade().obtieneCantidadProductosContratados(producto);
			logger.debug("getManCusInvFacade().obtieneCantidadProductosContratados():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("obtieneCantidadProductosContratados():end");
		return retorno;
	}
	
	public RetornoDTO crearListaNumeros(NumeroListDTO numeroListDTO) throws ManCusInvException
	{
		logger.debug("crearListaNumeros():start");
		RetornoDTO retorno=null;
		
		try
		{
			logger.debug("getManCusInvFacade().crearListaNumeros():antes");
			retorno=this.facadeMaker.getManCusInvFacade().crearListaNumeros(numeroListDTO);
			logger.debug("getManCusInvFacade().crearListaNumeros():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("crearListaNumeros():end");
		return retorno;
	}
	
	public RetornoDTO eliminarListaNumeros(NumeroListDTO numeroListDTO) throws ManCusInvException
	{
		logger.debug("eliminarListaNumeros():start");
		RetornoDTO retorno=null;
		
		try
		{
			logger.debug("getManCusInvFacade().eliminarListaNumeros():antes");
			retorno=this.facadeMaker.getManCusInvFacade().eliminarListaNumeros(numeroListDTO);
			logger.debug("getManCusInvFacade().eliminarListaNumeros():despues");
		}catch(ManCusInvException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.error(e);
			throw new ManCusInvException(e);
		}
		logger.debug("eliminarListaNumeros():end");
		return retorno;
	}
	
}
