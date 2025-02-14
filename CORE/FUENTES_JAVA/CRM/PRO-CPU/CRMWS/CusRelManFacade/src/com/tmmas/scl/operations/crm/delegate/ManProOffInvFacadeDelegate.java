package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;


public class ManProOffInvFacadeDelegate 
{
	private final Logger logger = Logger.getLogger(ManProOffInvFacadeDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public ManProOffInvFacadeDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	
	/**
	 * Obbtiene los productos ofertados (detalle) y cargos asociados al canal
	 * @param abonado
	 * @return
	 * @throws ManProOffInvException
	 */
	public ProductoOfertadoListDTO obtenerProductosOfertablesporCanal(AbonadoDTO abonado) throws ManProOffInvException
	{	
		logger.debug("obtenerProductosOfertablesporCanal():start");
		ProductoOfertadoListDTO retorno=null;
		try {
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesporCanal():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesporCanal(abonado);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesporCanal():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			logger.debug("RemoteException", e);
			throw new 	ManProOffInvException(e);			
		}
		logger.debug("obtenerProductosOfertablesporCanal():end");
		return retorno;
	}	
	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO prodOfertado) throws ManProOffInvException
	{	
		logger.debug("obtenerDetalleProductos():start");
		ProductoOfertadoListDTO retorno=null;
		try {
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerDetalleProductos():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerDetalleProductos(prodOfertado);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerDetalleProductos():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new 	ManProOffInvException(e);			
		}
		logger.debug("obtenerDetalleProductos():end");
		return retorno;
	}
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ManProOffInvException 
	{	
		logger.debug("obtenerProductosOfertables():start");
		ProductoOfertadoListDTO retorno=null;
		try {
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertables():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerProductosOfertables(abonado);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertables():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new 	ManProOffInvException(e);
		}
		logger.debug("obtenerProductosOfertables():end");
		return retorno;
	}
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws ManProOffInvException
	{
		logger.debug("obtenerProductosOfertablesPorPaquete():start");
		ProductoOfertadoListDTO retorno=null;
		try 
		{
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPorPaquete():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPorPaquete(paquete);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPorPaquete():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new ManProOffInvException(e);
		}	
		logger.debug("obtenerProductosOfertablesPorPaquete():end");
		return retorno;
	}
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPaquetePorDefecto(PaqueteDTO paquete) throws ManProOffInvException
	{
		logger.debug("obtenerProductosOfertablesPaquetePorDefecto():start");
		ProductoOfertadoListDTO retorno=null;
		try 
		{
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPaquetePorDefecto():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPaquetePorDefecto(paquete);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerProductosOfertablesPaquetePorDefecto():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new ManProOffInvException(e);
		}
		logger.debug("obtenerProductosOfertablesPaquetePorDefecto():end");
		return retorno;
	}
	
	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ManProOffInvException
	{	
		logger.debug("obtenerDetallePlanTarif():start");	
		try 
		{
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerDetallePlanTarif():antes");
			planTarif=this.facadeMaker.getManProOffInvFacade().obtenerDetallePlanTarif(planTarif);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerDetallePlanTarif():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new ManProOffInvException(e);
		}	
		logger.debug("obtenerDetallePlanTarif():end");	
		return planTarif;
	}
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO productoOfertadoListDTO) throws ManProOffInvException
	{
		logger.debug("obtenerLCplanAdicional():start");
		ProductoOfertadoListDTO retorno=null;
		try  
		{
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerLCplanAdicional():antes");
			retorno=this.facadeMaker.getManProOffInvFacade().obtenerLCplanAdicional(productoOfertadoListDTO);
			logger.debug("facadeMaker.getManProOffInvFacade().obtenerLCplanAdicional():despues");
		}catch(ManProOffInvException e){
			throw e;
		}
		catch (RemoteException e) 
		{
			throw new ManProOffInvException(e);
		}
		logger.debug("obtenerLCplanAdicional():end");
		return retorno;
	}
	
	
}
