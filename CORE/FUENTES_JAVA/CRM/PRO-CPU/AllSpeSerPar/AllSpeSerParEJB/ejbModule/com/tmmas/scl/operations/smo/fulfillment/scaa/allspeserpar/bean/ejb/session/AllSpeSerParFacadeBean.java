/**
 * 
 */
package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.helper.Global;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.common.exception.AllSpeSerParException;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.GestionProvisionamientoSrvFactory;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces.GestionProvisionamientoSrvFactoryIT;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces.GestionProvisionamientoSrvIT;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="AllSpeSerParFacade"	
 *           description="An EJB named AllSpeSerParFacade"
 *           display-name="AllSpeSerParFacade"
 *           jndi-name="AllSpeSerParFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public  class AllSpeSerParFacadeBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(AllSpeSerParFacadeBean.class);	
	private Global global = Global.getInstance();
	
	private GestionProvisionamientoSrvFactoryIT factorySrv1=new GestionProvisionamientoSrvFactory();
	private GestionProvisionamientoSrvIT service1=factorySrv1.getAplicationService1();
	
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
	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws AllSpeSerParException
	{
		EspecProvisionamientoListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerEspecificacionesProvisionamiento():start");
			resultado = service1.obtenerEspecificacionesProvisionamiento(espSerCliList);
			logger.debug("obtenerEspecificacionesProvisionamiento():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AllSpeSerParException(e);
		}
		return resultado;
	}

	/**
	 * 
	 */
	public AllSpeSerParFacadeBean() {
		// TODO Auto-generated constructor stub
	}

	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}
}
