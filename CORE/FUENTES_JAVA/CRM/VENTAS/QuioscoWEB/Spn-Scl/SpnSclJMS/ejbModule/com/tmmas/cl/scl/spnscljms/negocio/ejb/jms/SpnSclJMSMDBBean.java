/**
 * 
 */
package com.tmmas.cl.scl.spnscljms.negocio.ejb.jms;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.processmgr.AsyncProcessStarterXdocletMDBBean;



/**
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="SpnSclJMSMDB" 
 *     acknowledge-mode="Auto-acknowledge"
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *     destination-jndi-name="SpnSclJMSMDB"
 *
 *  @ejb.transaction="Supports"
 *  
 *  @weblogic.message-driven connection-factory-jndi-name = "com.tmmas.cl.scl.portabilidad.jms.ConnectionFactory"
 *  @weblogic.message-driven destination-jndi-name = "com.tmmas.cl.scl.jms.queue.portabilidad"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 **/

public class SpnSclJMSMDBBean implements javax.ejb.MessageDrivenBean,
		javax.jms.MessageListener {

	
	 private final Logger logger = Logger.getLogger(SpnSclJMSMDBBean.class); 	
	 private CompositeConfiguration config;
	
	
	/** 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * The context for the message-driven bean, set by the EJB container. 
	 * @generated
	 */
	private javax.ejb.MessageDrivenContext messageContext = null;

	/** 
	 * Required method for container to set context.
	 * @generated 
	 */
	public void setMessageDrivenContext(
			javax.ejb.MessageDrivenContext messageContext)
			throws javax.ejb.EJBException {
		this.messageContext = messageContext;
	}

	/** 
	 * Required creation method for message-driven beans. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.create-method 
	 * <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void ejbCreate() {
		//no specific action required for message-driven beans 
	}

	/** 
	 * Required removal method for message-driven beans. 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void ejbRemove() {
		messageContext = null;
	}

	/** 
	 * This method implements the business logic for the EJB. 
	 * 
	 * <p>Make sure that the business logic accounts for asynchronous message processing. 
	 * For example, it cannot be assumed that the EJB receives messages in the order they were 
	 * sent by the client. Instance pooling within the container means that messages are not 
	 * received or processed in a sequential order, although individual onMessage() calls to 
	 * a given message-driven bean instance are serialized. 
	 * 
	 * <p>The <code>onMessage()</code> method is required, and must take a single parameter 
	 * of type javax.jms.Message. The throws clause (if used) must not include an application 
	 * exception. Must not be declared as final or static. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void onMessage(javax.jms.Message message) {
		 //UtilLog.setLog(config.getString("OperacionMDBBean.log"));
		   logger.debug("onMessage():start");
		   try{
		   AsyncProcessStarterXdocletMDBBean jms = new AsyncProcessStarterXdocletMDBBean(messageContext);		   
		   jms.onMessage(message);
		   
		   logger.debug("onMessage():end");
		  } catch (Exception e) {
			  logger.debug("Exception", e);
			  messageContext.setRollbackOnly();
		  }
	}

	/**
	 * 
	 */
	public SpnSclJMSMDBBean() {
		// TODO Auto-generated constructor stub
	}
	
	
		
	
	
}
