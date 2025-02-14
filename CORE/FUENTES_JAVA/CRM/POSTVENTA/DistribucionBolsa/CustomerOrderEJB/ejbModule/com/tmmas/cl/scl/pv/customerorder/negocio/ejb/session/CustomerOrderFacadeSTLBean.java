/**
 * 
 */
package com.tmmas.cl.scl.pv.customerorder.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.pv.customerorder.service.servicios.CustomerOrderService;
import com.tmmas.cl.scl.pv.customerorder.service.servicios.InvolvementProductBundleService;
import com.tmmas.cl.scl.pv.customerorder.service.servicios.LogicalServiceSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CustomerOrderFacadeSTL"	
 *           description="An EJB named CustomerOrderFacadeSTL"
 *           display-name="CustomerOrderFacadeSTL"
 *           jndi-name="CustomerOrderFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class CustomerOrderFacadeSTLBean implements javax.ejb.SessionBean {
	
	private CustomerOrderService customerOrderService = new CustomerOrderService();

	private InvolvementProductBundleService involvementProductBundleService = new InvolvementProductBundleService();
	
	private LogicalServiceSrv logicalServiceSrv = new LogicalServiceSrv();
	
	private static final long serialVersionUID = 1L;

	private final Logger logger = Logger.getLogger(CustomerOrderFacadeSTLBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;	
	
	public CustomerOrderFacadeSTLBean() 
	{
		logger.debug("CustomerOrderFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("DistribucionBolsa.properties");
		UtilLog.setLog(config.getString("CustomerOrderEJB.log"));
		logger.debug("CustomerOrderFacadeSTLBean():End");
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

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ProductListDTO getInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) 
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("getInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado;
		try {
			resultado = customerOrderService
					.getInstalledCustomerAccountProductBundle(cust);
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
		logger.debug("getInstalledCustomerAccountProductBundle():end");
		return resultado;
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
	public void setInstalledCustomerAccountProductBundle(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("setInstalledCustomerAccountProductBundle():start");
		try {
			customerOrderService
					.setInstalledCustomerAccountProductBundle(prodList);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("setInstalledCustomerAccountProductBundle():end");
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
		throws CustomerOrderException,RemoteException 
	{		
		logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado = null;
		try {
			resultado = customerOrderService
					.getUnInstalledCustomerAccountProductBundle(cust);
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
		return resultado;
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
	public ReglasSSDTO[] getReglasdeValidacionSS()
		throws CustomerOrderException, RemoteException
	{		
		logger.debug("getReglasdeValidacionSS():start");
		ReglasSSDTO[] resultado = null;
		try {
			resultado = customerOrderService.getReglasdeValidacionSS();
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
		logger.debug("getReglasdeValidacionSS():end");
		return resultado;
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
	public CustomerAccountDTO getCustomerAccountData(CustomerAccountDTO cust)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("getCustomerAccountData():start");
		CustomerAccountDTO resultado = null;
		try {
			resultado = customerOrderService.getCustomerAccountData(cust);
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
		logger.debug("getCustomerAccountData():end");
		return resultado;
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
	public SecurityDTO getSecurityData(SecurityDTO seg)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("getSecurityData():start");
		SecurityDTO resultado = null;
		try {
			resultado = customerOrderService.getSecurityData(seg);
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
		logger.debug("getSecurityData():end");
		return resultado;
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
	public void setCustomerAccountProductBundle(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("setCustomerAccountProductBundle():start");
		try {
			customerOrderService.setCustomerAccountProductBundle(prodList);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("setCustomerAccountProductBundle():end");
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
	public void saveCustomerOrderProduct(OrdenServicioDTO oS)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("saveCustomerOrderProduct():start");
		try {
			customerOrderService.saveCustomerOrderProduct(oS);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("saveCustomerOrderProduct():end");
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
	public CustomerAccountDTO getInvolvementProductBundletData(AbonadoDTO abo)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("getInvolvementProductBundletData():start");
		CustomerAccountDTO respuesta = null;
		try {
			respuesta = involvementProductBundleService
					.getInvolvementProductBundletData(abo);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("getInvolvementProductBundletData():end");
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
	public ProductListDTO getInstalledInvolvementProductBundle(AbonadoDTO abo)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("getInstalledInvolvementProductBundle():start");
		ProductListDTO respuesta;
		try {
			respuesta = involvementProductBundleService
					.getInstalledInvolvementProductBundle(abo);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("getInstalledInvolvementProductBundle():end");
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
	public void setInvolvementProductBundleAttributes(ProductListDTO prodList)
		throws CustomerOrderException, RemoteException 
	{		
		logger.debug("setInvolvementProductBundleAttributes():start");
		try {
			involvementProductBundleService.setInvolvementProductBundleAttributes(prodList);
		} catch (CustomerOrderException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
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
		logger.debug("setInvolvementProductBundleAttributes():end");
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
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto)
		throws TOLException, RemoteException 
	{		
		logger.debug("getFreeUnitStock():start");
		BolsaAbonadoDTO[] retorno = null;
		try {
			retorno = logicalServiceSrv.getFreeUnitStock(dto);
		} catch (TOLException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("getFreeUnitStock():end");
		return retorno;
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
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto)
		throws TOLException, RemoteException 
	{		
		logger.debug("getFreeUnitBagId():start");
		CustomerAccountDTO retorno = null;
		try {
			retorno = logicalServiceSrv.getFreeUnitBagId(dto);
		} catch (TOLException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("getFreeUnitBagId():end");
		return retorno;
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
	public void setFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException 
	{		
		logger.debug("setFreeUnitStock():start");
		try {
			logger.debug("setFreeUnitStock:antes");
			logicalServiceSrv.setFreeUnitStock(dto);
			logger.debug("setFreeUnitStock:despues");	
		} catch (TOLException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("setFreeUnitStock():end");
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
	public void setFreeUnitStockPlanTarifOOSS(PlanTarifarioDistDTO[] planTarifarioArr, String comentario) throws TOLException, RemoteException 
	{		
		logger.debug("setFreeUnitStockPlanTarifOOSS():start");
		PlanTarifarioDistDTO planTarifarioDistDTO = null;
		DistribucionBolsaDTO bolsaDistrib = null;
		try {
			
			logger.debug("-------------Minutos por asignar-----ini-------------");
			logger.debug("----------------------------------------------Xplan");
			for(int j=0;j<planTarifarioArr.length;j++)
			{
				planTarifarioDistDTO = planTarifarioArr[j];
				logger.debug("CodigoPlanTarifario ["+planTarifarioDistDTO.getCodigoPlanTarifario()+"]");
				if(!planTarifarioDistDTO.isDistribucionPlanRealizada())
				{
					logger.debug("No se distribuye bolsa para el plan...continue");
					continue;
				}
				logger.debug("Cantidad de abonados["+planTarifarioDistDTO.getDistribucionBolsa().getBolsa().length+"]");
				logger.debug("guardarDistribucionBolsa:antes");
				bolsaDistrib = planTarifarioDistDTO.getDistribucionBolsa();//(DistribucionBolsaDTO)request.getSession().getAttribute("BolsaDistrib");		
				for (int i = 0; i < bolsaDistrib.getBolsa().length; i++){
					logger.debug("abonado["+bolsaDistrib.getBolsa()[i].getNum_abonado()+"] "+
							     "minutos["+bolsaDistrib.getBolsa()[i].getCnt_unidad()+"] "+
							     "porcentaje["+bolsaDistrib.getBolsa()[i].getPrc_unidad()+"]");
				}				
				this.setFreeUnitStock(bolsaDistrib);
				//logicalServiceSrv.setFreeUnitStock(bolsaDistrib);
				logger.debug("guardarDistribucionBolsa:despues");
				logger.debug("----------------------------------------------fin plan");
			}
			logger.debug("-------------Minutos por asignar-----fin-------------");
			
			bolsaDistrib.getServiceOrder().setComentario(comentario);//con el último PTarif se registra la OOSS 
			logger.debug("Comentarios ["+bolsaDistrib.getServiceOrder().getComentario()+"]");

			logger.debug("saveCustomerOrderProduct:antes");
			this.saveCustomerOrderProduct(bolsaDistrib.getServiceOrder());
			logger.debug("saveCustomerOrderProduct:despues");
	
			
		} catch (TOLException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new TOLException(e);
		}
		logger.debug("setFreeUnitStockPlanTarifOOSS():end");
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
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long codigoCliente)
		throws ProductDomainException, RemoteException 
	{		
		logger.debug("obtenerPlanesDistribuidos():start");
		PlanTarifarioDTO[] retorno = null;
		try {
			retorno = customerOrderService.obtenerPlanesDistribuidos(codigoCliente);
		} catch (ProductDomainException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new ProductDomainException(e);
		}
		logger.debug("obtenerPlanesDistribuidos():end");
		return retorno;
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
	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) 
		throws ProductDomainException, RemoteException 
	{		
		logger.debug("obtenerDatosBolsa():start");
		DistribucionBolsaDTO retorno = null;
		try {
			retorno = customerOrderService.obtenerDatosBolsa(codPlanTarif);
		} catch (ProductDomainException e) {
			logger.debug("Rollbacking transaction...");
			context.setRollbackOnly();
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new ProductDomainException(e);
		}
		logger.debug("obtenerDatosBolsa():end");
		return retorno;
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

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		this.context=arg0;

	}

	
}
