/**
 * 
 */
package com.tmmas.scl.operations.crm.b.bcm.apppridisreb.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ProrrateoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
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
	
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	/*public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws AppPriDisRebException {
		
		ObtencionCargosDTO resultado = null;
		logger.debug("parametros.getCodigoClienteOrigen()[" + parametros.getCodigoClienteOrigen() + "]");
		logger.debug("parametros.getFechaVigenciaAbonadoCero()[" + parametros.getFechaVigenciaAbonadoCero() + "]");
		System.out.println("AppPriDisReb parametros.getCodigoClienteOrigen()[" + parametros.getCodigoClienteOrigen() + "]");
		System.out.println("AppPriDisReb parametros.getFechaVigenciaAbonadoCero()[" + parametros.getFechaVigenciaAbonadoCero() + "]");
			
			try{
				String log = global.getValor("negocio.log");
				log = global.getPathInstancia() + log;
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
	}*/

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
				log = global.getPathInstancia() + log;
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
				log = global.getPathInstancia() + log;
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
	 * Elimina la solicitud de descuento
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException{
		RetornoDTO resultado = null;
			
			try{
				String log = global.getValor("negocio.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				logger.debug("eliminarSolicitud():start");
				resultado = service1.eliminarSolicitud(registro);
				logger.debug("eliminarSolicitud():end");
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
				log = global.getPathInstancia() + log;
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
				log = global.getPathInstancia() + log;
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
			log = global.getPathInstancia() + log;
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

	/** 
	 * Elimina cargos facturados
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException
	{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarCargosFacturados():start");
			resultado = service1.eliminarCargosFacturados(listaProductos);
			logger.debug("eliminarCargosFacturados():end");
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
	public RetornoDTO descontratarCargosRecurrentes(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException
	{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("finalizarCargosFacturados():start");
			resultado = service1.descontratarCargosRecurrentes(listaProductos);
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
	
	/** 
	 * Ejecuta Facturacion
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO informarCargosOcasionales(CargoOcasionalListDTO cargosOc) throws AppPriDisRebException
	{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarCargosOcasionales():start");
			resultado = service1.informarCargosOcasionales(cargosOc);
			logger.debug("informarCargosOcasionales():end");
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
	public RetornoDTO informarCargosRecurrentes(CargoRecurrenteListDTO cargosReq) throws AppPriDisRebException
	{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("informarCargosRecurrentes():start");
			resultado = service1.informarCargosRecurrentes(cargosReq);
			logger.debug("informarCargosRecurrentes():end");
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
	 * Consulta estado facturado
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultarEstadoFacturado():start");
			resultado = service1.consultarEstadoFacturado(numProceso);
			logger.debug("consultarEstadoFacturado():end");
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
	 * Obtiene detalle presupuesto
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws AppPriDisRebException{
		PresupuestoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDetallePresupuesto():start");
			resultado = service1.obtenerDetallePresupuesto(presup);
			logger.debug("obtenerDetallePresupuesto():end");
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
	 * Obtiene codigo concepto descuento
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws AppPriDisRebException{
		DescuentoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCodConceptoDescuento():start");
			resultado = service1.obtenerCodConceptoDescuento(sec);
			logger.debug("obtenerCodConceptoDescuento():end");
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
	 * Elimina codigo concepto descuento
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaCodConceptoDescuento():start");
			resultado = service1.eliminaCodConceptoDescuento(numTransaccion);
			logger.debug("eliminaCodConceptoDescuento():end");
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
	 * Inserta codigo descuento
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarConceptoDescuento():start");
			resultado = service1.insertarConceptoDescuento(desc);
			logger.debug("insertarConceptoDescuento():end");
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
	 * Elimina el presupuesto
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPresupuesto():start");
			resultado = service1.eliminarPresupuesto(registro);
			logger.debug("eliminarPresupuesto():end");
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
	 * Elimina el presupuesto
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ProrrateoDTO getCargoRecurrenteProrrateo(CargoRecurrenteDTO cargoRecurrenteDTO)throws GeneralException{
		ProrrateoDTO prorrateoDTO = new ProrrateoDTO();
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("getCargoRecurrenteProrrateado():start");
			
			prorrateoDTO.setNumAbonado(Long.parseLong(cargoRecurrenteDTO.getNumAbonadoPago()));
			prorrateoDTO.setCodCargo(Long.parseLong(cargoRecurrenteDTO.getCodCargoContratado()));
			prorrateoDTO = service1.getCargoRecurrenteProrrateo(cargoRecurrenteDTO);
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
	
	
	/** 
	 * Elimina el presupuesto
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertaCobroAdelantado(CargoRecurrenteDTO cargoRecurrenteDTO)	throws GeneralException{
		RetornoDTO retValue= new RetornoDTO();
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("insertaCobroAdelantado():start");
			retValue = service1.insertaCobroAdelantado(cargoRecurrenteDTO);
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
	 * Elimina el presupuesto
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public CargoImpuestoDTO getImpuestoImporte(CargoImpuestoDTO cargoImpuestoDTO)throws GeneralException{
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		try 
		{
			logger.debug("getCargoImpuesto():start");
			cargoImpuestoDTO = service1.getImpuestoImporte(cargoImpuestoDTO);
			logger.debug("getCargoImpuesto():end");
		} catch(AppPriDisRebException e){
			logger.debug("AppPriDisRebException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}		
		return cargoImpuestoDTO;
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
	public AppPriDisRebFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
