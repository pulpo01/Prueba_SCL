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
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.session.AvisoDeSiniestroFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.bean.ejb.session.AvisoDeSiniestroFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.common.dataTransfertObject.RegistraAvisoDeSiniestroActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;


public class AvisoSiniestroBussinessDelegate {

	private static AvisoSiniestroBussinessDelegate instance = null;
	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(AvisoSiniestroBussinessDelegate.class);
	
//	 ------------------------------------------------------------------------------------------------------------------------	
	
	public static AvisoSiniestroBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new AvisoSiniestroBussinessDelegate();
		}
		return instance;
	}	

//	 ------------------------------------------------------------------------------------------------------------------------
	
	private AvisoDeSiniestroFacade getAvisoDeSiniestroFacade() throws CusIntManException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getAvisoDeSiniestroFacade():start");
		
		String jndi = global.getValor("jndi.AvisoDeSiniestroFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.AvisoDeSiniestroProvider");
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
		
		AvisoDeSiniestroFacadeHome facadeHome =
			(AvisoDeSiniestroFacadeHome) PortableRemoteObject.narrow(obj, AvisoDeSiniestroFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de AvisoDeSiniestroFacade...");
		AvisoDeSiniestroFacade facade = null;
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

		logger.debug("getAvisoDeSiniestroFacade():end");
		return facade;
	}
	
	
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws CusIntManException {
		MensajeRetornoDTO respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutaRestrccion():start");
		
		try {
			respuesta = getAvisoDeSiniestroFacade().ejecutaRestrccion(restricciones);
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
	
	
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws CusIntManException {
		
		SolicitudAvisoDeSiniestroDTO respuesta ;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("grabaAvisoDeSiniestro():start");
		
		try {
			respuesta = getAvisoDeSiniestroFacade().grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario, numeroDesvio);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("grabaAvisoDeSiniestro():end");

		return respuesta;
		
	}	// grabaAvisoDeSiniestro

//	 ------------------------------------------------------------------------------------
	
	
public void guardaMensajesError(HttpServletRequest request, String mensajeTitulo, String mensajeDescriptivo )		{
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
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

public BodegaDTO[] obtenerBodegas(SesionDTO session) throws CusIntManException {
	BodegaDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerBodegas():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerBodegas(session);
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

// ------------------------------------------------------------------------------------	

public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String actAbo) throws CusIntManException {

	CausaSiniestroDTO[] respuesta ;

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerCausasSiniestro():start");
	
	try {
		respuesta = getAvisoDeSiniestroFacade().obtenerCausasSiniestro(usuarioAbonado, actAbo);
	}catch(ProductException e){
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("CusIntManException[" + loge + "]");
		throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	} catch (RemoteException e) {
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + loge + "]");
		throw new CusIntManException(e);
	}

	logger.debug("obtenerCausasSiniestro():end");

	return respuesta;
	
}	// obtenerCausasSiniestro

// ------------------------------------------------------------------------------------	

public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws CusIntManException {
	CentralDTO[] resultado = null;

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerCentralTecnologiaHlr():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerCentralTecnologiaHlr(serie, tecnologia);
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

// ------------------------------------------------------------------------------------	

public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws CusIntManException {
	CuotaDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerCuotas():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerCuotas(sesion, modalidadPago);
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

// ------------------------------------------------------------------------------------


public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws Exception{
	AbonadoDTO resultado = null;
	String log = global.getValor("web.log");
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerDatosAbonado():start");
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerDatosAbonado(abonado);
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

// ------------------------------------------------------------------------------------	

public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws Exception{
	
	ClienteDTO resultado = null;
	String log = global.getValor("web.log");
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerDatosCliente():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerDatosCliente(cliente);
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

// ------------------------------------------------------------------------------------	


public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws Exception{
	UsuarioAbonadoDTO resultado = null;
	String log = global.getValor("web.log");
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerDatosAbonado():start");
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerDatosUsuarioAbonado(usuarioAbonado);
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


// ------------------------------------------------------------------------------------	

public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws CusIntManException {

	UsuarioSistemaDTO respuesta = null;

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerInformacionUsuario():start");
	
	try {
		respuesta = getAvisoDeSiniestroFacade().obtenerInformacionUsuario(usuarioSistema);
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

// ------------------------------------------------------------------------------------	

public MesesProrrogasDTO[] obtenerMesesProrroga () throws CusIntManException {
	MesesProrrogasDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerMesesProrroga():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerMesesProrroga();
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

// ------------------------------------------------------------------------------------

public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws CusIntManException{
	ModalidadPagoDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerModalidadPago():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerModalidadPago(Sesion, CausaCamSerie);
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

// ------------------------------------------------------------------------------------


public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws CusIntManException{
	ModalidadPagoDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerModalidadPagoSimcard():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
	}catch(ProductException e){
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("CusIntManException[" + loge + "]");
		throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	} catch (RemoteException e) {
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + loge + "]");
		throw new CusIntManException(e);
	}
	logger.debug("obtenerModalidadPagoSimcard():end");

	return resultado;
	
}	// obtenerModalidadPagoSimcard

// ------------------------------------------------------------------------------------
public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws CusIntManException {
	TipoDeContratoDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerTiposDeContrato():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerTiposDeContrato(sessionDTO);
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

// ------------------------------------------------------------------------------------
public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {

	TipoSiniestroDTO[] respuesta;

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerTiposDeSiniestros():start");
	
	try {
		respuesta = getAvisoDeSiniestroFacade().obtenerTiposDeSiniestros(usuarioAbonado);
	}catch(ProductException e){
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("CusIntManException[" + loge + "]");
		throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	} catch (RemoteException e) {
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + loge + "]");
		throw new CusIntManException(e);
	}

	logger.debug("obtenerTiposDeSiniestros():end");

	return respuesta;
	
}	// obtenerTiposDeSiniestros

// ------------------------------------------------------------------------------------	

public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws CusIntManException {

	TipoSuspencionDTO[] respuesta ;

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerTiposDeSuspencion():start");
	
	try {
		respuesta = getAvisoDeSiniestroFacade().obtenerTiposDeSuspencion();
	}catch(ProductException e){
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("CusIntManException[" + loge + "]");
		throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
	} catch (RemoteException e) {
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + loge + "]");
		throw new CusIntManException(e);
	}

	logger.debug("obtenerTiposDeSuspencion():end");

	return respuesta;
	
}	// obtenerTiposDeSiniestros

// ------------------------------------------------------------------------------------	
public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws CusIntManException {
	TipoTerminalDTO[] resultado = null;
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("obtenerTipoTerminal():start");
	
	try {
		resultado = getAvisoDeSiniestroFacade().obtenerTipoTerminal(tecnologia);
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

// ------------------------------------------------------------------------------------
public String parametrosRestriccion(String codActuacion, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, ClienteOSSesionDTO sessionData)	{
	
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("parametrosRestriccionAviso():start");
	
	// Corregido
	// Para anulacion y aviso no viene el nro de serie, si para simcard, este metodo es distinto para ese caso
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
    				"|" + 												// nro Serie 21
    				"|" + global.getValor("MODULO") +					// codigo de modulo22
    				"|99999" +											// numero ID 23
    				"|"	+												// codigo de central 24
    				"|"	+ usuarioSistema.getNom_usuario() +    		    // nombre de usuario 25
    				"|"	+ usuarioSistema.getCod_tipcomis() +			// codigo tipo comisionista
    				"|";		
	
    logger.debug("parametrosRestriccionAviso():end");
    
    return parametros;
    
}	// parametrosRestriccionAviso

// ------------------------------------------------------------------------------------
public void reservaSimcard (String accionProceso,
		SerieDTO serie, 
		UsuarioSistemaDTO usuarioSistema, 
		UsuarioAbonadoDTO usuarioAbonado, 
		ClienteOSSesionDTO sessionData,
		CausaCamSerieDTO causa,
		TipoTerminalDTO terminal,
		ModalidadPagoDTO modalidadPago) throws CusIntManException {

String log = global.getValor("web.log");

log=System.getProperty("user.dir")+ log;
PropertyConfigurator.configure(log);		
logger.debug("reservaSimcard():start");

try {
// 1-
// Seteo los objetos para armar el string de parametros

// Armo el string con todos los parametros separados con pipes
String actAvisoSin = global.getValor("MODULO");
String parametros = parametrosRestriccion(actAvisoSin, usuarioSistema, usuarioAbonado, sessionData);

getAvisoDeSiniestroFacade().reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago);
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

}	// reservaSimcard

//------------------------------------------------------------------------------------	

public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws CusIntManException {
	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
	logger.debug("validaCausaCamSerie():start");
	
	try {
		getAvisoDeSiniestroFacade().validaCausaCamSerie(sesion, causaCamSerie);
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

// ------------------------------------------------------------------------------------

//Verifica si las restricciones se cumplieron y si no es asi, entonces devuelve un mensaje 
public String verificaEjecucionRestrccion(MensajeRetornoDTO mensaje)	{
	
	String textoMensaje = new String();

	String log = global.getValor("web.log");
	
	log=System.getProperty("user.dir")+ log;
	PropertyConfigurator.configure(log);		
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
	
}	
// verificaEjecucionRestrccion


	public void registrarAvisoDeSiniestroAction(RegistraAvisoDeSiniestroActionDTO  regAviSinActDTO )throws GeneralException {
		logger.debug("registrarCambioSimcardAction():start");
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			getAvisoDeSiniestroFacade().registrarOOSSAvisoSiniestro(regAviSinActDTO);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("registrarCambioSimcardAction():end");
	}
// ------------------------------------------------------------------------------------


	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan)  throws GeneralException {
	
		logger.debug("validarCambioPlanPendiente():start");
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		CambioPlanPendienteDTO retorno = null;
		
		try {
			logger.debug("validarCambioPlanPendiente:antes");
			retorno = getAvisoDeSiniestroFacade().validarCambioPlanPendiente(cambioPlan);
			logger.debug("validarCambioPlanPendiente:despues");
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("validarCambioPlanPendiente():end");
		return retorno;		
	}
// ------------------------------------------------------------------------------------


	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerOperadoraLocal():start");
		OperadoraLocalDTO retValue=null;
		
		try{
			retValue = getAvisoDeSiniestroFacade().obtenerOperadoraLocal();
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
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL 
	public String verificaNumeroDesviado( String numeroDesviado) throws GeneralException{	
		logger.debug("verificaNumeroDesviado():start");
		String validacionNumero;
		
		try{
			validacionNumero = getAvisoDeSiniestroFacade().verificaNumeroDesviado(numeroDesviado);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		logger.debug("verificaNumeroDesviado():start");
		return validacionNumero;
	}
	
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL 
}
