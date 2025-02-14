/**
 * 
 */
package com.tmmas.gte.integraciongte.ws.session;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.helper.CrearGeneralSoapException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongte.ejb.session.IntegracionGTEFacade;
import com.tmmas.gte.integraciongte.ejb.session.IntegracionGTEFacadeHome;
import com.tmmas.gte.integraciongtecommon.dto.ActDesServSupleDto;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ComponentesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsDistribuidorInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultarTerminalResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultarTipoAbonadoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosClienteOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosClientePospHibrPrepDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionRespOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaMesAnteriorResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionListDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionListDTO;
import com.tmmas.gte.integraciongtecommon.dto.IdTipoPrestacionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosLdiInDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosLdiResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO;
import com.tmmas.gte.integraciongtecommon.dto.TerminalServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespTipoClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO;
import com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.SeguroResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.TecnologiaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO;
import com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;



/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IntegracionGTEWS"	
 *           description="An EJB named IntegracionGTEWS"
 *           display-name="IntegracionGTEWS"
 *           jndi-name="IntegracionGTEWS"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class IntegracionGTEWSBean implements javax.ejb.SessionBean {
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(IntegracionGTEWSBean.class);
	private CompositeConfiguration config;
	
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
	public IntegracionGTEWSBean() {
		// TODO Auto-generated constructor stub
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongte/ws/properties/IntegracionGTEWS.properties");

	}
	
	private IntegracionGTEFacade getFacade() throws Exception {
		String initialContextFactory = config.getString("initial.context.factory");
		String jndi = "IntegracionGTEFacade";
		String url = config.getString("url.IntegracionGTEWSSTLProvider");
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
		env.put(Context.PROVIDER_URL, url);


		Context context = null;
		try {
			System.out.println("Inicializando contexto:antes");
			context = new InitialContext(env);
			System.out.println("Inicializando contexto:despues");
		} catch (NamingException e) {
			e.printStackTrace();
			System.out.println("NamingException[" + e + "]");
		}

		Object obj = null;
		try {
			System.out.println("Buscando jndi:antes");
			obj = context.lookup(jndi);
			System.out.println("Buscando jndi:despues");
		} catch (NamingException e) {
			e.printStackTrace();
			System.out.println("NamingException[" + e + "]");
		}

		IntegracionGTEFacadeHome facadeHome = (IntegracionGTEFacadeHome) PortableRemoteObject
				.narrow(obj, IntegracionGTEFacadeHome.class);

		System.out.println("Recuperada interfaz home de IntegracionGteHome...");
		IntegracionGTEFacade facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			e.printStackTrace();
			System.out.println("CreateException[" + e + "]");
			throw new Exception(e);

		} catch (RemoteException e) {
			e.printStackTrace();
			System.out.println("RemoteException[" + e + "]");
			throw new Exception(e);
		}
		return facade;
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
	public PlanTarifarioResponseOutDTO consultarPlanTarifario(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarPlanTarifario():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}
		
		PlanTarifarioResponseOutDTO respuesta = null;
		try {
			logger.info("consultarPlanTarifario():Start");
			respuesta = facade.consultarPlanTarifario(parametro);
			logger.info("consultarPlanTarifario():End");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarPlanTarifario fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
			
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarPlanTarifario fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarPlanTarifario fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		
		return respuesta;
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
	public AltaPrepagoOutDTO consultarFechaAlta(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarFechaAlta():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade(); 
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}

		AltaPrepagoOutDTO respuesta = null;
		try {
			
			System.out.println("consultarFechaAlta():Start");
			respuesta = facade.consultarFechaAlta(parametro);
			System.out.println("consultarFechaAlta():End");
		
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFechaAlta fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFechaAlta fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFechaAlta fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		return respuesta;
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
	public ServicioSupleRespondeDTO consultarServiciosSuplementarios(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarServiciosSuplementarios():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}

		ServicioSupleRespondeDTO respuesta = null;
		try {
			
			System.out.println("consultarServiciosSuplementarios():Start");
			respuesta = facade.consultarServiciosSuplementarios(parametro);
			System.out.println("consultarServiciosSuplementarios():End");
		
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarServiciosSuplementarios fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarServiciosSuplementarios fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarServiciosSuplementarios fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		return respuesta;
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
	public SeguroResponseDTO consultarSeguroPorTelefono(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarSeguroPorTelefono():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}

		SeguroResponseDTO respuesta = null;
		try {
			
			System.out.println("consultarSeguroPorTelefono():Start");
			respuesta = facade.consultarSeguroPorTelefono(parametro);
			System.out.println("consultarSeguroPorTelefono():End");
		
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarSeguroPorTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarSeguroPorTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarSeguroPorTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		return respuesta;
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
	public FacturaNoCicloResponseDTO consultarFacturasNoCicloCliente(DistribuidorInDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarFacturasNoCicloCliente():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}

		FacturaNoCicloResponseDTO respuesta = null;
		try {
			
			System.out.println("consultarFacturasNoCicloCliente():Start");
			respuesta = facade.consultarFacturasNoCicloCliente(parametro);
			System.out.println("consultarFacturasNoCicloCliente():End");
		
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFacturasNoCicloCliente fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFacturasNoCicloCliente fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarFacturasNoCicloCliente fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		return respuesta;
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
	public PagoOutDTO consultaPagosRealizados(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultaPagosRealizados():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}
		
		PagoOutDTO respuesta = null;
		try {
			logger.info("consultaPagosRealizados():Start");
			respuesta = facade.consultaPagosRealizados(parametro);
			logger.info("consultaPagosRealizados():End");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultaPagosRealizados fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultaPagosRealizados fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultaPagosRealizados fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		
		return respuesta;
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
	public RespBooleanDTO validarNumeroHibrido(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("validarNumeroHibrido():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}
		RespBooleanDTO respuesta = null;
		try {
			logger.info("validarNumeroHibrido():antes");
			respuesta = facade.validarNumeroHibrido(parametro);
			logger.info("muestra la respuesta del ejb : " + respuesta);
			logger.info("validarNumeroHibrido():despues");
		}  catch (IntegracionGTEException e) {
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumeroHibrido fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumeroHibrido fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumeroHibrido fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("validarNumeroHibrido():end");
		return respuesta;
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
	public ConsumoResponseOutDTO consultarConsumoMensajesCortos(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarConsumoMensajesCortos():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():Start");
			facade =  getFacade();
			logger.info("getFacade():End");
		} catch (Exception e) {
			logger.error("Exception", e);
			e.printStackTrace();
		}
		
		ConsumoResponseOutDTO respuesta = null;
		try {
			logger.info("consultarConsumoMensajesCortos():Start");
			respuesta = facade.consultarConsumoMensajesCortos(parametro);
			logger.info("consultarConsumoMensajesCortos():End");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarConsumoMensajesCortos fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarConsumoMensajesCortos fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarConsumoMensajesCortos fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}		
		
		return respuesta;
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
	
	public DireccionRespOutDTO consultarDireccionTelefono(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarDireccionTelefono():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}
		DireccionRespOutDTO respuesta = null;
		try {
			logger.info("consultarDireccionTelefono():antes");
			respuesta = facade.consultarDireccionTelefono(parametro);
			logger.info("muestra la respuesta del ejb : " + respuesta);
			logger.info("consultarDireccionTelefono():despues");
		}  catch (IntegracionGTEException e) {
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarDireccionTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarDireccionTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarDireccionTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("consultarDireccionTelefono():end");
		return respuesta;
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
	public ConsLinkFacturaResponseDTO consultarLinkFactura(ConsLinkFacturaDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("consultarLinkFactura():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}
		ConsLinkFacturaResponseDTO respuesta = null;
		try {
			logger.info("consultarLinkFactura():antes");
			respuesta = facade.consultarLinkFactura(parametro);
			logger.info("muestra la respuesta del ejb : " + respuesta);
			logger.info("consultarLinkFactura():despues");
		}  catch (IntegracionGTEException e) {
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarLinkFactura fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarLinkFactura fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "consultarLinkFactura fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("consultarLinkFactura():end");
		return respuesta;
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
	
	public RespBooleanDTO validarNumPospago(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("validarNumPospago():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}
		RespBooleanDTO respuesta = null;
		try {
			logger.info("validarNumPospago():antes");
			respuesta = facade.validarNumPospago(parametro);
			logger.info("muestra la respuesta del ejb : " + respuesta);
			logger.info("validarNumPospago():despues");
		}  catch (IntegracionGTEException e) {
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumPospago fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumPospago fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarNumPospago fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("validarNumPospago():end");
		return respuesta;
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
	public RespBooleanDTO validarClienteTelefono(EsClieTelefDTO parametro)
			throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("validarClienteTelefono():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}

		RespBooleanDTO respuesta = null;
		try {
			logger.info("validarClienteTelefono():antes");
			respuesta = facade.validarClienteTelefono(parametro);
			logger.info("validarClienteTelefono():despues");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarClienteTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarClienteTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarClienteTelefono fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("validarClienteTelefono():end");
		return respuesta;
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
	public RespBooleanDTO validarTelIgualCli(EsTelefIgualClieDTO parametro)
			throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("validarTelIgualCli():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}

		RespBooleanDTO respuesta = null;
		try {
			logger.info("validarTelIgualCli():antes");
			respuesta = facade.validarTelIgualCli(parametro);
			logger.info("validarTelIgualCli():despues");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarTelIgualCli fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarTelIgualCli fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "validarTelIgualCli fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("validarTelIgualCli():end");
		return respuesta;
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
	 public RespuestaDTO activarDesactivarSS(ActDesServSupleDto parametro)
		throws IntegracionGTEException {
		UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
		String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
		logger.info("ActDesServicioSuplem():start");
		IntegracionGTEFacade facade = null;
		try {
			logger.info("getFacade():antes");
			facade = getFacade();
			logger.info("getFacade():despues");
		} catch (Exception e) {
			logger.error("Exception", e);
			throw new IntegracionGTEException(e);
		}
		
		RespuestaDTO respuesta = null;
		try {
			logger.info("ActDesServicioSuplem():antes");
			respuesta = facade.activarDesactivarSS(parametro);
			logger.info("ActDesServicioSuplem():despues");
		} catch (IntegracionGTEException e) {
			// TODO Auto-generated catch block
			
			logger.error("IntegracionGTEException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "ActDesServicioSuplem fallo", urlMsg,
					e); 
			throw errorSoap.obtenerGeneralSoapException();
		} catch (RemoteException e) {
			
			logger.error("RemoteException", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "ActDesServicioSuplem fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		} catch (Exception e) {
			
			logger.error("Exception", e);
			CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
					urlMsg, "Server fallo", "ActDesServicioSuplem fallo", urlMsg,
					e);
			throw errorSoap.obtenerGeneralSoapException();
		}
		logger.info("ActDesServicioSuplem():end");
		return respuesta;
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
		public ConsultaPukResponseDTO consultarPuk(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultaPuk():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ConsultaPukResponseDTO respuesta = null;
			try {
				logger.info("consultaPuk():Start");
				respuesta = facade.consultarPuk(parametro);
				logger.info("consultaPuk():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaPuk fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaPuk fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaPuk fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public RespBooleanDTO consultaNumeracion(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultaNumeracion():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			RespBooleanDTO respuesta = null;
			try {
				logger.info("consultaNumeracion():Start");
				respuesta = facade.consultaNumeracion(parametro);
				logger.info("consultaNumeracion():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaNumeracion fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaNumeracion fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultaNumeracion fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public ConsAvisoSiniestroResponseDTO consultarAvisoSiniestro(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarAvisoSiniestro():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ConsAvisoSiniestroResponseDTO respuesta = null;
			try {
				logger.info("consultarAvisoSiniestro():Start");
				respuesta = facade.consultarAvisoSiniestro(parametro);
				logger.info("consultarAvisoSiniestro():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public ConsAvisoSiniestroResponseDTO consultarFechaAvisoSiniestro(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarFechaAvisoSiniestro():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ConsAvisoSiniestroResponseDTO respuesta = null;
			try {
				logger.info("consultarFechaAvisoSiniestro():Start");
				respuesta = facade.consultarFechaAvisoSiniestro(parametro);
				logger.info("consultarFechaAvisoSiniestro():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFechaAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFechaAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFechaAvisoSiniestro fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public LstCliResponseDTO listarClientes(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("listarClientesNit():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			LstCliResponseDTO respuesta = null;
			try {
				logger.info("listarClientes():Start");
				respuesta = facade.listarClientes(parametro);
				logger.info("listarClientes():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public LstCliResponseDTO listarClientes(DatosLstCliCueDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("listarClientesCue():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			LstCliResponseDTO respuesta = null;
			try {
				logger.info("listarClientesCue():Start");
				respuesta = facade.listarClientes(parametro);
				logger.info("listarClientesCue():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientesCue fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientesCue fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarClientesCue fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public LstConceptoFacturaDTO consultarConceptosFactura(CodClienteDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("listarClientesCue():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			LstConceptoFacturaDTO respuesta = null;
			try {
				logger.info("consultarConceptosFactura():Start");
				respuesta = facade.consultarConceptosFactura(parametro);
				logger.info("consultarConceptosFactura():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarConceptosFactura fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarConceptosFactura fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarConceptosFactura fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public CarteraResponseDTO consultarSaldoPospago(
				NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarSaldoPospago():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():antes");
				facade = getFacade();
				logger.info("getFacade():despues");
			} catch (Exception e) {
				logger.error("Exception", e);
				throw new IntegracionGTEException(e);
			}
			CarteraResponseDTO respuesta = null;
			try {
				logger.info("consultarSaldoPospago():antes");
				respuesta = facade.consultarSaldoPospago(parametro);
				logger.info("muestra la respuesta del ejb : " + respuesta);
				logger.info("consultarSaldoPospago():despues");
			}  catch (IntegracionGTEException e) {
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoPospago fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoPospago fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoPospago fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}
			logger.info("consultarSaldoPospago():end");
			return respuesta;
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
		public FacturaResponseDTO consultasFacturasDeunCliente(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultasFacturasDeunCliente():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			FacturaResponseDTO respuesta = null;
			try {
				logger.info("consultasFacturasDeunCliente():Start");
				respuesta = facade.consultasFacturasDeunCliente(parametro);
				logger.info("consultasFacturasDeunCliente():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturasDeunCliente fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturasDeunCliente fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturasDeunCliente fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public TecnologiaDTO consultarTecnologia(NumeroTelefonoDTO parametro)
				throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("validarTelIgualCli():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():antes");
				facade = getFacade();
				logger.info("getFacade():despues");
			} catch (Exception e) {
				logger.error("Exception", e);
				throw new IntegracionGTEException(e);
			}

			TecnologiaDTO respuesta = null;
			try {
				logger.info("consultarTecnologia():antes");
				respuesta = facade.consultarTecnologia(parametro);
				logger.info("consultarTecnologia():despues");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTecnologia fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTecnologia fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTecnologia fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}
			logger.info("validarTelIgualCli():end");
			return respuesta;
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
		public DatosClientePospHibrPrepDTO consultarDatosGenClienteTel(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("ConsultarDatosGenClienteTel():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			DatosClientePospHibrPrepDTO respuesta = null;
			try {
				logger.info("ConsultarDatosGenClienteTel():Start");
				respuesta = facade.consultarDatosGenClienteTel(parametro);
				logger.info("ConsultarDatosGenClienteTel():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteTel fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteTel fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteTel fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public DatosClienteOutDTO consultarDatosGenClienteCod(CodClienteDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("ConsultarDatosGenClienteCod():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			DatosClienteOutDTO respuesta = null;
			try {
				logger.info("ConsultarDatosGenClienteCod():Start");
				respuesta = facade.consultarDatosGenClienteCod(parametro);
				logger.info("ConsultarDatosGenClienteCod():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteCod fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteCod fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "ConsultarDatosGenClienteCod fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public FacturaResponseDTO obtenerUltimaFacturaPagada(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("obtenerUltimaFacturaPagada():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			FacturaResponseDTO respuesta = null;
			try {
				logger.info("obtenerUltimaFacturaPagada():Start");
				respuesta = facade.obtenerUltimaFacturaPagada(parametro);
				logger.info("obtenerUltimaFacturaPagada():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerUltimaFacturaPagada fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerUltimaFacturaPagada fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerUltimaFacturaPagada fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public FacturaResponseDTO consultarFacturasImpagasPorCliente(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarFacturasImpagasPorCliente():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			FacturaResponseDTO respuesta = null;
			try {
				logger.info("consultarFacturasImpagasPorCliente():Start");
				respuesta = facade.consultarFacturasImpagasPorCliente(parametro);
				logger.info("consultarFacturasImpagasPorCliente():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFacturasImpagasPorCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFacturasImpagasPorCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarFacturasImpagasPorCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public RespTipoClienteDTO consultarTipoCliente(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarTipoCliente():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			RespTipoClienteDTO respuesta = null;
			try {
				logger.info("consultarTipoCliente():Start");
				respuesta = facade.consultarTipoCliente(parametro);
				logger.info("consultarTipoCliente():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarTipoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarTipoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarTipoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public PlanTarifarioResponseDTO consultarPlanesDisponibles(GrpCodPrestacionListDTO inParam0) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarPlanesDisponibles():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			PlanTarifarioResponseDTO respuesta = null;
			try {
				logger.info("consultarPlanesDisponibles():Start");
				respuesta = facade.consultarPlanesDisponibles(inParam0);
				logger.info("consultarPlanesDisponibles():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public PlanTarifarioResponseDTO consultarPlanesDisponibles(GrupoPrestacionListDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarPlanesDisponibles():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			PlanTarifarioResponseDTO respuesta = null;
			try {
				logger.info("consultarPlanesDisponibles():Start");
				respuesta = facade.consultarPlanesDisponibles(parametro);
				logger.info("consultarPlanesDisponibles():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public PlanTarifarioResponseDTO consultarPlanesDisponibles(AuditoriaDTO inParam0) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarPlanesDisponibles():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			PlanTarifarioResponseDTO respuesta = null;
			try {
				logger.info("consultarPlanesDisponibles():Start");
				respuesta = facade.consultarPlanesDisponibles(inParam0);
				logger.info("consultarPlanesDisponibles():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPlanesDisponibles fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public ConsPrestacionesResponseDTO consultarCodigosPrestacion(IdTipoPrestacionInDTO inParam0) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarPrestaciones():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			ConsPrestacionesResponseDTO respuesta = null;
			try {
				logger.info("consultarPrestaciones():Start");
				respuesta = facade.consultarCodigosPrestacion(inParam0);
				logger.info("consultarPrestaciones():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPrestaciones fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPrestaciones fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarPrestaciones fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public BloqueoResponseDTO consultaBloqueoTelefono(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultaBloqueoTelefono():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			BloqueoResponseDTO respuesta = null;
			try {
				logger.info("consultaBloqueoTelefono():Start");
				respuesta = facade.consultaBloqueoTelefono(parametro);
				logger.info("consultaBloqueoTelefono():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultaBloqueoTelefono fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultaBloqueoTelefono fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultaBloqueoTelefono fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public MinutosConsumidosDTO consultarMinutosConsumidos(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarMinutosConsumidos():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			MinutosConsumidosDTO respuesta = null;
			try {
				logger.info("consultarMinutosConsumidos():Start");
				respuesta = facade.consultarMinutosConsumidos(parametro);
				logger.info("consultarMinutosConsumidos():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarMinutosConsumidos fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarMinutosConsumidos fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarMinutosConsumidos fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public ComponentesResponseDTO consultarEstadoComponentes(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarEstadoComponentes():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ComponentesResponseDTO respuesta = null;
			try {
				logger.info("consultarEstadoComponentes():Start");
				respuesta = facade.consultarEstadoComponentes(parametro);
				logger.info("consultarEstadoComponentes():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarEstadoComponentes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarEstadoComponentes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarEstadoComponentes fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public SegmentoClienteResponseDTO obtenerSegmentoCliente(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("obtenerSegmentoCliente():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			SegmentoClienteResponseDTO respuesta = null;
			try {
				logger.info("obtenerSegmentoCliente():Start");
				respuesta = facade.obtenerSegmentoCliente(parametro);
				logger.info("obtenerSegmentoCliente():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerSegmentoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerSegmentoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "obtenerSegmentoCliente fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public RespBooleanDTO validarSoporteGprs(TerminalServicioDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("validarSoporteGprs():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			RespBooleanDTO respuesta = null;
			try {
				logger.info("validarSoporteGprs():Start");
				respuesta = facade.validarSoporteGprs(parametro);
				logger.info("validarSoporteGprs():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "validarSoporteGprs fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "validarSoporteGprs fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "validarSoporteGprs fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta ;
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
		public PrestacionResponseDTO consultarGruposPrestacion(AuditoriaDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("ConsultarGruposPrestacion():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			PrestacionResponseDTO respuesta = null;
			try {
				logger.info("ConsultarGruposPrestacion():Start");
				respuesta = facade.consultarGruposPrestacion(parametro);
				logger.info("ConsultarGruposPrestacion():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "ConsultarGruposPrestacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "ConsultarGruposPrestacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "ConsultarGruposPrestacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public LlamadasFacturadasOutDTO consultarLlamadasNoFacturadas(ConsLlamadaInDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarLlamadasNoFacturadas():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			LlamadasFacturadasOutDTO respuesta = null;
			try {
				logger.info("consultarLlamadasNoFacturadas():Start");
				respuesta = facade.consultarLlamadasNoFacturadas(parametro);
				logger.info("consultarLlamadasNoFacturadas():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasNoFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasNoFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasNoFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public TipoServicioResponseDTO consultarTipoServicio(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarTipoServicio():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			TipoServicioResponseDTO respuesta = null;
			try {
				logger.info("consultarTipoServicio():Start");
				respuesta = facade.consultarTipoServicio(parametro);
				logger.info("consultarTipoServicio():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoServicio fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoServicio fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoServicio fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public FacturaOutDTO consultarFechaReporteConsumo(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarServiciosSuplementarios():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			FacturaOutDTO respuesta = null;
			try {
				
				System.out.println("consultasFechaReporteConsumo():Start");
				respuesta = facade.consultarFechaReporteConsumo(parametro);
				System.out.println("consultasFechaReporteConsumo():End");
			
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFechaReporteConsumo fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFechaReporteConsumo fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFechaReporteConsumo fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			return respuesta;
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
		public LlamadasFacturadasOutDTO consultarLlamadasFacturadas(LlamadaClienteDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarLlamadasFacturadas():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			LlamadasFacturadasOutDTO respuesta = null;
			try {
				logger.info("consultarLlamadasFacturadas():Start");
				respuesta = facade.consultarLlamadasFacturadas(parametro);
				logger.info("consultarLlamadasFacturadas():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarLlamadasFacturadas fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public ConsultarTerminalResponseDTO consultarTerminal(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarTerminal():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			ConsultarTerminalResponseDTO respuesta = null;
			try {
				logger.info("consultarTerminal():Start");
				respuesta = facade.consultarTerminal(parametro);
				logger.info("consultarTerminal():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTerminal fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTerminal fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTerminal fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public ConsultarTipoAbonadoResponseDTO consultarTipoAbonado(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarTipoAbonado():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			ConsultarTipoAbonadoResponseDTO respuesta = null;
			try {
				logger.info("consultarTipoAbonado():Start");
				respuesta = facade.consultarTipoAbonado(parametro);
				logger.info("consultarTipoAbonado():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoAbonado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoAbonado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarTipoAbonado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public DistribuidorResponseDTO consultarDatosDistribuidor(ConsDistribuidorInDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarDatosDistribuidor():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			DistribuidorResponseDTO respuesta = null;
			try {
				logger.info("consultarDatosDistribuidor():Start");
				respuesta = facade.consultarDatosDistribuidor(parametro);
				logger.info("consultarDatosDistribuidor():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public DistribPedidoResponseDTO consultarDatosDistribuidor(DistribPedidoInDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarDatosDistribuidor():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			DistribPedidoResponseDTO respuesta = null;
			try {
				logger.info("consultarDatosDistribuidor():Start");
				respuesta = facade.consultarDatosDistribuidor(parametro);
				logger.info("consultarDatosDistribuidor():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosDistribuidor fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
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
		public FacturaMesAnteriorResponseDTO consultaFacturaMesAnterior(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			logger.info("consultasFacturaMesAnterior():start");
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}

			FacturaMesAnteriorResponseDTO respuesta = null;
			try {
				
				System.out.println("consultasFacturaMesAnterior():Start");
				respuesta = facade.consultaFacturaMesAnterior(parametro);
				System.out.println("consultasFacturaMesAnterior():End");
			
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturaMesAnterior fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturaMesAnterior fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultasFacturaMesAnterior fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			return respuesta;
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
		public SaldoMorosidadDTO consultarSaldoClienteBloqueado(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarSaldoClienteBloqueado():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():antes");
				facade = getFacade();
				logger.info("getFacade():despues");
			} catch (Exception e) {
				logger.error("Exception", e);
				throw new IntegracionGTEException(e);
			}
			SaldoMorosidadDTO respuesta = null;
			try {
				logger.info("consultarSaldoClienteBloqueado():antes");
				respuesta = facade.consultarSaldoClienteBloqueado(parametro);
				logger.info("muestra la respuesta del ejb : " + respuesta);
				logger.info("consultarSaldoClienteBloqueado():despues");
			}  catch (IntegracionGTEException e) {
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoClienteBloqueado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoClienteBloqueado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarSaldoClienteBloqueado fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}
			logger.info("consultarSaldoClienteBloqueado():end");
			return respuesta;
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
		public TarjetaCreditoResponseDTO listarTarjetasDeCredito(AuditoriaDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("listarTarjetasDeCredito():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			TarjetaCreditoResponseDTO respuesta = null;
			try {
				logger.info("listarTarjetasDeCredito():Start");
				respuesta = facade.listarTarjetasDeCredito(parametro);
				logger.info("listarTarjetasDeCredito():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarTarjetasDeCredito fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarTarjetasDeCredito fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "listarTarjetasDeCredito fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public RespBooleanDTO registrarDatosTarjCredito(TarjetaDeCreditoInDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("registrarDatosTarjCredito():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():antes");
				facade = getFacade();
				logger.info("getFacade():despues");
			} catch (Exception e) {
				logger.error("Exception", e);
				throw new IntegracionGTEException(e);
			}
			RespBooleanDTO respuesta = null;
			try {
				logger.info("registrarDatosTarjCredito():antes");
				respuesta = facade.registrarDatosTarjCredito(parametro);
				logger.info("muestra la respuesta del ejb : " + respuesta);
				logger.info("registrarDatosTarjCredito():despues");
			}  catch (IntegracionGTEException e) {
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "registrarDatosTarjCredito fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "registrarDatosTarjCredito fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "registrarDatosTarjCredito fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}
			logger.info("registrarDatosTarjCredito():end");
			return respuesta;
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
		public BancoResponseDTO consultarBancosDisponibles(AuditoriaDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarBancosDisponibles():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			BancoResponseDTO respuesta = null;
			try {
				logger.info("consultarBancosDisponibles():Start");
				respuesta = facade.consultarBancosDisponibles(parametro);
				logger.info("consultarBancosDisponibles():End");
			} catch (IntegracionGTEException e) {
	            // TODO Auto-generated catch block
	            
	            logger.error("IntegracionGTEException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarBancosDisponibles fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (RemoteException e) {
	            
	            logger.error("RemoteException", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarBancosDisponibles fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      } catch (Exception e) {
	            
	            logger.error("Exception", e);
	            CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
	                       urlMsg, "Server fallo", "consultarBancosDisponibles fallo", urlMsg, e);
	            throw errorSoap.obtenerGeneralSoapException();
	      }           

	      return respuesta;
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
		public MinutosLdiResponseDTO consultarMinutosLDI(MinutosLdiInDTO parametro) throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarMinutosLdi():Start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e); 
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			MinutosLdiResponseDTO respuesta = null;
			try {
				logger.info("consultarMinutosLdi():Start");
				respuesta = facade.consultarMinutosLDI(parametro);
				logger.info("consultarMinutosLdi():End");
			} catch (IntegracionGTEException e) {
		           // TODO Auto-generated catch block
		           
		           logger.error("IntegracionGTEException", e);
		           CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
		                      urlMsg, "Server fallo", "consultarMinutosLdi fallo", urlMsg, e);
		           throw errorSoap.obtenerGeneralSoapException();
		     } catch (RemoteException e) {
		           
		           logger.error("RemoteException", e);
		           CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
		                      urlMsg, "Server fallo", "consultarMinutosLdi fallo", urlMsg, e);
		           throw errorSoap.obtenerGeneralSoapException();
		     } catch (Exception e) {
		           
		           logger.error("Exception", e);
		           CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
		                      urlMsg, "Server fallo", "consultarMinutosLdi fallo", urlMsg, e);
		           throw errorSoap.obtenerGeneralSoapException();
		     }           

		     return respuesta;
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
		public ConsRenovacionDTO consultarDatosRenovacion(NumeroTelefonoDTO parametro)throws IntegracionGTEException {
			UtilLog.setLog(config.getString("IntegracionGTEWS.log"));
			String urlMsg = config.getString("url.IntegracionGTEWSSTLProvider");
			logger.info("consultarDatosRenovacion():start");
			IntegracionGTEFacade facade = null;
			try {
				logger.info("getFacade():Start");
				facade =  getFacade();
				logger.info("getFacade():End");
			} catch (Exception e) {
				logger.error("Exception", e);
				e.printStackTrace();
			}
			
			ConsRenovacionDTO respuesta = null;
			try {
				logger.info("consultarDatosRenovacion():Start");
				respuesta = facade.consultarDatosRenovacion(parametro);
				logger.info("consultarDatosRenovacion():End");
			} catch (IntegracionGTEException e) {
				// TODO Auto-generated catch block
				
				logger.error("IntegracionGTEException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosRenovacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (RemoteException e) {
				
				logger.error("RemoteException", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosRenovacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			} catch (Exception e) {
				
				logger.error("Exception", e);
				CrearGeneralSoapException errorSoap = new CrearGeneralSoapException(
						urlMsg, "Server fallo", "consultarDatosRenovacion fallo", urlMsg,
						e);
				throw errorSoap.obtenerGeneralSoapException();
			}		
			
			return respuesta;
		}			
}