package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.IntegracionBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.IntegracionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.IntegracionIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraCPUPDTDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.IntegracionSrvIF;


public class IntegracionSrv implements IntegracionSrvIF {

	private final Logger logger = Logger.getLogger(IntegracionSrv.class);

	private IntegracionBOFactoryIT factoryBO1 = new IntegracionBOFactory();
	private IntegracionIT integracionBO = factoryBO1.getBusinessObject1();
	private ClienteBOFactoryIT clienteFactory = new ClienteBOFactory();
	private ClienteIT clienteBO = clienteFactory.getBusinessObject1();
	

	private Global global = Global.getInstance();

	//051208 pv quitarPlanes,contratarPlanesPorDefecto,integrarCPUPDT,provisionarAbonado
	public RetornoDTO quitarPlanes(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("quitarPlanes():start");
			respuesta = integracionBO.quitarPlanes(integraCPUPDTDTO);
			logger.debug("quitarPlanes():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return respuesta;			
	}
	
	public RetornoDTO contratarPlanesPorDefecto(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("contratarPlanesPorDefecto():start");
			respuesta = integracionBO.contratarPlanesPorDefecto(integraCPUPDTDTO);
			logger.debug("contratarPlanesPorDefecto():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return respuesta;			
	}

	public RetornoDTO integrarCPUPDT(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("integrarCPUPDT():start");
			respuesta = integracionBO.integrarCPUPDT(integraCPUPDTDTO);
			logger.debug("integrarCPUPDT():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return respuesta;			
	}
	
	public RetornoDTO provisionarAbonado(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("provisionarAbonado():start");
			respuesta = integracionBO.provisionarAbonado(integraCPUPDTDTO);
			logger.debug("provisionarAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return respuesta;			
	}
	

	public RetornoDTO validaPrimerAbonadoActivo(AbonadoDTO abonadoDTO) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaPrimerAbonadoActivo():start");
			respuesta = clienteBO.validaPrimerAbonadoActivo(abonadoDTO);
			logger.debug("validaPrimerAbonadoActivo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return respuesta;			
	}


}
