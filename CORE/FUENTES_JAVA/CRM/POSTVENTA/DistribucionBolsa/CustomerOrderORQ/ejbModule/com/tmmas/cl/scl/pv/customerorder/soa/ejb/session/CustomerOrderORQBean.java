/**
 * 
 */
package com.tmmas.cl.scl.pv.customerorder.soa.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.jms.QueueSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ActualizarSSClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CargosRecCliAboDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.pv.customerorder.negocio.ejb.session.CustomerOrderFacadeSTL;
import com.tmmas.cl.scl.pv.customerorder.negocio.ejb.session.CustomerOrderFacadeSTLHome;
import com.tmmas.cl.scl.pv.customerorder.service.servicios.BillingProductChargeFacadeSTL;
import com.tmmas.cl.scl.pv.customerorder.service.servicios.BillingProductChargeFacadeSTLHome;
import com.tmmas.cl.scl.pv.customerorder.soa.ejb.cmd.ActivarSSQueueCMD;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacade;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacadeHome;



/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CustomerOrderORQ"	
 *           description="An EJB named CustomerOrderORQ"
 *           display-name="CustomerOrderORQ"
 *           jndi-name="CustomerOrderORQ"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class CustomerOrderORQBean implements javax.ejb.SessionBean {
	
	private final Logger logger = Logger.getLogger(CustomerOrderORQBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;	
	
	public CustomerOrderORQBean() 
	{
		logger.debug("CustomerOrderORQBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("DistribucionBolsa.properties");
		UtilLog.setLog(config.getString("CustomerOrderORQ.log"));
		logger.debug("CustomerOrderORQBean():End");
	}		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}
	
		private CustomerOrderFacadeSTL getCustomerOrderFacade()
		throws CustomerOrderException 
	{	
		logger.debug("getCustomerOrderFacade():start");
		
		CustomerOrderFacadeSTLHome customerOrderFacadeHome = null;		
		String jndi = config.getString("jndi.facade"); 
		
		logger.debug("Buscando servicio[" + jndi + "]");		
		String url = config.getString("url.provider");
		logger.debug("Url provider[" + url + "]");
		
		try {
			customerOrderFacadeHome = (CustomerOrderFacadeSTLHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, CustomerOrderFacadeSTLHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		
		logger.debug("Recuperada interfaz home de Customer Order facade...");
		CustomerOrderFacadeSTL customerOrderFacade = null;
		try {
			customerOrderFacade = customerOrderFacadeHome.create();
		} catch (CreateException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
		
			throw new CustomerOrderException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		
		logger.debug("getCustomerOrderFacade()():end");
		return customerOrderFacade;
	}
	
	
	private TOLFacade getTOLFacade() 
		throws TOLException 
	{	
		
		logger.debug("getTOLFacade():start");
		
		TOLFacadeHome facadeHome = null;		
		String jndi = config.getString("jndi.TOLfacade"); 
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.provider");
		logger.debug("Url provider[" + url + "]");
		
		try {
			facadeHome = (TOLFacadeHome) ServiceLocator.getInstance()
					.getRemoteHome(url, jndi, TOLFacadeHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new TOLException(e);
		}
		
		logger.debug("Recuperada interfaz home de TOL Order facade...");
		TOLFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new TOLException(e);
		
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}
		
		logger.debug("getTOLFacade()():end");
		return facade;
	}
	
	private BillingProductChargeFacadeSTL getBillingProductChargeFacade()
		throws BillingProductChargeException 
	{	
				
		logger.debug("getBillingProductChargeFacade():start");		
		BillingProductChargeFacadeSTLHome facadeHome = null;
		String jndi = config.getString("jndi.Billingfacade"); 
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.provider");
		logger.debug("Url provider[" + url + "]");
		
		try {
			facadeHome = (BillingProductChargeFacadeSTLHome) ServiceLocator
					.getInstance().getRemoteHome(url, jndi,
							BillingProductChargeFacadeSTLHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new BillingProductChargeException(e);
		}
		
		logger.debug("Recuperada interfaz home de BillingProductCharge Order facade...");
		BillingProductChargeFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new BillingProductChargeException(e);
		
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new BillingProductChargeException(e);
		}
		
		logger.debug("getBillingProductChargeFacade()():end");
		return facade;
	}
	
	 
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setServiceBundle(ActualizarSSClienteDTO dto)
		throws CustomerOrderException, TOLException, BillingProductChargeException, RemoteException 
	{	
		
		logger.debug("setServiceBundle():start");
		try {
			ProductListDTO prodList = new ProductListDTO();
			CargosRecCliAboDTO cargos = new CargosRecCliAboDTO();
			
			prodList.setCustomer(dto.getClienteServicio());
			prodList.setOrdenServicio(dto.getOoss());
			prodList.setProducts(dto.getServActivar());
			prodList.setProductsDisabled(dto.getServDesactivar());
			
			cargos.setCod_clientepago(dto.getClientePago().getCode());
			cargos.setCod_clienteserv(dto.getClienteServicio().getCode());
			cargos.setNum_abonadopago(dto.getClientePago().getAbonado().getNum_abonado());
			cargos.setNum_abonadoserv(dto.getClienteServicio().getAbonado().getNum_abonado());
			cargos.setSsActivar(dto.getServActivar());
			cargos.setSsDesactivar(dto.getServDesactivar());
			
			
			logger.debug("setCustomerAccountProductBundle():antes");
			getCustomerOrderFacade().setCustomerAccountProductBundle(prodList);
			logger.debug("setCustomerAccountProductBundle():despues");
		
			boolean rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setCustomerAccountProductBundle rollbacked...");
				return;
			}
		
			logger.debug("setServiceBundle:antes");
			getTOLFacade().setServiceBundle(prodList);
			logger.debug("setServiceBundle:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setServiceBundleAttributes rollbacked...");
				return;
			}
		
			logger.debug("setBillingProductCharge:antes");
			getBillingProductChargeFacade().setBillingProductCharge(cargos);
			logger.debug("setBillingProductCharge:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setBillingProductCharge rollbacked...");
				return;
			}			
			
			
			logger.debug("saveCustomerOrderProduct:antes");
			getCustomerOrderFacade().saveCustomerOrderProduct(
					prodList.getOrdenServicio());
			logger.debug("saveCustomerOrderProduct:despues");
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("saveCustomerOrderProduct rollbacked...");
				return;
			}
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (BillingProductChargeException e) {
			logger.debug("BillingProductChargeException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setServiceBundle():end");
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setProductBundleAttributes(ProductListDTO prodList)
		throws CustomerOrderException, TOLException, RemoteException
	{	
			
		logger.debug("setProductBundleAttributes():start");
		try {
			//Servicio se encarga de validar que no existan cambios durante el ciclo
			logger.debug("validServiceBundleAttributes:antes!!");
			getTOLFacade().validServiceBundleAttributes(prodList);
			
			logger.debug("setInstalledCustomerAccountProductBundle:antes!!");
			CustomerOrderFacadeSTL facade = getCustomerOrderFacade();
			logger.debug("setInstalledCustomerAccountProductBundle:antes de setInstalledCustomerAccountProductBundle");
			facade.setInstalledCustomerAccountProductBundle(prodList);
			logger.debug("setInstalledCustomerAccountProductBundle:despues");
			boolean rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setInstalledCustomerAccountProductBundle rollbacked...");
				return;
			}
			logger.debug("setServiceBundleAttributes:antes");
			getTOLFacade().setServiceBundleAttributes(prodList);
			logger.debug("setServiceBundleAttributes:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setServiceBundleAttributes rollbacked...");
				return;
			}
		
			logger.debug("saveCustomerOrderProduct:antes");
			getCustomerOrderFacade().saveCustomerOrderProduct(
					prodList.getOrdenServicio());
			logger.debug("saveCustomerOrderProduct:despues");
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("saveCustomerOrderProduct rollbacked...");
				return;
			}
		
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new CustomerOrderException(e);
		}
		
		logger.debug("setProductBundleAttributes():end");
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setInvolvementProductBundleAttributes(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{	
		
		logger.debug("setInvolvementProductBundleAttributes():start");
		try {
		
			logger.debug("setInvolvementProductBundleAttributes:antes");
			CustomerOrderFacadeSTL facade = getCustomerOrderFacade();
			logger.debug("setInvolvementProductBundleAttributes:antes de setInvolvementProductBundleAttributes");
			facade.setInvolvementProductBundleAttributes(prodList);
			logger.debug("setInvolvementProductBundleAttributes:despues");
		
			boolean rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setInvolvementProductBundleAttributes rollbacked...");
				return;
			}
		
			logger.debug("saveCustomerOrderProduct:antes");
			getCustomerOrderFacade().saveCustomerOrderProduct(
					prodList.getOrdenServicio());
			logger.debug("saveCustomerOrderProduct:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("saveCustomerOrderProduct rollbacked...");
				return;
			}
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setInvolvementProductBundleAttributes():start");
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setFreeUnitStock(DistribucionBolsaDTO dto)
		throws CustomerOrderException, RemoteException, TOLException 	
	{
		logger.debug("setFreeUnitStock():start");	
		try {
		
			logger.debug("setFreeUnitStock:antes");
			getTOLFacade().setFreeUnitStock(dto);
			logger.debug("setFreeUnitStock:despues");
		
			boolean rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setFreeUnitStock rollbacked...");
				return;
			}
		
			logger.debug("saveCustomerOrderProduct:antes");
			getCustomerOrderFacade().saveCustomerOrderProduct(
					dto.getServiceOrder());
			logger.debug("saveCustomerOrderProduct:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("saveCustomerOrderProduct rollbacked...");
				return;
			}
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setFreeUnitStock():start");
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProductListDTO getUnInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) 
		throws CustomerOrderException,TOLException, RemoteException
	{	
		
		logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado = null;
		ProductListDTO resultado2 = null;
		try {
			logger.debug("getUnInstalledCustomerAccountProductBundle():antes");
			resultado = getCustomerOrderFacade()
					.getUnInstalledCustomerAccountProductBundle(cust);
			logger.debug("getUnInstalledCustomerAccountProductBundle():despues");
		
			logger.debug("getDefaultServiceLimitProfile():antes");
			resultado2 = getTOLFacade()
					.getDefaultServiceLimitProfile(resultado);
			logger.debug("getDefaultServiceLimitProfile():despues");
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getUnInstalledCustomerAccountProductBundle():end");
		return resultado2;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setServiceLimitTemporally(LimiteClienteDTO dto)  
		throws CustomerOrderException, TOLException, RemoteException
	{
	
		logger.debug("setServiceLimitTemporally():start");
		try {
		
			logger.debug("setServiceLimitTemporally:antes");
			getTOLFacade().setServiceLimitTemporally(dto);
			logger.debug("setServiceLimitTemporally:despues");
		
			boolean rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("setServiceLimitTemporally rollbacked...");
				return;
			}
		
			logger.debug("saveCustomerOrderProduct:antes");
			getCustomerOrderFacade().saveCustomerOrderProduct(dto.getOoss());
			logger.debug("saveCustomerOrderProduct:despues");
		
			rollback = context.getRollbackOnly();
			logger.debug("rollback[" + rollback + "]");
			if (rollback) {
				logger.debug("saveCustomerOrderProduct rollbacked...");
				return;
			}
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw e;
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw new CustomerOrderException(e);
		}
		logger.debug("setServiceLimitTemporally():start");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void uninstallServiceBundle(ProductListDTO list) 
		throws BillingProductChargeException, TOLException, RemoteException
	{
	
		
		logger.debug("uninstallServiceBundle():start");
		
		CargosRecCliAboDTO cargos = ProductListDTO_TO_CargosRecCliAboDTO(list);
		
		try
		{
			getTOLFacade().uninstallServiceBundle(list);
			getBillingProductChargeFacade().setBillingProductCharge(cargos);
		} catch (TOLException e) {
			logger.debug("TOLException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw e;
		} catch (BillingProductChargeException e) {
			logger.debug("BillingProductChargeException");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("log error", e);
			throw new TOLException(e);
		}		
		
		logger.debug("uninstallServiceBundle():start");
	}	
	
	private CargosRecCliAboDTO ProductListDTO_TO_CargosRecCliAboDTO(ProductListDTO list)
	{
		CargosRecCliAboDTO cargos = new CargosRecCliAboDTO();
		cargos.setSsActivar(list.getProducts());
		cargos.setSsDesactivar(list.getProductsDisabled());
		cargos.setCod_clientepago(list.getCustomer().getCode());
		cargos.setCod_clienteserv(list.getCustomer().getCode());
		cargos.setNum_abonadopago(list.getCustomer().getAbonado().getNum_abonado());
		cargos.setNum_abonadoserv(list.getCustomer().getAbonado().getNum_abonado());
		
		return cargos;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void installServiceBundleJms(ProductListDTO list) 
		throws BillingProductChargeException, TOLException, RemoteException
	{
		String sNombreMethodo = new String("installServiceBundle:");
		ParametroProcesoDTO parametro = new ParametroProcesoDTO();
		
		
		logger.info(sNombreMethodo+"star");
		logger.debug(sNombreMethodo+"Genero dto para registrar proceso!!");
			
		parametro.setParametro(list);
		logger.info(sNombreMethodo+"star1");
		//parametro.setGlosa_proceso (global.getInstallServiceBungleCode());
		parametro.setGlosa_proceso(config.getString("code.installServiceBundle"));
		logger.info(sNombreMethodo+"star2");
		//parametro.setObservacion ("Proceso [" + global.getInstallServiceBungleCode() + "] inscrito, con los siguientes datos : cliente = " + list.getCustomer().getCode() + ",abonado = " + list.getCustomer().getAbonado().getNum_abonado() + ", cantidad de servicios = " + list.getProducts().length );
		parametro.setObservacion ("Proceso [" + config.getString("code.installServiceBundle") + "] inscrito, con los siguientes datos : cliente = " + list.getCustomer().getCode() + ",abonado = " + list.getCustomer().getAbonado().getNum_abonado() + ", cantidad de servicios = " + list.getProducts().length );
		logger.info(sNombreMethodo+"star3");
		
		parametro = inscribeProceso(parametro);
			
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto ActivarSSQueueCmd");
			
			ActivarSSQueueCMD generaQuueeCmd = new ActivarSSQueueCMD(parametro);
			
			//logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueInstallServiceBundle());
			//MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueInstallServiceBundle());
			
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +config.getString("jndi.factory")+ " Queue :" + config.getString("queue.installServiceBundle")  );
			MessagePublisher messagePublisher = new MessagePublisher(config.getString("jndi.factory"), config.getString("queue.installServiceBundle"));
				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
			parametro.setEstado(4);
			parametro.setObservacion("Error en la inscripción");
			parametro.setError_tecnico(e.getMessage());
			actualizaProceso(parametro);
		}
		
		logger.info(sNombreMethodo+"():end");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void executeInstallServiceBundle(ProductListDTO list) 
		throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("executeInstallServiceBundle");
		
		logger.info(sNombreMethodo+"():start");
		try 
		{			
			CargosRecCliAboDTO cargos = new CargosRecCliAboDTO();							
		    cargos.setCod_clientepago(list.getCustomer().getCode());
		    cargos.setCod_clienteserv(list.getCustomer().getCode());
		    cargos.setNum_abonadopago(list.getCustomer().getAbonado().getNum_abonado());
		    cargos.setNum_abonadoserv(list.getCustomer().getAbonado().getNum_abonado());					    		  
		    cargos.setSsActivar(list.getProducts());
		    
		    getTOLFacade().installServiceBundle(list);
			getBillingProductChargeFacade().setBillingProductCharge(cargos);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			logger.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			logger.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio " + sNombreMethodo,	e);
		}
		
		logger.info(sNombreMethodo+"():end");
	}		
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroProcesoDTO inscribeProceso(ParametroProcesoDTO dto)
		throws TOLException, RemoteException
	{
		ParametroProcesoDTO respuesta;	

		logger.debug("inscribeProceso:star");
		respuesta = getTOLFacade().inscribeProceso(dto);
		logger.debug("inscribeProceso:end");
		return respuesta;
		
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroProcesoDTO actualizaProceso(ParametroProcesoDTO dto) 
		throws TOLException, RemoteException
	{	
		ParametroProcesoDTO respuesta;
		logger.debug("inscribeProceso:star");
		respuesta = getTOLFacade().actualizaProceso(dto);
		logger.debug("inscribeProceso:end");
		return respuesta;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void installServiceBundle(ProductListDTO list) 
		throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("installServiceBundleJms");		
	
		logger.info(sNombreMethodo+"():start");
		try 
		{
			getTOLFacade().installServiceBundle(list);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			logger.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			logger.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio " + sNombreMethodo,	e);
		}
		
		logger.info(sNombreMethodo+"():end");
	}
	
	

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub

	}
	
}
