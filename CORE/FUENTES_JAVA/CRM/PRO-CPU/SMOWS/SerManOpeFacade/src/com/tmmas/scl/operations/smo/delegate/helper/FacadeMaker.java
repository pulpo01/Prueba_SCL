package com.tmmas.scl.operations.smo.delegate.helper;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.operations.crm.o.csr.manserinv.bean.ejb.session.ManSerInvFacade;
import com.tmmas.scl.operations.crm.o.csr.manserinv.bean.ejb.session.ManSerInvFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.session.IssSerOrdFacade;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.session.IssSerOrdFacadeHome;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;

public class FacadeMaker 
{	
	private Hashtable env=null;
	private Object obj=null;
	
	private final Logger logger = Logger.getLogger(FacadeMaker.class);	
	private static Global global=Global.getInstance();
	private static FacadeMaker instance;
	
//------------------------------------------------------------------
   /**
	 * Fachadas Disponibles.
	 *  
	 */
	private IssSerOrdFacade issSerOrdFacade=null;
	private ManSerInvFacade manSerInvFacade=null;
//-------------------------------------------------------------------	
	
	
	private void getEJBInstance(String urlProvider,String EJBJndi) throws Exception
	{
		env = new Hashtable();
		logger.debug("Instanciando EJB ["+EJBJndi+"]");
		env.put(Context.INITIAL_CONTEXT_FACTORY, global.getValor("initial.context.factory"));		
		env.put(Context.SECURITY_PRINCIPAL, global.getValor("security.principal"));
		env.put(Context.SECURITY_CREDENTIALS, global.getValor("security.credentials"));
		env.put(Context.PROVIDER_URL, urlProvider);

		Context context = new InitialContext(env);			
		obj = context.lookup(EJBJndi);
		logger.debug("EJB ["+EJBJndi+"] instanciando");				
	}
	
	public static FacadeMaker getInstance()
	{
				
		if(instance==null)
		{			
			instance=new FacadeMaker();
		}			
		return instance;	
	}
	
	private FacadeMaker()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}
	
	public IssSerOrdFacade getIssSerOrdFacade() throws IssSerOrdException
	{
		try 
		{
			if(issSerOrdFacade==null)
			{
				this.getEJBInstance(global.getValor("url.IssSerOrdProvider"), global.getValor("jndi.IssSerOrdFacade"));				
				IssSerOrdFacadeHome home =(IssSerOrdFacadeHome) PortableRemoteObject.narrow(obj, IssSerOrdFacadeHome.class);				
				issSerOrdFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia "+e);
			throw new IssSerOrdException(e);			
		}		
		return issSerOrdFacade;
	}
	
	public ManSerInvFacade getManSerInvFacade() throws ManSerInvException
	{
		try 
		{
			if(manSerInvFacade==null)
			{
				this.getEJBInstance(global.getValor("url.ManSerInvProvider"), global.getValor("jndi.ManSerInvFacade"));				
				ManSerInvFacadeHome home =(ManSerInvFacadeHome) PortableRemoteObject.narrow(obj, ManSerInvFacadeHome.class);				
				manSerInvFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia "+e);
			throw new ManSerInvException(e);		
		}		
		return manSerInvFacade;
	}

}
