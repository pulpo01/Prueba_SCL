package com.tmmas.cl.scl.ss911correofax.negocio.web.delegate;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.configuration.Configuration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.direccion.presentacion.delegate.DireccionDelegate;
import com.tmmas.cl.scl.direccioncommon.commonapp.exception.DireccionException;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacade;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacadeHome;

public class ServSupl911CorreoFaxDelegate {
	
	private static ServSupl911CorreoFaxDelegate instance = null;
	protected DireccionDelegate direccionDelegate= new DireccionDelegate();
	
	
	private static Logger logger = Logger.getLogger(ServSupl911CorreoFaxDelegate.class);
	private Configuration config;
	public static ServSupl911CorreoFaxDelegate getInstance(){
		if (instance == null) {
			instance = new ServSupl911CorreoFaxDelegate();
		}
		return instance;
	}
	
	public ServSupl911CorreoFaxDelegate()
	{
		config = UtilProperty.getConfiguration("ServSupl911CorreoFax.properties","com/tmmas/cl/scl/ss911correofax/negocio/web/properties/webpropiedades.properties");
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));	
	}
	
	
	private ServSupl911CorreoFaxFacade getServSupl911CorreoFaxFacade() throws GeneralException 	
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
		logger.debug(" Ingreso a getServSupl911CorreoFaxFacade");
		
		String jndi = config.getString("jndi.ServSupl911CorreoFaxFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.ServSupl911CorreoFaxProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		ServSupl911CorreoFaxFacadeHome facadeHome = (ServSupl911CorreoFaxFacadeHome) PortableRemoteObject.narrow(obj, 
				ServSupl911CorreoFaxFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de getServSupl911CorreoFaxFacade...");
		ServSupl911CorreoFaxFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new GeneralException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("getServSupl911CorreoFaxFacade():end");
		return facade;	
	}
	
	
	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO) 
		throws DireccionException, RemoteException 
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));	
		logger.debug("getDatosDireccion():start");
		try {
			logger.debug("getDatosDireccion:antes");
			direccionDTO = direccionDelegate.getDatosDireccion(direccionDTO);
			logger.debug("getDatosDireccion:despues");
		} catch (DireccionException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDatosDireccion():end");
		return direccionDTO;
	}

	public ProvinciaDireccionDTO getProvincias(	ProvinciaDireccionDTO provinciaDireccionDTO) 
		throws DireccionException, RemoteException 
	{
		logger.debug("getProvincias():start");
		
		try {
			logger.debug("getProvincias:antes");
			provinciaDireccionDTO= direccionDelegate.getProvincias(provinciaDireccionDTO);
			logger.debug("getProvincias:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getProvincias():end");
		return provinciaDireccionDTO;
	}
	
	
	public CiudadDireccionDTO getCiudades(CiudadDireccionDTO ciudadDireccionDTO)
		throws DireccionException, RemoteException 
	{
		logger.debug("getCiudades():start");
		
		try {
			logger.debug("getCiudades:antes");
			ciudadDireccionDTO = direccionDelegate.getCiudades(ciudadDireccionDTO);
			logger.debug("getCiudades:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getCiudades():end");
		return ciudadDireccionDTO;
	}
	
	public CodigosDTO[] getListCodigos(CodigosDTO entrada)
		throws GeneralException, RemoteException 
	{
		logger.debug("getListCodigos():start");
		CodigosDTO[] retValue = null;
		
		try {
			logger.debug("getCiudades:antes");
			retValue = getServSupl911CorreoFaxFacade().getListCodigos(entrada);
			logger.debug("getCiudades:despues");
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListCodigos():end");
		return retValue;
	}

	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT contactoAbonadoTT) throws GeneralException, RemoteException{
		logger.debug("obtenerListaContactos():start");
		ContactoAbonadoTT[] retValue = null;
		
		try {
			logger.debug("obtenerListaContactos:antes");
			retValue = getServSupl911CorreoFaxFacade().obtenerListaContactos(contactoAbonadoTT);
			logger.debug("obtenerListaContactos:despues");
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerListaContactos():end");
		return retValue;
	} 
	
	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] contactoAbonadoTTs) throws GeneralException, RemoteException{
		logger.debug("deleteInsertPvContactoAbonadoTT():start");		
		try {
			logger.debug("deleteInsertPvContactoAbonadoTT:antes");
			getServSupl911CorreoFaxFacade().deleteInsertPvContactoAbonadoTT(contactoAbonadoTTs);
			logger.debug("deleteInsertPvContactoAbonadoTT:despues");
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("deleteInsertPvContactoAbonadoTT():end");
	} 
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException, RemoteException {
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retorno = null;
		try {
			logger.debug("getParametroGeneral:antes");
			retorno = getServSupl911CorreoFaxFacade().getParametroGeneral(entrada);
			logger.debug("getParametroGeneral:despues");
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getParametroGeneral():end");
		
		return retorno;
	}
}
