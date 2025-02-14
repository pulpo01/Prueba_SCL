package com.tmmas.cl.scl.pv.customerorder.web.delegate;

import java.rmi.RemoteException;

import javax.ejb.CreateException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ActualizarSSClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.pv.customerorder.negocio.ejb.session.CustomerOrderFacadeSTL;
import com.tmmas.cl.scl.pv.customerorder.negocio.ejb.session.CustomerOrderFacadeSTLHome;
import com.tmmas.cl.scl.pv.customerorder.soa.ejb.session.CustomerOrderORQ;
import com.tmmas.cl.scl.pv.customerorder.soa.ejb.session.CustomerOrderORQHome;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacade;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session.TOLFacadeHome;


public class CustomerOrderDelegate {

	private static CustomerOrderDelegate instance = null;

	private Category logger = Category.getInstance(CustomerOrderDelegate.class);

	protected ServiceLocator svcLocator = ServiceLocator.getInstance();

	private CompositeConfiguration config;
	
	private void CustomerOrderDelegate() {
		setPropertieFile();
	}
	
	
	
	private void setPropertieFile() 
	{
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
	}

	private CustomerOrderFacadeSTL getCustomerOrderFacade()
		throws CustomerOrderException 
	{
		setPropertieFile(); // MA
		 
		logger.debug("getCustomerOrderFacade():start");

		CustomerOrderFacadeSTLHome customerOrderFacadeHome = null;
		//String jndi = global.getValor("jndi.facade"); // MA
		String jndi = config.getString("jndi.facade"); // MA
		logger.debug("Buscando servicio[" + jndi + "]");
		//String url = global.getValor("url.provider"); // MA
		String url = config.getString("url.provider"); // MA
		logger.debug("Url provider[" + url + "]");

		try {
			customerOrderFacadeHome = (CustomerOrderFacadeSTLHome) ServiceLocator
					.getInstance().getRemoteHome(url, jndi,
							CustomerOrderFacadeSTLHome.class);
		} catch (ServiceLocatorException e) {
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
		//String jndi = global.getValor("jndi.TOLfacade"); // MA
		String jndi = config.getString("jndi.TOLfacade"); // MA
		logger.debug("Buscando servicio[" + jndi + "]");
		//String url = global.getValor("url.provider"); // MA
		String url = config.getString("url.provider"); // MA
		logger.debug("Url provider[" + url + "]");

		try {
			facadeHome = (TOLFacadeHome) ServiceLocator.getInstance()
					.getRemoteHome(url, jndi, TOLFacadeHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			logger.debug("ServiceLocatorException", e);
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

	private CustomerOrderORQ getCustomerOrderORQ()
		throws CustomerOrderException 
	{

		logger.debug("getCustomerOrderORQ():start");

		CustomerOrderORQHome customerOrderORQHome = null;
		//String jndi = global.getValor("jndi.customer.orq"); // MA
		String jndi = config.getString("jndi.customer.orq");
		logger.debug("Buscando servicio[" + jndi + "]");
		//String url = global.getValor("url.provider");      // MA
		String url = config.getString("url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			customerOrderORQHome = (CustomerOrderORQHome) ServiceLocator
					.getInstance().getRemoteHome(url, jndi,
							CustomerOrderORQHome.class);
		} catch (ServiceLocatorException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new CustomerOrderException(e);
		}

		logger.debug("Recuperada interfaz home de Customer Order ORQ...");
		CustomerOrderORQ customerOrderORQ = null;
		try {
			customerOrderORQ = customerOrderORQHome.create();
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

		logger.debug("getCustomerOrderORQ()():end");
		return customerOrderORQ;
	}

	public static CustomerOrderDelegate getInstance() {
		if (instance == null) {
			instance = new CustomerOrderDelegate();
		}
		return instance;
	}

	/**
	 * Obtine la lista de servicios suplementarios contratados por cliente
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public ProductListDTO getInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) 
		throws CustomerOrderException 
	{
		logger.debug("getInstalledCustomerAccountProductBundle():start");
		ProductListDTO respuesta = null;
		try {
			logger.debug("getInstalledCustomerAccountProductBundle:antes");
			respuesta = getCustomerOrderFacade()
					.getInstalledCustomerAccountProductBundle(cust);
			logger.debug("getInstalledCustomerAccountProductBundle:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getInstalledCustomerAccountProductBundle():end");
		return respuesta;

	}

	/**
	 * Valida la seguridad dado un id de seguridad
	 * 
	 * @param seg
	 * @return
	 * @throws CustomerOrderException
	 */
	public SecurityDTO getSecurityData(SecurityDTO seg)
		throws CustomerOrderException 
	{
		logger.debug("getSecurityData():start");
		SecurityDTO respuesta = null;
		try {
			logger.debug("getSecurityData:antes");
			respuesta = getCustomerOrderFacade().getSecurityData(seg);
			logger.debug("getSecurityData:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getSecurityData():end");
		return respuesta;
	}

	public String ValidaSC(String paramtro) {
		return paramtro;
	}

	/**
	 * Obtiene la lista de reglas de los servicios suplementarios
	 * 
	 * @return
	 * @throws CustomerOrderException
	 * @throws RemoteException
	 */
	public ReglasSSDTO[] getReglasdeValidacionSS()
		throws CustomerOrderException, RemoteException 
	{

		logger.debug("getReglasdeValidacionSS():start");
		ReglasSSDTO[] respuesta = null;
		try {
			logger.debug("getReglasdeValidacionSSReglasSSDTO:antes");
			respuesta = getCustomerOrderFacade().getReglasdeValidacionSS();
			logger.debug("getInstalledProductBundleList:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getReglasdeValidacionSS():end");
		return respuesta;

	}

	/**
	 * Obtiene la lista de servicios no contratados
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 * @throws RemoteException
	 */
	public ProductListDTO getUnInstalledCustomerAccountProductBundle(CustomerAccountDTO cust)
		throws CustomerOrderException,	RemoteException
	{

		logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		ProductListDTO respuesta = null;
		try {
			logger.debug("getUnInstalledCustomerAccountProductBundle:antes");
			respuesta = getCustomerOrderORQ()
					.getUnInstalledCustomerAccountProductBundle(cust);
			logger.debug("getUnInstalledCustomerAccountProductBundle:despues");
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);			
			
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getUnInstalledCustomerAccountProductBundle():end");
		return respuesta;

	}

	/**
	 * Recupera los limites de consumo del cliente
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public LimiteConsumoDTO[] getServiceLimitProfiles(ProductDTO prod)
		throws TOLException 
	{
		logger.debug("getServiceLimitProfiles():start");
		LimiteConsumoDTO[] respuesta = null;
		try {
			logger.debug("getServiceLimitProfiles:antes");
			respuesta = getTOLFacade().getServiceLimitProfiles(prod);
			logger.debug("getServiceLimitProfiles:despues");
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("getServiceLimitProfiles():end");
		return respuesta;
	}

	/**
	 * Recupera la informacion del cliente
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public CustomerAccountDTO getCustomerAccountData(CustomerAccountDTO cust)
		throws CustomerOrderException
	{
		logger.debug("getCustomerAccountData():start");
		CustomerAccountDTO respuesta = null;
		try {
			logger.debug("getCustomerAccountData:antes");
			respuesta = getCustomerOrderFacade().getCustomerAccountData(cust);
			logger.debug("getCustomerAccountData:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getCustomerAccountData():end");
		return respuesta;
	}

	/***ini GTM**/
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto)
		throws TOLException, CustomerOrderException 
	{
		logger.debug("getFreeUnitStock():start");
		BolsaAbonadoDTO[] respuesta = null;
		try {
			logger.debug("getFreeUnitStock:antes");
			//respuesta = getTOLFacade().getFreeUnitStock(dto);
			respuesta = getCustomerOrderFacade().getFreeUnitStock(dto);
			logger.debug("getFreeUnitStock:despues");
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} 
		logger.debug("getFreeUnitStock():end");
		return respuesta;
	}

	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto)
		throws TOLException, CustomerOrderException 
	{
		logger.debug("getFreeUnitBagId():start");
		CustomerAccountDTO respuesta = null;
		try {
			logger.debug("getFreeUnitBagId:antes");
			//respuesta = getTOLFacade().getFreeUnitBagId(dto);
			respuesta = getCustomerOrderFacade().getFreeUnitBagId(dto);
			logger.debug("getFreeUnitBagId:despues");
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} 
		logger.debug("getFreeUnitBagId():end");
		return respuesta;
	}

	public PlanTarifarioDTO[] obtenerPlanesDistribuidos( Long numVenta )
	throws GeneralException, RemoteException
	{
		logger.debug("obtenerPlanesDistribuidos():start");	
		PlanTarifarioDTO[] resultado = null;
		try {
			resultado = getCustomerOrderFacade().obtenerPlanesDistribuidos(numVenta);
		} catch (ProductDomainException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductDomainException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerPlanesDistribuidos():end");
		return resultado;
	}
	
	/** Metodos distribucion de bolsa **/
	
	public DistribucionBolsaDTO obtenerDatosBolsa( String codPlanTarif )
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDatosBolsa():start");		
		DistribucionBolsaDTO resultado= new DistribucionBolsaDTO();
		try {
			resultado = getCustomerOrderFacade().obtenerDatosBolsa(codPlanTarif);
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosBolsa():end");
		return resultado;
	}
	
	/***fin GTM**/
	/**
	 * Actualiza los atributos de los servicios Scl y Tol por cliente
	 * 
	 * @param prodList
	 * @throws CustomerOrderException
	 * @throws  
	 */
	public void setProductBundleAttributes(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{
		logger.debug("setProductBundleAttributes():start");
		try {
			getCustomerOrderORQ().setProductBundleAttributes(prodList);
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setProductBundleAttributes():end");
	}
	
	/**
	 * Obtiene la lista de servicios suplementarios contratados por abonado
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public ProductListDTO getInstalledInvolvementProductBundle(AbonadoDTO abo)
		throws CustomerOrderException 
	{
		logger.debug("getInstalledInvolvementProductBundle():start");
		ProductListDTO respuesta = null;
		try {
			logger.debug("getInstalledInvolvementProductBundle:antes");
			respuesta = getCustomerOrderFacade()
					.getInstalledInvolvementProductBundle(abo);
			logger.debug("getInstalledInvolvementProductBundle:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getInstalledInvolvementProductBundle():end");
		return respuesta;

	}

	/**
	 * Actualiza los atributos de los servicios Scl y Tol por abonado
	 * 
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInvolvementProductBundleAttributes(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{
		logger.debug("setInvolvementProductBundleAttributes():start");
		try {
			getCustomerOrderORQ().setInvolvementProductBundleAttributes(
					prodList);
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setInvolvementProductBundleAttributes():end");
	}

	/**
	 * Recupera la informacion del abonado
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public CustomerAccountDTO getInvolvementProductBundletData(AbonadoDTO abo)
		throws CustomerOrderException
	{
		logger.debug("getInvolvementProductBundletData():start");
		CustomerAccountDTO respuesta = null;
		try {
			logger.debug("getInvolvementProductBundletData:antes");
			respuesta = getCustomerOrderFacade()
					.getInvolvementProductBundletData(abo);
			logger.debug("getInvolvementProductBundletData:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("getInvolvementProductBundletData():end");
		return respuesta;
	}	
	
	public void setFreeUnitStock(DistribucionBolsaDTO dto)
		throws CustomerOrderException, RemoteException 
	{
		logger.debug("setFreeUnitStock():start");
		try {
			logger.debug("setFreeUnitStock():antes");
			//getCustomerOrderORQ().setFreeUnitStock(dto);
			getCustomerOrderFacade().setFreeUnitStock(dto);
			logger.debug("setFreeUnitStock():despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setFreeUnitStock():end");
	}	
	
	public void setFreeUnitStockPlanTarifOOSS(PlanTarifarioDistDTO[] planTarifarioArr, String comentario)
		throws CustomerOrderException, RemoteException 
	{
		logger.debug("setFreeUnitStockPlanTarifOOSS():start");
		try {
			logger.debug("setFreeUnitStockPlanTarifOOSS():antes");
			getCustomerOrderFacade().setFreeUnitStockPlanTarifOOSS(planTarifarioArr, comentario);
			logger.debug("setFreeUnitStockPlanTarifOOSS():despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setFreeUnitStockPlanTarifOOSS():end");
	}
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto)
		throws CustomerOrderException, TOLException 
	{
		logger.debug("getServiceLimitProfileValue():start");
		LimiteClienteDTO respuesta = null;
		
		try {
			logger.debug("getServiceLimitProfileValue:antes");
			respuesta = getTOLFacade().getServiceLimitProfileValue(dto);
			logger.debug("getServiceLimitProfileValue:despues");
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("getServiceLimitProfileValue():end");
		return respuesta;
	}
	
	public LimiteClienteDTO setServiceLimitTemporally(LimiteClienteDTO dto)
		throws TOLException, CustomerOrderException 
	{
		logger.debug("setServiceLimitTemporally():start");
		LimiteClienteDTO respuesta = null;
		try {
			logger.debug("getServiceLimitProfileValue:antes");
			getCustomerOrderORQ().setServiceLimitTemporally(dto);
			logger.debug("getServiceLimitProfileValue:despues");
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;			
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setServiceLimitTemporally():end");
		return respuesta;
	}	
	
	public void setServiceBundle(ActualizarSSClienteDTO dto)
		throws CustomerOrderException, RemoteException 
	{
		logger.debug("setServiceBundle():start");
		try {
			getCustomerOrderORQ().setServiceBundle(dto);			
		} catch (BillingProductChargeException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);			
		} catch (CustomerOrderException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerOrderException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new CustomerOrderException(e);
		} catch (TOLException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("TOLException[" + log + "]");
			throw new CustomerOrderException(e);
		}
		logger.debug("setServiceBundle():end");
	}	
}
