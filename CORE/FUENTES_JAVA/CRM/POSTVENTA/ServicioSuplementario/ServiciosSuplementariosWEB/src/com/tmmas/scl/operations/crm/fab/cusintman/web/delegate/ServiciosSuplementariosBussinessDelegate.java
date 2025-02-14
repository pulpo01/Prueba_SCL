package com.tmmas.scl.operations.crm.fab.cusintman.web.delegate;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO; 
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacade;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeroRangoAjaxDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RegistroVentaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularRangoDTO;
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
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.helper.ParsearGeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;

import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.helper.FacadeMaker;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.session.SerSupFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.bean.ejb.session.SerSupFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.NumeroAjaxDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.RegistraServSuplemtDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.RetornoValorDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.BuscaNumeroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;


public class ServiciosSuplementariosBussinessDelegate {

	private static ServiciosSuplementariosBussinessDelegate instance = null;
	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(ServiciosSuplementariosBussinessDelegate.class);
	private FrmkOOSSBussinessDelegate delegateOOSS = FrmkOOSSBussinessDelegate.getInstance();
	
	private FacadeMaker facadeMaker = FacadeMaker.getInstance();
	
//	 ------------------------------------------------------------------------------------------------------------------------	
	
	public static ServiciosSuplementariosBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new ServiciosSuplementariosBussinessDelegate();
		}
		return instance;
	}	

//	 ------------------------------------------------------------------------------------------------------------------------

	private SerSupFacade getSerSupFacade() throws CusIntManException {
	
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getSerSupFacade():start");
		
		String jndi = global.getValor("jndi.SerSupFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SerSupProvider");
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
		
		SerSupFacadeHome facadeHome =
			(SerSupFacadeHome) PortableRemoteObject.narrow(obj, SerSupFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManConFacade...");
		SerSupFacade facade = null;
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

		logger.debug("getManConFacade():end");
		return facade;
	}	
	
// ------------------------------------------------------------------------------------
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws Exception{
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getSerSupFacade().obtenerDatosAbonado(abonado);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getSerSupFacade().obtenerDatosUsuarioAbonado(usuarioAbonado);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCliente():start");
		
		try {
			resultado = getSerSupFacade().obtenerDatosCliente(cliente);
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
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerBodegas():start");
		
		try {
			resultado = getSerSupFacade().obtenerBodegas(session);
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
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws CusIntManException {
		TipoDeContratoDTO[] resultado = null;
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDeContrato():start");
		
		try {
			resultado = getSerSupFacade().obtenerTiposDeContrato(sessionDTO);
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerMesesProrroga():start");
		
		try {
			resultado = getSerSupFacade().obtenerMesesProrroga();
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerModalidadPago():start");
		
		try {
			resultado = getSerSupFacade().obtenerModalidadPago(Sesion, CausaCamSerie);
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerModalidadPagoSimcard():start");
		
		try {
			resultado = getSerSupFacade().obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
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

//	 ------------------------------------------------------------------------------------

	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws CusIntManException {
		TipoTerminalDTO[] resultado = null;
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTipoTerminal():start");
		
		try {
			resultado = getSerSupFacade().obtenerTipoTerminal(tecnologia);
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotas():start");
		
		try {
			resultado = getSerSupFacade().obtenerCuotas(sesion, modalidadPago);
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

	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws CusIntManException {
		CentralDTO[] resultado = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCentralTecnologiaHlr():start");
		
		try {
			resultado = getSerSupFacade().obtenerCentralTecnologiaHlr(serie, tecnologia);
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
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("validaCausaCamSerie():start");
		
		try {
			getSerSupFacade().validaCausaCamSerie(sesion, causaCamSerie);
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

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws CusIntManException {

		UsuarioSistemaDTO respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInformacionUsuario():start");
		
		try {
			respuesta = getSerSupFacade().obtenerInformacionUsuario(usuarioSistema);
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

	public String parametrosRestriccion(String codActuacion, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, ClienteOSSesionDTO sessionData)	{
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("parametrosRestriccionAviso():start");
		
		String parametros = new String();
	    parametros = 	"|" + global.getValor("codigoPrograma") + 			// codigo del programa
	    				"|" + global.getValor("versionPrograma") + "|" +	// version del programa
	    				"|" +	  											// proceso
	    				codActuacion +										// actuacion
	    				"|" + usuarioAbonado.getNum_abonado() +				// numero abonado
	    				"|" + usuarioAbonado.getCod_cliente() +				// codigo del cliente
	    				"|" +												// cod mod gener
	    				"|" +												// codigo de venta
	    				"|" + sessionData.getCodOrdenServicio()  +	 		// codigo orden de servicio		
	    				"|" + usuarioSistema.getCod_vendedor() +			// codigo de vendedor
	    				"|" + 												// descripcion ss
	    				"|" + 												// codigo plan tarifario D
	    				"|" +												// codigo de uso
	    				"|" +												// codigo cuenta orig
	    				"|" +												// cod cuenta des
	    				"|" +												// cod cliente des
	    				"|" +												// cod tip plan tarif
	    				"|" +												// cod tip plan tarif D
	    				"|" +												// codigo de ciclo
	    				"|" +												// codigo fecha de sistema
	    				"|" +												// restriccion aux
	    				global.getValor("MODULO") +							// codigo de modulo
	    				"|99999" +											// numero ID
	    				"|"	+												// codigo de central
	    				usuarioSistema.getNom_usuario() + "|" +				// nombre de usuario
	    				usuarioSistema.getCod_tipcomis() + "|";				// codigo tipo comisionista	
		
	    logger.debug("parametrosRestriccionAviso():end");
	    
	    return parametros;
	    
	}	// parametrosRestriccionAviso

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

	
	public void guardaMensajesError(HttpServletRequest request,  String mensajeTitulo, Exception e  )		{
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("guardaMensajesError():start");
		String mensajeDescriptivo = ""; 
		ParsearGeneralException parsear = new ParsearGeneralException(e);
		GeneralException ge = parsear.getGeneralExceptionAttributesNested();
		if (ge != null ) {
			logger.debug("GeneralException parseado no nulo");
			mensajeDescriptivo = ge.getDescripcionEvento();
		}
		else {
			logger.debug("GeneralException parseado nulo");
			mensajeDescriptivo = global.getValor("mensaje.error.generico");
		}
		logger.debug("mensajeDescriptivo[" + mensajeDescriptivo + "]");
		mensajeTitulo = mensajeTitulo.replaceAll("\n", "<BR>");
		mensajeTitulo = mensajeTitulo.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

		mensajeDescriptivo = mensajeDescriptivo.replaceAll("\n", "<BR>");
		mensajeDescriptivo = mensajeDescriptivo.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		
		request.setAttribute("tituloError", mensajeTitulo);
    	request.setAttribute("descripcionError", mensajeDescriptivo);
    	
    	logger.debug("guardaMensajesError():end");
		
	}	
//	 ------------------------------------------------------------------------------------------------------------------------

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
		
		    getSerSupFacade().reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago);
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

//	 ------------------------------------------------------------------------------------	

	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws CusIntManException{
		SSuplementarioDTO[] respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerServiciosContratados():start");
		
		try {
			respuesta = getSerSupFacade().obtenerServiciosContratados(usuarioAbonado, opcion);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("obtenerServiciosContratados():end");

		return respuesta;
		
	}	// obtenerServiciosContratados

//	 ------------------------------------------------------------------------------------		

	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws CusIntManException{

		SSuplementarioDTO[] respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerServiciosDisplonibles():start");
		
		try {
			respuesta = getSerSupFacade().obtenerServiciosDisplonibles(usuarioAbonado, sesion);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("obtenerServiciosDisplonibles():end");

		return respuesta;
		
	}	// obtenerServiciosDisplonibles

//	 ------------------------------------------------------------------------------------
	
	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws CusIntManException{

		ReglasSSDTO[] respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getReglasdeValidacionSS():start");
		
		try {
			respuesta = getSerSupFacade().getReglasdeValidacionSS(usuarioAbonado, abonado);
		}catch(CustomerException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("getReglasdeValidacionSS():end");

		return respuesta;
		
	}	// getReglasdeValidacionSS

//	 ------------------------------------------------------------------------------------

	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws CusIntManException {
		MensajeRetornoDTO respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutaRestrccion():start");
		
		try {
			respuesta = getSerSupFacade().ejecutaRestrccion(restricciones);
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

	// Verifica si las restricciones se cumplieron y si no es asi, entonces devuelve un mensaje 
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
		
	}	// verificaEjecucionRestrccion
	
//	 ------------------------------------------------------------------------------------
//	 Verifica si las restricciones se cumplieron y si no es asi, entonces devuelve un mensaje 
	public void registrarServiciosSuplementariosAction(RegistraServSuplemtDTO  regServSuplemDTO) throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarServiciosSuplemtariosAction():start");
		try {
			 getSerSupFacade().registrarServiciosSuplementariosAction(regServSuplemDTO);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		   
	    logger.debug("registrarServiciosSuplemtariosAction():end");
	}	// verificaEjecucionRestrccion
	
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
//	Verifica si esta activado para un abonado los servicios de blackberry
//	HGG 20/06/08
	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws Exception {
		
		SSuplementarioDTO[] resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getFlagBlackberryActivado():start");
		try {
			resultado = getSerSupFacade().getServiciosBBContratados(usuarioAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}
		   
	    logger.debug("getFlagBlackberryActivado():end");
	    return resultado;
	    	
	}	// getFlagBlackberryActivado
//	 ------------------------------------------------------------------------------------
	
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws CusIntManException {
		GaServSupDefDTO[] resultado = null;
	
	try{
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("blackberryActivado():start");
			resultado = getSerSupFacade().getObtieneListCodServPorDef(gaServSupDefDTO);
		logger.debug("blackberryActivado():end");
	} catch (Exception e) {
		logger.debug("Exception[", e);
		throw new CusIntManException(e);
	}

	return resultado;
	
} 
//	 ------------------------------------------------------------------------------------
	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws CusIntManException {
		GaServSuPlDTO resultado = null;
	try{
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("getEstadoCorreoServSupl():start");
			resultado = getSerSupFacade().getEstadoCorreoServSupl(gaServSuPlDTO);
		logger.debug("getEstadoCorreoServSupl():end");
	} catch (Exception e) {
		logger.debug("Exception[", e);
		throw new CusIntManException(e);
	}
	return resultado;
	
} 
//	 ------------------------------------------------------------------------------------
	
	public GaAboMailTODTO[] getAbomailTOxNumAbonado (GaAboMailTODTO gaAboMailTODTO)throws  CusIntManException{
		GaAboMailTODTO[] resultado = null;
		try{
			String log = global.getValor("web.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getAbomailTOxNumAbonado():start");
				resultado = getSerSupFacade().getAbomailTOxNumAbonado(gaAboMailTODTO);
			logger.debug("getAbomailTOxNumAbonado():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}

		return resultado;
	}
	
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws CusIntManException, RemoteException {
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retorno = null;
		try {
			retorno = getSerSupFacade().getParametroGeneral(entrada);
		} catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}		
		
		logger.debug("getParametroGeneral():end");
		return retorno;
	}
	
//	 ------------------------------------------------------------------------------------
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerOperadoraLocal():start");
		OperadoraLocalDTO retValue=null;
		
		try{
			retValue = getSerSupFacade().obtenerOperadoraLocal();
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
	
//	 ------------------------------------------------------------------------------------

	public void reponerNumeracion(String numCelular, String tabla, String codCateg, String codUsoFax, String codCentral) throws CusIntManException {
		
		logger.debug("reponerNumeracion:inicio()");
		RetornoValorDTO retorno = new RetornoValorDTO();
		
		try{
			DatosCentralDTO datosCentralDTO = getSerSupFacade().obtenerDatosCentral(Integer.valueOf(codCentral).intValue());
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNumCelular(new Long(numCelular));
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodCat(codCateg);
			numeracionCelularDTO.setCodUso(codUsoFax);
			numeracionCelularDTO.setCodSubALM(datosCentralDTO.getCod_subAlm());
			numeracionCelularDTO.setCodCentral(codCentral);

			logger.info("(DesReserva) Reponer Número Celular ");
			getSerSupFacade().reponerNumeracion(numeracionCelularDTO);
		}
		catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al reponer numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("reponerNumeracion:fin()");		

	} // reponerNumeracion
	
//	 ------------------------------------------------------------------------------------
	
	public void desReservaNumeroCelular(String numCelular, String tabla, String codCateg, String codUsoFax, String codCentral) throws CusIntManException {
		
		logger.debug("desReservaNumeroCelular:inicio()");
		RetornoValorDTO retorno = new RetornoValorDTO();
		
		try{
			DatosCentralDTO datosCentralDTO = getSerSupFacade().obtenerDatosCentral(Integer.valueOf(codCentral).intValue());
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNumCelular(new Long(numCelular));
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodCat(codCateg);
			numeracionCelularDTO.setCodUso(codUsoFax);
			numeracionCelularDTO.setCodSubALM(datosCentralDTO.getCod_subAlm());
			numeracionCelularDTO.setCodCentral(codCentral);

			logger.info("(DesReserva) Reponer Número Celular ");
			getSerSupFacade().desReservaNumeroCelular(numeracionCelularDTO);
		}
		catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al reponer numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("desReservaNumeroCelular:fin()");		

	} // desReservaNumeroCelular
	
//	 ------------------------------------------------------------------------------------

	public NumeroAjaxDTO[] obtenerNumeracionReservada(	com.tmmas.scl.vendedor.dto.VendedorDTO vendedor, 
																	ClienteOSSesionDTO sessionData, 
																	String codUsoFax, 
																	String codCentral, 
																	String cantMaxCel,
																	UsuarioSistemaDTO usuarioSistema) throws CusIntManException, RemoteException {
		
		logger.debug("obtenerNumeracionReservada:inicio()");

		SeleccionNumeroCelularDTO[] listaNumeros= null;
		NumeroAjaxDTO[] listaRetorno = null;
		try{
			DatosNumeracionDTO paramCategoria = new DatosNumeracionDTO();
			paramCategoria.setCodActabo(obtenerActuacion(sessionData.getAbonados()[0].getCodUso()));
			String codCateg = obtieneCategoria(paramCategoria);
			
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCliente(new Long(sessionData.getAbonados()[0].getCodCliente()));
			datosNumeracionDTO.setCodCodUsoNue(codUsoFax);
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodVendealer(new Long(0));
			
			// Si se mostró la seleccion de vendedor y es externo
			if (vendedor != null)
				if (!vendedor.isInd_interno())	{
					datosNumeracionDTO.setCodVendedor(new Long(vendedor.getCod_vendedor()));
					datosNumeracionDTO.setCodVendealer(new Long(vendedor.getCod_vendealer()));
				} // if
				else
					// Si se mostró la seleccion de vendedor y es interno
						datosNumeracionDTO.setCodVendedor(new Long(vendedor.getCod_vendedor()));
			else
				// Si NO mostró la seleccion de vendedor 
				datosNumeracionDTO.setCodVendedor(new Long(usuarioSistema.getCod_vendedor()));
			
			listaNumeros = getSerSupFacade().obtenerNumeracionReservada(datosNumeracionDTO);
			listaRetorno =  new NumeroAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroAjaxDTO numero = new NumeroAjaxDTO();
				numero.setNumCelular(String.valueOf(listaNumeros[i].getNumCelular()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				listaRetorno[i] = numero;
			}			
		} 
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("obtenerNumeracionReservada:fin()");
		return listaRetorno;
		
	} // obtieneNumeracionReutilizable	
	
	//	 ------------------------------------------------------------------------------------

	public NumeroAjaxDTO[] obtenerNumeracionReutilizable(	BuscaNumeroForm  buscaNumeroForm, 
																	ClienteOSSesionDTO sessionData, 
																	String codUsoFax, 
																	String codCentral, 
																	String cantMaxCel
																	) throws CusIntManException, RemoteException {
		
		logger.debug("obtenerNumeracionReutilizable:inicio()");

		SeleccionNumeroCelularDTO[] listaNumeros= null;
		NumeroAjaxDTO[] listaRetorno = null;
		try{
			
			String rangoInferior = buscaNumeroForm.getBusquedaRangoInf();
			String rangoSuperior = buscaNumeroForm.getBusquedaRangoSup();
			
			DatosNumeracionDTO paramCategoria = new DatosNumeracionDTO();
			paramCategoria.setCodActabo(obtenerActuacion(sessionData.getAbonados()[0].getCodUso()));
			String codCateg = obtieneCategoria(paramCategoria);
			
			DatosCentralDTO datosCentralDTO = getSerSupFacade().obtenerDatosCentral(Integer.valueOf(codCentral).intValue());
			
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCodCodUsoNue(codUsoFax);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			datosNumeracionDTO.setCodSubalmNue(datosCentralDTO.getCod_subAlm());
			datosNumeracionDTO.setLimiteInferior(new Long(rangoInferior));
			datosNumeracionDTO.setLimiteSuperior(new Long(rangoSuperior));			
			listaNumeros = getSerSupFacade().obtenerNumeracionReutilizable(datosNumeracionDTO);			
			
			listaRetorno =  new NumeroAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroAjaxDTO numero = new NumeroAjaxDTO();
				numero.setNumCelular(String.valueOf(listaNumeros[i].getNumCelular()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				numero.setFechaBaja(listaNumeros[i].getFechaBaja());
				listaRetorno[i] = numero;
			}
			
		} 
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("obtenerNumeracionReutilizable:fin()");
		return listaRetorno;
		
	} // obtenerNumeracionReutilizable	
	
	//	 ------------------------------------------------------------------------------------
	

	public NumeroRangoAjaxDTO[] obtenerNumeracionRango(	BuscaNumeroForm  buscaNumeroForm, 
																ClienteOSSesionDTO sessionData, 
																String codUsoFax, 
																String codCentral, 
																String cantMaxCel
																) throws CusIntManException, RemoteException {
		
		logger.debug("obtenerNumeracionRango:inicio()");

		NumeroRangoAjaxDTO[] listaRetorno = null;
		SeleccionNumeroCelularRangoDTO[] listaNumeros= null;
		try{

			String rangoInferior = buscaNumeroForm.getBusquedaRangoInf();
			String rangoSuperior = buscaNumeroForm.getBusquedaRangoSup();
	
			DatosNumeracionDTO paramCategoria = new DatosNumeracionDTO();
			paramCategoria.setCodActabo(obtenerActuacion(sessionData.getAbonados()[0].getCodUso()));
			String codCateg = obtieneCategoria(paramCategoria);
			
			DatosCentralDTO datosCentralDTO = getSerSupFacade().obtenerDatosCentral(Integer.valueOf(codCentral).intValue());
			
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCodCodUsoNue(codUsoFax);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			datosNumeracionDTO.setCodSubalmNue(datosCentralDTO.getCod_subAlm());
			datosNumeracionDTO.setLimiteInferior(new Long(rangoInferior));
			datosNumeracionDTO.setLimiteSuperior(new Long(rangoSuperior));			
			listaNumeros = getSerSupFacade().obtenerNumeracionRango(datosNumeracionDTO);			
			
			listaRetorno =  new NumeroRangoAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroRangoAjaxDTO numero = new NumeroRangoAjaxDTO();
				numero.setNumDesde(String.valueOf(listaNumeros[i].getNumDesde()));
				numero.setNumHasta(String.valueOf(listaNumeros[i].getNumHasta()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				listaRetorno[i] = numero;
			}
			
		} 
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("obtenerNumeracionRango:fin()");
		return listaRetorno;
		
	} // obtenerNumeracionRango	
	
	//	 ------------------------------------------------------------------------------------
	
	public NumeroAjaxDTO aceptaNumeracion(	HttpSession session,
											ClienteOSSesionDTO sessionData,			
											BuscaNumeroForm  buscaNumeroForm, 
											String codUsoFax, 
											String codCentral) throws CusIntManException, RemoteException {
		
		logger.debug("aceptaNumeracion:inicio()");
		NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
		UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
		
		try{
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");
			secuencia = delegateOOSS.obtenerSecuencia(secuencia);
			
			DatosCentralDTO datosCentralDTO = getSerSupFacade().obtenerDatosCentral(Integer.valueOf(codCentral).intValue());
			
			//(+)---- Anular ------------------ ->NumeroAnteriorRes
			if (!buscaNumeroForm.getNumeroAnteriorRes().equals("")){
				//Tabla anterior
				String tablaNumeroAnteriorRes  = "";
				String categoriaAnt = "";
				if (session.getAttribute("numeroSel")!=null) {
					tablaNumeroAnteriorRes = ((NumeroAjaxDTO)session.getAttribute("numeroSel")).getTablaNumeracion();
					categoriaAnt = ((NumeroAjaxDTO)session.getAttribute("numeroSel")).getCategoria();
				} // if
				
				logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
				reponerNumeracion(	buscaNumeroForm.getNumeroAnteriorRes(), 
									tablaNumeroAnteriorRes, 
									categoriaAnt, 
									codUsoFax,  
									codCentral);
				logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
				desReservaNumeroCelular( buscaNumeroForm.getNumeroAnteriorRes(), 
										tablaNumeroAnteriorRes, 
										categoriaAnt, 
										codUsoFax,  
										codCentral);
				//limpia variable
				buscaNumeroForm.setNumeroAnteriorRes("");
			}
			//(-)------------------------------------------
			
//			(+)------ Reservar ------------------------------------
			String tabla = "";
			String categoria = "";
			String fechaBaja = null;

			if (buscaNumeroForm.getTipoBusqueda().equals("M"))	{ //busqueda manual 
				String tipoLista = "N"; //numero
				if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reservados")))
					tabla  = global.getValor("consulta.numeracion.ga_reserva");
				else 
					if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables")))
						tabla  = global.getValor("consulta.numeracion.ga_celnum_reutil");
					else if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.rango")))	{
						tabla  = global.getValor("consulta.numeracion.ga_celnum_uso");
						tipoLista = "R";
					}
				
//				buscar categoria y fecha de baja
				if (tipoLista.equals("N"))	{
					NumeroAjaxDTO[] listaNumeros = (NumeroAjaxDTO[])session.getAttribute("listaNumeros");
					if (listaNumeros!=null)	{
						for(int i=0; i<listaNumeros.length;i++)	{
							if (listaNumeros[i].getNumCelular().equals(buscaNumeroForm.getNumeroSel()))	{
								categoria = listaNumeros[i].getCategoria();
								
								if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables"))){
									fechaBaja = listaNumeros[i].getFechaBaja();
								} // if
								
								break;
							} // if
						} // for
					}  // if
				}  // if
				else	{
					NumeroRangoAjaxDTO[] listaNumeros = (NumeroRangoAjaxDTO[])session.getAttribute("listaNumerosRango");
					if (listaNumeros!=null)	{					
						for(int i=0; i<listaNumeros.length;i++)	{
							if (listaNumeros[i].getNumDesde().equals(buscaNumeroForm.getRangoInfSel()))	{
								categoria = listaNumeros[i].getCategoria();
								break;
							} // if
						}  // for
					} // if
				} // else
			} // Busqueda manual
			else 
				if (buscaNumeroForm.getTipoBusqueda().equals("A"))	{ //busqueda automatica
					tabla  = buscaNumeroForm.getTablaNumeracionAut();
					categoria = buscaNumeroForm.getCategoria();
					fechaBaja = (buscaNumeroForm.getFechaBaja().equals("null")||buscaNumeroForm.getFechaBaja().equals(""))?null:buscaNumeroForm.getFechaBaja();
				} // if
			
			logger.debug("Aceptar->reserva->tabla="+tabla);
			logger.debug("Aceptar->reserva->categoria="+categoria);
			logger.debug("Aceptar->reserva->fechaBaja="+fechaBaja);
				
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setSecuencia(String.valueOf(secuencia.getNumSecuencia()));
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(datosCentralDTO.getCod_subAlm());
			numeracionCelularDTO.setCodCentral(String.valueOf(sessionData.getAbonados()[0].getCodCentral()));
			numeracionCelularDTO.setCodCat(categoria);
			numeracionCelularDTO.setCodUso(codUsoFax);
			numeracionCelularDTO.setCodProducto(new Long(1));
			numeracionCelularDTO.setNumCelular(new Long(buscaNumeroForm.getNumeroSel()));				

			//Paso 1
			if (buscaNumeroForm.getTipoBusqueda().equals("M")){
				logger.info("(Reserva) Ejecuta P_NUMERACION_MANUAL");
				getSerSupFacade().reservaNumeroCelular(numeracionCelularDTO);
			} // if
			
			//Paso 2
			String user = usuarioSistema.getNom_usuario();
			
			numeracionCelularDTO.setNumLinea(new Long("1"));
			numeracionCelularDTO.setNumOrden(new Long("1"));
			numeracionCelularDTO.setNomUsuarioSCL(user);
			numeracionCelularDTO.setIndProcNum(tabla);
			numeracionCelularDTO.setFecBaja(fechaBaja);
			logger.info("(Reserva) Inserta GA_RESNUMCEL");
			getSerSupFacade().insertarNumeroCelularReservado(numeracionCelularDTO);			

			//Dejar numero en sesion para cargarlo en Datos Linea
			numeroSel.setNumCelular(buscaNumeroForm.getNumeroSel());
			numeroSel.setTablaNumeracion(tabla);
			numeroSel.setCategoria(categoria);

			//actualiza variable
			buscaNumeroForm.setNumeroAnteriorRes(buscaNumeroForm.getNumeroSel());
		} 
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("aceptaNumeracion:fin()");
		
		return numeroSel;
		
	} // aceptaNumeracion	
	
	//	 ------------------------------------------------------------------------------------
		
	public String obtieneCategoria(DatosNumeracionDTO datosNumeracionVO) throws CusIntManException, RemoteException {
		
		logger.debug("reponerNumeracion:inicio()");
		String retorno = "";
		
		try{
			retorno = getSerSupFacade().obtieneCategoria(datosNumeracionVO);
			logger.info("(DesReserva) Reponer Número Celular ");
		}
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("reponerNumeracion:fin()");
		return retorno;

	} // reponerNumeracion
	
//	 ------------------------------------------------------------------------------------
		
	private String obtenerActuacion(String codUso) throws CusIntManException	{

		String codActuacion = "";
		logger.debug("obtenerActuacion:inicio()");

		if (codUso.equals(global.getValor("codigo.uso.hibrido"))){
			codActuacion=global.getValor("codigo.actuacion.hibrido");//HH
		} 
		else	{
			codActuacion=global.getValor("codigo.actuacion.pospago");//VO
		}

		logger.debug("obtenerActuacion:fin()");

		return codActuacion;

     } // obtenerActuacion

	//	 ------------------------------------------------------------------------------------
	
	public NumeroAjaxDTO[] obtieneNumeracionAutomatica(	ClienteOSSesionDTO sessionData, 
															String codUsoFax, 
															String codCentral) throws CusIntManException, RemoteException {
		
		logger.debug("obtieneNumeracionAutomaticav:inicio()");
		DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
		NumeroAjaxDTO[] listaRetorno = new NumeroAjaxDTO[1];		
		try{
			String codCelda = getSerSupFacade().obtenerCeldaAbonado(sessionData.getAbonados()[0].getNumAbonado());
			
			datosNumeracionDTO.setCodCodUsoNue(codUsoFax);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodActabo(obtenerActuacion(sessionData.getAbonados()[0].getCodUso()));
			datosNumeracionDTO.setCodCeldNue(codCelda);
			datosNumeracionDTO = getSerSupFacade().obtieneNumeracionAutomatica(datosNumeracionDTO);
			
			NumeroAjaxDTO numero = new NumeroAjaxDTO();
			numero.setNumCelular(String.valueOf(datosNumeracionDTO.getNumCelular()));
			numero.setFechaBaja(datosNumeracionDTO.getFecBaja());
			listaRetorno[0] = numero;
		} 
		catch (CusIntManException e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("obtieneNumeracionAutomatica:fin()");
		return listaRetorno;
		
	} // obtieneNumeracionAutomatica	
	
	//	 ------------------------------------------------------------------------------------


	public SSuplementarioDTO[] filtrarGrupoenSSDisponibles(SSuplementarioDTO[] srvServiciosAct,  SSuplementarioDTO[] srvServiciosDisp, String codGrupo) throws CusIntManException {

		SSuplementarioDTO[] retorno = null;
		
		try {
			logger.debug("obtieneNumeracionAutomaticav:inicio()");

			// Verificamos si hay algun servicio contratado con el grupo del parametro
			boolean flgSSContratado=false;
			for( int fila=0; fila < srvServiciosAct.length; fila++)
				if (!String.valueOf(srvServiciosAct[fila].getCod_servsupl()).equals(codGrupo)) {
					flgSSContratado = true;
					fila = srvServiciosAct.length;
				} // if
			
			// Si ya está contratado, no hay que mostrarlo en la lista y se elimina del array de disponibles
			if (flgSSContratado)	{
				ArrayList lista = new ArrayList();			
				for( int fila=0; fila < srvServiciosDisp.length; fila++)	
					if (!String.valueOf(srvServiciosDisp[fila].getCod_servsupl()).equals(codGrupo))	
						lista.add(srvServiciosDisp[fila]);
				
				// Ya tengo la lista filtrada, ahora la convierto en un array
				retorno = new SSuplementarioDTO[lista.size()];
				for( int fila=0; fila < lista.size(); fila++)
					retorno[fila] = (SSuplementarioDTO)lista.get(fila);
			} // if
			else
				retorno=srvServiciosDisp;

			logger.debug("filtrarGrupoenSSDisponibles():end");
		} catch (Exception e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause());
		}
		
		return retorno;
		
	} // filtrarGrupoenSSDisponibles
	
	
//	---------------------------------------------------------------------------------------------------------------	
	
}	// ServiciosSuplementariosBussinessDelegate

