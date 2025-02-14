package com.tmmas.scl.operation.crm.fab.cusintman.suspvol.bean.ejb.session;

import java.rmi.RemoteException;
import java.sql.Date;
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

import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.bean.ejb.helper.Global;
import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.common.dataTransfertObject.RegistraSuspVoluntariaDTO;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces.SuspensionVoluntariaSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces.SuspensionVoluntariaSrvIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.SuspensionVoluntariaSrvFactory;

import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="SuspVolFacade" description="An EJB named SuspVolFacade"
 *           display-name="SuspVolFacade" jndi-name="SuspVolFacade"
 *           type="Stateless" transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */
public abstract class SuspVolFacadeBean implements javax.ejb.SessionBean {

	SuspensionVoluntariaSrvFactoryIF factorySrv1 = new SuspensionVoluntariaSrvFactory();

	// Obtiene el application service
	SuspensionVoluntariaSrvIF service1 = factorySrv1.getApplicationService1();

	SessionContext context;

	private Global global = Global.getInstance();

	private final Logger logger = Logger.getLogger(SuspVolFacadeBean.class);

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
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
	public String foo(String param) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
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
	public SuspVolFacadeBean() {
		// TODO Auto-generated constructor stub
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente)
			throws CusIntManException, GeneralException {
		ClienteDTO resultado = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerDatosCliente():start");
			resultado = service1.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		}catch (CusIntManException e) {
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
			throws CusIntManException {
		AbonadoDTO resultado = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerDatosAbonado():start");
			resultado = service1.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (CusIntManException e) {
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(
			UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {
		UsuarioAbonadoDTO resultado = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerDatosAbonado():start");
			resultado = service1.obtenerDatosUsuarioAbonado(usuarioAbonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (CusIntManException e) {
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;

	} // obtenerDatosUsuarioAbonado

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones)
			throws ProductException {

		MensajeRetornoDTO respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("ejecutaRestrccion():start");
			respuesta = service1.ejecutaRestrccion(restricciones);
			logger.debug("ejecutaRestrccion():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // ejecutaRestrccion

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public UsuarioSistemaDTO obtenerInformacionUsuario(
			UsuarioSistemaDTO usuarioSistema) throws AplicationException {

		UsuarioSistemaDTO respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerInformacionUsuario():start");
			respuesta = service1.obtenerInformacionUsuario(usuarioSistema);
			logger.debug("obtenerInformacionUsuario():end");
		} catch (AplicationException e) {
			logger.debug("AplicationException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AplicationException(e);
		}

		return respuesta;

	} // obtenerInformacionUsuario

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup)
			throws GeneralException {
		RetornoDTO retorno = null;
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("aceptarPresupuesto():start");
		try {
			retorno = getFrmkOOSSFacade().aceptarPresupuesto(presup);
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e
					.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("aceptarPresupuesto():end");
		return retorno;
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * @author: rlozano
	 * @description: metodos de FrmkOOSS y FrmkCargos
	 */

	// Fachada del Framework de OOSS
	private FrmkOOSSFacade getFrmkOOSSFacade() throws GeneralException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("getFrmkOOSSFacade():start");

		String jndi = global.getValor("jndi.FrmkOOSSFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.FrmkOOSSProvider");
		logger.debug("Url provider[" + url + "]");

		String initialContextFactory = global
				.getValor("initial.context.factory");
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

		FrmkOOSSFacadeHome facadeHome = (FrmkOOSSFacadeHome) PortableRemoteObject
				.narrow(obj, FrmkOOSSFacadeHome.class);

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

	// -------------------------------------------------------------------------------------------------------------------------------------

	private FrmkCargosFacade getFrmkCargosFacade() throws GeneralException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("getFrmkCargosFacade():start");

		String jndi = global.getValor("jndi.FrmkCargosFacade");
		logger.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.FrmkCargosProvider");
		logger.debug("Url provider[" + url + "]");

		String initialContextFactory = global
				.getValor("initial.context.factory");
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

		FrmkCargosFacadeHome facadeHome = (FrmkCargosFacadeHome) PortableRemoteObject
				.narrow(obj, FrmkCargosFacadeHome.class);

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

		logger.debug("getFrmkCargosFacade():end");
		return facade;
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos)
			throws GeneralException {
		ResultadoRegCargosDTO retorno = null;
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("parametrosRegistrarCargos():start");
		try {
			retorno = getFrmkCargosFacade().parametrosRegistrarCargos(cargos);
		} catch (FrmkCargosException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(
					"Se ha producido un error en el módulo de cargos.", e
							.getCause(), e.getCodigo(), e.getCodigoEvento(),
					"Se ha producido un error en el módulo de cargos.");
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			throw new GeneralException(e.getMessage(), e.getCause(), e
					.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("parametrosRegistrarCargos():end");
		return retorno;
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(
			UsuarioAbonadoDTO usuarioAbonado) throws ProductException {

		SuspensionAbonadoDTO[] respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerSuspensionesAbonado():start");
			respuesta = service1.obtenerSuspensionesAbonado(usuarioAbonado);
			logger.debug("obtenerSuspensionesAbonado():end");
		}catch (ProductException e) {
			throw (e);
		}
		
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // obtenerSuspensionesAbonado

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public CausasSuspensionDTO[] obtenerCausasSuspension()
			throws ProductException {

		CausasSuspensionDTO[] respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerCausasSuspension():start");
			respuesta = service1.obtenerCausasSuspension();
			logger.debug("obtenerCausasSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // obtenerCausasSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(
			long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin)
			throws ProductException {

		SuspensionAbonadoDTO[] respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerSuspensionesHistoricasAbonado():start");
			respuesta = service1.obtenerSuspensionesHistoricasAbonado(
					numAbonado, fecIni, fecFin);
			logger.debug("obtenerSuspensionesHistoricasAbonado():end");
		} 
		catch (ProductException e) {
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // obtenerSuspensionesHistoricasAbonado

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public FechasSuspensionDTO[] recuperarFechasSuspension(
			ClienteOSSesionDTO sessionData) throws ProductException {

		FechasSuspensionDTO[] respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("recuperarFechasSuspension():start");
			respuesta = service1.recuperarFechasSuspension(sessionData);
			logger.debug("recuperarFechasSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // recuperarFechasSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado,
			ClienteOSSesionDTO sessionData) throws ProductException {

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("programarSuspension():start");
			service1.programarSuspension(suspensionAbonado, sessionData);
			logger.debug("programarSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

	} // programarSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado)
			throws ProductException {

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("modificarSuspension():start");
			service1.modificarSuspension(suspensionAbonado);
			logger.debug("modificarSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

	} // modificarSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado)
			throws ProductException {

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("anularSuspension():start");
			service1.anularSuspension(suspensionAbonado);
			logger.debug("anularSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

	} // anularSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension()
			throws ProductException {

		DatosGeneralesSuspensionDTO respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerDatosGeneralesSuspension():start");
			respuesta = service1.obtenerDatosGeneralesSuspension();
			logger.debug("obtenerDatosGeneralesSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // obtenerDatosGeneralesSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(
			UsuarioAbonadoDTO usuarioAbonado) throws ProductException {

		PeriodoSuspencionAbonadoDTO[] respuesta = null;

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("obtenerPeriodosSuspensioAbonado():start");
			respuesta = service1
					.obtenerPeriodosSuspensioAbonado(usuarioAbonado);
			logger.debug("obtenerPeriodosSuspensioAbonado():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;

	} // obtenerPeriodosSuspensioAbonado

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void agregaPeriodoSuspension(
			PeriodoSuspencionAbonadoDTO periodoSuspensionAbonado)
			throws ProductException {

		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("agregaPeriodoSuspension():start");
			service1.agregaPeriodoSuspension(periodoSuspensionAbonado);
			logger.debug("agregaPeriodoSuspension():end");
		}catch (ProductException e) {
			throw (e);
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

	} // agregaPeriodoSuspension

	// -------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void registrarSuspensionVoluntaria(
			RegistraSuspVoluntariaDTO registraDTO) throws GeneralException {

		String textoMensajeRestricciones = "";
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			logger.debug("registrarSuspensionVoluntaria():start");

			// -- OOSS --
			textoMensajeRestricciones = "Error al Registrar la Suspensión Voluntaria en el proceso : "
					+ registraDTO.getOpcionProceso().toUpperCase();
			logger.debug("registraDTO.getOpcionProceso()["+registraDTO.getOpcionProceso()+"]");
			if (registraDTO.getOpcionProceso().equals("anular"))
				anularSuspension(registraDTO.getSuspension());
			else if (registraDTO.getOpcionProceso().equals("programar"))
				programarSuspension(registraDTO.getSuspension(), registraDTO.getSessionData());
			else if (registraDTO.getOpcionProceso().equals("modificar"))
				modificarSuspension(registraDTO.getSuspension());

			// -- CARGOS --
			// Aqui registramos los cargos
			logger.debug("Registro de cargos ini");
			if ((!( registraDTO.getSessionData().getCargosObtenidos() == null )) && 
				  ( registraDTO.getSessionData().getCargosObtenidos().isACiclo())
			    ) {
				logger.debug("registraDTO.getSessionData().getCargosObtenidos().isACiclo() ["+
				registraDTO.getSessionData().getCargosObtenidos().isACiclo()+"]");
				
				if (registraDTO.getRegCargosDTO() != null && 
					registraDTO.getRegCargosDTO().getCargos().length > 0) {
					logger.debug("registraDTO.getRegCargosDTO().getCargos().length["+
							registraDTO.getRegCargosDTO().getCargos().length+"]");
					logger.debug("parametrosRegistrarCargos ini");
					ResultadoRegCargosDTO resultado = this.parametrosRegistrarCargos(registraDTO.getRegCargosDTO());
					logger.debug("parametrosRegistrarCargos fin");
				} else {
					textoMensajeRestricciones = "No se registraron Cargos";
					if (registraDTO.getRegCargosDTO() == null) 
					{
						logger.debug("registraDTO.getRegCargosDTO() = null");
					}else
					{
						logger.debug("registraDTO.getRegCargosDTO().getCargos().length["+
						registraDTO.getRegCargosDTO().getCargos().length+"]");
					}
					logger.debug("No se registraron Cargos");
				}

				// Esta parte acepta el presupuesto
				/*textoMensajeRestricciones = "Error al Registrar Cargos";
				logger.debug("aceptarPresupuesto:antes");
				textoMensajeRestricciones = "Error en la Aceptación del Presupuesto";
				this.aceptarPresupuesto(registraDTO.getPresupuestoDTO());
				logger.debug("aceptarPresupuesto:despues");*/
			}else// if
			{
				if (registraDTO.getSessionData().getCargosObtenidos() == null )
				{
					logger.debug("registraDTO.getSessionData().getCargosObtenidos() = null");
				}else
				{
					logger.debug("registraDTO.getSessionData().getCargosObtenidos().isACiclo() ["+
					registraDTO.getSessionData().getCargosObtenidos().isACiclo()+"]");
				}
			}
			logger.debug("Registro de cargos fin");
			logger.debug("registrarSuspensionVoluntaria():end");

		} // try
		catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			logger.debug("context.setRollbackOnly().: Procede Rollback:.");
			throw new GeneralException(textoMensajeRestricciones, e.getCause(),
					e.getCodigo(), e.getCodigoEvento(), e
							.getDescripcionEvento());

		} // catch
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			context.setRollbackOnly();
			logger.debug("context.setRollbackOnly().: Procede Rollback:.");
			throw new GeneralException(textoMensajeRestricciones, e.getCause());

		} // catch

	} // registrarSuspensionVoluntaria

	// -------------------------------------------------------------------------------------------------------------------------------------
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
	// -------------------------------------------------------------------------------------------------------------------------------------	
} // SuspVolFacadeBean
