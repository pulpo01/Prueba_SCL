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
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.helper.ParsearGeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.bean.ejb.session.SuspVolFacade;
import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.bean.ejb.session.SuspVolFacadeHome;
import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.common.dataTransfertObject.RegistraSuspVoluntariaDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.SuspensionVoluntariaForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class SuspensionVoluntariaBussinessDelegate {

	private static SuspensionVoluntariaBussinessDelegate instance = null;
	private Global global = Global.getInstance();
	private static Logger logger = Logger.getLogger(SuspensionVoluntariaBussinessDelegate.class);
	
//	 --------------------------------------------------------------------------------------------------------------------------------	
	
	public static SuspensionVoluntariaBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new SuspensionVoluntariaBussinessDelegate();
		}
		return instance;
	}	

//	 --------------------------------------------------------------------------------------------------------------------------------
	
	private SuspVolFacade getSuspVolFacade() throws CusIntManException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("getSuspVolFacade():start");
		
		String jndi = global.getValor("jndi.SuspVolFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = global.getValor("url.SuspVolProvider");
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
		
		SuspVolFacadeHome facadeHome =
			(SuspVolFacadeHome) PortableRemoteObject.narrow(obj, SuspVolFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de SuspVolFacade...");
		SuspVolFacade facade = null;
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

		logger.debug("getSuspVolFacade():end");
		return facade;
		
	}	// getSuspVolFacade
	
//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws Exception{
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getSuspVolFacade().obtenerDatosAbonado(abonado);
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
		
	} // obtenerDatosAbonado

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws Exception{
		UsuarioAbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado():start");
		try {
			resultado = getSuspVolFacade().obtenerDatosUsuarioAbonado(usuarioAbonado);
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
		
	}  // obtenerDatosAbonado

//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws Exception{
	
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCliente():start");
		
		try {
			resultado = getSuspVolFacade().obtenerDatosCliente(cliente);
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

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws CusIntManException {

		UsuarioSistemaDTO respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerInformacionUsuario():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerInformacionUsuario(usuarioSistema);
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

//	 --------------------------------------------------------------------------------------------------------------------------------	

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

//	 --------------------------------------------------------------------------------------------------------------------------------

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

	
//	 --------------------------------------------------------------------------------------------------------------------------------
	
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
		
	}	// guardaMensajesError
	
//	 --------------------------------------------------------------------------------------------------------------------------------

	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws CusIntManException {
		MensajeRetornoDTO respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("ejecutaRestrccion():start");
		
		try {
			respuesta = getSuspVolFacade().ejecutaRestrccion(restricciones);
		}catch(ProductException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("ejecutaRestrccion():end");

		return respuesta;
		
	}	// ejecutaRestrccion

//	 --------------------------------------------------------------------------------------------------------------------------------	

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
	
//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public CausasSuspensionDTO[] obtenerCausasSuspension() throws  ProductException {

		CausasSuspensionDTO[]  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCausasSuspension():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerCausasSuspension();
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("obtenerCausasSuspension():end");

		return respuesta;
		
	}	// obtenerCausasSuspension

//	 --------------------------------------------------------------------------------------------------------------------------------	
	
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin ) throws ProductException {

		SuspensionAbonadoDTO[]  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSuspensionesHistoricasAbonado():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerSuspensionesHistoricasAbonado(numAbonado, fecIni, fecFin);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("obtenerSuspensionesHistoricasAbonado():end");

		return respuesta;
		
	}	// obtenerSuspensionesHistoricasAbonado

//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {

		SuspensionAbonadoDTO[]  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSuspensionesAbonado():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerSuspensionesAbonado(usuarioAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("obtenerSuspensionesAbonado():end");

		return respuesta;
		
	}	// obtenerSuspensionesAbonado

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException {

		FechasSuspensionDTO[]  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("recuperarFechasSuspension():start");
		
		try {
			respuesta = getSuspVolFacade().recuperarFechasSuspension(sessionData);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("recuperarFechasSuspension():end");

		return respuesta;
		
	}	// recuperarFechasSuspension

//	 --------------------------------------------------------------------------------------------------------------------------------	
	
	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException  {

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("programarSuspension():start");
		
		try {
			getSuspVolFacade().programarSuspension(suspensionAbonado, sessionData);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("programarSuspension():end");
	
	}	// programarSuspension

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException  {

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("modificarSuspension():start");
		
		try {
			getSuspVolFacade().modificarSuspension(suspensionAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("modificarSuspension():end");
	
	}	// modificarSuspension

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException  {

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("anularSuspension():start");
		
		try {
			getSuspVolFacade().anularSuspension(suspensionAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("anularSuspension():end");
	
	}	// modificarSuspension

//	 --------------------------------------------------------------------------------------------------------------------------------	

	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException	{
		
		DatosGeneralesSuspensionDTO  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosGeneralesSuspension():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerDatosGeneralesSuspension();
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("obtenerDatosGeneralesSuspension():end");

		return respuesta;
		
	} // obtenerDatosGeneralesSuspension
	
//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{
		
		PeriodoSuspencionAbonadoDTO[]  respuesta = null;

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerPeriodosSuspensioAbonado():start");
		
		try {
			respuesta = getSuspVolFacade().obtenerPeriodosSuspensioAbonado(usuarioAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}

		logger.debug("obtenerPeriodosSuspensioAbonado():end");

		return respuesta;
		
	} // obtenerPeriodosSuspensioAbonado
	
//	 --------------------------------------------------------------------------------------------------------------------------------

	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspensionAbonado) throws ProductException	{
		
		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("agregaPeriodoSuspension():start");
		
		try {
			getSuspVolFacade().agregaPeriodoSuspension(periodoSuspensionAbonado);
		}catch(CusIntManException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new ProductException(e);
		}
	
		logger.debug("agregaPeriodoSuspension():end");
	
	}	// agregaPeriodoSuspension

// --------------------------------------------------------------------------------------------------------------------------------	

	public void registrarSuspensionVoluntaria(RegistraSuspVoluntariaDTO registraDTO)  throws GeneralException	{

		String log = global.getValor("web.log");
		
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarSuspensionVoluntaria():start");
		
		try {
			getSuspVolFacade().registrarSuspensionVoluntaria(registraDTO);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new CusIntManException(e);
		}

		logger.debug("registrarSuspensionVoluntaria():end");
	
	} // registrarSuspensionVoluntaria
	
//	 --------------------------------------------------------------------------------------------------------------------------------
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException{
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerOperadoraLocal():start");
		OperadoraLocalDTO retValue=null;
		
		try{
			retValue = getSuspVolFacade().obtenerOperadoraLocal();
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
//	 --------------------------------------------------------------------------------------------------------------------------------
}	// SuspensionVoluntariaBussinessDelegate

