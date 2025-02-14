package com.tmmas.scl.operations.crm.fab.cusintman.web.delegate;

import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.bean.ejb.session.AnuSinFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.bean.ejb.session.AnuSinFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.common.dataTransfertObject.RegistrarAnulacionSiniestroDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;


public class AnulacionSiniestroBussinessDelegate {

	private static AnulacionSiniestroBussinessDelegate instance = null;
	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(AnulacionSiniestroBussinessDelegate.class);
	
//	 ------------------------------------------------------------------------------------------------------------------------	
	
	public static AnulacionSiniestroBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new AnulacionSiniestroBussinessDelegate();
		}
		return instance;
	}	

//	 ------------------------------------------------------------------------------------------------------------------------
	
	private AnuSinFacade getAnuSinFacade() throws CusIntManException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getAnuSinFacade():start");
		
		String jndi = global.getValor("jndi.AnuSinFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.AnuSinProvider");
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
		
		AnuSinFacadeHome facadeHome =
			(AnuSinFacadeHome) PortableRemoteObject.narrow(obj, AnuSinFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de ManConFacade...");
		AnuSinFacade facade = null;
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
			resultado = getAnuSinFacade().obtenerDatosAbonado(abonado);
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
			resultado = getAnuSinFacade().obtenerDatosUsuarioAbonado(usuarioAbonado);
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
			resultado = getAnuSinFacade().obtenerDatosCliente(cliente);
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
			resultado = getAnuSinFacade().obtenerBodegas(session);
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCausaCambioSerie():start");
		
		try {
			resultado = getAnuSinFacade().obtenerCausaCambioSerie();
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
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDeContrato():start");
		
		try {
			resultado = getAnuSinFacade().obtenerTiposDeContrato(sessionDTO);
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
			resultado = getAnuSinFacade().obtenerMesesProrroga();
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
			resultado = getAnuSinFacade().obtenerModalidadPago(Sesion, CausaCamSerie);
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
			resultado = getAnuSinFacade().obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
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
			resultado = getAnuSinFacade().obtenerTipoTerminal(tecnologia);
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
			resultado = getAnuSinFacade().obtenerCuotas(sesion, modalidadPago);
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
			resultado = getAnuSinFacade().obtenerCentralTecnologiaHlr(serie, tecnologia);
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
			getAnuSinFacade().validaCausaCamSerie(sesion, causaCamSerie);
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

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutaRestrccion():start");
		
		try {
			respuesta = getAnuSinFacade().ejecutaRestrccion(restricciones);
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

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInformacionUsuario():start");
		
		try {
			respuesta = getAnuSinFacade().obtenerInformacionUsuario(usuarioSistema);
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
    	/**/
    	int codCiclo;
    	String fechaSistema;
    	//fechaHoraBaseDatos = cstmt.getTimestamp(1);//2009-04-08 14:37:53 YYYY-MM-DD HH24:MI:SS
    												 //2008-10-13:14:28:56
    	String formatoFecha = "dd-MM-yyyy";//"yyyy-MM-dd:HH:mm:ss";
 
    	if (sessionData.getNumAbonado() != 0){
    		codCiclo = sessionData.getAbonados()[0].getCodCiclo();
    		logger.debug("X abonado codCiclo ["+codCiclo+"]");
    	}else
    	{
    		codCiclo = sessionData.getCliente().getCodCiclo();
    		logger.debug("X cliente codCiclo ["+codCiclo+"]");
    		
    	}
    	
    	
		Date fecha = new Date();
		Timestamp fechaActual = new Timestamp(fecha.getTime());
    	fechaSistema = fechaActual.toString();
    	logger.debug("fechaSistema       ["+fechaSistema+"]");
    	
    	SimpleDateFormat sdf = new SimpleDateFormat(formatoFecha);
    	fechaSistema = sdf.format(fecha);
    	logger.debug("fechaSistema       ["+fechaSistema+"]");
    	
    	
		//param.setFechaDesde(Formatting.getFecha(form1.getFecDesdeLlam(), "dd-MM-yyyy"));
		//param.setFecDesdeLlamTS(Timestamp.valueOf(Formatting.dateTime(param.getFechaDesde(),"yyyy-MM-dd")+" 00:00:00.000000000"));
    	/**/
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
	    				"|" +	codCiclo	+								// codigo de ciclo 19
	    				"|" +	fechaSistema+								// codigo fecha de sistema 20
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
    	{
    			logger.debug("Error al Validar restricciones mensaje:["+mensaje.getMensaje()+"]");
    			flagOK = false;
    	}
	    
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
		
		    getAnuSinFacade().reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, parametros, causa, terminal, modalidadPago);
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

	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {
		SiniestrosDTO[] respuesta = null;
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("recDatosSiniestroAboando():start");
		
		try {
			respuesta = getAnuSinFacade().recDatosSiniestroAboando(usuarioAbonado);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("recDatosSiniestroAboando():end");

		return respuesta;
		
	}	// recDatosSiniestroAboando

//	 ------------------------------------------------------------------------------------		

	/*public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException{
		SSuplementarioDTO[] respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerServiciosContratados():start");
		
		try {
			//respuesta = getAnuSinFacade().obtenerServiciosContratados(usuarioAbonado);
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
		
	}	*/// obtenerServiciosContratados

//	 ------------------------------------------------------------------------------------
//	 ------------------------------------------------------------------------------------		

	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws CusIntManException {

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("anulaSinistroAbonado():start");
		
		try {
			getAnuSinFacade().anulaSinistroAbonado(Siniestros, usuarioAbonado, sesion);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("anulaSinistroAbonado():end");
		
	}	// anulaSinistroAbonado
	
	public RetornoDTO RegistrarAnulacionSiniestroAction(RegistrarAnulacionSiniestroDTO regAnuSinDTO)throws GeneralException{
		
		String log = global.getValor("web.log");
		RetornoDTO retValue=null;
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("RegistrarAnulacionSiniestroAction():start");
		
		try {
			retValue=getAnuSinFacade().registrarAnulacionSiniestroAction(regAnuSinDTO);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage());
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

		logger.debug("RegistrarAnulacionSiniestroAction():end");
		return retValue;
	}

	//Incluido santiago ventura 23-03-2010	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrosGeneralesDTO)throws GeneralException{
		
		String log = global.getValor("web.log");
		ParametrosGeneralesDTO retValue=null;
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("getParametroGeneral():start");
		
		try {
			retValue=getAnuSinFacade().getParametroGeneral(parametrosGeneralesDTO);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw new GeneralException(e.getMessage());
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

		logger.debug("getParametroGeneral():end");
		return retValue;
	}

}	// AnulacionSiniestroBussinessDelegate
