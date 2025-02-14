/**
 * 
 */
package com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.bean.ejb.helper.Global;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.GestionActivacionServiciosSrvFactory;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces.GestionActivacionServiciosSrvFactoryIF;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces.GestionActivacionServiciosSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IssSerOrdFacade"	
 *           description="An EJB named IssSerOrdFacade"
 *           display-name="IssSerOrdFacade"
 *           jndi-name="IssSerOrdFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public  class IssSerOrdFacadeBean implements javax.ejb.SessionBean 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(IssSerOrdFacadeBean.class);	
	private Global global = Global.getInstance();
	
	GestionActivacionServiciosSrvFactoryIF factorySrv1 = new GestionActivacionServiciosSrvFactory();
	GestionActivacionServiciosSrvIF service1 = factorySrv1.getApplicationService1();
	

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
	 * @throws IssSerOrdException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO informarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarProductoTasacionContratado():start");
			resultado = service1.informarProductoTasacionContratado(listaProdTas);
			logger.debug("informarProductoTasacionContratado():end");
		} catch(IssSerOrdException e){
			logger.debug("IssSerOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws IssSerOrdException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws IssSerOrdException 
	{
		EspecPlanTasacionListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarProductoTasacionContratado():start");
			resultado = service1.obtenerPlanesTasacion();
			logger.debug("informarProductoTasacionContratado():end");
		} catch(IssSerOrdException e){
			logger.debug("IssSerOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws IssSerOrdException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO desactivarProductoTasacionContratado(ProductoTasacionContratadoListDTO listaProdTas) throws IssSerOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarProductoTasacionContratado():start");
			resultado = service1.desactivarProductoTasacionContratado(listaProdTas);
			logger.debug("informarProductoTasacionContratado():end");
		} catch(IssSerOrdException e){
			logger.debug("IssSerOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws IssSerOrdException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO desactivarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("desactivarProductoTasacionContratado():start");
			resultado = service1.desactivarProductoTasacionContratado(listaProductos);
			logger.debug("desactivarProductoTasacionContratado():end");
		} catch(IssSerOrdException e){
			logger.debug("IssSerOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		return resultado;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws IssSerOrdException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarProductoTasacionContratado(ProductoContratadoListDTO listaProductos) throws IssSerOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarProductoTasacionContratado():start");
			resultado = service1.eliminarProductoTasacionContratado(listaProductos);
			logger.debug("eliminarProductoTasacionContratado():end");
		} catch(IssSerOrdException e){
			logger.debug("IssSerOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssSerOrdException(e);
		}
		return resultado;
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
	 * @throws IssSerOrdException 
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

	/**
	 * 
	 */
	public IssSerOrdFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
