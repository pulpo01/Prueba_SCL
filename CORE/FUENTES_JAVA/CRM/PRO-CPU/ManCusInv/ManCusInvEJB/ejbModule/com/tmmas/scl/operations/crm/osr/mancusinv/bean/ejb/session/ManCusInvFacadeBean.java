/**
 * 
 */
package com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CantidadProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.osr.mancusinv.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.GestionProductoContratadoSrvFactory;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.interfaces.GestionProductoContratadoSrvFactoryIF;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.interfaces.GestionProductoContratadoSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManCusInvFacade"	
 *           description="An EJB named ManCusInvFacade"
 *           display-name="ManCusInvFacade"
 *           jndi-name="ManCusInvFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class ManCusInvFacadeBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(ManCusInvFacadeBean.class);	
	private Global global = Global.getInstance();
	
	private GestionProductoContratadoSrvFactoryIF factorySrv1 = new GestionProductoContratadoSrvFactory();
	private GestionProductoContratadoSrvIF		  service1 = factorySrv1.getApplicationService1();

	
	
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
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProductoContratadoListDTO  obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws ManCusInvException
	{
		ProductoContratadoListDTO resultado = null;
		try{
			
			
			logger.debug("obtenerProductoContratado():start");
			resultado = service1.obtenerProductoContratado(ordenServicio);
			logger.debug("obtenerProductoContratado():end");
		} catch(ManCusInvException e){
			logger.debug("ManCusInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
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
	public PaqueteContratadoDTO obtenerProductoContratadoPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ManCusInvException 
	{
		PaqueteContratadoDTO resultado = null;
		try{
			
			
			logger.debug("obtenerProductoContratadoPorPaquete():start");
			resultado = service1.obtenerProductoContratadoPorPaquete(paqueteContratado);
			logger.debug("obtenerProductoContratadoPorPaquete():end");
		} catch(ManCusInvException e){
			logger.debug("ManCusInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
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
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ManCusInvException 
	{
		NumeroDTO resultado = null;
		try{
			
			logger.debug("obtieneModificacionesProducto():start");
			resultado = service1.obtieneModificacionesProducto(productoContratado);
			logger.debug("obtieneModificacionesProducto():end");
		} catch(ManCusInvException e){
			logger.debug("ManCusInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO crearListaNumeros(NumeroListDTO listaNumeros) throws ManCusInvException 
	{
		RetornoDTO resultado = null;
		try{
			
			logger.debug("crearListaNumeros():start");
			resultado = service1.crearListaNumeros(listaNumeros);
			logger.debug("crearListaNumeros():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarListaNumeros(NumeroListDTO listaNumeros) throws ManCusInvException 
	{
		RetornoDTO resultado = null;
		try{
			
			
			logger.debug("eliminarListaNumeros():start");
			resultado = service1.eliminarListaNumeros(listaNumeros);
			logger.debug("eliminarListaNumeros():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
	}
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ManCusInvException
	{		
		try
		{
				
			
			logger.debug("obtenerDetalleProductoContratado():start");
			listaProductos = service1.obtenerDetalleProductoContratado(listaProductos);
			logger.debug("obtenerDetalleProductoContratado():end");
		}
		catch(ManCusInvException e)
		{
			logger.debug("ManCusInvException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return listaProductos;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado)throws ManCusInvException{
		NumeroListDTO resultado = null;
		try{
			
			
			logger.debug("obtenerListaNumeros():start");
			resultado = service1.obtenerListaNumeros(productoContratado);
			logger.debug("obtenerListaNumeros():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CantidadProductoContratadoDTO obtieneCantidadProductosContratados(CantidadProductoContratadoDTO producto) throws ManCusInvException{
		CantidadProductoContratadoDTO resultado = null;
		try{
			
			
			logger.debug("obtenerListaNumeros():start");
			resultado = service1.obtieneCantidadProductosContratados(producto);
			logger.debug("obtenerListaNumeros():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;	
	 }
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO informarLC(LimiteConsumoPlanAdicionalListDTO LimConsLista) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("informarLimiteConsumo():start");
			resultado = service1.informarLC(LimConsLista);			
			logger.debug("informarLimiteConsumo():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarLC(ProductoContratadoListDTO prodList) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = service1.actualizarLC(prodList);			
			logger.debug("actualizarLimiteConsumo():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO cambiarLC(ProductoContratadoListDTO prodList) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = service1.cambiarLC(prodList);			
			logger.debug("actualizarLimiteConsumo():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws ManCusInvException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO informarAbonoLimiteConsumo(AbonoLimiteConsumoListDTO listaAbonoLimiteConsumo) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = service1.informarAbonoLimiteConsumo(listaAbonoLimiteConsumo);			
			logger.debug("actualizarLimiteConsumo():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
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
	public ManCusInvFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
