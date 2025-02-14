/**
 * 
 */
package com.tmmas.scl.operations.smo.bean.ejb.session;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.smo.bean.ejb.helper.Global;
import com.tmmas.scl.operations.smo.common.exception.SerManOpeWSException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SerManOpeWSFacade"	
 *           description="An EJB named SerManOpeWSFacade"
 *           display-name="SerManOpeWSFacade"
 *           jndi-name="SerManOpeWSFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */



public class SerManOpeWSFacadeBean implements javax.ejb.SessionBean {

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(SerManOpeWSFacadeBean.class);	
	private Global global=Global.getInstance(); 
	private SerManOpeFacade serManOpeFacade=null;
	
	public void ejbCreate() 
	{
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
	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws SerManOpeWSException, RemoteException
	{
		try{
			return getSerManOpeFacade().obtenerPlanesTasacion();
		}
		catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new SerManOpeWSException(e);
		}
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
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws SerManOpeWSException,RemoteException
	{
		try{
			return getSerManOpeFacade().obtenerSaldosProducto(productoCliente);
		}catch(GeneralException e){
			logger.debug("GeneralException", e);
			this.context.setRollbackOnly();
			throw new SerManOpeWSException(e);
		}
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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public SerManOpeWSFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
	public SerManOpeFacade getSerManOpeFacade() throws SerManOpeWSException 
	{
		try 
		{
			if(serManOpeFacade==null)
			{
				String urlProvider = global.getValor("url.SerManOpeEJBProvider");
				String 	EJBJndi =global.getValor("jndi.SerManOpeFacade");
				Hashtable env=null;
				Object obj=null;
			 	env = new Hashtable();
				logger.debug("Instanciando EJB ["+EJBJndi+"]");
				env.put(Context.INITIAL_CONTEXT_FACTORY, global.getValor("initial.context.factory"));		
				env.put(Context.SECURITY_PRINCIPAL, global.getValor("security.principal"));
				env.put(Context.SECURITY_CREDENTIALS, global.getValor("security.credentials"));
				env.put(Context.PROVIDER_URL, urlProvider);

				Context context = new InitialContext(env);			
				obj = context.lookup(EJBJndi);
				logger.debug("EJB ["+EJBJndi+"] instanciando");	
				SerManOpeFacadeHome home =(SerManOpeFacadeHome) PortableRemoteObject.narrow(obj, SerManOpeFacadeHome.class);		
				serManOpeFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new SerManOpeWSException(e);			
		}		
		return serManOpeFacade;
	}
}
