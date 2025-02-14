package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActParamComerInmDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionProvisionamientoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.SaldoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.GestionOrdenServiciosSrvIF;


public class GestionOrdenServiciosSrv implements GestionOrdenServiciosSrvIF {

	private final Logger logger = Logger.getLogger(GestionOrdenServiciosSrv.class);

	private ProductoContratadoBOFactoryIT factoryBO1 = new ProductoContratadoBOFactory();
	private EspecificacionProvisionamientoBOFactoryIT factoryBO2 = new EspecificacionProvisionamientoBOFactory();
	private AbonadoBOFactoryIT factoryBO3 = new AbonadoBOFactory();
	private OrdenServicioBOFactoryIT factoryBO4 = new OrdenServicioBOFactory();
	
	private ProductoContratadoIT productoBO = factoryBO1.getBusinessObject1();
	private EspecificacionProvisionamientoIT provisionamientoBO = factoryBO2.getBusinessObject1();
	private AbonadoIT abonadoBO = factoryBO3.getBusinessObject1();
	private OrdenServicioIT ordenServicioBO = factoryBO4.getBusinessObject1();
	

	private Global global = Global.getInstance();

	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos)
	throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroCambPlanComer():start");
			retorno = productoBO.registroCambPlanComer(datos);
			logger.debug("registroCambPlanComer():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}

	public RetornoDTO actualizarParamComerInm(ActParamComerInmDTO datos)
	throws IssCusOrdException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarParamComerInm():start");
			retorno = productoBO.actualizarParamComerInm(datos);
			logger.debug("actualizarParamComerInm():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}

	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroCambPlanServ():start");
			retorno = productoBO.registroCambPlanServ(plan);
			logger.debug("registroCambPlanServ():end");
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

	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarLimiteConsumo():start");
			retorno = provisionamientoBO.actualizarLimiteConsumo(param);
			logger.debug("actualizarLimiteConsumo():end");
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

	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraDesActSerFre():start");
			respuesta = productoBO.registraDesActSerFre(param);
			logger.debug("registraDesActSerFre():end");
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

	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaPrepago():start");
			respuesta = provisionamientoBO.consultaPrepago(consulta);
			logger.debug("consultaPrepago():end");
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

	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws IssCusOrdException{
		SaldoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaSaldo():start");
			respuesta = provisionamientoBO.consultaSaldo(consulta);
			logger.debug("consultaSaldo():end");
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

	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws IssCusOrdException{
		PlanTarifarioDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaPlanActual():start");
			respuesta = provisionamientoBO.consultaPlanActual(consulta);
			logger.debug("consultaPlanActual():end");
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

	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws IssCusOrdException{
		ListaActivaListDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaListaActivas():start");
			respuesta = provisionamientoBO.consultaListaActivas(consulta);
			logger.debug("consultaListaActivas():end");
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

	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPlanAtlantida():start");
			respuesta = provisionamientoBO.obtenerPlanAtlantida(abonado);
			logger.debug("obtenerPlanAtlantida():end");
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

	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertaMovAtl():start");
			respuesta = provisionamientoBO.insertaMovAtl(mov);
			logger.debug("insertaMovAtl():end");
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

	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws IssCusOrdException{
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServContrato():start");
			respuesta = provisionamientoBO.obtenerServContrato(abonado);
			logger.debug("obtenerServContrato():end");
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

	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarServContrato():start");
			respuesta = provisionamientoBO.registrarServContrato(abonado);
			logger.debug("registrarServContrato():end");
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

	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws IssCusOrdException{
		BodegaListDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaBodegas():start");
			respuesta = provisionamientoBO.obtenerListaBodegas(param);
			logger.debug("obtenerListaBodegas():end");
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

	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarSituPerfil():start");
			respuesta = abonadoBO.actualizarSituPerfil(abonado);
			logger.debug("actualizarSituPerfil():end");
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


	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws IssCusOrdException{
		IntarcelDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFecDesdeCtaSeg():start");
			respuesta = abonadoBO.obtenerFecDesdeCtaSeg(intarcel);
			logger.debug("obtenerFecDesdeCtaSeg():end");
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

	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws IssCusOrdException{
		ObtencionRolUsuarioDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarSituPerfil():start");
			respuesta = abonadoBO.obtenerRolUsuario(obtRol);
			logger.debug("actualizarSituPerfil():end");
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

	public CausaExcepcionListDTO obtenerCausaExcepcion() throws IssCusOrdException{
		CausaExcepcionListDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarSituPerfil():start");
			respuesta = ordenServicioBO.obtenerCausaExcepcion();
			logger.debug("actualizarSituPerfil():end");
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
	
	//Inicio INC 147444
	public RetornoDTO actualizaGaIntarcelAccionesTo(IntarcelDTO intarcel) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaGaIntarcelAccionesTo():start");
			retorno=abonadoBO.actualizaGaIntarcelAccionesTo(intarcel);
			logger.debug("actualizaGaIntarcelAccionesTo():end");
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
	//Fin INC 147444
}
