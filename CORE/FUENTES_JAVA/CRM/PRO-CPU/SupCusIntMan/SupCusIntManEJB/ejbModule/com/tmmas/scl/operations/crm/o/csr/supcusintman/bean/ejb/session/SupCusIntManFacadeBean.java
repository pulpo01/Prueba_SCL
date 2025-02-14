/**
 * 
 */
package com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.GestionValidacionesSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces.GestionValidacionesSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces.GestionValidacionesSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SupCusIntManFacade"	
 *           description="An EJB named SupCusIntManFacade"
 *           display-name="SupCusIntManFacade"
 *           jndi-name="SupCusIntManFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class SupCusIntManFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(SupCusIntManFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionValidacionesSrvFactoryIF factorySrv1 = new GestionValidacionesSrvFactory();

	// Obtiene el application service
	GestionValidacionesSrvIF service1 = factorySrv1.getApplicationService1();

		
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
		
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}


	/** 
	 * Valida cuenta personal
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws SupCusIntManException{	
		RetornoDTO resultado = null;
		try{
			
			logger.debug("validaCuentaPersonal():start");
			resultado = service1.validaCuentaPersonal(cuenta);
			logger.debug("validaCuentaPersonal():end");
		} catch(SupCusIntManException e){
			logger.debug("SupCusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
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
	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws SupCusIntManException 
	{
		NumeroDTO resultado = null;
		try{
			logger.debug("obtenerTipoNumero():start");
			resultado = service1.obtenerTipoNumero(numero);
			logger.debug("obtenerTipoNumero():end");
		} catch(SupCusIntManException e){
			logger.debug("SupCusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
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
	public ClienteDTO validarCliente(ClienteDTO cliente) throws SupCusIntManException 
	{
		ClienteDTO resultado = null;
		try{
			logger.debug("validarCliente():start");
			resultado = service1.validarCliente(cliente);
			logger.debug("validarCliente():end");
		} catch(SupCusIntManException e){
			logger.debug("SupCusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
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
	public RestriccionesContratacionListDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restriccionesContratacion) throws SupCusIntManException 
	{
		RestriccionesContratacionListDTO resultado = null;
		try{
			logger.debug("obtenerRestriccionesContratacion():start");
			resultado = service1.obtenerRestriccionesContratacion(restriccionesContratacion);
			logger.debug("obtenerRestriccionesContratacion():end");
		} catch(SupCusIntManException e){
			logger.debug("SupCusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
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
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws SupCusIntManException 
	{
		RetornoDTO resultado = null;
		try{
			logger.debug("obtenerRestriccionesContratacion():start");
			resultado = service1.validarContratanteBeneficiario(contratanteBeneficiarioDTO);
			logger.debug("obtenerRestriccionesContratacion():end");
		} catch(SupCusIntManException e){
			logger.debug("SupCusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
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

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub
			this.context=arg0;
	}

	/**
	 * 
	 */
	public SupCusIntManFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
