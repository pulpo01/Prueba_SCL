/**
 * 
 */
package com.tmmas.scl.operations.rmo.rp.issresord.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.operations.rmo.rp.issresord.bean.ejb.helper.Global;
import com.tmmas.scl.operations.rmo.rp.issresord.common.exception.IssResOrdException;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.GestionActivacionRecursosSrvFactory;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces.GestionActivacionRecursosSrvFactoryIF;
import com.tmmas.scl.operations.rmo.rp.issresord.srvrec.interfaces.GestionActivacionRecursosSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IssResOrdFacade"	
 *           description="An EJB named IssResOrdFacade"
 *           display-name="IssResOrdFacade"
 *           jndi-name="IssResOrdFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class IssResOrdFacadeBean implements javax.ejb.SessionBean 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(IssResOrdFacadeBean.class);	
	private Global global = Global.getInstance();
	
	GestionActivacionRecursosSrvFactoryIF factorySrv1 = new GestionActivacionRecursosSrvFactory();
	GestionActivacionRecursosSrvIF service1 = factorySrv1.getApplicationService1();

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
	public RetornoDTO informarPerfilProvisionamiento(PerfilProvisionamientoListDTO perfilProv) throws IssResOrdException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarPerfilProvisionamiento():start");
			resultado = service1.informarPerfilProvisionamiento(perfilProv);
			logger.debug("informarPerfilProvisionamiento():end");
		} catch(IssResOrdException e){
			logger.debug("IssResOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
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
	public RetornoDTO informarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarPerfilProvisionamiento():start");
			resultado = service1.informarPerfilProvisionamiento(listaProductos);
			logger.debug("informarPerfilProvisionamiento():end");
		} catch(IssResOrdException e){
			logger.debug("IssResOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
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
	public RetornoDTO eliminarPerfilProvisionamiento(ProductoContratadoListDTO listaProductos) throws IssResOrdException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPerfilProvisionamiento():start");
			resultado = service1.eliminarPerfilProvisionamiento(listaProductos);
			logger.debug("eliminarPerfilProvisionamiento():end");
		} catch(IssResOrdException e){
			logger.debug("IssResOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IssResOrdException(e);
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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public IssResOrdFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
