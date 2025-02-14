package com.tmmas.cl.scl.pv.customerorder.soa.ejb.cmd;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponse;
import com.tmmas.cl.framework.processmgr.GenericCommand;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.pv.customerorder.soa.ejb.session.CustomerOrderORQ;
import com.tmmas.cl.scl.pv.customerorder.soa.ejb.session.CustomerOrderORQHome;



public class ActivarSSQueueCMD extends GenericCommand{
	private static final long serialVersionUID = 1L;
	
	//transient private static Category cat = Category.getInstance(ActivarSSQueueCMD.class);
	
	private ParametroProcesoDTO proceso;
	private int intento;

	//transient private static Logger logger = Logger.getLogger(ActivarSSQueueCMD.class);
	transient private static Category logger = Category.getInstance(ActivarSSQueueCMD.class);
	private CompositeConfiguration config;
	
	private void setLog() {
//		 inicio MA
		String strRuta = "/com/tmmas/cl/CustomerOrderORQ/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderORQ.properties";
		String strArchivoLog="CustomerOrderORQ.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
		// fin MA	
	}
	
	
	
	
	
	public ActivarSSQueueCMD(ParametroProcesoDTO proceso)
	{
		this.proceso = proceso;
	}
	
	public void onInit() throws FrameworkException {
		
		logger.debug("onInit:Star");
		
		logger.debug("onInit:end");
		
	}
	
	
	private CustomerOrderORQ getCustomerOrderORQ()
	throws TOLException {

		setLog();
		
		logger.debug("getCustomerOrderORQ():start");
		
		//Global global = Global.getInstance();
		
		CustomerOrderORQHome customerOrderORQHome = null;
		
		//String jndi = global.getValor("jndi.customer.orq");
		String jndi = config.getString("jndi.customer.orq");
		logger.debug("Buscando servicio[" + jndi + "]");
		//String url = global.getValor("url.provider");
		String url = config.getString("url.provider");
		logger.debug("Url provider[" + url + "]");
		
		try {
			logger.debug("Recupero el ServiceLocator");
			ServiceLocator sl = ServiceLocator.getInstance();
			if(sl == null)
				logger.debug("No se pudo recuperar instancia a ServiceLocator");
			

			logger.debug("Buscando Remote Home");
			EJBHome h = sl.getRemoteHome(url, jndi,	CustomerOrderORQHome.class);
			if(h == null)
				logger.debug("No se pudo recuperar instancia a ServiceLocator");
			
			logger.debug("Castiando home a CustomerOrderORQHome");
			customerOrderORQHome = (CustomerOrderORQHome)h ;
			logger.debug("Proceso OK");
		} catch (Throwable e) {
			logger.debug("Exception ", e);
			throw new TOLException(e);
		}
		
		logger.debug("Recuperada interfaz home de Customer Order ORQ...");
		CustomerOrderORQ customerOrderORQ = null;
		try {
			customerOrderORQ = customerOrderORQHome.create();
		} catch (CreateException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
		
			throw new TOLException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}
		
		logger.debug("getCustomerOrderORQ()():end");
		return customerOrderORQ;
	}		
	
	
	
	public AsyncProcessResponse start() throws FrameworkException 
	{
		ProductListDTO prodList;
		
		setLog();
		
		logger.debug("start:Star");
		
		intento++;
		logger.debug("start:Intento [" + intento + "]");
		
		proceso.setError_tecnico("");
		proceso.setNum_reintentos(intento);
		
		try {
			logger.debug("Registro Inicialdo ejecucion en BD");
			proceso.setNum_reintentos(intento);
			actualizaProceso("En proceso", 2);
			
			prodList = (ProductListDTO)proceso.getParametro();
			logger.debug("se procese a ejecutar proceso");
			getCustomerOrderORQ().executeInstallServiceBundle(prodList);
			
			logger.debug("Proceso terminó satisfactoriamente, actualizo estado de proceso");
			actualizaProceso("Fin OK ", 3);
			
		} catch (Exception e) {
			//proceso.setError_tecnico(buscaGlosa(e));
			actualizaProceso("Fin Error", 4);
			logger.debug("Error, se procesede a ejecutar roolback");
			throw new FrameworkException("A ocurrido un error al instalar el servicio suplementario", e); 
		}

		return null;
	}
	
	private void actualizaProceso(String glosa, int estado) 
	{
		
		setLog();
		
		proceso.setObservacion(glosa);
		proceso.setEstado(estado);
		try {
			getCustomerOrderORQ().actualizaProceso(proceso);
		} catch (Exception e) {
			logger.debug("Error al actualizar el proceso :" + proceso.getNumeroProceso() + " a :" + glosa, e);
		}
	
	}
}
