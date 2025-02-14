package com.tmmas.scl.operations.crm.bean.ejb.helper;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacade;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacadeHome;
import com.tmmas.scl.operations.crm.common.Exception.CusRelManWSException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.isscusord.bean.ejb.session.IssCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.soa.bean.ejb.session.IssCusOrdORCHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacade;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacade;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;

public class FacadeWS 
{	
	private Hashtable env=null;
	private Object obj=null;
	
	private final Logger logger = Logger.getLogger(FacadeWS.class);	
	private static Global global=Global.getInstance();
	private static FacadeWS instance;
	
//------------------------------------------------------------------
   /**
	 * Fachadas Disponibles.
	 *  
	 */	
	private CusRelManFacade cusRelManFacade=null;
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
	
//	-------------------------------------------------------------------------------------------------------------------------------------------	
	public static FacadeWS getInstance()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		if(instance==null)
		{			
			instance=new FacadeWS();
		}			
		return instance;	
	}
	
	private FacadeWS()
	{
		
	}
//-----------------------------------------------------------------------------------------------------------------------------------------------	
	
  public CusRelManFacade getCusRelManFacade() throws CusRelManWSException 
	{
		try 
		{
			if(cusRelManFacade==null)
			{
				this.getEJBInstance(global.getValor("url.CusRelManEJBProvider"), global.getValor("jndi.CusRelManFacade"));				
				CusRelManFacadeHome home =(CusRelManFacadeHome) PortableRemoteObject.narrow(obj, CusRelManFacadeHome.class);		
				cusRelManFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new CusRelManWSException(e);			
		}		
		return cusRelManFacade;
	}	
//-----------------------------------------------------------------------------------------------------------------------------------------------	
	
}
