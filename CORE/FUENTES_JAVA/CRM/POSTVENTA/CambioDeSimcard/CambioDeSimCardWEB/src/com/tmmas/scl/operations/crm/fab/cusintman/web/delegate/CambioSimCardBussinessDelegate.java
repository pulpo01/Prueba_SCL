package com.tmmas.scl.operations.crm.fab.cusintman.web.delegate;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
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
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.bean.ejb.session.CamSimCarFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.bean.ejb.session.CamSimCarFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.common.dataTransferObject.RegistraCambioDeSimcardActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;


public class CambioSimCardBussinessDelegate {

	private static CambioSimCardBussinessDelegate instance = null;
	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(CambioSimCardBussinessDelegate.class);
	private FacadeMaker facadeMaker = FacadeMaker.getInstance();
//	 ------------------------------------------------------------------------------------------------------------------------	
	
	public static CambioSimCardBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new CambioSimCardBussinessDelegate();
		}
		return instance;
	}	

//	 ------------------------------------------------------------------------------------------------------------------------
	
	private CamSimCarFacade getCamSimCarFacade() throws CusIntManException {
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/
		
		logger.debug("getCamSimCarFacade():start");
		
		String jndi = global.getValor("jndi.CamSimCarFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.CamSimCarProvider");
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
			throw new CusIntManException(e.getMessage(), e.getCause());
		}
		
		CamSimCarFacadeHome facadeHome =
			(CamSimCarFacadeHome) PortableRemoteObject.narrow(obj, CamSimCarFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de CamSimCarFacade...");
		CamSimCarFacade facade = null;
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

		logger.debug("getCamSimCarFacade():end");
		return facade;
	}	
	
// ------------------------------------------------------------------------------------
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws Exception{
		AbonadoDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getCamSimCarFacade().obtenerDatosAbonado(abonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerDatosAbonado():end");
		return resultado;
		
	}

//	 ------------------------------------------------------------------------------------	


	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws Exception{
		UsuarioAbonadoDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/
		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getCamSimCarFacade().obtenerDatosUsuarioAbonado(usuarioAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerDatosAbonado():end");
		return resultado;
		
	}


//	 ------------------------------------------------------------------------------------	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws Exception{
	
		ClienteDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerDatosCliente():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerDatosCliente(cliente);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerDatosCliente():end");
		return resultado;
		
	}	// obtenerDatosCliente

//	 ------------------------------------------------------------------------------------	
	public BodegaDTO[] obtenerBodegas(SesionDTO session) throws CusIntManException {
		BodegaDTO[] resultado = null;
		
		String log = global.getValor("web.log");
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/
		
		try {
			resultado = getCamSimCarFacade().obtenerBodegas(session);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerBodegas():end");
		return resultado;
		
	}	// obtenerBodegas

//	 ------------------------------------------------------------------------------------	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie() throws CusIntManException {
		CausaCamSerieDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerCausaCambioSerie():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerCausaCambioSerie();
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerCausaCambioSerie():end");
		return resultado;
		
	}	// obtenerCausaCambioSerie

//	 ------------------------------------------------------------------------------------	
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws CusIntManException {
		TipoDeContratoDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerTiposDeContrato():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerTiposDeContrato(sessionDTO);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerTiposDeContrato():end");
		return resultado;
		
	}	// obtenerTiposDeContrato
	
//	 ------------------------------------------------------------------------------------

	public MesesProrrogasDTO[] obtenerMesesProrroga () throws CusIntManException {
		MesesProrrogasDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerMesesProrroga():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerMesesProrroga();
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerMesesProrroga():end");
		return resultado;
		
	}	// obtenerMesesProrroga

//	 ------------------------------------------------------------------------------------

	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws CusIntManException{
		ModalidadPagoDTO[] resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerModalidadPago():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerModalidadPago(Sesion, CausaCamSerie);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerModalidadPago():end");

		return resultado;
		
	}	// obtenerModalidadPago

//	 ------------------------------------------------------------------------------------

	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws CusIntManException{
		ModalidadPagoDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerModalidadPagoSimcard():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CamSimCarException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerModalidadPagoSimcard():end");

		return resultado;
		
	}	// obtenerModalidadPagoSimcard

//	 ------------------------------------------------------------------------------------

	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws CusIntManException {
		TipoTerminalDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerTipoTerminal():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerTipoTerminal(tecnologia);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerTipoTerminal():end");

		return resultado;
		
	}	// obtenerMesesProrroga

//	 ------------------------------------------------------------------------------------
	
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws CusIntManException {
		CuotaDTO[] resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerCuotas():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerCuotas(sesion, modalidadPago);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerCuotas():end");

		return resultado;
		
	}	// obtenerCuotas

//	 ------------------------------------------------------------------------------------

	public UsosVentaDTO[] obtenerUsosVenta () throws CusIntManException {
		UsosVentaDTO[] resultado = null;
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerUsosVenta():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerUsosVenta();
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerUsosVenta():end");

		return resultado;
		
	}	// obtenerUsosVenta

//	 ------------------------------------------------------------------------------------	

	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws CusIntManException {
		CentralDTO[] resultado = null;

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerCentralTecnologiaHlr():start");
		
		try {
			resultado = getCamSimCarFacade().obtenerCentralTecnologiaHlr(serie, tecnologia);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerCentralTecnologiaHlr():end");

		return resultado;
		
	}	// obtenerUsosVenta

//	 ------------------------------------------------------------------------------------	

	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws CusIntManException {
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("validaCausaCamSerie():start");
		
		try {
			getCamSimCarFacade().validaCausaCamSerie(sesion, causaCamSerie);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("validaCausaCamSerie():end");

		
	}	// validaCausaCamSerie

//	 ------------------------------------------------------------------------------------	

	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws CusIntManException {
		MensajeRetornoDTO respuesta = null;

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("ejecutaRestrccion():start");
		
		try {
			respuesta = getCamSimCarFacade().ejecutaRestrccion(restricciones);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("ejecutaRestrccion():end");

		return respuesta;
		
	}	// ejecutaRestrccion

//	 ------------------------------------------------------------------------------------	

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws CusIntManException {

		UsuarioSistemaDTO respuesta = null;

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerInformacionUsuario():start");
		
		try {
			respuesta = getCamSimCarFacade().obtenerInformacionUsuario(usuarioSistema);
		}catch(AplicationException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("obtenerInformacionUsuario():end");

		return respuesta;
		
	}	// ejecutaRestrccion

//	 ------------------------------------------------------------------------------------	

	public String parametrosRestriccion(String nroSerie, String codActuacion, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, ClienteOSSesionDTO sessionData)	{
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("parametrosRestriccionAviso():start");
		
		
		// Corregido
		String parametros = new String();
	    parametros = 	"|" + global.getValor("codigoPrograma") + 			// codigo del programa 1
	    				"|" + global.getValor("versionPrograma") +      	// version del programa 2
	    				"|" +	  											// proceso 3
	    				"|" + codActuacion +										// actuacion 4 
	    				"|" + usuarioAbonado.getNum_abonado() +				// numero abonado 5
	    				"|" + usuarioAbonado.getCod_cliente() +				// codigo del cliente 6
	    				"|" +												// cod mod gener 7
	    				"|" +												// codigo de venta 8
	    				"|" + sessionData.getCodOrdenServicio()  +	 		// codigo orden de servicio 9		
	    				"|" + usuarioSistema.getCod_vendedor() +			// codigo de vendedor 10
	    				"|" + 												// descripcion ss 11
	    				"|" + 												// codigo plan tarifario D 12
	    				"|" +												// codigo de uso 13
	    				"|" +												// codigo cuenta orig 14
	    				"|" +												// cod cuenta des 15
	    				"|" +												// cod cliente des 16
	    				"|" +												// cod tip plan tarif 17
	    				"|" +												// cod tip plan tarif D 18
	    				"|" +												// codigo de ciclo 19
	    				"|" +												// codigo fecha de sistema 20
	    				"|" + nroSerie +									// nro Serie 21
	    				"|" + global.getValor("MODULO") +					// codigo de modulo22
	    				"|99999" +											// numero ID 23
	    				"|"	+												// codigo de central 24
	    				"|"	+ usuarioSistema.getNom_usuario() +    		    // nombre de usuario 25
	    				"|"	+ usuarioSistema.getCod_tipcomis() +			// codigo tipo comisionista
	    				"|";	
		
	    logger.debug("parametrosRestriccionAviso():end");
	    
	    return parametros;
	    
	}	// parametrosRestriccionAviso

//	 ------------------------------------------------------------------------------------

	// Verifica si las restricciones se cumplieron y si no es asi, entonces devuelve un mensaje 
	public String verificaEjecucionRestrccion(MensajeRetornoDTO mensaje)	{
		
		String textoMensaje = new String();

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("verificaEjecucionRestrccion():start");
		
		  // Primero valido rapido si existe al menos una restriccion que no haya pasado
	    boolean flagOK = true;
    	if 	((mensaje.getMensaje() !=  null) && 
    		(!(mensaje.getMensaje().toUpperCase().equals("OK"))))
	    		flagOK = false;
	    
	    // Si se complieron todas las restricciones
	    if (flagOK)
	    	return "OK";
	    else
	    	// Busco cuales no se cumplieron y las agrego al mensaje de error a devolver.
	    	if 	((mensaje.getMensaje() !=  null) && 
	    		(!(mensaje.getMensaje().toUpperCase().equals("OK"))))
	    			textoMensaje = textoMensaje + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + mensaje.getMensaje() + "<BR>";
   
	    logger.debug("verificaEjecucionRestrccion():end");
	    
		return textoMensaje;
		
	}	// verificaEjecucionRestrccion
	
//	 ------------------------------------------------------------------------------------
	
	public void guardaMensajesError(HttpServletRequest request, String mensajeTitulo, String mensajeDescriptivo )		{
		
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("guardaMensajesError():start");
		
		mensajeTitulo = mensajeTitulo.replaceAll("\n", "<BR>");
		mensajeTitulo = mensajeTitulo.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

		mensajeDescriptivo = mensajeDescriptivo.replaceAll("\n", "<BR>");
		mensajeDescriptivo = mensajeDescriptivo.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		
		request.setAttribute("tituloError", mensajeTitulo);
    	request.setAttribute("descripcionError", mensajeDescriptivo);
    	
    	logger.debug("guardaMensajesError():end");
		
	}	// redirectErrorPage

//	 ------------------------------------------------------------------------------------------------------------------------

	public SerieDTO reservaSimcard (String accionProceso,
								SerieDTO serie, 
								UsuarioSistemaDTO usuarioSistema, 
								UsuarioAbonadoDTO usuarioAbonado, 
								ClienteOSSesionDTO sessionData,
								CausaCamSerieDTO causa,
								TipoTerminalDTO terminal,
								ModalidadPagoDTO modalidadPago) throws CusIntManException {
	  
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("reservaSimcard():start");
		
		SerieDTO infoserie=null;
		try {
			// 1-
			// Seteo los objetos para armar el string de parametros
			
		    // Armo el string con todos los parametros separados con pipes
			String actAvisoSin = global.getValor("MODULO");
		    String parametros = parametrosRestriccion(serie.getNum_serie(), actAvisoSin, usuarioSistema, usuarioAbonado, sessionData);
		
		    infoserie = getCamSimCarFacade().reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago);
		}
		catch(ProductException e)	{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} 
		catch(CustomerException e)	{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} 
		catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("reservaSimcard():end");
		return infoserie;
		
	}	// reservaSimcard

//	 ------------------------------------------------------------------------------------	

	
//	 ------------------------------------------------------------------------------------	
	
	public SerieDTO recInfoSerie (SerieDTO serie) throws CusIntManException {

		SerieDTO respuesta  = null;

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("recInfoSerie():start");
		
		try {
			respuesta = getCamSimCarFacade().recInfoSerie(serie);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("recInfoSerie():end");

		return respuesta;
		
	}	// recInfoSerie

//	 ------------------------------------------------------------------------------------	
	/***
	 * @author rlozano
	 * @description Funcionalidades obtenidas del FrmkOOSS
	 */
	
	/**
	 * Aceptar presupuesto
	 * 
	 * @param presup
	 * @return RetornoDTO
	 * @throws GeneralException
	 */
	
	
//	Fachada del Framework de OOSS
	/*private FrmkOOSSFacade getFrmkOOSSFacade() throws GeneralException {
		String log = global.getValor("web.log");
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
		String log = global.getValor("web.log");
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
	}*/
	
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws GeneralException{
		RetornoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("aceptarPresupuesto():start");
		try {
			retorno = getCamSimCarFacade().aceptarPresupuesto(presup);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("aceptarPresupuesto():end");
		return retorno;		
	}
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = getCamSimCarFacade().registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[",e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			logger.debug("Exception[",e);
			throw new GeneralException(e);
		}		
		return respuesta;
	}
	
		
	
	
	
	/**
	 * Construir registro de cargos
	 * 
	 * @param cargos
	 * @return RegCargosDTO
	 * @throws CusIntManException
	 */
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO cargos) throws GeneralException{
		RegCargosDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("construirRegistroCargos():start");
		try {
			retorno = getCamSimCarFacade().construirRegistroCargos(cargos);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("construirRegistroCargos():end");
		return retorno;		
	}	
	
	
	/**
	 * Obtiene plan comercial
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws CusIntManException
	 */
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException{
		logger.debug("obtenerPlanComercial():start");
		
		ClienteDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/	
		try {
			logger.debug("obtenerPlanComercial:antes");
			retorno = getCamSimCarFacade().obtenerPlanComercial(cliente);
			logger.debug("obtenerPlanComercial:despues");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerPlanComercial():end");
		return retorno;		
	}
	
	/**
	 * Obtiene datos del vendedor
	 * 
	 * @param usuario
	 * @return UsuarioDTO
	 * @throws GeneralException
	 */
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GeneralException{	
	
		UsuarioDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerVendedor():start");
		try {
			resultado = getCamSimCarFacade().obtenerVendedor(usuario);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw e;
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Obtiene información del vendedor
	 * 
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws CusIntManException
	 */
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GeneralException{
		logger.debug("obtenerVendedor():start");
		
		VendedorDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerVendedor(vendedor);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Registrar cargos
	 * 
	 * @param cargos
	 * @return ResultadoRegCargosDTO
	 * @throws GeneralException
	 */
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws GeneralException{
		ResultadoRegCargosDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/	
		logger.debug("parametrosRegistrarCargos():start");
		try {
			retorno = getCamSimCarFacade().parametrosRegistrarCargos(cargos);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("parametrosRegistrarCargos():end");
		return retorno;		
	}	
	
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws GeneralException{
		CartaGeneralDTO retorno = null;

		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerTextoCarta():start");
		try {			
			retorno = getCamSimCarFacade().obtenerTextoCarta(cartaGeneral);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Obtiene secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws ProyectoException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws CusIntManException{	
	
		SecuenciaDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerSecuencia():start");
		try {
			resultado = getCamSimCarFacade().obtenerSecuencia(parametro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerSecuencia():end");
		return resultado;
	}
	
	/**
	 * Obtiene cargos
	 * 
	 * @param parametrosCargos
	 * @return ParametrosObtencionCargosDTO
	 * @throws GeneralException
	 */
	public ObtencionCargosDTO obtencionCargos(ParametrosObtencionCargosDTO parametrosCargos) throws GeneralException{	
	
		ObtencionCargosDTO resultado = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtencionCargos():start");
		try {
			resultado = getCamSimCarFacade().obtencionCargos(parametrosCargos);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtencionCargos():end");
		return resultado;
	}
	
	/**
	 * eliminar Presupuesto
	 * 
	 * @param parametrosCargos
	 * @return ParametrosObtencionCargosDTO
	 * @throws GeneralException
	 */
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GeneralException{
		RetornoDTO retorno= null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("eliminarPresupuesto():start");
		try {
			retorno = getCamSimCarFacade().eliminarPresupuesto(registro);
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("eliminarPresupuesto[" + loge + "]");
			throw new CusIntManException(e);
		}
		
		logger.debug("eliminarSolicitud():end");
		return retorno;
	}
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException{
		logger.debug("obtenerTipoContrato():start");
		
		ContratoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerTipoContrato(contrato);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Obtiene modalidad de pago
	 * 
	 * @param modalidad
	 * @return ModalidadPagoDTO
	 * @throws GeneralException
	 */
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException{
		logger.debug("obtenerModalidadPago():start");
		
		ModalidadPagoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerModalidadPago(modalidad);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerModalidadPago():end");
		return retorno;		
	}
	
	/**
	 * Obtiene detalle del presupuesto
	 * 
	 * @param presup
	 * @return PresupuestoDTO
	 * @throws CusIntManException
	 */
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GeneralException{
		logger.debug("obtenerDetallePresupuesto():start");
		
		PresupuestoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerDetallePresupuesto(presup);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDetallePresupuesto():end");
		return retorno;		
	}
	
	public void cierreVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		logger.debug("cierreVenta():start");
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			getCamSimCarFacade().cierreVenta(gaVentasDTO);
		} catch (FrmkCargosException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException("Se ha producido un error en el módulo de cargos.", e.getCause(), e.getCodigo(), e.getCodigoEvento(), "Se ha producido un error en el módulo de cargos.");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("cierreVenta():end");
	}
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws GeneralException{
		RetornoDTO retorno= null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("eliminarSolicitud():start");
		try {
			retorno = getCamSimCarFacade().eliminarSolicitud(registro);
		} catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("AppPriDisRebException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		
		logger.debug("eliminarSolicitud():end");
		return retorno;
	}
	
	/**
	 * Inserta solicitud de autorización de descuento, para cargos que exceden el máximo
	 * descuento permitido
	 * @param registro
	 * @return
	 * @throws GeneralException
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro) throws GeneralException{	
		RespuestaSolicitudDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("solicitarAprobacionDescuento():start");
		try {
			retorno = getCamSimCarFacade().solicitarAprobacionDescuento(registro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("solicitarAprobacionDescuento():end");
		return retorno;		
	}
	/**
	 * Consulta estado de solicitud de autorización de descuento
	 * @param registro
	 * @return
	 * @throws GeneralException
	 */
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro)	 throws GeneralException{	
		RegistroSolicitudDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("consultarEstadoSolicitud():start");
		try {
			retorno = getCamSimCarFacade().consultarEstadoSolicitud(registro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("consultarEstadoSolicitud():end");
		return retorno;		
	}
	
	/**
	 * Consulta estado facturado
	 * 
	 * @param consultarEstadoFacturado
	 * @return RetornoDTO
	 * @throws GeneralException
	 */
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws GeneralException{
		logger.debug("consultarEstadoFacturado():start");
		
		RetornoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().consultarEstadoFacturado(numProceso);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
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
	 * Obtiene la ruta de una factura
	 * 
	 * @param factura
	 * @return ArchivoFacturaDTO
	 * @throws GeneralException
	 */
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws GeneralException{
		logger.debug("consultarEstadoFacturado():start");
		
		ArchivoFacturaDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerRutaFactura(factura);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
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
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO parametro) throws GeneralException{
		logger.debug("obtenerParametroGeneral():start");
		ParametroDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerParametroGeneral(parametro);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
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
	 * Registrar venta
	 * 
	 * @param venta
	 * @return RetornoDTO
	 * @throws CusIntManException
	 */
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws GeneralException{
		RetornoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("registrarVenta():start");
		try {
			retorno = getCamSimCarFacade().registrarVenta(venta);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Obtiene información de descuentos asociada a los privilegios de un vendedor
	 * @param vendedor
	 * @return
	 * @throws GeneralException
	 */
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor)throws GeneralException{
		DescuentoVendedorDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/	
		logger.debug("obtenerDescuentoVendedor():start");
		try {
			retorno = getCamSimCarFacade().obtenerDescuentoVendedor(vendedor);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw e;
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
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
	
	public DocumentoListDTO obtenerTiposDocumento(BusquedaTiposDocumentoDTO tipoDocumento) throws GeneralException{
		DocumentoListDTO documentoList = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerTiposDocumento():start");
			try {
				documentoList = getCamSimCarFacade().obtenerTiposDocumento(tipoDocumento);
			} catch (GeneralException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManColException[" + loge + "]");
				throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + loge + "]");
				throw new CusIntManException(e);
			}
		logger.debug("obtenerTiposDocumento():end");
		return documentoList;
	}
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws GeneralException{
		CuotasProductoDTO[] cuotasProducto = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		logger.debug("obtenerCuotasProducto():start");
			try {
				cuotasProducto = getCamSimCarFacade().obtenerCuotasProducto();
			} catch (GeneralException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("ManColException[" + loge + "]");
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
	 * Inserta concepto descuento en ga_transacabo
	 * 
	 * @param desc
	 * @return RetornoDTO
	 * @throws CusIntManException
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException{
		logger.debug("insertarConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().insertarConceptoDescuento(desc);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Obtiene concepto descuento de ga_transacabo
	 * 
	 * @param param
	 * @return DescuentoDTO
	 * @throws CusIntManException
	 */
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO param) throws GeneralException{
		logger.debug("obtenerCodConceptoDescuento():start");
		
		DescuentoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().obtenerCodConceptoDescuento(param);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
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
	 * Elimina concepto descuento de ga_transacabo
	 * 
	 * @param numTransaccion
	 * @return RetornoDTO
	 * @throws GeneralException
	 */
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GeneralException{
		logger.debug("eliminaCodConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			retorno = getCamSimCarFacade().eliminaCodConceptoDescuento(numTransaccion);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("eliminaCodConceptoDescuento():end");
		return retorno;		
	}	
	
public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO formaPago) throws GeneralException{
		
		FormaPagoListDTO formaPagoList = null;
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/	
		logger.debug("obtenerFromasPago():start");
			try {
				formaPagoList = getCamSimCarFacade().obtenerFormasPago(formaPago);
			} catch (GeneralException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("GeneralException[" + loge + "]");
				throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			} catch (RemoteException e) {
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("GeneralException[" + loge + "]");
				throw new CusIntManException(e);
			}
		logger.debug("obtenerFromasPago():end");
		
		return formaPagoList;
	}

	public void registrarCambioSimcardAction(RegistraCambioDeSimcardActionDTO regCmbSmdActDTO)throws GeneralException{
		logger.debug("registrarCambioSimcardAction():start");
		/*
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/		
		try {
			logger.debug("registrarOOSSCambioSimcard:antes");
			CamSimCarFacade facade = getCamSimCarFacade();
			logger.debug("antes registrarOOSSCambioSimcard");
			facade.registrarOOSSCambioSimcard(regCmbSmdActDTO);
			logger.debug("registrarOOSSCambioSimcard:despues");
			
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);			
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);			
			logger.debug("RemoteException[" + loge + "]");			
			throw new GeneralException(e);
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);			
			logger.debug("Exception[" + loge + "]");			
			throw new GeneralException(e);		
	}
		logger.debug("registrarCambioSimcardAction():end");
	}
	
	public com.tmmas.scl.vendedor.dto.VendedorDTO recuperarInformacionVendedor(com.tmmas.scl.vendedor.dto.VendedorDTO vendedor) throws VendedorException  {
	String log = global.getValor("web.log");
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);
	logger.debug("recuperarInformacionVendedor():start");
	logger.debug("getVendedorFacade:antes");
	VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
	logger.debug("getVendedorFacade:despues");
	com.tmmas.scl.vendedor.dto.VendedorDTO resultado = null;
	try {
		logger.debug("recuperarInformacionVendedor():antes");
		resultado = facade.recuperarInformacionVendedor(vendedor);
		logger.debug("recuperarInformacionVendedor():despues");
	} catch (Exception e) {
		logger.debug("Exception", e);
		throw new VendedorException(e);			
	}
	logger.debug("recuperarInformacionVendedor():end");
	return resultado;
}	
	
//	 ------------------------------------------------------------------------------------	
	public SimcardDTO obtenerSimcard (SimcardDTO simcardDTO) throws CusIntManException {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSimcard():start");
		
		try {
			simcardDTO = getCamSimCarFacade().obtenerSimcard(simcardDTO);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerSimcard():end");

		return simcardDTO;
		
	}
	
	public SerieDTO desReservaSerie(SerieDTO inValue)throws CusIntManException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("des_reservaSerie():start");
		SerieDTO retValue=null;
		String accionProceso="";
		try{
			retValue = getCamSimCarFacade().reservaSimcard(accionProceso, inValue, null, null, null, null, null, null);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("des_reservaSerie():end");
		return retValue;
	}
	
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO inValue)throws CusIntManException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getCategoriaPlanTarifario():start");
		PlanTarifarioDTO retValue=null;
		
		try{
			retValue = getCamSimCarFacade().getCategoriaPlanTarifario(inValue);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("getPlanTarifarioDefault():end");
		return retValue;
	}
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerOperadoraLocal():start");
		OperadoraLocalDTO retValue=null;
		
		try{
			retValue = getCamSimCarFacade().obtenerOperadoraLocal();
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerOperadoraLocal():end");
		return retValue;
	}
	
	public BodegaDTO[] getBodegasXVendedor(BodegaDTO entrada) throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getBodegasXVendedor():start");
		BodegaDTO[] retorno = null;
		try {
			retorno = getCamSimCarFacade().getBodegasXVendedor(entrada);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("getBodegasXVendedor():end");
		return retorno;
	}		

	public ArticuloInDTO[] getArticulos(ArticuloInDTO entrada) throws GeneralException{
		logger.debug("getArticulos():start");
		ArticuloInDTO[] retorno = null;
		try {
			retorno = getCamSimCarFacade().getArticulos(entrada);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("getArticulos():end");
		return retorno;
	}	

	public SerieDTO[] buscarSerie (SerieDTO serie) throws GeneralException{
		logger.debug("buscarSerie():start");
		SerieDTO[] retorno = null;
		try {
			retorno = getCamSimCarFacade().buscarSeries(serie); 
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("buscarSerie():end");
		return retorno;
	}
	
	public SerieDTO[] listarSerie(SerieDTO entrada) throws GeneralException{
		logger.debug("listarSerie():start");
		SerieDTO[] retorno = null;
		try {
			retorno = getCamSimCarFacade().listarSerie(entrada);
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("listarSerie():end");
		return retorno;
	}	
	
	public RetornoDTO validaSerieExterna (SerieDTO serie) throws GeneralException{
		logger.debug("validaSerieExterna():start");
		RetornoDTO retorno = null;
		try {
			retorno = getCamSimCarFacade().validaSerieExterna(serie); 
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("validaSerieExterna():end");
		return retorno;
	}

	public DatosCentralDTO obtenerDatosCentral(int codCentral)  throws GeneralException{
		logger.debug("obtenerDatosCentral():start");
		DatosCentralDTO retorno = null;
		try {
			retorno = getCamSimCarFacade().obtenerDatosCentral(codCentral); 
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("obtenerDatosCentral():end");
		return retorno;
	}
	
	
}	// CambioSimCardBussinessDelegate
