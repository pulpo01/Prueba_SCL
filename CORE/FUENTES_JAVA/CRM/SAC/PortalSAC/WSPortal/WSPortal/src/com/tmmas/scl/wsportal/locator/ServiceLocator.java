/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.locator;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.negocio.ejb.session.LlenadoFacade;
import com.tmmas.scl.wsportal.negocio.ejb.session.LlenadoFacadeHome;
import com.tmmas.scl.wsportal.wsservices.WSLlenado;

public class ServiceLocator
{
	private static CompositeConfiguration config = UtilProperty.getConfiguration(WSLlenado.PROPERTIES_EXTERNO,
			WSLlenado.PROPERTIES_INTERNO);

	private static final String INICIO_LOG = "Inicio";

	private static final String FIN_LOG = "Fin";

	private static Logger logger = Logger.getLogger(ServiceLocator.class);

	private static final String URL = config.getString("GE.url.PortalEAR.GE");

	private static final String INITIAL_CONTEXT_FACTORY = config.getString("GE.initial.context.factory.GE");

	private static final String SECURITY_PRINCIPAL = config.getString("GE.security.principal.GE");

	private static final String SECURITY_CREDENTIALS = config.getString("GE.security.credentials.GE");

	private static final String JNDI = config.getString("GE.jndi.LlenadoFacade.GE");

	public ServiceLocator()
	{

	}

	public static LlenadoFacade obtenerFacade() throws NamingException, RemoteException, CreateException
	{
		logger.info(INICIO_LOG);
		logger.debug("INITIAL_CONTEXT_FACTORY= " + INITIAL_CONTEXT_FACTORY);
		logger.debug("URL= " + URL);
		//logger.debug("SECURITY_PRINCIPAL= " + SECURITY_PRINCIPAL);
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
		env.put(Context.PROVIDER_URL, URL);
		//env.put(Context.SECURITY_PRINCIPAL, SECURITY_PRINCIPAL);
		//env.put(Context.SECURITY_CREDENTIALS, SECURITY_CREDENTIALS);
		Context context = null;
		logger.debug("Obteniendo Context...");
		context = new InitialContext(env);
		Object obj = null;
		obj = context.lookup(JNDI);
		LlenadoFacadeHome facadeHome = (LlenadoFacadeHome) PortableRemoteObject.narrow(obj, LlenadoFacadeHome.class);
		LlenadoFacade facade = null;
		facade = facadeHome.create();
		logger.info(FIN_LOG);
		return facade;
	}
}
