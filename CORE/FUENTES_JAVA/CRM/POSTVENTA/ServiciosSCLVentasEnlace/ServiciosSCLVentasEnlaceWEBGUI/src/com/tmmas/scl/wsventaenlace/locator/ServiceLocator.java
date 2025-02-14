package com.tmmas.scl.wsventaenlace.locator;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.negocio.ejb.session.AsociaRangoFacadeLocal;
import com.tmmas.scl.wsventaenlace.negocio.ejb.session.AsociaRangoFacadeLocalHome;
import com.tmmas.scl.wsventaenlace.negocio.ejb.session.ValidacionesVentaEnlaceE1FacadeLocal;
import com.tmmas.scl.wsventaenlace.negocio.ejb.session.ValidacionesVentaEnlaceE1FacadeLocalHome;

public class ServiceLocator {

	private GlobalProperties global = GlobalProperties.getInstance();
	private final String url = global.getValorExterno("GE.url.ServicioVentaEnlaceE1EAR.GE");// t3://172.28.11.164:7001/ServiciosSCLVentaEnlaceWSEAR
	private final String initialContextFactory = global.getValorExterno("GE.initial.context.factory.GE");// weblogic.jndi.WLInitialContextFactory
	private final String securityPrincipal = global.getValorExterno("GE.security.principal.GE");// weblogic
	private final String securityCredentials = global.getValorExterno("GE.security.credentials.GE");// weblogic

	/**
	 * 
	 */
	public ServiceLocator() {

	}

	private Hashtable getEnviroment() {
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		return env;
	}

	private Context getContex(Hashtable env) throws NamingException {
		Context context = null;
		context = new InitialContext(env);
		return context;
	}

	public AsociaRangoFacadeLocal obtenerAsociaRangoFacadeLocal() {
		AsociaRangoFacadeLocalHome localh = null;
		AsociaRangoFacadeLocal local = null;
		InitialContext ic = null;
		String jndi = "";

		try {
			if (localh == null) {
				jndi = global.getValor("GE.AR.jndi.GE");
				System.out.println("VALOR:" + jndi);
				ic = new InitialContext();
				localh = (AsociaRangoFacadeLocalHome) ic.lookup(jndi);
			}

			local = (AsociaRangoFacadeLocal) localh.create();
		} catch (Exception t) {
			t.printStackTrace();
		}

		return local;
	}
	
	public ValidacionesVentaEnlaceE1FacadeLocal obtenerValidacionesVentaEnlaceE1FacadeLocal() {
		ValidacionesVentaEnlaceE1FacadeLocalHome localh = null;
		ValidacionesVentaEnlaceE1FacadeLocal local = null;
		Context ic = null;
		String jndi = "";
		try {
		
			if (localh==null) {
				jndi = global.getValor("GE.VVE.jndi.GE");
				System.out.println("VALOR:"+jndi);
				ic = new InitialContext();
				localh = (ValidacionesVentaEnlaceE1FacadeLocalHome) ic.lookup(jndi);
			}
			local = (ValidacionesVentaEnlaceE1FacadeLocal) localh.create();
		} catch (Exception t) {
			t.printStackTrace();
		}
		return local;
	}

}
