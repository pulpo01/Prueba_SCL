package com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.GestionProductoSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces.GestionProductoSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces.GestionProductoSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManProOffInvFacade"	
 *           description="An EJB named ManProOffInvFacade"
 *           display-name="ManProOffInvFacade"
 *           jndi-name="ManProOffInvFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManProOffInvFacadeBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(ManProOffInvFacadeBean.class);
	
	private Global global = Global.getInstance();	
	
	// Instancia el factory
	private GestionProductoSrvFactoryIF factorySrv1 = new GestionProductoSrvFactory();

	// Obtiene el application service
	private GestionProductoSrvIF service1 = factorySrv1.getApplicationService1();
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() 
	{
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
	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ManProOffInvException{
		
		PlanTarifarioListDTO planes = null;
		try{
			logger.debug("obtenerPlanesTarifarios():start");
			planes = service1.obtenerPlanesTarifarios(param);
			logger.debug("obtenerPlanesTarifarios():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return planes;		
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
	public PlanTarifarioDTO obtenerTipoCobroPlanTarifario(
			PlanTarifarioDTO plan) throws ManProOffInvException{

		try{
			logger.debug("obtenerTipoCobroPlanTarifario():start");
			plan = service1.obtenerTipoCobroPlanTarifario(plan);
			logger.debug("obtenerTipoCobroPlanTarifario():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return plan;		
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
	public ProductoOfertadoListDTO obtenerDetalleProductos(
			ProductoOfertadoListDTO param) throws ManProOffInvException{
		
		ProductoOfertadoListDTO prodOfertado= null;
		try{
			logger.debug("obtenerDetalleProductos():start");
			prodOfertado = service1.obtenerDetalleProductos(param);
			logger.debug("obtenerDetalleProductos():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;		
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
	public ProductoOfertadoListDTO obtenerProductosOfertables(
			AbonadoDTO param) throws ManProOffInvException{
		
		ProductoOfertadoListDTO prod= null;
		try{
			logger.debug("obtenerProductosOfertables():start");
			prod = service1.obtenerProductosOfertables(param);
			logger.debug("obtenerProductosOfertables():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prod;		
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
	public ReglasListaNumerosListDTO obtenerRestriccionesLista(
			EspecServicioListaDTO param) throws ManProOffInvException{
		
		ReglasListaNumerosListDTO resultado = null;
		try{
			logger.debug("obtenerRestriccionesLista():start");
			resultado = service1.obtenerRestriccionesLista(param);
			logger.debug("obtenerRestriccionesLista():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
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
	public ProductoOfertadoListDTO obtenerProductosPorDefecto(AbonadoDTO abonado) throws ManProOffInvException{
		
		ProductoOfertadoListDTO resultado = null;
		try{
			logger.debug("obtenerRestriccionesLista():start");
			resultado = service1.obtenerProductosPorDefecto(abonado);
			logger.debug("obtenerRestriccionesLista():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
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
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete)throws ManProOffInvException 
	{
		ProductoOfertadoListDTO resultado = null;
		try{
			logger.debug("obtenerProductosOfertablesPorPaquete():start");
			resultado = service1.obtenerProductosOfertablesPorPaquete(paquete);
			logger.debug("obtenerProductosOfertablesPorPaquete():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
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
	public ProductoOfertadoListDTO obtenerProductosOfertablesPaquetePorDefecto(PaqueteDTO paquete) throws ManProOffInvException 
	{
		ProductoOfertadoListDTO resultado = null;
		try{
			logger.debug("obtenerProductosOfertablesPaquetePorDefecto():start");
			resultado = service1.obtenerProductosOfertablesPaquetePorDefecto(paquete);
			logger.debug("obtenerProductosOfertablesPaquetePorDefecto():end");
		} catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return resultado;				
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ManProOffInvException 
	{		
		try
		{
			logger.debug("obtenerDetallePlanTarif():start");
			planTarif = service1.obtenerDetallePlanTarif(planTarif);
			logger.debug("obtenerDetallePlanTarif():end");
		}
		catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return planTarif;				
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
	public ProductoOfertadoListDTO obtenerProductosOfertablesporCanal(AbonadoDTO abonado) throws ManProOffInvException {
		ProductoOfertadoListDTO resultado =  null;
		try
		{
			logger.debug("obtenerProductosOfertablesporCanal():start");
			resultado = service1.obtenerProductosOfertablesporCanal(abonado);
			logger.debug("obtenerProductosOfertablesporCanal():end");
		}
		catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
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
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO productoOfertadoLista) throws ManProOffInvException {
		ProductoOfertadoListDTO resultado =  null;
		try
		{
			logger.debug("obtenerLimiteConsumoPlanAdicional():start");
			resultado = service1.obtenerLCplanAdicional(productoOfertadoLista);
			logger.debug("obtenerLimiteConsumoPlanAdicional():end");
		}
		catch(ManProOffInvException e){
			logger.debug("ManProOffInvException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
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
	public LimiteConsumoProductoListDTO consultaAboLc(LimiteConsumoProductoDTO limiteConsumoProducto) throws ManProOffInvException {
		LimiteConsumoProductoListDTO resultado =  null;
		try
		{
			logger.debug("obtenerLimiteConsumoPlanAdicional():start");
			resultado = service1.consultaAbonoLcProducto(limiteConsumoProducto);
			logger.debug("obtenerLimiteConsumoPlanAdicional():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			e.printStackTrace();
			throw new ManProOffInvException(e);
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
	public TipoComportamientoListDTO obtenerTiposComportamiento() throws ManProOffInvException{
		TipoComportamientoListDTO resultado =  null;
		try
		{
			logger.debug("obtenerTiposComportamiento():start");
			resultado = service1.obtenerTiposComportamiento();
			logger.debug("obtenerTiposComportamiento():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			e.printStackTrace();
			throw new ManProOffInvException(e);
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
	public ProductoScoringListDTO obtenerProductosScoring(Long numAbonado) throws ManProOffInvException{
		ProductoScoringListDTO resultado =  null;
		try
		{
			logger.debug("obtenerProductosScoring():start");
			resultado = service1.obtenerProductosScoring(numAbonado);
			logger.debug("obtenerProductosScoring():end");
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			e.printStackTrace();
			throw new ManProOffInvException(e);
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
	public ManProOffInvFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
