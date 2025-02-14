/**
 * 
 */
package com.tmmas.scl.operations.crm.o.csr.manserinv.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.operations.crm.o.csr.manserinv.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.SaldosProductoSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces.SaldosProductoSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces.SaldosProductoSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManSerInvFacade"	
 *           description="An EJB named ManSerInvFacade"
 *           display-name="ManSerInvFacade"
 *           jndi-name="ManSerInvFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManSerInvFacadeBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SaldosProductoSrvFactoryIF saldSrvFactory=new SaldosProductoSrvFactory();
	private SaldosProductoSrvIF saldosProSrv = saldSrvFactory.getApplicationService1();
	private final Logger logger = Logger.getLogger(ManSerInvFacadeBean.class);	
	private Global global=Global.getInstance(); 
	
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
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws ManSerInvException 
	{
		logger.debug("obtenerSaldosProducto");
		
		
		SaldoProductoTasacionListDTO retorno=null;		
		try {
			retorno= saldosProSrv.obtenerSaldosProducto(productoCliente);
			logger.debug("obtenerSaldosProducto OK");
		}
		catch (Exception e) 
		{			
			logger.error(e);
			throw new ManSerInvException(e);
		}
		return retorno;
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
	public ManSerInvFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
