/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.f.s.manpro.web.delegate;
import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.jms.QueueSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ProrrateoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GenericDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacade;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session.AppPriDisRebFacadeHome;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.common.exception.AppPriDisRebException;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacade;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacade;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.bean.ejb.session.DetCusOrdFeaFacadeHome;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.Global;
import com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.session.NegSalFacade;
import com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.session.NegSalFacadeHome;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.ContratacionOfertaComercialVenAsinSRVORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacade;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session.SupCusIntManFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session.SupBillAndColFacade;
import com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session.SupBillAndColFacadeHome;
import com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception.SupBillAndColException;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.session.AllSpeSerParFacade;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.bean.ejb.session.AllSpeSerParFacadeHome;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.common.exception.AllSpeSerParException;

public class ManageProspectBussinessDelegate {

	private static ManageProspectBussinessDelegate instance = null;
	private static Logger logger = Logger.getLogger(ManageProspectBussinessDelegate.class);
	private Global global = Global.getInstance();
	
	private ManConFacade manConFacade=null;
	private SupCusIntManFacade supCusIntManFacade=null;
	private ManProOffInvFacade manProOffInvFacade=null;
	private SupBillAndColFacade supBillAndColFacade=null;
	private AllSpeSerParFacade allSpeSerParFacade=null;
	private SupOrdHanFacade supOrdHanFacade=null;
	private CusRelManFacade cusRelManWSFacade=null;
	private AppPriDisRebFacade appPriDisRebFacade=null;
	private DetCusOrdFeaFacade detCusOrdFeaFacade=null;

	
	protected ServiceLocator svcLologgeror = ServiceLocator.getInstance();

	public static ManageProspectBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new ManageProspectBussinessDelegate();
		}
		return instance;
	}	
	
	private AllSpeSerParFacade getAllSpeSerParFacade() throws AllSpeSerParException 
	{
		if(this.allSpeSerParFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);				
				logger.debug("getSupBillAndColFacade():start");				
				String jndi = global.getValor("jndi.AllSpeSerParFacade");
				logger.debug("Buscando servicio[" + jndi + "]");				
				String url = global.getValor("url.AllSpeSerParProvider");
				logger.debug("Url provider[" + url + "]");				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");					
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				AllSpeSerParFacadeHome facadeHome =
					(AllSpeSerParFacadeHome) PortableRemoteObject.narrow(obj, AllSpeSerParFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de AllSpeSerParFacade...");
				AllSpeSerParFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new AllSpeSerParException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new AllSpeSerParException(e);
				}
		
				logger.debug("getSupBillAndColFacade():end");
				this.allSpeSerParFacade=facade;
				return facade;
		}
		else
		{
			return this.allSpeSerParFacade;
		}
	}
	
	private SupBillAndColFacade getSupBillAndColFacade() throws SupBillAndColException 
	{
		if(this.supBillAndColFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("getSupBillAndColFacade():start");				
				String jndi = global.getValor("jndi.SupBillAndColFacade");
				logger.debug("Buscando servicio[" + jndi + "]");				
				String url = global.getValor("url.SupBillAndColProvider");
				logger.debug("Url provider[" + url + "]");				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");					
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				SupBillAndColFacadeHome facadeHome =
					(SupBillAndColFacadeHome) PortableRemoteObject.narrow(obj, SupBillAndColFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de ManConFacade...");
				SupBillAndColFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new SupBillAndColException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new SupBillAndColException(e);
				}
		
				logger.debug("getSupBillAndColFacade():end");
				this.supBillAndColFacade=facade;
				return facade;
		}
		else
		{
			return this.supBillAndColFacade;
		}
	}
	
	private ManConFacade getManConFacade() throws ManConException 
	{
		if(this.manConFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);
				
				logger.debug("getManConFacade():start");
				
				String jndi = global.getValor("jndi.ManConFacade");
				logger.debug("Buscando servicio[" + jndi + "]");
				
				String url = global.getValor("url.ManConProvider");
				logger.debug("Url provider[" + url + "]");
				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");
				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");	
				
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");			
				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				ManConFacadeHome facadeHome =
					(ManConFacadeHome) PortableRemoteObject.narrow(obj, ManConFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de ManConFacade...");
				ManConFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new ManConException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new ManConException(e);
				}
		
				logger.debug("getManConFacade():end");
				this.manConFacade=facade;
				return facade;
		}
		else
		{
			return this.manConFacade;
		}
	}
	
	private SupCusIntManFacade getSupCusIntManFacade() throws SupCusIntManException
	{
		if(this.supCusIntManFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);				
				logger.debug("getSupCusIntManFacade():start");				
				String jndi = global.getValor("jndi.SupCusIntManFacade");
				logger.debug("Buscando servicio[" + jndi + "]");				
				String url = global.getValor("url.SupCusIntManProvider");
				logger.debug("Url provider[" + url + "]");				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");					
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				SupCusIntManFacadeHome facadeHome =
					(SupCusIntManFacadeHome) PortableRemoteObject.narrow(obj, SupCusIntManFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de ManConFacade...");
				SupCusIntManFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new SupCusIntManException(e);
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("SupCusIntManException[" + loge + "]");
					throw new SupCusIntManException(e);
				}
		
				logger.debug("getSupCusIntManFacade():end");
				this.supCusIntManFacade=facade;
				return facade;
		}
		else
		{
			return this.supCusIntManFacade;
		}
	}
	
//	ManageProductOfferingInventoryFacade	
	private ManProOffInvFacade getManProOffInvFacade() throws ManProOffInvException 
	{
		if(this.manProOffInvFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);
				
				logger.debug("getManProOffInvFacade():start");
				
				String jndi = global.getValor("jndi.ManProOffInvFacade");
				logger.debug("Buscando servicio[" + jndi + "]");
				
				String url = global.getValor("url.ManProOffInvProvider");
				logger.debug("Url provider[" + url + "]");
				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");
				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");	
				
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");			
				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				ManProOffInvFacadeHome facadeHome =
					(ManProOffInvFacadeHome) PortableRemoteObject.narrow(obj, ManProOffInvFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de ManProOffInvFacade...");
				ManProOffInvFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new ManProOffInvException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new ManProOffInvException(e);
				}
		
				logger.debug("getManProOffInvFacade()():end");
				
				this.manProOffInvFacade=facade;
				return facade;
		}
		else
		{
			return this.manProOffInvFacade;
		}
	}
	
	private SupOrdHanFacade getSupOrdHanFacade() throws SupOrdHanException 
	{
		if(this.supOrdHanFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("getSupOrdHanFacade():start");				
				String jndi = global.getValor("jndi.SupOrdHanFacade");
				logger.debug("Buscando servicio[" + jndi + "]");				
				String url = global.getValor("url.SupOrdHanProvider");
				logger.debug("Url provider[" + url + "]");				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");					
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				SupOrdHanFacadeHome facadeHome =
					(SupOrdHanFacadeHome) PortableRemoteObject.narrow(obj, SupOrdHanFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de ManConFacade...");
				SupOrdHanFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new SupOrdHanException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new SupOrdHanException(e);
				}
		
				logger.debug("getSupBillAndColFacade():end");
				this.supOrdHanFacade=facade;
				return facade;
		}
		else
		{
			return this.supOrdHanFacade;
		}
	}
	
	
//	ManageProductOfferingInventoryFacade cambiar nombre 	a getCusRelManFacade
	private CusRelManFacade getCusRelManWSFacade() throws ManProOffInvException 
	{
		if(this.cusRelManWSFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);
				
				logger.debug("getManProOffInvFacade():start");
				
				String jndi = global.getValor("jndi.CusRelManFacade");
				logger.debug("Buscando servicio[" + jndi + "]");
				
				String url = global.getValor("url.CusRelManEJBProvider");
				logger.debug("Url provider[" + url + "]");
				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");
				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");	
				
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");			
				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				CusRelManFacadeHome facadeHome =
					(CusRelManFacadeHome) PortableRemoteObject.narrow(obj, CusRelManFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de getCusRelManWSFacade...");
				CusRelManFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new ManProOffInvException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new ManProOffInvException(e);
				}
		
				logger.debug("getCusRelManWSFacade()():end");
				
				this.cusRelManWSFacade=facade;
				return facade;
		}
		else
		{
			return this.cusRelManWSFacade;
		}
	}

	private AppPriDisRebFacade getAppPriDisRebFacade() throws AppPriDisRebException 
	{
		if(this.appPriDisRebFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);
				
				logger.debug("getAppPriDisRebFacade():start");
				
				String jndi = global.getValor("jndi.AppPriDisRebFacade");
				logger.debug("Buscando servicio[" + jndi + "]");
				
				String url = global.getValor("url.AppPriDisRebProvider");
				logger.debug("Url provider[" + url + "]");
				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");
				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");	
				
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");			
				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				AppPriDisRebFacadeHome facadeHome =
					(AppPriDisRebFacadeHome) PortableRemoteObject.narrow(obj, AppPriDisRebFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de getAppPriDisRebFacade...");
				AppPriDisRebFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new AppPriDisRebException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new AppPriDisRebException(e);
				}
		
				logger.debug("getAppPriDisRebFacade():end");
				
				this.appPriDisRebFacade=facade;
				return facade;
		}
		else
		{
			return this.appPriDisRebFacade;
		}
	}
	
	
	private NegSalFacade getNegSalFacade() throws GeneralException {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getNegSalFacade():start");
		
		String jndi = global.getValor("jndi.NegSalFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.NegSalProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
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
		
		NegSalFacadeHome facadeHome =
			(NegSalFacadeHome) PortableRemoteObject.narrow(obj, NegSalFacadeHome.class);	
		
		
		logger.debug("Recuperada interfaz home de NegSalFacade...");
		NegSalFacade facade = null;
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

		logger.debug("getNegSalFacade():end");
		return facade;
	}
	
	private DetCusOrdFeaFacade getDetCusOrdFeaFacade() throws DetCusOrdFeaException 
	{
		if(this.detCusOrdFeaFacade==null)
		{
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);
				
				logger.debug("getDetCusOrdFeaFacade():start");
				
				String jndi = global.getValor("jndi.DetCusOrdFeaFacade");
				logger.debug("Buscando servicio[" + jndi + "]");
				
				String url = global.getValor("url.DetCusOrdFeaProvider");
				logger.debug("Url provider[" + url + "]");
				
				String initialContextFactory = global.getValor("initial.context.factory");
				logger.debug("Initial context factory[" + initialContextFactory + "]");
				
				String securityPrincipal = global.getValor("security.principal");
				logger.debug("Security principal[" + securityPrincipal + "]");	
				
				String securityCredentials = global.getValor("security.credentials");
				logger.debug("Security credentials[" + securityCredentials + "]");			
				
		
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
				env.put(Context.PROVIDER_URL, url);
				env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
				env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
				
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
				
				DetCusOrdFeaFacadeHome facadeHome =
					(DetCusOrdFeaFacadeHome) PortableRemoteObject.narrow(obj, DetCusOrdFeaFacadeHome.class);	
				
				logger.debug("Recuperada interfaz home de getCusRelManWSFacade...");
				DetCusOrdFeaFacade facade = null;
				try {
					facade = facadeHome.create();
				} catch (CreateException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("CreateException[" + loge + "]");
					throw new DetCusOrdFeaException(e);
					
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new DetCusOrdFeaException(e);
				}
		
				logger.debug("getCusRelManWSFacade()():end");
				
				this.detCusOrdFeaFacade=facade;
				return facade;
		}
		else
		{
			return this.detCusOrdFeaFacade;
		}
	}
	
	
	
//--------------------------------------------------------------------------------------------------------------------------------------------------
	
	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws AllSpeSerParException
	{
		EspecProvisionamientoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("EspecProvisionamientoListDTO():start");
		try {
			resultado = getAllSpeSerParFacade().obtenerEspecificacionesProvisionamiento(espSerCliList);
		}catch(AllSpeSerParException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new AllSpeSerParException(e);
		}
		
		logger.debug("EspecProvisionamientoListDTO():end");
		return resultado;
	}
	
	//------------------------------
	
	/**
	 * Este método retorna la lista de Cargos a través de una lista de Productos Ofertado. 
	 * La obtención de cargos ocurre en el contexto del proceso definido por eTOM, <b>Support Billing & Collections</b>. 
	 * @param ProductoOfertadoListDTO este objeto representa una lista de productos ofertados.
	 * 		   En este objeto se define un arreglo ProductoOfertadoDTO y una lista de especificación de productos (EspecProductoDTO) 
	 * 		   y la lista de cargos para cada producto.  
	 * @return CargoListDTO Lista de Cargos asociados a la lista de productos ofertados
	 * @throws SupBillAndColException 
	 * @see com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session.SupBillAndColFacade 
	 */	
	public CargoListDTO  obtenerCargosProductos(ProductoOfertadoListDTO prodOfeProdList) throws SupBillAndColException
	{
		CargoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCargosProductos():start");
		try {
			resultado = getSupBillAndColFacade().obtenerCargosProductos(prodOfeProdList);
		}catch(SupBillAndColException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupBillAndColException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupBillAndColException(e);
		}
		
		
		logger.debug("obtenerCargosProductos():end");
		return resultado;
	}
	
	
	//----
	/**
	 * Obtiene tipo de numero
	 * 
	 */
	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws SupCusIntManException
	{
		NumeroDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTipoNumero():start");
		try {
			resultado = getSupCusIntManFacade().obtenerTipoNumero(numero);
		}catch(SupCusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupCusIntManException(e);
		}
		
		logger.debug("obtenerTipoNumero():end");
		return resultado;
	}
	
//	/**
//	 * Obtiene tipo numero
//	 * 
//	 * @param numero
//	 * @return NumeroDTO
//	 * @throws ManReqException
//	 */
//	public NumeroDTO obtenerTipoNumero(NumeroDTO parametro) throws ManReqException{	
//	
//		NumeroDTO resultado = null;
//		String log = global.getValor("web.log");
//		log=global.getPathInstancia()+ log;
//		PropertyConfigurator.configure(log);		
//		logger.debug("obtenerSecuencia():start");
//		try {
//			resultado = getSupCusIntManFacade().obtenerTipoNumero(parametro);//getSupOrdHanFacade().obtenerSecuencia(parametro);
//		}catch(ManReqException e){
//			String loge = StackTraceUtl.getStackTrace(e);
//			logger.debug("ManReqException[" + loge + "]");
//			throw e;
//		}catch(SupCusIntManException e){
//			String loge = StackTraceUtl.getStackTrace(e);
//			logger.debug("SupCusIntManException[" + loge + "]");
//			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
//		} catch (RemoteException e) {
//			String loge = StackTraceUtl.getStackTrace(e);
//			logger.debug("RemoteException[" + loge + "]");
//			throw new ManReqException(e);
//		}
//		logger.debug("obtenerTipoNumero():end");
//		return resultado;
//	}
	
	public ClienteDTO validarCliente(ClienteDTO cliente) throws SupCusIntManException
	{
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarCliente():start");
		try {
			resultado = getSupCusIntManFacade().validarCliente(cliente);
		}catch(SupCusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupCusIntManException(e);
		} 
		
		
		logger.debug("validarCliente():end");
		return resultado;
	}
	
	
	/**
	 * Obtiene lista de clientes cuenta
	 * 
	 * @param cliente
	 * @return ClienteTipoPlanListDTO
	 * @throws ManConException 
	 * @throws ProyectoException
	 */
	public ClienteDTO obtenerDatosClienteCuenta(
			VentaDTO venta) throws  ManConException{	
	
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosClienteCuenta():start");
		
			try {
				resultado = getManConFacade().obtenerDatosCliente(venta);
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ProyectoException[" + loge + "]");
				throw new ManConException();
			}
			
		logger.debug("obtenerDatosClienteCuenta():end");
		return resultado;
	}
	
	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws  ManConException
	{			
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerNumeroMovimientoAlta():start");		
		try 
		{
			abonado = getManConFacade().obtenerNumeroMovimientoAlta(abonado);
		}
		catch (RemoteException e) 
		{
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ProyectoException[" + loge + "]");
				throw new ManConException();
		}
		
		
		logger.debug("obtenerNumeroMovimientoAlta():end");
		return abonado;
	}
	
	public ClienteListDTO buscarCliente(NumeroDTO numero) throws  ManConException
	{
		ClienteListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("buscarCliente():start");
		try {
			resultado = getManConFacade().buscarCliente(numero);
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManConException(e);
		}
		
		
		logger.debug("buscarCliente():end");
		return resultado;
	}
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws  ManConException
	{
		ClienteListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("buscarCliente():start");
		try {
			resultado = getManConFacade().buscarCliente(cliente);
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManConException(e);
		}
		
			
		logger.debug("buscarCliente():end");
		return resultado;
	}
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ManConException, RemoteException
    {
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getManConFacade().obtenerDatosAbonado(abonado);
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManConException(e);
		}
		
		
		logger.debug("obtenerDatosAbonado():end");
		return resultado;
    }
	
	
//---------------------
	
	/**
	 * Obtiene lista de productos ofertables
	 * 
	 * @param cliente
	 * @return ProductoOfertadoListDTO
	 * @throws GeneralException 
	 * @throws ProyectoException
	 */
	public ProductoOfertadoListDTO obtenerProductosOfertables(
			AbonadoDTO abonado) throws ManProOffInvException{	
	
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosOfertables():start");
		try {
			resultado = getManProOffInvFacade().obtenerProductosOfertables(abonado);
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManProOffInvException(e);
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManProOffInvException(e);
		}
		
		logger.debug("obtenerProductosOfertables():end");
		return resultado;
	}
	
	/**
	 * Obtiene lista de productos ofertables
	 * 
	 * @param cliente
	 * @return ProductoOfertadoListDTO
	 * @throws ProductException 
	 * @throws SupOrdHanException 
	 */
	public TipIdentListDTO obtenerTiposDeIdentidad() throws SupOrdHanException{	
	
		TipIdentListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDeIdentidad():start");
		try {
			resultado = getSupOrdHanFacade().obtenerTiposDeIdentidad();
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupOrdHanException(e);
		}
		
		logger.debug("obtenerTiposDeIdentidad():end");
		return resultado;
	}
	
	/**
	 * Este método retorna la lista de los productos ofertados a un Abonado.
	 * La obtención de productos por defecto ocurre en el contexto del proceso definido por eTOM, <b>Manage Product Offering Inventory</b>.  
	 * @param abonado objeto del tipo AbonadoDTO
	 * @return ProductoOfertadoListDTO este objeto representa la lista de productos ofertados a un Abonado.
	 * 		   En este objeto se define un arreglo ProductoOfertadoDTO y una lista de especificación de productos (EspecProductoDTO) 
	 * 		   y la lista de cargos para cada producto ofertado.  
	 * @throws GeneralException
	 * @see com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade 
	 */	
	public ProductoOfertadoListDTO obtenerProductosPorDefecto(AbonadoDTO abonado) throws GeneralException
	{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosPorDefecto():start");
		try {
			resultado = getManProOffInvFacade().obtenerProductosPorDefecto(abonado);
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}
		
		
		logger.debug("obtenerProductosPorDefecto():end");
		return resultado;
	}
	
	/**
	 * Este método retorna un lista de productos ofertados por paquete.
	 * La obtención de productos ofertables ocurre en el contexto del proceso definido por eTOM, <b>Manage Product Offering Inventory</b>.  
	 * @param paquete objeto del tipo PaqueteDTO con toda la información asociada a un Paquete (Código de producto padre, producto hijo y lista de productos ofertados).
	 * @return ProductoOfertadoListDTO este objeto representa la lista de productos ofertados por paquete.
	 * 		   En este objeto se define un arreglo ProductoOfertadoDTO y una lista de especificación de productos (EspecProductoDTO) 
	 * 		   y la lista de cargos para cada producto ofertado. 
	 * @throws GeneralException
	 * @see com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade 
	 */	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws GeneralException
	{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosOfertablesPorPaquete():start");
		try {
			resultado = getManProOffInvFacade().obtenerProductosOfertablesPorPaquete(paquete);
		}
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		
		logger.debug("obtenerProductosOfertablesPorPaquete():end");
		return resultado;
	}

	/**
	 * Este método retorna una lista de productos ofertados.
	 * La obtención del detalle de los productos ofertados ocurre en el contexto del proceso definido por eTOM, <b>Manage Product Offering Inventory</b>. 
	 * @param param objeto del tipo ProductoOfertadoListDTO
	 * @return ProductoOfertadoListDTO este objeto representa la lista de productos ofertados.
	 * 		   En este objeto se define un arreglo ProductoOfertadoDTO y una lista de especificación de productos (EspecProductoDTO) 
	 * 		   y la lista de cargos para cada producto ofertado. 
	 * @throws GeneralException 
	 * @see com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session.ManProOffInvFacade
	 */	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO param) throws GeneralException
	{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDetalleProductos():start");
		try {
			resultado = getManProOffInvFacade().obtenerDetalleProductos(param);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		
		logger.debug("obtenerDetalleProductos():end");
		return resultado;		
	}
	
	public ReglasListaNumerosListDTO obtenerRestriccionesLista(EspecServicioListaDTO param) throws GeneralException
	{
		ReglasListaNumerosListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerRestriccionesLista():start");
		try {
			resultado = getManProOffInvFacade().obtenerRestriccionesLista(param);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProyectoException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		
		logger.debug("obtenerRestriccionesLista():end");
		return resultado;		
	}
	
	/** 
	 * Este método activa una oferta comercial. El método recibe un objeto del tipo OfertaComercialDTO, que representa una Oferta 
	 * Comercial a ser activada. 
	 * Internamente construye un mensaje del tipo ContratacionOfertaComercialVenAsinSRVORC que es enviado a la cola JMS. 
	 * El mensaje construido contiene al objeto OfertaComercialDTO que se es recibido como parámetro.
	 * @param ofertaComercial objeto del tipo OfertaComercialDTO que contiene entre otras cosas un lista de paquetes contratados, 
	 *        lista de productos contratados (PaqueteContratadoListDTO y ProductoContratadoListDTO).
	 * @throws NegSalException
	 * @see com.tmmas.scl.operations.crm.f.sel.negsal.cmd.ContratacionOfertaComercialVenAsinSRVORC 
	 */
	public void activarOfertaComercialJms(OfertaComercialDTO ofertaComercial, CargoRecurrenteDTO[] cargosCobroAdelantado) throws NegSalException
	{
		AsyncProcessParameterObject paramProceso;
		String sNombreMethodo = new String("activarOfertaComercialJms:");		
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug(sNombreMethodo+"start");
		

		logger.info(sNombreMethodo+"star");
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto ContratacionOfertaComercialVenAsinSRVORC");
			paramProceso = new AsyncProcessParameterObject(ofertaComercial);			
			ContratacionOfertaComercialVenAsinSRVORC generaQuueeCmd = new ContratacionOfertaComercialVenAsinSRVORC(paramProceso);		
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueVenta());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueVenta());				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
			throw new NegSalException(e);
		}
		
		try{
			/*Inserta los cargos con cobro adelantado*/
			if (cargosCobroAdelantado!=null){
				for(int i=0; i<cargosCobroAdelantado.length;i++){
						insertaCobroAdelantado(cargosCobroAdelantado[i]);
				}
			}
		}catch(Exception e)
		{
				logger.debug(sNombreMethodo+"Error al insertar cobro adelantado", e);
				//	throw new NegSalException(e);
		}
		
		logger.info(sNombreMethodo+"():end");
	}
	
	/**
	 * Obtiene informacion del cliente
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws ProyectoException
	 */
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManProException{
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCliente():start");
		try {
			resultado = getManConFacade().obtenerDatosCliente(cliente);
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManProException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManProException(e);
		}
		
		logger.debug("obtenerDatosCliente():end");
		return resultado;
		
	}
	
	/** 
	 * Metodo para crear un nuevo proceso en la base de datos, ademas de guardar una version binaria del VentaDTO.
	 * Al crear el proceso se hace persistente la venta en la Base de Datos (tabla PR_PROCESOS_PROD_TD).
	 * La creación del proceso ocurre en el contexto del proceso definido por eTOM, <b>Support Order Handling</b>.
	 * @author Cristian Toledo 
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que identifican la Venta.
	 * @return ParametroSerializableDTO objeto que tienen entre sus atributos un byte[] que representa un objeto serializado.
	 * @see com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade 
	 * @throws SupOrdHanException
	 */
	public ParametroSerializableDTO crearProceso(VentaDTO venta) throws SupOrdHanException
	{
		logger.debug("crearProceso: start ");
		//(byte[])SerializationUtils.serialize(parametro.getParametroObject()		
		//GenericDTO dtoGeneric=new GenericDTO();
		//dtoGeneric.setSerializableObject(ofComercial);
		ParametroSerializableDTO param=new ParametroSerializableDTO();
		param.setEstadoProceso("INSCRITO");
		param.setNumProceso(venta.getIdVenta());
		param.setOrigenProceso("VT");		
		
		//param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofComercial));	
		try {
			param=getSupOrdHanFacade().nuevoProceso(param);
		} 
		catch(Exception e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new SupOrdHanException(e);		
		}
		
		logger.debug("crearProceso: end ");
		return param;
	}
	
	/** 
	 * Este método inscribe un proceso representado por una Oferta Comercial, que es hecha Serializable antes de pasar a la fachada.
	 * La inscripción del proceso ocurre en el contexto del proceso definido por eTOM, <b>Support Order Handling</b>. 
	 * @param ofComercial objeto del tipo OfertaComercialDTO que contiene entre otras cosas un lista de paquetes contratados, 
	 *        lista de productos contratados (PaqueteContratadoListDTO y ProductoContratadoListDTO).	  
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @see com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade 
	 * @throws SupOrdHanException
	 */
	public RetornoDTO inscribeProceso(OfertaComercialDTO ofComercial) throws SupOrdHanException
	{
		logger.debug("inscribeProceso: start ");
		//(byte[])SerializationUtils.serialize(parametro.getParametroObject()		
		RetornoDTO retorno=null;
		GenericDTO dtoGeneric=new GenericDTO();
		dtoGeneric.setSerializableObject(ofComercial);
		ParametroSerializableDTO param=new ParametroSerializableDTO();
		param.setEstadoProceso("ENCOLADO");
		param.setNumProceso(ofComercial.getNumProceso());
		param.setIdProceso(ofComercial.getNumEvento());
		param.setOrigenProceso("VT");
		param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofComercial));	
		try {
			retorno=getSupOrdHanFacade().inscribeProceso(param);
		} 
		catch(Exception e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new SupOrdHanException(e);		
		}
		
				
		logger.debug("inscribeProceso: end ");
		return retorno;
	}
	
	/**
	 * Este método recibe como parámetro un objeto VentaDTO a través del cual se hará la contratación de los
	 * productos por defecto.
	 * La contratación de productos por defecto ocurre en el contexto del proceso definido por eTOM, <b>Customer Relationship Management</b>.  
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que definen la Venta.
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito.	 
	 * @see com.tmmas.scl.operations.crm.bean.ejb.session.CurRelManWSFacade
	 * @throws GeneralException
	 */	
	public RetornoDTO contrataProductosPorDefecto(VentaDTO venta) throws GeneralException
	{
		RetornoDTO retorno=null;
		DatosVentaDTO datosVenta=new DatosVentaDTO();
		
		datosVenta.setCod_cliente(String.valueOf(venta.getCliente().getCodCliente()));
		datosVenta.setNum_venta(venta.getIdVenta());
		datosVenta.setCod_proceso("VT");
		datosVenta.setCod_vendedor(venta.getNomUsuaOra());
		
		try 
		{
			retorno=this.getCusRelManWSFacade().sendToQueueActivacionProductosPorDefecto(datosVenta);
		}
		catch (Exception e) 
		{			
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new GeneralException(e);
		}
		
		return retorno;
	}
	/**
	 * @author rlozano
	 * @description Obtiene el listado de Restriciones 
	 * @param null
	 * @return RestriccionesContratacionListDTO
	 */
	
	public RestriccionesContratacionListDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restdto)throws GeneralException
	{
		RestriccionesContratacionListDTO retValue=null;
		try{
			retValue=this.getSupCusIntManFacade().obtenerRestriccionesContratacion(restdto);
		}
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new GeneralException(e);
		}
		
		return retValue;
	}
	
	/**
	 * @author rlozano
	 * @description Obtiene el o los usuarios asociados al vendedor 
	 * @param null
	 * @return GeSegUsuarioListDTO
	 */
	
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedor(GeSegUsuarioDTO geSegUsuarioDTO)throws GeneralException
	{
		GeSegUsuarioListDTO retValue=null;
		try{
			retValue=this.getSupOrdHanFacade().obtenerUsuariosPorCodVendedor(geSegUsuarioDTO);
		}
		catch(Exception e){
			throw new GeneralException(e);
		}
		
		return retValue;
	}
	
	/**
	 * @author rlozano
	 * @description Obtiene el o los usuarios asociados al vendedor 
	 * @param null
	 * @return GeSegUsuarioListDTO
	 */
	
	public RetornoDTO getUsuariosPorNumVenta(String numVenta)throws GeneralException
	{
		RetornoDTO retValue=null;
		try{
			retValue=this.getSupOrdHanFacade().getUsuariosPorNumVenta(numVenta);
		}
		catch(Exception e){
			throw new GeneralException(e);
		}
		
		return retValue;
	}
	
	
	
	
	/**
	 * Obtiene información de descuentos asociada a los privilegios de un vendedor
	 * @param vendedor
	 * @return
	 * @throws ManReqException
	 */
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor)throws SupOrdHanException{
		DescuentoVendedorDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDescuentoVendedor():start");
		try {
			retorno = getSupOrdHanFacade().obtenerDescuentoVendedor(vendedor);
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupOrdHanException(e);
		}
		logger.debug("obtenerDescuentoVendedor():end");
		return retorno;		
	}
	
	//(+) EV 06/02/09
	public RetornoDTO inscribeProceso(ParametroSerializableDTO param)throws SupOrdHanException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("inscribeProceso():start");
		try {
			retorno = getSupOrdHanFacade().inscribeProceso(param);
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new SupOrdHanException(e);
		}
		logger.debug("inscribeProceso():end");
		return retorno;		
	}
	//(+) EV 06/02/09

	public ProrrateoDTO getCargoRecurrenteProrrateo(CargoRecurrenteDTO cargoRecurrenteDTO)throws GeneralException{
		ProrrateoDTO prorrateoDTO = new ProrrateoDTO();
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("getCargoRecurrenteProrrateado():start");
			
			prorrateoDTO.setNumAbonado(Long.parseLong(cargoRecurrenteDTO.getNumAbonadoPago()));
			prorrateoDTO.setCodCargo(Long.parseLong(cargoRecurrenteDTO.getCodCargoContratado()));
			prorrateoDTO = this.getAppPriDisRebFacade().getCargoRecurrenteProrrateo(cargoRecurrenteDTO);
			logger.debug("getCargoRecurrenteProrrateado():end");
		} catch(AppPriDisRebException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
			return prorrateoDTO;	
	}

	
	public CargoImpuestoDTO getImpuestoImporte(CargoImpuestoDTO cargoImpuestoDTO)	throws GeneralException{
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("getImpuestoImporte():start");
			cargoImpuestoDTO = this.getAppPriDisRebFacade().getImpuestoImporte(cargoImpuestoDTO);
			logger.debug("getImpuestoImporte():end");
		} catch(AppPriDisRebException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
			return cargoImpuestoDTO;	
	}
	
	public String getCodigoOperadora()throws GeneralException{
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		String retValue ="";
		try 
		{
			logger.debug("getCodigoOperadora():start");
			retValue = this.getDetCusOrdFeaFacade().getCodigoOperadora();
			logger.debug("getCodigoOperadora():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
		return retValue;	
	}
	
	public DatosVentaOutDTO getCodOficinaXVendedor(DatosVentaOutDTO entrada) throws DetCusOrdFeaException{
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		DatosVentaOutDTO retValue;
		try 
		{
			logger.debug("getCodOficinaXVendedor():start");
			 retValue = this.getDetCusOrdFeaFacade().getCodOficinaXVendedor(entrada);
			
			logger.debug("getCodOficinaXVendedor():end");
		} catch(DetCusOrdFeaException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new DetCusOrdFeaException(e);
		}
			return retValue;	
	}
	
	public RetornoDTO insertaCobroAdelantado(CargoRecurrenteDTO cargoRecurrenteDTO)	throws GeneralException{
		RetornoDTO retValue= new RetornoDTO();
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("insertaCobroAdelantado():start");
			retValue = this.getAppPriDisRebFacade().insertaCobroAdelantado(cargoRecurrenteDTO);
			logger.debug("insertaCobroAdelantado():end");
		} catch(AppPriDisRebException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}		
		return retValue;	
		
	}	
	
	/**
	 * Generar Oferta Comercial
	 * 
	 * @param venta
	 * @return OfertaComercialDTO
	 * @throws ManReqException
	 */
	public OfertaComercialDTO generarOfertaComercial(VentaDTO venta) throws GeneralException{
		OfertaComercialDTO retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("generarOfertaComercial():start");
		try {
			retorno = this.getNegSalFacade().generarOfertaComercial(venta);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw e;
		}catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new NegSalException(e);
		} 
		logger.debug("generarOfertaComercial():end");
		return retorno;		
	}
	
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO listaProductos) throws GeneralException{
		ProductoOfertadoListDTO resultado = null;
		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerLCplanAdicional():start");
		try {
			resultado = getManProOffInvFacade().obtenerLCplanAdicional(listaProductos);
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManProOffInvException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}
		
		
		logger.debug("obtenerLCplanAdicional():end");
		return resultado;
	}
	
	public DatosClienteDTO obtenerDatosAdicCliente(Long codCliente)	throws ManProException {
		logger.debug("obtenerDatosAdicCliente():start");
		DatosClienteDTO retorno = null;
		try {
			retorno = getManConFacade().obtenerDatosAdicCliente(codCliente);
		}catch(ManConException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManConException[" + loge + "]");
			throw new ManProException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManProException(e);
		}
		logger.debug("obtenerDatosAdicCliente():end");
		return retorno;
	}
	
	/**
	 * Obtiene parametro general
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws ProyectoException
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws ManReqException{	
	
		ParametroDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerParametroGeneral():start");
		try {
			resultado = getSupOrdHanFacade().obtenerParametroGeneral(param);
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerParametroGeneral():end");
		return resultado;
	}
	
	/**
	 * Obtiene indCompartido plan tarifario
	 * 
	 * @param codPlanTarif
	 * @return ParametroDTO
	 * @throws ProyectoException
	 */
	public PlanTarifarioDTO obtenerDatosPlanTarifario(String codPlanTarif) throws ManReqException{	
	
		PlanTarifarioDTO resultado = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosPlanTarifario():start");
		try {
			resultado = getSupOrdHanFacade().obtenerDatosPlanTarifario(codPlanTarif);
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		logger.debug("obtenerDatosPlanTarifario():end");
		return resultado;
	}	
	
	/**
	 * Obtiene listado de tipos de comportamiento
	 * 
	 * @return TipoComportamientoListDTO
	 * @throws ManReqException
	 */
	public TipoComportamientoListDTO obtenerTiposComportamiento() throws ManReqException{	
	
		TipoComportamientoListDTO resultado = new TipoComportamientoListDTO();
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposComportamiento():start");
		try {
			resultado = getManProOffInvFacade().obtenerTiposComportamiento();
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManProOffInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		
		logger.debug("obtenerTiposComportamiento():end");
		return resultado;
	}	

	/**
	 * Obtiene listado de tipos de prestaciones
	 * 
	 * @return TipoComportamientoListDTO
	 * @throws ManReqException
	 */
	public PrestacionListDTO obtenerPrestaciones() throws ManReqException{	
	
		PrestacionListDTO resultado = new PrestacionListDTO();
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPrestaciones():start");
		try {
			resultado = getSupOrdHanFacade().obtenerPrestaciones();
		}catch(SupOrdHanException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		
		logger.debug("obtenerPrestaciones():end");
		return resultado;
	}	
	
	/**
	 * Obtiene productos pre evaluados en solictud Scoring
	 * 
	 * @return ProductoScoringListDTO
	 * @throws ManReqException
	 */
	public ProductoScoringListDTO obtenerProductosScoring(Long numAbonado) throws ManReqException{	
	
		ProductoScoringListDTO resultado = new ProductoScoringListDTO();
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerProductosScoring():start");
		try {
			resultado = getManProOffInvFacade().obtenerProductosScoring(numAbonado);
		}catch(ManProOffInvException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManProOffInvException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ManReqException(e);
		}
		
		logger.debug("obtenerProductosScoring():end");
		return resultado;
	}	
	
}