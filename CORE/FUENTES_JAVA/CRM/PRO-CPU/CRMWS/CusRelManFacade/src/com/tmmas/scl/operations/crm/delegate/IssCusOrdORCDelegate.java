package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;


public class IssCusOrdORCDelegate 
{
	private final Logger logger = Logger.getLogger(IssCusOrdORCDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public IssCusOrdORCDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public RetornoDTO anulacionVenta(VentaDTO venta) throws IssCusOrdException, RemoteException 
	{	
		try
		{
			return this.facadeMaker.getIssCusOrdORC().anulacionVenta(venta);
		}
		catch(IssCusOrdException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.debug("Exception en WS anulacionVenta : "+e);
			throw new IssCusOrdException(e);
		}			
	}
	
	public RetornoDTO activarDesactivarMantenerProductos(ContenedorPlanesAdicionalesDTO contenedor) throws IssCusOrdException
	{
		logger.debug("activarDesactivarMantenerProductos():start");
		RetornoDTO retorno=null;
		try
		{
			logger.debug("getIssCusOrdORC().ejecutarMantencionPlanesAdicionales:antes");
			retorno=this.facadeMaker.getIssCusOrdORC().ejecutarMantencionPlanesAdicionales(contenedor);
			logger.debug("getIssCusOrdORC().ejecutarMantencionPlanesAdicionales:despues");
		}
		catch(IssCusOrdException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.debug("Exception en WS activarDesactivarMantenerProductos : "+e);
			throw new IssCusOrdException(e);
		}
		logger.debug("activarDesactivarMantenerProductos():end");
		return retorno;
	}
	
	public RetornoDTO activarProductoContratado(OfertaComercialDTO ofertaComercial) throws IssCusOrdException
	{
		logger.debug("activarProductoContratado():start");
		RetornoDTO retorno=null;
		try
		{
			logger.debug("getIssCusOrdORC().activarProductoContratado:antes");
			retorno=this.facadeMaker.getIssCusOrdORC().activarProductoContratado(ofertaComercial);
			logger.debug("getIssCusOrdORC().activarProductoContratado:despues");
		}
		catch(IssCusOrdException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.debug("Exception en WS activarProductoContratado : "+e);
			throw new IssCusOrdException(e);
		}
		logger.debug("activarProductoContratado():end");
		return retorno;
	}
	
	public RetornoDTO descontratarOfertaComercial(ProductoContratadoListDTO productoContratadoListDTO) throws IssCusOrdException
	{
		logger.debug("descontratarOfertaComercial():start");
		RetornoDTO retorno=null;
		try
		{
			logger.debug("getIssCusOrdORC().descontratarOfertaComercial:antes");
			retorno=this.facadeMaker.getIssCusOrdORC().descontratarOfertaComercial(productoContratadoListDTO);
			logger.debug("getIssCusOrdORC().descontratarOfertaComercial:despues");
		}
		catch(IssCusOrdException e){
			throw e;
		}
		catch(Exception e)
		{
			logger.debug("Exception en WS descontratarOfertaComercial : "+e);
			throw new IssCusOrdException(e);
		}
		logger.debug("descontratarOfertaComercial():end");
		return retorno;
	}
}
