/**
 * 
 */
package com.tmmas.cl.scl.spnscljms.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.jms.QueueSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaJMSDTO;
import com.tmmas.cl.scl.spnscljms.negocio.ejb.cmd.AltaDeLineaQueueCMD;
import com.tmmas.cl.scl.spnscljms.negocio.ejb.cmd.PruebaQueueCMD;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SpnSclJMS"	
 *           description="An EJB named SpnSclJMS"
 *           display-name="SpnSclJMS"
 *           jndi-name="SpnSclJMS"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class SpnSclJMSBean implements javax.ejb.SessionBean {
	
	private SessionContext context = null;
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(SpnSclJMSBean.class);
	
	

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
		context = arg0;

	}

	/**
	 * 
	 */
	public SpnSclJMSBean() {
		System.out.println("SpnSclJMSBean(): Start");
		config = UtilProperty.getConfiguration("SpnSclJMSBean.properties","com/tmmas/cl/scl/spnscljms/negocio/ejb/properties/SpnSclJMSBean.properties");
		UtilLog.setLog(config.getString("SpnSclJMSBean.log"));
		logger.debug("SpnSclJMSBean():End");
	}
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void pruebaJMS(String cierreVenta){
		
		UtilLog.setLog(config.getString("SpnSclJMSBean.log"));
		
		AsyncProcessParameterObject parametro = new AsyncProcessParameterObject();
		logger.debug("cierreVentaWS():start");  
		try{														
				parametro.setArgumentsData(cierreVenta);
				PruebaQueueCMD generaQuueeCmd = new PruebaQueueCMD(parametro);			
				logger.debug("Genero objeto MessagePuSerializableblisher -> Factory :" +config.getString("jndi.factory")+ " Queue :" + config.getString("jndi.jms.queue"));			
				MessagePublisher messagePublisher = new MessagePublisher(config.getString("jndi.factory"), config.getString("jndi.jms.queue"));						
				messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
				
			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclJMSBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}		
				
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void AltaDeLineaJMS(WsCunetaAltaDeLineaDTO CunetaAltaDeLinea, int rollback){
		
		UtilLog.setLog(config.getString("SpnSclJMSBean.log"));
		WsCunetaAltaDeLineaJMSDTO  CunetaAltaDeLineaJMS = new  WsCunetaAltaDeLineaJMSDTO();
		AsyncProcessParameterObject parametro = new AsyncProcessParameterObject();
		logger.debug("cierreVentaWS():start");  
		try{					
			
			    CunetaAltaDeLineaJMS.setCunetaAltaDeLinea(CunetaAltaDeLinea);
			    CunetaAltaDeLineaJMS.setRollback(rollback);
			    
				parametro.setArgumentsData(CunetaAltaDeLineaJMS);
				AltaDeLineaQueueCMD generaQuueeCmd = new AltaDeLineaQueueCMD(parametro);			
				logger.debug("Genero objeto MessagePuSerializableblisher -> Factory :" +config.getString("jndi.factory")+ " Queue :" + config.getString("jndi.jms.queue"));			
				MessagePublisher messagePublisher = new MessagePublisher(config.getString("jndi.factory"), config.getString("jndi.jms.queue"));						
				messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
				
			
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclJMSBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}		
				
	}		
	
	
	
}
