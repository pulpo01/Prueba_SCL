package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper;

import java.io.Serializable;
import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.log4j.Logger;
import org.jdom.Element;

import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacade;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session.ManCusBilFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
//import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManWSFacade;
//import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManWSFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;

public class FacadeHelper implements Serializable {
	
	private static final long serialVersionUID = 1L;
	transient static Logger cat = Logger.getLogger(FacadeHelper.class);	
	
	
	/**
	 * Almacena las fachada a el EJB
	 * @return
	 * @throws ManCusBilException
	 */
	public ManCusBilFacade getManCusBilFacade() throws ManCusBilException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManCusBilFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		ManCusBilFacadeHome manCusBilFacadeHome = null;

		String jndi = global.getValor("jndi.ManCusBilFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManCusBilProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manCusBilFacadeHome = (ManCusBilFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManCusBilFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManCusBilException(e);
		}		
		cat.debug("Recuperada interfaz home de Manage Customer...");
		ManCusBilFacade manCusBilFacade = null;

		try 
		{
			manCusBilFacade = manCusBilFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new ManCusBilException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new ManCusBilException(e);
		}		
		cat.debug("getManCusBilFacade():end");
		return manCusBilFacade;
	}

	public FrmkCargosFacade getFrmkCargosFacade() throws  FrmkCargosException 
	{
		Global global = Global.getInstance();		
		cat.debug("getFrmkCargosFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		FrmkCargosFacadeHome facadeHome = null;

		String jndi = global.getValor("jndi.FrmkCargosFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.FrmkCargosProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (FrmkCargosFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, FrmkCargosFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new FrmkCargosException(e);
		}		
		cat.debug("Recuperada interfaz home de FrmkCargosFacade...");
		FrmkCargosFacade frmkCargosFacade = null;

		try 
		{
			frmkCargosFacade = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new FrmkCargosException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new FrmkCargosException(e);
		}		
		cat.debug("getFrmkCargosFacade():end");
		return frmkCargosFacade;
	}

	/**
	 * Almacena las fachada a el EJB
	 * @return
	 * @throws IssCusOrdException
	 * @throws ManConException
	 */
	public ManConFacade getManConFacade() throws IssCusOrdException, ManConException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManConFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		ManConFacadeHome manConFacadeHome = null;

		String jndi = global.getValor("jndi.ManConFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManConProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manConFacadeHome = (ManConFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManConFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManConException(e);
		}		
		cat.debug("Recuperada interfaz home de ManConFacade...");
		ManConFacade manConFacade = null;

		try 
		{
			manConFacade = manConFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getManConFacade():end");
		return manConFacade;
	}	

	
	/**
	 * Almacena las fachada a el EJB
	 * @return
	 * @throws IssCusOrdException
	 */
	/*public CusRelManWSFacade getCusRelManWSFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getCusRelManWSFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		CusRelManWSFacadeHome cusRelManWSFacadeHome = null;

		String jndi = global.getValor("jndi.CusRelManWSFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.CusRelManWSProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			cusRelManWSFacadeHome = (CusRelManWSFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, CusRelManWSFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" +  loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de cusRelManWSFacade...");
		CusRelManWSFacade cusRelManWSFacade = null;

		try 
		{
			cusRelManWSFacade = cusRelManWSFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("cusRelManWSFacade():end");
		return cusRelManWSFacade;
	}*/
	
	
	/**
	 * Almacena las fachada a el EJB
	 * @return
	 * @throws IssCusOrdException
	 */
	public SupOrdHanFacade getSupOrdHanFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		cat.debug("getSupOrdHanFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		SupOrdHanFacadeHome supOrdHanFacadeHome = null;
		String jndi = global.getValor("jndi.SupOrdHanFacade");
		cat.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.SupOrdHanProvider");
		cat.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");

		try {
			supOrdHanFacadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		cat.debug("Recuperada interfaz home de Issue Customer Order Facade...");
		SupOrdHanFacade supOrdHanFacade = null;
		try {
			supOrdHanFacade = supOrdHanFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");

			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		cat.debug("getIssCusOrdFacade():end");
		return supOrdHanFacade;
	}

	/**
	 * Obtiene una instancia de la fachada descrita en el objeto "metodo" que tiene como entrada.
	 * 
	 * @param metodo Element que contiene toda la información referente al método que se quiere ejecutar (EJ: Parametros de entrada, salida, ubicación de la fachada, etc )
	 * @return Instancia de la fachada que contiene el método que se ejecutará.
	 * @throws ProyectoException
	 * @throws ClassNotFoundException
	 */
	public Object obtenerFacade(Element metodo) throws IssCusOrdException, ClassNotFoundException{
		cat.debug("obtenerFacade():start");
		
		Global global = Global.getInstance();
		String initialContextFactory = global.getValor(metodo.getChild("ContextFactory").getText());
		String jndi = global.getValor(metodo.getChild("JNDI").getText());
		String url = global.getValor(metodo.getChild("URL").getText());
		String securityPrincipal = global.getValor(metodo.getChild("SecurityPrincipal").getText());
		String securityCredentials = global.getValor(metodo.getChild("SecurityCredentials").getText());
		
		cat.debug("initialContextFactory[" + initialContextFactory + "]");
		cat.debug("jndi[" + jndi + "]");
		cat.debug("url[" + url + "]");
		cat.debug("securityPrincipal[" + securityPrincipal + "]");
		cat.debug("securityCredentials[" + securityCredentials + "]");
		
		Object facadeHome;
		try {
			String clase = metodo.getChild("FacadeHome").getText();
			cat.debug("clase[" + clase + "]");
			
			facadeHome = ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, Class.forName(clase));
			
			cat.debug("Recuperada la interfaz home de " + jndi);
			
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}
		
		Object facade = null;
		
		try {
			facade = facadeHome.getClass().getMethod("create", null).invoke(facadeHome,null);
		} catch (Exception e) {
			if (e instanceof CreateException){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("CreateException[" + loge + "]");
				throw new IssCusOrdException(e);
			}
			if (e instanceof RemoteException){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("RemoteException[" + loge + "]");
				throw new IssCusOrdException(e);
			}
			if (e instanceof Exception){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("Exception[" + loge + "]");
				throw new IssCusOrdException(e);
			}
		}
		cat.debug("obtenerFacade():end");
		return facade;
	}
	

	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
