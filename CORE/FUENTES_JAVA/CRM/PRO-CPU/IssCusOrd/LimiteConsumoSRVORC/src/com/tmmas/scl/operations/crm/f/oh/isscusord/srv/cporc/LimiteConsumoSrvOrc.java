package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces.LimiteConsumoSrvOrcIF;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacade;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session.ManCusInvFacadeHome;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;

public class LimiteConsumoSrvOrc implements LimiteConsumoSrvOrcIF{
	
	transient static Logger cat = Logger.getLogger(LimiteConsumoSrvOrc.class);
	SessionContext context;
	
	public RetornoDTO mantenerLimiteDeConsumo(ProductoContratadoListDTO listaProdContraMantenidosLC) throws IssCusOrdException {
		
		cat.debug("mantenerLimiteDeConsumo():start");		
		RetornoDTO retornoPrincipal= new RetornoDTO();
				
		try
		{			
			
				//Limite de Consumo
				cat.debug("getManCusInvFacade().informarLC:inicio");
				this.getManCusInvFacade().cambiarLC(listaProdContraMantenidosLC);
				cat.debug("getManCusInvFacade().informarLC:fin");
			
		
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e)
		{			
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}			
		cat.debug("mantenerLimiteDeConsumo():end");	
		
		return retornoPrincipal;
	}
	
	public RetornoDTO abonoLimiteDeConsumo(AbonoLimiteConsumoListDTO listaAboLC) throws IssCusOrdException {
		
		cat.debug("abonoLimiteDeConsumo():start");		
		RetornoDTO retornoPrincipal= new RetornoDTO();
				
		try
		{					
				//Limite de Consumo
				cat.debug("getManCusInvFacade().informarAbonoLimiteConsumo:inicio");
				this.getManCusInvFacade().informarAbonoLimiteConsumo(listaAboLC);
				cat.debug("getManCusInvFacade().informarAbonoLimiteConsumo:fin");
			
		
		} catch (GeneralException e) {
			cat.debug("GeneralException[", e);
			throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e)
		{			
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}			
		cat.debug("abonoLimiteDeConsumo():end");	
		
		return retornoPrincipal;
	}
	
	private ManCusInvFacade getManCusInvFacade() throws ManCusInvException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManCusInvFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");		
		ManCusInvFacadeHome manCusInvFacadeHome = null;
		String jndi = global.getValor("jndi.ManCusInvFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManCusInvProvider");
		cat.debug("Url provider[" + url + "]");		
		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manCusInvFacadeHome = (ManCusInvFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManCusInvFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("Recuperada interfaz home de Iss Customer Order Facade...");
		ManCusInvFacade manCusInvFacade = null;
		try 
		{
			manCusInvFacade = manCusInvFacadeHome.create();
			//issCusOrdFacade.setSessionContext(this.context);
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e); 
			cat.debug("CreateException[" + loge + "]");		
			throw new ManCusInvException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new ManCusInvException(e);
		}		
		cat.debug("getIssCusOrdFacade():end");
		return manCusInvFacade;
	}

	public void setContext(SessionContext context) {
		// TODO Auto-generated method stub
		
	}	

}
