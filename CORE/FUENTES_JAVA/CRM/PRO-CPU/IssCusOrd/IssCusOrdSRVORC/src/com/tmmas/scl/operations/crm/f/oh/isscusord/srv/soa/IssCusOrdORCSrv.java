package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa;

import java.rmi.RemoteException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.ejb.CreateException;

import org.apache.log4j.Logger;

import com.sun.rsasign.u;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productABE.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionProvisionamientoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.exception.ServiceSpecEntitiesException;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.comord.bean.ejb.session.ComOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.comord.bean.ejb.session.ComOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.comord.common.exception.ComOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OSAbonadoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.UtilAgrupCargosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces.IssCusOrdORCSrvIT;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;


public class IssCusOrdORCSrv implements IssCusOrdORCSrvIT {

	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(IssCusOrdORCSrv.class);
	private EspecificacionProvisionamientoBOFactoryIT factoryBO2 = new EspecificacionProvisionamientoBOFactory();
	
	private ProductoContratadoBOFactoryIT factoryBO1 = new ProductoContratadoBOFactory();
	private SCLPlanBasicoBOFactoryIT factoryBO4 = new SCLPlanBasicoBOFactory();
	private SCLPlanBasicoIT planBO = factoryBO4.getBusinessObject1();
	private EspecificacionProvisionamientoIT provisionamientoBO = factoryBO2.getBusinessObject1();
	private ProductoContratadoIT productoBO = factoryBO1.getBusinessObject1();
	
	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();
	
	

	public IntegraProdCPUListDTO registroReordenamientoAbonados(RegistroPlanDTO registro) throws IssCusOrdException{
		logger.debug("registroReordenamientoAbonados():inicio");
		IntegraProdCPUDTO [] retorno = null;
		IntegraProdCPUListDTO integraProdCPU = new IntegraProdCPUListDTO();
		ParamRegistroPlanDTO param = registro.getParamRegistroPlan();
		//ClienteDTO cliente= registro.getCliente();

		ClienteDTO cliente =new ClienteDTO();
		cliente.setCodCliente(registro.getCliente().getCodCliente());
	
		AbonadoDTO[] abonados = null;
		String [] numAbonados = param.getNumAbonados();
		
		IssCusOrdFacade issCusOrdFacade =  getIssCusOrdFacade();
		
		
		if(numAbonados!=null){
			try {
				cliente = getManConFacade().obtenerDatosCliente(cliente);
				abonados = obtenerAbonados(numAbonados);
				if(numAbonados.length==1){ //SE EJECUTA SOLO SI EL CLIENTE TIENE UN SOLO ABONADO
					//eliminacuentapersonal
					CuentaPersonalDTO cuentaPersonal = new CuentaPersonalDTO();
					cuentaPersonal.setNumCelular(abonados[0].getNumCelular());
					cuentaPersonal.setNumCelularCorp(0);
/*DESCOMENTAR					RetornoDTO retornoEliminaCuenta = getCloCusOrdFacade().eliminaCuentaPersonal(cuentaPersonal);
					if(retornoEliminaCuenta!=null&&!"0".equalsIgnoreCase(retornoEliminaCuenta.getCodigo())){
						throw new IssCusOrdException("Ha ocurrido un error general al utilizar eliminaCuentaPersonal");
					}
	*/			}
				
				retorno = new IntegraProdCPUDTO[0];
				
				
				//registraNivelOoss
				RegistroNivelOOSSDTO registroNivel = new RegistroNivelOOSSDTO();
				registroNivel.setTipSujeto("C");
				registroNivel.setNumAbonado(0);
				registroNivel.setCodCliente(cliente.getCodCliente());
				registroNivel.setCodTipMod(param.getCodTipModi());
				registroNivel.setNomUsuaOra(param.getNomUsuaOra());
				/**/getCloCusOrdFacade().registraNivelOoss(registroNivel);



				for(int i = 0; i<numAbonados.length;i++){

					SecuenciaDTO secuenciaNumOs = new SecuenciaDTO(); 
					secuenciaNumOs.setNomSecuencia("CI_SEQ_NUMOS");
					secuenciaNumOs = getSupOrdHanFacade().obtenerSecuencia(secuenciaNumOs);
					long numOs = secuenciaNumOs.getNumSecuencia();
					logger.debug("numOs="+numOs);
					
					//insertaMovAtl
					MovAtlantidaDTO movAtlantida = new MovAtlantidaDTO();
					movAtlantida.setNumAbonado(abonados[i].getNumAbonado());
					movAtlantida.setCodCliente(cliente.getCodCliente());
					movAtlantida.setCodPlanTarifNuevo(param.getCodPlanTarifDestino());
					movAtlantida.setParam("T");
					logger.debug("insertaMovAtl():inicio");
					RetornoDTO retornoInsertaMovAtl = issCusOrdFacade.insertaMovAtl(movAtlantida);
					logger.debug("insertaMovAtl():fin");
					if(!"0".equalsIgnoreCase(retornoInsertaMovAtl.getCodigo())){
						throw new IssCusOrdException("Ha ocurrido un error general al utilizar insertaMovAtl");
					}
				
				//inicio CUENTA PERSONAL
					CuentaPersonalDTO cuentaPer = new CuentaPersonalDTO();
					cuentaPer.setNumCelularPers(param.getCelularPers());
					cuentaPer.setNumCelularCorp(abonados[i].getNumCelular());
					cuentaPer.setCodCliente(cliente.getCodCliente());
					cuentaPer.setCodPlanTarifNuevo(param.getCodPlanTarifDestino());
					logger.debug("validaDesactivaCuentaPersonal():inicio");
					RetornoDTO retornoCuentaPersonal = getCloCusOrdFacade().validaDesactivaCuentaPersonal(cuentaPer);
					
					if(!"0".equalsIgnoreCase(retornoCuentaPersonal.getCodigo())){
						logger.debug("Codigo   :" + retornoCuentaPersonal.getCodigo());
						logger.debug("MsgError :" + retornoCuentaPersonal.getDescripcion());
						logger.debug("Resultado:" + retornoCuentaPersonal.isResultado());
						throw new IssCusOrdException("Ocurrió un error general al ejecutar el metodo validaDesactivaCuentaPersonal()");
					}
					
					logger.debug("validaDesactivaCuentaPersonal():inicio");
				//fin CUENTA PERSONAL	
					
				//inicio REGISTRO MOVIMIENTOS DE ALTA O BAJA HIBRIDO
					
					//obtenerSecuencia 
					SecuenciaDTO secuenciaApro = new SecuenciaDTO(); 
					secuenciaApro.setNomSecuencia("ICC_SEQ_NUMMOV");
					secuenciaApro = getSupOrdHanFacade().obtenerSecuencia(secuenciaApro);

					//ejecutaAprovisionamiento
					AprovisionamientoDTO aprovisionamientoPH = new AprovisionamientoDTO();
					aprovisionamientoPH.setNumAbonado(abonados[i].getNumAbonado());
					aprovisionamientoPH.setCodActAbo(param.getCodActAboAux());
					aprovisionamientoPH.setTipoTecnologia(abonados[i].getCodTecnologia());
					aprovisionamientoPH.setUsuarioOracle(param.getNomUsuaOra());
					aprovisionamientoPH.setCodTipoTerminal(cliente.getCodTipoTerminal());
					aprovisionamientoPH.setCodCentral(abonados[i].getCodCentral());
					aprovisionamientoPH.setNumSerie(abonados[i].getNumSerie());
					aprovisionamientoPH.setImei(abonados[i].getNumImei());
					aprovisionamientoPH.setValorOOSS(0);
					aprovisionamientoPH.setCodPlanTarif(param.getCodPlanTarifDestino());
					aprovisionamientoPH.setNumOOSS(0);
					aprovisionamientoPH.setCodOOSS(param.getCodOOSS());
					aprovisionamientoPH.setSeqNumMov(secuenciaApro.getNumSecuencia());
					aprovisionamientoPH.setCodTipPlan(param.getCodTipPlanDestino());
					aprovisionamientoPH.setCodTipoTerminal(abonados[i].getCodTipoTerminal());
					aprovisionamientoPH.setNumCelular(abonados[i].getNumCelular());

					RetornoDTO retornoAprov = provisionamientoBO.aprovisionamiento(aprovisionamientoPH);
					/*if(retornoAprov==null&&!"0".equalsIgnoreCase(retornoAprov.getCodigo())){
						throw new IssCusOrdException("Ocurrió un error general al ejecutar el Aprovisionamiento");
					}*/
				//fin REGISTRO MOVIMIENTOS DE ALTA O BAJA HIBRIDO
					
					
					//registroHistoricoPlan
					CicloFactDTO cicloFact = new CicloFactDTO ();
					cicloFact.setCodCiclo(cliente.getCodCiclo());
					cicloFact.setFecCicloFecDesdeLlam(param.getFecDesdeLlam());
					cicloFact.setPerCicloCodCiclFact(0); //CAMBIAR
					cicloFact.setNumAbonado(abonados[i].getNumAbonado());
					logger.debug("registroHistoricoPlan():inicio");
					/**/RetornoDTO retornoRegistroHistoricoPlan = planBO.registroHistoricoPlan(cicloFact);
					logger.debug("registroHistoricoPlan():fin");
					if(!"0".equalsIgnoreCase(retornoRegistroHistoricoPlan.getCodigo())){
						throw new IssCusOrdException("Ha ocurrido un error general al utilizar registroHistoricoPlan");
					}/**/

					//registraReordenamientoPlan
					ReordenamientoDTO reordenamiento = new ReordenamientoDTO();
					reordenamiento.setCodClienteOrigen(cliente.getCodCliente());
					reordenamiento.setCodClienteDestino(param.getCodClienteDestino());
					reordenamiento.setCodCuentaOrigen(cliente.getCodCuenta());
					reordenamiento.setCodCuentaDestino(param.getCodCuentaDestino());
					reordenamiento.setNumAbonado(abonados[i].getNumAbonado());
					reordenamiento.setCodSubCuentaOrigen(cliente.getCodSubCuenta());
					reordenamiento.setCodSubCuentaDestino(param.getCodSubCuentaDestino());
					reordenamiento.setCodPlanTarifDestino(param.getCodPlanTarifDestino());
					reordenamiento.setCodProducto(1);
					reordenamiento.setUsuarioOracle(param.getNomUsuaOra());
					reordenamiento.setCodActAbo(param.getCodActAbo());
					reordenamiento.setCodTipoContrato(abonados[i].getCodTipContrato());
					//reordenamiento.setCodTipoTraspaso("");//CAMBIAR
					reordenamiento.setNumContrato(abonados[i].getNroContrato());
					reordenamiento.setNumAnexo(abonados[i].getNumAnexo());
					reordenamiento.setCodUsuarioDestino(abonados[i].getCodUsuario());
					reordenamiento.setCodUsuarioOrigen(abonados[i].getCodUsuario());
					reordenamiento.setCodTipoMovimiento(param.getCodTipoMovimiento());
					reordenamiento.setNumCelular(abonados[i].getNumCelular());
					
					
					
					
					

					if("E".equalsIgnoreCase(cliente.getCodTipoPlanTarif())){
						reordenamiento.setEmpresaOrigen(cliente.getCodEmpresa());
					}else{
						reordenamiento.setEmpresaOrigen(0);
					}
					if("E".equalsIgnoreCase(param.getCodTipPlanDestino())){
						reordenamiento.setEmpresaDestino(cliente.getCodEmpresa());
					}else{
						reordenamiento.setEmpresaDestino(0);
					}
					/* COMENTADO PARA PROBAR
					logger.debug("registraReordenamientoPlan():inicio");
					RetornoDTO retornoRegistraReordPlan = productoBO.registraReordenamientoPlan(reordenamiento);
					logger.debug("registraReordenamientoPlan():fin");
					
					if(retornoRegistraReordPlan!=null&&!"0".equalsIgnoreCase(retornoRegistraReordPlan.getCodigo())){
						throw new IssCusOrdException("Ocurrió un error general al utilizar registraReordenamientoPlan");
					}*/

					//obtenerSecuencia
					SecuenciaDTO secuenciaValida = new SecuenciaDTO(); 
					secuenciaValida.setNomSecuencia("PV_SEQ_NUMOS");
					secuenciaValida = getSupOrdHanFacade().obtenerSecuencia(secuenciaValida);

					//validaServicioActDesc
					ValidaServiciosDTO validaServicios = new ValidaServiciosDTO();
					validaServicios.setNumMovimiento(secuenciaValida.getNumSecuencia());
					validaServicios.setCodActAbo(param.getCodActAbo());
					validaServicios.setCodProducto(1);
					validaServicios.setCodTecnologia(abonados[i].getCodTecnologia());
					validaServicios.setTipPantalla(0);
					validaServicios.setCodConcepto(0);
					validaServicios.setCodModulo("XS");
					validaServicios.setCodPlanTarifNue(param.getCodPlanTarifDestino());
					validaServicios.setCodPlanTarifAnt(abonados[i].getCodPlanTarif());
					validaServicios.setTipAbonado(0);
					validaServicios.setCodOS(param.getCodOS());
					validaServicios.setCodCliente(cliente.getCodCliente());
					validaServicios.setNumAbonado(abonados[i].getNumAbonado());
					validaServicios.setIndFactur(0);
					validaServicios.setCodPlanServ("0");
					validaServicios.setCodOperacion("0");
					validaServicios.setCodTipContrato("0");
					validaServicios.setTipCelular("0");
					validaServicios.setNumMeses(0);
					validaServicios.setCodAntiguedad("0");
					validaServicios.setCodCiclo(0);
					validaServicios.setNumCelular(abonados[i].getNumCelular());
					validaServicios.setTipServicio(0);
					validaServicios.setCodPlanCom(0);
					validaServicios.setParam1Mens(param.getAplicaTraspaso());
					validaServicios.setParam2Mens("0");
					validaServicios.setParam3Mens("0");
					validaServicios.setCodArticulo(0);
					validaServicios.setCodCausa("0");
					validaServicios.setCodCausaNue("0");
					validaServicios.setCodVend(0);
					validaServicios.setCodCategoria("0");
					validaServicios.setCodModVenta(0);
					validaServicios.setCodCausinie("0");
					logger.debug("validaServicioActDesc():inicio");
					/**/RegistroServiciosListDTO registroServiciosList = getComOrdFacade().validaServicioActDesc(validaServicios);
					logger.debug("validaServicioActDesc():fin");
					
					/**/registroServiciosList.getServicios()[0].getDesError();
					if(registroServiciosList.getServicios()[0].getCodError()!=0){
						throw new IssCusOrdException("Ha ocurrido un error general en validaServicioActDesc");
					}/**/


					//converActAbo
					ConvertActAboDTO converActAbo = new ConvertActAboDTO();
					converActAbo.setCodActAbo(param.getCodActAbo());
					converActAbo.setCodTipPlan(param.getCodTipPlanDestino());//CAMBIAR ...Dice param.getCodTipPlan y no existe...EXISTE UN getCodTipPlanDes
					logger.debug("obtenerConverActAbo():inicio");
					/**/converActAbo = getSupOrdHanFacade().obtenerConverActAbo(converActAbo);
					logger.debug("obtenerConverActAbo():fin");

					//obtenerSecuencia 
					SecuenciaDTO secuenciaAp = new SecuenciaDTO(); 
					secuenciaAp.setNomSecuencia("ICC_SEQ_NUMMOV");
					/**/secuenciaAp = getSupOrdHanFacade().obtenerSecuencia(secuenciaAp);

					//ejecutaAprovisionamiento
					AprovisionamientoDTO aprovisionamiento = new AprovisionamientoDTO();
					aprovisionamiento.setNumAbonado(abonados[i].getNumAbonado());
					aprovisionamiento.setCodActAbo("SS");
					aprovisionamiento.setTipoTecnologia(abonados[i].getCodActAbo());
					aprovisionamiento.setUsuarioOracle(param.getNomUsuaOra());
					aprovisionamiento.setCodTipoTerminal(cliente.getCodTipoTerminal());
					aprovisionamiento.setCodCentral(abonados[i].getCodCentral());
					aprovisionamiento.setNumSerie(abonados[i].getNumSerie());
					aprovisionamiento.setImei(abonados[i].getNumImei());
					aprovisionamiento.setValorOOSS(0);
					aprovisionamiento.setCodPlanTarif(param.getCodPlanTarifDestino());
					aprovisionamiento.setNumOOSS(0);
					aprovisionamiento.setCodOOSS(param.getCodOOSS());
					aprovisionamiento.setSeqNumMov(secuenciaAp.getNumSecuencia());
					aprovisionamiento.setCodTipPlan(param.getCodTipPlanDestino());//CAMBIAR...DICE param.getCodTipPlan y no esxiste...EXISTE UN getCodTipPlanDes
/*					aprovisionamiento.setCodServicios(registroServiciosList.getServicios()[0].getClaseServicios());
					RetornoDTO retornoAprov = provisionamientoBO.aprovisionamiento(aprovisionamiento);
					if(retornoAprov!=null&&!"0".equalsIgnoreCase(retornoAprov.getCodigo())){
						throw new IssCusOrdException("Ocurrió un error general al ejecutar el Aprovisionamiento");
					}
*/
					long sujeto = 0;
					String tipSujeto = "";
					if (abonados[i].getCodTipoPlanTarif().equals("I")){
						sujeto = abonados[i].getNumAbonado();
						tipSujeto = "A";
					}else{
						if (param.getTipPlanTarifDestino().equals("I")){
							sujeto = abonados[i].getNumAbonado();
							tipSujeto = "A";
						}else{
							sujeto = abonados[i].getCodCliente();
							tipSujeto = "C";
						}
					}
					
					LimiteConsumoDTO limiteConsumo = new LimiteConsumoDTO();
					limiteConsumo.setSujeto(sujeto);
					limiteConsumo.setTipSujeto(tipSujeto);
					limiteConsumo.setFechaDesde(param.getFecDesdeLlam());
					limiteConsumo.setFechaHasta("*");
					limiteConsumo.setCodActAbo(param.getCodActAbo());
					limiteConsumo.setCodPlanTarifDestino(param.getCodPlanTarifDestino());
					limiteConsumo.setCodTipoMovimiento(param.getCodTipoMovimiento());
					limiteConsumo.setCodProducto(1);
					logger.debug("actualizarLimiteConsumo():inicio");
					/**/RetornoDTO actLimConsumo = provisionamientoBO.actualizarLimiteConsumo(limiteConsumo);
					logger.debug("actualizarLimiteConsumo():fin");
					
					/**/if(actLimConsumo==null&&!"0".equalsIgnoreCase(actLimConsumo.getCodigo())){
						throw new IssCusOrdException("Ha ocurrido un error general al utilizar actualizarLimiteConsumo");
					}else{
						IntegraProdCPUDTO integraProd = new IntegraProdCPUDTO();
						integraProd.setClienteOrigen(cliente.getCodCliente());
						integraProd.setAbonadoOrigen(abonados[i].getNumAbonado());
						integraProd.setPlanTarifOrigen(abonados[i].getPlanTarifario()!=null?abonados[i].getPlanTarifario().getCodPlanTarif():null);
						integraProd.setClienteDestino(param.getCodClienteDestino());
						integraProd.setAbonadoDestino(abonados[i].getNumAbonado());
						integraProd.setPlanTarifDestino(param.getCodPlanTarifDestino());
						integraProd.setFechaActivacionPlanes(new Timestamp(System.currentTimeMillis()));
						integraProd.setFechaDesactivacionPlanes(Timestamp.valueOf("3000-12-31 00:00:00.000000000"));
						integraProd.setNumMovCentral(0);
						integraProd.setOrigenProceso("PV");
						integraProd.setNumProceso(numOs);
						logger.debug("creaEstructuraProdCPU():inicio");
						retorno = getSupOrdHanFacade().creaEstructuraProdCPU(integraProd, retorno);
						logger.debug("creaEstructuraProdCPU():fin");
					}/**/
				}
			} catch (IssCusOrdException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("IssCusOrdException[" + loge + "]");
				e.printStackTrace();
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				e.printStackTrace();
			} catch (ManConException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManConException[" + loge + "]");
				e.printStackTrace();
			/*} catch (ProductException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ProductException[" + loge + "]");
				e.printStackTrace();*/
			} catch (ProductOfferingException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ProductOfferingException[" + loge + "]");
				e.printStackTrace();
			} catch (CloCusOrdException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("CloCusOrdException[" + loge + "]");
				e.printStackTrace();
			} catch (SupOrdHanException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("SupOrdHanException[" + loge + "]");
				e.printStackTrace();
			/**/} catch (ComOrdException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ComOrdException[" + loge + "]");
				e.printStackTrace();/**/
			} catch (ServiceSpecEntitiesException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ServiceSpecEntitiesException[" + loge + "]");
				e.printStackTrace();
			}
		}

		integraProdCPU.setLista(retorno);
		logger.debug("registroReordenamientoAbonados():fin");
		return integraProdCPU;
	}

	private AbonadoDTO [] obtenerAbonados(String [] numAbonados) throws RemoteException, IssCusOrdException, ManConException{
		AbonadoDTO []abonados = new AbonadoDTO[numAbonados.length];
		ManConFacade manConFacade = getManConFacade();
		for(int i = 0; i<abonados.length;i++){
			abonados[i] = new AbonadoDTO();
			abonados[i].setNumAbonado(Long.valueOf(numAbonados[i]).longValue());
			abonados[i] = manConFacade.obtenerDatosAbonado(abonados[i]);
		}
		return abonados;
	}

	public RetornoDTO registroCargosAbonadosBatch(ParamRegistroOrdenServicioDTO entrada) throws IssCusOrdException{
		RetornoDTO retorno = new RetornoDTO();
		try {
			ManCusBilFacade manCusBilFacade = getManCusBilFacade();
			SupOrdHanFacade supOrdHanFacade = getSupOrdHanFacade();
			RegistroPlanDTO param = entrada.getRegistroPlan();
			ClienteDTO cliente = param.getCliente();
			//AbonadoDTO abonados[] = obtenerAbonados(param.getParamRegistroPlan().getNumAbonados()); 
			OSAbonadoDTO abonados[] = param.getOsAbonados();//REVISAR QUE SIEMPRE SE LE ESTA PASANDO ESTE VALOR
			CargosDTO[] cargos = entrada.getRegistroCargos()==null?null:entrada.getRegistroCargos().getOcacionales()==null?null:entrada.getRegistroCargos().getOcacionales().getCargos();

			SecuenciaDTO secuencia = new SecuenciaDTO();
			RegistroCargosBatchDTO registroCargosBatch = new RegistroCargosBatchDTO();
			registroCargosBatch.setCodProducto(1);
			registroCargosBatch.setCodPlanCom(new Long(cliente.getCodPlanCom()).longValue());
			registroCargosBatch.setCodCliente(cliente.getCodCliente());
			registroCargosBatch.setNomUsuarOra(entrada.getNomUsuaOra());
			
			
			
			if(param.getParamRegistroPlan().getTipOOSS().equalsIgnoreCase("40007")){//Si es Empresa, agrupa y asigna los cargos al abonado 0
				long numOs = abonados[0].getNumOOSS();//Revisar si para empresa se toma el numero de os del primer abonado
				registroCargosBatch.setNumOs(numOs);
				logger.debug("OOSS 40007, numOs="+numOs);
				
				UtilAgrupCargosDTO[]  datosCargosAgrupados = obtenerDatosDeCargosAgrupados(cargos);
				for(int i = 0; i<datosCargosAgrupados.length;i++){
					secuencia.setNomSecuencia("GE_SEQ_CARGOS");
					secuencia = supOrdHanFacade.obtenerSecuencia(secuencia);
					registroCargosBatch.setNumCargo(secuencia.getNumSecuencia());
					registroCargosBatch.setNumAbonado(0);
					registroCargosBatch.setFecAlta(new Date(System.currentTimeMillis()));
					registroCargosBatch.setCodConcepto(Long.valueOf(datosCargosAgrupados[i].getCodigoConcepto()).longValue());
					registroCargosBatch.setNumUnidades(datosCargosAgrupados[i].getNumUnidades());
					registroCargosBatch.setImpCargo(datosCargosAgrupados[i].getMonto() * entrada.getRegistroPlan().getOsAbonados().length);  // multiplica el valor por la cantidad de abonados
					registroCargosBatch.setCodMoneda(datosCargosAgrupados[i].getCodigoMoneda());
					registroCargosBatch.setCodConceptoDto(datosCargosAgrupados[i].getCodigoConceptoDescuento()==null?0:Long.parseLong(datosCargosAgrupados[i].getCodigoConceptoDescuento()));
					registroCargosBatch.setTipDto(datosCargosAgrupados[i].getTipDescuento());
					if(datosCargosAgrupados[i].getTipDescuento()== 0){
						registroCargosBatch.setValDto( datosCargosAgrupados[i].getValorDescuento() * entrada.getRegistroPlan().getOsAbonados().length);  // multiplica el valor por la cantidad de abonados
					}else{
						registroCargosBatch.setValDto( datosCargosAgrupados[i].getValorDescuento() );  
					}
					
					
					try{
						RegistroFacturacionDTO  registroFact = registroFacturacionBO.getCodigoCicloFacturacion(cliente);
						registroCargosBatch.setCodCiclFact(registroFact.getCodigoCicloFacturacion());
						
					}catch(Exception e){
						throw new IssCusOrdException(e);
					}
					
					retorno = manCusBilFacade.registraCargosBatch(registroCargosBatch);
				}
	
				
			}else{
				if (cargos==null || cargos.length == 0)
					logger.debug("NO HAY CARGOS ");
				
				for(int i = 0; i<(cargos==null?0:cargos.length);i++){
					logger.debug("cargo "+ i);
					//Para cada abonado ejecutar el registro de cargos
					for(int j=0; j<abonados.length;j++){
							OSAbonadoDTO osAbonado=abonados[j];
							long numAbonado = osAbonado.getAbonado().getNumAbonado();
							long numOs = osAbonado.getAbonado().getNumeroOS();
							
							if(numAbonado == Long.parseLong(cargos[i].getAtributo().getNumAbonado())){
								logger.debug("Registra cargos para abonado :"+numAbonado);
								
								secuencia.setNomSecuencia("GE_SEQ_CARGOS");
								secuencia = supOrdHanFacade.obtenerSecuencia(secuencia);
								registroCargosBatch.setNumAbonado(numAbonado);
								registroCargosBatch.setNumOs(numOs);
								registroCargosBatch.setNumCargo(secuencia.getNumSecuencia());
								registroCargosBatch.setCodConcepto(new Long(cargos[i].getPrecio().getCodigoConcepto()).longValue());
								registroCargosBatch.setFecAlta(new Date(System.currentTimeMillis()));
								registroCargosBatch.setImpCargo((cargos[i].getPrecio().getMonto()));
								registroCargosBatch.setCodMoneda(cargos[i].getPrecio().getUnidad().getCodigo());
								registroCargosBatch.setNumUnidades(1);
								
								if (cargos[i].getDescuento()==null ){
									registroCargosBatch.setCodConceptoDto(0);
									registroCargosBatch.setValDto(0);
									registroCargosBatch.setTipDto(0);
								}else{
									registroCargosBatch.setCodConceptoDto(Long.valueOf(cargos[i].getDescuento()[0].getCodigoConcepto()).longValue());
									registroCargosBatch.setValDto(cargos[i].getDescuento()[0].getMonto());
									registroCargosBatch.setTipDto(cargos[i].getDescuento()[0].getTipo()==null?0:Long.parseLong(cargos[i].getDescuento()[0].getTipo()));
								}
								
								/*
								if (cargos[i].getDescuento()!=null&&cargos[i].getDescuento().length>0){
									registroCargosBatch.setCodConceptoDto(Long.valueOf(cargos[i].getDescuento()[0].getCodigoConcepto()).longValue());
									registroCargosBatch.setValDto(cargos[i].getDescuento()[0].getMonto());
									registroCargosBatch.setTipDto(cargos[i].getDescuento()[0].getTipo()==null?0:Long.parseLong(cargos[i].getDescuento()[0].getTipo()));
								}*/
								
								try{
									RegistroFacturacionDTO  registroFact = registroFacturacionBO.getCodigoCicloFacturacion(cliente);
									registroCargosBatch.setCodCiclFact(registroFact.getCodigoCicloFacturacion());
									
								}catch(Exception e){
									throw new IssCusOrdException(e);
								}
								
																
								retorno = manCusBilFacade.registraCargosBatch(registroCargosBatch);
							}//fin if(numAbonado == Long.parseLong(cargos[i].getAtributo().getNumAbonado()))
							
					}//for(int j=0; j<abonados.length;j++){
					
				}//fin for(int i = 0; i<(cargos==null?0:cargos.length);i++)
			}//fin else


		} catch (IssCusOrdException e) {
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (ManCusBilException e) {
			e.printStackTrace();
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			throw new IssCusOrdException("Ha ocurrido un error general al registroCargosAbonadosBatch");
		} catch (SupOrdHanException e) {
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}


		return retorno;
	}
	
	private UtilAgrupCargosDTO[] obtenerDatosDeCargosAgrupados(CargosDTO[] cargos){
		UtilAgrupCargosDTO[] retorno=null;
		List codConceptos = new ArrayList();
		HashMap a = new HashMap();
		int contador=0;
		for(int i = 0; i<cargos.length;i++){
			if(a.containsKey(cargos[i].getPrecio().getCodigoConcepto())){
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setNumUnidades(((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).getNumUnidades()+1);
			}else{
				contador++;
				a.put(cargos[i].getPrecio().getCodigoConcepto(), new UtilAgrupCargosDTO());
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setNumUnidades(1);
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setCodigoConcepto(cargos[i].getPrecio().getCodigoConcepto());
				codConceptos.add(cargos[i].getPrecio().getCodigoConcepto());
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setMonto(cargos[i].getPrecio().getMonto());
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setCodigoMoneda(cargos[i].getPrecio().getUnidad().getCodigo());
				
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setValorDescuento(cargos[i].getDescuento()!=null?cargos[i].getDescuento()[0].getMonto():0);
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setCodigoConceptoDescuento(cargos[i].getDescuento()!=null&&cargos[i].getDescuento()[0].getCodigoConcepto()!=null? cargos[i].getDescuento()[0].getCodigoConcepto():"0");
				((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setTipDescuento(Long.parseLong(cargos[i].getDescuento()!=null&&cargos[i].getDescuento()[0].getTipo()!=null ? cargos[i].getDescuento()[0].getTipo() : "0"));
							
					
				
				/*
				RegistroCargosDTO registroCargos = agruparDescuentos(cargos[i]);
				if(registroCargos!=null){
					((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setValorDescuento(registroCargos.getValorDescuento());
					((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setCodigoConceptoDescuento(registroCargos.getCodigoConceptoDescuento());
					((UtilAgrupCargosDTO)a.get(cargos[i].getPrecio().getCodigoConcepto())).setTipDescuento(registroCargos.getTipoDescuento()==null?9:Long.parseLong(registroCargos.getTipoDescuento()));
				}*/
			}
		}
		
		retorno = new UtilAgrupCargosDTO[contador];
		for(int x = 0; x<contador;x++){
			retorno[x] = (UtilAgrupCargosDTO)a.get(codConceptos.get(x)); 
		}
		return retorno;
	}
	
	private AbonadoDTO obtAbonado(AbonadoDTO[] abonados, String numAbonado){
		for(int i = 0; i<abonados.length;i++){
			if(numAbonado.equalsIgnoreCase(String.valueOf(abonados[i].getNumAbonado()))){
				return abonados[i];
			}
		}
		return null;
	}

	public RetornoDTO validarActDescRegistrarCambPlanBatch(RegistroPlanDTO registro) throws IssCusOrdException{
		logger.debug("validarActDescRegistrarCambPlanBatch():start");

		RetornoDTO retorno= new RetornoDTO();
		ParamRegistroPlanDTO param = registro.getParamRegistroPlan();
		OSAbonadoDTO abonados[] = registro.getOsAbonados();
		
		long numAbonados = abonados.length;
		logger.debug("numAbonados="+numAbonados);
		
		try{
				SecuenciaDTO secuenciaNumMov = new SecuenciaDTO();
				ValidaServiciosDTO validaServicios = new ValidaServiciosDTO();
				PlanBatchDTO planBatch = new PlanBatchDTO();
				
				for(int i = 0; i<numAbonados;i++){
					OSAbonadoDTO osAbonados = abonados[i];
					AbonadoDTO abonado = osAbonados.getAbonado();
					long 	   numOs   = osAbonados.getNumOOSS();
					logger.debug("numAbonado="+abonado.getNumAbonado());
					logger.debug("numOs="+numOs);
					
					//Obtener Secuencia para validaServicioActDesc
					secuenciaNumMov.setNomSecuencia("PV_SEQ_NUMOS");
					secuenciaNumMov = getSupOrdHanFacade().obtenerSecuencia(secuenciaNumMov);

					//validaServicioActDesc
					validaServicios.setNumMovimiento(secuenciaNumMov.getNumSecuencia());
					validaServicios.setCodActAbo(param.getCodActAbo());
					validaServicios.setCodProducto(1);
					validaServicios.setCodTecnologia(abonado.getCodTecnologia());
					validaServicios.setTipPantalla(0);
					validaServicios.setCodConcepto(0);
					validaServicios.setCodModulo("XS");
					validaServicios.setCodPlanTarifNue(param.getCodPlanTarifDestino());
					validaServicios.setCodPlanTarifAnt(abonado.getCodPlanTarif());
					validaServicios.setTipAbonado(0);
					validaServicios.setCodOS(param.getCodOS());
					validaServicios.setCodCliente(abonado.getCodCliente());
					validaServicios.setNumAbonado(abonado.getNumAbonado());
					validaServicios.setIndFactur(0);
					validaServicios.setCodPlanServ("0");
					validaServicios.setCodOperacion("0");
					validaServicios.setCodTipContrato("0");
					validaServicios.setTipCelular("0");
					validaServicios.setNumMeses(0);
					validaServicios.setCodAntiguedad("0");
					validaServicios.setCodCiclo(0);
					validaServicios.setNumCelular(abonado.getNumCelular());
					validaServicios.setTipServicio(0);
					validaServicios.setCodPlanCom(0);
					validaServicios.setParam1Mens(param.getAplicaTraspaso()==null||"".equals(param.getAplicaTraspaso())?"NO":param.getAplicaTraspaso());
					validaServicios.setParam2Mens("0");
					validaServicios.setParam3Mens("0");
					validaServicios.setCodArticulo(0);
					validaServicios.setCodCausa("0");
					validaServicios.setCodCausaNue("0");
					validaServicios.setCodVend(0);
					validaServicios.setCodCategoria("0");
					validaServicios.setCodModVenta(0);
					validaServicios.setCodCausinie("0");
					RegistroServiciosListDTO registroServiciosList = getComOrdFacade().validaServicioActDesc(validaServicios);

					registroServiciosList.getServicios()[0].getDesError();
					if(registroServiciosList.getServicios()[0].getCodError()!=0){
						throw new IssCusOrdException("Ha ocurrido un error general en validaServicioActDesc");
					}

					//registraCambPlanBatch()
					planBatch.setIdSecuencia(numOs); //NUMERO DE ORDEN DE SERVICIO
					planBatch.setCodActAl(String.valueOf(registroServiciosList.getServicios()[0].getClaseServiciosAct()));
					planBatch.setCodActBa(registroServiciosList.getServicios()[0].getClaseServiciosDes());
					planBatch.setUsuario(param.getNomUsuaOra());
					planBatch.setCodOOSS(param.getCodOS());
					planBatch.setNumAbonado(abonado.getNumAbonado());
					planBatch.setPeriodoFact(Integer.parseInt(String.valueOf(param.getPeriodoFact())));
					planBatch.setCodPlanTarif(param.getCodPlanTarifDestino());
					planBatch.setFecVencimiento(param.getFechaDesde());
					
					planBatch.setCodCausa(param.getCodCausaBajaSel());
					planBatch.setIndPortable(param.getIndPortable());
					
					if(param.getTipOOSS().equalsIgnoreCase("40007")){//Solo cuando es empresa su cod Actabo debe ser "SS"
						planBatch.setCodActAbo("SS");
					}else{
						planBatch.setCodActAbo(param.getCodActAbo());
					}
					planBatch.setNumOSF(1);
					planBatch.setCodProducto(1);
					planBatch.setTipSujeto(param.getSujeto());
					planBatch.setCodCausaExc("003"); //causa por defecto
					planBatch.setCodClienteNuevo(param.getCodClienteDestino());
					planBatch.setCodCuentaNueva(param.getCodCuentaDestino());

					retorno = getCloCusOrdFacade().registraCambPlanBatch(planBatch);
					

				}// fin for(int i = 0; i<numAbonados;i++)

		}catch(Exception e)	{			
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}
		retorno.setCodigo("0");
		retorno.setDescripcion("");
		logger.debug("validarActDescRegistrarCambPlanBatch():end");
		return retorno;
	}

	public RetornoDTO registrarCambioPlanAbonados(RegistroPlanDTO registro) throws IssCusOrdException{
		logger.debug("registrarCambioPlanAbonados():start");
		RetornoDTO retorno = new RetornoDTO();
		SecuenciaDTO secuenciaAbonado = new SecuenciaDTO();
		ParamRegistroPlanDTO param = registro.getParamRegistroPlan();
		OSAbonadoDTO abonados[] = registro.getOsAbonados();
		
		long numAbonados = abonados.length;
		logger.debug("numAbonados="+numAbonados);

		try {
			
			for(int i = 0; i<abonados.length;i++){
						
				OSAbonadoDTO osAbonados = abonados[i];
				AbonadoDTO abonado = osAbonados.getAbonado();
				logger.debug("numAbonado="+abonado.getNumAbonado());
				
				secuenciaAbonado.setNomSecuencia("GA_SEQ_TRANSACABO");
				secuenciaAbonado = getSupOrdHanFacade().obtenerSecuencia(secuenciaAbonado);

				
				PlanServicioDTO planServicio = new PlanServicioDTO();
				planServicio.setIdSecuencia(secuenciaAbonado.getNumSecuencia());
				planServicio.setCodActAbo("CS");
				planServicio.setCodProducto(1);
				planServicio.setNumAbonado(abonado.getNumAbonado());
				planServicio.setTipPlanTarif(param.getTipPlanTarifDestino());
				planServicio.setCodPlanTarifNuevo(param.getCodPlanTarifDestino());
				planServicio.setCodHolding(0);
				planServicio.setCodTipPlan(param.getCodTipPlanDestino());
				
				// obtener cambio de plan serv
				AbonadoDTO abonadoAux = new AbonadoDTO();
				abonadoAux.setCodPlanTarif(param.getCodPlanTarifDestino());
				abonadoAux.setCodTecnologia(abonado.getCodTecnologia());
				logger.debug("obtenerDatosCambPlanServ():inicio");
				abonadoAux = getSupOrdHanFacade().obtenerDatosCambPlanServ(abonadoAux);
				logger.debug("obtenerDatosCambPlanServ():fin");
				planServicio.setCodPlanServicio(abonadoAux.getCodPlanServ());
				logger.debug("CodPlanServNuevo="+abonadoAux.getCodPlanServ());
				
				if (planServicio.getCodPlanServicio()!=null && !planServicio.getCodPlanServicio().equalsIgnoreCase("null")){
					logger.debug("registroCambPlanServ():ini");
					RetornoDTO retornoCambPlanServ = getIssCusOrdFacade().registroCambPlanServ(planServicio);
					logger.debug("registroCambPlanServ():fin");
					if(!retornoCambPlanServ.getCodigo().equals("0")){
						throw new IssCusOrdException("Ocurrió un error general al ejecutar registrarCambioPlanAbonados");
					}
				}
				
			}//for(int i = 0; i<abonados.length;i++)	
			
			retorno.setCodigo("0");
			retorno.setDescripcion("");
			
		} catch (SupOrdHanException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			e.printStackTrace();
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			e.printStackTrace();
		}
		
		logger.debug("registrarCambioPlanAbonados():end");
		return retorno;
	}



	private ManConFacade getManConFacade() throws IssCusOrdException, ManConException 
	{
		Global global = Global.getInstance();		
		logger.debug("getManConFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		ManConFacadeHome manConFacadeHome = null;

		String jndi = global.getValor("jndi.ManConFacade");
		logger.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManConProvider");
		logger.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manConFacadeHome = (ManConFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManConFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new ManConException(e);
		}		
		logger.debug("Recuperada interfaz home de ManConFacade...");
		ManConFacade manConFacade = null;

		try 
		{
			manConFacade = manConFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		logger.debug("getManConFacade():end");
		return manConFacade;
	}

	private ComOrdFacade getComOrdFacade() throws IssCusOrdException, ComOrdException
	{
		Global global = Global.getInstance();		
		logger.debug("getComOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		ComOrdFacadeHome comOrdFacadeHome = null;

		String jndi = global.getValor("jndi.ComOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ComOrdProvider");
		logger.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			comOrdFacadeHome = (ComOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ComOrdFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new ComOrdException(e);
		}		
		logger.debug("Recuperada interfaz home de ComOrdFacade...");
		ComOrdFacade comOrdFacade = null;

		try 
		{
			comOrdFacade = comOrdFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		logger.debug("getComOrdFacade():end");
		return comOrdFacade;
	}
	private SupOrdHanFacade getSupOrdHanFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		logger.debug("getSupOrdHanFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		SupOrdHanFacadeHome supOrdHanFacadeHome = null;
		String jndi = global.getValor("jndi.SupOrdHanFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.SupOrdHanProvider");
		logger.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		try {
			supOrdHanFacadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("Recuperada interfaz home de Issue Customer Order Facade...");
		SupOrdHanFacade supOrdHanFacade = null;
		try {
			supOrdHanFacade = supOrdHanFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");

			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("getIssCusOrdFacade():end");
		return supOrdHanFacade;
	}


	private ManCusBilFacade getManCusBilFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		logger.debug("getManCusBilFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		ManCusBilFacadeHome manCusBilFacadeHome = null;
		String jndi = global.getValor("jndi.ManCusBilFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.ManCusBilProvider");
		logger.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		try {
			manCusBilFacadeHome = (ManCusBilFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, ManCusBilFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("Recuperada interfaz home de ManCusBil Facade...");
		ManCusBilFacade manCusBilFacade = null;
		try {
			manCusBilFacade = manCusBilFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}
		logger.debug("getManCusBilFacade():end");
		return manCusBilFacade;
	}

	private CloCusOrdFacade getCloCusOrdFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		logger.debug("getCloCusOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		CloCusOrdFacadeHome cloCusOrdFacadeHome = null;
		String jndi = global.getValor("jndi.CloCusOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.CloCusOrdProvider");
		logger.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		try {
			cloCusOrdFacadeHome = (CloCusOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, CloCusOrdFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("Recuperada interfaz home de Close Customer Order Order Facade...");
		CloCusOrdFacade cloCusOrdFacade = null;
		try {
			cloCusOrdFacade = cloCusOrdFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}
		logger.debug("getCloCusOrdFacade():end");
		return cloCusOrdFacade;
	}
	
	private RegistroCargosDTO agruparDescuentos(CargosDTO cargosDTO){
		double numeroDecimalesPorDesc = 0;
		boolean bExistDctoAut = false;
		RegistroCargosDTO registroCargos = new RegistroCargosDTO();
		if(cargosDTO!=null){
				float ifValorDescuento = 0;
				
				if (cargosDTO.getDescuento()!=null&&cargosDTO.getDescuento().length>0){
					for (int k=0; k<cargosDTO.getDescuento().length;k++){
						
						
						if (cargosDTO.getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)) 
								&& cargosDTO.getDescuento()[k].getMonto() > 0){
							registroCargos.setCodigoConceptoDescuento(cargosDTO.getDescuento()[k].getCodigoConcepto());
							bExistDctoAut = true;

						}
						else if(cargosDTO.getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual)) 
								&& !bExistDctoAut){
							registroCargos.setCodigoConceptoDescuento(cargosDTO.getDescuento()[k].getCodigoConcepto());
						}
						
						if(cargosDTO.getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
								&& cargosDTO.getDescuento()[k].getMonto() > 0){
							ifValorDescuento =((registroCargos.getImporteCargo() * cargosDTO.getDescuento()[k].getMonto()) /100) + registroCargos.getValorDescuento();
							logger.debug("valor descuento sin redondeo: " + ifValorDescuento);
							Double  dValorDescAux = new Double(Math.round(ifValorDescuento*Math.pow(10,numeroDecimalesPorDesc))/Math.pow(10,numeroDecimalesPorDesc));
							ifValorDescuento =  dValorDescAux.floatValue();
							logger.debug("valor descuento con redondeo: " + ifValorDescuento);

							registroCargos.setValorDescuento(ifValorDescuento * cargosDTO.getCantidad());
						}	
						else
							registroCargos.setValorDescuento(registroCargos.getValorDescuento() + cargosDTO.getDescuento()[k].getMonto());
						
						
												
						
												
				}  // del for
			}  // del if descuento !=null
		} // del if cargos !=null
		return registroCargos;
	}
	
	
	
	private IssCusOrdFacade getIssCusOrdFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		logger.debug("getIssCusOrdFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		IssCusOrdFacadeHome issCusOrdFacadeHome = null;
		String jndi = global.getValor("jndi.IssCusOrdFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.IssCusOrdProvider");
		logger.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		try {
			issCusOrdFacadeHome = (IssCusOrdFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, IssCusOrdFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("Recuperada interfaz home de Issue Customer Order Facade...");
		IssCusOrdFacade issCusOrdFacade = null;
		try {
			issCusOrdFacade = issCusOrdFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");

			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		logger.debug("getIssCusOrdFacade():end");
		return issCusOrdFacade;
	}
}
