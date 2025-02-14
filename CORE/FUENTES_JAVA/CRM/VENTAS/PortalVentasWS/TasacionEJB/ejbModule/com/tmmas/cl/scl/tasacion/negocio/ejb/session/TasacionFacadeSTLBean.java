/**
 * 
 */
package com.tmmas.cl.scl.tasacion.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.TasacionException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.tasacion.service.servicios.TasacionSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="TasacionFacadeSTL"	
 *           description="An EJB named TasacionFacadeSTL"
 *           display-name="TasacionFacadeSTL"
 *           jndi-name="TasacionFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class TasacionFacadeSTLBean implements javax.ejb.SessionBean {
	
	private static final long serialVersionUID = 1L;
	private TasacionSrv srv = new TasacionSrv();
	private final Logger logger = Logger.getLogger(TasacionFacadeSTLBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;

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
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoValidacionTasacionDTO validacionLinea(ParametrosValidacionTasacionDTO parametrosEntrada)
	throws TasacionException, RemoteException	
	{
		logger.debug("validacionLinea:start");
		ResultadoValidacionTasacionDTO ret; 
		try {
			ret = srv.validacionLinea(parametrosEntrada);
		}
		catch(ProductDomainException e){
			logger.debug("validacionLinea:end");
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TasacionException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(CustomerDomainException e){
			logger.debug("validacionLinea:end");
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TasacionException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TasacionException(e);
		}
		logger.debug("validacionLinea:end");
		return ret;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO parametroEntrada)
	throws TasacionException, RemoteException
	{
		logger.debug("getPlanTarifario:start");
		PlanTarifarioDTO ret; 
		try {
			ret = srv.getPlanTarifario(parametroEntrada);
		}
		catch(ProductDomainException e){
			logger.debug("getPlanTarifario:end");
			logger.debug("TasacionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TasacionException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TasacionException(e);
		}
		logger.debug("getPlanTarifario:end");
		return ret;
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
		context = arg0;
	}

	/**
	 * 
	 */
	public TasacionFacadeSTLBean() 
	{
		logger.debug("TasacionFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("TasacionEJB.log"));
		logger.debug("TasacionFacadeSTLBean():End");	
	}
}
