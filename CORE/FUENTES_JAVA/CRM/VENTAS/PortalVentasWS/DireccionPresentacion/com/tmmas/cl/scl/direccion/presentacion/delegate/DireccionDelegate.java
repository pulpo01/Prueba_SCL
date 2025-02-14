/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 22/06/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.direccion.presentacion.delegate;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.direccion.negocio.ejb.session.DireccionFacadeSTL;
import com.tmmas.cl.scl.direccion.negocio.ejb.session.DireccionFacadeSTLHome;
import com.tmmas.cl.scl.direccion.presentacion.helper.Global;
import com.tmmas.cl.scl.direccioncommon.commonapp.exception.DireccionException;


public class DireccionDelegate {

	private static DireccionDelegate instance = null;
	
	private static Logger logger = Logger.getLogger(DireccionDelegate.class);
	
	public static DireccionDelegate getInstance() {
		if (instance == null) {
			instance = new DireccionDelegate();
		}
		return instance;
	}
	

	protected ServiceLocator svcLocator = ServiceLocator.getInstance();

	private Global global = Global.getInstance();
	
	private DireccionFacadeSTL getDireccionFacade()
	throws DireccionException {
		
		logger.debug("getDireccionFacade():start");
		
		String jndi = global.getValor("jndi.DireccionFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValor("url.DireccionFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");

		String initialContextFactory =  global.getValor("initial.context.factory").trim();
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		
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
		
		DireccionFacadeSTLHome facadeHome = (DireccionFacadeSTLHome) PortableRemoteObject.narrow(obj, DireccionFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de DireccionFacadeSTL...");
		DireccionFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new DireccionException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDireccionFacade():end");
		return facade;
	}

	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getDatosDireccion():start");
		DireccionDTO direccionDTO2 = null;
		try {
			logger.debug("getDatosDireccion:antes");
			direccionDTO2 = getDireccionFacade().getDatosDireccion(direccionDTO);
			logger.debug("getDatosDireccion:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDatosDireccion():end");
		return direccionDTO2;
	}
	
	public ProvinciaDireccionDTO getProvincias(ProvinciaDireccionDTO provinciaDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getProvincias():start");
		ProvinciaDireccionDTO provinciaDireccionDTO2 = null;
		try {
			logger.debug("getProvincias:antes");
			provinciaDireccionDTO2 = getDireccionFacade().getProvincias(provinciaDireccionDTO);
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
		return provinciaDireccionDTO2;
	}
	public CiudadDireccionDTO getCiudades(CiudadDireccionDTO ciudadDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getCiudades():start");
		CiudadDireccionDTO ciudadDireccionDTO2 = null;
		try {
			logger.debug("getCiudades:antes");
			ciudadDireccionDTO2 = getDireccionFacade().getCiudades(ciudadDireccionDTO);
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
		return ciudadDireccionDTO2;
	}

	public ComunaDireccionDTO getComunas(ComunaDireccionDTO comunaDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getComunas():start");
		ComunaDireccionDTO comunaDireccionDTO2 = null;
		try {
			logger.debug("getComunas:antes");
			comunaDireccionDTO2 = getDireccionFacade().getComunas(comunaDireccionDTO);
			logger.debug("getComunas:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getComunas():end");
		return comunaDireccionDTO2;
	}

	public CodigoPostalDireccionDTO getCodigosPostales(CodigoPostalDireccionDTO codigoPostalDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getComunas():start");
		
		try {
			logger.debug("getCodigosPostales:antes");
			codigoPostalDireccionDTO = getDireccionFacade().getCodigosPostales(codigoPostalDireccionDTO);
			logger.debug("getCodigosPostales:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getCodigosPostales():end");
		return codigoPostalDireccionDTO;
	}

}
