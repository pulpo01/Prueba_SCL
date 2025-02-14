/**
 * 
 */
package com.tmmas.gte.integraciongte.ejb.session;
 
import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongte.ejb.helper.Fecha;
import com.tmmas.gte.integraciongte.ejb.helper.Global;
import com.tmmas.gte.integraciongte.ejb.helper.ValidaParametros;
import com.tmmas.gte.integraciongtecommon.dto.ActDesServSupleDto;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO;
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
import com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO;
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
import com.tmmas.gte.integraciongteservice.srv.AbonadoDTOService;
import com.tmmas.gte.integraciongteservice.srv.AbonadoDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.ArticuloDTOService;
import com.tmmas.gte.integraciongteservice.srv.ArticuloDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.AvisoSiniestroDTOService;
import com.tmmas.gte.integraciongteservice.srv.AvisoSiniestroDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.BancoDTOService;
import com.tmmas.gte.integraciongteservice.srv.BancoDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.ClienteDTOService;
import com.tmmas.gte.integraciongteservice.srv.ClienteDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.DireccionDTOService;
import com.tmmas.gte.integraciongteservice.srv.DireccionDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.EquipoDTOService;
import com.tmmas.gte.integraciongteservice.srv.EquipoDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.FacturaDTOService;
import com.tmmas.gte.integraciongteservice.srv.FacturaDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.MovimientoCtaCteDTOService;
import com.tmmas.gte.integraciongteservice.srv.MovimientoCtaCteDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.NumeracionDTOService;
import com.tmmas.gte.integraciongteservice.srv.NumeracionDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.PlanTarifarioDTOService;
import com.tmmas.gte.integraciongteservice.srv.PlanTarifarioDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.PrestacionesDTOService;
import com.tmmas.gte.integraciongteservice.srv.PrestacionesDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.ServicioSuplementarioDTOService;
import com.tmmas.gte.integraciongteservice.srv.ServicioSuplementarioDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.TarjetaDeCreditoDTOService;
import com.tmmas.gte.integraciongteservice.srv.TarjetaDeCreditoDTOServiceImpl;
import com.tmmas.gte.integraciongteservice.srv.TraficoDTOService;
import com.tmmas.gte.integraciongteservice.srv.TraficoDTOServiceImpl;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="IntegracionGTEFacade" description="An EJB named
 *           IntegracionGTEFacade" display-name="IntegracionGTEFacade"
 *           jndi-name="IntegracionGTEFacade" type="Stateless"
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public class IntegracionGTEFacadeBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;
	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(IntegracionGTEFacadeBean.class);
	private CompositeConfiguration config;
	private Global global = Global.getInstance();
	
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
	public IntegracionGTEFacadeBean() {
		// TODO Auto-generated constructor stub
		config = UtilProperty
				.getConfiguration("IntegracionGte.properties",
						"com/tmmas/gte/integraciongte/ejb/properties/IntegracionGTEEJB.properties");

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
	public CarteraResponseDTO consultarSaldoPospago(NumeroTelefonoDTO parametro)
			throws IntegracionGTEException, RemoteException {
		CarteraResponseDTO resultado = new CarteraResponseDTO();
		MovimientoCtaCteDTOService serviceSaldoPospago = new MovimientoCtaCteDTOServiceImpl();

		RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarSaldoPospago():start");
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarSaldoPospago():start");
				NumeroPlanTarifDTO inParam0 = new NumeroPlanTarifDTO();
				inParam0.setNumeroTelefono(parametro.getNumeroTelefono());
				inParam0.setAuditoria(parametro.getAuditoria());
				resultado = serviceSaldoPospago.consultarSaldo(inParam0);
				logger.debug("consultarSaldoPospago():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
       }catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IntegracionGTEException(e);
		}
		return resultado;
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
	public DireccionRespOutDTO consultarDireccionTelefono(NumeroTelefonoDTO parametro)
			throws IntegracionGTEException, RemoteException {
		DireccionRespOutDTO resultado = new DireccionRespOutDTO();
		DireccionDTOService serviceDireccionTelefono = new DireccionDTOServiceImpl();
		RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarDireccionTelefono():start");
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarDireccionTelefono():start");
				resultado = serviceDireccionTelefono.consultarDireccionTelefono(parametro);
				logger.debug("consultarDireccionTelefono():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new DireccionRespOutDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new IntegracionGTEException(e);
		}
		return resultado;
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
		String nombreMetodo = " consultarPlanTarifario";
		PlanTarifarioDTOService servicePlanTarifario = new PlanTarifarioDTOServiceImpl();
		PlanTarifarioResponseOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosPlanTarifario():start");
			   mensaje = validaParametro.planTarifario(parametro);
			logger.debug("validacionMetodosPlanTarifario():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarPlanTarifario():start");
				resultado = servicePlanTarifario.consultarPlanTarifario(parametro);
				logger.debug("consultarPlanTarifario():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new PlanTarifarioResponseOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general")+ nombreMetodo);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general")+ nombreMetodo,nuevo);
		}
		return resultado;
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
		ServicioSuplementarioDTOService serviceSeguro = new ServicioSuplementarioDTOServiceImpl();
		SeguroResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionConsultarSeguroPorTelefono():start");
			   mensaje = validaParametro.consultarSeguroPorTelefono(parametro);
			logger.debug("validacionConsultarSeguroPorTelefono():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarSeguroPorTelefono():start");
				resultado = serviceSeguro.consultarSeguroTelefono(parametro);
				logger.debug("consultarSeguroPorTelefono():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new SeguroResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		TraficoDTOService serviceLlamadaNoFacturada = new TraficoDTOServiceImpl();
		LlamadasFacturadasOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosconsultarLlamadasNoFacturadas():start");
			   mensaje = validaParametro.consultarLLamadasNoFacturadas(parametro);
			logger.debug("validacionMetodosconsultarLlamadasNoFacturadas():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarLlamadasNoFacturadas():start");
				resultado = serviceLlamadaNoFacturada.listarLlamadasNoFacturadas(parametro);
				logger.debug("consultarLlamadasNoFacturadas():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new LlamadasFacturadasOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		AbonadoDTOService serviceAlta = new AbonadoDTOServiceImpl();
		AltaPrepagoResponseDTO resultado;
		AltaPrepagoOutDTO      resultadoFinal = new AltaPrepagoOutDTO();
		Fecha fecha = new Fecha();
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("AltaPrepago():start");
			   mensaje = validaParametro.altaPrepago(parametro);
			logger.debug("validacionMetodosAltaPrepago():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarFechaAlta():start");
				resultado = serviceAlta.consultarFechaAltaPrepago(parametro);
				if(resultado != null && resultado.getFechaAlta() != null && resultado.getRespuesta()!= null && resultado.getRespuesta().getCodigoError() == 0){
					resultadoFinal.setFechaAlta(fecha.fechaDateTOfechaString(Fecha.FORMATO_FECHA_ESPAÑOL, resultado.getFechaAlta()));
					resultadoFinal.setRespuesta(resultado.getRespuesta());
				}else{
					if(resultado != null && resultado.getRespuesta()!= null && resultado.getRespuesta().getCodigoError() != 0){
						resultadoFinal.setRespuesta(resultado.getRespuesta());
						return resultadoFinal;
					}
				}
				logger.debug("consultarFechaAlta():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultadoFinal = new AltaPrepagoOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultadoFinal.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultadoFinal;
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
		ServicioSuplementarioDTOService serviceServicioSuplementario = new ServicioSuplementarioDTOServiceImpl();
		ServicioSupleRespondeDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodoServiciosSuplementarios():start");
			   mensaje = validaParametro.serviciosSuplementarios(parametro);
			logger.debug("validacionMetodoServiciosSuplementarios():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarServiciosSuplementarios():start");
				resultado = serviceServicioSuplementario.consultaServicioSuplem(parametro);
				logger.debug("consultarServiciosSuplementarios():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new ServicioSupleRespondeDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
				
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		FacturaDTOService serviceAlta = new FacturaDTOServiceImpl();
		FacturaResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null;              
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionconsultasFacturasDeunCliente():start");
			   mensaje = validaParametro.consultasFacturasDeunCliente(parametro);
			logger.debug("validacionconsultasFacturasDeunCliente():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultasFacturasDeunCliente():start");
				resultado = serviceAlta.consultarFacturasPorCliente(parametro);
				logger.debug("consultasFacturasDeunCliente():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new FacturaResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		FacturaDTOService servicefechaFactura = new FacturaDTOServiceImpl();
		FacturaOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionconsultasFechaReporteConsumo():start");
			   mensaje = validaParametro.consultasFechaFacturaReporteConsumo(parametro);
			logger.debug("validacionconsultasFechaReporteConsumo():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultasFechaReporteConsumo():start");
				resultado = servicefechaFactura.consultarFechasReporteConsumo(parametro);
				logger.debug("consultasFechaReporteConsumo():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new FacturaOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public PagoOutDTO consultaPagosRealizados(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		MovimientoCtaCteDTOService servicePago = new MovimientoCtaCteDTOServiceImpl();
		PagoOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionconsultaPagosRealizados():start");
			   mensaje = validaParametro.consultasFechaFacturaReporteConsumo(parametro);
			logger.debug("validacionconsultaPagosRealizados():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultaPagosRealizados():start");
				resultado = servicePago.consultarPagosRealizados(parametro);
				logger.debug("consultaPagosRealizados():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new PagoOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public ConsumoResponseOutDTO consultarConsumoMensajesCortos(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		TraficoDTOService serviceConsumo = new TraficoDTOServiceImpl();
		ConsumoResponseOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionconsultarConsumoMensajesCortos():start");
			   mensaje = validaParametro.consultarConsumoMensajesCortos(parametro);
			logger.debug("validacionconsultarConsumoMensajesCortos():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarConsumoMensajesCortos():start");
				resultado = serviceConsumo.listarConsumoMensajesCortos(parametro);
				logger.debug("consultarConsumoMensajesCortos():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new ConsumoResponseOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public RespBooleanDTO validarNumeroHibrido(NumeroTelefonoDTO parametro)	throws IntegracionGTEException, RemoteException {
		RespBooleanDTO resultado;
		RespuestaDTO respuesta;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		AbonadoDTOService serviceNumeroHibrido = new AbonadoDTOServiceImpl();

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroHibrido():start");
			logger.debug("validacionMetodosPlanTarifario():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validacionMetodosPlanTarifario():end");

			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("validarNumeroHibrido():start");
				NumeroPlanTarifDTO inParam0 = new NumeroPlanTarifDTO();
				inParam0.setNumeroTelefono(parametro.getNumeroTelefono());
				inParam0.setDesPlanTarifario(global.getValor("plan.tarifario.hibrido"));
				inParam0.setAuditoria(parametro.getAuditoria());
				resultado = serviceNumeroHibrido.validarNumPospagoHibrido(inParam0);
				logger.debug("validarNumeroHibrido():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new RespBooleanDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}	
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;

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
	public ConsLinkFacturaResponseDTO consultarLinkFactura(ConsLinkFacturaDTO parametro) throws IntegracionGTEException, RemoteException {
		ConsLinkFacturaResponseDTO resultado;
		RespuestaDTO respuesta;
		FacturaDTOService serviceLinkFactura = new FacturaDTOServiceImpl();

		ValidaParametros validaParametro = new ValidaParametros();
		String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarLinkFactura():start");
			logger.debug("validacionMetodosLinkFactura():start");
			mensaje = validaParametro.linkFactura(parametro);
			logger.debug("validacionMetodosLinkFactura():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarLinkFactura():start");
				resultado = serviceLinkFactura.consultarLinkFactura(parametro);
				logger.debug("consultarLinkFactura():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new ConsLinkFacturaResponseDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}	
						
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public RespBooleanDTO validarNumPospago(NumeroTelefonoDTO parametro) throws IntegracionGTEException, RemoteException {
		RespBooleanDTO resultado;
		RespuestaDTO respuesta;
		ValidaParametros validaParametro = new ValidaParametros();
		AbonadoDTOService serviceCliePospago = new AbonadoDTOServiceImpl();
		String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumPospago():start");
			logger.debug("validacionMetodosNumPospago():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validacionMetodosNumPospago():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("validarNumPospago():start");
				NumeroPlanTarifDTO inParam0 = new NumeroPlanTarifDTO();
				inParam0.setNumeroTelefono(parametro.getNumeroTelefono());
				inParam0.setDesPlanTarifario(global.getValor("plan.tarifario.pospago"));
				inParam0.setAuditoria(parametro.getAuditoria());
				resultado = serviceCliePospago.validarNumPospagoHibrido(inParam0);
				logger.debug("validarNumPospago():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new RespBooleanDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public RespBooleanDTO validarClienteTelefono(EsClieTelefDTO parametro) throws IntegracionGTEException, RemoteException {
		RespBooleanDTO resultado;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			AbonadoDTOService  serviceAbonado = new AbonadoDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			logger.debug("validarTelefonoCliente():start");
			mensaje = validaParametro.esClienteTelefono(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
			   resultado = serviceAbonado.validarClienteTelefono(parametro);
			   logger.debug("validarTelefonoCliente():end");
			}else{
		         /*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new RespBooleanDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);

          }
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public RespBooleanDTO validarTelIgualCli(EsTelefIgualClieDTO parametro) throws IntegracionGTEException, RemoteException {
		RespBooleanDTO resultado;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			ValidaParametros validaParametro = new ValidaParametros();
			AbonadoDTOService  serviceAbonado= new AbonadoDTOServiceImpl();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			logger.debug("validarTelCli():start");
			mensaje = validaParametro.esTelefIgualClie(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = serviceAbonado.validarTelIgualCli(parametro);
				logger.debug("validarTelCli():end");
			}else{
		         /*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new RespBooleanDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public RespuestaDTO activarDesactivarSS(ActDesServSupleDto parametro) throws IntegracionGTEException, RemoteException {
		RespuestaDTO resultado;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			ServicioSuplementarioDTOService servSuple= new ServicioSuplementarioDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			logger.debug("actDesServicioSuplem():start");
			logger.debug("validaParametro.actDesServSuple():start");
			mensaje = validaParametro.actDesServSuple(parametro);
			logger.debug("validaParametro.actDesServSuple:end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = servSuple.activarDesactivarSS(parametro);
				logger.debug("Comienza ha evaluar para hacer Rollback :start");
				if(resultado == null){
					context.setRollbackOnly();
				}else if(resultado != null && resultado.getCodigoError() != 0  ){
					context.setRollbackOnly();
				}
				logger.debug("Finaliza evaluación para hacer Rollback :end");
				logger.debug("actDesServicioSuplem():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				resultado = new RespuestaDTO();
				resultado.setCodigoError(-10044);
				resultado.setMensajeError(mensajeFinal);
				resultado.setNumeroEvento(0);
			}	
		
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			logger.debug("IntegracionGTEException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			context.setRollbackOnly();
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		ArticuloDTOService articuloDTOServicePuk = new ArticuloDTOServiceImpl();
		ConsultaPukResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensajeFinal = null;
        String  mensaje = null;  
        String  mensajeAuditoria = null;  
        try {
              UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
              logger.debug("validacionMetodosConsultaPuk():start");
                    mensaje = validaParametro.consultarPuk(parametro);
              logger.debug("validacionMetodosConsultaPuk():end");
              if(mensaje != null){
                    mensajeFinal = mensaje;
              }     
              //Validar Auditoria
              logger.debug("validaParametro.validarAuditoria:start");
              mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
              logger.debug("ValidaParametro.validarAuditoria:end");
              if(mensajeAuditoria != null){
                    mensajeFinal = mensajeAuditoria;
              }     
              if((mensaje == null)&&(mensajeAuditoria == null)){
                    logger.debug("consultaPuk():start");
                    resultado = articuloDTOServicePuk.consultarPuk(parametro);
                    logger.debug("consultaPuk():end");
              }else{
                    /*
             * se comienza a construir el mensaje de error por no pasar la validaciones
             * */
                    resultado = new ConsultaPukResponseDTO();
                    RespuestaDTO nuevaValidacion = new RespuestaDTO();
                    nuevaValidacion.setCodigoError(-10044);
                    nuevaValidacion.setMensajeError(mensajeFinal);
                    nuevaValidacion.setNumeroEvento(0);
                    resultado.setRespuesta(nuevaValidacion);
              }
              logger.debug("consultaPuk():end");
        } catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
        } catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
        }
        return resultado;
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
		NumeracionDTOService serviceValNumTelefonica = new NumeracionDTOServiceImpl();
		RespBooleanDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
    	String  mensaje = null;
    	String  mensajeFinal = null;
    	String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosesTelefTelefonica():start");
				mensaje = validaParametro.consultaNumeracion(parametro);
			logger.debug("validacionMetodosesTelefTelefonica():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("sesTelefTelefonica():start");
				resultado = serviceValNumTelefonica.consultarNumeracion(parametro);
				logger.debug("esTelefTelefonica():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new RespBooleanDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);

			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
		AvisoSiniestroDTOService service = new AvisoSiniestroDTOServiceImpl();
    	ConsAvisoSiniestroResponseDTO resultado;
    	RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
	       String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null; 

			try {
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarAvisoSiniestro():start");
				logger.debug("validacionMetodosConsAvisoSiniestro():start");
					mensaje = validaParametro.consultarAvisoSiniestro(parametro);
				logger.debug("validacionMetodosConsAvisoSiniestro():end");
				if (mensaje != null){
					mensajeFinal = mensaje;
				}
				//validar Auditoria
				logger.debug("validaParametro.validarAuditoria:start");
				mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
				logger.debug("ValidaParametro.validarAuditoria:end");
				if(mensajeAuditoria != null){
					mensajeFinal = mensajeAuditoria;
				}	
				if((mensaje == null)&&(mensajeAuditoria == null)){
					logger.debug("consultarAvisoSiniestro():start");
					resultado = service.consultarAvisoSiniestro(parametro);
					logger.debug("consultarAvisoSiniestro():end");
				}else{
					/*
					 * se comienza a construir el mensaje de error por no pasar la validaciones
					 **/
					respuesta = new RespuestaDTO();
					resultado = new ConsAvisoSiniestroResponseDTO();
					respuesta.setCodigoError(-10044);
					respuesta.setMensajeError(mensajeFinal);
					respuesta.setNumeroEvento(0);
					resultado.setRespuesta(respuesta);
				}
			} catch (IntegracionGTEException e) {
				logger.debug("IntegracionGTEException[", e);
				e.setMessage(global.getValor("error.ejb.general"));
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				IntegracionGTEException nuevo = new IntegracionGTEException();
				nuevo.setMessage(e.getMessage());
				throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
			}

			return resultado;
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
		AvisoSiniestroDTOService service = new AvisoSiniestroDTOServiceImpl();
    	ConsAvisoSiniestroResponseDTO resultado;
    	RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
   
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarFechaAvisoSiniestro():start");
			logger.debug("validacionMetodosConsAvisoSiniestro():start");
				mensaje = validaParametro.consultarAvisoSiniestro(parametro);
			logger.debug("validacionMetodosConsAvisoSiniestro():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
			logger.debug("consultarFechaAvisoSiniestro():start");
				resultado = service.consultarFechaAvisoSiniestro(parametro);
				logger.debug("consultarFechaAvisoSiniestro():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new ConsAvisoSiniestroResponseDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public LstCliResponseDTO listarClientes(NumeroTelefonoDTO parametro) throws IntegracionGTEException, RemoteException {
		LstCliResponseDTO resultado;
		try {
			ClienteDTOService servCliente= new ClienteDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null; 
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("listarClientes():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = servCliente.listarClientes(parametro);
				logger.debug("listarClientes():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				 resultado = new LstCliResponseDTO();
	             RespuestaDTO  nuevaValidacion = new RespuestaDTO();
	             nuevaValidacion.setCodigoError(-10044);
	             nuevaValidacion.setMensajeError(mensajeFinal);
	             nuevaValidacion.setNumeroEvento(0);
	             resultado.setRespuesta(nuevaValidacion);
			}	
		
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public LstCliResponseDTO listarClientes(DatosLstCliCueDTO parametro) throws IntegracionGTEException, RemoteException {
		LstCliResponseDTO resultado;
		try {
			ClienteDTOService servCliente= new ClienteDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("listarClientesCue():start");
			mensaje = validaParametro.validarClienteCuenta(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = servCliente.listarClientes(parametro);
				logger.debug("listarClientesCue():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				 resultado = new LstCliResponseDTO();
	             RespuestaDTO  nuevaValidacion = new RespuestaDTO();
	             nuevaValidacion.setCodigoError(-10044);
	             nuevaValidacion.setMensajeError(mensajeFinal);
	             nuevaValidacion.setNumeroEvento(0);
	             resultado.setRespuesta(nuevaValidacion);
			}	
		
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public LstConceptoFacturaDTO consultarConceptosFactura(CodClienteDTO parametro) throws IntegracionGTEException, RemoteException {
		LstConceptoFacturaDTO resultado;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			FacturaDTOService servFactura= new FacturaDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			logger.debug("consultarConceptosFactura():start");
			mensaje = validaParametro.consultarConceptosFactura(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = servFactura.consultarConceptosFactura(parametro);
				logger.debug("consultarConceptosFactura():end");
			}else{
		         /*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new LstConceptoFacturaDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
		ClienteDTOService service = new ClienteDTOServiceImpl();
		DatosClientePospHibrPrepDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensaje = null;
    	String  mensajeFinal = null;
    	String  mensajeAuditoria = null;
    	
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosConsultarDatosGenCliente():start");
				mensaje = validaParametro.consultarDatosGenCliente(parametro);
			logger.debug("validacionMetodosConsultarDatosGenCliente():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("ConsultarDatosGenCliente():start");
				resultado = service.consultarDatosGenCliente(parametro);
				logger.debug("ConsultarDatosGenCliente():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new DatosClientePospHibrPrepDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}
 
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public TecnologiaDTO consultarTecnologia(NumeroTelefonoDTO parametro) throws IntegracionGTEException, RemoteException {
		TecnologiaDTO resultado = new TecnologiaDTO();
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			AbonadoDTOService servAbonado= new AbonadoDTOServiceImpl();
			ValidaParametros validaParametro = new ValidaParametros();
			String  mensajeFinal = null;
			String  mensaje = null;  
			String  mensajeAuditoria = null;  
			logger.debug("consultarTecnologia():start");
			logger.debug("ValidaParametro.validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("ValidaParametro.validarNumeroTelefono:end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				resultado = servAbonado.consultarTecnologia(parametro);
				logger.debug("consultarTecnologia():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				  RespuestaDTO  nuevaValidacion = new RespuestaDTO();
	              nuevaValidacion.setCodigoError(-10044);
	              nuevaValidacion.setMensajeError(mensajeFinal);
	              nuevaValidacion.setNumeroEvento(0);
	              resultado.setRespuesta(nuevaValidacion);
			}	
		
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;	
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
		ClienteDTOService service = new ClienteDTOServiceImpl();
		DatosClienteOutDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensaje = null;
    	String  mensajeFinal = null;
    	String  mensajeAuditoria = null;
    	
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosConsultarDatosGenClienteCod():start");
				mensaje = validaParametro.consultarDatosGenCliente(parametro);
			logger.debug("validacionMetodosConsultarDatosGenClienteCod():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("ConsultarDatosGenClienteCod():start");
				resultado = service.consultarDatosGenCliente(parametro);
				logger.debug("ConsultarDatosGenClienteCod():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new DatosClienteOutDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public FacturaResponseDTO obtenerUltimaFacturaPagada(NumeroTelefonoDTO inParam1) throws IntegracionGTEException {
		FacturaDTOService service = new FacturaDTOServiceImpl();
		FacturaResponseDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null;  
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroTelefono():start");
				mensaje = validaParametro.validarNumeroTelefono(inParam1);
			logger.debug("validarNumeroTelefono():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(inParam1.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("obtenerUltimaFacturaPagada():start");
					resultado = service.obtenerUltimaFacturaPagada(inParam1);
				logger.debug("obtenerUltimaFacturaPagada():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new FacturaResponseDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
		FacturaDTOService service = new FacturaDTOServiceImpl();
    	FacturaResponseDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensaje = null;
    	String  mensajeFinal = null;
    	String  mensajeAuditoria = null;
    	
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosConsultarDatosGenClienteCod():start");
				mensaje = validaParametro.consultarFacturasImpagasPorCliente(parametro);
			logger.debug("validacionMetodosConsultarDatosGenClienteCod():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("ConsultarFacturasImpagasPorCliente():start");
				NumeroPlanTarifDTO inParam0 = new NumeroPlanTarifDTO();
				inParam0.setNumeroTelefono(parametro.getNumeroTelefono());
				inParam0.setAuditoria(parametro.getAuditoria());
				resultado = service.consultarFacturasImpagasPorCliente(inParam0);
				logger.debug("ConsultarFacturasImpagasPorCliente():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new FacturaResponseDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
		ClienteDTOService service = new ClienteDTOServiceImpl();
		RespTipoClienteDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensaje = null;
    	String  mensajeFinal = null;
    	String  mensajeAuditoria = null;
    	
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionMetodosConsultarTipoCliente():start");
				mensaje = validaParametro.consultarTipoCliente(parametro);
			logger.debug("validacionMetodosConsultarTipoCliente():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
//			Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("ConsultarConsultarTipoCliente():start");
				resultado = service.consultarTipoCliente(parametro);
				logger.debug("ConsultarConsultarTipoCliente():end");
			}else{
				
				resultado = new RespTipoClienteDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
		PlanTarifarioDTOService servicePlanesVigentes = new PlanTarifarioDTOServiceImpl();
		PlanTarifarioResponseDTO resultado = new PlanTarifarioResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			
			logger.debug("consultarPlanesDisponibles():start");
			logger.debug("Metodos Validar consultarPlanesDisponibles():start");
			mensaje = validaParametro.consultarPlanesDisponibles(inParam0);
			logger.debug("Metodos Validar consultarPlanesDisponibles():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(inParam0.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarPlanesDisponibles():start");
				resultado = servicePlanesVigentes.consultarPlanesDisponibles(inParam0);
				logger.debug("consultarPlanesDisponibles():end");
			}else{
				
				 // se comienza a construir el mensaje de error por no pasar la validaciones
				 
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public PlanTarifarioResponseDTO consultarPlanesDisponibles(GrupoPrestacionListDTO inParam0) throws IntegracionGTEException {
		PlanTarifarioDTOService servicePlanesVigentes = new PlanTarifarioDTOServiceImpl();
		PlanTarifarioResponseDTO resultado = new PlanTarifarioResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			
			logger.debug("consultarPlanesDisponibles():start");
			logger.debug("Metodos Validar consultarPlanesDisponibles():start");
			mensaje = validaParametro.consultarPlanesDisponibles(inParam0);
			logger.debug("Metodos Validar consultarPlanesDisponibles():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(inParam0.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarPlanesDisponibles():start");
				resultado = servicePlanesVigentes.consultarPlanesDisponibles(inParam0);
				logger.debug("consultarPlanesDisponibles():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		PlanTarifarioDTOService servicePlanesVigentes = new PlanTarifarioDTOServiceImpl();
		PlanTarifarioResponseDTO resultado = new PlanTarifarioResponseDTO();           
		String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		RespuestaDTO respuesta = new RespuestaDTO();
		ValidaParametros validaParametro = new ValidaParametros();
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarPlanesDisponibles():start");
			
//			validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(inParam0);
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarPlanesDisponibles():start");
				resultado = servicePlanesVigentes.consultarPlanesDisponibles(inParam0);
				logger.debug("consultarPlanesDisponibles():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		PrestacionesDTOService servicePrestaciones = new PrestacionesDTOServiceImpl();
		ConsPrestacionesResponseDTO resultado = new ConsPrestacionesResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarCodigosPrestacion():start");
			logger.debug("MetodoValidarConsCodPrestacion():start");
			mensaje = validaParametro.consCodPrestacion(inParam0);
			logger.debug("MetodoValidarConsCodPrestacion():end");

			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(inParam0.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarCodigosPrestacion():start");
				resultado = servicePrestaciones.consultarCodigosPrestacion(inParam0);
				logger.debug("consultarCodigosPrestacion():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public BloqueoResponseDTO consultaBloqueoTelefono(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		AbonadoDTOServiceImpl serviceBloqueo = new AbonadoDTOServiceImpl();
		BloqueoResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionConsultaBloqueoTelefono():start");
			   mensaje = validaParametro.consultarDeBloqueo(parametro);
			logger.debug("validacionConsultaBloqueoTelefono():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultaBloqueoTelefono():start");
				resultado = serviceBloqueo.consultarBloqueoTelefono(parametro);
				logger.debug("consultaBloqueoTelefono():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new BloqueoResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		TraficoDTOService service = new TraficoDTOServiceImpl();
		MinutosConsumidosDTO resultado;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null;  
    	
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroTelefono():start");
				mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarMinutosConsumidos():start");
					resultado = service.consultarMinutosConsumidos(parametro);
				logger.debug("consultarMinutosConsumidos():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				resultado = new MinutosConsumidosDTO();
				RespuestaDTO nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);
			}

		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}

		return resultado;
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
	public RespBooleanDTO validarSoporteGprs(TerminalServicioDTO parametro)
			throws IntegracionGTEException, RemoteException {
		RespBooleanDTO resultado = new RespBooleanDTO();
		ArticuloDTOService serviceSoporteGprs = new ArticuloDTOServiceImpl();
		RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	NumeroTelefonoDTO parametro2 = new NumeroTelefonoDTO();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarSoporteGprs():start");
			logger.debug("validarNumeroTelefono():start");
			parametro2.setNumeroTelefono(parametro.getNumeroTelefono());
			mensaje = validaParametro.validarNumeroTelefono(parametro2);
			logger.debug("validarNumeroTelefono():end");

			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("validarSoporteGprs():start");
				resultado = serviceSoporteGprs.validarSoporteGprs(parametro);
				logger.debug("validarSoporteGprs():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new RespBooleanDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public ComponentesResponseDTO consultarEstadoComponentes(NumeroTelefonoDTO parametro)
			throws IntegracionGTEException, RemoteException {
		ComponentesResponseDTO resultado = new ComponentesResponseDTO();
		ServicioSuplementarioDTOService serviceServSuple = new ServicioSuplementarioDTOServiceImpl();

		ValidaParametros validaParametro = new ValidaParametros();
        String  mensaje = null; 
        String  mensajeFinal = null; 
        String mensajeAuditoria = null ;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarEstadoComponentes():start");
				resultado = serviceServSuple.consultarEstadoComponentes(parametro);
				logger.debug("consultarEstadoComponentes():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new ComponentesResponseDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);    
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public SegmentoClienteResponseDTO obtenerSegmentoCliente(NumeroTelefonoDTO parametro)
			throws IntegracionGTEException, RemoteException {
		SegmentoClienteResponseDTO resultado = new SegmentoClienteResponseDTO();
		ClienteDTOService serviceCliente = new ClienteDTOServiceImpl();

		ValidaParametros validaParametro = new ValidaParametros();
        String  mensaje = null; 
        String  mensajeFinal = null; 
        String mensajeAuditoria = null ;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarEstadoComponentes():start");
				resultado = serviceCliente.obtenerSegmentoCliente(parametro);
				logger.debug("consultarEstadoComponentes():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new SegmentoClienteResponseDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);    
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		PrestacionesDTOService prestacionesDTOService = new PrestacionesDTOServiceImpl();
		PrestacionResponseDTO resultado;  
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		String  mensaje = null;
		ValidaParametros validaParametro = new ValidaParametros();
		RespuestaDTO respuesta;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));

			mensaje = validaParametro.validarAuditoria(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro);
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("ConsultarGruposPrestacion():start");
				resultado = prestacionesDTOService.consultarGruposPrestacion(parametro);
				logger.debug("ConsultarGruposPrestacion():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new PrestacionResponseDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public ConsultarTerminalResponseDTO consultarTerminal(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		EquipoDTOService equipoDTOService = (EquipoDTOService) new EquipoDTOServiceImpl();
		ConsultarTerminalResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null; 
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarTerminal():start");
			   mensaje = validaParametro.consultarTerminal(parametro);
			logger.debug("consultarTerminal():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarTerminal():start");
				resultado = equipoDTOService.consultarTerminal(parametro);
				logger.debug("consultarTerminal():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new ConsultarTerminalResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
				logger.debug("IntegracionGTEException[", e);
				e.setMessage(global.getValor("error.ejb.general"));
				throw e;
		} catch (Exception e) {
				logger.debug("Exception[", e);
				IntegracionGTEException nuevo = new IntegracionGTEException();
				nuevo.setMessage(e.getMessage());
				throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public ConsultarTipoAbonadoResponseDTO consultarTipoAbonado(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		AbonadoDTOService abonadoDTOService = new AbonadoDTOServiceImpl();
		ConsultarTipoAbonadoResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null; 
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarTipoAbonado():start");
			   mensaje = validaParametro.consultarTipoAbonado(parametro);
			logger.debug("consultarTipoAbonado():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarTipoAbonado():start");
				resultado = abonadoDTOService.consultarTipoAbonado(parametro);
				logger.debug("consultarTipoAbonado():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new ConsultarTipoAbonadoResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		}catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		FacturaDTOService serviceFactura = new FacturaDTOServiceImpl();
		FacturaNoCicloResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;  
    	String  mensajeFinal = null;
		String  mensajeAuditoria = null; 		
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validacionconsultarFacturasNoCicloCliente():start");
			   mensaje = validaParametro.consultarFacturasNoCicloCliente(parametro);
			logger.debug("validacionconsultarFacturasNoCicloCliente():end");
			if (mensaje != null){
				mensajeFinal = mensaje;
			}			
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensaje == null && mensajeAuditoria == null){
				logger.debug("consultarFacturasNoCicloCliente():start");
				resultado = serviceFactura.consultarFacturasNoCicloCliente(parametro);
				logger.debug("consultarFacturasNoCicloCliente():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new FacturaNoCicloResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public FacturaMesAnteriorResponseDTO consultaFacturaMesAnterior(NumeroTelefonoDTO parametro)
		throws IntegracionGTEException, RemoteException {
		FacturaMesAnteriorResponseDTO resultado = new FacturaMesAnteriorResponseDTO();
		FacturaDTOService serviceFactura = new FacturaDTOServiceImpl();

		ValidaParametros validaParametro = new ValidaParametros();
        String  mensaje = null; 
        String  mensajeFinal = null; 
        String mensajeAuditoria = null ;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarEstadoComponentes():start");
				resultado = serviceFactura.consultaFacturaMesAnterior(parametro);
				logger.debug("consultarEstadoComponentes():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
                resultado = new FacturaMesAnteriorResponseDTO();
                RespuestaDTO  nuevaValidacion = new RespuestaDTO();
                nuevaValidacion.setCodigoError(-10044);
                nuevaValidacion.setMensajeError(mensajeFinal);
                nuevaValidacion.setNumeroEvento(0);
                resultado.setRespuesta(nuevaValidacion);    
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public DistribuidorResponseDTO consultarDatosDistribuidor(ConsDistribuidorInDTO parametro)
			throws IntegracionGTEException, RemoteException {
		DistribuidorResponseDTO resultado = new DistribuidorResponseDTO();
		ClienteDTOService serviceDistribuidor = new ClienteDTOServiceImpl();
		RespuestaDTO respuesta = new RespuestaDTO();
		ValidaParametros validaParametro = new ValidaParametros();
        String  mensaje = null; 
        String  mensajeFinal = null; 
        String mensajeAuditoria = null ;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("Metodo Validar: consultarDistribuidor():start");
			mensaje = validaParametro.consultarDistribuidor(parametro);
			logger.debug("Metodo Validar: consultarDistribuidor():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarEstadoComponentes():start");
				resultado = serviceDistribuidor.consultarDatosDistribuidor(parametro);
				logger.debug("consultarEstadoComponentes():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public DistribPedidoResponseDTO consultarDatosDistribuidor(DistribPedidoInDTO parametro)
			throws IntegracionGTEException, RemoteException {
		DistribPedidoResponseDTO resultado = new DistribPedidoResponseDTO();
		ClienteDTOService serviceDistribuidor = new ClienteDTOServiceImpl();
		RespuestaDTO respuesta = new RespuestaDTO();
		ValidaParametros validaParametro = new ValidaParametros();
        String  mensaje = null; 
        String  mensajeFinal = null; 
        String mensajeAuditoria = null ;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("Metodo Validar: consultarDistribuidor():start");
			mensaje = validaParametro.consultarDistribuidor(parametro);
			logger.debug("Metodo Validar: consultarDistribuidor():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.actDesServSuple:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
				logger.debug("consultarDatosDistribuidor():start");
				resultado = serviceDistribuidor.consultarDatosDistribuidor(parametro);
				logger.debug("consultarDatosDistribuidor():end");
			}else{
				/*
                 * se comienza a construir el mensaje de error por no pasar la validaciones
                 * */
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
				logger.debug("IntegracionGTEException[", e);
				e.setMessage(global.getValor("error.ejb.general"));
				throw e;
		} catch (Exception e) {
				logger.debug("Exception[", e);
				IntegracionGTEException nuevo = new IntegracionGTEException();
				nuevo.setMessage(e.getMessage());
				throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public TipoServicioResponseDTO consultarTipoServicio(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		PrestacionesDTOService prestacionesDTOService = new PrestacionesDTOServiceImpl();
		TipoServicioResponseDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null;    
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarTipoServicio():start");
			   mensaje = validaParametro.consultarTipoServicio(parametro);
			logger.debug("consultarTipoServicio():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarTipoServicio():start");
				resultado = prestacionesDTOService.consultarTipoServicio(parametro);
				logger.debug("consultarTipoServicio():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new TipoServicioResponseDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public SaldoMorosidadDTO consultarSaldoClienteBloqueado(NumeroTelefonoDTO parametro)
			throws IntegracionGTEException, RemoteException {
		SaldoMorosidadDTO resultado = new SaldoMorosidadDTO();
		MovimientoCtaCteDTOService serviceSaldoMoroso = new MovimientoCtaCteDTOServiceImpl();

		RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarSaldoClienteBloqueado():start");
			logger.debug("validarNumeroTelefono():start");
			mensaje = validaParametro.validarNumeroTelefono(parametro);
			logger.debug("validarNumeroTelefono():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarSaldoClienteBloqueado():start");
				resultado = serviceSaldoMoroso.consultarSaldo(parametro);
				logger.debug("consultarSaldoClienteBloqueado():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
       }catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public LlamadasFacturadasOutDTO consultarLlamadasFacturadas(LlamadaClienteDTO parametro) throws IntegracionGTEException {
		TraficoDTOService serviceLlamadasFacturadas = new TraficoDTOServiceImpl();
		LlamadasFacturadasOutDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null; 
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("consultarLlamadasFacturadas():start");
			   mensaje = validaParametro.consultarLlamadasFacturadas(parametro);
			logger.debug("consultarLlamadasFacturadas():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarLlamadasFacturadas():start");
				resultado = serviceLlamadasFacturadas.consultarLlamadasFacturadas(parametro);
				logger.debug("consultarLlamadasFacturadas():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new LlamadasFacturadasOutDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public TarjetaCreditoResponseDTO listarTarjetasDeCredito(AuditoriaDTO parametro)
		throws IntegracionGTEException, RemoteException {
		RespuestaDTO respuesta;
    	ValidaParametros  	validaParametro 		= new ValidaParametros();
    	TarjetaDeCreditoDTOService  	serviceTarjetaCredito 	= new TarjetaDeCreditoDTOServiceImpl();
    	TarjetaCreditoResponseDTO resultado 				= new TarjetaCreditoResponseDTO();
    	String  mensajeFinal 	 = null;
		String  mensaje 	 	 = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("listarTarjetasDeCredito():start");
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro);
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if(mensajeAuditoria == null){
				logger.debug("listarTarjetasDeCredito():start");
				resultado = serviceTarjetaCredito.listarTarjetasDeCredito(parametro);
				logger.debug("listarTarjetasDeCredito():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
       }catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public RespBooleanDTO registrarDatosTarjCredito(TarjetaDeCreditoInDTO parametro)
			throws IntegracionGTEException, RemoteException {
		RespBooleanDTO 		resultado 		= new RespBooleanDTO();
		TarjetaDeCreditoDTOService 	serviceRegTarjCredito = new TarjetaDeCreditoDTOServiceImpl();

		RespuestaDTO respuesta;
    	ValidaParametros validaParametro = new ValidaParametros();
    	String  mensajeFinal = null;
		String  mensaje = null;  
		String  mensajeAuditoria = null; 
		
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("registrarDatosTarjCredito():start");
			logger.debug("validarDatosTarjCredito():start");
			mensaje = validaParametro.validarDatosTarjCredito(parametro);
			logger.debug("validarDatosTarjCredito():end");
			
			if (mensaje != null){
				mensajeFinal = mensaje;
			}
			//validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarSaldoClienteBloqueado():start");
				//parametro.getFechaVencTarjeta();
				resultado = serviceRegTarjCredito.registrarDatosTarjCredito(parametro);
				logger.debug("Comienza ha evaluar para hacer Rollback :start");
				if(resultado == null){
					context.setRollbackOnly();	
				}else if(resultado != null && resultado.getRespuesta().getCodigoError() !=0  ){
					context.setRollbackOnly();
				}
				logger.debug("Finaliza evaluación para hacer Rollback :end");
				logger.debug("consultarSaldoClienteBloqueado():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
       }catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			context.setRollbackOnly();
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		BancoDTOService bancoDTOService = new BancoDTOServiceImpl();
		BancoResponseDTO resultado;  
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		String  mensaje = null;
		ValidaParametros validaParametro = new ValidaParametros();
		RespuestaDTO respuesta;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));

			mensaje = validaParametro.validarAuditoria(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro);
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarBancosDisponibles():start");
				resultado = bancoDTOService.listarBancosDisponibles(parametro);
				logger.debug("consultarBancosDisponibles():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new BancoResponseDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
		TraficoDTOService minutosLdiDTOService = new TraficoDTOServiceImpl();
		MinutosLdiResponseDTO resultado;  
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		String  mensaje = null;
		ValidaParametros validaParametro = new ValidaParametros();
		RespuestaDTO respuesta;

		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));

			mensaje = validaParametro.validarDatosLargaDistancia(parametro);
			if(mensaje != null){
				mensajeFinal = mensaje;
			}
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarDatosLargaDistancia(parametro);
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarMinutosLdi():start");
				resultado = minutosLdiDTOService.consultarMinutosLDI(parametro);
				logger.debug("consultarMinutosLdi():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 **/
				respuesta = new RespuestaDTO();
				resultado = new MinutosLdiResponseDTO();
				respuesta.setCodigoError(-10044);
				respuesta.setMensajeError(mensajeFinal);
				respuesta.setNumeroEvento(0);
				resultado.setRespuesta(respuesta);
			}
		} catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
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
	public ConsRenovacionDTO consultarDatosRenovacion(NumeroTelefonoDTO parametro) throws IntegracionGTEException {
		AbonadoDTOService abonadoDTOService = new AbonadoDTOServiceImpl();
		ConsRenovacionDTO resultado;
		ValidaParametros validaParametro = new ValidaParametros();
		String  mensaje = null; 
		String  mensajeFinal = null;
		String  mensajeAuditoria = null;
		try {
			UtilLog.setLog(config.getString("IntegracionGTEEJB.log"));
			logger.debug("validaParametro.consultarDatosRenovacion():start");
			   mensaje = validaParametro.consultarDatosRenovacion(parametro);
			logger.debug("validaParametro.consultarDatosRenovacion():end");
			if(mensaje != null){
				mensajeFinal = mensaje;
			}	
			//Validar Auditoria
			logger.debug("validaParametro.validarAuditoria:start");
			mensajeAuditoria = validaParametro.validarAuditoria(parametro.getAuditoria());
			logger.debug("ValidaParametro.validarAuditoria:end");
			if(mensajeAuditoria != null){
				mensajeFinal = mensajeAuditoria;
			}	
			if((mensaje == null)&&(mensajeAuditoria == null)){
				logger.debug("consultarDatosRenovacion():start");
				resultado = abonadoDTOService.consultarDatosRenovacion(parametro);
				logger.debug("consultarDatosRenovacion():end");
			}else{
				/*
				 * se comienza a construir el mensaje de error por no pasar la validaciones
				 * */
				resultado = new ConsRenovacionDTO();
				RespuestaDTO  nuevaValidacion = new RespuestaDTO();
				nuevaValidacion.setCodigoError(-10044);
				nuevaValidacion.setMensajeError(mensajeFinal);
				nuevaValidacion.setNumeroEvento(0);
				resultado.setRespuesta(nuevaValidacion);
			}
			
		}catch (IntegracionGTEException e) {
			logger.debug("IntegracionGTEException[", e);
			e.setMessage(global.getValor("error.ejb.general"));
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			IntegracionGTEException nuevo = new IntegracionGTEException();
			nuevo.setMessage(e.getMessage());
			throw new IntegracionGTEException(global.getValor("error.ejb.general"),nuevo);
		}
		return resultado;
	}	
}