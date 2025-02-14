/**
 * 
 */
package com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActParamComerInmDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraCPUPDTDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaIntegracionCPUPDTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productPromotionABE.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.SaldoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.IssCusOrdSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.GestionActivacionesSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces.IssCusOrdSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces.IssCusOrdSrvIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.GestionPromocionOrdenSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces.GestionPromocionOrdenSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces.GestionPromocionOrdenSrvIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.GestionOrdenServiciosSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.IntegracionSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.GestionOrdenServiciosSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.GestionOrdenServiciosSrvIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.IntegracionSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.IntegracionSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IssCusOrdFacade"	
 *           description="An EJB named IssCusOrdFacade"
 *           display-name="IssCusOrdFacade"
 *           jndi-name="IssCusOrdFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * @weblogic.transaction-descriptor trans-timeout-seconds = "900"
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class IssCusOrdFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;

	private final Logger logger = Logger.getLogger(IssCusOrdFacadeBean.class);

	private Global global = Global.getInstance();

	// Instancia el factory
	IssCusOrdSrvFactoryIF factorySrv1 = new IssCusOrdSrvFactory();	
	GestionPromocionOrdenSrvFactoryIF factorySrv2 = new GestionPromocionOrdenSrvFactory();	
	GestionOrdenServiciosSrvFactoryIF factorySrv3 = new GestionOrdenServiciosSrvFactory();
	GestionActivacionesSrvFactoryIF factorySrv4 = new GestionActivacionesSrvFactory();
	IntegracionSrvFactoryIF factorySrv5 = new IntegracionSrvFactory();

	// Obtiene el application service
	IssCusOrdSrvIF service1 = factorySrv1.getApplicationService1();	
	GestionPromocionOrdenSrvIF service2 = factorySrv2.getApplicationService1();
	GestionOrdenServiciosSrvIF service3 = factorySrv3.getApplicationService1();
	GestionActivacionesSrvIF   service4 = factorySrv4.getApplicationService1();
	IntegracionSrvIF service5 = factorySrv5.getApplicationService1();
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String foo(String param) {
		return null;
	}
	
	/** 
	 * Este método es responsable de activar una lista de productos contratados.
	 * @param productos representa una lista de productos contratados (arreglo de objetos ProductoContratadoDTO). 
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub 
	 */
	public RetornoDTO activarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("activarProductoContratado():start");
			resultado = service4.activarProductoContratado(productos);
			logger.debug("activarProductoContratado():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Este método es responsable de enviar correo para una lista de productos contratados que lo requieran.
	 * @param productos representa una lista de productos contratados (arreglo de objetos ProductoContratadoDTO). 
	 * @return RetornoDTO
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub 
	 */
	public RetornoDTO enviarCorreo(ProductoContratadoListDTO productos) throws IssCusOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("enviarCorreo():start");
			resultado = service4.enviarCorreo(productos);
			logger.debug("enviarCorreo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Este método es responsables de activar una lista de paquetes contratados.
	 * @param paquetes representa una lista de paquetes contratados (arreglo de objetos PaqueteContratadoDTO).
	 * 		  Cada PaqueteContratadoDTO contiene una lista de productos contratados a ser activados (ProductoContratadoDTO)
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 * 
	 */
	public RetornoDTO activarPaqueteContratado(PaqueteContratadoListDTO paquetes) throws IssCusOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("activarPaqueteContratado():start");
			resultado = service4.activarPaqueteContratado(paquetes);
			logger.debug("activarPaqueteContratado():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 *  Registro de intarcel
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws IssCusOrdException {
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");	
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("actualizaIntarcelAcciones():start");
			resultado = service1.actualizaIntarcelAcciones(intarcel);
			logger.debug("actualizaIntarcelAcciones():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Registra activación/desactivación de servicios frecuentes
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraDesActSerFre():start");
			resultado = service3.registraDesActSerFre(param);
			logger.debug("registraDesActSerFre():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Elimina y actualiza de ga_intarcel
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraElimActIntarcel():start");
			resultado = service1.registraElimActIntarcel(intarcel);
			logger.debug("registraElimActIntarcel():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}		


	/** 
	 * Registra numeros frecuentes desactivados
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaDesacListaFrecuente():start");
			resultado = service1.validaDesacListaFrecuente(lista);
			logger.debug("validaDesacListaFrecuente():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Actualiza límite de consumo
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarLimiteConsumo():start");
			resultado = service3.actualizarLimiteConsumo(param);
			logger.debug("actualizarLimiteConsumo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}		
	
	/** 
	 * Informa plan de servicio
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroCambPlanServ():start");
			resultado = service3.registroCambPlanServ(plan);
			logger.debug("registroCambPlanServ():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Actualiza la situación del abonado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaSituaAbo():start");
			resultado = service1.actualizaSituaAbo(abonado);
			logger.debug("actualizaSituaAbo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Registra baja y/o alta de gestor corporativo
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param) throws IssCusOrdException{	
		GestorCorpDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaGestorCorp():start");
			resultado = service1.validaGestorCorp(param);
			logger.debug("validaGestorCorp():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Elimina promocion
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param)throws IssCusOrdException {	
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPromocion():start");
			resultado = service2.eliminarPromocion(param);
			logger.debug("eliminarPromocion():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Registra movimientos a interfaz con central
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param) throws IssCusOrdException {	
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("aprovisionamiento():start");
			resultado = service1.aprovisionamiento(param);
			logger.debug("aprovisionamiento():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Registra cambio de plan
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws IssCusOrdException {	
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registroCambPlanComer():start");
			resultado = service3.registroCambPlanComer(datos);
			logger.debug("registroCambPlanComer():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}

	/** 
	 * Actualiza cambio de plan
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarParamComerInm(ActParamComerInmDTO datos) throws IssCusOrdException {	
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarParamComerInm():start");
			resultado = service3.actualizarParamComerInm(datos);
			logger.debug("actualizarParamComerInm():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Este metodo esta asociado a la consulta de saldo, 
	 * plantarifario actual  numeros frecuentes a la dll ICC_CONSULTA
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaPrepago():start");
			resultado = service3.consultaPrepago(consulta);
			logger.debug("consultaPrepago():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * Consulta saldo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws IssCusOrdException{
		SaldoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaSaldo():start");
			resultado = service3.consultaSaldo(consulta);
			logger.debug("consultaSaldo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}

	/** 
	 * Consulta plan actual
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws IssCusOrdException{
		PlanTarifarioDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaPlanActual():start");
			resultado = service3.consultaPlanActual(consulta);
			logger.debug("consultaPlanActual():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * Consulta listas activas
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws IssCusOrdException{
		ListaActivaListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaListaActivas():start");
			resultado = service3.consultaListaActivas(consulta);
			logger.debug("consultaListaActivas():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarCargoBolsaDinamica():start");
			resultado = service1.actualizarCargoBolsaDinamica(bolsa);
			logger.debug("actualizarCargoBolsaDinamica():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaFinCiclo():start");
			resultado = service1.eliminaFinCiclo(finCiclo);
			logger.debug("eliminaFinCiclo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaFinCiclo():start");
			resultado = service1.registroHistoricoPlan(ciclo);
			logger.debug("eliminaFinCiclo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraTraspasoPlan():start");
			resultado = service1.registraTraspasoPlan(traspaso);
			logger.debug("registraTraspasoPlan():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraReordenamientoPlan():start");
			resultado = service1.registraReordenamientoPlan(datos);
			logger.debug("registraReordenamientoPlan():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}		
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraProrrateo() throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraReordenamientoPlan():start");
			resultado = service1.registraProrrateo();
			logger.debug("registraReordenamientoPlan():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente) throws IssCusOrdException{
		ParametroDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAtlantida():start");
			resultado = service1.obtieneAtlantida(cliente);
			logger.debug("obtieneAtlantida():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaBajaAtlantida():start");
			resultado = service1.validaBajaAtlantida(param);
			logger.debug("validaBajaAtlantida():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPlanAtlantida():start");
			resultado = service3.obtenerPlanAtlantida(abonado);
			logger.debug("obtenerPlanAtlantida():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;	
	}
	
	
	/** 
	 * Este método es responsable iniciar la descontratación de una serie de productos contratados.
	 * @param productoContratadoList representa una lista de productos contratados (arreglo de objetos ProductoContratadoDTO). 
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 *  
	 */
	public RetornoDTO descontratarProductoContratado(ProductoContratadoListDTO productoContratadoList) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPlanAtlantida():start");
			resultado = service4.descontratarProductoContratado(productoContratadoList);
			logger.debug("obtenerPlanAtlantida():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;	
	}
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertaMovAtl():start");
			resultado = service3.insertaMovAtl(mov);
			logger.debug("insertaMovAtl():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	
	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws IssCusOrdException
	{
		ProductoContratadoListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerProductosContratadosVenta():start");
			resultado = service4.obtenerProductosContratadosVenta(venta);
			logger.debug("obtenerProductosContratadosVenta():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws IssCusOrdException
	{
		ProductoContratadoListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerProductoContratado():start");
			resultado = service4.obtenerProductoContratado(ordenServicio);
			logger.debug("obtenerProductoContratado():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * Este método es responsable de desactivar una lista de productos contratados.
	 * @param productos representa una lista de productos contratados (arreglo de objetos ProductoContratadoDTO).
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.
	 * @throws IssCusOrdException 
	 * @see com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub 
	 */
	public RetornoDTO desactivarProductoContratado(ProductoContratadoListDTO productos) throws IssCusOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("desactivarProductoContratado():start");
			resultado = service4.desactivarProductoContratado(productos);
			logger.debug("desactivarProductoContratado():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * Obtiene servicios contratatados
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws IssCusOrdException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServContrato():start");
			resultado = service3.obtenerServContrato(abonado);
			logger.debug("obtenerServContrato():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Registra servicios contratatados
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarServContrato():start");
			resultado = service3.registrarServContrato(abonado);
			logger.debug("registrarServContrato():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Obtener lista de bodegas
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws IssCusOrdException{
		BodegaListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaBodegas():start");
			resultado = service3.obtenerListaBodegas(param);
			logger.debug("obtenerListaBodegas():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Actualiza perfil del abonado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws IssCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarSituPerfil():start");
			resultado = service3.actualizarSituPerfil(abonado);
			logger.debug("actualizarSituPerfil():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Obtiene fecha desde cta segura
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws IssCusOrdException{
		IntarcelDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFecDesdeCtaSeg():start");
			retorno = service3.obtenerFecDesdeCtaSeg(intarcel);
			logger.debug("obtenerFecDesdeCtaSeg():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;		
	}	
	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CausaExcepcionListDTO obtenerCausaExcepcion() throws IssCusOrdException{
		CausaExcepcionListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerCausaExcepcion():start");
			resultado = service3.obtenerCausaExcepcion();
			logger.debug("obtenerCausaExcepcion():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws IssCusOrdException{
		ObtencionRolUsuarioDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerRolUsuario():start");
			resultado = service3.obtenerRolUsuario(obtRol);
			logger.debug("obtenerRolUsuario():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Quita Planes
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO quitarPlanes(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {		
//		051208 pv quitarPlanes,contratarPlanesPorDefecto,integrarCPUPDT,provisionarAbonado		
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("quitarPlanes():start");
			resultado = service5.quitarPlanes(integraCPUPDTDTO);
			logger.debug("quitarPlanes():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}

	/** 
	 * Contrata Planes Por Defecto
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO contratarPlanesPorDefecto(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("contratarPlanesPorDefecto():start");
			resultado = service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
			logger.debug("contratarPlanesPorDefecto():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Integra CPU con Productos
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO integrarCPUPDT(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("integrarCPUPDT():start");
			resultado = service5.integrarCPUPDT(integraCPUPDTDTO);
			logger.debug("integrarCPUPDT():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * Provisiona Abonado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO provisionarAbonado(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("provisionarAbonado():start");
			resultado = service5.provisionarAbonado(integraCPUPDTDTO);
			logger.debug("provisionarAbonado():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaContratarPlanesPorDefecto(ValidaIntegracionCPUPDTDTO valIntegraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		AbonadoDTO abonadoDTO =null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaContratarPlanesPorDefecto():start");
			IntegraCPUPDTDTO integraCPUPDTDTO=new IntegraCPUPDTDTO();
			integraCPUPDTDTO = (IntegraCPUPDTDTO)valIntegraCPUPDTDTO;
			
			abonadoDTO=new AbonadoDTO();
			abonadoDTO.setCodCliente(valIntegraCPUPDTDTO.getClienteDestino());
			abonadoDTO.setNumAbonado(valIntegraCPUPDTDTO.getAbonadoDestino());
			resultado=service5.validaPrimerAbonadoActivo(abonadoDTO);
			
			logger.debug("valIntegraCPUPDTDTO.getTipCliente()="+valIntegraCPUPDTDTO.getTipCliente());
			logger.debug("resultado.getDescripcion()="+resultado.getDescripcion());
			
			if ("I".equals(valIntegraCPUPDTDTO.getTipCliente())){
				resultado=service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
			}
			
			//(+) EV 04/02/09 Inc #145
			if ("0".equals(resultado.getDescripcion())){
				if ("E".equals(valIntegraCPUPDTDTO.getTipCliente())){
					integraCPUPDTDTO.setAbonadoDestino(Long.parseLong("0"));
					resultado=service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
				}
			}
			//(+) EV 28/01/09 Inc #125
			else{ //Aprovisionar
				provisionarAbonado(integraCPUPDTDTO);
			}
			//(-)
			
			/*if ("E".equals(valIntegraCPUPDTDTO.getTipCliente())){
				if ("0".equals(resultado.getDescripcion())){
					integraCPUPDTDTO.setAbonadoDestino(Long.parseLong("0"));
					resultado=service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
				}
				//(+) EV 28/01/09 Inc #125
				else{ //Aprovisionar
					provisionarAbonado(integraCPUPDTDTO);
				}
				//(-)
				
			}*/
			//(-) EV 04/02/09 Inc #145
			
			logger.debug("validaContratarPlanesPorDefecto():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaContratarPlanesPorDefectoReord(ValidaIntegracionCPUPDTDTO valIntegraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		AbonadoDTO abonadoDTO =null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaContratarPlanesPorDefecto():start");
			IntegraCPUPDTDTO integraCPUPDTDTO=new IntegraCPUPDTDTO();
			integraCPUPDTDTO = (IntegraCPUPDTDTO)valIntegraCPUPDTDTO;
			
			abonadoDTO=new AbonadoDTO();
			abonadoDTO.setCodCliente(valIntegraCPUPDTDTO.getClienteDestino());
			abonadoDTO.setNumAbonado(valIntegraCPUPDTDTO.getAbonadoDestino());
			resultado=service5.validaPrimerAbonadoActivo(abonadoDTO);
			
			logger.debug("valIntegraCPUPDTDTO.getTipCliente()="+valIntegraCPUPDTDTO.getTipCliente());
			logger.debug("resultado.getDescripcion()="+resultado.getDescripcion());
			
			//(+) EV 04/02/09 Inc #145
			if ("0".equals(resultado.getDescripcion())){
				if ("E".equals(valIntegraCPUPDTDTO.getTipCliente())){
					integraCPUPDTDTO.setAbonadoDestino(Long.parseLong("0"));
					resultado=service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
				}
			}
			else{ //Aprovisionar
				provisionarAbonado(integraCPUPDTDTO);
			}
			
			/*if ("E".equals(valIntegraCPUPDTDTO.getTipCliente())){
				if ("0".equals(resultado.getDescripcion())){
					integraCPUPDTDTO.setAbonadoDestino(Long.parseLong("0"));
					resultado=service5.contratarPlanesPorDefecto(integraCPUPDTDTO);
				}
				else{ //Aprovisionar
					provisionarAbonado(integraCPUPDTDTO);
				}
			}*/
			//(-) EV 04/02/09 Inc #145
			
			logger.debug("validaContratarPlanesPorDefecto():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaAbonadosActivos(ValidaIntegracionCPUPDTDTO valIntegraCPUPDTDTO) throws IssCusOrdException {		
		RetornoDTO resultado = null;
		AbonadoDTO abonadoDTO =null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAbonadosActivos():start");
			IntegraCPUPDTDTO integraCPUPDTDTO=new IntegraCPUPDTDTO();
			integraCPUPDTDTO = (IntegraCPUPDTDTO)valIntegraCPUPDTDTO;
			abonadoDTO=new AbonadoDTO();
			abonadoDTO.setCodCliente(valIntegraCPUPDTDTO.getClienteOrigen());
			abonadoDTO.setNumAbonado(valIntegraCPUPDTDTO.getAbonadoOrigen());
			resultado=service5.validaPrimerAbonadoActivo(abonadoDTO);
			/**
			 * @Description No tiene mas abonados activos
			 */
			if ("0".equals(resultado.getDescripcion())){
					integraCPUPDTDTO.setAbonadoOrigen(0); //EV 28/01/09 inc #125
					resultado=service5.quitarPlanes(integraCPUPDTDTO);
			}
			
			logger.debug("validaAbonadosActivos():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return resultado;
	}
	
	
	/** 
	 * Actualiza Actabo a PI INC 147444 HOM
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaGaIntarcelAccionesTo(IntarcelDTO intarcel) throws IssCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaGaIntarcelAccionesTo():start");
			retorno=service3.actualizaGaIntarcelAccionesTo(intarcel);
			logger.debug("actualizaGaIntarcelAccionesTo():end");
		} catch(IssCusOrdException e){
			logger.debug("IssCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssCusOrdException(e);
		}
		return retorno;
	}	
	//Fin INC 147444 HOM
	
	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/** 
	 * Obtener lista de bodegas
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		this.context=arg0;
	}

	/**
	 * 
	 */
	public IssCusOrdFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
