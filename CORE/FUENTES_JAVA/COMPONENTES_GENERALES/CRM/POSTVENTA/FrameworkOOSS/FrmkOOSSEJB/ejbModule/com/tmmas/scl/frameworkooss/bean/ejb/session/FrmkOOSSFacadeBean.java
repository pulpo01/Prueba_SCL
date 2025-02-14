/**
 * 
 */
package com.tmmas.scl.frameworkooss.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.commonDoman.exception.FrmkOOSSException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.helper.Global;
import com.tmmas.scl.frameworkooss.srv.FrmkOOSSSrvFactory;
import com.tmmas.scl.frameworkooss.srv.interfaces.FrmkOOSSSrvFactoryIF;
import com.tmmas.scl.frameworkooss.srv.interfaces.FrmkOOSSSrvIF;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="FrmkOOSSFacade"	
 *           description="An EJB named FrmkOOSSFacade"
 *           display-name="FrmkOOSSFacade"
 *           jndi-name="FrmkOOSSFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class FrmkOOSSFacadeBean implements javax.ejb.SessionBean {

	private final Logger logger = Logger.getLogger(FrmkOOSSFacadeBean.class);
	private Global global = Global.getInstance();
	private FrmkOOSSSrvFactoryIF factory= new FrmkOOSSSrvFactory();
	private FrmkOOSSSrvIF serviceFrmkOOSS = factory.getApplicationService(); 
	
	SessionContext context;

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
	public String foo(String param) {
		return null;
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
	public FrmkOOSSFacadeBean() {
		// TODO Auto-generated constructor stub
	}


	/** 
	 *  Obtiene numero de secuencia
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws FrmkOOSSException{
		SecuenciaDTO resultado = null;
		try{
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerSecuencia():start");
			resultado = serviceFrmkOOSS.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch(GeneralException e){
			logger.debug("FrmkOOSSException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return resultado;		
	}

	/** 
	 *  Obtiene las formas de pago
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws FrmkOOSSException{
		FormaPagoListDTO documentos = new FormaPagoListDTO();
		try{
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerFormasPago():start");
			documentos = serviceFrmkOOSS.obtenerFormasPago(param);
		} catch(GeneralException e){
			logger.debug("SupOrdHanException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return documentos;		
	}

	/** 
	 *  Obtiene los tipos de documentos de pago
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws GeneralException{	
		DocumentoListDTO documentos = null;
		try{
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDocumentos():start");
			documentos = serviceFrmkOOSS.obtenerTiposDocumentos(param);
			logger.debug("obtenerTiposDocumentos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return documentos;			
	}

	/** 
	 *  Obtiene elimina la solicitud de descuento
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws FrmkOOSSException{
		RetornoDTO respuesta = null;
		try {
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarSolicitud():start");
			respuesta = serviceFrmkOOSS.eliminarSolicitud(registro);
			logger.debug("eliminarSolicitud():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;		
	}

	/** 
	 *  Elimina el presupuesto
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws FrmkOOSSException{
		RetornoDTO resultado = null;
		try{
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);

			logger.debug("Inicio:eliminarPresupuesto()");
			resultado = serviceFrmkOOSS.eliminarPresupuesto(registro);
			logger.debug("Fin:eliminarPresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}			
		return resultado;			

	}

	/** 
	 *  Obtiene el numero de cuotas en el que se puede
	 *  parcelar el pago de un producto
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuotasProductoDTO[] obtenerCuotasProducto() throws FrmkOOSSException {
		//String log = global.getValor("service.log");
		String log = global.getValor("negocio.log");//pv 230709
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotasProducto():start");
		logger.debug("obtenerCuotasProducto():end");
		CuotasProductoDTO[] cuotasProducto = null;

		try {
			cuotasProducto = serviceFrmkOOSS.obtenerCuotasProducto();
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}


		return cuotasProducto;
	}

	/** 
	 *  Obtiene el vendedor asociado al usuario
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws FrmkOOSSException{
		UsuarioDTO retorno = null;
		try {
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			logger.debug("obtenerVendedor():start");
			retorno = serviceFrmkOOSS.obtenerVendedor(usuario);
			logger.debug("obtenerVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return retorno;				
	}

	/** 
	 *  Obtiene el texto de la carta
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws FrmkOOSSException{
		CartaGeneralDTO retorno = null;
		//String log = global.getValor("service.log");
		String log = global.getValor("negocio.log");//pv 230709
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTextoCarta():start");
		try {
			retorno = serviceFrmkOOSS.obtenerTextoCarta(cartaGeneral);
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		logger.debug("obtenerTextoCarta():end");
		return retorno;
	}

	/** 
	 *  Obtiene el máximo, mínimo del descuento y el indicador de
	 *  si tiene privilegios para hacer los descuentos.
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws FrmkOOSSException{
		DescuentoVendedorDTO retorno = null;
		try {
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDescuentoVendedor():start");
			retorno = serviceFrmkOOSS.obtenerDescuentoVendedor(vendedor);
			logger.debug("obtenerDescuentoVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return retorno;			
	}

	

	/** 
	 *  Obtiene el estado de la solicitud
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws FrmkOOSSException{
		RegistroSolicitudDTO respuesta = null;
		try {
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		logger.debug("consultarEstadoSolicitud():start");
			respuesta = serviceFrmkOOSS.consultarEstadoSolicitud(registro);
			logger.debug("consultarEstadoSolicitud():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;			
	}

	/** 
	 *  Registra una venta
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws FrmkOOSSException{
		RetornoDTO respuesta = null;
		logger.debug("registrarVenta():start");
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			respuesta = serviceFrmkOOSS.registrarVenta(venta);
			logger.debug("registrarVenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;		
	}

	/** 
	 *  Acepta el presupuesto
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws FrmkOOSSException{
		RetornoDTO respuesta = null;
		try {
			//String log = global.getValor("service.log"); pv 230709
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("aceptarPresupuesto():start");
			respuesta = serviceFrmkOOSS.aceptarPresupuesto(presup);
			logger.debug("aceptarPresupuesto():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;		

	}

	/** 
	 *  Obtener tipo contrato
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException{
		ContratoDTO respuesta = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTipoContrato():start");
			respuesta = serviceFrmkOOSS.obtenerTipoContrato(contrato);
			logger.debug("obtenerTipoContrato():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return respuesta;		
	}

	/** 
	 *  Obtiene las modalidades de pago
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
		ModalidadPagoDTO respuesta = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerModalidadPago():start");
			respuesta = serviceFrmkOOSS.obtenerModalidadPago(modalidad);
			logger.debug("obtenerModalidadPago():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return respuesta;	
	}

	/** 
	 *  Obtiene el detalle del presupuesto
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GeneralException{
		PresupuestoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);

			logger.debug("Inicio:obtenerDetallePresupuesto()");
			resultado = serviceFrmkOOSS.obtenerDetallePresupuesto(presup);
			logger.debug("Fin:obtenerDetallePresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}			
		return resultado;
	}

	/** 
	 *  Obtiene datos del vendedor
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GeneralException{
		VendedorDTO respuesta = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerVendedor():start");
			respuesta = serviceFrmkOOSS.obtenerVendedor(vendedor);
			logger.debug("obtenerVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return respuesta;			
	}

	/** 
	 *  Inserta un concepto de descuento
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);

			logger.debug("Inicio:insertarConceptoDescuento()");
			resultado = serviceFrmkOOSS.insertarConceptoDescuento(desc);
			logger.debug("Fin:insertarConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}			
		return resultado;			

	}

	/** 
	 *  Obtiene el codigo de concepto de descuento
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws GeneralException{
		DescuentoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);

			logger.debug("Inicio:obtenerCodConceptoDescuento()");
			resultado = serviceFrmkOOSS.obtenerCodConceptoDescuento(sec);
			logger.debug("Fin:obtenerCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}			
		return resultado;		
	}

	/** 
	 *  Elimina el codigo de concepto de descuento
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GeneralException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);

			logger.debug("Inicio:eliminaCodConceptoDescuento()");
			resultado = serviceFrmkOOSS.eliminaCodConceptoDescuento(numTransaccion);
			logger.debug("Fin:eliminaCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}			
		return resultado;			

	}

	/** 
	 *  Obtiene el plan comercial
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException{
		ClienteDTO retorno = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPlanComercial():start");
			retorno = serviceFrmkOOSS.obtenerPlanComercial(cliente);
			logger.debug("obtenerPlanComercial():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return retorno;			
	}
	
	/** 
	 *  Registra una solicitud de aprobación de descuento en SCL
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws GeneralException{
		RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("solicitarAprobacionDescuento():start");

			respuesta = serviceFrmkOOSS.solicitarAprobacionDescuento(registro);

			logger.debug("solicitarAprobacionDescuento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;	
	}
	
	/** 
	 *  Consulta el estado de una factura 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO consultarEstadoFacturado(long numProceso)throws GeneralException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultarEstadoFacturado():start");

			respuesta = serviceFrmkOOSS.consultarEstadoFacturado(numProceso);

			logger.debug("consultarEstadoFacturado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;	
	}
	
	/** 
	 *  Obtiene la ruta de una factura 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura)throws GeneralException{
		ArchivoFacturaDTO respuesta = null;
		try {
			String log = global.getValor("negocio.log");//("service.log");pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerRutaFactura():start");

			respuesta = serviceFrmkOOSS.obtenerRutaFactura(factura);

			logger.debug("obtenerRutaFactura():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;	
	}
	
	/** 
	 *  Obtiene parámetros generales 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO registro) throws GeneralException{
		ParametroDTO respuesta = null;
		try {
			//String log = global.getValor("service.log");
			String log = global.getValor("negocio.log");//pv 230709
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerParametroGeneral():start");

			respuesta = serviceFrmkOOSS.obtenerParametroGeneral(registro);

			logger.debug("obtenerParametroGeneral():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}
		return respuesta;	
	}
	
	/** 
	 *  registrarOOSSEnLinea
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = serviceFrmkOOSS.registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}		
		return respuesta;
	}
	
	/** 
	 *  Actualiza Renovación 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizaRenova():start");
			respuesta = serviceFrmkOOSS.actualizaRenova(param);
			logger.debug("actualizaRenova():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}		
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
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws GeneralException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			//Santiago Ventura 23-04-2010	
			logger.debug("obtenerDatosAbonado2():start");
			resultado = serviceFrmkOOSS.obtenerDatosAbonado2(abonado);
			logger.debug("obtenerDatosAbonado2():end");
		} catch(GeneralException e){
			logger.debug("CusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws GeneralException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			//Santiago Ventura 23-04-2010
			logger.debug("obtenerDatosCliente():start");
			resultado = serviceFrmkOOSS.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch(GeneralException e){
			logger.debug("CusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws GeneralException {
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			//Santiago Ventura 23-04-2010
			logger.debug("insertarCobroAdelantado():start");
			resultado = serviceFrmkOOSS.insertarCobroAdelantado(clienteCobroAdelantadoDTO);
			logger.debug("insertarCobroAdelantado():end");
		} catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}
	
	/** 
	 *  registrarCarta
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws GeneralException {
		boolean respuesta = false;
		try {
			respuesta = serviceFrmkOOSS.registrarCarta(dto, numOS);
			
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			context.setRollbackOnly();
			throw new FrmkOOSSException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkOOSSException(e);
		}		
		return respuesta;
	}
}