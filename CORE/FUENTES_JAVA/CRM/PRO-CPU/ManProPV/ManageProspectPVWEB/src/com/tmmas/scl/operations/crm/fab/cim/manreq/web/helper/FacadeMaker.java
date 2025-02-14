package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTLHome;

public class FacadeMaker {
	
	private Hashtable env = null;
	private Object obj = null;
	
	private final Logger logger = Logger.getLogger(FacadeMaker.class);	
	private static Global global = Global.getInstance();
	private static FacadeMaker instance;
	
	private VendedorFacadeSTL vendedorFacade = null; 

	
	
	private FacadeMaker()
	{
		
	}	
	
	private void getEJBInstance(String urlProvider,String EJBJndi) throws Exception
	{
		env = new Hashtable();
		logger.debug("Instanciando EJB [" + EJBJndi + "]");
		env.put(Context.INITIAL_CONTEXT_FACTORY, global.getValor("initial.context.factory"));		
		env.put(Context.SECURITY_PRINCIPAL, global.getValor("security.principal"));
		env.put(Context.SECURITY_CREDENTIALS, global.getValor("security.credentials"));
		env.put(Context.PROVIDER_URL, urlProvider);

		Context context = new InitialContext(env);			
		obj = context.lookup(EJBJndi);
		logger.debug("EJB [" + EJBJndi + "] instanciando");				
	}	
	
//	-------------------------------------------------------------------------------------------------------------------------------------------	
	public static FacadeMaker getInstance()
	{
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		if(instance == null)
		{			
			instance = new FacadeMaker();
		}			
		return instance;	
	}
	
	
	/**
	 * Obtiene la interfaz remota del Vendedor
	 * @return
	 * @throws VendedorException
	 */
	public VendedorFacadeSTL  getVendedorFacade() throws VendedorException 
	{
		try 
		{
			if(vendedorFacade ==null)
			{
				this.getEJBInstance(global.getValor("url.provider"), global.getValor("jndi.facade"));				
				VendedorFacadeSTLHome home =(VendedorFacadeSTLHome) PortableRemoteObject.narrow(obj, VendedorFacadeSTLHome.class);		
				vendedorFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new VendedorException(e);			
		}		
		return vendedorFacade;
	}	
}
