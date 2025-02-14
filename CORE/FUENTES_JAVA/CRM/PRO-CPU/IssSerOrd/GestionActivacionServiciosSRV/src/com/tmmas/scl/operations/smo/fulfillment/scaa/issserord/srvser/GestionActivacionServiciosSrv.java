package com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.ProductoTasacionContratadoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ProductoTasacionContratadoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ProductoTasacionContratadoIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionPlanTasacionBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionPlanTasacionBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionPlanTasacionIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.helper.Global;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces.GestionActivacionServiciosSrvIF;

public class GestionActivacionServiciosSrv implements GestionActivacionServiciosSrvIF
{
	private final Logger logger = Logger.getLogger(GestionActivacionServiciosSrv.class);
	
	private ProductoTasacionContratadoBOFactoryIT factoryBO1 = new ProductoTasacionContratadoBOFactory();
	private ProductoTasacionContratadoIT prodTasCon = factoryBO1.getBusinessObject1();
	
	private EspecificacionPlanTasacionBOFactoryIT factoryBO2 = new EspecificacionPlanTasacionBOFactory();
	private EspecificacionPlanTasacionIT espPlanTas = factoryBO2.getBusinessObject1();
	
	private Global global = Global.getInstance();

	public RetornoDTO desactivarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException 
	{
		RetornoDTO retorno = null;
		logger.debug("desactivarProductoTasacionContratado():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminar():antes");
			retorno = prodTasCon.eliminar(listaProdTas);
			logger.debug("eliminar():despues");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssSerOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		logger.debug("desactivarProductoTasacionContratado():end");
		return retorno;	
	}

	public RetornoDTO informarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException 
	{
		RetornoDTO retorno = null;
		logger.debug("informarProductoTasacionContratado():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informar():antes");
			retorno = prodTasCon.informar(listaProdTas);
			logger.debug("informar():despues");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssSerOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		logger.debug("informarProductoTasacionContratado():end");
		return retorno;	
	}

	public RetornoDTO desactivarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException 
	{
		RetornoDTO retorno = null;
		logger.debug("desactivarProductoTasacionContratado():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminar():antes");
			retorno = prodTasCon.eliminar(listaProductos);
			logger.debug("eliminar():despues");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssSerOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());			
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		logger.debug("desactivarProductoTasacionContratado():end");
		return retorno;	
	}

	public RetornoDTO eliminarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException 
	{
		RetornoDTO retorno = null;
		logger.debug("eliminarProductoTasacionContratado():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarProductoTasacionContratado():antes");
			retorno = prodTasCon.eliminarProductoTasacionContratado(listaProductos);
			logger.debug("eliminarProductoTasacionContratado():despues");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssSerOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());			
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		logger.debug("eliminarProductoTasacionContratado():end");
		return retorno;	
	}
	
	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws IssSerOrdException {
		EspecPlanTasacionListDTO retorno = null;
		logger.debug("obtenerPlanesTasacion():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPlanesTasacion():antes");
			retorno = espPlanTas.obtenerPlanesTasacion();
			logger.debug("obtenerPlanesTasacion():despues");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssSerOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		logger.debug("obtenerPlanesTasacion():end");
		return retorno;
	}

}
