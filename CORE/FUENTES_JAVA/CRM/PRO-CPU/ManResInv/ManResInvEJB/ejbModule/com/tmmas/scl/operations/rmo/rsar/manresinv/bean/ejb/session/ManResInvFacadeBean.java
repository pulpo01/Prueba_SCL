/**
 * 
 */
package com.tmmas.scl.operations.rmo.rsar.manresinv.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.operations.rmo.rsar.manresinv.bean.ejb.helper.Global;
import com.tmmas.scl.operations.rmo.rsar.manresinv.common.exception.ManResInvException;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.GestionListasPlataformaSrvFactory;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces.GestionListasPlataformaSrvFactoryIF;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces.GestionListasPlataformaSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManResInvFacade"	
 *           description="An EJB named ManResInvFacade"
 *           display-name="ManResInvFacade"
 *           jndi-name="ManResInvFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManResInvFacadeBean implements javax.ejb.SessionBean 
{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(ManResInvFacadeBean.class);	
	private Global global = Global.getInstance();
	
	GestionListasPlataformaSrvFactoryIF factorySrv1 = new GestionListasPlataformaSrvFactory();
	GestionListasPlataformaSrvIF service1 = factorySrv1.getApplicationService1();


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
		
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
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
	public RetornoDTO crearFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException 
	{
		RetornoDTO resultado = null;
		try{
			logger.debug("crearFrecuentesAltamira():start");
			resultado = service1.crearFrecuentesAltamira(frecAltDTO);
			logger.debug("crearFrecuentesAltamira():end");
		} catch(ManResInvException e){
			logger.debug("ManResInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManResInvException(e);
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
	public RetornoDTO eliminarFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException 
	{
		RetornoDTO resultado = null;
		try{
			logger.debug("eliminarFrecuentesAltamira():start");
			resultado = service1.eliminarFrecuentesAltamira(frecAltDTO);
			logger.debug("eliminarFrecuentesAltamira():end");
		} catch(ManResInvException e){
			logger.debug("ManResInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManResInvException(e);
		}
		return resultado;
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
	public ManResInvFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
