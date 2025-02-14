/**
 * 
 */
package com.tmmas.cl.scl.ss911correofax.negocio.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.srv.ServSupl911CorreoFaxSRV;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ServSupl911CorreoFaxFacade"	
 *           description="An EJB named ServSupl911CorreoFaxFacade"
 *           display-name="ServSupl911CorreoFaxFacade"
 *           jndi-name="ServSupl911CorreoFaxFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public  class ServSupl911CorreoFaxFacadeBean implements
		javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	private Logger logger =Logger.getLogger(this.getClass());
	private SessionContext context;
	private CompositeConfiguration config;
	private ServSupl911CorreoFaxSRV servSupl911CorreoFaxSRV= new ServSupl911CorreoFaxSRV();
	
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
			this.context= arg0;

	}

	/**
	 * 
	 */
	public ServSupl911CorreoFaxFacadeBean() {
		// TODO Auto-generated constructor stub
		config = UtilProperty.getConfiguration("ServSupl911CorreoFax.properties","com/tmmas/cl/scl/ss911correofax/propiedades/ServSupl911CorreoFaxFacadeEJB.properties");
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));	
		logger.debug("ServSupl911CorreoFaxFacadeBean():End");
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
	public void insertGaContactoAbonadoTO(GaContactoAbonadoToDTO gaContactoAbonadoTO) 
		throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("insertGaContactoAbonadoTO():start");		
		try{
			logger.debug("start: insertGaContactoAbonadoTO");			
			servSupl911CorreoFaxSRV.insertUpdateDeleteGaContactoAbonadoTO(gaContactoAbonadoTO);
			logger.debug("end: insertGaContactoAbonadoTO");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("insertGaContactoAbonadoTO():end");		
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
	public CodigosDTO[] getListCodigos(CodigosDTO entrada) 
		throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("getListCodigos():start");		
		CodigosDTO[] retValue = null;
		try{
			logger.debug("start: insertGaContactoAbonadoTO");			
			retValue = servSupl911CorreoFaxSRV.getListCodigos(entrada);
			logger.debug("end: insertGaContactoAbonadoTO");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListCodigos():end");
		return retValue;
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
	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT contactoAbonadoTT) throws GeneralException{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("obtenerListaContactos():start");		
		ContactoAbonadoTT[] retValue = null;
		try{
			logger.debug("start: obtenerListaContactos");			
			retValue = servSupl911CorreoFaxSRV.obtenerListaContactos(contactoAbonadoTT);
			logger.debug("end: obtenerListaContactos");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerListaContactos():end");
		return retValue;
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
	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] contactoAbonadoTTs) throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("deleteInsertPvContactoAbonadoTT():start");		
		try{
			logger.debug("start: deleteInsertPvContactoAbonadoTT");			
			servSupl911CorreoFaxSRV.deleteInsertPvContactoAbonadoTT(contactoAbonadoTTs);
			logger.debug("end: deleteInsertPvContactoAbonadoTT");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("deleteInsertPvContactoAbonadoTT():end");		
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
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("getParametroGeneral():start");		
		ParametrosGeneralesDTO retorno = null;
		try{
			logger.debug("start: getParametroGeneral");			
			retorno = servSupl911CorreoFaxSRV.getParametroGeneral(entrada);
			logger.debug("end: getParametroGeneral");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getParametroGeneral():end");		
		return retorno;
	}
	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setDireccion(DireccionNegocioWebDTO entrada) throws GeneralException	{
		
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("setDireccion():start");		
		try{
			logger.debug("start: setDireccion");			
			servSupl911CorreoFaxSRV.setDireccion(entrada);
			logger.debug("end: setDireccion");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("setDireccion():end");
		
	} // setDireccion
	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setGaContTHDelGaContTO_DelDireccion(GaContactoAbonadoTO gaContactoAbonadoTO)throws GeneralException{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));
		logger.debug("setGaContTHDelGaContTO_DelDireccion():start");		
		try{
			logger.debug("start: setGaContTHDelGaContTO_DelDireccion");			
			servSupl911CorreoFaxSRV.setGaContTHDelGaContTO_DelDireccion(gaContactoAbonadoTO);
			logger.debug("end: setDireccion");
		}
		catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw(e);
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxFacadeEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("setGaContTHDelGaContTO_DelDireccion():end");
	}
}
