/**
 * 
 */
package com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.common.exception.AppPriDisRebException;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.GestionCargosDescuentosSrvFactory;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces.GestionCargosDescuentosSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces.GestionCargosDescuentosSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="AppPriDisRebFacade"	
 *           description="An EJB named AppPriDisRebFacade"
 *           display-name="AppPriDisRebFacade"
 *           jndi-name="AppPriDisRebFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class AppPriDisRebFacadeBean implements javax.ejb.SessionBean {
	
	

	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(AppPriDisRebFacadeBean.class);
	private Global global = Global.getInstance();
	
	//Instancia el factory
	GestionCargosDescuentosSrvFactoryIF factorySrv1 = new GestionCargosDescuentosSrvFactory();
	
	//Obtiene el application service
	GestionCargosDescuentosSrvIF service1 = factorySrv1.getApplicationService1();
	
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
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws AppPriDisRebException {
		
		ObtencionCargosDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("obtenerCargos():start");
				resultado = service1.obtenerCargos(parametros);
				logger.debug("obtenerCargos():end");
			} catch(AppPriDisRebException e){
				logger.debug("AppPriDisRebException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new AppPriDisRebException(e);
			}
		return resultado;
	}

	/** 
	 * Registra una solicitud de aprobación de descuento en SCL
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws AppPriDisRebException{
		RespuestaSolicitudDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("solicitarAprobacionDescuento():start");
				resultado = service1.solicitarAprobacionDescuento(registro);
				logger.debug("solicitarAprobacionDescuento():end");
			} catch(AppPriDisRebException e){
				logger.debug("AppPriDisRebException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new AppPriDisRebException(e);
			}
		return resultado;
	}
	
	/** 
	 * Obtiene estado de solicitud
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException{
		RegistroSolicitudDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("consultarEstadoSolicitud():start");
				resultado = service1.consultarEstadoSolicitud(registro);
				logger.debug("consultarEstadoSolicitud():end");
			} catch(AppPriDisRebException e){
				logger.debug("AppPriDisRebException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new AppPriDisRebException(e);
			}
		return resultado;
	}	
	
	/** 
	 * Obtiene impuestos
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws AppPriDisRebException{
		ImpuestosDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("obtenerImpuestos():start");
				resultado = service1.obtenerImpuestos(impuestos);
				logger.debug("obtenerImpuestos():end");
			} catch(AppPriDisRebException e){
				logger.debug("AppPriDisRebException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new AppPriDisRebException(e);
			}
		return resultado;
	}
	
	/** 
	 * Ejecuta Facturacion
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws AppPriDisRebException{
		RetornoDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("aceptarPresupuesto():start");
				resultado = service1.aceptarPresupuesto(presup);
				logger.debug("aceptarPresupuesto():end");
			} catch(AppPriDisRebException e){
				logger.debug("AppPriDisRebException[", e);
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new AppPriDisRebException(e);
			}
		return resultado;
	}
	
	
	/** 
	 * Ejecuta Facturacion
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO finalizarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException
	{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("finalizarCargosFacturados():start");
			resultado = service1.finalizarCargosFacturados(listaProductos);
			logger.debug("finalizarCargosFacturados():end");
		} catch(AppPriDisRebException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
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

	}

	/**
	 * 
	 */
	public AppPriDisRebFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
