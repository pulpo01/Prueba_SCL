package com.tmmas.cl.scl.spnscljms.negocio.ejb.cmd;

import java.io.Serializable;
import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.processmgr.GenericCommandObject;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaJMSDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQ;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.session.SpnSclORQHome;

public class PruebaQueueCMD extends GenericCommandObject implements Serializable{

	private static final long serialVersionUID = 1L;
		
	transient static Logger logger = Logger.getLogger(PruebaQueueCMD.class);
	transient private CompositeConfiguration config = null;
		
	transient private AsyncProcessParameterObject parametros = null;	
	transient private String  CunetaAltaDeLineaJMS = null;
	
	public PruebaQueueCMD(AsyncProcessParameterObject value) {
		super(value);		
		logger.debug("PruebaQueueCMD(): Start");	
		config = UtilProperty.getConfiguration("SpnSclJMSBean.properties","com/tmmas/cl/scl/spnscljms/negocio/ejb/properties/SpnSclJMSBean.properties");
		UtilLog.setLog(config.getString("SpnSclJMSBean.log"));
		logger.debug("PruebaQueueCMD():End");		
	}	
	

	private SpnSclORQ getSpnSclORQ()
	throws GeneralException {
		config = UtilProperty.getConfiguration("SpnSclJMSBean.properties","com/tmmas/cl/scl/spnscljms/negocio/ejb/properties/SpnSclJMSBean.properties");
		UtilLog.setLog(config.getString("SpnSclJMSBean.log"));
		logger.debug("getSpnSclORQ():start");
		SpnSclORQHome SpnSclORQHome = null;
		String jndi = config.getString("SpnSclORQ.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("SpnSclORQ.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			SpnSclORQHome = (SpnSclORQHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, SpnSclORQHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de SpnSclORQ...");
		SpnSclORQ SpnSclORQ = null;

		try {
			SpnSclORQ = SpnSclORQHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getSpnSclORQ()():end");
		return SpnSclORQ;
	}	
			
	
	public void onInit() throws GeneralException {
		logger.debug("EstructuraComercialQueueCMD()-onInit(): Start");
		logger.debug("onInit():start");
		setRollBackManual(false);
		// Recupero el parametro
		parametros = getArguments();
		CunetaAltaDeLineaJMS = (String)parametros.getArgumentsData();
		logger.debug("onInit():end");
	}
	
	
	public AsyncProcessResponseObject start() throws GeneralException {
		logger.debug("start():start");	
		try{							
			getSpnSclORQ().pruebaJMS(CunetaAltaDeLineaJMS);									
		}catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			setRollBackManual(true);
			throw new GeneralException(e);
		}

		logger.debug("start():end");
		return null;
	}	

}
