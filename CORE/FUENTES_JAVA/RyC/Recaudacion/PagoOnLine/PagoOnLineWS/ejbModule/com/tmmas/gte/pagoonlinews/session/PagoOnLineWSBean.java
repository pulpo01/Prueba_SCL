/**
 * 
 */
package com.tmmas.gte.pagoonlinews.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import javax.ejb.CreateException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework.helper.CrearGeneralSoapException;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

import com.tmmas.gte.pagoonlineejb.session.PagoOnLineFacade;
import com.tmmas.gte.pagoonlineejb.session.PagoOnLineFacadeHome;
import com.tmmas.cl.framework.util.ServiceLocator;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="PagoOnLineWS"	
 *           description="An EJB named PagoOnLineWS"
 *           display-name="PagoOnLineWS"
 *           jndi-name="PagoOnLineWS"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class PagoOnLineWSBean implements javax.ejb.SessionBean {
	
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(PagoOnLineWSBean.class);
	private CompositeConfiguration config;	
	//private Global global = Global.getInstance();
		

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
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO aplicarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.PagoDTO inParam0) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
		
		UtilLog.setLog(config.getString("PagoOnLineWS.log"));
		//PagoOnLineFacade facade = getPagoOnLineFacade();
		
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO ();
		logger.debug("aplicarPagoOnLine():start");	
		String urlMsg = config.getString("url.msg");
		
		try {
			 respuesta = getPagoOnLineFacade().aplicarPagoOnLine(inParam0);
			  } catch (com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException e) {
			   String log = StackTraceUtl.getStackTrace(e);
			   logger.debug("PagoOnLineException[" + log + "]");
			   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","aplicarPagoOnLine fallo",urlMsg, e);
			   throw errorSoap.obtenerGeneralSoapException();
			  } catch (RemoteException e) {
				   String log = StackTraceUtl.getStackTrace(e);
				   logger.debug("PagoOnLineException[" + log + "]");
				   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","aplicarPagoOnLine fallo",urlMsg, e);
				   throw errorSoap.obtenerGeneralSoapException();
			  }catch (Exception e) {
				   String log = StackTraceUtl.getStackTrace(e);
				   logger.debug("PagoOnLineException[" + log + "]");
				   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","aplicarPagoOnLine fallo",urlMsg, e);
				   throw errorSoap.obtenerGeneralSoapException();
			  }
			  logger.debug("aplicarPagoOnLine():end");
			  return respuesta;
	  
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
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO reversarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.ReversaDTO inParam0) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
		
		UtilLog.setLog(config.getString("PagoOnLineWS.log"));
		//PagoOnLineFacade facade = getPagoOnLineFacade();
		
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO ();
		logger.debug("reversarPagoOnLine():start");	
		String urlMsg = config.getString("url.msg");
		
		try {
			 respuesta = getPagoOnLineFacade().reversarPagoOnLine(inParam0);
			  } catch (com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException e) {
			   String log = StackTraceUtl.getStackTrace(e);
			   logger.debug("PagoOnLineException[" + log + "]");
			   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","reversarPagoOnLine fallo",urlMsg, e);
			   throw errorSoap.obtenerGeneralSoapException();
			  } catch (RemoteException e) {
				   String log = StackTraceUtl.getStackTrace(e);
				   logger.debug("PagoOnLineException[" + log + "]");
				   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","reversarPagoOnLine fallo",urlMsg, e);
				   throw errorSoap.obtenerGeneralSoapException();
			  }catch (Exception e) {
				   String log = StackTraceUtl.getStackTrace(e);
				   logger.debug("PagoOnLineException[" + log + "]");
				   CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(urlMsg,"Server fallo","aplicarPagoOnLine fallo",urlMsg, e);
				   throw errorSoap.obtenerGeneralSoapException();
			  }
			  logger.debug("reversarPagoOnLine():end");
			  return respuesta;
	  
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
	private PagoOnLineFacade getPagoOnLineFacade() throws Exception {
		
		  UtilLog.setLog(config.getString("PagoOnLineWS.log"));
		  logger.debug("getPagoOnLineFacade():start");
		  PagoOnLineFacadeHome pagoOnLineFacadeHome = null;
		  String jndi = config.getString("jndi.facade");
		  logger.debug("Buscando servicio[" + jndi + "]");
		  String url = config.getString("url.weblogic");
		  logger.debug("Url weblogic[" + url + "]");
		  try {
		   pagoOnLineFacadeHome = (PagoOnLineFacadeHome) ServiceLocator.getInstance().getRemoteHome(url, jndi,PagoOnLineFacadeHome.class);
		  } catch (ServiceLocatorException e) {
		   // TODO Auto-generated catch block
		   logger.debug("ServiceLocatorException", e);
		   throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException(e);
		  }
		  logger.debug("Recuperada interfaz home de Customer Order facade...");
		  PagoOnLineFacade pagoOnLineFacade = null;
		  try {
		   pagoOnLineFacade = pagoOnLineFacadeHome.create();
		  } catch (CreateException e) {
		   // TODO Auto-generated catch block
		   String log = StackTraceUtl.getStackTrace(e);
		   logger.debug("CreateException[" + log + "]");
		   throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException(e);
		  } catch (RemoteException e) {
		   // TODO Auto-generated catch block
		   String log = StackTraceUtl.getStackTrace(e);
		   logger.debug("RemoteException[" + log + "]");
		   throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException(e);
		  }
		  logger.debug("getPagoOnLineFacade()():end");
		  return pagoOnLineFacade;
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

	}

	/**
	 * 
	 */
	public PagoOnLineWSBean() {
		// TODO Auto-generated constructor stub
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinews/properties/PagoOnLineWS.properties");
	}
}
