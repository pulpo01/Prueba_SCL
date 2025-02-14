package com.tmmas.scl.operations.crm.f.oh.isscusord.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.CiclosFacturacionBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CiclosFacturacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CiclosFacturacionIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionProvisionamientoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces.IssCusOrdSrvIF;

public class IssCusOrdSrv implements IssCusOrdSrvIF {

	private final Logger logger = Logger.getLogger(IssCusOrdSrv.class);
	
	private CargoBOFactoryIT factoryBO1 = new CargoBOFactory();
	private CiclosFacturacionBOFactoryIT factoryBO2 = new CiclosFacturacionBOFactory();
	private SCLPlanBasicoBOFactoryIT factoryBO3 = new SCLPlanBasicoBOFactory();
	private ProductoContratadoBOFactoryIT factoryBO4 = new ProductoContratadoBOFactory();
	private AbonadoBOFactoryIT factoryBO5 = new AbonadoBOFactory();
	private EspecificacionProvisionamientoBOFactoryIT factoryBO6 = new EspecificacionProvisionamientoBOFactory();
	
	private CargoIT cargoBO = factoryBO1.getBusinessObject1();
	private CiclosFacturacionIT ciclosBO = factoryBO2.getBusinessObject1();
	private SCLPlanBasicoIT planBO = factoryBO3.getBusinessObject1();	
	private ProductoContratadoIT productoBO = factoryBO4.getBusinessObject1();
	private AbonadoIT abonadoBO = factoryBO5.getBusinessObject1();
	private EspecificacionProvisionamientoIT provisionamientoBO = factoryBO6.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	public RetornoDTO actualizarCargoBolsaDinamica(BolsaDinamicaDTO bolsa)
			throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarCargoBolsaDinamica():start");
			retorno = cargoBO.actualizarCargoBolsaDinamica(bolsa);
			logger.debug("actualizarCargoBolsaDinamica():end");
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
	
	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaFinCiclo():start");
			retorno = ciclosBO.eliminaFinCiclo(finCiclo);
			logger.debug("eliminaFinCiclo():end");
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
	
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws IssCusOrdException{	
	RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroHistoricoPlan():start");
			retorno = planBO.registroHistoricoPlan(ciclo);
			logger.debug("registroHistoricoPlan():end");
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
	
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws IssCusOrdException{	
		RetornoDTO retorno = null;
			try {
				String log = global.getValor("service.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				logger.debug("validaDesacListaFrecuente():start");
				retorno = productoBO.validaDesacListaFrecuente(lista);
				logger.debug("validaDesacListaFrecuente():end");
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
	
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraTraspasoPlan():start");
			retorno = productoBO.registraTraspasoPlan(traspaso);
			logger.debug("registraTraspasoPlan():end");
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
	
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaIntarcelAcciones():start");
			retorno = abonadoBO.actualizaIntarcelAcciones(intarcel);
			logger.debug("actualizaIntarcelAcciones():end");
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
	
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraElimActIntarcel():start");
			retorno = abonadoBO.registraElimActIntarcel(intarcel);
			logger.debug("registraElimActIntarcel():end");
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
	
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaSituaAbo():start");
			retorno = abonadoBO.actualizaSituaAbo(abonado);
			logger.debug("actualizaSituaAbo():end");
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
	
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos) throws IssCusOrdException{	
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraReordenamientoPlan():start");
			retorno = productoBO.registraReordenamientoPlan(datos);
			logger.debug("registraReordenamientoPlan():end");
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
	
	public RetornoDTO registraProrrateo() throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraProrrateo():start");
			retorno = provisionamientoBO.registraProrrateo();
			logger.debug("registraProrrateo():end");
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
	
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente) throws IssCusOrdException{
		ParametroDTO parametro = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAtlantida():start");
			parametro = provisionamientoBO.obtieneAtlantida(cliente);
			logger.debug("obtieneAtlantida():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return parametro;			
		
	}
	
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaBajaAtlantida():start");
			retorno = provisionamientoBO.validaBajaAtlantida(param);
			logger.debug("validaBajaAtlantida():end");
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
	
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param) throws IssCusOrdException{
		GestorCorpDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaGestorCorp():start");
			retorno = provisionamientoBO.validaGestorCorp(param);
			logger.debug("validaGestorCorp():end");
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
	
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param) throws IssCusOrdException{
	
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("aprovisionamiento():start");
			retorno = provisionamientoBO.aprovisionamiento(param);
			logger.debug("aprovisionamiento():end");
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

	
}
