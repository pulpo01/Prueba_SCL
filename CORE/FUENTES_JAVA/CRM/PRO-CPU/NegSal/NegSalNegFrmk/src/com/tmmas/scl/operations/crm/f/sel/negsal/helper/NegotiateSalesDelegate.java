/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.crm.f.sel.negsal.helper;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacade;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.GlobalFrmk;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;

public class NegotiateSalesDelegate {

	private static NegotiateSalesDelegate instance = null;
	private static Logger logger = Logger.getLogger(NegotiateSalesDelegate.class);
	private GlobalFrmk global = GlobalFrmk.getInstance();
	
	protected ServiceLocator svcLologgeror = ServiceLocator.getInstance();

	public static NegotiateSalesDelegate getInstance() {
		if (instance == null) {
			instance = new NegotiateSalesDelegate();
		}
		return instance;
	}	
	
	
	//DetermineCustomerOrderFeasibilityFacade
	private DetCusOrdFeaFacade getDetCusOrdFeaFacade() throws NegSalException {
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getDetCusOrdFeaFacade():start");
		
		String jndi = global.getValor("jndi.DetCusOrdFeaFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.DetCusOrdFeaProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		DetCusOrdFeaFacadeHome facadeHome =
			(DetCusOrdFeaFacadeHome) PortableRemoteObject.narrow(obj, DetCusOrdFeaFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de DetCusOrdFeaFacade...");
		DetCusOrdFeaFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new NegSalException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new NegSalException(e);
		}

		logger.debug("getDetCusOrdFeaFacade()():end");
		return facade;
	}
	
	/**
	 * Obtiene fecha ciclo
	 * 
	 * @param ciclo
	 * @return CicloDTO
	 * @throws NegSalException
	 */
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws NegSalException{
	
		CicloDTO resultado = null;
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFechaCiclo():start");
		try {
			resultado = getDetCusOrdFeaFacade().obtenerFechaCiclo(ciclo);
		}catch(NegSalException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NegSalException[" + loge + "]");
			throw e;
		}catch(DetCusOrdFeaException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("DetCusOrdException[" + loge + "]");
			throw new NegSalException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NegSalException[" + loge + "]");
			throw new NegSalException(e);
		}
		logger.debug("obtenerFechaCiclo():end");
		return resultado;
	}	
	
}
