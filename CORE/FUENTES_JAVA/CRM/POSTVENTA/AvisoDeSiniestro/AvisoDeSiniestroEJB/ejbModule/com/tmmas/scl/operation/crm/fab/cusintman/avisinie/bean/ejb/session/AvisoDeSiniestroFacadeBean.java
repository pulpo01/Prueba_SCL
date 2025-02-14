/**
 * 
 */
package com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.session;

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
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.helper.Global;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.common.dataTransfertObject.RegistraAvisoDeSiniestroActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.AvisoDeSiniestroSrvFactory;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.interfaces.AvisoDeSiniestroSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="AvisoDeSiniestroFacade"	
 *           description="An EJB named AvisoDeSiniestroFacade"
 *           display-name="AvisoDeSiniestroFacade"
 *           jndi-name="AvisoDeSiniestroFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class AvisoDeSiniestroFacadeBean implements
		javax.ejb.SessionBean {
	
	
	private static final long serialVersionUID = 1L;
		
		AvisoDeSiniestroSrvFactory factorySrv1 = new AvisoDeSiniestroSrvFactory();
		// Obtiene el application service
		AvisoDeSiniestroSrvIF service1 = factorySrv1.getApplicationService1();
		
		SessionContext context;
		
		private Global global = Global.getInstance();
		private final Logger logger = Logger.getLogger(AvisoDeSiniestroFacadeBean.class);

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
	public AvisoDeSiniestroFacadeBean() {
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
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws ProductException {

		SolicitudAvisoDeSiniestroDTO respuesta ;

		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("grabaAvisoDeSiniestro():start");
				respuesta = service1.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario, numeroDesvio);
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
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

	
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void registrarOOSSAvisoSiniestro(RegistraAvisoDeSiniestroActionDTO  regAviSinActDTO) throws GeneralException{
		logger.debug("registrarOOSSAvisoSiniestro():start");
		String textoMensajeRestricciones="";
		try{
		if ("NO".equals(regAviSinActDTO.getCmbCiclo())){
			logger.debug("aceptarPresupuesto:antes");
			textoMensajeRestricciones="Error en la Aceptación del Presupuesto";
			this.aceptarPresupuesto(regAviSinActDTO.getPresupuestoDTO());
			logger.debug("aceptarPresupuesto:despues");
		};
		
		textoMensajeRestricciones="Error al Registrar el Aviso de Siniestro";
		
		//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
		String strNumeroCelularDesviado = null;
		
		if(regAviSinActDTO.getNroCelularDesviado() != null){
			strNumeroCelularDesviado = String.valueOf(regAviSinActDTO.getNroCelularDesviado().longValue());
		}
		SolicitudAvisoDeSiniestroDTO aviso =this.grabaAvisoDeSiniestro(regAviSinActDTO.getUsuarioAbonadoDTO(), regAviSinActDTO.getTipoSiniestroDTO(),
																	   regAviSinActDTO.getTipoSuspencionDTO(), regAviSinActDTO.getCausaSiniestroDTO(), 
																	   regAviSinActDTO.getUsuarioSistemaDTO(),global.getValor("ACT_AVISOSINIESTRO"),regAviSinActDTO.getNumOS(),
																	   regAviSinActDTO.getComentario() ,strNumeroCelularDesviado);
		
//		SolicitudAvisoDeSiniestroDTO aviso =this.grabaAvisoDeSiniestro(regAviSinActDTO.getUsuarioAbonadoDTO(), regAviSinActDTO.getTipoSiniestroDTO(),
//				   regAviSinActDTO.getTipoSuspencionDTO(), regAviSinActDTO.getCausaSiniestroDTO(), 
//				   regAviSinActDTO.getUsuarioSistemaDTO(),global.getValor("ACT_AVISOSINIESTRO"),regAviSinActDTO.getNumOS(),
//				   regAviSinActDTO.getComentario());
		//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

		textoMensajeRestricciones="Error al Registrar Cargos";
		if (regAviSinActDTO.getRegCargosDTO().getObjetoSesion().isFacturaCiclo()){
			if (regAviSinActDTO.getRegCargosDTO()!=null&&regAviSinActDTO.getRegCargosDTO().getCargos()!=null&&regAviSinActDTO.getRegCargosDTO().getCargos().length>0){
				ResultadoRegCargosDTO resultado = this.parametrosRegistrarCargos(regAviSinActDTO.getRegCargosDTO());
			}
		}
		
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
		logger.debug("registrarOOSSAvisoSiniestro():end");
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
	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan) throws ProductException {
		CambioPlanPendienteDTO retorno = null;
		String log = global.getValor("negocio.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validarCambioPlanPendiente():start");
		try {
			logger.debug("validarCambioPlanPendiente:antes");
			retorno = service1.validarCambioPlanPendiente(cambioPlan);
			logger.debug("validarCambioPlanPendiente:despues");
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new ProductException(e);
		}
		logger.debug("validarCambioPlanPendiente():end");
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
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String verificaNumeroDesviado(String numeroDesviado) throws GeneralException {
		logger.debug("verificaNumeroDesviado: start");
		String validacionNumero;
		try{
			validacionNumero=service1.verificaNumeroDesviado(numeroDesviado);
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		logger.debug("verificaNumeroDesviado: end");
		return validacionNumero;
	}
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
}