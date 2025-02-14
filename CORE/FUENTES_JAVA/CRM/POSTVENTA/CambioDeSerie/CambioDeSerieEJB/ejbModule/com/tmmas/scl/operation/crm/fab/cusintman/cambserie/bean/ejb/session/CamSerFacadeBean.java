/**
 * 
 */
package com.tmmas.scl.operation.crm.fab.cusintman.cambserie.bean.ejb.session;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.negocio.ejb.session.ConsultaFacadeSTL;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.cambserie.bean.ejb.helper.FacadeMaker;
import com.tmmas.scl.operation.crm.fab.cusintman.cambserie.bean.ejb.helper.Global;
import com.tmmas.scl.operation.crm.fab.cusintman.cambserie.common.dataTransferObject.RegistraCambioDeSerieActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.CambioDeSerieSrvFactory;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces.CambioDeSerieSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces.CambioDeSerieSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CamSerFacade"	
 *           description="An EJB named CamSerFacade"
 *           display-name="CamSerFacade"
 *           jndi-name="CamSerFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class CamSerFacadeBean implements javax.ejb.SessionBean {
	CambioDeSerieSrvFactoryIF factorySrv1 = new CambioDeSerieSrvFactory();	
	// Obtiene el application service
	CambioDeSerieSrvIF service1 = factorySrv1.getApplicationService1();

	SessionContext context;

	private FacadeMaker facadeMaker= FacadeMaker.getInstance();
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(CamSerFacadeBean.class);

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
		 this.context = arg0;
	}

	/**
	 * 
	 */
	public CamSerFacadeBean() {
		// TODO Auto-generated constructor stub
	}
//	 ---------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			resultado = service1.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch(CusIntManException e){
			logger.debug("CusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;
	}

//	 ---------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			resultado = service1.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch(CusIntManException e){
			logger.debug("CusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;
	}	

//	 ---------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException{
		UsuarioAbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			resultado = service1.obtenerDatosUsuarioAbonado(usuarioAbonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch(CusIntManException e){
			logger.debug("CusIntManException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;
		
	}	// obtenerDatosUsuarioAbonado

// ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public BodegaDTO[] obtenerBodegas(SesionDTO sesion) throws ProductException {
		BodegaDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerBodegas():start");
				resultado = service1.obtenerBodegas(sesion);
			logger.debug("obtenerBodegas():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return resultado;
		
	}	// obtenerBodegas

//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie() throws ProductException {
		CausaCamSerieDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCausaCambioSerie():start");
				resultado = service1.obtenerCausaCambioSerie();
			logger.debug("obtenerCausaCambioSerie():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return resultado;
		
	}	// obtenerBodegas

//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws ProductException {
		TipoDeContratoDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDeContrato():start");
				resultado = service1.obtenerTiposDeContrato(sessionDTO);
			logger.debug("obtenerTiposDeContrato():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return resultado;
		
	}	// obtenerBodegas
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public TecnologiaDTO[] obtenerTecnologia () throws ProductException {
		TecnologiaDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTecnologia():start");
				resultado = service1.obtenerTecnologia();
			logger.debug("obtenerTecnologia():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return resultado;
		
	}	// obtenerTecnologia
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException {
		MesesProrrogasDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerMesesProrroga():start");
				resultado = service1.obtenerMesesProrroga();
			logger.debug("obtenerMesesProrroga():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return resultado;
		
	}	// obtenerTecnologia
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerModalidadPago():start");
				resultado = service1.obtenerModalidadPago(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPago():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerModalidadPago
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerModalidadPagoSimcard():start");
				resultado = service1.obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPagoSimcard():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerModalidadPagoSimcard
	
//	 ---------------------------------------------------------------------------------


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws ProductException{
		
		TipoTerminalDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTipoTerminal():start");
				resultado = service1.obtenerTipoTerminal(tecnologia);
			logger.debug("obtenerTipoTerminal():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerTipoTerminal
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException{
		
		CuotaDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCuotas():start");
				resultado = service1.obtenerCuotas(sesion, modalidadPago);
			logger.debug("obtenerCuotas():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerCuotas
	
//	 ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO sesion) throws ProductException{
		
		CategoriaTributariaDTO[] resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCatTributaria():start");
				resultado = service1.obtenerCatTributaria(sesion);
			logger.debug("obtenerCatTributaria():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerCuotas
	
//	 ---------------------------------------------------------------------------------	


	/* 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO vendedor) throws CustomerException {		
		VendedorDTO respuesta = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerEstadoVendedor():start");
				respuesta = service1.obtenerEstadoVendedor(vendedor);
			logger.debug("obtenerEstadoVendedor():end");
		} catch(CustomerException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
		return respuesta;
		
	}	// obtenerEstadoVendedor
	
//	 ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	
	public void bloquearVendedor(VendedorDTO vendedor) throws CustomerException {		
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("bloquearVendedor():start");
			service1.bloquearVendedor(vendedor);
			logger.debug("bloquearVendedor():end");
		} catch(CustomerException e){
			logger.debug("CustomerException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}

	}	// bloquearVendedor
	
//	 ---------------------------------------------------------------------------------	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
		
	public void desbloquearVendedor(VendedorDTO vendedor) throws CustomerException {		
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("desbloquearVendedor():start");
			service1.bloquearVendedor(vendedor);
			logger.debug("desbloquearVendedor():end");
		} catch(CustomerException e){
			logger.debug("CustomerException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}

	}	*/// desbloquearVendedor
	
//	 ---------------------------------------------------------------------------------	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException
	{
		UsosVentaDTO[] resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerUsosVenta():start");
				resultado = service1.obtenerUsosVenta();
			logger.debug("obtenerUsosVenta():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerUsosVenta
	
//	 ---------------------------------------------------------------------------------		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException {
		CentralDTO[] resultado = null;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCentralTecnologiaHlr():start");
				resultado = service1.obtenerCentralTecnologiaHlr(serie, tecnologia);
			logger.debug("obtenerCentralTecnologiaHlr():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return resultado;
		
	}	// obtenerCentralTecnologiaHlr
	
//	 ---------------------------------------------------------------------------------		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException {

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaCausaCamSerie():start");
			service1.validaCausaCamSerie(sesion, causaCamSerie);
			logger.debug("validaCausaCamSerie():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// validaCausaCamSerie
	
//	 ---------------------------------------------------------------------------------			

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws ProductException {

		MensajeRetornoDTO respuesta = null;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("ejecutaRestrccion():start");
				respuesta = service1.ejecutaRestrccion(restricciones);
			logger.debug("ejecutaRestrccion():end");
		} catch(ProductException e){
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// ejecutaRestrccion
	
//	 ---------------------------------------------------------------------------------			
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException {

		UsuarioSistemaDTO respuesta = null;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerInformacionUsuario():start");
				respuesta = service1.obtenerInformacionUsuario(usuarioSistema);
			logger.debug("obtenerInformacionUsuario():end");
		} catch(AplicationException e){
			logger.debug("AplicationException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AplicationException(e);
		}
		
		return respuesta;
		
	}	// obtenerInformacionUsuario
	
//	 ---------------------------------------------------------------------------------		


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public SerieDTO reservaSimcard (String accionProceso, 
								SerieDTO serie, 
								UsuarioSistemaDTO usuarioSistema, 
								UsuarioAbonadoDTO usuarioAbonado, 
								String parametros,
								CausaCamSerieDTO causa,
								TipoTerminalDTO terminal,
								ModalidadPagoDTO modalidadPago, 
								String tipoAccion
								, String prmSerieInternta
								) throws ProductException, CustomerException{
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reservaSimcard():start");
			
			SerieDTO infoserie = service1.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago,tipoAccion,prmSerieInternta);
			//SerieDTO infoserie = service1.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago,tipoAccion);
			logger.debug("reservaSimcard():end");

			// retorno la info de la serie
			return infoserie;
			
		} catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch(CustomerException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause());
		}
		
		
	}	// reservaSimcard
	
//	 ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String actAbo) throws ProductException {
		
		CausaSiniestroDTO[] respuesta ;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerInformacionUsuario():start");
				respuesta = service1.obtenerCausasSiniestro(usuarioAbonado, actAbo);
			logger.debug("obtenerInformacionUsuario():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// obtenerCausasSiniestro
	
//	 ---------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		
		TipoSiniestroDTO[] respuesta;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDeSiniestros():start");
				respuesta = service1.obtenerTiposDeSiniestros(usuarioAbonado);
			logger.debug("obtenerTiposDeSiniestros():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// obtenerTiposDeSiniestros
	
//	 ---------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws ProductException {

		TipoSuspencionDTO[] respuesta ;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDeSuspencion():start");
				respuesta = service1.obtenerTiposDeSuspencion();
			logger.debug("obtenerTiposDeSuspencion():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// obtenerTiposDeSuspencion
	
//	 ---------------------------------------------------------------------------------

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {

		SolicitudAvisoDeSiniestroDTO respuesta ;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("grabaAvisoDeSiniestro():start");
				respuesta = service1.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario);
			logger.debug("grabaAvisoDeSiniestro():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// grabaAvisoDeSiniestro
	
//	 ---------------------------------------------------------------------------------			

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException{

	try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraCambioSimcard():start");
			service1.registraCambioSimcard(usuarioAbonado, serie, usoArticulo, cuota, sesion, modalidadPago, bodega, actabo, codModulo, causaCamSerie);
			logger.debug("registraCambioSimcard():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
	}	// registraCambioSimcard
	
//	 ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException	{ 
		SerieDTO respuesta = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("recInfoSerie():start");
				respuesta = service1.recInfoSerie(serie);
			logger.debug("recInfoSerie():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// recInfoSerie
	
//	 ---------------------------------------------------------------------------------		
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{ 
		SiniestrosDTO[] respuesta = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("recDatosSiniestroAboando():start");
				respuesta = service1.recDatosSiniestroAboando(usuarioAbonado);
			logger.debug("recDatosSiniestroAboando():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
		return respuesta;
		
	}	// recDatosSiniestroAboando
	
//	 ---------------------------------------------------------------------------------		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException {

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("anulaSinistroAbonado():start");
			service1.anulaSinistroAbonado(Siniestros, usuarioAbonado, sesion);
			logger.debug("anulaSinistroAbonado():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch
		
	}	// anulaSinistroAbonado
	
//	 ---------------------------------------------------------------------------------	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
//	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,com.tmmas.scl.vendedor.dto.VendedorDTO vendedor) throws ProductException { // RRG 23-09-2008 COL 70904
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,com.tmmas.scl.vendedor.dto.VendedorDTO vendedor,ConsultaSaldoDTO consultaSaldoDTO) throws ProductException {

		String respuesta;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			//if (oossComisionable)	{
			logger.debug("verificando Registro Vendedor:"+vendedor!=null?"existe":"null");
			if (vendedor != null) {
				logger.debug("Registrando informacion de vendedor existente..");
				VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
				logger.debug("getVendedorFacade:despues");
				//com.tmmas.scl.vendedor.dto.VendedorDTO resultado = null;
				try {
					logger.debug("registrarInformacionVendedor():antes");
					facade.registrarInformacionVendedor(vendedor);
					logger.debug("registrarInformacionVendedor():despues");
				} catch (Exception e) {
					logger.debug("Exception", e);
					throw new CusIntManException(e);			
				}
				logger.debug("Registrando informacion de vendedor existente en forma exitosa..");
			}
			//} // if
			logger.debug("registraCambioDeSerie():start");
			SaldoDTO retornoSaldo = new SaldoDTO(); // RRG 23-09-2008 COL 70904
			if (consultaSaldoDTO!=null){ // RRG 23-09-2008 COL 70904
				ConsultaFacadeSTL socketPSFacade=facadeMaker.getSocketPSFacade(); // RRG 23-09-2008 COL 70904
				logger.debug("Inicio registraCambioDeSerie():consultaSaldoPlataforma"); // FPP 15-04-2009 85562 
				retornoSaldo= socketPSFacade.consultaSaldo(consultaSaldoDTO); // RRG 23-09-2008 COL 70904
				logger.debug("Fin registraCambioDeSerie():consultaSaldoPlataforma"); // FPP 15-04-2009 85562
			} // RRG 23-09-2008 COL 70904
			respuesta = service1.registraCambioDeSerie(parametros,retornoSaldo); // RRG 23-09-2008 COL 70904
//			respuesta = service1.registraCambioDeSerie(parametros); // RRG 23-09-2008 COL 70904
			logger.debug("registraCambioDeSerie():end");
		} 
		catch(ProductException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		
		}	// catch

		return respuesta;
		
	}	// registraCambioDeSerie
	
//	 ---------------------------------------------------------------------------------
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO cargos) throws GeneralException{
		RegCargosDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("construirRegistroCargos():start");
		try {
			retorno = getFrmkCargosFacade().construirRegistroCargos(cargos);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			//logger.debug("GeneralException[" + loge + "]");

			logger.debug("e.getMessage: " + e.getMessage()); // RRG COL 07-07-2009 96723
			logger.debug("e.getCause: " + e.getCause());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigo: " + e.getCodigo());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigoEvento: " + e.getCodigoEvento());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento());	 // RRG COL 07-07-2009 96723

			//throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
			  throw new FrmkCargosException("Se ha producido un error en el módulo de cargos. "+ e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());

		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			//logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			//throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());

			logger.debug("e.getMessage: " + e.getMessage()); // RRG COL 07-07-2009 96723
			logger.debug("e.getCause: " + e.getCause());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigo: " + e.getCodigo());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigoEvento: " + e.getCodigoEvento());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento());	 // RRG COL 07-07-2009 96723

			//throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
			  throw new FrmkCargosException("Se ha producido un error en el módulo de cargos. "+ e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());


		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("construirRegistroCargos():end");
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
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws GeneralException{
		ResultadoRegCargosDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("parametrosRegistrarCargos():start");
		try {
			retorno = getFrmkCargosFacade().parametrosRegistrarCargos(cargos);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("parametrosRegistrarCargos():end");
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
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws GeneralException{
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarVenta():start");
		try {
			retorno = getFrmkOOSSFacade().registrarVenta(venta);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("registrarVenta():end");
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
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws GeneralException{
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("aceptarPresupuesto():start");
		try {
			retorno = getFrmkOOSSFacade().aceptarPresupuesto(presup);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("aceptarPresupuesto():end");
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
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException{
		logger.debug("obtenerTipoContrato():start");
		
		ContratoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerTipoContrato(contrato);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerTipoContrato():end");
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
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GeneralException{
		logger.debug("obtenerDetallePresupuesto():start");
		
		PresupuestoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerDetallePresupuesto(presup);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDetallePresupuesto():end");
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
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GeneralException{	
	
		UsuarioDTO resultado = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerVendedor():start");
		try {
			resultado = getFrmkOOSSFacade().obtenerVendedor(usuario);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw e;
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerVendedor():end");
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
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GeneralException{
		logger.debug("obtenerVendedor():start");
		
		VendedorDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerVendedor(vendedor);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerVendedor():end");
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
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException{
		logger.debug("insertarConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().insertarConceptoDescuento(desc);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("insertarConceptoDescuento():end");
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
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO param) throws GeneralException{
		logger.debug("obtenerCodConceptoDescuento():start");
		
		DescuentoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerCodConceptoDescuento(param);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerCodConceptoDescuento():end");
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
	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws CusIntManException {
		ArticuloDTO[] retValue = null;
		
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerListaArticulos():start");
		try {
			logger.debug("obtenerListaArticulos():end");
			retValue = service1.obtenerListaArticulos(articuloDTO);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerTipoTerminal():end");

		return retValue;
		
	}	// obtenerMesesProrroga

//	 ------------------------------------------------------------------------------------
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GeneralException{
		logger.debug("eliminaCodConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().eliminaCodConceptoDescuento(numTransaccion);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("eliminaCodConceptoDescuento():end");
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
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException{
		logger.debug("obtenerVendedor():start");
		
		ClienteDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerPlanComercial(cliente);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerVendedor():end");
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
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws GeneralException{
		logger.debug("consultarEstadoFacturado():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().consultarEstadoFacturado(numProceso);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("consultarEstadoFacturado():end");
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
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws GeneralException{
		logger.debug("consultarEstadoFacturado():start");
		
		ArchivoFacturaDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerRutaFactura(factura);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			context.setRollbackOnly();
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("consultarEstadoFacturado():end");
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
	public ParametroDTO obtenerParametroGeneral(ParametroDTO parametro) throws GeneralException{
		logger.debug("obtenerParametroGeneral():start");
		ParametroDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerParametroGeneral(parametro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			context.setRollbackOnly();
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerParametroGeneral():end");
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
	public void cierreVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		logger.debug("cierreVenta():start");
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			getFrmkCargosFacade().cierreVenta(gaVentasDTO);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en cierreVenta.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			context.setRollbackOnly();
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("cierreVenta():end");
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
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = getFrmkOOSSFacade().registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO registrarRenova) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("actualizaRenova():start");
			respuesta = getFrmkOOSSFacade().actualizaRenova(registrarRenova);
			logger.debug("actualizaRenova():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
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
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
		logger.debug("obtenerModalidadPago():start");
		
		ModalidadPagoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerModalidadPago(modalidad);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerModalidadPago():end");
		return retorno;		
	}	
	
	
	
	private FrmkCargosFacade getFrmkCargosFacade() throws GeneralException {
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		
		logger.debug("getFrmkCargosFacade():start");
		
		String jndi = global.getValor("jndi.FrmkCargosFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.FrmkCargosProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = global.getValor("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = global.getValor("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = global.getValor("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");			
		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
			throw new GeneralException(e);
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
			throw new GeneralException(e);
		}
		
		FrmkCargosFacadeHome facadeHome =
			(FrmkCargosFacadeHome) PortableRemoteObject.narrow(obj, FrmkCargosFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de FrmkOOSSFacade...");
		FrmkCargosFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new GeneralException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}

		logger.debug("getFrmkCargosFacade()():end");
		return facade;
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
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws CusIntManException{	
	
		SecuenciaDTO resultado = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSecuencia():start");
		try {
			resultado = getFrmkOOSSFacade().obtenerSecuencia(parametro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			context.setRollbackOnly();
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerSecuencia():end");
		return resultado;
	}
	
	/* ---------------------------------------------------------------------------------
		/**
		 * @author: rlozano
		 * @description: metodos de FrmkOOSS y FrmkCargos 
		 */
		
		//Fachada del Framework de OOSS
		private FrmkOOSSFacade getFrmkOOSSFacade() throws GeneralException {
			String log = global.getValor("negocio.log");
			log=System.getProperty("user.dir")+ log;
			PropertyConfigurator.configure(log);
			
			logger.debug("getFrmkOOSSFacade():start");
			
			String jndi = global.getValor("jndi.FrmkOOSSFacade");
			logger.debug("Buscando servicio[" + jndi + "]");
			
			String url = global.getValor("url.FrmkOOSSProvider");
			logger.debug("Url provider[" + url + "]");
			
			String initialContextFactory = global.getValor("initial.context.factory");
			logger.debug("Initial context factory[" + initialContextFactory + "]");
			
			String securityPrincipal = global.getValor("security.principal");
			logger.debug("Security principal[" + securityPrincipal + "]");	
			
			String securityCredentials = global.getValor("security.credentials");
			logger.debug("Security credentials[" + securityCredentials + "]");			
			

			Hashtable env = new Hashtable();
			env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
			env.put(Context.PROVIDER_URL, url);
			env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
			env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
			
			Context context = null;
			try {
				logger.debug("Inicializando contexto:antes");
				context = new InitialContext(env);
				logger.debug("Inicializando contexto:despues");
			} catch (NamingException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("NamingException[" + loge + "]");
				throw new GeneralException(e);
			}

			Object obj = null;
			try {
				logger.debug("Buscando jndi:antes");
				obj = context.lookup(jndi);
				logger.debug("Buscando jndi:despues");
			} catch (NamingException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("NamingException[" + loge + "]");
				throw new GeneralException(e);
			}
			
			FrmkOOSSFacadeHome facadeHome =
				(FrmkOOSSFacadeHome) PortableRemoteObject.narrow(obj, FrmkOOSSFacadeHome.class);	
			
			logger.debug("Recuperada interfaz home de FrmkOOSSFacade...");
			FrmkOOSSFacade facade = null;
			try {
				facade = facadeHome.create();
			} catch (CreateException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("CreateException[" + loge + "]");
				throw new GeneralException(e);
				
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new GeneralException(e);
			}

			logger.debug("getFrmkOOSSFacade():end");
			return facade;
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
		public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor)throws GeneralException{
			DescuentoVendedorDTO retorno = null;
			String log = global.getValor("negocio.log");
			log=System.getProperty("user.dir")+ log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDescuentoVendedor():start");
			try {
				retorno = getFrmkOOSSFacade().obtenerDescuentoVendedor(vendedor);
			}catch(CusIntManException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("CusIntManException[" + loge + "]");
				throw e;
			}catch(GeneralException e){
				String loge = StackTraceUtl.getStackTrace(e);
				context.setRollbackOnly();
				logger.debug("GeneralException[" + loge + "]");
				throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new GeneralException(e);
			}
			logger.debug("obtenerDescuentoVendedor():end");
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
		public DocumentoListDTO obtenerTiposDocumento(BusquedaTiposDocumentoDTO tipoDocumento) throws GeneralException{
			DocumentoListDTO documentoList = null;
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDocumento():start");
				try {
					documentoList = getFrmkOOSSFacade().obtenerTiposDocumentos(tipoDocumento);
				} catch (GeneralException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("ManColException[" + loge + "]");
					context.setRollbackOnly();
					throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new CusIntManException(e);
				}
			logger.debug("obtenerTiposDocumento():end");
			return documentoList;
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
		public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO formaPago) throws GeneralException{
			
			FormaPagoListDTO formaPagoList = null;
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFromasPago():start");
				try {
					formaPagoList = getFrmkOOSSFacade().obtenerFormasPago(formaPago);
				} catch (GeneralException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("GeneralException[" + loge + "]");
					context.setRollbackOnly();
					throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("GeneralException[" + loge + "]");
					throw new CusIntManException(e);
				}
			logger.debug("obtenerFromasPago():end");
			
			return formaPagoList;
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
		public CuotasProductoDTO[] obtenerCuotasProducto() throws GeneralException{
			CuotasProductoDTO[] cuotasProducto = null;
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCuotasProducto():start");
				try {
					cuotasProducto = getFrmkOOSSFacade().obtenerCuotasProducto();
				} catch (GeneralException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("ManColException[" + loge + "]");
					context.setRollbackOnly();
					throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
				} catch (RemoteException e) {
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("RemoteException[" + loge + "]");
					throw new CusIntManException(e);
				}
			logger.debug("obtenerCuotasProducto():end");
			return cuotasProducto;
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
		public ObtencionCargosDTO obtencionCargos(ParametrosObtencionCargosDTO parametrosCargos) throws GeneralException{	
		
			ObtencionCargosDTO resultado = null;
			String log = global.getValor("negocio.log");
			log=System.getProperty("user.dir")+ log;
			PropertyConfigurator.configure(log);		
			logger.debug("CamSerFacadeBean obtencionCargos():start");
			try {

				logger.debug("parametrosCargos.getOperacion:"+	parametrosCargos.getOperacion()); // RRG

				logger.debug("CamSerFacadeBean:Tipo Pantalla::"+parametrosCargos.getTipoPantalla());                  
				logger.debug("CamSerFacadeBean:Codigo Modalidad de Venta::"+parametrosCargos.getCodigoModalidadVenta());      
				logger.debug("CamSerFacadeBean:Abonados cantidad::"+parametrosCargos.getAbonados());              
				logger.debug("CamSerFacadeBean:Codigo Cliente Origen::"+parametrosCargos.getCodigoClienteOrigen());          
				logger.debug("CamSerFacadeBean:Codigo Cliente Destino::"+parametrosCargos.getCodigoClienteDestino());         
				logger.debug("CamSerFacadeBean:Codigo PlanTarifario Origen::"+parametrosCargos.getCodigoPlanTarifOrigen());    
				logger.debug("CamSerFacadeBean:Codigo PlanTarifario Destino::"+parametrosCargos.getCodigoPlanTarifDestino());   
				logger.debug("CamSerFacadeBean:Tipo Segmentacion Origen::"+parametrosCargos.getTipoSegOrigen());       
				logger.debug("CamSerFacadeBean:Tipo Segmentacion Origen::"+parametrosCargos.getTipoSegDestino());       
				logger.debug("CamSerFacadeBean:Codigo Causa Cambio de Plan::"+parametrosCargos.getCodCausaCambioPlan());    
				logger.debug("CamSerFacadeBean:Codigo Actuacion::"+parametrosCargos.getCodActabo());               
				logger.debug("CamSerFacadeBean:Codigo Tecnologia::"+parametrosCargos.getCodigoTecnologia());              
				logger.debug("CamSerFacadeBean:Codigo Penalizacion::"+parametrosCargos.getCodPenalizacion());            
				logger.debug("CamSerFacadeBean:Indicador Comodato::"+parametrosCargos.getIndComodato());             
				logger.debug("CamSerFacadeBean:Codigo Categoria::"+parametrosCargos.getCodCategoria());               
				logger.debug("CamSerFacadeBean:Tipo Contrato::"+parametrosCargos.getTipoContrato());                  
				logger.debug("CamSerFacadeBean:Indicador Causa::"+parametrosCargos.getIndCausa());                
				logger.debug("CamSerFacadeBean:Estado Devolucion de Cargador::"+parametrosCargos.getEstdDevlCargador());  
				logger.debug("CamSerFacadeBean:Fecha Vigencia::"+parametrosCargos.getFechaVigenciaAbonadoCero());                
				logger.debug("CamSerFacadeBean:Nombre Usuario:" + parametrosCargos.getNombreUsuario()); //INC-79469; COL; 11-03-2009; AVC


				resultado = getFrmkCargosFacade().obtenerCargos(parametrosCargos);
			} catch (FrmkCargosException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("GeneralException[" + loge + "]");

			logger.debug("e.getMessage: " + e.getMessage()); // RRG COL 07-07-2009 96723
			logger.debug("e.getCause: " + e.getCause());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigo: " + e.getCodigo());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigoEvento: " + e.getCodigoEvento());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento());	 // RRG COL 07-07-2009 96723

			//throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
			  throw new FrmkCargosException("Se ha producido un error en el módulo de cargos. "+ e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			}catch(GeneralException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("GeneralException[" + loge + "]");
				context.setRollbackOnly();
			//throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());

			logger.debug("e.getMessage: " + e.getMessage()); // RRG COL 07-07-2009 96723
			logger.debug("e.getCause: " + e.getCause());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigo: " + e.getCodigo());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigoEvento: " + e.getCodigoEvento());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento());	 // RRG COL 07-07-2009 96723

			//throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
			  throw new FrmkCargosException("Se ha producido un error en el módulo de cargos. "+ e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new GeneralException(e);
			}
			logger.debug("obtencionCargos():end");
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
		public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GeneralException{
			RetornoDTO retorno= null;
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarPresupuesto():start");
			try {
				retorno = getFrmkOOSSFacade().eliminarPresupuesto(registro);
			} catch (GeneralException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("AppPriDisRebException[" + loge + "]");
				context.setRollbackOnly();
				throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("eliminarPresupuesto[" + loge + "]");
				throw new CusIntManException(e);
			}
			
			logger.debug("eliminarSolicitud():end");
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
		
		public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws GeneralException{
			CartaGeneralDTO retorno = null;

			String log = global.getValor("negocio.log");
			log=System.getProperty("user.dir")+ log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTextoCarta():start");
			try {			
				retorno = getFrmkOOSSFacade().obtenerTextoCarta(cartaGeneral);
			}catch(GeneralException e){
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("GeneralException[" + loge + "]");
				context.setRollbackOnly();
				throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new GeneralException(e);
			}
			logger.debug("obtenerTextoCarta():end");
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
		
		
		public void registrarOOSSCambioSerieAction(RegistraCambioDeSerieActionDTO parametros) throws GeneralException {
		logger.debug("RegistraCambioDeSerieActionDTO():start");
		String textoMensajeRestricciones = "";
		try {
			// INICIO RRG 23-09-2008 COL 70904
			RegistrarOossEnLineaDTO regOssLinDTO = new RegistrarOossEnLineaDTO();
			regOssLinDTO = parametros.getRegistrarOossEnLineaDTO();
			ConsultaSaldoDTO consultaSaldoDTO = null;
			if (parametros.isBuscaSocketPS()) {
				consultaSaldoDTO = new ConsultaSaldoDTO();
				consultaSaldoDTO.setLin(String.valueOf(parametros.getParametrosCambioSerieDTO().getNumCelular()));
				consultaSaldoDTO.setRegion(parametros.getCodTecnAnt());
				logger.debug("getLin:" + consultaSaldoDTO.getLin());
				logger.debug("getRegion:" + consultaSaldoDTO.getRegion());
			}
			// FIN RRG 23-09-2008 COL 70904
			if ("NO".equals(parametros.getCmbCiclo()) && parametros.getPresupuestoDTO() != null) {
				// if ("NO".equals(parametros.getCmbCiclo())){ // INICIO RRG
				// 23-09-2008 COL 70904
				logger.debug("aceptarPresupuesto:antes");
				textoMensajeRestricciones = "Error en la Aceptación del Presupuesto";
				this.aceptarPresupuesto(parametros.getPresupuestoDTO());
				logger.debug("aceptarPresupuesto:despues");

				logger.debug("actualizaFacturacion:antes");
				String numeroVenta = "" + parametros.getPresupuestoDTO().getNumVenta();
				logger.debug("numeroVenta " + numeroVenta);
				ParametrosEjecucionFacturacionDTO parametrosEjecucion = new ParametrosEjecucionFacturacionDTO();
				parametrosEjecucion.setNumeroVenta(numeroVenta);
				this.actualizaFacturacion(parametrosEjecucion);
				logger.debug("actualizaFacturacion:despues");

			}
			
			textoMensajeRestricciones = "Error al Registrar cambio de Serie";
			// this.registraCambioDeSerie(parametros.getParametrosCambioSerieDTO(),parametros.getVendedorDTO()
			// ); // RRG 23-09-2008 COL 70904
			this.registraCambioDeSerie(parametros.getParametrosCambioSerieDTO(), parametros.getVendedorDTO(),
					consultaSaldoDTO);

			// 050809
			logger.debug("actualizaRenova:antes");
			this.actualizaRenova(parametros.getRegistrarRenovaDTO());
			logger.debug("actualizaRenova:despues");

			/**
			 * @author JIB Fecha: 22/11/2010 Incidencia: 155633
			 */
			logger.debug("registrarCarta:antes");
			this.registrarCarta(parametros.getCartaGeneralDTO(), parametros.getRegistrarOossEnLineaDTO().getNumOs());
			logger.debug("registrarCarta:despues");

			RetornoDTO retValue = this.registrarOOSSEnLinea(parametros.getRegistrarOossEnLineaDTO());

		} catch (GeneralException e) {
			// INI FPP 15-04-2009
			/*
			 * String loge = StackTraceUtl.getStackTrace(e);
			 * logger.debug("GeneralException[" + loge + "]");
			 * context.setRollbackOnly(); throw new
			 * GeneralException(textoMensajeRestricciones, e.getCause(),
			 * e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			 */

			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("registrarOOSSCambioSerieAction GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(textoMensajeRestricciones, e.getCause(), e.getCodigo(), e.getCodigoEvento(), e
					.getDescripcionEvento());
		} catch (Exception e) { // 86243
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("registrarOOSSCambioSerieAction Exception[" + loge + "]");
			throw new GeneralException(textoMensajeRestricciones);
		}
		// FIN FPP 15-04-2009
		logger.debug("RegistraCambioDeSerieActionDTO():end");
	}
		
		/**
		 * 
		 * <!-- begin-xdoclet-definition -->
		 * 
		 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition
		 *                       -->
		 * @generated
		 * 
		 * //TODO: Must provide implementation for bean method stub
		 */	
		
		public TerminalDTO obtenerTerminal (TerminalDTO terminalDTO) throws ProductException{
			
			try {
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("obtenerTerminal():start");
				terminalDTO = service1.obtenerTerminal(terminalDTO);
				logger.debug("obtenerTerminal():end");
				
			} catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ProductException(e);
			}
			
			return terminalDTO;		
			
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
		
		public SimcardDTO obtenerSimcard (SimcardDTO simcardDTO) throws ProductException{
			
			try {
				String log = global.getValor("negocio.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("obtenerSimcard():start");
				simcardDTO = service1.obtenerSimcard(simcardDTO);
				logger.debug("obtenerSimcard():end");
				
			} catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ProductException(e);
			}
			
			return simcardDTO;		
			
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
		
		public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws GeneralException,RemoteException{
			logger.debug("getRecPrecioEquipoActual: start");
			PrecioTerminalDTO  precioTerminalDTO=null;
			try{
				
				precioTerminalDTO=getFrmkCargosFacade().getRecPrecioEquipoActual(terminalDTO);
				
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			
			logger.debug("getRecPrecioEquipoActual: end");
			return precioTerminalDTO;
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
		public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException,RemoteException{
			logger.debug("verificaConcFactGarantia: start");
			RetornoDTO  retValue=null;
			try{
				
				retValue=service1.verificaConcFactGarantia(parametrosDTO);
				
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			
			logger.debug("verificaConcFactGarantia: end");
			return retValue;
			
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
		public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO)throws GeneralException{
			logger.debug("validaSeleccionCausa: start");
			RetornoDTO  retValue=null;
			try{
				
				retValue=service1.validaSeleccionCausa(parametrosCambioSerieDTO);
				
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			
			logger.debug("validaSeleccionCausa: end");
			return retValue;

			
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
		public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO)throws GeneralException{
			logger.debug("validaSeleccionCausa: start");
			PlanTarifarioDTO  retValue=null;
			try{
				
				retValue=service1.getCategoriaPlanTarifario(planTarifarioDTO);
				
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			
			logger.debug("validaSeleccionCausa: end");
			return retValue;

			
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
		
		public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws GeneralException{
			logger.debug("getPlanTarifarioDefault: start");
			try{
				usuarioAbonadoDTO=service1.getPlanTarifarioDefault(usuarioAbonadoDTO);
				
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			
			logger.debug("getPlanTarifarioDefault: end");
			return usuarioAbonadoDTO;
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
		public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException {
			logger.debug("obtenerOperadoraLocal: start");
			OperadoraLocalDTO  retValue=null;
			try{
				retValue=service1.obtenerOperadoraLocal();
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("obtenerOperadoraLocal: end");
			return retValue;
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
		public void actualizaFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws GeneralException{
			try{
				logger.debug("actualizaFacturacion: start");
				getFrmkCargosFacade().actualizaFacturacion(parametrosEjecucion);
				logger.debug("actualizaFacturacion: end");
			}catch(GeneralException e){
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
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
		public  BodegaDTO[] getBodegasXVendedor(BodegaDTO bodegaDTO) throws GeneralException 	{
			logger.debug("getBodegasXVendedor:start");
			BodegaDTO[] ret; 
			try {
				ret = service1.obtieneBodega(bodegaDTO);
			} catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("getBodegasXVendedor:end");
			return ret;
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
		public  ArticuloInDTO[] getArticulos(ArticuloInDTO entrada)  throws GeneralException {
			logger.debug("getArticulos:start");
			ArticuloInDTO[] ret; 
			try {
				ret = service1.obtieneArticulos(entrada);
			} catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("getBodegasXVendedor:end");
			return ret;
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
		public RetornoDTO validaSerieExterna (SerieDTO serie) throws GeneralException {
			RetornoDTO retValue=null;
			logger.debug("validaSerieExterna():start");
			try {
				retValue=service1.validaSerieExterna(serie);
			} catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("validaSerieExterna():end");
			return retValue;
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
		public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws GeneralException {
			RetornoDTO retValue=null;
			logger.debug("validaSerieExternaEquipo():start");
			try {
				retValue=service1.validaSerieExternaEquipo(serie);
			} catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("validaSerieExternaEquipo():end");
			return retValue;
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
		public SerieDTO[] buscarSeries(SerieDTO serie) throws GeneralException {			
			logger.debug("buscarSerie():start");
			SerieDTO[] retValue;
			try {
				retValue=service1.obtieneSerie(serie);
			} catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("buscarSerie():end");
			return retValue;
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
		public SerieDTO[] listarSerie(SerieDTO entrada)throws GeneralException {		
			logger.debug("listarSerie:start");
			SerieDTO[] retValue;
			try {
				//INICIO 177697 PAH
				//retValue = service1.obtieneSeries(entrada);
				retValue = service1.obtieneSeriesSinUso(entrada);
				//FIN 177697 PAH
			}catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("listarSerie:end");
			return retValue;
		}//fin listarSerie
		
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 * //TODO: Must provide implementation for bean method stub
		 */	
		public String consultarSeguroAbonado(Long numAbonado) throws GeneralException{
			logger.debug("consultarSeguroAbonado:start");
			String retValue;
			try {
				retValue = service1.consultarSeguroAbonado(numAbonado);
			}catch(GeneralException e) {
				logger.debug("GeneralException[", e);
				throw (e);
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new GeneralException(e);
			}	
			logger.debug("consultarSeguroAbonado:end");
			return retValue;	
		}
		
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean registrarCarta(CartaGeneralDTO cartaGeneral, long numOS) throws GeneralException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.info("registrarCarta, inicio");
		boolean retorno = false;
		try {
			retorno = getFrmkOOSSFacade().registrarCarta(cartaGeneral, numOS);
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.error("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e
					.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.error("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.info("registrarCarta, fin");
		return retorno;
	}
		
}
