package com.tmmas.scl.operations.rmo.rp.issresord.srvrec;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.PerfilProvisionamientoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.PerfilProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.PerfilProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionProvisionamientoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoIT;
import com.tmmas.scl.operations.rmo.rp.issresord.common.exception.IssResOrdException;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.helper.Global;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces.GestionActivacionRecursosSrvIF;

public class GestionActivacionRecursosSrv implements GestionActivacionRecursosSrvIF
{
	private final Logger logger = Logger.getLogger(GestionActivacionRecursosSrv.class);
	
	private PerfilProvisionamientoBOFactoryIT factoryBO1 = new PerfilProvisionamientoBOFactory();	
	private PerfilProvisionamientoIT perfilProvBO = factoryBO1.getBusinessObject1();
	
	private EspecificacionProvisionamientoBOFactoryIT factoryBO2 = new EspecificacionProvisionamientoBOFactory();	
	private EspecificacionProvisionamientoIT especificacionProvBO = factoryBO2.getBusinessObject1();
	
	private Global global = Global.getInstance();
	
	public RetornoDTO informarPerfilProvisionamiento(PerfilProvisionamientoListDTO perfilProv) throws IssResOrdException 
	{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarPerfilProvisionamiento():start");
			retorno = perfilProvBO.informar(perfilProv);
			logger.debug("informarPerfilProvisionamiento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssResOrdException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
		}
		return retorno;	
	}

	public RetornoDTO informarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException 
	{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarPerfilProvisionamiento():start");
			retorno = especificacionProvBO.generarMovimiento(listaProductos);
			logger.debug("informarPerfilProvisionamiento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssResOrdException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO eliminarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException 
	{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPerfilProvisionamiento():start");
			retorno = especificacionProvBO.eliminarMovimiento(listaProductos);
			logger.debug("eliminarPerfilProvisionamiento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssResOrdException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
		}
		return retorno;	
	}

}
