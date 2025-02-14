/**
 * 
 */
package com.tmmas.scl.operations.crm.f.sel.negsal.soa.bean.ejb.jms;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.processmgr.AsyncProcessStarterXdocletMDBBean;
import com.tmmas.scl.operations.crm.f.sel.negsal.soa.bean.ejb.helper.Global;





 
/**
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="VentaMDB" 
 *     acknowledge-mode="Auto-acknowledge"
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *     destination-jndi-name="VentaMDB"
 *
 *  @ejb.transaction="Supports"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 **/

public class VentaMDBBean implements javax.ejb.MessageDrivenBean,
		javax.jms.MessageListener {

	private static final long serialVersionUID = 1L;
	
	transient private final Logger logger = Logger.getLogger(VentaMDBBean.class);	
	
	//transient private Global global = Global.getInstance();
	
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
		//String log = global.getValor("soa.log");
		//log = global.getPathInstancia() + log;
		//PropertyConfigurator.configure(log);
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
		try {
			Global global = Global.getInstance();
			System.out.println("VentaMDBBean mod071009 onMessage ini========>");
			String log = global.getValor("soa.log");
			System.out.println("global.getValor(soa.log)log ==>["+log+"]");
			log = global.getPathInstancia() + log;
			System.out.println("global.getPathInstancia()+log ==>["+log+"]");
			PropertyConfigurator.configure(log);
			System.out.println("onMessage():start");
			logger.debug("onMessage():start VentaMDBBean mod071009 ini========>");
			System.out.println("mensaje[" + message.getClass().getName() + "]");
			logger.debug("mensaje[" + message.getClass().getName() + "]");
			//logger.debug("messageContext: "+messageContext);
			AsyncProcessStarterXdocletMDBBean jms = new AsyncProcessStarterXdocletMDBBean(messageContext); 
			jms.onMessage(message);
			logger.debug("onMessage():end");
			System.out.println("VentaMDBBean mod220709 onMessage fin========>");
		} catch (Exception e) {
			logger.debug("Exception", e);
			//messageContext.setRollbackOnly();
	
		}
	}

	/**
	 * 
	 */
	public VentaMDBBean() {
		// TODO Auto-generated constructor stub
	}
}
