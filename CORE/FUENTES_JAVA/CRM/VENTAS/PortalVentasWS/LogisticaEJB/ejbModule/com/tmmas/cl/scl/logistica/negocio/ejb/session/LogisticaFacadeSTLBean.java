/**
 * 
 */
package com.tmmas.cl.scl.logistica.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.LogisticaException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.logistica.service.servicios.LogisticaSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="LogisticaFacadeSTL"	
 *           description="An EJB named LogisticaFacadeSTL"
 *           display-name="LogisticaFacadeSTL"
 *           jndi-name="LogisticaFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class LogisticaFacadeSTLBean implements javax.ejb.SessionBean {
	
	private static final long serialVersionUID = 1L;	
	private LogisticaSrv srv = new LogisticaSrv();
	private final Logger logger = Logger.getLogger(LogisticaFacadeSTLBean.class);
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
	public ResultadoValidacionLogisticaDTO validacionesSerieTerminal(ParametrosValidacionLogisticaDTO parametrosEntrada)
	throws LogisticaException, RemoteException{
		
		logger.debug("validacionesSerieTerminal:start");
		ResultadoValidacionLogisticaDTO ret; 
		try {
			ret = srv.validacionesSerieTerminal(parametrosEntrada);
		}
		catch(ProductDomainException e){
			logger.debug("validacionesSerieTerminal:end");
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new LogisticaException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new LogisticaException(e);
		}
		logger.debug("validacionesSerieTerminal:end");
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
	public ResultadoValidacionLogisticaDTO validacionesSerieSimcard(ParametrosValidacionLogisticaDTO parametrosEntrada)
		throws LogisticaException, RemoteException
	{	
		logger.debug("validacionesSerieSimcard:start");
		ResultadoValidacionLogisticaDTO ret; 
		try {
			ret = srv.validacionesSerieSimcard(parametrosEntrada);
		}
		catch(ProductDomainException e){
			logger.debug("validacionesSerieSimcard:end");
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new LogisticaException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new LogisticaException(e);
		}
		logger.debug("validacionesSerieSimcard:end");
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
	public LogisticaFacadeSTLBean() 
	{
		logger.debug("LogisticaFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("LogisticaEJB.log"));
		logger.debug("LogisticaFacadeSTLBean():End");
	}
}
