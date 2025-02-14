/**
 * 
 */
package com.tmmas.scl.operations.smo.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;
import com.tmmas.scl.operations.smo.bean.ejb.helper.Global;
import com.tmmas.scl.operations.smo.delegate.IssSerOrdDelegate;
import com.tmmas.scl.operations.smo.delegate.ManSerInvDelegate;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SerManOpeFacade"	
 *           description="An EJB named SerManOpeFacade"
 *           display-name="SerManOpeFacade"
 *           jndi-name="SerManOpeFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class SerManOpeFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(SerManOpeFacadeBean.class);	
	private Global global=Global.getInstance(); 
	
	private IssSerOrdDelegate issSerOrdDel=new IssSerOrdDelegate();
	private ManSerInvDelegate manSerInvDelegate=new ManSerInvDelegate();
	
	
	
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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public SerManOpeFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
	/*****************************************************************************************************/
	 
	 /** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws IssSerOrdException, RemoteException
	{
		return issSerOrdDel.obtenerPlanesTasacion();
	}
	
	/******************************************************************************************************/
	 
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws ManSerInvException
	{
		return manSerInvDelegate.obtenerSaldosProducto(productoCliente);
	}
	/*****************************************************************************************************/
}
