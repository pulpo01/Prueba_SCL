package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;

public class ManConFacadeDelegate 
{
	private final Logger logger = Logger.getLogger(ManConFacadeDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	
	public ManConFacadeDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
//----------------------------------------------------------------------------------------------------------------------------
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManConException
	{	//logger.debug("obtenerDatosCliente():start");
		try 
		{
			logger.debug("getManConFacade().obtenerDatosCliente():antes");
			cliente=facadeMaker.getManConFacade().obtenerDatosCliente(cliente);
			logger.debug("getManConFacade().obtenerDatosCliente():despues");
		
		}catch(ManConException e){
			throw e;
		}
	    catch (RemoteException e) 
		{
	    	logger.error(e);
	    	throw new ManConException(e);
		}	
	    logger.debug("obtenerDatosCliente():end");
		return cliente;				
	}
//	----------------------------------------------------------------------------------------------------------------------------
	public ClienteDTO obtenerDatosClientePorVenta(VentaDTO venta) throws ManConException
	{
		logger.debug("obtenerDatosClientePorVenta():start");
		ClienteDTO cliente=null;
		try 
		{
			logger.debug("getManConFacade().obtenerDatosCliente():antes");
			cliente=facadeMaker.getManConFacade().obtenerDatosCliente(venta);
			logger.debug("getManConFacade().obtenerDatosCliente():despues");
		}catch(ManConException e){
			throw e;
		}
	    catch (RemoteException e) 
		{
	    	logger.error(e);
	    	throw new ManConException(e);
		}
	    logger.debug("obtenerDatosClientePorVenta():end");
		return cliente;				
	}
	
//----------------------------------------------------------------------------------------------------------------------------	
    public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ManConException
    {
    	logger.debug("obtenerListaAbonados():start");
    	AbonadoListDTO retorno=null;    	
    	try 
    	{
    		logger.debug("getManConFacade().obtenerListaAbonados():antes");
    		retorno=facadeMaker.getManConFacade().obtenerListaAbonados(cliente);
    		logger.debug("getManConFacade().obtenerListaAbonados():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (RemoteException e) 
    	{
    		logger.error(e);
			throw new ManConException(e);
		}
    	logger.debug("obtenerListaAbonados():end");
    	return retorno;    	
    }

//----------------------------------------------------------------------------------------------------------------------------
    public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ManConException
    {
    	logger.debug("obtenerListaAbonados():start");
    	try 
    	{
    		logger.debug("getManConFacade().obtenerDatosAbonado():antes");
    		abonado=facadeMaker.getManConFacade().obtenerDatosAbonado(abonado);
    		logger.debug("getManConFacade().obtenerDatosAbonado():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (RemoteException e) 
		{
    		logger.error(e);
			throw new ManConException(e);
		}
    	logger.debug("obtenerListaAbonados():end");
    	return abonado;    	
		
    }
//  ----------------------------------------------------------------------------------------------------------------------------
    public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO) throws ManConException
    {
    	logger.debug("obtieneAbonadosBeneficiarios():start");
    	AbonadoBeneficiarioListDTO abonBeneficiario=null;
    	try 
    	{
    		logger.debug("getManConFacade().obtieneAbonadosBeneficiarios():antes");
    		abonBeneficiario=facadeMaker.getManConFacade().obtieneAbonadosBeneficiarios(abonadoDTO);
    		logger.debug("getManConFacade().obtieneAbonadosBeneficiarios():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (Exception e) 
		{
    		logger.error(e);
			throw new ManConException(e);
		}
    	logger.debug("obtieneAbonadosBeneficiarios():end");
		return abonBeneficiario;    	
    }
    
//  ----------------------------------------------------------------------------------------------------------------------------
    public AbonadoDTO obtenerDatosAbonadoByNumCelular(AbonadoDTO abonado) throws ManConException
    {
    	logger.debug("obtenerDatosAbonadoByNumCelular():start");
    	try 
    	{
    		logger.debug("getManConFacade().obtenerDatosAbonadoByNumCelular():antes");
			abonado=facadeMaker.getManConFacade().obtenerDatosAbonadoByNumCelular(abonado);
			logger.debug("getManConFacade().obtenerDatosAbonadoByNumCelular():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (RemoteException e) 
		{
    		logger.error("RemoteException", e);
			throw new ManConException(e);
		}
    	logger.debug("obtenerDatosAbonadoByNumCelular():end");
		return abonado;    	
    }
    
//  ----------------------------------------------------------------------------------------------------------------------------
    public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO)throws ManConException 
    {
    	logger.debug("obtieneAbonadosVetados():start");
    	AbonadoVetadoListDTO abonadoVetadoListDTO=null;
    	try 
    	{
    		logger.debug("getManConFacade().obtieneAbonadosVetados():antes");
    		abonadoVetadoListDTO=facadeMaker.getManConFacade().obtieneAbonadosVetados(abonadoDTO);
    		logger.debug("getManConFacade().obtieneAbonadosVetados():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (RemoteException e) 
		{
    		logger.error(e);
			throw new ManConException(e);
		}
    	logger.debug("obtieneAbonadosVetados():end");
		return abonadoVetadoListDTO;    	
    }
    
    //  ----------------------------------------------------------------------------------------------------------------------------
    public IntegracionInClasificacionDTO consultaClasificacionCliente(IntegracionInClasificacionDTO integracionInClasificacionDTO) throws ManConException
    {
    	logger.debug("consultaClasificacionCliente():start");
    	IntegracionInClasificacionDTO retValue=null;
    	try 
    	{
    		logger.debug("getManConFacade().consultaClasificacionCliente():antes");
    		retValue=facadeMaker.getManConFacade().consultaClasificacionCliente(integracionInClasificacionDTO);
    		logger.debug("getManConFacade().consultaClasificacionCliente():despues");
		}catch(ManConException e){
			throw e;
		}
    	catch (RemoteException e) 
		{
    		logger.error(e);
			throw new ManConException(e);
		}
    	logger.debug("consultaClasificacionCliente():end");
		return retValue;    	 
    }
}
