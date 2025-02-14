/**
 * 
 */
package com.tmmas.cl.scl.pv.customerorder.service.servicios;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.BillingProductCharge.BillingProductCharge.service.servicios.BillingProductChargeSrv;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CargosRecCliAboDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="BillingProductChargeFacadeSTL"	
 *           description="An EJB named BillingProductChargeFacadeSTL"
 *           display-name="BillingProductChargeFacadeSTL"
 *           jndi-name="BillingProductChargeFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class BillingProductChargeFacadeSTLBean implements javax.ejb.SessionBean {
	
	private BillingProductChargeSrv service = new BillingProductChargeSrv();
	private static final long serialVersionUID = 1L;

	private final Logger logger = Logger.getLogger(BillingProductChargeFacadeSTLBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;	
	
	public BillingProductChargeFacadeSTLBean() 
	{
		logger.debug("BillingProductChargeFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("DistribucionBolsa.properties");
		UtilLog.setLog(config.getString("BillingProductChargeEJB.log"));
		logger.debug("BillingProductChargeFacadeSTLBean():End");
	}	

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
	public void setBillingProductCharge(CargosRecCliAboDTO list) 
		throws BillingProductChargeException, RemoteException
	{
		logger.debug("setBillingProductCharge():start");
		try
		{
			service.setBillingProductCharge(list);
		}
		catch(BillingProductChargeException e)
		{
			context.setRollbackOnly();
			logger.debug("setBillingProductCharge():Error [BillingProductChargeException e]");
			e.printStackTrace();
			throw e;
		}
		catch(Exception e)
		{
			context.setRollbackOnly();
			logger.debug("setBillingProductCharge():Error [Exception e]");
			e.printStackTrace();
			throw new BillingProductChargeException("Error al ejecutar la el servicio setBillingProductCharge", e);
		}
		logger.debug("setBillingProductCharge():end");
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

	
}
