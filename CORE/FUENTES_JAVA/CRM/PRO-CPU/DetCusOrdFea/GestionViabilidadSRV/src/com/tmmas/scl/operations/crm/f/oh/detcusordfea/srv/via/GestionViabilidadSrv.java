package com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.CiclosFacturacionBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CiclosFacturacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CiclosFacturacionIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces.GestionViabilidadSrvIF;

public class GestionViabilidadSrv implements GestionViabilidadSrvIF {

	private final Logger logger = Logger.getLogger(GestionViabilidadSrv.class);
	
	private ClienteBOFactoryIT factoryBO1 = new ClienteBOFactory();
	private CiclosFacturacionBOFactoryIT factoryBO2 = new CiclosFacturacionBOFactory();
	private OrdenServicioBOFactoryIT factoryBO3 = new OrdenServicioBOFactory();
	private SCLPlanBasicoBOFactoryIT factoryBO4 = new SCLPlanBasicoBOFactory();
	private DatosGeneralesBOFactoryIT datosGeneFactory=new DatosGeneralesBOFactory();
	
	private ClienteIT clienteBO = factoryBO1.getBusinessObject1();
	private CiclosFacturacionIT ciclosBO = factoryBO2.getBusinessObject1();
	private OrdenServicioIT ordenServicioBO = factoryBO3.getBusinessObject1();
	private SCLPlanBasicoIT planBO = factoryBO4.getBusinessObject1();
	private DatosGeneralesBOIT datosGeneralesBO=datosGeneFactory.getBusinessObject1();
	
	
	
	private Global global = Global.getInstance();
	
	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente)
			throws DetCusOrdFeaException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaCantAboCliente():start");
			retorno = clienteBO.actualizaCantAboCliente(cliente);
			logger.debug("actualizaCantAboCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;
	}

	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws DetCusOrdFeaException{
		CicloDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFechaCiclo():start");
			respuesta = ciclosBO.obtenerFechaCiclo(ciclo);
			logger.debug("obtenerFechaCiclo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return respuesta;		
	}
	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaRestriccionComerOoss():start");
			retorno = ordenServicioBO.validaRestriccionComerOoss(restricciones);
			logger.debug("validaRestriccionComerOoss():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaFreedom():start");
			retorno = planBO.validaFreedom(cliente);
			logger.debug("validaFreedom():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;			
	}
	
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws DetCusOrdFeaException{
		ValidaOOSSDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaOossPendPlan():start");
			retorno = ordenServicioBO.validaOossPendPlan(ordenServicio);
			logger.debug("validaOossPendPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validarPeriodoFact():start");
			retorno = ciclosBO.validarPeriodoFact(abonado);
			logger.debug("validarPeriodoFact():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;		
	}
	
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registro)throws DetCusOrdFeaException{
		RegistroFacturacionDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("aplicaImpuestoImporte():start");
			retorno = ciclosBO.aplicaImpuestoImporte(registro);
			logger.debug("aplicaImpuestoImporte():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;	
	}

	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registro)throws DetCusOrdFeaException{
		RegistroFacturacionDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getDiasProrrateo():start");
			retorno = ciclosBO.getDiasProrrateo(registro);
			logger.debug("getDiasProrrateo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;	
		
	}
	
	
	public RetornoDTO ejecutaPLRestricciones(RestriccionesDTO restriccionesDTO)throws DetCusOrdFeaException{
		RetornoDTO retorno=null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("ejecutaPLRestricciones():start");
			logger.debug("CodPrograma:"+restriccionesDTO.getCodPrograma()); 		
			logger.debug("VerPrograma:"+restriccionesDTO.getVerPrograma());
			logger.debug("Proceso:"+restriccionesDTO.getProceso());
			logger.debug("CodActuacion:"+restriccionesDTO.getCodActuacion());
			logger.debug("NumAbonado:"+restriccionesDTO.getNumAbonado());
			logger.debug("CodCliente:"+restriccionesDTO.getCodCliente());
			logger.debug("CodModGener:"+restriccionesDTO.getCodModGener());
			logger.debug("NumVenta:"+restriccionesDTO.getNumVenta());
			logger.debug("CodOOSS:"+restriccionesDTO.getCodOOSS());
			logger.debug("CodVendedor:"+restriccionesDTO.getCodVendedor());
			logger.debug("DescSS:"+restriccionesDTO.getDescSS());
			logger.debug("CodPlanTarifDes:"+restriccionesDTO.getCodPlanTarifDes());
			logger.debug("CodUso:"+restriccionesDTO.getCodUso());
			logger.debug("CodCuentaOrigen:"+restriccionesDTO.getCodCuentaOrigen());
			logger.debug("CodCuentaDestino:"+restriccionesDTO.getCodCuentaDestino());
			logger.debug("CodClienteDestino:"+restriccionesDTO.getCodClienteDestino());
			logger.debug("CodTipPlanTarif:"+restriccionesDTO.getCodTipPlanTarif());
			logger.debug("CodTipPlanTarifDes:"+restriccionesDTO.getCodTipPlanTarifDes());
			logger.debug("CodCiclo:"+restriccionesDTO.getCodCiclo());
			logger.debug("FechaSistema:"+restriccionesDTO.getFechaSistema());
			logger.debug("NumSerie:"+restriccionesDTO.getNumSerie());
			logger.debug("CodModulo:"+restriccionesDTO.getCodModulo());
			logger.debug("IdSecuencia:"+restriccionesDTO.getIdSecuencia());
			logger.debug("CodCentral:"+restriccionesDTO.getCodCentral());
			logger.debug("NomUsuario:"+restriccionesDTO.getNomUsuario());
			logger.debug("CodTipComis:"+restriccionesDTO.getCodTipComis());
			
			logger.debug(":::Armando Parametros de Restricciones:: ");
			String parametros = 	"|" + restriccionesDTO.getCodPrograma()==null?"":restriccionesDTO.getCodPrograma()+ 			// codigo del programa 1
									"|" + restriccionesDTO.getVerPrograma()==null?"":restriccionesDTO.getVerPrograma()+	      	// version del programa 2
									"|" + restriccionesDTO.getProceso()==null?"":restriccionesDTO.getProceso()+			// proceso 3
									"|" + restriccionesDTO.getCodActuacion()==null?"":restriccionesDTO.getCodActuacion()+			// actuacion 4 
									"|" + restriccionesDTO.getNumAbonado()==null?"":restriccionesDTO.getNumAbonado()+			// numero abonado 5
									"|" + restriccionesDTO.getCodCliente()==null?"":restriccionesDTO.getCodCliente() +			// codigo del cliente 6
									"|" + restriccionesDTO.getCodModGener()==null?"":restriccionesDTO.getCodModGener()+    		// cod mod gener 7
									"|" + restriccionesDTO.getNumVenta()==null?"":restriccionesDTO.getNumVenta()+				// codigo de venta 8
									"|" + restriccionesDTO.getCodOOSS()==null?"":restriccionesDTO.getCodOOSS()+	 			// codigo orden de servicio 9		
									"|" + restriccionesDTO.getCodVendedor()==null?"":restriccionesDTO.getCodVendedor()+			// codigo de vendedor 10
									"|" + restriccionesDTO.getDescSS()==null?"":restriccionesDTO.getDescSS()+					// descripcion ss 11
									"|" + restriccionesDTO.getCodPlanTarifDes()==null?"":restriccionesDTO.getCodPlanTarifDes()+			// codigo plan tarifario D 12
									"|" + restriccionesDTO.getCodUso()==null?"":restriccionesDTO.getCodUso()+ 				// codigo de uso 13
									"|" + restriccionesDTO.getCodCuentaOrigen()==null?"":restriccionesDTO.getCodCuentaOrigen()+ 		// codigo cuenta orig 14
									"|" + restriccionesDTO.getCodCuentaDestino()==null?"":restriccionesDTO.getCodCuentaDestino()+		// cod cuenta des 15
									"|" + restriccionesDTO.getCodClienteDestino()==null?"":restriccionesDTO.getCodClienteDestino()+		// cod cliente des 16
									"|" + restriccionesDTO.getCodTipPlanTarif()==null?"":restriccionesDTO.getCodTipPlanTarif()+		// cod tip plan tarif 17
									"|" + restriccionesDTO.getCodTipPlanTarifDes()==null?"":restriccionesDTO.getCodTipPlanTarifDes()+ 	// cod tip plan tarif D 18
									"|" + restriccionesDTO.getCodCiclo()==null?"":restriccionesDTO.getCodCiclo()+				// codigo de ciclo 19
									"|" + restriccionesDTO.getFechaSistema()==null?"":restriccionesDTO.getFechaSistema()+			// codigo fecha de sistema 20
									"|" + restriccionesDTO.getNumSerie()==null?"":restriccionesDTO.getNumSerie()+				// nro Serie 21
									"|" + restriccionesDTO.getCodModulo()==null?"":restriccionesDTO.getCodModulo()+				// codigo de modulo22
									"|" + restriccionesDTO.getIdSecuencia()==null?"":restriccionesDTO.getIdSecuencia()+			// numero ID 23
									"|"	+ restriccionesDTO.getCodCentral()==null?"":restriccionesDTO.getCodCentral()+				// codigo de central 24
									"|"	+ restriccionesDTO.getNomUsuario()==null?"": restriccionesDTO.getNomUsuario()+    		// nombre de usuario 25
									"|"	+ restriccionesDTO.getCodTipComis()==null?"":restriccionesDTO.getCodTipComis()+			// codigo tipo comisionista
									"|";
			
			logger.debug("Parametros:::::::"+parametros);
			restriccionesDTO.setParametros(parametros);
			retorno = datosGeneralesBO.ejecutaRestriccion(restriccionesDTO);
			logger.debug("ejecutaPLRestricciones():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;	
	}
	
	public String getCodigoOperadora()throws DetCusOrdFeaException{
		String retValue="";
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCodigoOperadora():start");
			retValue= datosGeneralesBO.getCodigoOperadora();
			logger.debug("getCodigoOperadora():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retValue;	
		
	}
	public DatosVentaOutDTO getCodOficinaXVendedor(DatosVentaOutDTO entrada) throws DetCusOrdFeaException{
		DatosVentaOutDTO retValue;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCodOficinaXVendedor():start");
			retValue= datosGeneralesBO.getCodOficinaXVendedor(entrada);
			logger.debug("getCodOficinaXVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new DetCusOrdFeaException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retValue;	
	}
}
