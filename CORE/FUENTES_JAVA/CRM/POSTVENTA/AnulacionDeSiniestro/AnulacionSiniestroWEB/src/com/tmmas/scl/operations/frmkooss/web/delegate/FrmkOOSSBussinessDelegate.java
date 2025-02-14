/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 3/12/2007	     	Daniel Sagredo        				Versión Inicial
 * 
 */
package com.tmmas.scl.operations.frmkooss.web.delegate;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
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
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
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
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public class FrmkOOSSBussinessDelegate {

	private static FrmkOOSSBussinessDelegate instance = null;
	private static Logger logger = Logger.getLogger(FrmkOOSSBussinessDelegate.class);
	private Global global = Global.getInstance();
	
	protected ServiceLocator svcLologgeror = ServiceLocator.getInstance();

	public static FrmkOOSSBussinessDelegate getInstance() {
		if (instance == null) {
			instance = new FrmkOOSSBussinessDelegate();
		}
		return instance;
	}	
	
	//Fachada del Framework de OOSS
	private FrmkOOSSFacade getFrmkOOSSFacade() throws GeneralException {
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerSecuencia():start");
		try {
			resultado = getFrmkOOSSFacade().obtenerSecuencia(parametro);
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
	public FormaPagoListDTO obtenerFromasPago(BusquedaFormasPagoDTO formaPago) throws GeneralException{
		
		FormaPagoListDTO formaPagoList = null;
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerFromasPago():start");
			try {
				formaPagoList = getFrmkOOSSFacade().obtenerFormasPago(formaPago);
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
	
	public DocumentoListDTO obtenerTiposDocumento(BusquedaTiposDocumentoDTO tipoDocumento) throws GeneralException{
		DocumentoListDTO documentoList = null;
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTiposDocumento():start");
			try {
				documentoList = getFrmkOOSSFacade().obtenerTiposDocumentos(tipoDocumento);
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
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws GeneralException{
		RetornoDTO retorno= null;
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarSolicitud():start");
		try {
			retorno = getFrmkOOSSFacade().eliminarSolicitud(registro);
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
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GeneralException{
		RetornoDTO retorno= null;
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarPresupuesto():start");
		try {
			retorno = getFrmkOOSSFacade().eliminarPresupuesto(registro);
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
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws GeneralException{
		CuotasProductoDTO[] cuotasProducto = null;
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotasProducto():start");
			try {
				cuotasProducto = getFrmkOOSSFacade().obtenerCuotasProducto();
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
	 * Obtiene cargos
	 * 
	 * @param parametrosCargos
	 * @return ParametrosObtencionCargosDTO
	 * @throws GeneralException
	 */
	public ObtencionCargosDTO obtencionCargos(ParametrosObtencionCargosDTO parametrosCargos) throws GeneralException{	
	
		ObtencionCargosDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtencionCargos():start");
		try {
			resultado = getFrmkCargosFacade().obtenerCargos(parametrosCargos);
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
	 * Obtiene datos del vendedor
	 * 
	 * @param usuario
	 * @return UsuarioDTO
	 * @throws GeneralException
	 */
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GeneralException{	
	
		UsuarioDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerVendedor():start");
		try {
			resultado = getFrmkOOSSFacade().obtenerVendedor(usuario);
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
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws GeneralException{
		CartaGeneralDTO retorno = null;

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTextoCarta():start");
		try {			
			retorno = getFrmkOOSSFacade().obtenerTextoCarta(cartaGeneral);
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
	 * Obtiene información de descuentos asociada a los privilegios de un vendedor
	 * @param vendedor
	 * @return
	 * @throws GeneralException
	 */
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor)throws GeneralException{
		DescuentoVendedorDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDescuentoVendedor():start");
		try {
			retorno = getFrmkOOSSFacade().obtenerDescuentoVendedor(vendedor);
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
	
	/**
	 * Inserta solicitud de autorización de descuento, para cargos que exceden el máximo
	 * descuento permitido
	 * @param registro
	 * @return
	 * @throws GeneralException
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro) throws GeneralException{	
		RespuestaSolicitudDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("solicitarAprobacionDescuento():start");
		try {
			retorno = getFrmkOOSSFacade().solicitarAprobacionDescuento(registro);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("consultarEstadoSolicitud():start");
		try {
			retorno = getFrmkOOSSFacade().consultarEstadoSolicitud(registro);
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
	 * Construir registro de cargos
	 * 
	 * @param cargos
	 * @return RegCargosDTO
	 * @throws CusIntManException
	 */
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO cargos) throws GeneralException{
		RegCargosDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("construirRegistroCargos():start");
		try {
			retorno = getFrmkCargosFacade().construirRegistroCargos(cargos);
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
	 * Registrar cargos
	 * 
	 * @param cargos
	 * @return ResultadoRegCargosDTO
	 * @throws GeneralException
	 */
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws GeneralException{
		ResultadoRegCargosDTO retorno = null;
		String log = global.getValor("web.log");
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
	 * Registrar venta
	 * 
	 * @param venta
	 * @return RetornoDTO
	 * @throws CusIntManException
	 */
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws GeneralException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("registrarVenta():start");
		try {
			retorno = getFrmkOOSSFacade().registrarVenta(venta);
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
	 * Aceptar presupuesto
	 * 
	 * @param presup
	 * @return RetornoDTO
	 * @throws GeneralException
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws GeneralException{
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("aceptarPresupuesto():start");
		try {
			retorno = getFrmkOOSSFacade().aceptarPresupuesto(presup);
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
	
	/**
	 * Obtiene tipo de contrato
	 * 
	 * @param contrato
	 * @return ContratoDTO
	 * @throws GeneralException
	 */
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException{
		logger.debug("obtenerTipoContrato():start");
		
		ContratoDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerTipoContrato(contrato);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerModalidadPago(modalidad);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerDetallePresupuesto(presup);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerVendedor(vendedor);
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
	 * Inserta concepto descuento en ga_transacabo
	 * 
	 * @param desc
	 * @return RetornoDTO
	 * @throws CusIntManException
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException{
		logger.debug("insertarConceptoDescuento():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().insertarConceptoDescuento(desc);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerCodConceptoDescuento(param);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().eliminaCodConceptoDescuento(numTransaccion);
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
	
	/**
	 * Obtiene plan comercial
	 * 
	 * @param cliente
	 * @return ClienteDTO
	 * @throws CusIntManException
	 */
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException{
		logger.debug("obtenerVendedor():start");
		
		ClienteDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerPlanComercial(cliente);
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
	 * Consulta estado facturado
	 * 
	 * @param consultarEstadoFacturado
	 * @return RetornoDTO
	 * @throws GeneralException
	 */
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws GeneralException{
		logger.debug("consultarEstadoFacturado():start");
		
		RetornoDTO retorno = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().consultarEstadoFacturado(numProceso);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerRutaFactura(factura);
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
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			retorno = getFrmkOOSSFacade().obtenerParametroGeneral(parametro);
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
 
	public void cierreVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		logger.debug("cierreVenta():start");
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		try {
			getFrmkCargosFacade().cierreVenta(gaVentasDTO);
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
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException {
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarOOSSEnLinea():start");
			respuesta = getFrmkOOSSFacade().registrarOOSSEnLinea(registro);
			logger.debug("registrarOOSSEnLinea():end");
		} catch (GeneralException e) {
			logger.debug("CustomerOrderException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (RemoteException e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return respuesta;
	}
	
	/**
	 * Incluido por santiago ventura 21-04-2010 
	 */	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws Exception{
		AbonadoDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosAbonado2():start");
		try {
			resultado = getFrmkOOSSFacade().obtenerDatosAbonado2(abonado);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosAbonado2():end");
		return resultado;
		
	}

	// ------------------------------------------------------------------------------------	

	/**
	 * Incluido por santiago ventura 21-04-2010 
	 */
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws Exception{
		
		ClienteDTO resultado = null;
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerDatosCliente():start");
		
		try {
			resultado = getFrmkOOSSFacade().obtenerDatosCliente(cliente);
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + loge + "]");
			throw e;
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosCliente():end");
		return resultado;
		
	}	// obtenerDatosCliente
	
}
