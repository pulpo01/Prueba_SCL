package com.tmmas.scl.operations.crm.delegate.helper;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacade;
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session.CloCusOrdFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacade;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
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
import com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session.SupBillAndColFacade;
import com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session.SupBillAndColFacadeHome;
import com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception.SupBillAndColException;

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
	private IssCusOrdORC issCusOrdORC = null;
	private IssCusOrdFacade issCusOrdFacade = null;
	private ManProOffInvFacade manProOffInvFacade = null;
	private ManConFacade manConFacade =null;
	private SupOrdHanFacade supOrdHanFacade=null;
	private ManCusInvFacade manCusInvFacade=null;
	private SupCusIntManFacade supCusIntManFacade=null; 
	private FrmkCargosFacade frmkCargosFacade=null;
	private CloCusOrdFacade cloCusOrdFacade=null;
	private DetCusOrdFeaFacade detCusOrdFeaFacade=null;
	private SupBillAndColFacade supBillAndColFacade= null; 
	
//-------------------------------------------------------------------	
	
	private void getEJBInstance(String urlProvider,String EJBJndi) throws Exception
	{
		logger.debug("getEJBInstance():start");
		env = new Hashtable();
		logger.debug("Instanciando EJB ["+EJBJndi+"]");
		env.put(Context.INITIAL_CONTEXT_FACTORY, global.getValor("initial.context.factory"));		
		env.put(Context.SECURITY_PRINCIPAL, global.getValor("security.principal"));
		env.put(Context.SECURITY_CREDENTIALS, global.getValor("security.credentials"));
		env.put(Context.PROVIDER_URL, urlProvider);

		Context context = new InitialContext(env);			
		obj = context.lookup(EJBJndi);
		logger.debug("EJB ["+EJBJndi+"] instanciando");
		logger.debug("getEJBInstance():end");
	}	
	
//	-------------------------------------------------------------------------------------------------------------------------------------------	
	public static FacadeMaker getInstance()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		if(instance==null)
		{			
			instance=new FacadeMaker();
		}			
		return instance;	
	}
	
	private FacadeMaker()
	{
		
	}
//	------------------------------------------------------------------------------------------------------------------------------------------	
	public IssCusOrdFacade getIssCusOrdFacade() throws IssCusOrdException  
	{
		try 
		{
			if(issCusOrdFacade==null)
			{
				this.getEJBInstance(global.getValor("url.IssCusOrdProvider"), global.getValor("jndi.IssCusOrdFacade"));				
				IssCusOrdFacadeHome home =(IssCusOrdFacadeHome) PortableRemoteObject.narrow(obj, IssCusOrdFacadeHome.class);				
				issCusOrdFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new IssCusOrdException(e);			
		}		
		return issCusOrdFacade;
	}	
//------------------------------------------------------------------------------------------------------------------------------------------	
	public IssCusOrdORC getIssCusOrdORC() throws IssCusOrdException  
	{
		try 
		{
			if(issCusOrdORC==null)
			{
				this.getEJBInstance(global.getValor("url.IssCusOrdORCProvider"), global.getValor("jndi.IssCusOrdORC"));				
				IssCusOrdORCHome home =(IssCusOrdORCHome) PortableRemoteObject.narrow(obj, IssCusOrdORCHome.class);				
				issCusOrdORC = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new IssCusOrdException(e);			
		}		
		return issCusOrdORC;
	}
//	-------------------------------------------------------------------------------------------------------------------------------------------	
	public ManProOffInvFacade getManProOffInvFacade() throws ManProOffInvException
	{
		try 
		{
			if(manProOffInvFacade==null)
			{
				this.getEJBInstance(global.getValor("url.ManProOffInvProvider"), global.getValor("jndi.ManProOffInvFacade"));				
				ManProOffInvFacadeHome home =(ManProOffInvFacadeHome) PortableRemoteObject.narrow(obj, ManProOffInvFacadeHome.class);				
				manProOffInvFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new ManProOffInvException(e);			
		}		
		return manProOffInvFacade;
	}
//-------------------------------------------------------------------------------------------------------------------------------------------	
	public ManConFacade getManConFacade() throws ManConException 
	{
		logger.debug("getManConFacade():start");
		try 
		{
			if(manConFacade==null)
			{
				logger.debug("gmanConFacade==null");
				this.getEJBInstance(global.getValor("url.ManConProvider"), global.getValor("jndi.ManConFacade"));				
				ManConFacadeHome home =(ManConFacadeHome) PortableRemoteObject.narrow(obj, ManConFacadeHome.class);				
				manConFacade = home.create();
			}
			else {
				logger.debug("gmanConFacade!=null");
			}
		}
		catch (Exception e) 
		{
			logger.error("Exception"+e);
			throw new ManConException(e);			
		}	
		logger.debug("getManConFacade():end");
		return manConFacade;
	}
	
//-------------------------------------------------------------------------------------------------------------------------------------------	
	public SupOrdHanFacade getSupOrdHanFacade() throws SupOrdHanException 
	{
		logger.debug("getSupOrdHanFacade():start");
		try 
		{
			if(supOrdHanFacade==null)
			{
				logger.debug("supOrdHanFacade==null");
				logger.debug("getEJBInstance():antes");
				this.getEJBInstance(global.getValor("url.SupOrdHanProvider"), global.getValor("jndi.SupOrdHanFacade"));
				logger.debug("getEJBInstance():despues");
				SupOrdHanFacadeHome home =(SupOrdHanFacadeHome) PortableRemoteObject.narrow(obj, SupOrdHanFacadeHome.class);				
				supOrdHanFacade = home.create();
			}
			else {
				logger.debug("supOrdHanFacade!=null");
				
			}
		}
		catch (Exception e) 
		{
			logger.error("Exception",e);
			throw new SupOrdHanException(e);			
		}	
		logger.debug("getSupOrdHanFacade():end");
		return supOrdHanFacade;
	}
	
//	-------------------------------------------------------------------------------------------------------------------------------------------	
	public ManCusInvFacade getManCusInvFacade() throws ManCusInvException 
	{
		try 
		{
			if(manCusInvFacade==null)
			{
				this.getEJBInstance(global.getValor("url.ManCusInvProvider"), global.getValor("jndi.ManCusInvFacade"));				
				ManCusInvFacadeHome home =(ManCusInvFacadeHome) PortableRemoteObject.narrow(obj, ManCusInvFacadeHome.class);		
				manCusInvFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new ManCusInvException(e);			
		}		
		return manCusInvFacade;
	}
//-----------------------------------------------------------------------------------------------------------------------------------------------
	public SupCusIntManFacade getSupCusIntManFacade() throws SupCusIntManException 
	{
		try 
		{
			if(supCusIntManFacade==null)
			{
				this.getEJBInstance(global.getValor("url.SupCusIntManProvider"), global.getValor("jndi.SupCusIntManFacade"));				
				SupCusIntManFacadeHome home =(SupCusIntManFacadeHome) PortableRemoteObject.narrow(obj, SupCusIntManFacadeHome.class);		
				supCusIntManFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new SupCusIntManException(e);			
		}		
		return supCusIntManFacade;
	}
//-----------------------------------------------------------------------------------------------------------------------------------------------	
	public CloCusOrdFacade getCloCusOrdFacade() throws CloCusOrdException 
	{
		try 
		{
			if(cloCusOrdFacade==null)
			{
				this.getEJBInstance(global.getValor("url.CloCusOrdProvider"), global.getValor("jndi.CloCusOrdFacade"));				
				CloCusOrdFacadeHome home =(CloCusOrdFacadeHome) PortableRemoteObject.narrow(obj, CloCusOrdFacadeHome.class);		
				cloCusOrdFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new CloCusOrdException(e);			
		}		
		return cloCusOrdFacade;
	}
//-----------------------------------------------------------------------------------------------------------------------------------------------	
	
  public FrmkCargosFacade getFrmkCargosFacade() throws FrmkCargosException 
	{
		try 
		{
			if(frmkCargosFacade==null)
			{
				this.getEJBInstance(global.getValor("url.FrmkCargosProvider"), global.getValor("jndi.FrmkCargosFacade"));				
				FrmkCargosFacadeHome home =(FrmkCargosFacadeHome) PortableRemoteObject.narrow(obj, FrmkCargosFacadeHome.class);		
				frmkCargosFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new FrmkCargosException(e);			
		}		
		return frmkCargosFacade;
	}	
//-----------------------------------------------------------------------------------------------------------------------------------------------	
  public SupBillAndColFacade getSupBillAndColFacade() throws SupBillAndColException 
	{
		try 
		{
			if(supBillAndColFacade==null)
			{
				this.getEJBInstance(global.getValor("url.SupBillAndColFacadeProvider"), global.getValor("jndi.SupBillAndColFacade"));				
				SupBillAndColFacadeHome home =(SupBillAndColFacadeHome) PortableRemoteObject.narrow(obj, SupBillAndColFacadeHome.class);		
				supBillAndColFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new SupBillAndColException(e);			
		}		
		return supBillAndColFacade;
	}	
//-----------------------------------------------------------------------------------------------------------------------------------------------
  
  public DetCusOrdFeaFacade getDetCusOrdFeaFacade() throws DetCusOrdFeaException 
	{
		try 
		{
			if(detCusOrdFeaFacade==null)
			{
				this.getEJBInstance(global.getValor("url.DetCusOrdFeaProvider"), global.getValor("jndi.DetCusOrdFeaFacade"));				
				DetCusOrdFeaFacadeHome home =(DetCusOrdFeaFacadeHome) PortableRemoteObject.narrow(obj, DetCusOrdFeaFacadeHome.class);		
				detCusOrdFeaFacade = home.create();
			}
		}
		catch (Exception e) 
		{
			logger.error("Ocurrio un error al generar la instancia :"+e);
			throw new DetCusOrdFeaException(e);			
		}		
		return detCusOrdFeaFacade;
	}	
//-----------------------------------------------------------------------------------------------------------------------------------------------  
}
