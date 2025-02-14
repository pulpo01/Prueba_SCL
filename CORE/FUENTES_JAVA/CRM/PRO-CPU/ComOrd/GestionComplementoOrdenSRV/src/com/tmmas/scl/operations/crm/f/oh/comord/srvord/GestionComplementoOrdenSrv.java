package com.tmmas.scl.operations.crm.f.oh.comord.srvord;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaServiciosDefaultDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServiciosDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.RestriccionesValidacionesBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.RestriccionesValidacionesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.RestriccionesValidacionesIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.operations.crm.f.oh.comord.common.exception.ComOrdException;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces.GestionComplementoOrdenSrvIF;

public class GestionComplementoOrdenSrv implements GestionComplementoOrdenSrvIF {

	private final Logger logger = Logger.getLogger(GestionComplementoOrdenSrv.class);
	
	private SCLPlanBasicoBOFactoryIT factoryBO1 = new SCLPlanBasicoBOFactory();
	private RestriccionesValidacionesBOFactoryIT factoryBO2 = new RestriccionesValidacionesBOFactory();
	private AbonadoBOFactoryIT factoryBO3 = new AbonadoBOFactory();
	
	
	private SCLPlanBasicoIT planBO = factoryBO1.getBusinessObject1();
	private RestriccionesValidacionesIT validaBO = factoryBO2.getBusinessObject1();
	private AbonadoIT abonadoBO = factoryBO3.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	public ServiciosDTO obtenerServiciosDefaultPlan(
			BusquedaServiciosDefaultDTO param) throws ComOrdException {
		ServiciosDTO servicios = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServiciosDefaultPlan():start");
			servicios = planBO.obtenerServiciosDefaultPlan(param);
			logger.debug("obtenerServiciosDefaultPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ComOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
		}
		return servicios;
	}

	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param) throws ComOrdException{
		RegistroServiciosListDTO servicios = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaServicioActDesc():start");
			servicios = validaBO.validaServicioActDesc(param);
			logger.debug("validaServicioActDesc():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ComOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
		}
		return servicios;		
	}
	
	public RetornoDTO insertaIntarcelAcciones(IntarcelDTO intarcel) throws ComOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertaIntarcelAcciones():start");
			retorno = abonadoBO.insertaIntarcelAcciones(intarcel);
			logger.debug("insertaIntarcelAcciones():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ComOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
		}
		return retorno;			
	}
	
	
}
