/**
 * 
 */
package com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.GestionViabilidadSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces.GestionViabilidadSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces.GestionViabilidadSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="DetCusOrdFeaFacade"	
 *           description="An EJB named DetCusOrdFeaFacade"
 *           display-name="DetCusOrdFeaFacade"
 *           jndi-name="DetCusOrdFeaFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class DetCusOrdFeaFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(DetCusOrdFeaFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionViabilidadSrvFactoryIF factorySrv2 = new GestionViabilidadSrvFactory();

	// Obtiene el application service
	GestionViabilidadSrvIF service2= factorySrv2.getApplicationService1();
	
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
	 * Actualiza la cantidad de abonados en el tabla ge_clientes
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaCantAboCliente():start");
			retorno = service2.actualizaCantAboCliente(cliente);
			logger.debug("actualizaCantAboCliente():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;		
	}
	
	/** 
	 * Obtiene fecha y periodo de facturación de ciclo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws DetCusOrdFeaException{
		CicloDTO respuesta = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFechaCiclo():start");
			respuesta = service2.obtenerFechaCiclo(ciclo);
			logger.debug("obtenerFechaCiclo():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return respuesta;				
	}
	
	/** 
	 * Obtiene fecha y periodo de facturación de ciclo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws DetCusOrdFeaException{	
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaRestriccionComerOoss():start");
			retorno = service2.validaRestriccionComerOoss(restricciones);
			logger.debug("validaRestriccionComerOoss():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public void solicitarEvaluacionCrediticia() {
	}
	
	/** 
	 *  Valida si posee plan freedom
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaFreedom():start");
			retorno = service2.validaFreedom(cliente);
			logger.debug("validaFreedom():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;
	}
	
	/** 
	 * Valida los cambios de plan pendientes a ciclo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValidaOOSSDTO validaOossPendPlan(ValidaOOSSDTO ordenServicio) throws DetCusOrdFeaException{	
		ValidaOOSSDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaOossPendPlan():start");
			retorno = service2.validaOossPendPlan(ordenServicio);
			logger.debug("validaOossPendPlan():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retorno;	
	}
	
	/** 
	 * Valida perido de facturacion
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validarPeriodoFact():start");
			retorno = service2.validarPeriodoFact(abonado);
			logger.debug("validarPeriodoFact():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registro)throws DetCusOrdFeaException{
		RegistroFacturacionDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("aplicaImpuestoImporte():start");
			retorno = service2.aplicaImpuestoImporte(registro);
			logger.debug("aplicaImpuestoImporte():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registro)throws DetCusOrdFeaException{
		RegistroFacturacionDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getDiasProrrateo():start");
			retorno = service2.getDiasProrrateo(registro);
			logger.debug("getDiasProrrateo():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public RetornoDTO ejecutaPLRestricciones(RestriccionesDTO restricciones)throws DetCusOrdFeaException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("ejecutaPLRestricciones():start");
			retorno = service2.ejecutaPLRestricciones(restricciones);
			logger.debug("ejecutaPLRestricciones():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public String getCodigoOperadora()throws DetCusOrdFeaException{
		String retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCodigoOperadora():start");
			retorno = service2.getCodigoOperadora();
			logger.debug("getCodigoOperadora():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	
	public DatosVentaOutDTO getCodOficinaXVendedor(DatosVentaOutDTO entrada) throws DetCusOrdFeaException{
		DatosVentaOutDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCodOficinaXVendedor():start");
			retorno = service2.getCodOficinaXVendedor(entrada);
			logger.debug("getCodOficinaXVendedor():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("DetCusOrdFeaException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
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
	public String foo(String param) {
		return null;
	}

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

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		this.context=arg0;

	}

	/**
	 * 
	 */
	public DetCusOrdFeaFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
