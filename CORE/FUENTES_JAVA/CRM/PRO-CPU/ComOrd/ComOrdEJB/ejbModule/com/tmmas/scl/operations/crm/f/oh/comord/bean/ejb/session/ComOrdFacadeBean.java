/**
 * 
 */
package com.tmmas.scl.operations.crm.f.oh.comord.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaServiciosDefaultDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServiciosDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.operations.crm.f.oh.comord.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.comord.common.exception.ComOrdException;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.GestionComplementoOrdenSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces.GestionComplementoOrdenSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces.GestionComplementoOrdenSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ComOrdFacade"	
 *           description="An EJB named ComOrdFacade"
 *           display-name="ComOrdFacade"
 *           jndi-name="ComOrdFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ComOrdFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(ComOrdFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionComplementoOrdenSrvFactoryIF factorySrv2 = new GestionComplementoOrdenSrvFactory();

	GestionComplementoOrdenSrvIF service2 = factorySrv2.getApplicationService1();
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
	 * Obtiene los servicios por default
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ServiciosDTO obtenerServiciosDefaultPlan(BusquedaServiciosDefaultDTO param) throws ComOrdException{
		ServiciosDTO servicios = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServiciosDefaultPlan():start");
			servicios = service2.obtenerServiciosDefaultPlan(param);
			logger.debug("obtenerServiciosDefaultPlan():end");
		} catch(ComOrdException e){
			logger.debug("ComOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
		}
		return servicios;
	}	
	
	/** 
	 * Valida servicios a activar y desactivar
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param) throws ComOrdException{
		RegistroServiciosListDTO servicios = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaServicioActDesc():start");
			servicios = service2.validaServicioActDesc(param);
			logger.debug("validaServicioActDesc():end");
		} catch(ComOrdException e){
			logger.debug("ComOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
		}
		return servicios;
	}
	
	/** 
	 *  Inserta Registro de intarcel
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertaIntarcelAcciones(IntarcelDTO intarcel) throws ComOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");	
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("insertaIntarcelAcciones():start");
			resultado = service2.insertaIntarcelAcciones(intarcel);
			logger.debug("insertaIntarcelAcciones():end");
		} catch(ComOrdException e){
			logger.debug("ComOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ComOrdException(e);
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
		// TODO Auto-generated method stub

	}

	/**
	 * 
	 */
	public ComOrdFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
