package com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegReordPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.PrestacionBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.PrestacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.PrestacionIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CartaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DetEstadoProcesoOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EventoNumFrecDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PagoAnticipadoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CtaPersonalEmpDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces.GestionOrdenServicioSrvIF;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegistroColaDTO; // RRG


public class GestionOrdenServicioSrv implements GestionOrdenServicioSrvIF {

	private final Logger logger = Logger.getLogger(GestionOrdenServicioSrv.class);
	
	private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	private ProductoContratadoBOFactoryIT factoryBO2 = new ProductoContratadoBOFactory();
	private AbonadoBOFactoryIT factoryBO3 = new AbonadoBOFactory();
	private SCLPlanBasicoBOFactory factoryBO5 = new SCLPlanBasicoBOFactory();
	private ClienteBOFactoryIT factoryBO6 = new ClienteBOFactory();
	private PrestacionBOFactoryIT factoryBO7 = new PrestacionBOFactory();
	
	private OrdenServicioIT ordenServicioBO = factoryBO1.getBusinessObject1();
	private ProductoContratadoIT productoBO = factoryBO2.getBusinessObject1();
	private AbonadoIT abonadoBO = factoryBO3.getBusinessObject1();
	private SCLPlanBasicoIT planBO = factoryBO5.getBusinessObject1();
	private ClienteIT clienteBO = factoryBO6.getBusinessObject1();
	private PrestacionIT prestacionBO = factoryBO7.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro)
			throws CloCusOrdException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraNivelOoss():start");
			respuesta = ordenServicioBO.registraNivelOoss(registro);
			logger.debug("registraNivelOoss():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return respuesta;
	}
	

	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CloCusOrdException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraCambPlanBatch():start");
			respuesta = ordenServicioBO.registraCambPlanBatch(param);
			logger.debug("registraCambPlanBatch():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return respuesta;			
		
	}
	
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaCuentaPersonal():start");
			retorno = abonadoBO.eliminaCuentaPersonal(cuenta);
			logger.debug("eliminaCuentaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reservaAmist():start");
			retorno = abonadoBO.reservaAmist(cuenta);
			logger.debug("reservaAmist():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaPermanencia():start");
			retorno = abonadoBO.validaPermanencia(param);
			logger.debug("validaPermanencia():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO registrarOOSSEnLinea (RegistrarOossEnLineaDTO param)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarOOSSEnLinea():start");
			retorno = ordenServicioBO.registrarOOSSEnLinea(param);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;	
	}	
	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaRenova():start");
			retorno = ordenServicioBO.actualizaRenova(param);
			logger.debug("actualizaRenova():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;	

	}

	public CambioPlanPendienteListDTO obtenerSolicPendPlan(ClienteDTO cliente) throws CloCusOrdException {
		CambioPlanPendienteListDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSolicPendPlan():start");
			retorno = ordenServicioBO.obtenerSolicPendPlan(cliente);
			logger.debug("obtenerSolicPendPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;			
	}
	
	/*
	public void notificarOOSS(EstadoProcesoOOSSDTO estadoProcesoOOSSDTO) throws CloCusOrdException {
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("notificarOOSS():start");
			EstadoProcesoOOSSDTO estadoProcesoOOSSDTO2 = ordenServicioBO.obtieneEstadoProcesoOOSS(estadoProcesoOOSSDTO);
			
			if (estadoProcesoOOSSDTO==null){
				throw new CloCusOrdException("El objeto informado es nulo");
			}
			
			if (estadoProcesoOOSSDTO.getCodOOSS()==null){
				throw new CloCusOrdException("El código de la OOSS se encuentra vacio");
			}
			
			if (estadoProcesoOOSSDTO.getEstado()==null){
				throw new CloCusOrdException("El estado de la OOSS se encuentra vacio");
			}
			
			if(estadoProcesoOOSSDTO.getFechaActualizacion()==null)
				throw new CloCusOrdException("La fecha de actualización de la OOSS se encuentra vacia");
			
			if (estadoProcesoOOSSDTO2 == null){
				ordenServicioBO.insEncProcesoOOSS(estadoProcesoOOSSDTO);
				if (estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO()==null)
					throw new CloCusOrdException("El detalle del estado de proceso se encuentra vacio");
				else{
					estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().setNumProceso(estadoProcesoOOSSDTO.getNumProceso());
					if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getNumOOSS()==0)
						throw new CloCusOrdException("El número de la OOSS no es valido[DETALLE]");
					else if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getEstado()==null)
						throw new CloCusOrdException("El estado de la OOSS se encuentra vacio[DETALLE]");
					else if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getFecEstado()==null)
						throw new CloCusOrdException("La fecha de la OOSS se encuentra vacia[DETALLE]");
					
				}
				ordenServicioBO.insDetProcesoOOSS(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO());
			}else{
				if (estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO()!=null){
					if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getNumOOSS()==0)
						throw new CloCusOrdException("El número de la OOSS no es valido[DETALLE]");
					else if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getEstado()==null)
						throw new CloCusOrdException("El estado de la OOSS se encuentra vacio[DETALLE]");
					else if(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO().getFecEstado()==null)
						throw new CloCusOrdException("La fecha de la OOSS se encuentra vacia[DETALLE]");
					ordenServicioBO.insDetProcesoOOSS(estadoProcesoOOSSDTO.getDetEstadoProcesoOSSDTO());
				}
				if (estadoProcesoOOSSDTO.getEstado()!=null)
					ordenServicioBO.actualizaEstadoProcesoOOSS(estadoProcesoOOSSDTO);
				else if (estadoProcesoOOSSDTO.getObjetoSerializado()!=null)
					ordenServicioBO.actualizaObjetoProcesoOOSS(estadoProcesoOOSSDTO);
			}
			
			
			logger.debug("notificarOOSS():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
	}
	*/
	
	public EstadoProcesoOOSSDTO actualizarEstado(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws CloCusOrdException{
		
		EstadoProcesoOOSSDTO estadoProcesoRet = null;
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("actualizarEstado():start");
				
		try{
			
			if(estadoProcesoOOSS==null){
				throw new CloCusOrdException("El objeto informado es nulo");
			}
						
			if(estadoProcesoOOSS.getNumProceso()==0){  // INSCRIBIR cabecera y detalle del proceso
				logger.debug("Inscribir Cabecera y Detalle del proceso");
				if(estadoProcesoOOSS.getCodOOSS()==null){
					throw new CloCusOrdException("El codigo de la OOSS se encuentra vacio");
				}
				if(estadoProcesoOOSS.getFechaActualizacion()==null){
					throw new CloCusOrdException("La fecha de actualizacion de la OOSS se encuentra vacio");
				}
				
				estadoProcesoOOSS.setEstado("ENCOLADO");
				logger.debug("estadoProcesoOOSS.getCodOOSS()[" + estadoProcesoOOSS.getCodOOSS()+ "]" );
				logger.debug("estadoProcesoOOSS.getFechaActualizacion()[" + estadoProcesoOOSS.getFechaActualizacion() + "]");
				
				logger.debug("insEncProcesoOOSS():inicio");
				estadoProcesoRet = ordenServicioBO.insEncProcesoOOSS(estadoProcesoOOSS);
				logger.debug("insEncProcesoOOSS():fin");
				
				if(estadoProcesoRet.getNumProceso()==0){
					throw new CloCusOrdException("El numero de proceso se encuentra vacio");
				}			
								
				if(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()==null){
					throw new CloCusOrdException("El detalle de este proceso se encuentra vacio");
				}
					
				for(int i=0; i<estadoProcesoOOSS.getDetEstadoProcesoOSSDTO().length;i++){
					if(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumOOSS()==0){
						throw new CloCusOrdException("El numero de la orden de servicio del DETALLE no es valido");
					}
					DetEstadoProcesoOSSDTO detEstadoProceso = new DetEstadoProcesoOSSDTO();
					detEstadoProceso.setNumProceso(estadoProcesoRet.getNumProceso());
					detEstadoProceso.setNumOOSS(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumOOSS());
					detEstadoProceso.setCodError(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getCodError());
					detEstadoProceso.setDesError(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getDesError());
					detEstadoProceso.setEstado(estadoProcesoOOSS.getEstado()); // Lo obtiene de la cabecera ya registrada
					detEstadoProceso.setFecEstado(estadoProcesoOOSS.getFechaActualizacion());  // Lo obtiene de la cabecera ya registrada
					detEstadoProceso.setNumEvento(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumEvento());
					detEstadoProceso.setNumAbonado(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumAbonado());
					detEstadoProceso.setCodCliente(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getCodCliente());
						
					logger.debug("detEstadoProceso.getNumProceso()[" + detEstadoProceso.getNumProceso() + "]");
					logger.debug("detEstadoProceso.getNumOOSS()[" + detEstadoProceso.getNumOOSS() + "]");
					logger.debug("detEstadoProceso.getCodError()[" + detEstadoProceso.getCodError() + "]");
					logger.debug("detEstadoProceso.getDesError()[" + detEstadoProceso.getDesError() + "]");
					logger.debug("detEstadoProceso.getEstado()[" + detEstadoProceso.getEstado() + "]");
					logger.debug("detEstadoProceso.getFecEstado()[" + detEstadoProceso.getFecEstado() + "]");
					logger.debug("detEstadoProceso.getNumEvento()[" + detEstadoProceso.getNumEvento() + "]");
					logger.debug("detEstadoProceso.getNumAbonado()[" + detEstadoProceso.getNumAbonado() + "]");
					logger.debug("detEstadoProceso.getCodCliente()[" + detEstadoProceso.getCodCliente() + "]");
						
					logger.debug("insDetProcesoOOSS():inicio");
					ordenServicioBO.insDetProcesoOOSS(detEstadoProceso);
					logger.debug("insDetProcesoOOSS():fin");
				} // del for
				
			}else{  // Debe ACTUALIZAR la Cabecera y el Detalle
				    logger.debug("Actualizar estado de Cabecera y Detalle");
					EstadoProcesoOOSSDTO estadoProceso = new EstadoProcesoOOSSDTO();
					estadoProceso.setNumProceso(estadoProcesoOOSS.getNumProceso());
					estadoProceso.setFechaActualizacion(estadoProcesoOOSS.getFechaActualizacion());
					estadoProceso.setEstado(estadoProcesoOOSS.getEstado());
					logger.debug("estadoProceso.getNumProceso()[" + estadoProceso.getNumProceso()+ "]");
					logger.debug("estadoProceso.getFechaActualizacion()[" + estadoProceso.getFechaActualizacion() + "]");
					logger.debug("estadoProceso.getEstado()[" + estadoProceso.getEstado() + "]");
					
					logger.debug("actualizaEstadoProcesoOOSS():inicio");
					ordenServicioBO.actualizaEstadoProcesoOOSS(estadoProceso);
					logger.debug("actualizaEstadoProcesoOOSS():fin");
					if(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()!=null){
						for(int i=0;i<estadoProcesoOOSS.getDetEstadoProcesoOSSDTO().length;i++){
							DetEstadoProcesoOSSDTO detalle = new DetEstadoProcesoOSSDTO();
							detalle.setEstado(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getEstado());
							detalle.setFecEstado(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getFecEstado());
							detalle.setNumProceso(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumProceso());
							detalle.setNumOOSS(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumOOSS());
							logger.debug("detalle.getEstado()[" + detalle.getEstado() + "]");
							logger.debug("detalle.getFecEstado()[" + detalle.getFecEstado() + "]");
							logger.debug("detalle.getNumProceso()[" + detalle.getNumProceso() + "]");
							logger.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
													
							if(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getCodError()!=0){
								detalle.setCodError(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getCodError());
								detalle.setNumEvento(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getNumEvento());
								detalle.setDesError(estadoProcesoOOSS.getDetEstadoProcesoOSSDTO()[i].getDesError());
								logger.debug("detalle.getCodError()[" + detalle.getCodError() + "]");
								logger.debug("detalle.getNumEvento()[" + detalle.getNumEvento() + "]");
								logger.debug("detalle.getDesError()[" + detalle.getDesError() + "]");
							}
													
							logger.debug("actualizaEstadoDetalleOOSS():inicio");
							ordenServicioBO.actualizaEstadoDetalleOOSS(detalle);
							logger.debug("actualizaEstadoDetalleOOSS():fin");
						} // del for
						
					} // del if
									
				} // del else
									
		} catch (GeneralException e){
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			
		}
		catch (Exception e){
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		
		logger.debug("actualizarEstado():end");
		return estadoProcesoRet;
		
	}


	public void validarActivarNumPer(CuentaPersonalDTO cuentaPersonalDTO) throws CloCusOrdException {
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validarActivarNumPer():start");
			abonadoBO.validarActivarNumPer(cuentaPersonalDTO);
			logger.debug("validarActivarNumPer():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		
	}


	public RetornoDTO validaDesactivaCuentaPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws CloCusOrdException {
		RetornoDTO retorno = new RetornoDTO();
		logger.debug("validaDesactivaCuentaPersonal():inicio");
		CuentaPersonalDTO cuentaPers = null;		
		int clieOriEsAtlantida = 0;
		int aboOriEsCorporativo = 0;
		int planDestinoEsAtlantida= 0;
		int aboOriEsPersonal = 0;
		long numCelular = 0;
		
		try {
			String ordenValidacion =cuentaPersonalDTO.getOrdenAccion();
			if (ordenValidacion==null) ordenValidacion =" ";
			logger.debug("ordenValidacion="+ordenValidacion);
			
			//if(cuentaPersonalDTO != null && cuentaPersonalDTO.getNumCelularPers()>0){
			if(cuentaPersonalDTO != null ){	
				AbonadoDTO abonado = new AbonadoDTO();
				abonado.setNumAbonado(cuentaPersonalDTO.getNumAbonado());
				clieOriEsAtlantida = abonadoBO.validaAtlantida(abonado);
				logger.debug("clieOriEsAtlantida = "+clieOriEsAtlantida);
				
				if(cuentaPersonalDTO.getNumCelular() != 0){
					cuentaPers   = abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
				}else{
					
					cuentaPersonalDTO.setNumCelular(cuentaPersonalDTO.getNumCelularCorp());
					cuentaPers   = abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
				}
				
				numCelular = cuentaPersonalDTO.getNumCelular();
				
				planDestinoEsAtlantida    = planBO.obtenerInfoAtl(cuentaPersonalDTO);
				
				if(cuentaPers.getNumCelular() != 0){
					cuentaPersonalDTO.setNumCelularPers(cuentaPers.getNumCelular());
				}else{				
					cuentaPersonalDTO.setNumCelularPers(cuentaPersonalDTO.getNumCelularPers());
				}
				
				if(clieOriEsAtlantida == 1)	aboOriEsCorporativo = abonadoBO.obtenerInfoPer(cuentaPersonalDTO);
				else						aboOriEsPersonal = abonadoBO.validaPersonal(cuentaPersonalDTO);
				
		
				logger.debug("abonado.getNumAbonado()				  :" + abonado.getNumAbonado());			
				logger.debug("cuentaPersonalDTO.getNumCelular()       :" + cuentaPersonalDTO.getNumCelular());
				logger.debug("cuentaPersonalDTO.getNumCelularCorp()   :" + cuentaPersonalDTO.getNumCelularCorp());
				logger.debug("cuentaPersonalDTO.getCodPlanTarifNuevo():" + cuentaPersonalDTO.getCodPlanTarifNuevo());
				logger.debug("cuentaPersonalDTO.getNumCelularPers()   :" + cuentaPersonalDTO.getNumCelularPers());
				
				if (ordenValidacion.equalsIgnoreCase("BAJA")){
					//BAJA
					if(( (aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1)
						 ||(aboOriEsCorporativo == 1 && planDestinoEsAtlantida == 0)
					   )
						&& clieOriEsAtlantida == 1)
					   {						
								logger.debug("BAJA");
								logger.debug("obtenerNumeroPersonal():start");
								CuentaPersonalDTO cuentaPersonal2DTO= abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
								logger.debug("obtenerNumeroPersonal():fin");
								logger.debug("cuentaPersonal2DTO.getNumCelular()[" + cuentaPersonal2DTO.getNumCelular() + "]");
								cuentaPersonalDTO.setNumCelularPers(cuentaPersonal2DTO.getNumCelular());
								logger.debug("cuentaPersonalDTO.getNumCelularPers()[" + cuentaPersonalDTO.getNumCelularPers() + "]");
								logger.debug("desactivarNumeroPersonal():start");
								abonadoBO.desactivarNumeroPersonal(cuentaPersonalDTO);
								logger.debug("desactivarNumeroPersonal():end");
					}
							
					//BAJAALTA
					if(aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0){
							logger.debug("BAJAALTA");
							logger.debug("bajaCuentaPersonal ():start");
							cuentaPersonalDTO.setCodEstado(4);
							cuentaPersonalDTO.setNumCelularPers(numCelular); //EV 21/07/08
							abonadoBO.actualizaNumeroPersonal(cuentaPersonalDTO);
							logger.debug("obtenerNumeroPersonal():start");
							CuentaPersonalDTO cuentaPersonal2DTO= abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
							logger.debug("cuentaPersonal2DTO.getNumCelular()[" + cuentaPersonal2DTO.getNumCelular() + "]");
							cuentaPersonalDTO.setNumCelularPers(cuentaPersonal2DTO.getNumCelular());
							logger.debug("obtenerNumeroPersonal():fin");
							cuentaPersonalDTO.setNumCelularPers(numCelular); //EV 21/07/08;
							abonadoBO.desactivarNumeroPersonal(cuentaPersonalDTO);
							logger.debug("bajaCuentaPersonal ():end");
	
					}
				}//fin if (ordenValidacion.equalsIgnoreCase("BAJA")	
				
				if (ordenValidacion.equalsIgnoreCase("ALTA")){
						//ALTA
						if( (aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0 && cuentaPersonalDTO.getNumCelularPers()>0)
							    || ( aboOriEsCorporativo==0 &&  aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && cuentaPersonalDTO.getNumCelularPers()>0) ) 
								{
									logger.debug("ALTA");
									logger.debug("altaCuentaPersonal():start");
									abonadoBO.registrarNumPer(cuentaPersonalDTO);
									logger.debug("altaCuentaPersonal():end");
						}
						
						  
						//MODIFICACION CUENTA PERSONAL			 
						if(aboOriEsPersonal == 1 && planDestinoEsAtlantida == 0 && clieOriEsAtlantida == 0){
							logger.debug("modificacionCuentaPersonal():start");
							cuentaPersonalDTO.setCodEstado(3);
							cuentaPersonalDTO.setCodSituacion(global.getValor("programa.posventa"));
							cuentaPersonalDTO.setNumCelularPers(numCelular);  //EV 12/09/09-- solucion para hibrido hibrido
							abonadoBO.actualizaNumeroPersonal(cuentaPersonalDTO);
							cuentaPersonalDTO = abonadoBO.obtieneNumeroCorporativo(cuentaPersonalDTO);
							
							//(+)EV 12/09/09-- solucion para hibrido hibrido
							//abonadoBO.modificarNumeroPersonal(cuentaPersonalDTO);
							abonadoBO.modificarNumeroPersonalCorp(cuentaPersonalDTO);
							//(-)
							
							logger.debug("modificacionCuentaPersonal():end");
						}
				}//FIN  if (ordenValidacion.equalsIgnoreCase("ALTA")
				
				
				if (ordenValidacion.equalsIgnoreCase("ALTAPROD")){
					//ALTA
					if( (aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0 && cuentaPersonalDTO.getNumCelularPers()>0)
						    || ( aboOriEsCorporativo==0 &&  aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && cuentaPersonalDTO.getNumCelularPers()>0) ) 
							{
								logger.debug("ALTAPROD");
								logger.debug("altaCuentaPersonal():start");
								abonadoBO.registrarNumPer(cuentaPersonalDTO);
								logger.debug("altaCuentaPersonal():end");
					}

				}

				
			}//FIN if(cuentaPersonalDTO != null )
			
			retorno.setCodigo("0");
			retorno.setDescripcion("");
			retorno.setResultado(true);
			
			logger.debug("validaDesactivaCuentaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;
	
			
		/*CuentaPersonalDTO cuentaPers = null;
		RetornoDTO retorno = new RetornoDTO();
		int valAtlantida = 0;
		int esCorporativo = 0;
		int esAlantida = 0;
		int esPersonal = 0;
		
		try {
			
			if(cuentaPersonalDTO != null && cuentaPersonalDTO.getNumCelularPers()>0){
				String log = global.getValor("service.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				logger.debug("validaDesactivaCuentaPersonal():start");
				
				ClienteDTO cliente = new ClienteDTO();
				cliente.setCodCliente(cuentaPersonalDTO.getCodCliente());			
				valAtlantida = abonadoBO.validaAtlantida(cliente);
				
				if(cuentaPersonalDTO.getNumCelular() != 0){
					cuentaPers   = abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
				}else{
					
					cuentaPersonalDTO.setNumCelular(cuentaPersonalDTO.getNumCelularCorp());
					cuentaPers   = abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
				}
				
				
				esPersonal   = abonadoBO.validaPersonal(cuentaPersonalDTO);
				esAlantida   = planBO.obtenerInfoAtl(cuentaPersonalDTO);
				
				if(cuentaPers.getNumCelular() != 0){
					cuentaPersonalDTO.setNumCelularPers(cuentaPers.getNumCelular());
				}else{				
					cuentaPersonalDTO.setNumCelularPers(cuentaPersonalDTO.getNumCelularPers());
				}
							
				
				logger.debug("cliente.getCodCliente()				  :" + cliente.getCodCliente());			
				logger.debug("cuentaPersonalDTO.getNumCelular()       :" + cuentaPersonalDTO.getNumCelular());
				logger.debug("cuentaPersonalDTO.getNumCelularCorp()   :" + cuentaPersonalDTO.getNumCelularCorp());
				logger.debug("cuentaPersonalDTO.getCodPlanTarifNuevo():" + cuentaPersonalDTO.getCodPlanTarifNuevo());
				logger.debug("cuentaPersonalDTO.getNumCelularPers()   :" + cuentaPersonalDTO.getNumCelularPers());
				
				
				// BAJA CUENTA PERSONAL			 
				if(valAtlantida != 0){		
					esCorporativo = abonadoBO.obtenerInfoPer(cuentaPersonalDTO);
					esAlantida    = planBO.obtenerInfoAtl(cuentaPersonalDTO);
					
						if(esCorporativo == 1 && esAlantida == 0){		
							logger.debug("bajaCuentaPersonal():start");
							abonadoBO.desactivarNumeroPersonal(cuentaPersonalDTO);
							logger.debug("bajaCuentaPersonal():end");
						}				
					
				}else{		 
						esPersonal = abonadoBO.validaPersonal(cuentaPersonalDTO);
						esAlantida = planBO.obtenerInfoAtl(cuentaPersonalDTO);			
						
						//ALTA CUENTA PERSONAL
						if ((esPersonal == 0 && esAlantida == 1 && valAtlantida == 0 ) || 
							(esPersonal == 1 && esAlantida == 1 && valAtlantida == 0 ) || 
							(esPersonal == 0 && esAlantida == 1 && valAtlantida == 1 ) ){
							logger.debug("altaCuentaPersonal():start");
							abonadoBO.registrarNumPer(cuentaPersonalDTO);
							logger.debug("altaCuentaPersonal():end");
						}
				}
				
				//BAJA CUENTA PERSONAL
				cuentaPersonalDTO.setNumCelularPers(cuentaPersonalDTO.getNumCelular());
				if(esPersonal == 1 && esAlantida == 1 && valAtlantida == 0){
					logger.debug("bajaCuentaPersonal ():start");
					cuentaPersonalDTO.setCodEstado(4);
					abonadoBO.actualizaNumeroPersonal(cuentaPersonalDTO);
					abonadoBO.desactivarNumeroPersonal(cuentaPersonalDTO);
					logger.debug("bajaCuentaPersonal ():end");
				}				
				//MODIFICACION CUENTA PERSONAL			 
				if(esPersonal == 1 && esAlantida == 0 && valAtlantida == 0){
					logger.debug("modificacionCuentaPersonal():start");
					cuentaPersonalDTO.setCodEstado(3);
					cuentaPersonalDTO.setCodSituacion(global.getValor("programa.posventa"));
					abonadoBO.actualizaNumeroPersonal(cuentaPersonalDTO);
					cuentaPersonalDTO = abonadoBO.obtieneNumeroCorporativo(cuentaPersonalDTO);
					abonadoBO.modificarNumeroPersonal(cuentaPersonalDTO);
					logger.debug("modificacionCuentaPersonal():end");
				}
			}
			retorno.setCodigo("0");
			retorno.setDescripcion("");
			retorno.setResultado(true);
			
			logger.debug("validaDesactivaCuentaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;*/
	}

	public RetornoDTO insertarCarta(CartaDTO carta)throws CloCusOrdException{
		RetornoDTO retorno = new RetornoDTO();
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			if (carta.getTextoCarta()!=null){
				logger.debug("insertarCarta():start");
				retorno = ordenServicioBO.insertarCarta(carta);
				logger.debug("insertarCarta():end");
			}
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}

	public RetornoDTO insertarFrecuentesProgramados(DesactServFreDTO desactServFre)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesProgramados():start");
			retorno = ordenServicioBO.insertarFrecuentesProgramados(desactServFre);
			logger.debug("insertarFrecuentesProgramados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}

	public RetornoDTO insertarFrecuentesOnline(DesactServFreDTO desactServFre)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesOnline():start");
			retorno = ordenServicioBO.insertarFrecuentesOnline(desactServFre);
			logger.debug("insertarFrecuentesOnline():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}

	public RetornoDTO insertarFrecuentesFFOnline(DesactServFreDTO desactServFre)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesFFOnline():start");
			retorno = ordenServicioBO.insertarFrecuentesFFOnline(desactServFre);
			logger.debug("insertarFrecuentesFFOnline():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO registrarCambioCuotas(RegReordPlanDTO regReordPlanDTO) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarCambioCuotas():start");
			retorno = clienteBO.registrarCambioCuotas(regReordPlanDTO);
			logger.debug("registrarCambioCuotas():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO eliminarFrecuentesOnLine(DesactServFreDTO desactServFre)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarFrecuentesOnLine():start");
			retorno = ordenServicioBO.eliminarFrecuentesOnLine(desactServFre);
			logger.debug("eliminarFrecuentesOnLine():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO insertarFrecuentesFFProgramados(DesactServFreDTO desactServFre)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesFFProgramados():start");
			retorno = ordenServicioBO.insertarFrecuentesFFProgramados(desactServFre);
			logger.debug("insertarFrecuentesFFProgramados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO actualizarIntarcelAbonado(AbonadoDTO abonado)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarIntarcelAbonado():start");
			retorno = abonadoBO.actualizarIntarcelAbonado(abonado);
			logger.debug("actualizarIntarcelAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}


	public RetornoDTO registrarFinciclo(AbonadoDTO abonado) throws CloCusOrdException {
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarFinciclo():start");
			retorno = abonadoBO.registrarFinciclo(abonado);
			logger.debug("registrarFinciclo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO modificarNumeroPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("modificarNumeroPersonal():start");
			retorno = abonadoBO.modificarNumeroPersonal(cuenta);
			logger.debug("modificarNumeroPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public CuentaPersonalDTO obtieneNumeroCorporativo(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		CuentaPersonalDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneNumeroCorporativo():start");
			retorno = abonadoBO.obtieneNumeroCorporativo(cuenta);
			logger.debug("obtieneNumeroCorporativo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}	
	
	public RetornoDTO validaBajaAtlEmpresa(ClienteDTO cliente) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaBajaAtlEmpresa():start");
			retorno = abonadoBO.validaBajaAtlEmpresa(cliente);
			logger.debug("validaBajaAtlEmpresa():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}		
	
	public CtaPersonalEmpDTO obtenerDatosCtaPersonalCliEmp(CtaPersonalEmpDTO cta) throws CloCusOrdException{
		CtaPersonalEmpDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCtaPersonalCliEmp():start");
			retorno = abonadoBO.obtenerDatosCtaPersonalCliEmp(cta);
			logger.debug("obtenerDatosCtaPersonalCliEmp():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}		
// INC-77866; COL; 12-02-2009; AVC
	/**
	 * 
	 * 
	 * @param param
	 * @return retorno, tipo de dato RetornoDTO
	 * @throws CloCusOrdException
	 */
	public RetornoDTO insertaTablaCola(RegistroColaDTO param)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("insertaTablaCola()INI_SRV");
			retorno = ordenServicioBO.insertaTablaCola(param);
			logger.debug("insertaTablaCola()FIN_SRV");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;	
	}
	
	public EventoNumFrecDTO obtenerMontoEvento(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException{
		EventoNumFrecDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerMontoEvento():start");
			retorno = ordenServicioBO.obtenerMontoEvento(eventoNumFrecDTO);
			logger.debug("obtenerMontoEvento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}	
	
	public RetornoDTO insertarEventoNumFrec(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarEventoNumFrec():start");
			retorno = ordenServicioBO.insertarEventoNumFrec(eventoNumFrecDTO);
			logger.debug("insertarEventoNumFrec():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO regCausaCambioPlan(CausaCambioPlanDTO causaCambioPlan) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("regCausaCambioPlan():start");
			retorno = prestacionBO.regCausaCambioPlan(causaCambioPlan);
			logger.debug("regCausaCambioPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO regPagoAnticipado(PagoAnticipadoDTO pagoAnticipado) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("regPagoAnticipado():start");
			retorno = prestacionBO.regPagoAnticipado(pagoAnticipado);
			logger.debug("regPagoAnticipado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CloCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
}
