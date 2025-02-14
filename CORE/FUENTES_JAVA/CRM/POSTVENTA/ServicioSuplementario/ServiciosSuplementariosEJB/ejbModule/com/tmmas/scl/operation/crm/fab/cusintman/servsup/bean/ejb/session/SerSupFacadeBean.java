/**
 * 
 */
package com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.session;

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
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacade;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeroRangoAjaxDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RegistroVentaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularRangoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.helper.FacadeMaker;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.helper.Global;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.NumeroAjaxDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.RegistraServSuplemtDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.ServiciosSuplementariosSrvFactory;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.interfaces.ServiciosSuplementariosSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.interfaces.ServiciosSuplementariosSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;

 

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SerSupFacade"	
 *           description="An EJB named SerSupFacade"
 *           display-name="SerSupFacade"
 *           jndi-name="SerSupFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class SerSupFacadeBean implements javax.ejb.SessionBean {
	
	ServiciosSuplementariosSrvFactoryIF factorySrv1 = new ServiciosSuplementariosSrvFactory();
	// Obtiene el application service
	ServiciosSuplementariosSrvIF service1 = factorySrv1.getApplicationService1();
	
	SessionContext context;
	
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(SerSupFacadeBean.class);
	private FacadeMaker facadeMaker = FacadeMaker.getInstance();

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
	public SerSupFacadeBean() {
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
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException, GeneralException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			resultado = service1.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
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
	 */	
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

	}	// desbloquearVendedor
	
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
	
	public void reservaSimcard (String accionProceso, 
								SerieDTO serie, 
								UsuarioSistemaDTO usuarioSistema, 
								UsuarioAbonadoDTO usuarioAbonado, 
								String parametros,
								CausaCamSerieDTO causa,
								TipoTerminalDTO terminal,
								ModalidadPagoDTO modalidadPago) throws ProductException, CustomerException{
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reservaSimcard():start");
			service1.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago);
			logger.debug("reservaSimcard():end");
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
	
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException{

		SSuplementarioDTO[] respuesta = null;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServiciosDisplonibles():start");
				respuesta = service1.obtenerServiciosDisplonibles(usuarioAbonado, sesion);
			logger.debug("obtenerServiciosDisplonibles():end");
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
		
	}	// obtenerServiciosDisplonibles
	
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
	
	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws ProductException{

		SSuplementarioDTO[] respuesta = null;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerServiciosContratados():start");
				respuesta = service1.obtenerServiciosContratados(usuarioAbonado, opcion);
			logger.debug("obtenerServiciosContratados():end");
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
		
	}	// obtenerServiciosContratados
	
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

	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws CustomerException{

		ReglasSSDTO[] respuesta = null;

	try{
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("getReglasdeValidacionSS():start");
			respuesta = service1.getReglasdeValidacionSS(usuarioAbonado, abonado);
		logger.debug("getReglasdeValidacionSS():end");
	} 
	catch(CustomerException e)	{
		logger.debug("ProductException[", e);
		throw e;
	} 	// catch
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new CustomerException(e);
	
	}	// catch
	
	return respuesta;
	
}	// obtenerServiciosContratados

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

	public void actDesactSS(ClienteOSSesionDTO sessionData, String listServAct, String listServDesac, String montoTotal, UsuarioSistemaDTO usuarioSistema, com.tmmas.scl.vendedor.dto.VendedorDTO vendedor, boolean oossComisionable, String comentario) throws CusIntManException {
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			logger.debug("Verificando informacion de vendedor..");
			if (oossComisionable)	{
				if (vendedor != null) {
					logger.debug("Registrando informacion de vendedor existente..");
					VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
					logger.debug("getVendedorFacade:despues");
					com.tmmas.scl.vendedor.dto.VendedorDTO resultado = null;
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
			} // if
			
			logger.debug("actDesactSS():start");
				service1.actDesactSS(sessionData, listServAct, listServDesac, montoTotal, usuarioSistema, comentario);
				
				
				/***
				 * @author rlozano
				 * @date 24-05-2010
				 */
				GaContactoAbonadoTO gaContactoAbonadoTO= new GaContactoAbonadoTO(); 
				gaContactoAbonadoTO.setNumAbonado(sessionData.getNumAbonado());
				gaContactoAbonadoTO.setNomUsuarora(sessionData.getUsuario());
				
				getServSupl911CorreoFaxFacade().setGaContTHDelGaContTO_DelDireccion(gaContactoAbonadoTO);
				
				/***
				 * @author rlozano	
				 * @description Se inserta los cobros adelantados.
				 * @date 27-05-2010
				 */
				
				ClienteCobroAdentadoDTO clienteCobroAdentadoDTO = new ClienteCobroAdentadoDTO();
				clienteCobroAdentadoDTO.setCodCliente(sessionData.getCliente().getCodCliente());
				clienteCobroAdentadoDTO.setNumAbonado(sessionData.getNumAbonado());
				clienteCobroAdentadoDTO.setCodActabo(sessionData.getCodActAboCargosUso());
				clienteCobroAdentadoDTO.setCodCicloFact(String.valueOf(sessionData.getCliente().getCodCiclo()));
				
				
				getFrmkOOSSFacade().insertarCobroAdelantado(clienteCobroAdentadoDTO);
				
			logger.debug("actDesactSS():end");
		} 
		catch(CusIntManException e)	{
			logger.debug("ProductException[", e);
			throw e;
		} 	// catch
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		
		}	// catch
	
	}	// actDesactSS

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
	
	public void registrarServiciosSuplementariosAction(RegistraServSuplemtDTO  regServSuplemDTO) throws GeneralException{
		logger.debug("registrarServiciosSuplemtariosAction():start");
		String textoMensajeRestricciones="";
		try{
		if ("NO".equals(regServSuplemDTO.getCmbCiclo())){
			logger.debug("aceptarPresupuesto:antes");
			textoMensajeRestricciones="Error en la Aceptación del Presupuesto";
			this.aceptarPresupuesto(regServSuplemDTO.getPresupuestoDTO());
			logger.debug("aceptarPresupuesto:despues");
		};
		      
		textoMensajeRestricciones="Error al Registrar Servicios Suplementarios";
		
		
		/*SolicitudAvisoDeSiniestroDTO aviso =this.grabaAvisoDeSiniestro(regServSuplemDTO.getUsuarioAbonadoDTO(), regServSuplemDTO.getTipoSiniestroDTO(),
																	   regServSuplemDTO.getTipoSuspencionDTO(), regServSuplemDTO.getCausaSiniestroDTO(), 
																	   regServSuplemDTO.getUsuarioSistemaDTO(),global.getValor("ACT_AVISOSINIESTRO"),regServSuplemDTO.getNumOS(),
																	   regServSuplemDTO.getComentario());*/

		if (regServSuplemDTO.getNumeroFax() != null && regServSuplemDTO.getNumeroFax() != "")
			service1.actualizaNroFax(regServSuplemDTO.getClienteOSSesionDTO().getAbonados()[0].getNumAbonado(), regServSuplemDTO.getNumeroFax());
			
		// Se graban los contactos de la asistencia vehicular
		
		this.actDesactSS(regServSuplemDTO.getClienteOSSesionDTO(),regServSuplemDTO.getContratTabla() ,regServSuplemDTO.getNoContratTabla(), 
						 regServSuplemDTO.getMontoTotal(), regServSuplemDTO.getUsuarioSistemaDTO(),regServSuplemDTO.getVendedorDTO(), regServSuplemDTO.getOossComisionable(), regServSuplemDTO.getComentario());
		textoMensajeRestricciones="Error al Registrar Cargos";
		if (regServSuplemDTO.getRegCargosDTO().getObjetoSesion().isFacturaCiclo()){
			if (regServSuplemDTO.getRegCargosDTO().getCargos()!=null&&regServSuplemDTO.getRegCargosDTO().getCargos().length>0){
				ResultadoRegCargosDTO resultado = this.parametrosRegistrarCargos(regServSuplemDTO.getRegCargosDTO());
			}
			else{
				textoMensajeRestricciones="No se registraron Cargos";
				logger.debug("No se registraron Cargos");
			}
		}
		
		if (regServSuplemDTO.getContactosTabla() != null)
			if (regServSuplemDTO.getContactosTabla().trim().length()>0)	{
				// Grabo los contactos
				GaContactoAbonadoToDTO[] contactos = string2ArrayContactos(regServSuplemDTO.getContactosTabla());
				DireccionNegocioWebDTO[] direcciones = string2ArrayDirecciones(regServSuplemDTO.getContactosTabla());				
				
				
				GaContactoAbonadoToDTO contacto = new GaContactoAbonadoToDTO();
				DireccionNegocioWebDTO direccion = new DireccionNegocioWebDTO();
				SecuenciaDTO secuencia = new SecuenciaDTO();
				for (int fila=0; fila < contactos.length; fila++)	{
					logger.debug("obtenerSecuencia:antes");
					secuencia.setNomSecuencia("GE_SEQ_DIRECCIONES");
					logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
					secuencia = getFrmkOOSSFacade().obtenerSecuencia(secuencia);
					logger.debug("obtenerSecuencia:despues");
					
					direccion = direcciones[fila];
					direccion.setCodigo(String.valueOf(secuencia.getNumSecuencia()));
					getServSupl911CorreoFaxFacade().setDireccion(direccion);
					
					contacto = contactos[fila];
					contacto.setCodDireccion(secuencia.getNumSecuencia());
					contacto.setNomUsuarora(regServSuplemDTO.getUsuarioSistemaDTO().getNom_usuario());
					contacto.setNumAbonado(regServSuplemDTO.getClienteOSSesionDTO().getNumAbonado());
					getServSupl911CorreoFaxFacade().insertGaContactoAbonadoTO(contacto);
				} // for

			
			} // if
		
		
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			logger.debug("context.setRollbackOnly().: Procede Rollback:.");
			throw new GeneralException(textoMensajeRestricciones, e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		
		} 
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			logger.debug("context.setRollbackOnly().: Procede Rollback:.");
			throw new GeneralException(textoMensajeRestricciones, e.getCause());
		
		} 
		logger.debug("registrarServiciosSuplemtariosAction():end");
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
//	 ---------------------------------------------------------------------------------
	
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
	
	
	private ServSupl911CorreoFaxFacade getServSupl911CorreoFaxFacade() throws CusIntManException       {

          
  		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getServSupl911CorreoFaxFacade():start");
		
		String jndi = global.getValor("jndi.ServSupl911CorreoFaxFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.ServSupl911CorreoFaxProvider");
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
			throw new CusIntManException(e);
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
			throw new CusIntManException(e);
		}

	     ServSupl911CorreoFaxFacadeHome facadeHome =
			(ServSupl911CorreoFaxFacadeHome) PortableRemoteObject.narrow(obj, ServSupl911CorreoFaxFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManConFacade...");
		ServSupl911CorreoFaxFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new CusIntManException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("getServSupl911CorreoFaxFacade():end");
		return facade;

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
	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {

		SSuplementarioDTO[] resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("blackberryActivado():start");
				resultado = service1.getServiciosBBContratados(usuarioAbonado);
			logger.debug("blackberryActivado():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}

		return resultado;
		
	} // getFlagBlackberryActivado

	// ----------------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws CusIntManException {
		GaServSuPlDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getEstadoCorreoServSupl():start");
				resultado = service1.getEstadoCorreoServSupl(gaServSuPlDTO);
			logger.debug("getEstadoCorreoServSupl():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}

		return resultado;
		
	} 
	
// ----------------------------------------------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws CusIntManException {
			GaServSupDefDTO[] resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getObtieneListCodServPorDef():start");
				resultado = service1.getObtieneListCodServPorDef(gaServSupDefDTO);
			logger.debug("getObtieneListCodServPorDef():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
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
	public GaAboMailTODTO[] getAbomailTOxNumAbonado (GaAboMailTODTO gaAboMailTODTO)throws  CusIntManException{
		GaAboMailTODTO[] resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getAbomailTOxNumAbonado():start");
				resultado = service1.getAbomailTOxNumAbonado(gaAboMailTODTO);
			logger.debug("getAbomailTOxNumAbonado():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
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
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws CusIntManException {
		ParametrosGeneralesDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getAbomailTOxNumAbonado():start");
			resultado = service1.getParametroGeneral(entrada);
			logger.debug("getAbomailTOxNumAbonado():end");
		} catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
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
	public OperadoraLocalDTO obtenerOperadoraLocal() throws CusIntManException {
		logger.debug("obtenerOperadoraLocal: start");
		OperadoraLocalDTO  retValue=null;
		try{
			retValue=service1.obtenerOperadoraLocal();
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
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
	public DatosCentralDTO obtenerDatosCentral(int codCentral) throws CusIntManException {
		
		logger.debug("obtenerDatosCentral: start");
		DatosCentralDTO  retValue=null;
		try{
			retValue=service1.obtenerDatosCentral(codCentral);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("obtenerDatosCentral: end");
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
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {
		
		logger.debug("reponerNumeracion: start");
		try{
			service1.reponerNumeracion(numeracionCelularVO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("reponerNumeracion: end");
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
	public SeleccionNumeroCelularDTO[]  obtenerNumeracionReservada(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {
		
		SeleccionNumeroCelularDTO[] arrayNumerosReservados = null;
		
		logger.debug("reponerNumeracion: start");
		try{
			arrayNumerosReservados = service1.obtenerNumeracionReservada(datosNumeracionDTO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("reponerNumeracion: end");
		
		return arrayNumerosReservados;
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
	public  String obtieneCategoria(DatosNumeracionDTO datosNumeracionVO) throws CusIntManException {
		
		String retorno = null;
		
		logger.debug("reponerNumeracion: start");
		try{
			retorno = service1.obtieneCategoria(datosNumeracionVO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("reponerNumeracion: end");
		
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
	public  String obtenerCeldaAbonado(long numAbonado) throws CusIntManException {
		
		String codCelda = null;
		
		logger.debug("reponerNumeracion: start");
		try{
			codCelda = service1.obtenerCeldaAbonado(numAbonado);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("reponerNumeracion: end");
		
		return codCelda;
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
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {
		
		DatosNumeracionDTO retorno = null;
		
		logger.debug("obtieneNumeracionAutomatica: start");
		try{
			retorno = service1.obtieneNumeracionAutomatica(datosNumeracionDTO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("obtieneNumeracionAutomatica: end");
		
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
	public SeleccionNumeroCelularRangoDTO[] obtenerNumeracionRango(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {
		
		SeleccionNumeroCelularRangoDTO[] retorno = null;
		
		logger.debug("obtenerNumeracionRango: start");
		try{
			retorno = service1.obtenerNumeracionRango(datosNumeracionDTO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("obtenerNumeracionRango: end");
		
		return retorno;
		
	} // obtenerNumeracionRangos
	
		
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SeleccionNumeroCelularDTO[]obtenerNumeracionReutilizable(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {
		
		SeleccionNumeroCelularDTO[] retorno = null;
		
		logger.debug("obtenerNumeracionReutilizable: start");
		try{
			retorno = service1.obtieneNumeracionReutilizable(datosNumeracionDTO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("obtenerNumeracionReutilizable: end");
		
		return retorno;
		
	} // obtenerNumeracionReutilizable
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {
		
		logger.debug("reservaNumeroCelular: start");
		try{
			service1.reservaNumeroCelular(numeracionCelularVO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("reservaNumeroCelular: end");
		
		
	} // reservaNumeroCelular
		


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {
		
		logger.debug("insertarNumeroCelularReservado: start");
		try{
			service1.insertarNumeroCelularReservado(numeracionCelularVO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("insertarNumeroCelularReservado: end");
		
		
	} // insertarNumeroCelularReservado
		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {
		
		logger.debug("desReservaNumeroCelular: start");
		try{
			service1.desReservaNumeroCelular(numeracionCelularVO);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}	
		logger.debug("desReservaNumeroCelular: end");
		
		
	} // desReservaNumeroCelular	
//	---------------------------------------------------------------------------------------------------------------------------------
//	HGG 24/02/10	
//  mod 05/05/10 : soporta multiples contactos para multiples SS	
	private GaContactoAbonadoToDTO[] string2ArrayContactos(String strArray)	{
		
		String separadorObjecto =  new String("###");
		
		//String[] coleccion = strArray.split("###");
		String[] coleccion = strArray.split(separadorObjecto);
		String campo = new String();
		GaContactoAbonadoToDTO[] contactos911 = new GaContactoAbonadoToDTO[coleccion.length];
		for (int fila=0; fila < coleccion.length; fila++){
			
			GaContactoAbonadoToDTO contacto = new GaContactoAbonadoToDTO();
			String[] campos = coleccion[fila].split("[|]");

			campo = campos[0];
			if (!(campo.trim().equals(""))) contacto.setApellido1Contacto(campo);
			
			campo = campos[1];
			if (!(campo.trim().equals(""))) contacto.setNombreContacto(campo);
			
			campo = campos[3];
			if (!(campo.trim().equals(""))) contacto.setTelefono(Long.parseLong(campo));
			
			campo = campos[4];
			if (!(campo.trim().equals(""))) contacto.setPlacaVehicular(campo);
			
			campo = campos[5];
			if (!(campo.trim().equals(""))) contacto.setColorVehiculo(campo);
			
			campo = campos[6];
			if (!(campo.trim().equals(""))) contacto.setAnioVehiculo(Long.parseLong(campo));

			campo = campos[8];
			if (!(campo.trim().equals(""))) contacto.setCodServicio(campo);
			
			campo = campos[9];
			if (!(campo.trim().equals(""))) contacto.setNumContacto(Long.parseLong(campo));
			
			campo = campos[10];
			if (!(campo.trim().equals(""))) contacto.setApellido2Contacto(campo);
			
			campo = campos[11];
			if (!(campo.trim().equals(""))) contacto.setCodParentesco(campo);
			
			contactos911[fila] = contacto;
			contacto = null;
		} // for
		
    	return contactos911;
    	
	} // string2Array
	
//	---------------------------------------------------------------------------------------------------------------------------------
//	HGG 11/05/10	
//  	
	private DireccionNegocioWebDTO[] string2ArrayDirecciones(String strArray)	{
		
		String separadorObjecto =  new String("###");
		
		//String[] coleccion = strArray.split("###");
		String[] coleccion = strArray.split(separadorObjecto);
		
		DireccionNegocioWebDTO[] direcciones = new DireccionNegocioWebDTO[coleccion.length];
		for (int fila=0; fila < coleccion.length; fila++){
			
			DireccionNegocioWebDTO direccion = new DireccionNegocioWebDTO();
			String[] campos = coleccion[fila].split("[|]");

			direccion.setCodigo("0");
			if (!(campos[13].trim().equals(""))) direccion.setCodMunicipio(campos[13]); // cod provincia
			if (!(campos[14].trim().equals(""))) direccion.setCodDepartamento(campos[14]); // cod region
			if (!(campos[15].trim().equals(""))) direccion.setCodZonaDistrito(campos[15]); // cod ciudad
			if (!(campos[17].trim().equals(""))) direccion.setNombreCalle(campos[17]);
			if (!(campos[18].trim().equals(""))) direccion.setNumeroCalle(campos[18]);
			if (!(campos[25].trim().equals(""))) direccion.setCodigoPostalDireccion(campos[25]);
			
			direcciones[fila] = direccion;
			direccion = null;
		} // for
		
    	return direcciones;
    	
	} // string2ArrayDirecciones	
}
