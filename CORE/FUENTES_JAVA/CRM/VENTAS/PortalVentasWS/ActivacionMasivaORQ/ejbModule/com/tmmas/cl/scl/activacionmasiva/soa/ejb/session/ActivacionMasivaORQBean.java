/**
 * 
 */
package com.tmmas.cl.scl.activacionmasiva.soa.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ActivacionLineaOutDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoCOLDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CargoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ContratosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.FormadePagoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ListadoCeldaDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ListadoCentralDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ParametrosComercialesDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ParametrosComercialesINDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ParametrosSeleccionadosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.RegCargosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ResultadoAltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ResultadoRegCargosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.SolicitudAutorizacionDescuentoDTO;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTL;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTLHome;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanTarifarioComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RepresentanteLegalComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProgramaDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ClienteInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ClienteOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.DatCteClienteInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.DatCteClienteOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroResultadoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroVentaInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SimcardInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SimcardOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioActInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AgenteVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosMigracionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteCOLDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConceptoVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DependenciasModalidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoAfinidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosComercialesVendExtDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanIndemnizacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.Producto;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoComisionistaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TiposContratoListOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.SolScoringVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.LogisticaException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.TasacionException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CampanaVigente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FacturaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FormasPagoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametroDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroSolicitudesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioInDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.logistica.negocio.ejb.session.LogisticaFacadeSTL;
import com.tmmas.cl.scl.logistica.negocio.ejb.session.LogisticaFacadeSTLHome;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ParametrosGenerales;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacade;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacadeHome;
import com.tmmas.cl.scl.tasacion.negocio.ejb.session.TasacionFacadeSTL;
import com.tmmas.cl.scl.tasacion.negocio.ejb.session.TasacionFacadeSTLHome;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTL;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTLHome;
import com.tmmas.cl.scl.ventas.service.helper.Global;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ActivacionMasivaORQ"	
 *           description="An EJB named ActivacionMasivaORQ"
 *           display-name="ActivacionMasivaORQ"
 *           jndi-name="ActivacionMasivaORQ"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class ActivacionMasivaORQBean implements javax.ejb.SessionBean {
	
	private static final long serialVersionUID = 1L;
	
	private static Logger logger = Logger.getLogger(ActivacionMasivaORQBean.class);
	private ProgramaDTO datosPrograma = ProgramaDTO.getInstance();
	
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	//Inicio P-CSR-11002 JLGN 24-04-2011
	private DatosGenerales datosGeneralesBO = new DatosGenerales();
	//Fin P-CSR-11002 JLGN 24-04-2011
	
	public ActivacionMasivaORQBean() {
		logger.debug("ActivacionMasivaORQBean(): Start");
		config = UtilProperty.getConfiguration("PortalVentas.properties", "com/tmmas/cl/scl/activacionmasiva/soa/properties/soa.properties");
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));
		logger.debug("ActivacionMasivaORQBean():End");
	}	
	
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
	
	private VentasFacadeSTL getVentasFacade() throws VentasException 	
	{
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));
		logger.debug(" Ingreso a getVentasFacade de Orquestador ");				
		String jndi = config.getString("jndi.VentasFacadeSTLFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.VentasFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		VentasFacadeSTLHome facadeHome = (VentasFacadeSTLHome) PortableRemoteObject.narrow(obj, VentasFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de VentasFacadeSTLFacade...");
		VentasFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new VentasException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new VentasException(e);
		}
		logger.debug("getVentasFacade()():end");
		return facade;	
	}
	
	
	private TasacionFacadeSTL getTasacionFacade() throws TasacionException 
	{
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
		logger.debug(" Ingreso a TasacionFacadeSTL de Orquestador ");
		logger.debug("getTasacionFacade():start");
		
		String jndi = config.getString("jndi.TasacionFacadeSTLFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = config.getString("url.TasacionFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");		

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}

		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		TasacionFacadeSTLHome facadeHome =
			(TasacionFacadeSTLHome) PortableRemoteObject.narrow(obj, TasacionFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de TasacionFacade...");
		TasacionFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new TasacionException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new TasacionException(e);
		}
		logger.debug("getTasacionFacade():end");
		return facade;	
	}	
	
	private LogisticaFacadeSTL getLogisticaFacade() throws LogisticaException 
	{		
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));
		logger.debug("getLogisticaFacade():start");
		
		String jndi = config.getString("jndi.LogisticaFacadeSTLFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = config.getString("url.LogisticaFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");			
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		LogisticaFacadeSTLHome facadeHome =
			(LogisticaFacadeSTLHome) PortableRemoteObject.narrow(obj, LogisticaFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de LogisticaFacade...");
		LogisticaFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new LogisticaException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new LogisticaException(e);
		}
		
		logger.debug("getLogisticaFacade():end");		
		return facade;	
	}
	
	/*private IntegracionERiesgo getIntegracionRiesgoFacade() throws GeneralException 
	{		
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
		logger.debug("INICIO getIntegracionRiesgoFacade ORQ");
				
		String jndi = config.getString("jndi.IntegracionEriesgoFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		
		String url = config.getString("url.IntegracionEriesgoFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");			
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");	
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		IntegracionERiesgoHome facadeHome =
			(IntegracionERiesgoHome) PortableRemoteObject.narrow(obj, IntegracionERiesgoHome.class);	
		
		logger.debug("Recuperada interfaz home de IntegracionERiesgoHome...");
		IntegracionERiesgo facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new LogisticaException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new LogisticaException(e);
		}
		
		logger.debug("FIN getIntegracionRiesgoFacade ORQ");
		return facade;	
	}*/
	
	
	private AltaClienteFacadeSTL getAltaClienteFacade()
		throws AltaClienteException 
	{
		logger.debug("getAltaClienteFacade():start");
		AltaClienteFacadeSTLHome altaClienteFacadeHome = null;
		String jndi = config.getString("jndi.AltaClienteFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.AltaClienteFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");
		String initialContextFactory = config.getString("initial.context.factory");
		String securityPrincipal = config.getString("security.principal");
		String securityCredentials = config.getString("security.credentials");
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		AltaClienteFacadeSTLHome facadeHome =
			(AltaClienteFacadeSTLHome) PortableRemoteObject.narrow(obj, AltaClienteFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de IntegracionERiesgoHome...");
		AltaClienteFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new AltaClienteException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new AltaClienteException(e);
		}
		
		logger.debug("FIN getIntegracionRiesgoFacade ORQ");		
		return facade;
	}
	
	
	private ServSupl911CorreoFaxFacade getServSupl911CorreoFaxFacade() throws GeneralException 	
	{
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));
		logger.debug(" Ingreso a getServSupl911CorreoFaxFacade de Orquestador ");
		
		String jndi = config.getString("jndi.ServSupl911CorreoFaxFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("url.ServSupl911CorreoFaxProvider");
		logger.debug("Url provider[" + url + "]");
		
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");
		
		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		//env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
		//env.put(Context.SECURITY_CREDENTIALS, securityCredentials);
		
		Context context = null;
		try {
			logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		Object obj = null;
		try {
			logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		ServSupl911CorreoFaxFacadeHome facadeHome = (ServSupl911CorreoFaxFacadeHome) PortableRemoteObject.narrow(obj, 
				ServSupl911CorreoFaxFacadeHome.class);	
		
		logger.debug("Recuperada interfaz home de getServSupl911CorreoFaxFacade...");
		ServSupl911CorreoFaxFacade facade = null;
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
		logger.debug("getServSupl911CorreoFaxFacade():end");
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
	public String ejemplo(String param) throws VentasException, RemoteException {
		
		logger.debug("Ingreso a ejemplo de orquestador");
		String prueba = getVentasFacade().prueba();		
		
				
		return prueba;
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
	public void updUsuario(UsuarioInDTO entrada) 
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
		logger.debug("Inicio:updUsuario()");		
		try {
			getVentasFacade().updUsuario(entrada);
			UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));			
		} catch (VentasException e) {
			UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));			
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:updUsuario()");		
	}//fin updUsuario
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ActivacionLineaOutDTO altaLinea(ParametrosComercialesINDTO actLinea,UsuarioActInDTO  usuario) 
		throws RemoteException, GeneralException
	{		
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
        logger.debug("Inicio:altaLinea()");
		ActivacionLineaOutDTO resultado = new ActivacionLineaOutDTO();
		Long numMovimiento = null;
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		boolean excepcionado = false;
		try {		
	        logger.debug("Antes:validarParametrosAltaLinea()");
			validarParametrosAltaLinea(usuario);			
	        logger.debug("Despues:validarParametrosAltaLinea()");
			
			logger.debug("altaLinea() --> getdatos()");
			cabecera = getDatos(actLinea);
			
			//Busca excepción asociada al cliente
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodigoCliente(cabecera.getCodigoCliente());			
			clienteDTO = getVentasFacade().getCliente(clienteDTO);	
			
			RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo = new RegistroEvaluacionRiesgoDTO();
			long numSolicitud = (actLinea.getNumSolicitud()!=null && !actLinea.getNumSolicitud().equals(""))? Long.parseLong(actLinea.getNumSolicitud().trim()):0;
			registroEvaluacionRiesgo.setNumeroSolicitud(numSolicitud); 
			
			//Logica Si número de solicitud no existe se busca una evaluacion de riesgo para ese cliente
			//se verifica estado Si estado =0 se encuentra Rechazada, si es 4 esta vendida y
			// si es -1 no revisa evaluacion
			//MA-70659 17-10-2008
			if (registroEvaluacionRiesgo.getNumeroSolicitud() != -1){
			//fin MA-70659 17-10-2008	
				if (registroEvaluacionRiesgo.getNumeroSolicitud() != 0 ){
					excepcionado = false;
					registroEvaluacionRiesgo = getVentasFacade().validaExistenciaEvRiesgo(registroEvaluacionRiesgo);
					logger.debug("registroEvaluacionRiesgo.getNumIdentificacion() ["+registroEvaluacionRiesgo.getNumIdentificacion()+"]");
					logger.debug("clienteDTO.getNumeroIdentificacion() ["+clienteDTO.getNumeroIdentificacion()+"]");
					logger.debug("registroEvaluacionRiesgo.getCodigoTipoIdentificacion() ["+registroEvaluacionRiesgo.getCodigoTipoIdentificacion()+"]");
					logger.debug("clienteDTO.getCodigoTipoIdentificacion() ["+clienteDTO.getCodigoTipoIdentificacion()+"]");										
					if (!registroEvaluacionRiesgo.getNumIdentificacion().equals(clienteDTO.getNumeroIdentificacion()) || (!registroEvaluacionRiesgo.getCodigoTipoIdentificacion().equals(clienteDTO.getCodigoTipoIdentificacion()))){
						//Error
					    VentasException e =new VentasException();
					    e.setMessage("Número de Identificacion no corresponde al definido en la Evaluacion de Riesgo");
						e.setDescripcionEvento("Número de Identificacion no corresponde al definido en la Evaluacion de Riesgo");
						throw e;
					}
					
					if (registroEvaluacionRiesgo.getTipoSolicitud().equals("0")){
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("514");
					    e.setMessage("Solicitud Corresponde a un Prechequeo");
						e.setDescripcionEvento("Solicitud Corresponde a un Prechequeo");
						throw e;
					}
					
					if (registroEvaluacionRiesgo.getCodigoEstado()==6)
					{
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("515");
					    e.setMessage("Solicitud Corresponde a un Prechequeo");
						e.setDescripcionEvento("Solicitud Corresponde a un Prechequeo");
						throw e;
					}else if(registroEvaluacionRiesgo.getCodigoEstado()==9){
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("516");
					    e.setMessage("Solicitud No Vigente");
						e.setDescripcionEvento("Solicitud No Vigente");
						throw e;
					}else if (registroEvaluacionRiesgo.getCodigoEstado()==0){
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("517");
					    e.setMessage("Solicitud de Evaluacion de riesgo rechazada");
						e.setDescripcionEvento("Solicitud de Evaluacion de riesgo rechazada");
						throw e;
					}else if (registroEvaluacionRiesgo.getCodigoEstado()==3){
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("518");
					    e.setMessage("Solicitud en venta");
						e.setDescripcionEvento("Solicitud en venta");
						throw e;  	
					}else if (registroEvaluacionRiesgo.getCodigoEstado()!=1){
	//					Error
					    VentasException e =new VentasException();
					    e.setCodigo("519");
					    e.setMessage("La Solicitud se encuentra en un estado invalido, Estado de solicitud ["+registroEvaluacionRiesgo.getCodigoEstado()+"]");
						e.setDescripcionEvento("La Solicitud se encuentra en un estado invalido, Estado de solicitud ["+registroEvaluacionRiesgo.getCodigoEstado()+"]");
						throw e;						
					}
					registroEvaluacionRiesgo.setCodigoPlanTarifario(actLinea.getCod_planTarif());
					registroEvaluacionRiesgo.setNumeroSolicitud(Long.parseLong(actLinea.getNumSolicitud()));
					getVentasFacade().validaPlanTarifarioEvRiesgo(registroEvaluacionRiesgo);
					getVentasFacade().bloqueaSolicitudEvRiesgo(registroEvaluacionRiesgo);
				}else{		
					excepcionado = true;
					registroEvaluacionRiesgo.setCodigoTipoIdentificacion(clienteDTO.getCodigoTipoIdentificacion());
					registroEvaluacionRiesgo.setNumIdentificacion(clienteDTO.getNumeroIdentificacion());
					getVentasFacade().getExcepcion(registroEvaluacionRiesgo);				
				}
			}
			
			
			//Se setean estos valores ya que para colombia los precios deben ser 
			//filtrados por el uso de la linea y no del articulo.
			if(actLinea.getTipo_producto() != null && actLinea.getTipo_producto().trim().equals("0")){
				cabecera.setCodUsoLinea(2);
			}
			else 
				cabecera.setCodUsoLinea(10);
			
			boolean cabeceraOK = true;
			String descripcionError= "";
			
			//Validacion Contrato Ingresado.
			if (cabecera.getParametros().getContrato().getIndicadorContratoNuevo() == 1)
			{
				logger.debug("contratoNuevo");
				ContratoDTO contrato =new ContratoDTO();				
				contrato.setCodigoCliente(cabecera.getParametros().getContrato().getCodigoCliente());				
				contrato.setCodigoTipoContrato(cabecera.getParametros().getContrato().getCodigoTipoContrato());				
				contrato.setNumeroContrato(cabecera.getParametros().getContrato().getNumeroContrato());				
				DatosValidacionDTO validaContrato = getVentasFacade().getValidaNuevoContratoCliente(contrato);				
				if(validaContrato.getExisteContrato()==1){
					cabeceraOK =false;
					descripcionError="Contrato Ingresado ya Existe";
				}
			}
					
			
			//Valida si el cliente es agente comercial			
			ParametrosValidacionVentasDTO parametrosValidacionVentasDTO = new ParametrosValidacionVentasDTO();
			parametrosValidacionVentasDTO.setCodigoCliente(cabecera.getCodigoCliente());
			ResultadoValidacionVentaDTO resultadoValidacionVentaDTO = getVentasFacade().clienteAgenteComercial(
					parametrosValidacionVentasDTO);
			if (resultadoValidacionVentaDTO.isResultado())
			{		
				cabeceraOK =false;
				descripcionError=resultadoValidacionVentaDTO.getDetalleEstado();
			}
			//Fin validación cliente comercial	
			
			
			
			
			if (cabeceraOK == true)
			{			
				logger.debug("		altaLinea() --> validacionLinea()");
				ParametrosValidacionDTO[] detalleArchivo = validacionLinea(cabecera);
				
				//Valida si se encuentra bloqueado el vendedor
				VendedorDTO vendedor = new VendedorDTO();
				vendedor.setCodigoVendedor(actLinea.getCod_vendedor());
				getVentasFacade().validaCodigoVendedor(vendedor);
				
				//BLOQUEA VENDEDOR						
				vendedor.setCodigoAccionBloqueo(config.getString("indicador.bloqueo"));
				
				// Incidencia 67401 (24-06-2008) (Solo se bloquea vendedores directos)
				if (actLinea.getCod_canal()!=null && actLinea.getCod_canal().trim().equals(config.getString("codigo.canal.directo"))) { 
					logger.debug("inicio:bloqueaDesbloqueaVendedor");
					getVentasFacade().bloqueaDesbloqueaVendedor(vendedor);
					logger.debug("fin:bloqueaDesbloqueaVendedor");
				}
				// Incidencia 67401 (24-06-2008) (Solo se bloquea vendedores directos)
				
				if (detalleArchivo.length>0)
				{					
					 //-- CREACION DE LINEAS
					logger.debug("		altaLinea() --> crearLineas()");
					DatosGeneralesVentaDTO abonado = crearLineas(detalleArchivo,cabecera, usuario);
					// COL08009
					resultado.setCodPlanTarif(abonado.getCodigoPlanTarifario());
					resultado.setIcc(abonado.getNumeroSerieSimcard());
					resultado.setImei(abonado.getNumeroSerieTerminal());
					resultado.setNumAbonado(abonado.getNum_abonado());
					resultado.setNumCelular(abonado.getNumeroCelular());
					resultado.setNumVenta(abonado.getNumeroVenta());
					resultado.setCodCliente(abonado.getCodigoCliente());
					
					//Release II
					resultado.setCod_ciclo(abonado.getCod_ciclo());
					
					//-- OBTENER CARGOS
					cabecera.setNum_abonado(abonado.getNum_abonado());
					cabecera.setNum_terminal(Long.valueOf(abonado.getNumeroCelular()));					
					
					ParametrosSeleccionadosDTO parametros = cabecera.getParametros();					
					CiudadDTO ciudad = new CiudadDTO();
					ciudad.setCodigoCiudad(abonado.getCodigoCiudad());		
					parametros.setCiudad(ciudad);
					ProvinciaDTO provincia = new ProvinciaDTO();
					provincia.setCodigoProvincia(abonado.getCodigoProvincia());					
					parametros.setProvincia(provincia);
					RegionDTO region = new RegionDTO();
					region.setCodigoRegion(abonado.getCodigoRegion());
					parametros.setRegion(region);
					cabecera.setParametros(parametros);
					
					logger.debug("		altaLinea() --> obtieneCargos()");					
					RegCargosDTO objetoCargos = obtieneCargos(cabecera);
					String aplicaTipoCargo = config.getString("aplica.tipo.cargo");
					objetoCargos.setAplicaTipoCargo(aplicaTipoCargo!=null & aplicaTipoCargo.equals("true")?true:false);					
					CargoDTO[] cargosVenta = objetoCargos.getCargos();
					
					//--Registrar Cargos
					RegCargosDTO listadoCargosDTO = new RegCargosDTO();
					listadoCargosDTO.setObjetoSesion(cabecera);
					CargoDTO[] cargos = cargosVenta;
					listadoCargosDTO.setCargos(cargos);
					listadoCargosDTO.setNum_Simcard(cabecera.getNro_icc());
					
					logger.debug("cargos !!!!!! : " + cargos);
					logger.debug("cargos !!!!!! : " + cargos.length);
					logger.debug("		altaLinea() --> registrarCargos()");		
					ResultadoRegCargosDTO resultadoRegCargos = registrarCargos(listadoCargosDTO);					
					float total=0.0f;
					if (!cabecera.isFacturaCiclo())
					{
						cabecera.setTotalImpuestoVenta(resultadoRegCargos.getTotalImpuestos());
						cabecera.setTotalCargosVenta(resultadoRegCargos.getTotalCargos());
						cabecera.setTotalDescuentosVenta(resultadoRegCargos.getTotalDescuentos());
						total = resultadoRegCargos.getTotalCargos() + resultadoRegCargos.getTotalImpuestos() + resultadoRegCargos.getTotalDescuentos();
						
						
						cabecera.setTotalPresupuestoVenta(total); 
						cabecera.setNumeroProcesoFacturacion(resultadoRegCargos.getNumeroProceso());
					}					
					
					//--Aceptar presupuesto		
					logger.debug("		altaLinea() --> aceptarPresupuesto()");
					//aceptarPresupuesto(cabecera);					
					
					//--Cierre venta
					String numeroContrato =cabecera.getParametros().getContrato().getNumeroContrato(); 
					String numAnexo = numeroContrato.substring(0,(numeroContrato.length()-String.valueOf(1).length()));
					numAnexo=numAnexo+String.valueOf(1);
					
					logger.debug("		altaLinea() --> cierreVenta()");
					numMovimiento = cierreVenta(cabecera);
					
					//Se aplica formato a valor Factura definido en Parametro
					resultado.setValorFactura(FormatearValor (new Float(total)));
					//resultado.setValorFactura(new Float(total));
					GaDocVentasDTO gaDocVentasDTO=new GaDocVentasDTO();
					gaDocVentasDTO.setNum_Venta(new Long(cabecera.getNumeroVenta()));
					gaDocVentasDTO.setNum_Folio(numAnexo);
					gaDocVentasDTO=getVentasFacade().insertGaDocVentas(gaDocVentasDTO);
					resultado.setNumero_transaccion(String.valueOf(numMovimiento));										
				}
				//DESBLOQUEA VENDEDOR
				vendedor.setCodigoAccionBloqueo(config.getString("indicador.desbloqueo"));
				getVentasFacade().bloqueaDesbloqueaVendedor(vendedor);
			}else{
				//TODO
				logger.debug("Ingreso a altaLinea ORQ 7");				
			}
			// MA - 70659 23-10-2008
			if ((!excepcionado)&& (registroEvaluacionRiesgo.getNumeroSolicitud()!= -1)){
			// fin MA - 70659 23-10-2008
				registroEvaluacionRiesgo.setNumeroVenta(String.valueOf(cabecera.getNumeroVenta()));
				getVentasFacade().udp_EvRiesgo_registroPlanes(registroEvaluacionRiesgo);
				getVentasFacade().desBloqueaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo);
			}
			
			/***
			 * @author rlozano
			 * @description se realiza llamado a activacion de productos por defecto. primero se verifica flag en la ged_parametros
			 * @date 06-11-2008
			 */
			//TODO: Procede a llamar  a la llamada al webservices de contratacion de productos por defecto
			ParametroDTO parametroEntrada =new ParametroDTO();
			parametroEntrada.setCodigoModulo(config.getString("indicador.modulo.GA"));
			parametroEntrada.setCodigoProducto(config.getString("indicador.codigo.producto"));
			parametroEntrada.setCodigoParametro(config.getString("indicador.aplica.pl.adicional"));
			parametroEntrada =this.getVentaFacade().getValorParametro(parametroEntrada);
			
			
			if ("TRUE".equals(parametroEntrada.getValorParametro())){
				/*DatosVentaDTO datosVentaDTO=new DatosVentaDTO();  
				datosVentaDTO.setCod_cliente(resultado.getCodCliente());
				datosVentaDTO.setNum_venta(resultado.getNumVenta());
				datosVentaDTO.setCod_proceso(actLinea.getCod_canal());*/
				//RetornoDTO retorno=this.getCusRelManWSFacade().sendToQueueActivacionProductosPorDefecto(datosVentaDTO);
			}
			
		} catch (VentasException e) {			
			logger.debug("Fin:altaLinea");
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			if(cabecera.getNumeroVenta() != 0)
			{
				e.setMessageUser(String.valueOf(cabecera.getNumeroVenta()));
			}
			throw e;
		}catch (GeneralException e) {
			context.setRollbackOnly();
			logger.debug("GeneralException");
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			logger.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
				e.setMessageUser(String.valueOf(cabecera.getNumeroVenta()));
			throw e;			
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Inicio:altaLinea()");
		return resultado;		
	}	
	
	public String FormatearValor(Float valor)
	throws VentasException, RemoteException
{
	logger.debug("Formatea Valor():start");
	VentasFacadeSTL ventasFacade = getVentasFacade();
	String Valor= new String();
	try {
		Valor =ventasFacade.FormatearValor(valor);
    }catch (VentasException e) {
	 logger.debug("VentasException");
	 context.setRollbackOnly();
	 String log = StackTraceUtl.getStackTrace(e);
	 logger.debug("log error[" + log + "]");			
	 throw e;
    } catch (Exception e) {
	 logger.debug("Exception");			
	 String log = StackTraceUtl.getStackTrace(e);
	 logger.debug("log error[" + log + "]");
	 context.setRollbackOnly();
	 throw new VentasException(e);
}
logger.debug("insertCierreVenta():end");
return Valor;	
}

	
	private void validarParametrosAltaLinea(UsuarioActInDTO  usuario)
	throws VentasException, RemoteException  {
		try{
			logger.debug("inicio:validarParametrosAltaLinea()");
			// Valida estado civil
			logger.debug("antes:validaEstadoCivilIngresado");
			validaEstadoCivilIngresado(usuario.getCodEstCivil());
			logger.debug("despues:validaEstadoCivilIngresado");
			// Valida dirección 
			DireccionNegocioDTO direccion = new DireccionNegocioDTO();
			direccion.setRegion(usuario.getCodRegion());
			direccion.setProvincia(usuario.getCodProvincia());
			direccion.setCiudad(usuario.getCodCiudad());
			direccion.setComuna(usuario.getCodComuna());
			validaDireccion(direccion);
			logger.debug("fin:validarParametrosAltaLinea()");
		}
		catch (VentasException v) {
			throw v;
		}	
		catch (AltaClienteException a) {
			String log = StackTraceUtl.getStackTrace(a);
			logger.debug("AltaClienteException[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(a.getMessage());
			v.setDescripcionEvento(a.getDescripcionEvento());
			throw v;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
	}
	
	
	
	private ParametrosValidacionDTO[] validacionLinea(CabeceraArchivoCOLDTO cabecera) 
		throws GeneralException
	{
		logger.debug("inicio():validacionLinea()");
		ArrayList arrayLineasValidas = new ArrayList();
		try {
			int cantidadRegsLeidos = 0;
			int numeroDeLineas = 0;
			int numeroDeOrden = 0;			
			double dtotalImporteCargoBasico = 0;				
			
			String planTarifarioLinea = null;
			String numeroCelular = null;
			ParametrosValidacionDTO parametrosValidacionDTO = new ParametrosValidacionDTO();
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		    //Busca largo serie simcard
		    ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		    parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
		    parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.AL"));
		    parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.largoSerieSimcard"));
		    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    parametrosValidacionDTO.setLargoSerieSimcard(Integer.parseInt(parametrosGeneralesDTO.getValorparametro()));		    
		    //Fin busca largo serie simcard
		     //Busca largo serie terminal
		    parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.largoSerieTerminal"));
		    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    parametrosValidacionDTO.setLargoSerieTerminal(Integer.parseInt(parametrosGeneralesDTO.getValorparametro()));
		    //Busca largo serie terminal
		    //Busca estado nuevo Simcard
		    parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.estadoNuevo"));
		    parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    parametrosValidacionDTO.setEstadoNuevoSimcard(parametrosGeneralesDTO.getValorparametro());
		    //Fin busqueda estado nuevo simcard
	        //Busca uso venta postpago
		    parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.usoVentaPostpago"));
		    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    parametrosValidacionDTO.setUsoVentaPostpago(parametrosGeneralesDTO.getValorparametro());
		    //Fin busqueda uso venta postpago		    
		    //Busca uso venta hibrido
		    parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.usoVentaHibrido"));
		    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    parametrosValidacionDTO.setUsoVentaHibrido(parametrosGeneralesDTO.getValorparametro());
		    //Fin busqueda uso venta hibrido
			parametrosValidacionDTO.setCodigoVendedor(cabecera.getCodigoVendedor());
			parametrosValidacionDTO.setCodigoCliente(cabecera.getCodigoCliente());
			parametrosValidacionDTO.setTipoIdentificador(cabecera.getCodigoTipoIdentificacion());
			parametrosValidacionDTO.setNumeroIdentificador(cabecera.getNumeroIdentificacion());
			parametrosValidacionDTO.setCodigoModalidadVenta(cabecera.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
			parametrosValidacionDTO.setTipoCliente(cabecera.getIdentificadorEmpresa());
			ResultadoValidacionDTO resultadoValidacionDTO = new ResultadoValidacionDTO();
			ResultadoValidacionLogisticaDTO resultadoValidacionLogistica = null;
			ResultadoValidacionVentaDTO resultadoValidacionVentas = null;
			ResultadoValidacionTasacionDTO resultadoValidacionTasacion = null;			
			cabecera.setIdentificadorEmpresa(config.getString("identificador.empresa"));			
			if (cabecera.getIdentificadorEmpresa().equals(config.getString("identificador.empresa"))&& cantidadRegsLeidos == 1)
			{							
				planTarifarioLinea=cabecera.getCod_planTarif().trim();
				parametrosValidacionDTO.setCodigoPlanTarifario(planTarifarioLinea);
			}else if (cabecera.getIdentificadorEmpresa().equals(config.getString("identificador.empresa")) 
					&& cantidadRegsLeidos > 1)
			{
				parametrosValidacionDTO.setCodigoPlanTarifario(planTarifarioLinea);	
			}else {			
				parametrosValidacionDTO.setCodigoPlanTarifario(cabecera.getCod_planTarif());
			}	
			//Datos Archivo						
			parametrosValidacionDTO.setNumeroSerie(cabecera.getNro_icc());
			parametrosValidacionDTO.setNumeroSerieSimcard(cabecera.getNro_icc());			
			parametrosValidacionDTO.setNumeroSerieTerminal(cabecera.getNro_imei());
			parametrosValidacionDTO.setNumeroCelular(cabecera.getNumero_celular());
			parametrosValidacionDTO.setCodigoCanal(cabecera.getCod_canal());
			parametrosValidacionDTO.setTipoProducto(cabecera.getTipo_producto());			
			parametrosValidacionDTO.setCodigoModalidadVenta(cabecera.getParametros().
																		getModalidadPagoDTO().getCodigoModalidadPago());
			
			parametrosValidacionDTO.setCodigoCanal(cabecera.getCod_canal());
			//--- Validar linea ---			
			// VALIDACION TASACION
			ParametrosValidacionTasacionDTO parametrosValidacionTasacion = new ParametrosValidacionTasacionDTO(parametrosValidacionDTO);
			parametrosValidacionTasacion.setTotalImporteCargoBasico(dtotalImporteCargoBasico);
			resultadoValidacionTasacion = getTasacionFacade().validacionLinea(parametrosValidacionTasacion);
			resultadoValidacionDTO.setEstado(resultadoValidacionTasacion.getEstado());
			resultadoValidacionDTO.setDetalleEstado(resultadoValidacionTasacion.getDetalleEstado());
			resultadoValidacionDTO.setCodigoError(resultadoValidacionTasacion.getCodigoError());
			ParametrosValidacionLogisticaDTO parametrosValidacionLogistica =new ParametrosValidacionLogisticaDTO(parametrosValidacionDTO);
			if (resultadoValidacionDTO.getEstado()!=null && resultadoValidacionDTO.getEstado().equals("OK"))
			{
				//VALIDACIONES LOGISTICA			
				dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico();
				//	VALIDACIONES Simcard				
				resultadoValidacionLogistica = getLogisticaFacade().validacionesSerieSimcard(parametrosValidacionLogistica);
				boolean esMayoristaSimcard = resultadoValidacionLogistica.isEsMayoristaSimcard();
				resultadoValidacionDTO.setEstado(resultadoValidacionLogistica.getEstado());				
				resultadoValidacionDTO.setDetalleEstado(resultadoValidacionLogistica.getDetalleEstado());
				resultadoValidacionDTO.setCodigoError(resultadoValidacionLogistica.getCodigoError());
				if (resultadoValidacionDTO.getEstado().equals("OK") && cabecera.getProc_equipo().trim().toUpperCase().equals("I"))
				{
	                //VALIDACIONES Terminal					
					resultadoValidacionLogistica = getLogisticaFacade().validacionesSerieTerminal(parametrosValidacionLogistica);
				}else{	
					if(cabecera.getProc_equipo().trim().toUpperCase().equals("I"))
					{	
						dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
						resultadoValidacionTasacion.getImporteCargoBasico();	
						throw new VentasException(resultadoValidacionDTO.getCodigoError(), 0, resultadoValidacionDTO.getDetalleEstado() );
					}
				}				
				resultadoValidacionDTO.setEstado(resultadoValidacionLogistica.getEstado());
				resultadoValidacionDTO.setDetalleEstado(resultadoValidacionLogistica.getDetalleEstado());
				resultadoValidacionDTO.setCodigoError(resultadoValidacionLogistica.getCodigoError());
				if (resultadoValidacionDTO.getEstado().equals("OK"))
				{				
					//VALIDACIONES VENTAS
					ParametrosValidacionVentasDTO parametrosValidacionVentas = new ParametrosValidacionVentasDTO(parametrosValidacionDTO);					
					parametrosValidacionVentas.setNumeroTransaccionVenta(String.valueOf(cabecera.getNumeroTransaccionVenta()));					
					parametrosValidacionVentas.setNumeroLinea(numeroDeLineas);
					parametrosValidacionVentas.setNumeroOrden(numeroDeOrden);
					parametrosValidacionVentas.setCodigoTipoContrato(cabecera.getParametros().getContrato().getCodigoTipoContrato());					
					parametrosValidacionVentas.setNumeroCelular("N/A");
					parametrosValidacionVentas.setCodigoUsoLinea(cabecera.getCodUsoLinea());
					parametrosValidacionVentas.setEsMayoristaSimcard(esMayoristaSimcard);
					parametrosValidacionVentas.setEsMayoristaTerminal(resultadoValidacionLogistica.isEsMayoristaTerminal());
					resultadoValidacionVentas = getVentasFacade().validacionLinea(parametrosValidacionVentas);
					resultadoValidacionDTO.setEstado(resultadoValidacionVentas.getEstado());
					resultadoValidacionDTO.setDetalleEstado(resultadoValidacionVentas.getDetalleEstado());
					resultadoValidacionDTO.setCodigoError(resultadoValidacionVentas.getCodigoError());
					resultadoValidacionDTO.setBDireccionLinea(resultadoValidacionVentas.isBDireccionLinea());					
					numeroCelular = resultadoValidacionVentas.getNumeroCelular();					
			 	}else{
					dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
					resultadoValidacionTasacion.getImporteCargoBasico();					
					throw new VentasException(resultadoValidacionDTO.getCodigoError(), 0, resultadoValidacionDTO.getDetalleEstado() );
				}				
				if (resultadoValidacionDTO.getEstado().equals("OK"))
				{					
					parametrosValidacionDTO.setNumeroCelular(numeroCelular);
					ParametrosValidacionDTO parametrosValidacionDTO2 = new ParametrosValidacionDTO();
					parametrosValidacionDTO2.setCodigoPlanTarifario(parametrosValidacionDTO.getCodigoPlanTarifario());
					parametrosValidacionDTO2.setNumeroSerie(parametrosValidacionDTO.getNumeroSerie());
					parametrosValidacionDTO2.setNumeroSerieTerminal(parametrosValidacionDTO.getNumeroSerieTerminal());					
					parametrosValidacionDTO2.setNumeroCelular(numeroCelular);
					parametrosValidacionDTO2.setEstadoNuevoSimcard(parametrosValidacionDTO.getEstadoNuevoSimcard());
					parametrosValidacionDTO2.setBDireccionLinea(resultadoValidacionDTO.isBDireccionLinea());					
					arrayLineasValidas.add(parametrosValidacionDTO2);					
					numeroDeLineas++;
					numeroDeOrden++;
				}else{					
					dtotalImporteCargoBasico = resultadoValidacionTasacion.getTotalImporteCargoBasico() - 
					resultadoValidacionTasacion.getImporteCargoBasico();
					throw new VentasException(resultadoValidacionDTO.getCodigoError(), 0, resultadoValidacionDTO.getDetalleEstado() );
				}				
			}else{
				throw new VentasException(resultadoValidacionDTO.getCodigoError(), 0, resultadoValidacionDTO.getDetalleEstado() );
			}			
		} catch (VentasException e) {
			context.setRollbackOnly();
			logger.debug("VentasException", e);
			throw(e);		
		} catch (LogisticaException e) {
			context.setRollbackOnly();
			logger.debug("LogisticaException", e);
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (TasacionException e) {
			context.setRollbackOnly();
			logger.debug("TasacionException", e);
			throw new VentasException(e);
		} catch (RemoteException e) {
			context.setRollbackOnly();
			logger.debug("RemoteException", e);
			throw new VentasException(e);
		}		
		logger.debug("Fin:validacionLinea()");
		ParametrosValidacionDTO[] detalleArchivo =(ParametrosValidacionDTO[])ArrayUtl.copiaArregloTipoEspecifico(arrayLineasValidas.toArray(), 
				ParametrosValidacionDTO.class);
		return detalleArchivo;
	}
	
	private ParametrosValidacionDTO[] validacionLineaWeb(AltaLineaWebDTO alta) 
		throws GeneralException
	{
		logger.debug("inicio():validacionLinea()");
		ArrayList arrayLineasValidas = new ArrayList();
		try {			
			int numeroDeLineas = 0;
			int numeroDeOrden = 0;
			
			//Para Guatemala - El Salvador las validaciones estan en la interfaz		
			ParametrosValidacionDTO parametrosValidacionDTO = new ParametrosValidacionDTO();
			ResultadoValidacionDTO resultadoValidacionDTO = new ResultadoValidacionDTO();
			resultadoValidacionDTO.setEstado("OK");
			
			 //Busca estado nuevo Simcard
			//TODO
			parametrosValidacionDTO.setEstadoNuevoSimcard("1");
		    //Fin busqueda estado nuevo simcard
				
			if (resultadoValidacionDTO.getEstado().equals("OK"))
			{					
				parametrosValidacionDTO.setNumeroCelular(alta.getNumCelular());
				ParametrosValidacionDTO parametrosValidacionDTO2 = new ParametrosValidacionDTO();
				parametrosValidacionDTO2.setCodigoPlanTarifario(alta.getCodPlanTarif());
				parametrosValidacionDTO2.setNumeroSerie(alta.getNumSerie());
				parametrosValidacionDTO2.setNumeroSerieTerminal(alta.getNumEquipo());					
				parametrosValidacionDTO2.setNumeroCelular(alta.getNumCelular());
				parametrosValidacionDTO2.setEstadoNuevoSimcard(parametrosValidacionDTO.getEstadoNuevoSimcard());
				parametrosValidacionDTO2.setBDireccionLinea(resultadoValidacionDTO.isBDireccionLinea());
				parametrosValidacionDTO2.setTipoCliente(alta.getCodTipoCliente());
				arrayLineasValidas.add(parametrosValidacionDTO2);					
				numeroDeLineas++;
				numeroDeOrden++;
			}else{					
				throw new VentasException(resultadoValidacionDTO.getCodigoError(), 0, resultadoValidacionDTO.getDetalleEstado() );
			}			
		} catch (VentasException e) {
			context.setRollbackOnly();
			logger.debug("VentasException", e);
			throw(e);		
		} 	
		logger.debug("Fin:validacionLinea()");
		ParametrosValidacionDTO[] detalleArchivo =(ParametrosValidacionDTO[])ArrayUtl.copiaArregloTipoEspecifico(arrayLineasValidas.toArray(), 
				ParametrosValidacionDTO.class);
		return detalleArchivo;
	}

	
	private DatosGeneralesVentaDTO crearLineas(ParametrosValidacionDTO[] detalleArchivo, CabeceraArchivoCOLDTO cabecera,UsuarioActInDTO  usuario) 
		throws GeneralException
	{
		DatosGeneralesVentaDTO datosGeneralesVenta = new DatosGeneralesVentaDTO();
		try {
			logger.debug("Inicio:crearLineas()");						
			VendedorDTO vendedor = new VendedorDTO();
			VentasFacadeSTL ventasFacade=getVentasFacade();			
			Date fecha = new Date();			
			String fechaActual;
			fechaActual = Formatting.dateTime(fecha,"dd/MM/yyyy HH:mm:ss");			
			
			//-- BUSCAR VENDEDOR
			vendedor.setCodigoVendedor(cabecera.getCodigoVendedor());	
			vendedor.setCodigoVendedorDealer(cabecera.getCodigoVenDealer());
			vendedor = ventasFacade.getVendedor(vendedor);						

			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodigoCliente(cabecera.getCodigoCliente());
			clienteDTO = getVentasFacade().getCliente(clienteDTO);
			
			//-- BLOQUEA VENDEDOR
			vendedor.setCodigoVendedor(cabecera.getCodigoVendedor());
			vendedor.setCodigoVendedorRaiz(cabecera.getCodigoVendedorRaiz());
			vendedor.setCodigoAccionBloqueo(config.getString("indicador.bloqueo"));
			// Incidencia 67401 (24-06-2008) (Solo se bloquea vendedores directos)
			if (cabecera.getCod_canal()!=null && cabecera.getCod_canal().trim().equals(config.getString("codigo.canal.directo"))) {
				logger.debug("inicio:bloqueaDesbloqueaVendedor");
				ventasFacade.bloqueaDesbloqueaVendedor(vendedor);
				logger.debug("fin:bloqueaDesbloqueaVendedor");
			}
			// Incidencia 67401 (24-06-2008) (Solo se bloquea vendedores directos)
			
			datosGeneralesVenta.setIdentificadorEmpresa(config.getString("identificador.empresa"));
			datosGeneralesVenta.setFechaActual(fechaActual);
			datosGeneralesVenta.setCodigoCliente(cabecera.getCodigoCliente());
			datosGeneralesVenta.setCodigoVendedorRaiz(String.valueOf(vendedor.getCodigoVendedorRaiz()));
			datosGeneralesVenta.setCodigoVendedor(vendedor.getCodigoVendedor());
			datosGeneralesVenta.setCodigoVendedorDealer(String.valueOf(vendedor.getCodigoVendedorDealer()));
			datosGeneralesVenta.setNumeroVenta(String.valueOf(cabecera.getNumeroVenta()));
			datosGeneralesVenta.setNumeroTransaccionVenta(String.valueOf(cabecera.getNumeroTransaccionVenta()));
			datosGeneralesVenta.setNombreUsuarioOracle(cabecera.getNombreUsuario());			
			datosGeneralesVenta.setTipoTerminal(cabecera.getParametroCodigoTerminalGSM());
			datosGeneralesVenta.setNumeroPerContrato(config.getString("numero.per.contrato"));
			datosGeneralesVenta.setCodigoTipoContrato(cabecera.getParametros().getContrato().getCodigoTipoContrato());
			datosGeneralesVenta.setIndicadorComodato(String.valueOf(cabecera.getParametros().getContrato().getIndComodato()));
			datosGeneralesVenta.setCodigoEstado(cabecera.getParametroCodigoEstadoCobros());			
			datosGeneralesVenta.setCodigoGrupoServicio(cabecera.getParametros().getGrupoCobroServicio().getCodigoGrupoCobroServicio());
			datosGeneralesVenta.setCodigoModalidadVenta(cabecera.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
			datosGeneralesVenta.setNumeroContrato(cabecera.getParametros().getContrato().getNumeroContrato());
			datosGeneralesVenta.setNumAnexo(cabecera.getNumAnexo());
			datosGeneralesVenta.setCodigoCreditoMorosidad(cabecera.getParametros().getCreditoMorosidadDTO().getCodigoCreditoMorosidad());
			datosGeneralesVenta.setCodigoCreditoConsumo(cabecera.getParametros().getCreditoConsumo().getCodigoCreditoConsumo());
			datosGeneralesVenta.setIndicadorFacturable(String.valueOf(cabecera.getIndicativoFacturableCliente()));			
			datosGeneralesVenta.setCodigoVendedorDealer(String.valueOf(cabecera.getCodigoVenDealer()));
			datosGeneralesVenta.setCodigoGrupoAfinidad(cabecera.getParametros().getGrupoAfinidad().getCodigoGrupoAfinidad());
			datosGeneralesVenta.setCodigoPlanIndemnizacion(cabecera.getParametros().getPlanIndemnizacion().getCodigoPlanIndemnizacion());
		    datosGeneralesVenta.setCodigoTerminalGSM(cabecera.getParametroCodigoTerminalGSM());
		    datosGeneralesVenta.setCodigoSimcardGSM(cabecera.getParametroCodigoSimcardGSM());
		    datosGeneralesVenta.setIndicadorCuotas(cabecera.getParametros().getModalidadPagoDTO().getIndicadorCuotas());
		    datosGeneralesVenta.setTipoPlanHibrido(cabecera.getTipoPlanHibrido());
		    datosGeneralesVenta.setTipoPlanPostpago(cabecera.getTipoPlanPostpago());
		    datosGeneralesVenta.setCodigoEstrato(cabecera.getCod_estrato());
		    if(cabecera.getCod_cuota() != null && !cabecera.getCod_cuota().trim().equals(""))
		    {
		    	datosGeneralesVenta.setCodCuota(Long.valueOf(cabecera.getCod_cuota()));	
		    }		    
		    //Se setea codigo del terminal externo
		    datosGeneralesVenta.setCodigoArticuloTerminal(cabecera.getCodigoArticuloTerminal());
		    datosGeneralesVenta.setNumMesesContrato(new Long(cabecera.getParametros().getContrato().getNumeroMesesSeleccionado()));
		    
			int corrLinea = 1;
			int numOrden = 0;
			boolean OkCreaLinea = true;

			//-- Seteamos para registro de campañas vigentes
			if( cabecera.getParametros() != null && cabecera.getParametros().getCampanaVigente() != null &&
					cabecera.getParametros().getCampanaVigente().getCodigoCampanasVigentes() != null	)
			{
				datosGeneralesVenta.setCodigoCampana(cabecera.getParametros().getCampanaVigente().getCodigoCampanasVigentes());
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				CampanaVigente CampanaBO = new CampanaVigente();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
				campanaVigenteDTO = CampanaBO.getCampanaVigente(campanaVigenteDTO);
				datosGeneralesVenta.setAplicaCampanaA(campanaVigenteDTO.getAplicaA());
			}
			
			for(int i=0;i<detalleArchivo.length;i++)
			{
				ParametrosValidacionDTO lineaDetalle = new ParametrosValidacionDTO();
				lineaDetalle = detalleArchivo[i];

				datosGeneralesVenta.setCodigoPlanTarifario(lineaDetalle.getCodigoPlanTarifario());
				datosGeneralesVenta.setNumeroSerieSimcard(lineaDetalle.getNumeroSerie());
				datosGeneralesVenta.setNumeroSerieTerminal(lineaDetalle.getNumeroSerieTerminal());
				datosGeneralesVenta.setNumeroCelular(lineaDetalle.getNumeroCelular());
				datosGeneralesVenta.setEstadoSerieSimcard((lineaDetalle.getEstadoNuevoSimcard()));
				datosGeneralesVenta.setCorrelativoLinea(corrLinea);
				datosGeneralesVenta.setNumeroOrden(numOrden);
				
				/* DATOS HOME DE LA LINEA */
				HomeLineaDTO home = new HomeLineaDTO();						
				home.setNum_icc(datosGeneralesVenta.getNumeroSerieSimcard());				
				home.setCod_vendedor(Long.valueOf(datosGeneralesVenta.getCodigoVendedor()));
				home.setCod_planTarif(datosGeneralesVenta.getCodigoPlanTarifario());
				
				//release II
				home.setCod_actabo(cabecera.getCod_actabo());
				
				
				/* Se setean los datos que vienen desde la pantalla */
				
				HomeLineaDTO obtieneHomeLinea = getVentasFacade().obtieneHomeLinea(home);				
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_region() : " + obtieneHomeLinea.getCod_region());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_provincia() : " + obtieneHomeLinea.getCod_provincia());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_ciudad() : " + obtieneHomeLinea.getCod_ciudad());
				
				/* Para COLOMBIA estos datos vienen dados por el HOME de la LINEA*/
				datosGeneralesVenta.setCodigoRegion(obtieneHomeLinea.getCod_region());
				datosGeneralesVenta.setCodigoProvincia(obtieneHomeLinea.getCod_provincia());
				datosGeneralesVenta.setCodigoCiudad(obtieneHomeLinea.getCod_ciudad());	
				datosGeneralesVenta.setNumeroCelular(String.valueOf(obtieneHomeLinea.getNum_celular()));
				datosGeneralesVenta.setCodigoCelda(obtieneHomeLinea.getCod_celda());
				datosGeneralesVenta.setCodigoCentral(String.valueOf(obtieneHomeLinea.getCod_central()));				
				
			    corrLinea++;
				numOrden++;
				
				//Modalidad de venta cuando es vendedor externo
				ParametrosComercialesVendExtDTO  parametrosComerciales = new ParametrosComercialesVendExtDTO(0, null);				
				AgenteVenta agente = new AgenteVenta(cabecera.getCod_canal(), null);				
				Producto producto = new Producto(cabecera.getNro_icc());				
				ConceptoVenta conceptoVenta = new ConceptoVenta(Integer.parseInt(
						cabecera.getParametros().getModalidadPagoDTO().getCodigoModalidadPago()), null);
				DependenciasModalidadDTO depModalidad =
					new DependenciasModalidadDTO(agente, parametrosComerciales, producto, conceptoVenta);
				ConceptoVenta concepto = getVentasFacade().validarModalidadVenta(depModalidad);				
				datosGeneralesVenta.setCodigoModalidadVenta(String.valueOf(concepto.getCodigo()));
				datosGeneralesVenta.setServSuplAdicionales(cabecera.getServSuplAdicionales());
				datosGeneralesVenta  = ventasFacade.crearLinea(datosGeneralesVenta,usuario);				
				OkCreaLinea = true;
				if (datosGeneralesVenta.getEstadoError().equals("NOK"))	
				{				
					OkCreaLinea = false;
				}				
			}
			
			//-- Registra campaña a nivel de cliente
			if (datosGeneralesVenta.getAplicaCampanaA() != null && 
					datosGeneralesVenta.getAplicaCampanaA().equals(config.getString("aplica.campana.a.cliente"))
					&& datosGeneralesVenta.getCodigoCampana() != null )
			{
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
				campanaVigenteDTO.setCodigoCliente(Long.parseLong(cabecera.getCodigoCliente()));
				campanaVigenteDTO.setNumeroAbonado(-1);				
				ventasFacade.registraCampanaVigente(campanaVigenteDTO);				
			}			
			logger.debug("Fin:crearLineas()");
		} catch (VentasException e) {			
			logger.debug("VentasException", e);
			context.setRollbackOnly();			
			throw e;
		} catch (RemoteException e) {
			logger.debug("RemoteException", e);
			context.setRollbackOnly();			
			throw new VentasException(e);
		}	
		return datosGeneralesVenta;
				
	}//fin crearLineas
	
	
	private DatosGeneralesVentaDTO crearLineasWeb(ParametrosValidacionDTO[] detalleArchivo,	CabeceraArchivoCOLDTO cabecera, AltaLineaWebDTO alta) 
		throws GeneralException, RemoteException
	{
		DatosGeneralesVentaDTO datosGeneralesVenta = new DatosGeneralesVentaDTO();
		try {
			logger.debug("Inicio:crearLineas()");						
			
			VentasFacadeSTL ventasFacade=getVentasFacade();
			Date fecha = new Date();			
			String fechaActual;
			fechaActual = Formatting.dateTime(fecha,"dd/MM/yyyy HH:mm:ss");			
			
			//-- BUSCAR VENDEDOR
			VendedorDTO vendedor = new VendedorDTO();
			vendedor.setCodigoVendedor(cabecera.getCodigoVendedor());	
			vendedor.setCodigoVendedorDealer(cabecera.getCodigoVenDealer());
			vendedor = ventasFacade.getVendedor(vendedor);
			vendedor.setCodigoVendedorRaiz(cabecera.getCodigoVendedorRaiz());
						
			datosGeneralesVenta.setIdentificadorEmpresa(config.getString("identificador.empresa"));
			datosGeneralesVenta.setFechaActual(fechaActual);
			datosGeneralesVenta.setCodigoCliente(cabecera.getCodigoCliente());
			datosGeneralesVenta.setCodigoVendedorRaiz(String.valueOf(vendedor.getCodigoVendedorRaiz()));
			datosGeneralesVenta.setCodigoVendedor(vendedor.getCodigoVendedor());
			datosGeneralesVenta.setCodigoVendedorDealer(String.valueOf(vendedor.getCodigoVendedorDealer()));
			datosGeneralesVenta.setNumeroVenta(String.valueOf(cabecera.getNumeroVenta()));
			datosGeneralesVenta.setNumeroTransaccionVenta(String.valueOf(cabecera.getNumeroTransaccionVenta()));
			datosGeneralesVenta.setNombreUsuarioOracle(cabecera.getNombreUsuario());			
			datosGeneralesVenta.setTipoTerminal(alta.getCodTipoTerminal());
			datosGeneralesVenta.setNumeroPerContrato(config.getString("numero.per.contrato"));
			datosGeneralesVenta.setCodigoTipoContrato(cabecera.getParametros().getContrato().getCodigoTipoContrato());
			datosGeneralesVenta.setIndicadorComodato(String.valueOf(cabecera.getParametros().getContrato().getIndComodato()));
			datosGeneralesVenta.setCodigoEstado(cabecera.getParametroCodigoEstadoCobros());			
			datosGeneralesVenta.setCodigoGrupoServicio(cabecera.getParametros().getGrupoCobroServicio().getCodigoGrupoCobroServicio());
			datosGeneralesVenta.setCodigoModalidadVenta(cabecera.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
			datosGeneralesVenta.setNumeroContrato(cabecera.getParametros().getContrato().getNumeroContrato());
			datosGeneralesVenta.setNumAnexo(cabecera.getNumAnexo());
			datosGeneralesVenta.setCodigoCreditoMorosidad(cabecera.getParametros().getCreditoMorosidadDTO().getCodigoCreditoMorosidad());
			datosGeneralesVenta.setCodigoCreditoConsumo(cabecera.getParametros().getCreditoConsumo().getCodigoCreditoConsumo());
			datosGeneralesVenta.setIndicadorFacturable(String.valueOf(cabecera.getIndicativoFacturableCliente()));			
			datosGeneralesVenta.setCodigoVendedorDealer(String.valueOf(cabecera.getCodigoVenDealer()));
			datosGeneralesVenta.setCodigoGrupoAfinidad(cabecera.getParametros().getGrupoAfinidad().getCodigoGrupoAfinidad());
			datosGeneralesVenta.setCodigoPlanIndemnizacion(cabecera.getParametros().getPlanIndemnizacion().getCodigoPlanIndemnizacion());
		    datosGeneralesVenta.setCodigoTerminalGSM(cabecera.getParametroCodigoTerminalGSM());
		    datosGeneralesVenta.setCodigoSimcardGSM(cabecera.getParametroCodigoSimcardGSM());
		    datosGeneralesVenta.setIndicadorCuotas(cabecera.getParametros().getModalidadPagoDTO().getIndicadorCuotas());
		    datosGeneralesVenta.setTipoPlanHibrido(cabecera.getTipoPlanHibrido());
		    datosGeneralesVenta.setTipoPlanPostpago(cabecera.getTipoPlanPostpago());
		    datosGeneralesVenta.setCodigoEstrato(cabecera.getCod_estrato());
		    datosGeneralesVenta.setCodigoTecnologia(alta.getCodTecnologia());
		    datosGeneralesVenta.setCodigoCausaDescuento(alta.getCodCausaDescuento());
		    datosGeneralesVenta.setCodPlanServ(alta.getCodPlanServicio());
		    datosGeneralesVenta.setCodLimiteConsumo(alta.getCodLimiteConsumo());
		    datosGeneralesVenta.setCodTipoCliente(alta.getCodTipoCliente());
		    datosGeneralesVenta.setCodigoArticuloTerminal(alta.getCodArticuloSerieTerminal());
		    datosGeneralesVenta.setTipoPrimariaCarrier(alta.getTipoPrimariaCarrier());
		    
		    if(cabecera.getCod_cuota() != null && !cabecera.getCod_cuota().trim().equals(""))
		    {
		    	datosGeneralesVenta.setCodCuota(Long.valueOf(cabecera.getCod_cuota()));	
		    }		    
		    //Se setea codigo del terminal externo
		    datosGeneralesVenta.setCodigoArticuloTerminal(cabecera.getCodigoArticuloTerminal());
		    datosGeneralesVenta.setNumMesesContrato(new Long(cabecera.getParametros().getContrato().getNumeroMesesSeleccionado()));
		    
			int corrLinea = 1;
			int numOrden = 0;
			boolean OkCreaLinea = true;
	
			//-- Seteamos para registro de campañas vigentes
			if( cabecera.getParametros() != null && cabecera.getParametros().getCampanaVigente() != null &&
					cabecera.getParametros().getCampanaVigente().getCodigoCampanasVigentes() != null && 
					!cabecera.getParametros().getCampanaVigente().getCodigoCampanasVigentes().trim().equals(""))
			{
				datosGeneralesVenta.setCodigoCampana(cabecera.getParametros().getCampanaVigente().getCodigoCampanasVigentes());
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				CampanaVigente CampanaBO = new CampanaVigente();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
				campanaVigenteDTO = CampanaBO.getCampanaVigente(campanaVigenteDTO);
				datosGeneralesVenta.setAplicaCampanaA(campanaVigenteDTO.getAplicaA());
			}
			
			for(int i=0;i<detalleArchivo.length;i++)
			{
				ParametrosValidacionDTO lineaDetalle = new ParametrosValidacionDTO();
				lineaDetalle = detalleArchivo[i];
	
				datosGeneralesVenta.setCodigoPlanTarifario(lineaDetalle.getCodigoPlanTarifario());
				datosGeneralesVenta.setNumeroSerieSimcard(lineaDetalle.getNumeroSerie());
				datosGeneralesVenta.setNumeroSerieTerminal(lineaDetalle.getNumeroSerieTerminal());
				datosGeneralesVenta.setNumeroCelular(lineaDetalle.getNumeroCelular());
				datosGeneralesVenta.setEstadoSerieSimcard((lineaDetalle.getEstadoNuevoSimcard()));
				datosGeneralesVenta.setCorrelativoLinea(corrLinea);
				datosGeneralesVenta.setNumeroOrden(numOrden);
				
				/* DATOS HOME DE LA LINEA */
				HomeLineaDTO home = new HomeLineaDTO();						
				home.setNum_icc(datosGeneralesVenta.getNumeroSerieSimcard());				
				home.setCod_vendedor(Long.valueOf(datosGeneralesVenta.getCodigoVendedor()));
				home.setCod_planTarif(datosGeneralesVenta.getCodigoPlanTarifario());
				home.setCod_actabo(cabecera.getCod_actabo());				
				
				/* Se setean los datos que vienen desde la pantalla */
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_region() : " + alta.getCodRegion());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_provincia() : " + alta.getCodProvincia());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_ciudad() : " + alta.getCodCiudad());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_celda() : " + alta.getCodCelda());
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getCod_central() : " + alta.getCodCentral());				
				logger.debug(" ActivacionMasivaORQ obtieneHomeLinea.getNum_Celular() : " + alta.getNumCelular());
				
				datosGeneralesVenta.setCodigoRegion(alta.getCodRegion());
				datosGeneralesVenta.setCodigoProvincia(alta.getCodProvincia());
				datosGeneralesVenta.setCodigoCiudad(alta.getCodCiudad());
				datosGeneralesVenta.setCodigoCelda(alta.getCodCelda());
				datosGeneralesVenta.setCodigoCentral(alta.getCodCentral());
				datosGeneralesVenta.setNumeroCelular(alta.getNumCelular());
				datosGeneralesVenta.setCodUso(alta.getCodUsoLinea());
				datosGeneralesVenta.setCodigoPlanIndemnizacion(alta.getCodIndemnizacion());
				datosGeneralesVenta.setCodGrupoPrestacion(alta.getCodGrpPrestacion());
				datosGeneralesVenta.setCodTipPrestacion(alta.getCodTipoPrestacion());
				datosGeneralesVenta.setCodNivel1(alta.getCodNivel1());
				datosGeneralesVenta.setCodNivel2(alta.getCodNivel2());
				datosGeneralesVenta.setCodNivel3(alta.getCodNivel3());
				datosGeneralesVenta.setCodigoSeguro(alta.getCodigoSeguro());
				datosGeneralesVenta.setImporteEquipo(alta.getImporteSeguro());
				datosGeneralesVenta.setFechaVigenciaSeguro(alta.getVigenciaSeguro());
				datosGeneralesVenta.setMontoPreautorizado(alta.getMontoPreAutorizado());
				datosGeneralesVenta.setCodMoneda(alta.getCodMoneda());
				datosGeneralesVenta.setValorRefXMinuto(alta.getValorRefPorMinuto());
				datosGeneralesVenta.setObsInstancia(alta.getObservacion());
				datosGeneralesVenta.setDesArticuloTerminal(alta.getDescArticuloEquipo());
				datosGeneralesVenta.setFlgSerieKit(alta.getFlgSerieKit());
				datosGeneralesVenta.setImpLimiteConsumo(alta.getImpLimiteConsumo());	
				datosGeneralesVenta.setNumFax(alta.getNumFax());
				datosGeneralesVenta.setCodigoCalificacion(alta.getCodCalificacion());
				
			    corrLinea++;
				numOrden++;
				
				datosGeneralesVenta.setServSuplAdicionales(cabecera.getServSuplAdicionales());	
				datosGeneralesVenta.setIndRenovacion(alta.getIndRenovacion());
				datosGeneralesVenta  = ventasFacade.crearLineaWeb( datosGeneralesVenta, alta.getUsuario() );	
				
				OkCreaLinea = true;
				if (datosGeneralesVenta.getEstadoError().equals("NOK"))	
				{				
					OkCreaLinea = false;
				}else {	
					
					//Inicio P-CSR-11002 JLGN 21-04-2011 Inserta Planes Acidionales Seleccionados
					/*Obtiene secuencia movimiento a centrales */
					logger.debug("Inicio Inserta PA Normal");
					DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
					datosGrales.setCodigoSecuencia(config.getString("secuencia.movimiento.central"));
					datosGrales = datosGeneralesBO.getSecuencia(datosGrales);										
					ventasFacade.insertaPANormal(alta,datosGeneralesVenta.getNum_abonado(),datosGrales.getSecuencia());					
					datosGeneralesVenta.setNumMovimiento(datosGrales.getSecuencia());
					logger.debug("Fin Inserta PA Normal");					
					//Fin P-CSR-11002 JLGN 21-04-2011
					
					//Registra lista de contactos servicio 911
					if(alta.getListaContactos() != null){
						ServSupl911CorreoFaxFacade serv911Facade=getServSupl911CorreoFaxFacade();
						for(int k=0;k<alta.getListaContactos().length;k++)
						{
							GaContactoAbonadoToDTO contacto = new GaContactoAbonadoToDTO();
							contacto.setNumContacto(k+1);
							contacto.setApellido1Contacto(alta.getListaContactos()[k].getApellido1Contacto());
							contacto.setApellido2Contacto(alta.getListaContactos()[k].getApellido2Contacto());
							contacto.setNombreContacto(alta.getListaContactos()[k].getNombreContacto());
							contacto.setNomUsuarora(alta.getListaContactos()[k].getNomUsuarora());
							contacto.setCodParentesco(alta.getListaContactos()[k].getCodParentesco());
							contacto.setPlacaVehicular(alta.getListaContactos()[k].getPlacaVehicular());
							contacto.setNumAbonado(datosGeneralesVenta.getNum_abonado().longValue());
							contacto.setCodServicio(alta.getListaContactos()[k].getCodServicio());
							contacto.setAnioVehiculo(alta.getListaContactos()[k].getAnioVehiculo());
							contacto.setColorVehiculo(alta.getListaContactos()[k].getColorVehiculo());
							contacto.setNomUsuarora(alta.getNombreUsuarOra());		
							contacto.setTelefono(alta.getListaContactos()[k].getTelefono());
							
							//Creacion de direccion							
							DireccionNegocioWebDTO dir = new DireccionNegocioWebDTO();
							dir.setCodDepartamento(alta.getListaContactos()[k].getCodRegion());
							dir.setCodigoPostalDireccion(alta.getListaContactos()[k].getZip());
							dir.setCodMunicipio(alta.getListaContactos()[k].getCodProvincia());
							dir.setCodZonaDistrito(alta.getListaContactos()[k].getCodCiudad());
							
							// Incidencia 134089: setear el valor de comuna (Loc/Barrio)
							dir.setLocBarrio(alta.getListaContactos()[k].getCodComuna());
							dir.setDesDirec1(alta.getListaContactos()[k].getDesDirec1());
							
							dir.setNombreCalle(alta.getListaContactos()[k].getNomCalle());
							dir.setNumeroCalle(alta.getListaContactos()[k].getNumCalle());
							dir.setObservacionDireccion(alta.getListaContactos()[k].getObsDireccion());
							
							Long codDireccion = ventasFacade.creaDireccion(dir);
							contacto.setCodDireccion(codDireccion.longValue());							
							
							serv911Facade.insertGaContactoAbonadoTO(contacto);						
						}
					}
					
					
					//Registra numeros sms
					if(alta.getListaNumerosSMS() != null){						
						for(int k=0;k<alta.getListaNumerosSMS().length;k++)
						{
							FormularioNumerosSMSDTO numSMS = new FormularioNumerosSMSDTO();							
							numSMS.setNumAbonado(datosGeneralesVenta.getNum_abonado().longValue());
							numSMS.setNumeroCortoValor(alta.getListaNumerosSMS()[k].getNumeroCortoValor());
							numSMS.setNomUsuarora(alta.getNombreUsuarOra());							
							ventasFacade.insertaNumerosSMS(numSMS);						
						}
						
					}
				}//fin else ok linea
				if(alta.getCodTipoSolicitud().trim().equals(config.getString("tipo.solicitud.scoring")) || 
						alta.getActualizadaScoringNormal() == 1)
				{
					ventasFacade.updLineaScoringReplicada(new Long(alta.getNumLineaScoring()), datosGeneralesVenta.getNum_abonado() );
				}
			}
			
			//-- Registra campaña a nivel de cliente
			if (datosGeneralesVenta.getAplicaCampanaA() != null && 
					datosGeneralesVenta.getAplicaCampanaA().equals(config.getString("aplica.campana.a.cliente"))
					&& datosGeneralesVenta.getCodigoCampana() != null )
			{
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
				campanaVigenteDTO.setCodigoCliente(Long.parseLong(cabecera.getCodigoCliente()));
				campanaVigenteDTO.setNumeroAbonado(-1);				
				ventasFacade.registraCampanaVigente(campanaVigenteDTO);				
			}			
			logger.debug("Fin:crearLineas()");
		} catch (VentasException e) {			
			logger.debug("VentasException", e);
			context.setRollbackOnly();			
			throw e;
		} catch (RemoteException e) {
			logger.debug("RemoteException", e);
			context.setRollbackOnly();			
			throw new VentasException(e);
		}	
		return datosGeneralesVenta;
				
	}//fin crearLineas
	
	/**
	* Obtiene los parametros Generales.
	* 
	* @param cust
	* @return
	* @throws VentasException
	*/
	public ContratosDTO getListadoContratosCliente(ContratosDTO contrato) 
		throws VentasException,RemoteException
	{
		ContratosDTO resultado = new ContratosDTO();
		ContratoDTO contratoParametro = new ContratoDTO();
		ContratoDTO contratoSalida = new ContratoDTO(); 
		contratoParametro.setCodigoCliente(contrato.getCodigoCliente());
		contratoParametro.setCodigoTipoContrato(contrato.getCodigoTipoContrato());
		contratoSalida = getVentasFacade().listadoContratosCliente(contratoParametro);
		resultado.setContratos(contratoSalida.getContratos());
		resultado.setCodigoCliente(contrato.getCodigoCliente());
		resultado.setCodigoTipoContrato(contrato.getCodigoTipoContrato());		
		return resultado;
	}
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametrosComercialesDTO getParametrosComerciales (CabeceraArchivoCOLDTO objetoSesion) 
		throws VentasException,RemoteException
	{
		logger.debug("getParametrosComerciales():start");
		ParametrosComercialesDTO resultado = new ParametrosComercialesDTO();
		DatosComercialesDTO datosComerciales = new DatosComercialesDTO(); 
		ClienteDTO cliente = new ClienteDTO();
		VendedorDTO vendedor = new VendedorDTO();
		try {
			VentasFacadeSTL ventasFacade = getVentasFacade();
			datosComerciales.setCodigoCliente(objetoSesion.getCodigoCliente());
			cliente.setCodigoCliente(objetoSesion.getCodigoCliente());
			datosComerciales.setCodigoDealer(objetoSesion.getCodigoDealer());
			datosComerciales.setCodigoVendedor(objetoSesion.getCodigoVendedor());
			vendedor.setCodigoVendedor(objetoSesion.getCodigoVendedor());
			vendedor.setCodigoVendedorDealer(objetoSesion.getCodigoVenDealer());
			datosComerciales.setIdentificadorEmpresa(objetoSesion.getIdentificadorEmpresa());
			datosComerciales.setNombreUsuario(objetoSesion.getNombreUsuario());
			//Busca Datos del Cliente
			cliente = ventasFacade.getCliente(cliente);			
			resultado.setCodigoCliente(cliente.getCodigoCliente());
			resultado.setNombreCliente(cliente.getNombreCliente());
			resultado.setCodigoTipoIdentificacion(cliente.getCodigoTipoIdentificacion());
			resultado.setNumeroIdentificacion(cliente.getNumeroIdentificacion());
			resultado.setCodigoActividadCliente(cliente.getCodigoActividad());
			resultado.setCodigoCalidadCliente(cliente.getCodigoCalidadCliente());
			resultado.setCodigoCeldaCliente(cliente.getCodigoCelda());
			resultado.setCodigoCicloCliente(cliente.getCodigoCiclo());
			resultado.setCodigoCuentaCliente(cliente.getCodigoCuenta());
			resultado.setFechaNacimientoCliente(cliente.getFechaNacimiento());
			resultado.setIndicadorEstadoCivilCliente(cliente.getIndicadorEstadoCivil());
			resultado.setIndicadorSexoCliente(cliente.getIndicadorSexo());
			resultado.setIndicativoFacturableCliente(cliente.getIndicativoFacturable());
			resultado.setNombreApellido1Cliente(cliente.getNombreApellido1());
			resultado.setNombreApellido2Cliente(cliente.getNombreApellido2());
			resultado.setCodigoOperadora(cliente.getCodigoOperadora());
			if (cliente.getDirecciones()!=null)
				resultado.setDireccionCliente(cliente.getDirecciones()[0]);
			resultado.setCodigoEmpresa(cliente.getCodigoEmpresa());
			resultado.setPlanComercialCliente(cliente.getPlanComercial());
			/*--Busca datos del Vendedor--*/
			vendedor = ventasFacade.getVendedor(vendedor);
			resultado.setCodigoVendedor(vendedor.getCodigoVendedor());
			resultado.setNombreVendedor(vendedor.getNombreVendedor());
			resultado.setCodigoVenDealer(vendedor.getCodigoVendedorDealer());
			resultado.setCodigoVendedorRaiz(vendedor.getCodigoVendedorRaiz());
			resultado.setDireccionVendedor(vendedor.getDireccion());
			resultado.setOficinaVendedor(vendedor.getCodigoOficina());
			resultado.setCodigoTipoComisionista(vendedor.getCodTipComisionista());
			resultado.setDescripcionTipoComisionista(vendedor.getDesTipComisionista());
			resultado.setIndicadorTipoVenta(vendedor.getIndicadorTipoVenta());
			resultado.setCampanasVigentes(ventasFacade.getListadoCampanasVigentes());
			resultado.setCausalDescuento(ventasFacade.getListadoCausalDescuento(new Long(objetoSesion.getCodUsoLinea())));
			CreditoConsumoDTO creditoConsumo = new CreditoConsumoDTO();
			creditoConsumo.setCodigoCliente(objetoSesion.getCodigoCliente());
			resultado.setCreditoConsumo(ventasFacade.getListadoCreditoConsumo(creditoConsumo));
			resultado.setCreditoMorosidad(ventasFacade.getListadoCreditoMorosidad(datosComerciales));
			resultado.setGrupoAfinidad(ventasFacade.getListadoGrupoAfinidad(datosComerciales));
			//resultado.setGrupoCobroServicio(ventasFacade.getListadoGrupoCobroServicio());
			resultado.setListaPlanIndemnizacion(ventasFacade.getListadoPlanIndemnizacion());
			//resultado.setListaPlanServicio(ventasFacade.getListadoPlanServicio());
			ContratoDTO contrato = new ContratoDTO();			
			contrato.setNombreUsuario(objetoSesion.getNombreUsuario());			
			datosPrograma.setCodigoPrograma(config.getString("programa.codigo"));			
			datosPrograma.setNumeroVersion(Integer.parseInt(config.getString("programa.version")));			
			datosPrograma.setNumeroSubVersion(Integer.parseInt(config.getString("programa.subversion")));			
			contrato.setDatosPrograma(datosPrograma);	
			contrato.setTipoCliente(objetoSesion.getTipoCliente());
			ContratoDTO[] tipodeContratos =ventasFacade.getListadoTipoContrato(contrato);
			int ilargoTipoContratos = tipodeContratos.length;
			List listaTipoContrato = new ArrayList();
			for (int i = 0; i<ilargoTipoContratos;i++){
				ContratosDTO tipoContratoDTO = new ContratosDTO();
				tipoContratoDTO.setCodigoTipoContrato(tipodeContratos[i].getCodigoTipoContrato());
				tipoContratoDTO.setDescripcionTipoContrato(tipodeContratos[i].getDescripcionTipoContrato());
				listaTipoContrato.add(tipoContratoDTO);
			}			
			ContratosDTO[] listadoTipoContratos =(ContratosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaTipoContrato.toArray(), ContratosDTO.class);			
			resultado.setListaTipoContrato(listadoTipoContratos);			
			resultado.setDocumento(ventasFacade.getListadoTipoDocumento(datosComerciales));			
			resultado.setRegion(ventasFacade.getListadoRegiones());									
			logger.debug("getParametrosComerciales():despues");		
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getParametrosComerciales():end");
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CabeceraArchivoDTO getParametrosGenerales(CabeceraArchivoCOLDTO objetoSesion) 
		throws VentasException, RemoteException
	{
		logger.debug("getParametrosGenerales():start");
		ParametroDTO parametroEntrada = new ParametroDTO();
		try {		
			parametroEntrada.setCodigoParametro(config.getString("parametro.calcliente"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);			
			
			objetoSesion.setParametroCalCliente(parametroEntrada.getValorParametro());
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoParametro(config.getString("parametro.codabc"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
		    objetoSesion.setParametroCodigoAbc(parametroEntrada.getValorParametro());		    
			
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoParametro(config.getString("parametro.cod123"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setParametroCodigo123(parametroEntrada.getValorParametro());			
			
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoParametro(config.getString("parametro.codigo.estadocobro"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setParametroCodigoEstadoCobros(parametroEntrada.getValorParametro());			
			
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoParametro(config.getString("parametro.codigo.terminalgsm"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.AL"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setParametroCodigoTerminalGSM(parametroEntrada.getValorParametro());			
			
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoParametro(config.getString("parametro.codigo.simcardgsm"));
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.AL"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setParametroCodigoSimcardGSM(parametroEntrada.getValorParametro());			
			
			//-- OBTENER VALOR TIPO PLAN PREPAGO
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada.setCodigoParametro(config.getString("parametro.tipoplan.postpago"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setTipoPlanPostpago(parametroEntrada.getValorParametro());			
			
			//-- OBTENER VALOR TIPO PLAN HIBRIDO
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametroEntrada.setCodigoParametro(config.getString("parametro.tipoplan.hibrido"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			objetoSesion.setTipoPlanHibrido(parametroEntrada.getValorParametro());			
			
		    //-- OBTIENE CANTIDAD DE DECIMALES UTILIZADOS EN SISCEL Y EN EL FORMATO DE NUMEROS DE LOS FORMULARIOS
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GE"));
			parametroEntrada.setCodigoParametro(config.getString("parametro.decimal.siscel"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			if(parametroEntrada.getValorParametro() != null)
			{
				objetoSesion.setDecimalesFormulario(Integer.parseInt(parametroEntrada.getValorParametro()));
			}
			
		    //-- OBTIENE CANTIDAD DE DECIMALES UTILIZADOS EN FACTURACION Y PARA ALMACENAR EN BD
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GE"));
			parametroEntrada.setCodigoParametro(config.getString("parametro.decimal.facturacion"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			if(parametroEntrada.getValorParametro() != null)
			{
				objetoSesion.setDecimalesBD(Integer.parseInt(parametroEntrada.getValorParametro()));
			}
			
		    //-- OBTIENE CANTIDAD DE DECIMALES UTILIZADOS PARA FORMATEAR LOS PORCENTAJES DE DESCUENTOS
			parametroEntrada = new ParametroDTO();
			parametroEntrada.setCodigoProducto(config.getString("codigo.producto"));
			parametroEntrada.setCodigoModulo(config.getString("codigo.modulo.GE"));
			parametroEntrada.setCodigoParametro(config.getString("parametro.decimal.descuento"));
			parametroEntrada = getVentasFacade().getValorParametro(parametroEntrada);
			if(parametroEntrada.getValorParametro() != null)
			{
				objetoSesion.setDecimalesPorcentajeDescuento(Integer.parseInt(parametroEntrada.getValorParametro()));
			}
			objetoSesion.setTipoVentaOficinaTerreno(config.getString("venta.oficina"));
			objetoSesion.setIndTelefono(Long.valueOf(config.getString("indicador.telefono")));
			
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getParametrosGenerales():end");
		return objetoSesion;
	}
	
	public ListadoCeldaDTO[] getListadoCeldas(CiudadDTO entrada)
		throws VentasException,RemoteException
	{
		logger.debug("getListadoCeldas():start");
		ListadoCeldaDTO[] resultado = null;
		try {
		
			CeldaDTO[] celdas = null;
			celdas = getVentasFacade().getListadoCeldas(entrada);
			if (celdas != null){
				logger.debug("largo de listado de celdas" + celdas.length);
				if (celdas.length>0){
					ArrayList lista = new ArrayList();
					for (int i=0;i<celdas.length;i++){
						ListadoCeldaDTO celdaAuxiliar = new ListadoCeldaDTO();
						celdaAuxiliar.setCodigoCelda(celdas[i].getCodigoCelda());
						celdaAuxiliar.setDescripcionCelda(celdas[i].getDescripcionCelda());
						lista.add(celdaAuxiliar);
					}
					resultado =(ListadoCeldaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							lista.toArray(), ListadoCeldaDTO.class);
				}	
			}
		} catch (VentasException e) {
			logger.debug("VentasException");	
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCeldas():end");
		return resultado;
	}
	
	/**
	* Obtiene Listado de Centrales
	* utilizado para que el usuario selecciona una de ellas en el proceso
	* de parametros comerciales.
	* @param cabecera
	* @return resultado
	* @throws VentasException, RemoteException
	*/
	
	public ListadoCentralDTO[] getListadoCentrales(ListadoCeldaDTO entrada)
		throws VentasException,RemoteException
	{
		logger.debug("getListadoCentrales():start");
		ListadoCentralDTO[] resultado = null;
		try {
			CeldaDTO celda = new CeldaDTO();
			celda.setCodigoCelda(entrada.getCodigoCelda());
			celda.setCodigoProducto(config.getString("codigo.producto"));
			celda = getVentasFacade().obtieneDatosCelda(celda);
			CentralDTO[] centrales = null;
			centrales = getVentasFacade().getListadoCentrales(celda);
			if (centrales !=null){
				if (centrales.length>0){
					ArrayList lista = new ArrayList();
					for (int i=0;i<centrales.length;i++){
						ListadoCentralDTO centralAuxiliar = new ListadoCentralDTO();
						centralAuxiliar.setCodigoCentral(centrales[i].getCodigoCentral());
						centralAuxiliar.setDescripcionCentral(centrales[i].getDescripcionCentral());
						lista.add(centralAuxiliar);
					}
					resultado =(ListadoCentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							lista.toArray(), ListadoCentralDTO.class);
				}
			}
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCentrales():end");
		return resultado;
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
	public CabeceraArchivoDTO getParametrosVenta(CabeceraArchivoCOLDTO cabecera) 
		throws VentasException, RemoteException
	{
		logger.debug("getParametrosVenta():start");
		try {
			RegistroVentaDTO registroVta = new RegistroVentaDTO();
		    //Obtiene numero de venta
			registroVta = getVentasFacade().getSecuenciaVenta();
			cabecera.setNumeroVenta(registroVta.getNumeroVenta());
			//obtiene numero de transaccion de venta
			registroVta = getVentasFacade().getSecuenciaTransacabo();			
			cabecera.setNumeroTransaccionVenta(registroVta.getNumeroTransaccionVenta());			
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getParametrosVenta():end");
		return cabecera;
	}
	
	/**
	* Obtiene Cargos
	* @param cabecera
	* @return resultado
	* @throws VentasException, RemoteException
	*/
	public RegCargosDTO obtieneCargos(CabeceraArchivoDTO cabecera) 
		throws VentasException, RemoteException
	{
		logger.debug("obtieneCargos():start");
		RegCargosDTO resultado = new RegCargosDTO();
		CargoDTO[] arregloCargos =null;
		List listaCargos = new ArrayList();
		try {
			ParametrosObtencionCargosDTO parametros = obtieneParametrosCargos(cabecera);
			ObtencionCargosDTO objetoCargos =getVentasFacade().obtenerCargos(parametros);			
			CargosDTO[] cargos =objetoCargos.getCargos();
			if (cargos !=null){
				if (cargos.length>0){
					for (int i=0;i<cargos.length;i++)
					{						
						CargoDTO cargo = new CargoDTO();
						cargo.setCodigoArticuloServicio(cargos[i].getAtributo().getCodigoArticuloServicio());
						cargo.setTipoProducto(cargos[i].getAtributo().getTipoProducto());
						cargo.setCantidad(cargos[i].getCantidad());
						PrecioDTO precio = cargos[i].getPrecio();
						cargo.setCodigoConceptoPrecio(precio.getCodigoConcepto());
						cargo.setDescripcionConceptoPrecio(precio.getDescripcionConcepto());
						cargo.setMontoConceptoPrecio(new Double(precio.getMonto()).floatValue());
						cargo.setCodigoMoneda(precio.getUnidad().getCodigo());
						cargo.setDescripcionMoneda(precio.getUnidad().getDescripcion());
						cargo.setInd_equipo(precio.getDatosAnexos().getInd_equipo());
						cargo.setInd_paquete(precio.getDatosAnexos().getInd_paquete());
						cargo.setNum_abonado(precio.getDatosAnexos().getNum_abonado());
						cargo.setNum_terminal(precio.getDatosAnexos().getNum_terminal());
						cargo.setNum_serie(precio.getNroSerie());
						cargo.setCod_bodega(precio.getCodBodega());						
						DescuentoDTO[] arregloDescuento = cargos[i].getDescuento();				
						
						if (arregloDescuento!=null)
							if (arregloDescuento.length>0)
							{
								/*Recorre los descuentos. Si existe descuento automatico se asigna este como descuento del cargo, 
								en caso contrario toma el código del descuento manual. Si existen los dos tipos de descuentos toma
								el codigo concepto del descuento automatico*/
								for (int k=0;k<arregloDescuento.length;k++)
								{
									if (arregloDescuento[k].getTipo()==null)
									{
										if (arregloDescuento[k].getCodigoConcepto()!=null && cargo.getCodigoDescuento()==null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
									}else if (arregloDescuento[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)))
									{
										if (arregloDescuento[k].getCodigoConcepto()!=null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
										cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
										cargo.setMontoDescuento(arregloDescuento[k].getMonto());
										cargo.setTipoDescuento(arregloDescuento[k].getTipoAplicacion());	
										cargo.setCodigoMonedaDescuento(arregloDescuento[k].getCodMoneda());
									}																		
								}														
							}else{
								cargo.setCodigoDescuento("");
								cargo.setMontoDescuento(0);
							}								
						else{
							cargo.setMontoDescuento(0);
						}
						cargo.setDescuentoManual(1);						
						listaCargos.add(cargo);											
					}
				}
			}
			arregloCargos =(CargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCargos.toArray(), CargoDTO.class);
			resultado.setAplicaDescuentoVendedor(objetoCargos.isAplicaDescuentoVendedor());
			logger.debug("Tiene Permiso vendedor: " + resultado.isAplicaDescuentoVendedor());
			if (resultado.isAplicaDescuentoVendedor()){
				resultado.setPorcentajeDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
				resultado.setPorcentajeDesctoSuperior(objetoCargos.getPorcentajeDesctoSuperior());
				resultado.setPuntoDesctoInferior(objetoCargos.getPorcentajeDesctoInferior());
				resultado.setPuntoDesctoSuperior(objetoCargos.getPuntoDesctoSuperior());
			}
			resultado.setCargos(arregloCargos);			
			logger.debug("YA RECORRIMOS LISTA DE ABONADOS");		
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneCargos():end");
		return resultado;
	}	
	
	/**
	* Metodo Privado que obtiene datos anexos para la busqueda 
	* de los cargos asociados a la venta
	* @param cabecera
	* @return parametros
	* @throws 
	*/
	
	private ParametrosObtencionCargosDTO obtieneParametrosCargos(CabeceraArchivoDTO cabecera)
	{
		ParametrosObtencionCargosDTO parametros = new ParametrosObtencionCargosDTO();
		parametros.setCodigoCliente(cabecera.getCodigoCliente());
		parametros.setNumeroVenta(String.valueOf(cabecera.getNumeroVenta()));
		parametros.setNumeroMesesContrato(cabecera.getParametros().getContrato().getNumeroMesesSeleccionado());
		parametros.setIndicadorTipoVenta(cabecera.getIndicadorTipoVenta());
		parametros.setNumeroCuotas(cabecera.getParametros().getNumeroCuotas().getCodigo());
		parametros.setTipoPlanHibrido(cabecera.getTipoPlanHibrido());
		parametros.setTipoPlanPostPago(cabecera.getTipoPlanPostpago());
		parametros.setCodigoModalidadVenta(cabecera.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
		parametros.setTipoContrato(cabecera.getParametros().getContrato().getCodigoTipoContrato());
		parametros.setIndComodato(cabecera.getParametros().getContrato().getIndComodato());
		parametros.setCodigoVendedor(cabecera.getCodigoVendedor());		
		if(cabecera.getCodigoVenDealer() != 0)
		{
			parametros.setCanalVendedor("I");
			parametros.setIndicadorTipoVenta(1);
		}else{
			parametros.setCanalVendedor("D");
			parametros.setIndicadorTipoVenta(0);
		}
		
		parametros.setNum_abonado(cabecera.getNum_abonado());
		parametros.setNum_terminal(cabecera.getNum_terminal());
		//Ocupado para mayorista		
		parametros.setProcTerminal(cabecera.getProc_equipo());
		
		parametros.setCodUsoVenta(cabecera.getCodUsoLinea());
		parametros.setCodOficina(cabecera.getOficinaVendedor());
		
		//release II
		parametros.setCod_actabo(cabecera.getCod_actabo());
		
		//Guatemala - El Salvador
		parametros.setCodigoCalificacion(cabecera.getCodigoCalificacion());
		
		parametros.setIndRenovacion(cabecera.getIndRenovacion());//EV 08/01/10
		
		return parametros;
	}	
	
	
	/**
	* Crea la Venta, registra los cargos, ejecuta prebilling y preliquidación y obtiene impuestos 
	* de los cargos asociados a la venta.
	* Es necesario crear la venta antes de ejecutar el Prebilling, lo cual es un mal diseño, esta 
	* mal implementado y debiera realizarse este insert en el cierre de la venta. Fernando Garcia.
	* @param cabecera
	* @return parametros
	 * @throws GeneralException 
	* @throws 
	*/
	
	public ResultadoRegCargosDTO registrarCargos(RegCargosDTO listadoCargos)
		throws RemoteException, GeneralException
	{
		logger.debug("registrarCargos():start");
		VentasFacadeSTL ventasFacade = getVentasFacade();
		/*Setea los datos necesarios para crear registro en tabla GA_VENTA*/		
		GaVentasDTO gaVentasDTO = new GaVentasDTO();		
		gaVentasDTO.setNumVenta(new Long(listadoCargos.getObjetoSesion().getNumeroVenta()));		
		gaVentasDTO.setCodOficina(listadoCargos.getObjetoSesion().getOficinaVendedor());		
		gaVentasDTO.setCodTipcomis(listadoCargos.getObjetoSesion().getParametros().getTipoComisionista().getCodigoTipoComisionista());			
		gaVentasDTO.setCodVendedor(new Long (listadoCargos.getObjetoSesion().getCodigoVendedor()));		
		gaVentasDTO.setCodVendedorAgente(new Long (listadoCargos.getObjetoSesion().getCodigoVendedorRaiz()));
		gaVentasDTO.setCodRegion(listadoCargos.getObjetoSesion().getParametros().getRegion().getCodigoRegion());
		gaVentasDTO.setCodProvincia(listadoCargos.getObjetoSesion().getParametros().getProvincia().getCodigoProvincia());		
		gaVentasDTO.setCodCiudad(listadoCargos.getObjetoSesion().getParametros().getCiudad().getCodigoCiudad());		
		gaVentasDTO.setNumTransaccion(new Long (listadoCargos.getObjetoSesion().getNumeroTransaccionVenta()));		
		gaVentasDTO.setIndVenta(String.valueOf(listadoCargos.getObjetoSesion().getIndicadorTipoVenta()));
		gaVentasDTO.setCodCliente(new Long(listadoCargos.getObjetoSesion().getCodigoCliente())); 
		gaVentasDTO.setCodModVenta(new Long(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));
		gaVentasDTO.setCodCuota(listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo());
		gaVentasDTO.setNumContrato(listadoCargos.getObjetoSesion().getParametros().getContrato().getNumeroContrato());
		gaVentasDTO.setCodTipContrato(listadoCargos.getObjetoSesion().getParametros().getContrato().getCodigoTipoContrato());		
		gaVentasDTO.setNomUsuarVta(listadoCargos.getObjetoSesion().getNombreUsuario());		
		gaVentasDTO.setCodVenDealer(new Long(listadoCargos.getObjetoSesion().getCodigoVenDealer()));
		gaVentasDTO.setCodTipDocumento(listadoCargos.getObjetoSesion().getCodigoDocumento());		
		gaVentasDTO.setAciclo(listadoCargos.getObjetoSesion().isFacturaCiclo());
		if(gaVentasDTO.getCodModVenta().intValue() == 1)
		{
			gaVentasDTO.setTipValor(Long.valueOf(config.getString("forma.pago.efectivo")));
		}
		//gaVentasDTO.setIndPasoCob(new Long(0));//valor por defecto obtenido de la BD
		gaVentasDTO.setCodOperadora(listadoCargos.getObjetoSesion().getCodigoOperadora());
		gaVentasDTO.setCodModPago(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
		gaVentasDTO.setFormPago(listadoCargos.getObjetoSesion().getCodigoFormaPago());
		gaVentasDTO.setIndTipVenta(new Long (listadoCargos.getObjetoSesion().getIndicadorTipoVenta()));
		datosPrograma.setCodigoPrograma(config.getString("programa.codigo"));
		datosPrograma.setNumeroVersion(Integer.parseInt(config.getString("programa.version")));
		datosPrograma.setNumeroSubVersion(Integer.parseInt(config.getString("programa.subversion")));
		gaVentasDTO.setDatosPrograma(datosPrograma);
		gaVentasDTO.setIndOfiter(listadoCargos.getObjetoSesion().getInd_ofiter());
		gaVentasDTO.setCodTipoSolicitud(listadoCargos.getObjetoSesion().getCodTipoSolicitud());
		
		/*--Realiza el cierre de la venta--*/		
		ventasFacade.creaVenta(gaVentasDTO);
		logger.debug("CierreVenta():start");
		
		ResultadoRegCargosDTO resultado = new ResultadoRegCargosDTO();
		List listaCargos = new ArrayList();
		
		//Registra Cargos
		ParametrosRegistroCargosDTO parametrosCargos = new ParametrosRegistroCargosDTO();
		int iNumeroCargos =listadoCargos.getCargos().length; 
		parametrosCargos.setCodigoCliente(listadoCargos.getObjetoSesion().getCodigoCliente());
		parametrosCargos.setNumeroVenta(String.valueOf(listadoCargos.getObjetoSesion().getNumeroVenta()));
		parametrosCargos.setNumeroTransaccion(String.valueOf(listadoCargos.getObjetoSesion().getNumeroTransaccionVenta()));
		parametrosCargos.setCodigoPlanComercial(listadoCargos.getObjetoSesion().getPlanComercialCliente());
		parametrosCargos.setCodigoOficina(listadoCargos.getObjetoSesion().getOficinaVendedor());
		parametrosCargos.setCategoriaTributaria(listadoCargos.getObjetoSesion().getCategoriaTributaria());
		parametrosCargos.setCodigoDocumento(listadoCargos.getObjetoSesion().getCodigoDocumento());
		parametrosCargos.setTipoFoliacion(listadoCargos.getObjetoSesion().getTipoFoliacion());
		parametrosCargos.setModalidadVenta(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
		parametrosCargos.setFacturacionaCiclo(listadoCargos.getObjetoSesion().isFacturaCiclo());
		parametrosCargos.setCodigoVendedor(listadoCargos.getObjetoSesion().getCodigoVendedor());
		parametrosCargos.setCodigoVendedorRaiz(listadoCargos.getObjetoSesion().getCodigoVendedorRaiz());
		parametrosCargos.setDatosPrograma(datosPrograma);
        parametrosCargos.setNombreUsuario(listadoCargos.getObjetoSesion().getNombreUsuario());
        parametrosCargos.setNumeroDecimalesBD(listadoCargos.getObjetoSesion().getDecimalesBD());
        parametrosCargos.setNumeroDecimalesPorDesc(listadoCargos.getObjetoSesion().getDecimalesPorcentajeDescuento());
		parametrosCargos.setDatosPrograma(datosPrograma);
		
		for (int i=0;i<iNumeroCargos;i++){			
			CargosDTO cargo = new CargosDTO();
			
			PrecioDTO precio = new PrecioDTO();
			precio.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoConceptoPrecio());
			precio.setMonto(listadoCargos.getCargos()[i].getMontoConceptoPrecio()/listadoCargos.getCargos()[i].getCantidad());
			MonedaDTO moneda = new MonedaDTO();
			moneda.setCodigo(listadoCargos.getCargos()[i].getCodigoMoneda());
			precio.setUnidad(moneda);	
			precio.setNroSerie(listadoCargos.getCargos()[i].getNum_serie());
			precio.setCodBodega(listadoCargos.getCargos()[i].getCod_bodega());
			
			DescuentoDTO[] arregloDescuento = new DescuentoDTO[2];			
			
			DescuentoDTO descuento = new DescuentoDTO();
			descuento.setTipo(String.valueOf(TipoDescuentos.Manual)); // Manual
			descuento.setTipoAplicacion(listadoCargos.getCargos()[i].getTipoDescuentoManual());//0-Monto 1-Porcentaje
			descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuentoManual());
			descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
			descuento.setCodMoneda(listadoCargos.getCargos()[i].getCodigoMonedaDescuento());
			arregloDescuento[0] = descuento;
			descuento = new DescuentoDTO();
			descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
			descuento.setTipo(String.valueOf(TipoDescuentos.Automatico)); // Automatico
			descuento.setTipoAplicacion(listadoCargos.getCargos()[i].getTipoDescuento());//0-Monto 1-Porcentaje
			descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuento());
			descuento.setCodMoneda(listadoCargos.getCargos()[i].getCodigoMonedaDescuento());
			arregloDescuento[1] = descuento;
			AtributosMigracionDTO atributo = new AtributosMigracionDTO();
			if (listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo()!=null &&
					!listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo().trim().equals(""))
			{	
				atributo.setCuotas(Integer.parseInt(listadoCargos.getObjetoSesion().getParametros().getNumeroCuotas().getCodigo()));
			}else {				
				atributo.setCuotas(0);
			}			
			atributo.setInd_equipo(listadoCargos.getCargos()[i].getInd_equipo());			
			atributo.setInd_paquete(listadoCargos.getCargos()[i].getInd_paquete());			
			atributo.setTipoProducto(listadoCargos.getCargos()[i].getTipoProducto());			
			atributo.setCodigoArticuloServicio(listadoCargos.getCargos()[i].getCodigoArticuloServicio());
			atributo.setInd_cuota(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getIndicadorCuotas());			
			cargo.setPrecio(precio);
			cargo.setDescuento(arregloDescuento);
			cargo.setAtributo(atributo);
			cargo.setCantidad(listadoCargos.getCargos()[i].getCantidad());
			
			cargo.setNum_abonado(listadoCargos.getCargos()[i].getNum_abonado());
			cargo.setNum_terminal(listadoCargos.getCargos()[i].getNum_terminal());
			
			listaCargos.add(cargo);			
		}

		CargosDTO[] arregloCargos =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				listaCargos.toArray(), CargosDTO.class);
		
		parametrosCargos.setCargos(arregloCargos);		
		try{
		ResultadoRegistroCargosDTO resultadoRegistro = ventasFacade.registrarCargos(parametrosCargos);
		FormasPagoDTO[] formasPago = ventasFacade.obtenerFormasPago(parametrosCargos);
		
		if (formasPago!=null)
		{
			List listaFormaPago = new ArrayList();
			int largoFormadePago = formasPago.length; 
			for (int i =1 ; i<largoFormadePago;i++)
			{
				FormadePagoDTO formadePago = new FormadePagoDTO();
				formadePago.setDescripcionTipoValor(formasPago[i].getDescripcionTipoValor());
				formadePago.setTipoValor(formasPago[i].getTipoValor());
				listaFormaPago.add(formadePago);
			}
			FormadePagoDTO[] arrayFormaPago =(FormadePagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaFormaPago.toArray(), FormadePagoDTO.class);
			resultado.setArregloFormasdePago(arrayFormaPago);
		}
		
		
		//Se saca ya que en GUATEMALA - EL SALVADOR el prebilliong se hace posteriormente
		/*if (resultadoRegistro!= null && resultadoRegistro.getImpuestos()!=null)
		{
			resultado.setNumeroProceso(resultadoRegistro.getImpuestos().getNumeroProceso());
			resultado.setTotalCargos(resultadoRegistro.getImpuestos().getTotalCargos());
			resultado.setTotalDescuentos(resultadoRegistro.getImpuestos().getTotalDescuentos());
			resultado.setTotalImpuestos(resultadoRegistro.getImpuestos().getTotalImpuestos());
		}
		else{
			if (arregloCargos != null && arregloCargos.length>0 && !listadoCargos.getObjetoSesion().isFacturaCiclo()){
		    	throw new VentasException("No se pudo rescatar los impuestos");
			}
		}*/		
		}catch (GeneralException e) {
			logger.error("GeneralException");
			logger.error("e.getCodigo() [" + e.getCodigo() + "]");
			logger.error("e.getDescripcionEvento() [" + e.getDescripcionEvento() + "]");
			logger.error("e.getCodigoEvento() [" + e.getCodigoEvento() + "]");
			throw e;
		}		
		logger.debug("registrarCargos():end");
		return resultado;	
	}
	
	
	
	
	public Long cierreVenta(CabeceraArchivoDTO cabeceraArchivoDTO)
		throws VentasException, RemoteException
	{
		logger.debug("CierreVenta():start");
		GaVentasDTO gaVentasDTO = new GaVentasDTO();
		VentasFacadeSTL ventasFacade = getVentasFacade();
		Long numMovimiento = null;
		try {		
			// Se procede a llenar la DTO con los parametros Requeridos
			//Valores por default consultar si van en el properties		
			gaVentasDTO.setNumVenta(new Long(cabeceraArchivoDTO.getNumeroVenta()));
			gaVentasDTO.setCodOficina(cabeceraArchivoDTO.getOficinaVendedor());
			gaVentasDTO.setCodTipcomis(cabeceraArchivoDTO.getParametros().getTipoComisionista().getCodigoTipoComisionista());
			gaVentasDTO.setCodTipcomis("0");		
			gaVentasDTO.setCodVendedor(new Long (cabeceraArchivoDTO.getCodigoVendedor()));		
			//gaVentasDTO.setCodVendedorAgente(new Long (cabeceraArchivoDTO.getCodigoVendedorRaiz()));		
			gaVentasDTO.setCodRegion(cabeceraArchivoDTO.getParametros().getRegion().getCodigoRegion());
			gaVentasDTO.setCodProvincia(cabeceraArchivoDTO.getParametros().getProvincia().getCodigoProvincia());
			gaVentasDTO.setCodCiudad(cabeceraArchivoDTO.getParametros().getCiudad().getCodigoCiudad());		
			gaVentasDTO.setServSuplAdicionales(cabeceraArchivoDTO.getServSuplAdicionales());
			gaVentasDTO.setImpVenta(new Float(cabeceraArchivoDTO.getTotalCargosVenta()));
			gaVentasDTO.setNumTransaccion(new Long (cabeceraArchivoDTO.getNumeroTransaccionVenta()));
			gaVentasDTO.setIndComodato(cabeceraArchivoDTO.getParametros().getContrato().getIndComodato());
			gaVentasDTO.setIndVenta(String.valueOf(cabeceraArchivoDTO.getIndicadorTipoVenta()));
			gaVentasDTO.setCodCliente(new Long(cabeceraArchivoDTO.getCodigoCliente())); 
			gaVentasDTO.setCodModVenta(new Long(cabeceraArchivoDTO.getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));		
			gaVentasDTO.setCodCuota(cabeceraArchivoDTO.getParametros().getNumeroCuotas().getCodigo());
			gaVentasDTO.setCodTipContrato(cabeceraArchivoDTO.getParametros().getContrato().getCodigoTipoContrato());
			gaVentasDTO.setNumContrato(cabeceraArchivoDTO.getParametros().getContrato().getNumeroContrato());
			gaVentasDTO.setIndicadorContratoNuevo(cabeceraArchivoDTO.getParametros().getContrato().getIndicadorContratoNuevo());
			gaVentasDTO.setNumeroMesesContrato(cabeceraArchivoDTO.getParametros().getContrato().getNumeroMesesSeleccionado());
			gaVentasDTO.setNomUsuarVta(cabeceraArchivoDTO.getNombreUsuario());		
			gaVentasDTO.setCodVenDealer(new Long(cabeceraArchivoDTO.getCodigoVenDealer()));
			gaVentasDTO.setTipFoliacion( String.valueOf(cabeceraArchivoDTO.getTipoFoliacion().charAt(0)));		
			gaVentasDTO.setCodTipDocumento(cabeceraArchivoDTO.getCodigoDocumento());		
			gaVentasDTO.setAciclo(cabeceraArchivoDTO.isFacturaCiclo());		
			gaVentasDTO.setTipValor(new Long(cabeceraArchivoDTO.getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));		
			//gaVentasDTO.setIndPasoCob(new Long(0));//valor por defecto obtenido de la BD ya q 
			gaVentasDTO.setCodOperadora(cabeceraArchivoDTO.getCodigoOperadora());
			gaVentasDTO.setCodModPago(cabeceraArchivoDTO.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
			gaVentasDTO.setFormPago(cabeceraArchivoDTO.getCodigoFormaPago());
			gaVentasDTO.setIndTipVenta(new Long (cabeceraArchivoDTO.getIndicadorTipoVenta()));
			/*--Datos necesarios para realizar precierre--*/
			gaVentasDTO.setNumIdentCliente(cabeceraArchivoDTO.getNumeroIdentificacion());
			gaVentasDTO.setTipIdentCliente(cabeceraArchivoDTO.getCodigoTipoIdentificacion());
			gaVentasDTO.setTipoCliente(cabeceraArchivoDTO.getTipoCliente());
			gaVentasDTO.setIndicadorCuotas(cabeceraArchivoDTO.getParametros().getModalidadPagoDTO().getIndicadorCuotas());
			/*--Datos necesarios para provisionar la linea--*/
			gaVentasDTO.setCodigoActuacionDefecto(cabeceraArchivoDTO.getCod_actabo());			
			gaVentasDTO.setTipoPlanHibrido(cabeceraArchivoDTO.getTipoPlanHibrido());
			gaVentasDTO.setCodOperadora(cabeceraArchivoDTO.getCodigoOperadora());
			gaVentasDTO.setCodigoUsuario(cabeceraArchivoDTO.getNombreUsuario());
			gaVentasDTO.setParametroCodigoSimcardGSM(cabeceraArchivoDTO.getParametroCodigoSimcardGSM());
			gaVentasDTO.setIndOfiter(cabeceraArchivoDTO.getInd_ofiter());
			gaVentasDTO.setCodGrpPrestacion(cabeceraArchivoDTO.getCodGrpPrestacion());
			gaVentasDTO.setCodTipoSolicitud(cabeceraArchivoDTO.getCodTipoSolicitud());
			/*--Busca los abonados de la venta y por cada uno provisiona lineas--*/
			RegistroVentaDTO regVenta = new RegistroVentaDTO();		
			regVenta.setNumeroVenta(cabeceraArchivoDTO.getNumeroVenta());		
			AbonadoDTO[] listaAbonados = ventasFacade.getListaAbonadosVenta(regVenta);		
			int iNumeroAbonados =listaAbonados.length;			
			
			for(int i=0;i<iNumeroAbonados;i++)
			{
				gaVentasDTO.setAbonado(listaAbonados[i]); 
				//Inicio P-CSR-11002 JLGN 24-04-2011
				for(int y = 0; y<cabeceraArchivoDTO.getArrayNumAbonado().length ; y++){
					if(gaVentasDTO.getAbonado().getNumAbonado() == cabeceraArchivoDTO.getArrayNumAbonado()[y]){
						logger.debug("EXISTE");
						logger.debug("numAbonado: "+ gaVentasDTO.getAbonado().getNumAbonado());
						logger.debug("numMovimiento: "+ cabeceraArchivoDTO.getArrayNumMovimiento()[y]);
						gaVentasDTO.setNumMovimiento(cabeceraArchivoDTO.getArrayNumMovimiento()[y]);
					}					
				}				
				//Fin P-CSR-11002 JLGN 24-04-2011
				numMovimiento = ventasFacade.provisionandoLinea(gaVentasDTO);			
			}			
			/*--Ejecuta precierre--*/
			gaVentasDTO.setNumVenta(new Long(cabeceraArchivoDTO.getNumeroVenta()));
			gaVentasDTO = ventasFacade.procesosPreCierre(gaVentasDTO);		
			double totalCargo = cabeceraArchivoDTO.getTotalCargosVenta();		
			double totalImpuestos = cabeceraArchivoDTO.getTotalImpuestoVenta();		
			double totalDescuentos = cabeceraArchivoDTO.getTotalDescuentosVenta();		
			float mtoGarantia = 0;		
			if (gaVentasDTO.getMtoGarantia() !=null)
			{			
				mtoGarantia =gaVentasDTO.getMtoGarantia().floatValue();
			}
		    /*--Realiza el cierre de la venta--*/
			double totalImporte = (totalCargo + totalImpuestos  + totalDescuentos) + (mtoGarantia*iNumeroAbonados);
			gaVentasDTO.setImpVenta(new Float(totalImporte));		
			ventasFacade.cierreVenta(gaVentasDTO);
			logger.debug("CierreVenta():start");		
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");			
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new VentasException(e);
		}
		logger.debug("insertCierreVenta():end");
		return numMovimiento;	
	}
	
	public CabeceraArchivoCOLDTO validacionesGeneralesCargo(CabeceraArchivoCOLDTO cabeceraSesion) 
		throws VentasException, RemoteException
	{		
		logger.debug("validacionesGeneralesCargo():start");
		VentasFacadeSTL ventasFacade = getVentasFacade();
		ResultadoValidacionDTO resultadoVal = new ResultadoValidacionDTO();
		ParametrosValidacionDTO parametros = new ParametrosValidacionDTO();
		parametros.setCodigoModalidadVenta(cabeceraSesion.getParametros().getModalidadPagoDTO().getCodigoModalidadPago());
		resultadoVal = ventasFacade.validacionesGeneralesCargo(parametros);
		cabeceraSesion.setFacturaCiclo(resultadoVal.isResultado());
		logger.debug("validacionesGeneralesCargo():end");
		return cabeceraSesion;
	}
	
	public void aceptarPresupuesto(CabeceraArchivoDTO cabeceraSesion) 
		throws VentasException, RemoteException
	{
		logger.debug("aceptarPresupuesto():start");
		VentasFacadeSTL ventasFacade = getVentasFacade();
		ParametrosEjecucionFacturacionDTO parametros = new ParametrosEjecucionFacturacionDTO();
		parametros.setNumeroProcesoFacturacion(cabeceraSesion.getNumeroProcesoFacturacion());
		parametros.setNumeroVenta(String.valueOf(cabeceraSesion.getNumeroVenta()));
		logger.debug("aceptarPresupuesto():end");		
		ventasFacade.ejecutarFacturacion(parametros);		
	}
	
	/**
	* Obtiene los parametros Generales.
	* 
	* @param cust
	* @return
	* @throws VentasException
	*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ContratosDTO obtenerContratoNuevo()
		throws VentasException,RemoteException
	{
		logger.debug("obtenerContratoNuevo():start");
		ContratosDTO resultado = new ContratosDTO();
		try{
			logger.debug("INICIO obtenerContratoNuevo ORQ");
		
			ContratoDTO contrato = new ContratoDTO();
			logger.debug("INICIO obtenerContratoNuevo ORQ 1");
			contrato = getVentasFacade().obtenerContratoNuevo();
			logger.debug("INICIO obtenerContratoNuevo ORQ 2");
			resultado.setNumeroContrato(contrato.getNumeroContrato());
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Prueba de Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerContratoNuevo():end");
		return resultado;
	}
	
	/**
	* Busca los meses de duración asociado al tipo de contrato de venta
	* @param entrada
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	public ContratosDTO getListadoNumeroMesesContrato(ContratosDTO entrada)
		throws VentasException,RemoteException
	{
		logger.debug("getListadoNumeroMesesContrato():start");
		ContratosDTO resultado = new ContratosDTO();
		try{
			ContratoDTO contrato = new ContratoDTO();
			contrato.setCodigoTipoContrato(entrada.getCodigoTipoContrato());
			contrato = getVentasFacade().getListadoNumeroMesesContrato(contrato);
			resultado.setNumeroMesesContrato(contrato.getNumeroMesesContrato());
			resultado.setNumeroContrato(contrato.getNumeroContrato());
		} catch (VentasException e) {
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Prueba de Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoNumeroMesesContrato():end");
		return resultado;
	}
	
	/**
	* Consulta tipo contrato
	* @param entrada
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ContratosDTO getTipoContrato(ContratosDTO entrada)
		throws VentasException,RemoteException
	{
		logger.debug("getTipoContrato():start");
		ContratosDTO resultado = new ContratosDTO();
		try{
			resultado.setCodigoTipoContrato(entrada.getCodigoTipoContrato());
			ContratoDTO contrato = new ContratoDTO();
			contrato.setCodigoTipoContrato(entrada.getCodigoTipoContrato());
			contrato = getVentasFacade().getTipoContrato(contrato);
			resultado.setCodigoTipoContrato(entrada.getCodigoTipoContrato());
			resultado.setNumeroMesesContrato(contrato.getNumeroMesesContrato());
			resultado.setNumeroContrato(contrato.getNumeroContrato());
			resultado.setIndComodato(contrato.getIndComodato());
		} catch (VentasException e) {
			context.setRollbackOnly();
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Prueba de Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getTipoContrato():end");
		return resultado;
	}
	
	/**
	* Busca las modalidades de pago
	* @param entrada
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	
	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoModalidadPago:star");
		ModalidadPagoDTO[] ret; 
		try {
			datosPrograma.setCodigoPrograma(config.getString("programa.codigo"));
			datosPrograma.setNumeroVersion(Integer.parseInt(config.getString("programa.version")));
			datosPrograma.setNumeroSubVersion(Integer.parseInt(config.getString("programa.subversion")));
			modalidad.setDatosPrograma(datosPrograma);
			ret = getVentasFacade().getListadoModalidadPago(modalidad);
		}
		catch(VentasException e){
			logger.debug("getListadoModalidadPago:end");
			logger.debug("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoModalidadPago:star");
		return ret;
	}
	
	
	/**
	* Busca los numeros de cuotas cuando la modalidad de pago es a credito
	* @param entrada
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	
	public NumeroCuotasDTO[] getListadoNumeroCuotas(ModalidadPagoDTO modalidad)
		throws VentasException, RemoteException 
	{	
		logger.debug("getListadoNumeroCuotas():start");
		NumeroCuotasDTO[] respuesta = null;
		try {
			logger.debug("getListadoNumeroCuotas():antes");
			respuesta = getVentasFacade().getListadoNumeroCuotas(modalidad);
			logger.debug("getListadoNumeroCuotas():despues");
		} catch (VentasException e) {
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoNumeroCuotas():end");
		return respuesta;
	}

	
	
	/**
	* Crea la solicitud de aprobación rango de descuento
	* @param regCargosDTO
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SolicitudAutorizacionDescuentoDTO solicitarAprobaciones(RegCargosDTO regCargosDTO)
		throws VentasException, RemoteException
	{
		SolicitudAutorizacionDescuentoDTO resultado = new SolicitudAutorizacionDescuentoDTO();
		RegistroSolicitudesDTO registroSolicitud = new RegistroSolicitudesDTO();
		logger.debug("solicitarAprobaciones():start");
		try {
			CabeceraArchivoDTO objetoSesion = regCargosDTO.getObjetoSesion();
			
			logger.debug("solicitarAprobaciones():antes");
			CargoDTO[] cargoAfectos = regCargosDTO.getCargos();
			List listadoRegistroSolicitudesDTO  = new ArrayList();
			for (int i = 0 ; i<cargoAfectos.length;i++){
				RegistroSolicitudesDTO registroSolicitudesDTO = new RegistroSolicitudesDTO();
				registroSolicitudesDTO.setNumeroVenta(objetoSesion.getNumeroVenta());
				registroSolicitudesDTO.setCodigoOficina(objetoSesion.getOficinaVendedor());
				registroSolicitudesDTO.setCodigoVendedor(Long.parseLong(objetoSesion.getCodigoVendedor()));
				registroSolicitudesDTO.setNumeroUnidades(cargoAfectos[i].getCantidad());
				registroSolicitudesDTO.setPrecioOrigen(cargoAfectos[i].getMontoConceptoPrecio());
				registroSolicitudesDTO.setIndicadorTipoVenta(objetoSesion.getIndicadorTipoVenta());
				registroSolicitudesDTO.setCodigoCliente(Long.parseLong(objetoSesion.getCodigoCliente()));
				registroSolicitudesDTO.setCodigoModalidadVenta(Integer.parseInt(objetoSesion.getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));
				registroSolicitudesDTO.setNombreUsuarioVenta(objetoSesion.getNombreUsuario());
				registroSolicitudesDTO.setCodigoConcepto(Integer.parseInt(cargoAfectos[i].getCodigoConceptoPrecio()));
				registroSolicitudesDTO.setImporteCargo(cargoAfectos[i].getMontoConceptoPrecio());
				registroSolicitudesDTO.setCodigoConceptoDescuento(cargoAfectos[i].getCodigoDescuento() == null ? 0:Integer.parseInt(cargoAfectos[i].getCodigoDescuento()));
				registroSolicitudesDTO.setValorDescuento(cargoAfectos[i].getMontoDescuentoManual());
				registroSolicitudesDTO.setTipoDescuento(Integer.parseInt(cargoAfectos[i].getTipoDescuentoManual()));
				listadoRegistroSolicitudesDTO.add(registroSolicitudesDTO);
			}
			RegistroSolicitudesDTO[] registroSolicitudes =(RegistroSolicitudesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listadoRegistroSolicitudesDTO.toArray(), RegistroSolicitudesDTO.class);
				
			registroSolicitud = getVentasFacade().solicitarAprobaciones(registroSolicitudes);
			resultado.setCodigoEstado(registroSolicitud.getCodigoEstado());
			resultado.setNumeroAutorizacion(registroSolicitud.getNumeroAutorizacion());
			logger.debug("solicitarAprobaciones():despues");
		} catch (VentasException e) {
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");		
			throw e;
		} catch (RemoteException e) {		
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			context.setRollbackOnly();
			throw new VentasException(e);
		}
		logger.debug("solicitarAprobaciones():end");
		return resultado;
	}
	
	/**
	* Consulta el estado de la solicitud de autorización.
	* @param regCargosDTO
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SolicitudAutorizacionDescuentoDTO consultaEstadoSolicitud(SolicitudAutorizacionDescuentoDTO solicitudAutorizacionDescuentoDTO)
		throws VentasException, RemoteException
	{
		SolicitudAutorizacionDescuentoDTO resultado = new SolicitudAutorizacionDescuentoDTO();
		RegistroSolicitudesDTO registroSolicitudesDTO = new RegistroSolicitudesDTO();
		logger.debug("consultaEstadoSolicitud():start");
		try {
			logger.debug("consultaEstadoSolicitud():antes");
			registroSolicitudesDTO.setNumeroAutorizacion(solicitudAutorizacionDescuentoDTO.getNumeroAutorizacion());
			registroSolicitudesDTO.setCodigoEstado(solicitudAutorizacionDescuentoDTO.getCodigoEstado());
			registroSolicitudesDTO = getVentasFacade().consultaEstadoSolicitud(registroSolicitudesDTO);
			resultado.setNumeroAutorizacion(registroSolicitudesDTO.getNumeroAutorizacion());
			resultado.setCodigoEstado(registroSolicitudesDTO.getCodigoEstado());
			resultado.setDescripcionEstado(registroSolicitudesDTO.getDescripcionEstado());
			logger.debug("consultaEstadoSolicitud():despues");
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			context.setRollbackOnly();
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			context.setRollbackOnly();
			throw new VentasException(e);
		}
		logger.debug("consultaEstadoSolicitud():end");
		return resultado;
	}
	
	/*
	public EncabezadoPresupuestoDTO obtenerInformePresupuesto(EncabezadoPresupuestoDTO objetoEntradaDTO)
		throws VentasException, RemoteException
	{
		logger.debug("obtenerInformePresupuesto():start");
		try {
			InformePresupuestoDTO informePresupuestoDTO = new InformePresupuestoDTO();
			informePresupuestoDTO.setNumeroVenta(objetoEntradaDTO.getNumeroVenta());
			informePresupuestoDTO.setNumeroProcesoFacturacion(objetoEntradaDTO.getNumeroProcesoFacturacion());
			informePresupuestoDTO.setCodigoCuenta(objetoEntradaDTO.getCodigoCuenta());
			informePresupuestoDTO.setCodigoTipoContrato(objetoEntradaDTO.getCodigoTipoContrato());
			informePresupuestoDTO.setCodigoVendedor(objetoEntradaDTO.getCodigoVendedor());
			informePresupuestoDTO.setCodigoModalidadVenta(objetoEntradaDTO.getCodigoModalidadVenta());
			informePresupuestoDTO.setCodigoCliente(objetoEntradaDTO.getCodigoCliente());
			
		    List listaCargosNegocio = new ArrayList();
		    for(int i=0;i<objetoEntradaDTO.getArregloCargos().length;i++){
		    	CargosDTO cargoNegocioDTO = new CargosDTO();
		    	PrecioDTO precioDTO = new PrecioDTO();
		    	precioDTO.setCodigoConcepto(objetoEntradaDTO.getArregloCargos()[i].getCodigoConceptoPrecio());
		    	precioDTO.setDescripcionConcepto(objetoEntradaDTO.getArregloCargos()[i].getDescripcionConceptoPrecio());
		    	precioDTO.setMonto(objetoEntradaDTO.getArregloCargos()[i].getMontoConceptoPrecio());
		    	cargoNegocioDTO.setPrecio(precioDTO);
		    	cargoNegocioDTO.setCantidad(objetoEntradaDTO.getArregloCargos()[i].getCantidad());
		    	listaCargosNegocio.add(cargoNegocioDTO);
		    }
		    CargosDTO[] arregloCargosNegocio =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
		    		listaCargosNegocio.toArray(), CargosDTO.class);
		    informePresupuestoDTO.setArregloCargos(arregloCargosNegocio);
		    informePresupuestoDTO = getVentasFacade().obtenerInformePresupuesto(informePresupuestoDTO);
		    objetoEntradaDTO.setNombreVendedor(informePresupuestoDTO.getNombreVendedor());
		    objetoEntradaDTO.setDescripcionModalidadVenta(informePresupuestoDTO.getDescripcionModalidadVenta());
		    objetoEntradaDTO.setDescripcionCuenta(informePresupuestoDTO.getDescripcionCuenta());
		    objetoEntradaDTO.setDescripcionTipoContrato(informePresupuestoDTO.getDescripcionTipoContrato());
		    objetoEntradaDTO.setDescripcionProducto(informePresupuestoDTO.getDescripcionProducto());
		    objetoEntradaDTO.setDescripcionTipoDocumento(informePresupuestoDTO.getDescripcionTipoDocumento());
		    List listaDetallePresupuesto = new ArrayList();
		    for (int i=0;i<informePresupuestoDTO.getDetalle().length;i++){
		    	DetallePresupuestoDTO  detalle = new DetallePresupuestoDTO();
		    	detalle.setCodigoArticulo(informePresupuestoDTO.getDetalle()[i].getCodigoArticulo());
		    	detalle.setDescripcionArticulo(informePresupuestoDTO.getDetalle()[i].getDescripcionArticulo());
		    	detalle.setCargo(informePresupuestoDTO.getDetalle()[i].getCargos());
		    	detalle.setImpuestos(informePresupuestoDTO.getDetalle()[i].getImpuestos());
		    	detalle.setDescuentos(informePresupuestoDTO.getDetalle()[i].getDescuentos());
		    	detalle.setNumeroTerminal(informePresupuestoDTO.getDetalle()[i].getNumeroTerminal());
		    	listaDetallePresupuesto.add(detalle);
		    }
		    DetallePresupuestoDTO[] arregloDetalle = (DetallePresupuestoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaDetallePresupuesto.toArray(), DetallePresupuestoDTO.class);
		    objetoEntradaDTO.setDetalle(arregloDetalle);
		} catch (VentasException e) {
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerInformePresupuesto():end");
		return objetoEntradaDTO;
	}*/
	
	
	public IdentificadorCivilComDTO[] getListadoIdentificadorCivil()
		throws VentasException,RemoteException
	{
		logger.debug("getListadoIdentificadorCivil():start");
		IdentificadorCivilComDTO[] arrayIdentCivilCommon = null;
		IdentificadorCivilDTO[] arrayIdentCivil = null;
		try{
			arrayIdentCivil = getVentasFacade().getListadoIdentificadorCivil();
			if (arrayIdentCivil!=null){
				/*MapperIF mapper = new DozerBeanMapper();
				arrayIdentCivilCommon = new IdentificadorCivilComDTO[arrayIdentCivil.length];
				for (int i=0; i< arrayIdentCivil.length; i++  ){
					IdentificadorCivilComDTO identificadorCommon = new IdentificadorCivilComDTO();
					mapper.map(arrayIdentCivil[i], identificadorCommon);
					arrayIdentCivilCommon[i] = identificadorCommon ;
				}*/
			}
		} catch (VentasException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Prueba de Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoIdentificadorCivil():end");
		return arrayIdentCivilCommon;
	}
	
	
	public CuentaComDTO[] getListadoCuentas(String[] arrayCriterios)
		throws VentasException, RemoteException 
	{
		logger.debug("getListadoCuentas():start");
		CuentaComDTO[] arrayCuentaCommon = null;
		CuentaDTO[] arrayCuenta = null;
		
		CuentaDTO criterioBusquedaCuenta = new CuentaDTO();
		criterioBusquedaCuenta.setCriterioBusqueda(arrayCriterios[0]);
		criterioBusquedaCuenta.setFiltroBusqueda(arrayCriterios[1]);
		criterioBusquedaCuenta.setValorBusqueda(arrayCriterios[2]);
		criterioBusquedaCuenta.setTipoIdentificacion(arrayCriterios[3]);
		
		try{
			arrayCuenta = getVentasFacade().getListadoCuentas(criterioBusquedaCuenta);
			if (arrayCuenta!=null){
				/*MapperIF mapper = new DozerBeanMapper();
				arrayCuentaCommon = new CuentaComDTO[arrayCuenta.length];
				for (int i=0; i< arrayCuenta.length; i++  ){
					CuentaComDTO identificadorCommon = new CuentaComDTO();
					mapper.map(arrayCuenta[i], identificadorCommon);
					arrayCuentaCommon[i] = identificadorCommon ;
				}*/
			}
		} catch (VentasException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Prueba de Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCuentas():end");
		return arrayCuentaCommon;
	}
	
	public void bloqueaDesbloqueaVendedor(CabeceraArchivoDTO objetoSesion)
		throws VentasException, RemoteException	
	{
		logger.debug("Inicio:bloqueaDesbloqueaVendedor");
		try {
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(objetoSesion.getCodigoVendedor());
			vendedorDTO.setCodigoAccionBloqueo(config.getString("indicador.desbloqueo"));
			getVentasFacade().bloqueaDesbloqueaVendedor(vendedorDTO);
		}
		catch(RemoteException e){
			context.setRollbackOnly();
			logger.debug("bloqueaDesbloqueaVendedor:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:bloqueaDesbloqueaVendedor");
	}//fin bloqueaDesbloqueaVendedor
	

	/** 
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO entrada) 
		throws VentasException,RemoteException
	{
		logger.debug("Inicio:getListadoSS()");		
		ListadoSSOutDTO[] resultado = null;
		try {
			resultado =  getVentasFacade().getListadoSS(entrada);						
		} catch (VentasException e) {
			logger.debug("Fin:getListadoSS");
			logger.debug("IntegracionSIGAException");
			// context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			// printTrazas(e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			// context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Inicio:getListadoSS()");		
		return resultado;
	}//fin getListadoSS

	/**  
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ArticuloOutDTO[] getListadoArticulos(ArticuloInDTO articulo) 
		throws VentasException,RemoteException
	{
		logger.debug("Inicio:getListadoArticulo()");		
		ArticuloOutDTO[] resultado = null;
		try {
			resultado =  getVentasFacade().getListadoArticulos(articulo);						
		} catch (ProductDomainException e) {
			logger.debug("Fin:getListadoArticulo");
			// context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		} catch (Exception e) {
			logger.debug("Exception");
			// context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Inicio:getListadoArticulo()");		
		return resultado;
	}//fin getListadoSS
	
		
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public DatCteClienteOutDTO[] getDatosCliente(DatCteClienteInDTO entrada) 
		throws VentasException,RemoteException 	
	{
		logger.debug("Inicio:getDatosCliente()");
		DatCteClienteOutDTO[] arrayClienteOut = null;
		ClienteDTO[] arrayCliente = null;
		BusquedaClienteDTO cliente = new BusquedaClienteDTO();
		try {
			cliente.setCodCliente(entrada.getCodigoCliente());
			cliente.setCodTipoIdentificacion(entrada.getTipoIdentificacion());
			cliente.setNumIdentificacion(entrada.getNumeroIdentificacion());
			arrayCliente = getVentasFacade().getDatosCliente(cliente);
	
			if (arrayCliente!=null){
				MapperIF mapper = new DozerBeanMapper();
				arrayClienteOut = new DatCteClienteOutDTO[arrayCliente.length];
				for (int i=0; i< arrayCliente.length; i++  ){
					DatCteClienteOutDTO clienteOut = new DatCteClienteOutDTO();
					mapper.map(arrayCliente[i], clienteOut);
					arrayClienteOut[i] = clienteOut ;
				}
			}
		} 
		catch (VentasException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:getDatosCliente()");
		return arrayClienteOut;
	}//fin getDatosCliente

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public LstVtaRegistroResultadoDTO getListVentas(LstVtaRegistroVentaInDTO entrada) 
		throws VentasException,RemoteException 	
	{
		logger.debug("Inicio:getListVentas()");
		LstVtaRegistroResultadoDTO salida = null;
		RegistroVentaDTO registroVenta = new RegistroVentaDTO();
		try {
			registroVenta.setCodigo_vendedor(entrada.getCodigoVendedor());
			registroVenta.setCodigo_vendedor_dealer(entrada.getCodigoVendedorDealer());
			registroVenta.setCanal_vendedor(entrada.getCanalVendedor());
			registroVenta.setFecha_desde(entrada.getFechaDesde());
			registroVenta.setFecha_hasta(entrada.getFechaHasta());
			registroVenta.setFiltro(Integer.parseInt(entrada.getFiltro()));
			salida = getVentasFacade().getListVentas(registroVenta);
		} catch (VentasException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:getListVentas()");
		return salida;
	}//fin getListVentas

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarif (LstPTaPlanTarifarioInDTO entrada) 
		throws VentasException,RemoteException,GeneralException
	{
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
		logger.debug("Inicio:lstPlanTarif()");
		LstPTaPlanTarifarioListOutDTO salida = null;
		
		try {
			/**1.- Llamo al Servicio Listar Planes*/
			salida = getVentasFacade().lstPlanTarif(entrada);
			UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));			
			logger.debug("Codigo de Error" + salida.getCodError());
			/**2.- Listar Planes me genera error porque evaluación esta rechazada o no existe.*/
			if (salida.getCodError().intValue()==new Integer (config.getString("error.evaluacion.no.vigente")).intValue() 
		    	|| salida.getCodError().intValue()==new Integer (config.getString("error.evaluacion.prechequeo")).intValue()
		    	|| salida.getCodError().intValue()==new Integer (config.getString("error.evaluacion.rechazada")).intValue() )
		    {
		    /**	4.- Llamo a Listar planes de  Srv de IntegracionRiesgo*/
			//salida = getIntegracionRiesgoFacade().listarPlanesEriesgo(entrada);			                                      			
		    }	
		} 
		catch (VentasException e) {
			e.printStackTrace();
			logger.debug("Fin:getListPlanTarif");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
		catch (GeneralException e) {
			e.printStackTrace();
			logger.debug("Fin:getListPlanTarif");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			e.printStackTrace();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:lstPlanTarif()");
		/**7.-Listar Planes devuelve Planes tarifarios y Registros de evaluacion de riesgo*/
		return salida;
	}//fin getListPlanTarif
	
	
	
	/*public ActualizarPrevaluacionOutDTO actualizarPreevaluacion (ActualizarPrevaluacionInDTO datosPrevaluacionDTO) 
		throws GeneralException,RemoteException
	{
		logger.debug("Inicio:actualizarPreevaluacion()");
		ActualizarPrevaluacionOutDTO salida = null;
		
		try {
			//salida = getIntegracionRiesgoFacade().actualizarPrevaluacion(datosPrevaluacionDTO);
		} 
		catch (GeneralException e) {
			logger.debug("Fin:actualizarPreevaluacion");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			salida.setCodError(new Long (999));
			salida.setMsgError("Ocurrio un Error al ejecutar el Servicio");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			salida.setCodError(new Long (999));
			salida.setMsgError("Ocurrio un Error al ejecutar el Servicio");
			throw new VentasException(e);
		}
		logger.debug("Fin:actualizarPreevaluacion()");
		return salida;
	}*/
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarifPosventa (LstPTaPlanTarifarioInDTO entrada) 
		throws VentasException,RemoteException
	{
		logger.debug("Inicio:lstPlanTarifPosventa()");
		LstPTaPlanTarifarioListOutDTO salida = null;
		
		try {
			salida = getVentasFacade().lstPlanTarifPosventa(entrada);
		} 
		catch (VentasException e) {
			logger.debug("Fin:lstPlanTarifPosventa");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:lstPlanTarifPosventa()");
		return salida;
	}//fin lstPlanTarifPosventa
	
	
	
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
		context = arg0;
	}

	/**
	 * 
	 */
	public void ActivacionMasivaORQBean() {
		// TODO Auto-generated constructor stub
	}


	/**
	* Realiza el alta de cliente 
	* @param entrada
	* @return resultado
	* @throws VentasException,RemoteException
	*/
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO crearCliente (CuentaComDTO cuentaComDTO)
		throws VentasException, RemoteException 
	{
		logger.debug("altaCliente():start");
		CuentaComDTO respuesta = new CuentaComDTO();
		try {
			logger.debug("crearCliente:antes");
		    
			logger.debug("Orquestador: Antes de ingresar a crearCliente() ");
			respuesta =getAltaClienteFacade().crearCliente(cuentaComDTO);
			logger.debug("Orquestador: Despues de ingresar a crearCliente() ");
			logger.debug("crearCliente:despues");
		}
		catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("altaCliente():end");
		return respuesta;
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
	public ClienteOutDTO altaCliente (ClienteInDTO clienteIn)
		throws VentasException, RemoteException 
	{
		logger.debug("altaCliente():start");
		ClienteOutDTO respuesta = null;
		ClienteComDTO clienteCom = null;
		try {
			logger.debug("crearCliente:antes");
		    clienteCom = new ClienteComDTO();
		    clienteCom.setNombreCliente(clienteIn.getNombreCliente());
		    clienteCom.setCodigoTipoCliente(clienteIn.getIndTipoCliente());		    
			clienteCom.setCodigoTipoIdentificacion(clienteIn.getCodigoTipoIdentificacion());
			clienteCom.setNumeroIdentificacion(clienteIn.getNumeroIdentificacion());
			clienteCom.setNombreUsuarOra(clienteIn.getUsuario());
			clienteCom.setUsuario(clienteIn.getUsuario());
			clienteCom.setIndicadirTipPersona(clienteIn.getIndicadirTipPersona());
			clienteCom.setCodigoPlanTarifario(clienteIn.getCodigoPlanTarifario());
			clienteCom.setPlanTarifario(clienteIn.getCodigoPlanTarifario());
			
			clienteCom.setCodProvincia(clienteIn.getCodProvincia());
			clienteCom.setCodRegion(clienteIn.getCodRegion());
			clienteCom.setCodCiudad(clienteIn.getCodCiudad());
			clienteCom.setCodComuna(clienteIn.getCodComuna());
			clienteCom.setNomCalle(clienteIn.getNomCalle());
			clienteCom.setNumCalle(clienteIn.getNumCalle());
			clienteCom.setZip(clienteIn.getZip());
			clienteCom.setDesDirec1(clienteIn.getDesDirec1());
			clienteCom.setDesDirec2(clienteIn.getDesDirec2());
			clienteCom.setTipoCalle(clienteIn.getTipoCalle());
			
			//Campos nuevos solicitados en MA
			clienteCom.setObservacionDireccion(clienteIn.getObservacionDireccion());
			clienteCom.setNombreApellido1(clienteIn.getApellido1Cliente());
			clienteCom.setNombreApellido2(clienteIn.getApellido2Cliente());		
			
			clienteCom.setNumeroTelefono1(clienteIn.getTelefono_1());
			clienteCom.setFechaNacimiento(clienteIn.getFechaNacimiento());
			// Al apoderado se le setea el nombre del responsable
			clienteCom.setNombreApoderado(clienteIn.getNombreResponsable());
			clienteCom.setNumeroTelefono2(clienteIn.getTelefonoContacto());
			clienteCom.setCodigoCalidadCliente(clienteIn.getCodCalidadCliente());
			clienteCom.setIndicadorSexo(clienteIn.getIndSexo());			
			
			// Campos COL08009
			// Valida si la subcategoria ingresada existe en  SCL
			validaSubCategoriaIngresada(clienteIn.getCodSubcategoria());
			clienteCom.setCodigoSubCategoria(clienteIn.getCodSubcategoria());
			 
			
			clienteCom.setIndicadirTipPersona(clienteIn.getIndicadirTipPersona());
			
			if (clienteCom.getIndicadirTipPersona().equals(config.getString("indicador.tipo.natural").trim())){
	            // Persona Natural           
				// Valida si el estado civil ingresado existe en SCL
				validaEstadoCivilIngresado(clienteIn.getCodEstCivil());
				clienteCom.setIndicadorEstadoCivil(clienteIn.getCodEstCivil());
				clienteCom.setDireccionEMail(clienteIn.getNomEmail());
			} 
			
			clienteCom.setCodigoCuenta(clienteIn.getCodigoCuenta());//EV 04/01/10
			
			RepresentanteLegalComDTO[] arrayRepLegal  = null;
			
			if  (
					clienteIn.getNombreResponsable()!=null &&  !clienteIn.getNombreResponsable().equals("") &&
					clienteIn.getCodTipIdentResp()!=null && !clienteIn.getCodTipIdentResp().equals("") && 
					clienteIn.getNumIdentResp()!=null && !clienteIn.getNumIdentResp().equals("")  	
			    )
			{	
				arrayRepLegal = new RepresentanteLegalComDTO[1];
				arrayRepLegal[0] = new RepresentanteLegalComDTO();
				arrayRepLegal[0].setNombre(clienteIn.getNombreResponsable());
				arrayRepLegal[0].setCodigoTipoIdentificacion(clienteIn.getCodTipIdentResp());
				arrayRepLegal[0].setNumeroTipoIdentificacion(clienteIn.getNumIdentResp());
			}
			
			
			clienteCom.setRepresentanteLegalComDTO(arrayRepLegal);
			
			logger.debug("Orquestador: Antes de ingresar a crearCliente() ");
			clienteCom = getAltaClienteFacade().crearCliente(clienteCom);
			logger.debug("Orquestador: Despues de ingresar a crearCliente() ");
		    
			if (clienteCom!=null){
		    	respuesta =  new ClienteOutDTO(); 
		    	respuesta.setCodigoCliente(clienteCom.getCodigoCliente());
		    }
			logger.debug("crearCliente:despues");
		}
		catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("altaCliente():end");
		return respuesta;
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
	public ConceptoVenta ValidarModalidadVenta(DependenciasModalidadDTO entrada) 
		throws VentasException,RemoteException
	{	 
		logger.debug("Inicio:ValidarModalidadVenta()");
		ConceptoVenta resultado = null;			
		try {
			
			resultado = getVentasFacade().validarModalidadVenta(entrada);
					
		} catch (VentasException e) {
			context.setRollbackOnly();			
			logger.debug("Fin:getDatosCliente");
			logger.debug("IntegracionSIGAException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			context.setRollbackOnly();			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("fin:ValidarModalidadVenta()");
		return resultado;
	}//fin getDatosCliente
	
	public CabeceraArchivoCOLDTO getDatos(ParametrosComercialesINDTO actLinea) 
		throws VentasException, TasacionException, RemoteException
	{
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		try {
			logger.debug("Ingreso a getDatos ");					
			cabecera.setCodigoVendedor(actLinea.getCod_vendedor());
			if( actLinea.getCod_vendealer() != null && !actLinea.getCod_vendealer().trim().equals("")){
				cabecera.setCodigoVenDealer(Long.valueOf(actLinea.getCod_vendealer()).longValue());
			}else 
				cabecera.setCodigoVenDealer(0);
			cabecera.setCodigoCliente(actLinea.getCod_cliente());
			cabecera.setCod_planTarif(actLinea.getCod_planTarif());
			cabecera.setNumeroSeries("1");
			cabecera.setNro_icc(actLinea.getNro_icc());
			cabecera.setNro_imei(actLinea.getNro_imei());
			cabecera.setNombreUsuario(actLinea.getNom_usuarora().toUpperCase());
			cabecera.setCod_canal(actLinea.getCod_canal());
			cabecera.setCodigoArticuloTerminal(actLinea.getCod_articulo());
			cabecera.setProc_equipo(actLinea.getProc_equipo());
			cabecera.setTipo_producto(actLinea.getTipo_producto());
			cabecera.setCod_cuota(actLinea.getNro_cuotas());
			
			//release II
			cabecera.setInd_ofiter(actLinea.getInd_ofiter().trim());
			if(actLinea.getInd_ofiter().trim().equals("O")) {
				cabecera.setCod_actabo(config.getString("codigo.actuacion.venta.oficina"));
			}else {
				cabecera.setCod_actabo(config.getString("codigo.actuacion.venta.terreno"));			 
			}
			//cabecera.setCod_estrato(actLinea.getCod_estrato());
			
			
			String servAdicionales = "";
			//Setea los servicios adicionales en caso que existan
			logger.debug("actLinea.getServSupActLineaDTO() : " + actLinea.getServSupActLineaDTO());
			String caracterSS = config.getString("caracter.ss.adicionales");
			if(actLinea.getServSupActLineaDTO() != null && actLinea.getServSupActLineaDTO().length > 0)
			{
				logger.debug("Ingreso a getDatos 0.1");
				String codServicio = "";
			    for(int i=0; i<actLinea.getServSupActLineaDTO().length; i++)
			    {
			    	logger.debug("Ingreso a getDatos 0.1  codServicio.lenght(): " + codServicio.length());
			    	codServicio = actLinea.getServSupActLineaDTO()[i].getCod_servicio();
			    	if(codServicio.length() == 2) codServicio = caracterSS.trim() + codServicio;
			    	if(codServicio.length() == 1) codServicio = caracterSS.trim() + caracterSS.trim() + codServicio;
			    	logger.debug("Ingreso a getDatos 0.2 : " + codServicio);
			    	servAdicionales = servAdicionales + codServicio;
			    	logger.debug("Ingreso a getDatos 0.3 servAdicionales: " + servAdicionales);
			    }						
			    cabecera.setServSuplAdicionales(servAdicionales.toUpperCase());
			}
		    
			logger.debug("Ingreso a getDatos 1");
			
			//Llenado de valores de DTO ParametrosSeleccionados de CabeceraArchivo DTO		
			ParametrosSeleccionadosDTO parametrosSelec = new ParametrosSeleccionadosDTO();			
		
			//CausalDescuento
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodigoProducto(config.getString("codigo.producto"));
			parametro.setCodigoModulo(config.getString("codigo.modulo.GA"));
			parametro.setCodigoParametro(config.getString("causal.descuento.default"));
			
			logger.debug("Ingreso a getDatos 2");
			
			parametro = getVentasFacade().getValorParametro(parametro);
			
			CausalDescuentoDTO causaDcto = new CausalDescuentoDTO();
			causaDcto.setCodigoCausalDescuento(parametro.getValorParametro());
			parametrosSelec.setCausalDescuento(causaDcto);		
			logger.debug("Ingreso a getDatos 3");
			
			//GrupoCobroServicio
			GrupoCobroServicioDTO grupoCobroServicio = new GrupoCobroServicioDTO();
			grupoCobroServicio = getVentasFacade().getGrupoCobroServicioDefault(new Long(1));
			parametrosSelec.setGrupoCobroServicio(grupoCobroServicio);
			logger.debug("Ingreso a getDatos 4");
			
			//CampanaVigente
			CampanaVigenteCOLDTO campanaVigenteCOL = new CampanaVigenteCOLDTO();
			campanaVigenteCOL.setCodPlantarif(actLinea.getCod_planTarif());
			campanaVigenteCOL.setInd_default("1");
			campanaVigenteCOL.setTipEntidad("A");
			campanaVigenteCOL.setFormato_fecha("YYYYMMDD");
			CampanaVigenteDTO campanaVigente = new CampanaVigenteDTO();		
			campanaVigente = getVentasFacade().getCampanaVigenteDefault(campanaVigenteCOL);
			parametrosSelec.setCampanaVigente(campanaVigente);
			logger.debug("Ingreso a getDatos 5");			
			
			GrupoAfinidadDTO grupoAfinidad = new GrupoAfinidadDTO();
			grupoAfinidad.setCodigoGrupoAfinidad(null);
			grupoAfinidad.setDescripcionGrupoAfinidad(null);
			parametrosSelec.setGrupoAfinidad(grupoAfinidad);
			logger.debug("Ingreso a getDatos 8");
			
			PlanIndemnizacionDTO planIndemnizacion = new PlanIndemnizacionDTO();
			planIndemnizacion.setCodigoPlanIndemnizacion(null);
			planIndemnizacion.setDescripcionPlanIndemnizacion(null);
			parametrosSelec.setPlanIndemnizacion(planIndemnizacion);
			logger.debug("Ingreso a getDatos 9");
			
			ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();
			modalidadPago.setCodigoModalidadPago(actLinea.getForma_pago());
			modalidadPago = getVentasFacade().getModalidadPago(modalidadPago);
			parametrosSelec.setModalidadPagoDTO(modalidadPago);
			logger.debug("Ingreso a getDatos 9.1");
			
			//Modalidad de venta cuando es vendedor externo
			ParametrosComercialesVendExtDTO  parametrosComerciales = new ParametrosComercialesVendExtDTO(0, null);				
			AgenteVenta agente = new AgenteVenta(cabecera.getCod_canal(), null);				
			Producto producto = new Producto(cabecera.getNro_icc());				
			ConceptoVenta conceptoVenta = new ConceptoVenta(Integer.parseInt(
					modalidadPago.getCodigoModalidadPago()), null);
			DependenciasModalidadDTO depModalidad =
				new DependenciasModalidadDTO(agente, parametrosComerciales, producto, conceptoVenta);
			ConceptoVenta concepto = getVentasFacade().validarModalidadVenta(depModalidad);				
			modalidadPago.setCodigoModalidadPago(String.valueOf(concepto.getCodigo()));
			parametrosSelec.setModalidadPagoDTO(modalidadPago);
			logger.debug("Ingreso a getDatos 10");
			
			NumeroCuotasDTO numeroCoutas = new NumeroCuotasDTO();
			numeroCoutas.setCodigo(actLinea.getNro_cuotas()); //El parametro que envian corresponde al cod_cuota no al nro
			parametrosSelec.setNumeroCuotas(numeroCoutas);
			logger.debug("Ingreso a getDatos 11");
			
			VendedorDTO vendedor = new VendedorDTO();
			vendedor.setCodigoVendedor(actLinea.getCod_vendedor());			
			vendedor.setCodigoVendedorDealer(cabecera.getCodigoVenDealer());
			vendedor = getVentasFacade().getVendedor(vendedor);
			logger.debug("Ingreso a getDatos 11.1");		
			TipoComisionistaDTO tipoComisionista = new TipoComisionistaDTO();
			tipoComisionista.setCodigoTipoComisionista(vendedor.getCodTipComisionista());		
			parametrosSelec.setTipoComisionista(tipoComisionista);
			logger.debug("Ingreso a getDatos 12");
			
			PlanTarifarioDTO planTarif = new PlanTarifarioDTO();
			planTarif.setCodigoPlanTarifario(actLinea.getCod_planTarif());
			planTarif.setCodigoProducto(config.getString("codigo.producto"));
			planTarif.setCodigoTecnologia(config.getString("codigo.tecnologia"));
			cabecera.setIdentificadorEmpresa(getTasacionFacade().getPlanTarifario(planTarif).getCodigoTipoPlan());
			logger.debug("Ingreso a getDatos 12.1");
			//Obtiene parametros comerciales
			ParametrosComercialesDTO  parametrosComercialesDTO = getParametrosComerciales(cabecera);
			logger.debug("Ingreso a getDatos 13");
			//Setea datos del Cliente
			logger.debug("Ingreso a getDatos 15 parametrosComercialesDTO.getNumeroIdentificacion() : " + parametrosComercialesDTO.getNumeroIdentificacion() );
			cabecera.setCodigoTipoIdentificacion(parametrosComercialesDTO.getCodigoTipoIdentificacion());
			cabecera.setNumeroIdentificacion(parametrosComercialesDTO.getNumeroIdentificacion());
			logger.debug("Ingreso a getDatos 15.1 "  );
			cabecera.setNombreCliente(parametrosComercialesDTO.getNombreCliente());
			cabecera.setCodigoActividadCliente(parametrosComercialesDTO.getCodigoActividadCliente());
			cabecera.setCodigoCalidadCliente(parametrosComercialesDTO.getCodigoCalidadCliente());
			logger.debug("Ingreso a getDatos 15.2 "  );
			cabecera.setCodigoCeldaCliente(parametrosComercialesDTO.getCodigoCeldaCliente());
			cabecera.setCodigoCicloCliente(parametrosComercialesDTO.getCodigoCicloCliente());
			cabecera.setCodigoCuentaCliente(parametrosComercialesDTO.getCodigoCuentaCliente());
			logger.debug("Ingreso a getDatos 15.3 "  );
			cabecera.setFechaNacimientoCliente(parametrosComercialesDTO.getFechaNacimientoCliente());
			cabecera.setIndicadorEstadoCivilCliente(parametrosComercialesDTO.getIndicadorEstadoCivilCliente());
			cabecera.setIndicadorSexoCliente(parametrosComercialesDTO.getIndicadorSexoCliente());
			logger.debug("Ingreso a getDatos 15.4 "  );
			cabecera.setIndicativoFacturableCliente(parametrosComercialesDTO.getIndicativoFacturableCliente());
			cabecera.setNombreApellido1Cliente(parametrosComercialesDTO.getNombreApellido1Cliente());
			cabecera.setNombreApellido2Cliente(parametrosComercialesDTO.getNombreApellido2Cliente());
			logger.debug("Ingreso a getDatos 15.5 "  );
			cabecera.setDireccionCliente(parametrosComercialesDTO.getDireccionCliente());
			cabecera.setCodigoEmpresa(parametrosComercialesDTO.getCodigoEmpresa());
			cabecera.setPlanComercialCliente(parametrosComercialesDTO.getPlanComercialCliente());
			logger.debug("Ingreso a getDatos 15.6 "  );		
			//Setea datos del documento
			cabecera.setCodigoDocumento(parametrosComercialesDTO.getDocumento().getCodigo());
			cabecera.setTipoFoliacion(parametrosComercialesDTO.getDocumento().getTipoFoliacion());
			cabecera.setCategoriaTributaria(parametrosComercialesDTO.getDocumento().getCategoriaTributaria());
			logger.debug("Ingreso a getDatos 15.7 "  );		
			//Setea datos vendedor
			cabecera.setCodigoVenDealer(parametrosComercialesDTO.getCodigoVenDealer());
			cabecera.setCodigoVendedorRaiz(parametrosComercialesDTO.getCodigoVendedorRaiz());
			cabecera.setDireccionVendedor(parametrosComercialesDTO.getDireccionVendedor());
			cabecera.setOficinaVendedor(parametrosComercialesDTO.getOficinaVendedor());
			cabecera.setIndicadorTipoVenta(parametrosComercialesDTO.getIndicadorTipoVenta());
			cabecera.setCodigoOperadora(parametrosComercialesDTO.getCodigoOperadora());
			logger.debug("Ingreso a getDatos 15.8 cabecera.setIndicadorTipoVenta : " + cabecera.getIndicadorTipoVenta() );
			
			
			CreditoConsumoDTO[] listaCreditoConsumo = null;
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();			
			CreditoConsumoDTO creditoConsumo = new CreditoConsumoDTO();
			creditoConsumo.setCodigoCliente(null);
			creditoConsumo.setCodigoCreditoConsumo(listaCreditoConsumo[0].getCodigoCreditoConsumo());
			creditoConsumo.setDescripcionCreditoConsumo(null);
			parametrosSelec.setCreditoConsumo(creditoConsumo);
			logger.debug("Ingreso a getDatos 6");
			
			CreditoMorosidadDTO[] listaCreditoMorosidad = null;
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();			
			CreditoMorosidadDTO creditoMorosidad = new CreditoMorosidadDTO();
			creditoMorosidad.setCodigoCreditoMorosidad(listaCreditoMorosidad[0].getCodigoCreditoMorosidad());
			creditoMorosidad.setDescripcionCreditoMorosidad(null);
			parametrosSelec.setCreditoMorosidadDTO(creditoMorosidad);
			logger.debug("Ingreso a getDatos 7");
			
			ContratosDTO[] listaTipoContrato = null;
			
			/*listaCampanasVigentes = parametrosComercialesDTO.getCampanasVigentes();
			listaCausalDescuento = parametrosComercialesDTO.getCausalDescuento();
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();
			listaGrupoAfinidad = parametrosComercialesDTO.getGrupoAfinidad();
			listaGrupoCobroServicio = parametrosComercialesDTO.getGrupoCobroServicio();
			listaPlanIndemnizacion = parametrosComercialesDTO.getListaPlanIndemnizacion();
			listaPlanServicio = parametrosComercialesDTO.getListaPlanServicio();*/		
			listaTipoContrato = parametrosComercialesDTO.getListaTipoContrato();		
			/*Se almacena en el objeto de sesion todos los datos del contrato de la venta*/
			ContratosDTO contrato = new ContratosDTO();
			contrato.setCodigoTipoContrato(actLinea.getCod_tipContrato());
			contrato = getTipoContrato(contrato);
			
			//Para este sistema siempre sera contrato nuevo = 1
			contrato.setIndicadorContratoNuevo(Integer.parseInt(config.getString("indicador.contrato")));
			logger.debug("Ingreso a getDatos 15.9 contrato.getIndicadorContratoNuevo() : " + contrato.getIndicadorContratoNuevo() );
			if (contrato.getIndicadorContratoNuevo() == 1)
			{
				logger.debug("Ingreso a getDatos 15.9 " );
				ContratosDTO nuevoContrato = obtenerContratoNuevo();
				logger.debug("Ingreso a getDatos 15.9.0 nuevoCOntrato: " + nuevoContrato.getNumeroContrato() );
				logger.debug("Ingreso a getDatos 15.9.0 nuevoCOntrato: " + nuevoContrato.getNumeroMesesContrato() );
				if (nuevoContrato!=null){
					contrato.setNumeroContrato(nuevoContrato.getNumeroContrato());
				}
			}else{
				logger.debug("Ingreso a getDatos 15.10 contrato.getNumeroContrato() : " + contrato.getNumeroContrato() );
				contrato.setNumeroContrato(contrato.getNumeroContrato());
			}
	
			String numAnexo=null;			
			numAnexo=contrato.getNumeroContrato().substring(0,(contrato.getNumeroContrato().length()-1));
			numAnexo=numAnexo+String.valueOf(1);
			cabecera.setNumAnexo(numAnexo);
			
			ContratoDTO nroMeses = new ContratoDTO();
			nroMeses.setCodigoTipoContrato(actLinea.getCod_tipContrato());
			nroMeses = getVentasFacade().getNroMesesContrato(nroMeses);			
			contrato.setNumeroMesesSeleccionado(nroMeses.getNumeroMeses());
			logger.debug("NRO MESES CONTRATO : " + nroMeses.getNumeroMeses());			
			logger.debug("NUMERO CONTRATO : " + contrato.getNumeroContrato());
			logger.debug("TIPO CONTRATO : " + contrato.getCodigoTipoContrato());
			parametrosSelec.setContrato(contrato);
			
			//Obtiene parametros generales
			CabeceraArchivoDTO  cabeceraPG = getParametrosGenerales(cabecera);			
			cabecera.setParametroCalCliente(cabeceraPG.getParametroCalCliente());
			cabecera.setParametroCodigoAbc(cabeceraPG.getParametroCodigoAbc());
			cabecera.setParametroCodigo123(cabeceraPG.getParametroCodigo123());
			cabecera.setParametroCodigoEstadoCobros(cabeceraPG.getParametroCodigoEstadoCobros());
			cabecera.setParametroCodigoTerminalGSM(cabeceraPG.getParametroCodigoTerminalGSM());
			cabecera.setParametroCodigoSimcardGSM(cabeceraPG.getParametroCodigoSimcardGSM());
			cabecera.setTipoPlanPostpago(cabeceraPG.getTipoPlanPostpago());
			cabecera.setTipoPlanHibrido(cabeceraPG.getTipoPlanHibrido());
			cabecera.setDecimalesFormulario(cabeceraPG.getDecimalesFormulario());
			cabecera.setDecimalesBD(cabeceraPG.getDecimalesBD());
			cabecera.setDecimalesPorcentajeDescuento(cabeceraPG.getDecimalesPorcentajeDescuento());
			cabecera.setIndTelefono(cabeceraPG.getIndTelefono());
			logger.debug("Ingreso a getDatos 16");
			
			//Obtiene numero de venta y numero de transaccion de venta
			CabeceraArchivoDTO cabeceraPV = getParametrosVenta(cabecera);
			cabecera.setNumeroVenta(cabeceraPV.getNumeroVenta());
			cabecera.setNumeroTransaccionVenta(cabeceraPV.getNumeroTransaccionVenta());
			
			cabecera.setIndRenovacion(cabeceraPV.getIndRenovacion()); //EV 08/01/09
			
			logger.debug("Ingreso a getDatos 17");			
					
			cabecera.setParametros(parametrosSelec);
		}catch(VentasException e){		
			logger.debug(" e.getCodigo : "  + e.getCodigo() );
			logger.debug(" e.getCodigo : "  + e.getCodigoEvento() );
			logger.debug(" e.getCodigo : "  + e.getMessage() );
			logger.debug("Fin:altaLinea");
			logger.debug("IntegracionSIGAException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			// printTrazas(e);
			throw e;
		}
		return cabecera;
	}
	
	public CabeceraArchivoCOLDTO getDatosWeb(AltaLineaWebDTO actLinea) 
		throws VentasException, TasacionException, RemoteException
	{
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		try {
			logger.debug("Ingreso a getDatos ");					
			cabecera.setCodigoVendedor(actLinea.getCodDistribuidor());
			if( actLinea.getCodVendedor() != null && !actLinea.getCodVendedor().trim().equals("")){
				cabecera.setCodigoVenDealer(Long.valueOf(actLinea.getCodVendedor()).longValue());
			}else 
				cabecera.setCodigoVenDealer(0);
			
			
			cabecera.setCodigoCliente(actLinea.getCodCliente());
			cabecera.setCod_planTarif(actLinea.getCodPlanTarif());
			//TODO:cambiar a properties
			cabecera.setNumeroSeries("1");
			cabecera.setNro_icc(actLinea.getNumSerie());
			cabecera.setNro_imei(actLinea.getNumEquipo());
			cabecera.setNombreUsuario(actLinea.getNombreUsuarOra().toUpperCase());
			cabecera.setTipoCliente(actLinea.getCodTipoCliente());
			cabecera.setCod_cuota(actLinea.getCodCuotas());
			
			String servAdicionales = "";
			//Setea los servicios adicionales en caso que existan
			logger.debug("actLinea.getServSupActLineaDTO() : " + actLinea.getListaServicios());
			String caracterSS = config.getString("caracter.ss.adicionales");
			if(actLinea.getListaServicios() != null && actLinea.getListaServicios().length > 0)
			{
				logger.debug("Ingreso a getDatos 0.1");
				String codServicio = "";
			    for(int i=0; i<actLinea.getListaServicios().length; i++)
			    {
			    	logger.debug("Ingreso a getDatos 0.1  codServicio.lenght(): " + codServicio.length());
			    	codServicio = actLinea.getListaServicios()[i].getCodigoServicio();
			    	if(codServicio.length() == 2) codServicio = caracterSS.trim() + codServicio;
			    	if(codServicio.length() == 1) codServicio = caracterSS.trim() + caracterSS.trim() + codServicio;
			    	logger.debug("Ingreso a getDatos 0.2 : " + codServicio);			    	
			    	servAdicionales = servAdicionales + codServicio;			    	
			    	logger.debug("Ingreso a getDatos 0.3 servAdicionales: " + servAdicionales);
			    }						
			    cabecera.setServSuplAdicionales(servAdicionales.toUpperCase());			    
			}		    
			logger.debug("Ingreso a getDatos 1");
			
			//Llenado de valores de DTO ParametrosSeleccionados de CabeceraArchivo DTO		
			ParametrosSeleccionadosDTO parametrosSelec = new ParametrosSeleccionadosDTO();			
		
			//CausalDescuento
			logger.debug("getDatosWeb.CausalDescuento:" + actLinea.getCodCausaDescuento());
			CausalDescuentoDTO causaDcto = new CausalDescuentoDTO();
			causaDcto.setCodigoCausalDescuento(actLinea.getCodCausaDescuento());
			parametrosSelec.setCausalDescuento(causaDcto);			
			
			//GrupoCobroServicio
			logger.debug("getDatosWeb.GrupoCobroServicio:" + actLinea.getCodGrupoCobroServ());
			GrupoCobroServicioDTO grupoCobroServicio = new GrupoCobroServicioDTO();
			grupoCobroServicio.setCodigoGrupoCobroServicio(actLinea.getCodGrupoCobroServ());
			parametrosSelec.setGrupoCobroServicio(grupoCobroServicio);
			
			logger.debug("getDatosWeb.CampanaVigente:" + actLinea.getCodCampanaVigente());
			CampanaVigenteDTO campanaVigente = new CampanaVigenteDTO();		
			campanaVigente.setCodigoCampanasVigentes(actLinea.getCodCampanaVigente());
			parametrosSelec.setCampanaVigente(campanaVigente);						
			
			GrupoAfinidadDTO grupoAfinidad = new GrupoAfinidadDTO();
			grupoAfinidad.setCodigoGrupoAfinidad(null);
			grupoAfinidad.setDescripcionGrupoAfinidad(null);
			parametrosSelec.setGrupoAfinidad(grupoAfinidad);			
			
			PlanIndemnizacionDTO planIndemnizacion = new PlanIndemnizacionDTO();
			planIndemnizacion.setCodigoPlanIndemnizacion(null);
			planIndemnizacion.setDescripcionPlanIndemnizacion(null);
			parametrosSelec.setPlanIndemnizacion(planIndemnizacion);			
			
			ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();
			modalidadPago.setCodigoModalidadPago(actLinea.getCodModalidadVenta());
			modalidadPago = getVentasFacade().getModalidadPago(modalidadPago);
			parametrosSelec.setModalidadPagoDTO(modalidadPago);			
			
			NumeroCuotasDTO numeroCoutas = new NumeroCuotasDTO();
			numeroCoutas.setCodigo(actLinea.getCodCuotas()); //El parametro que envian corresponde al cod_cuota no al nro
			parametrosSelec.setNumeroCuotas(numeroCoutas);			
			
			TipoComisionistaDTO tipoComisionista = new TipoComisionistaDTO();
			tipoComisionista.setCodigoTipoComisionista(actLinea.getCodTipoComisionista());		
			parametrosSelec.setTipoComisionista(tipoComisionista);			
			
			PlanTarifarioDTO planTarif = new PlanTarifarioDTO();
			planTarif.setCodigoPlanTarifario(actLinea.getCodPlanTarif());
			planTarif.setCodigoProducto(config.getString("codigo.producto"));
			planTarif.setCodigoTecnologia(actLinea.getCodCelda());
			cabecera.setIdentificadorEmpresa(getTasacionFacade().getPlanTarifario(planTarif).getCodigoTipoPlan());			
			//Obtiene parametros comerciales
			ParametrosComercialesDTO  parametrosComercialesDTO = getParametrosComerciales(cabecera);			
			//Setea datos del Cliente			
			cabecera.setCodigoTipoIdentificacion(parametrosComercialesDTO.getCodigoTipoIdentificacion());
			cabecera.setNumeroIdentificacion(parametrosComercialesDTO.getNumeroIdentificacion());			
			cabecera.setNombreCliente(parametrosComercialesDTO.getNombreCliente());
			cabecera.setCodigoActividadCliente(parametrosComercialesDTO.getCodigoActividadCliente());
			cabecera.setCodigoCalidadCliente(parametrosComercialesDTO.getCodigoCalidadCliente());			
			cabecera.setCodigoCeldaCliente(parametrosComercialesDTO.getCodigoCeldaCliente());
			cabecera.setCodigoCicloCliente(parametrosComercialesDTO.getCodigoCicloCliente());
			cabecera.setCodigoCuentaCliente(parametrosComercialesDTO.getCodigoCuentaCliente());			
			cabecera.setFechaNacimientoCliente(parametrosComercialesDTO.getFechaNacimientoCliente());
			cabecera.setIndicadorEstadoCivilCliente(parametrosComercialesDTO.getIndicadorEstadoCivilCliente());
			cabecera.setIndicadorSexoCliente(parametrosComercialesDTO.getIndicadorSexoCliente());			
			cabecera.setIndicativoFacturableCliente(parametrosComercialesDTO.getIndicativoFacturableCliente());
			cabecera.setNombreApellido1Cliente(parametrosComercialesDTO.getNombreApellido1Cliente());
			cabecera.setNombreApellido2Cliente(parametrosComercialesDTO.getNombreApellido2Cliente());			
			cabecera.setDireccionCliente(parametrosComercialesDTO.getDireccionCliente());
			cabecera.setCodigoEmpresa(parametrosComercialesDTO.getCodigoEmpresa());
			cabecera.setPlanComercialCliente(parametrosComercialesDTO.getPlanComercialCliente());			
			//Setea datos del documento
			cabecera.setCodigoDocumento(parametrosComercialesDTO.getDocumento().getCodigo());
			cabecera.setTipoFoliacion(parametrosComercialesDTO.getDocumento().getTipoFoliacion());
			cabecera.setCategoriaTributaria(parametrosComercialesDTO.getDocumento().getCategoriaTributaria());					
			//Setea datos vendedor
			cabecera.setCodigoVenDealer(parametrosComercialesDTO.getCodigoVenDealer());
			cabecera.setCodigoVendedorRaiz(parametrosComercialesDTO.getCodigoVendedorRaiz());
			cabecera.setDireccionVendedor(parametrosComercialesDTO.getDireccionVendedor());
			cabecera.setOficinaVendedor(parametrosComercialesDTO.getOficinaVendedor());
			cabecera.setIndicadorTipoVenta(parametrosComercialesDTO.getIndicadorTipoVenta());
			cabecera.setCodigoOperadora(parametrosComercialesDTO.getCodigoOperadora());			
			logger.debug("Ingreso a getDatosWeb cabecera.setIndicadorTipoVenta : " + cabecera.getIndicadorTipoVenta() );
			
			
			CreditoConsumoDTO[] listaCreditoConsumo = null;
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();			
			CreditoConsumoDTO creditoConsumo = new CreditoConsumoDTO();
			creditoConsumo.setCodigoCliente(null);
			creditoConsumo.setCodigoCreditoConsumo(listaCreditoConsumo[0].getCodigoCreditoConsumo());
			creditoConsumo.setDescripcionCreditoConsumo(null);
			parametrosSelec.setCreditoConsumo(creditoConsumo);			
			
			CreditoMorosidadDTO[] listaCreditoMorosidad = null;
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();			
			CreditoMorosidadDTO creditoMorosidad = new CreditoMorosidadDTO();
			creditoMorosidad.setCodigoCreditoMorosidad(listaCreditoMorosidad[0].getCodigoCreditoMorosidad());
			creditoMorosidad.setDescripcionCreditoMorosidad(null);
			parametrosSelec.setCreditoMorosidadDTO(creditoMorosidad);			
			
			ContratosDTO[] listaTipoContrato = null;
			
			/*listaCampanasVigentes = parametrosComercialesDTO.getCampanasVigentes();
			listaCausalDescuento = parametrosComercialesDTO.getCausalDescuento();
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();
			listaGrupoAfinidad = parametrosComercialesDTO.getGrupoAfinidad();
			listaGrupoCobroServicio = parametrosComercialesDTO.getGrupoCobroServicio();
			listaPlanIndemnizacion = parametrosComercialesDTO.getListaPlanIndemnizacion();
			listaPlanServicio = parametrosComercialesDTO.getListaPlanServicio();*/		
			listaTipoContrato = parametrosComercialesDTO.getListaTipoContrato();		
			/*Se almacena en el objeto de sesion todos los datos del contrato de la venta*/
			ContratosDTO contrato = new ContratosDTO();
			contrato.setCodigoTipoContrato(actLinea.getCodTipoContrato());
			contrato = getTipoContrato(contrato);
			
			//Para este sistema siempre sera contrato nuevo = 1
			contrato.setIndicadorContratoNuevo(Integer.parseInt(config.getString("indicador.contrato")));			
			if (contrato.getIndicadorContratoNuevo() == 1)
			{
				ContratosDTO nuevoContrato = obtenerContratoNuevo();
				if (nuevoContrato!=null){
					contrato.setNumeroContrato(nuevoContrato.getNumeroContrato());
				}
			}else{				
				contrato.setNumeroContrato(contrato.getNumeroContrato());
			}
	
			String numAnexo=null;			
			numAnexo=contrato.getNumeroContrato().substring(0,(contrato.getNumeroContrato().length()-1));
			numAnexo=numAnexo+String.valueOf(1);
			cabecera.setNumAnexo(numAnexo);
			
			ContratoDTO nroMeses = new ContratoDTO();
			nroMeses.setCodigoTipoContrato(actLinea.getCodTipoContrato());
			nroMeses = getVentasFacade().getNroMesesContrato(nroMeses);			
			contrato.setNumeroMesesSeleccionado(nroMeses.getNumeroMeses());
			logger.debug("NRO MESES CONTRATO : " + nroMeses.getNumeroMeses());			
			logger.debug("NUMERO CONTRATO : " + contrato.getNumeroContrato());
			logger.debug("TIPO CONTRATO : " + contrato.getCodigoTipoContrato());
			parametrosSelec.setContrato(contrato);
			
			//Obtiene parametros generales
			CabeceraArchivoDTO  cabeceraPG = getParametrosGenerales(cabecera);			
			cabecera.setParametroCalCliente(cabeceraPG.getParametroCalCliente());
			cabecera.setParametroCodigoAbc(cabeceraPG.getParametroCodigoAbc());
			cabecera.setParametroCodigo123(cabeceraPG.getParametroCodigo123());
			cabecera.setParametroCodigoEstadoCobros(cabeceraPG.getParametroCodigoEstadoCobros());
			cabecera.setParametroCodigoTerminalGSM(cabeceraPG.getParametroCodigoTerminalGSM());
			cabecera.setParametroCodigoSimcardGSM(cabeceraPG.getParametroCodigoSimcardGSM());
			cabecera.setTipoPlanPostpago(cabeceraPG.getTipoPlanPostpago());
			cabecera.setTipoPlanHibrido(cabeceraPG.getTipoPlanHibrido());
			cabecera.setDecimalesFormulario(cabeceraPG.getDecimalesFormulario());
			cabecera.setDecimalesBD(cabeceraPG.getDecimalesBD());
			cabecera.setDecimalesPorcentajeDescuento(cabeceraPG.getDecimalesPorcentajeDescuento());
			cabecera.setIndTelefono(cabeceraPG.getIndTelefono());
			cabecera.setCodigoArticuloTerminal(actLinea.getCodArticuloSerieTerminal());
			cabecera.setNumeroVenta(actLinea.getNumeroVenta());			
			cabecera.setNumeroTransaccionVenta(actLinea.getNumeroTransaccionVenta());
			cabecera.setDescArticuloEquipo(actLinea.getDescArticuloEquipo());
			cabecera.setListaContactos(actLinea.getListaContactos());
			cabecera.setParametros(parametrosSelec);
		}catch(VentasException e){		
			logger.debug(" e.getCodigo : "  + e.getCodigo() );
			logger.debug(" e.getCodigo : "  + e.getCodigoEvento() );
			logger.debug(" e.getCodigo : "  + e.getMessage() );
			logger.debug("Fin:altaLinea");
			logger.debug("IntegracionSIGAException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			// printTrazas(e);
			throw e;
		}
		return cabecera;
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
	
	public void liberarSeries(String nroSimcard, String nroTerminal, String procEquipo, String numVenta, String codVendedor) 
		throws VentasException, RemoteException
	{
		logger.debug("Inicio:insertGaDocVentas");		
		try {			
			Long numeroVenta = new Long(0);
			if(numVenta != null && !numVenta.trim().equals("")) numeroVenta = Long.valueOf(numVenta); 
			getVentasFacade().liberarSeries(nroSimcard, nroTerminal, procEquipo,numeroVenta,codVendedor);
		}
		catch(VentasException e){
			context.setRollbackOnly();
			logger.debug("getNroMesesContrato:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new VentasException(e);
		}
		logger.debug("Fin:insertGaDocVentas");		
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
	public TiposContratoListOutDTO ListaTipoContrato()
		throws VentasException, RemoteException 
	{
		logger.debug("Lista_contratos():inicio");
		TiposContratoListOutDTO respuesta = new TiposContratoListOutDTO();
		try {
			logger.debug("Lista_contratos():antes");
			respuesta = getVentasFacade().ListaTipoContrato();
			logger.debug("Lista_contratos():despues");
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
	    logger.debug("Lista_contratos():fin");
	    return respuesta;
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
	public SimcardOutDTO validacionSimcard(SimcardInDTO entrada)
		throws VentasException, RemoteException 
	{
		logger.debug("Lista_contratos():inicio");
		SimcardOutDTO respuesta = new SimcardOutDTO();
		try {
			logger.debug("Lista_contratos():antes");			
			respuesta = getVentasFacade().validacionSimcard(entrada);			
			logger.debug("Lista_contratos():despues");
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
	    logger.debug("Lista_contratos():fin");
	    return respuesta;
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
	
	
	public SalidaOutDTO bloqueaSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws VentasException, RemoteException{
		SalidaOutDTO resultado = null;
		
		logger.debug("Inicio:bloqueaSolicitudEvRiesgo()");
		try {		
			// Valida estado civil
			resultado = getVentasFacade().bloqueaSolicitudEvRiesgo(registroEvaluacionRiesgo);
			// Valida dirección 
		} 
		catch (VentasException e) {
			logger.debug("Fin:getListPlanTarif");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		
		return resultado;
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
	
	
	public SalidaOutDTO desBloqueaEstadoSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws VentasException, RemoteException{
		SalidaOutDTO resultado = null;
		logger.debug("Inicio:desBloqueaEstadoSolicitudEvRiesgo()");
		try {		
			resultado = getVentasFacade().desBloqueaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo);
		} 
		catch (VentasException e) {
			logger.debug("Fin:getListPlanTarif");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		return resultado;
	}	
	
	
	// Valida si la subcategoria  ingresada existe en SCL
	private void validaSubCategoriaIngresada(String subCategoria) 
	     throws AltaClienteException,RemoteException  
	{
	    DatosGeneralesComDTO[] arrSubcategorias = getAltaClienteFacade().getListSubcategorias();
		boolean subcategoriaNoExisteEnLista = true;
		if (arrSubcategorias!=null){
		  for (int i = 0; i< arrSubcategorias.length; i++) {
			  if (arrSubcategorias[i].getCodigoValor().equals(subCategoria)) {
				  subcategoriaNoExisteEnLista = false;
				  break;
			  }
		  }
		}  
		if (subcategoriaNoExisteEnLista)  {
			AltaClienteException e = new AltaClienteException();
			e.setMessage("Codigo de subcategoria no definido en SCL");
			e.setDescripcionEvento("Codigo de subcategoria no definido en SCL");
			throw e;
	 }  
    }

	// Valida si el estado civil ingresado existe en SCL
	private void validaEstadoCivilIngresado(String estadoCivil) 
	     throws AltaClienteException,RemoteException  
	{
		logger.debug("inicio:validaEstadoCivilIngresado");
		logger.debug("Recupera Datos Inicio:validaEstadoCivilIngresado");
		DatosGeneralesComDTO[] arrEstadosCiv = getAltaClienteFacade().getListEstadosCiviles();
		logger.debug("Recupera Datos Fin:validaEstadoCivilIngresado");
		boolean estadoNoExisteEnLista = true;
		logger.debug("Antes del IF arrEstadosCiv!=null");
		if (arrEstadosCiv!=null){
			logger.debug("Despues del IF arrEstadosCiv!=null");
			logger.debug("Antes del FOR arrEstadosCiv.length ["+arrEstadosCiv.length+"]");	
		  for (int i = 0; i< arrEstadosCiv.length; i++) {
			  logger.debug("valor 1 [" + arrEstadosCiv[i].getCodigoValor().trim() +"] [valor 2" +  estadoCivil.trim()+"]");
			  logger.debug("valor 1 [" + arrEstadosCiv[i].getCodigoValor().trim() +"] [valor 2" +  estadoCivil.trim()+"]");
			  if (arrEstadosCiv[i].getCodigoValor().trim().equals(estadoCivil.trim())) {
				  estadoNoExisteEnLista = false;
				  break;
			  }
		  }
		}  
		if (estadoNoExisteEnLista)  {
			AltaClienteException e = new AltaClienteException();
			e.setMessage("Estado civil no definido en SCL");
			e.setDescripcionEvento("Estado civil no definido en SCL");
			throw e;
	    }  
    }
	
	// Valida si la direccion ingresada es consistente con SCL
	private void validaDireccion(DireccionNegocioDTO direccion) 
    throws VentasException,RemoteException {
		getVentasFacade().validaDireccion(direccion);
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
	
	/**
	 * realiza reversa de la venta
	 * @param CausalDescuentoComDTO (causalDescuentoComDTO)
	 * @return CausalDescuentoComDTO
	 * @throws VentasException,RemoteException
	 */		
	public void reversaVenta(CabeceraArchivoDTO objetoSesion) throws VentasException,RemoteException{
		logger.debug("reversaVenta():start");
		try{
			VentasFacadeSTL ventasFacade = getVentasFacade();
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(objetoSesion.getCodigoVendedor());
			vendedorDTO.setCodigoAccionBloqueo(config.getString("indicador.desbloqueo"));
			ventasFacade.bloqueaDesbloqueaVendedor(vendedorDTO);
			
			
			GaVentasDTO gaVentasDTO = new GaVentasDTO();
			
		  	gaVentasDTO.setNumVenta(new Long(objetoSesion.getNumeroVenta()));
		  	logger.debug("Numero Venta:" + gaVentasDTO.getNumVenta().longValue());
		  	if (objetoSesion.getCodigoVendedor() !=null){
		  		gaVentasDTO.setCodVendedor(new Long (objetoSesion.getCodigoVendedor()));
		  		logger.debug("codigo Vendedor:" + gaVentasDTO.getCodVendedor().longValue());
		  	}
		  	if (objetoSesion.getNombreUsuario() !=null){
		  		gaVentasDTO.setNomUsuarVta(objetoSesion.getNombreUsuario());
		  		logger.debug("Nombre usuario:" + gaVentasDTO.getNomUsuarVta());
		  	}
		  	if (objetoSesion.getNumeroProcesoFacturacion() !=null){
		  		gaVentasDTO.setNumProceso(new Long (objetoSesion.getNumeroProcesoFacturacion()));
		  		logger.debug("Numero proceso facturacion:" + gaVentasDTO.getNumProceso().longValue());
		  	}else
		  		gaVentasDTO.setNumProceso(new Long(0));
		  	
		  	gaVentasDTO.setNumTransaccion(new Long (objetoSesion.getNumeroTransaccionVenta()));
		  	logger.debug("Numero transaccion:" + objetoSesion.getNumeroTransaccionVenta());
		  	ventasFacade.reversaVenta(gaVentasDTO);
      		
		}catch (VentasException e) {
		  	logger.debug("VentasException");
		  	String log = StackTraceUtl.getStackTrace(e);
		  	logger.debug("log error[" + log + "]");
		  	throw e;
		} catch (Exception e) {
		  	logger.debug("Prueba de Exception");
		  	String log = StackTraceUtl.getStackTrace(e);
		  	logger.debug("log error[" + log + "]");
		  	throw new VentasException(e);
		}
		logger.debug("reversaVenta():end");
	 }//fin reversaVenta
	/*private CusRelManWSFacade getCusRelManWSFacade() throws Exception 
	{		
		logger.debug("getCusRelManWSFacade():start");
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		CusRelManWSFacadeHome facadeHome = null;

		String jndi = config.getString("jndi.CusRelManWSFacade");
		logger.debug("Buscando servicio[" + jndi + "]");		
		String url = config.getString("url.CusRelManWSProvider");
		logger.debug("Url provider[" + url + "]");		

		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (CusRelManWSFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, CusRelManWSFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new Exception(e); 
		}		
		logger.debug("Recuperada interfaz home de CusRelManWSFacade...");
		CusRelManWSFacade cusRelManWSFacade = null;

		try 
		{
			cusRelManWSFacade = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");		
			throw new Exception(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new Exception(e);
		}		
		logger.debug("getCusRelManWSFacade():end");
		return cusRelManWSFacade;
	}*/
	private VentasFacadeSTL getVentaFacade() throws Exception 
	{				
		logger.debug("getVentaFacade():start");
		String initialContextFactory = config.getString("initial.context.factory");
		logger.debug("Initial context factory[" + initialContextFactory + "]");

		VentasFacadeSTLHome facadeHome = null;

		String jndi = config.getString("jndi.VentasFacadeSTLFacade");
		logger.debug("Buscando servicio[" + jndi + "]");		
		String url = config.getString("url.VentasFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");		

		String securityPrincipal = config.getString("security.principal");
		logger.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = config.getString("security.credentials");
		logger.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (VentasFacadeSTLHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, VentasFacadeSTLHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + loge + "]");
			throw new Exception(e); 
		}		
		logger.debug("Recuperada interfaz home de getVentaFacade...");
		VentasFacadeSTL ventasFacadeSTL = null;

		try 
		{
			ventasFacadeSTL = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");		
			throw new Exception(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new Exception(e);
		}		
		logger.debug("getVentaFacade():end");
		return ventasFacadeSTL;
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
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada)
		throws VentasException, RemoteException 
	{
		logger.debug("altaCliente():start");
		NumeroIdentificacionDTO respuesta = new NumeroIdentificacionDTO();
		try {
			logger.debug("crearCliente:antes");
		    
			logger.debug("Orquestador: Antes de ingresar a crearCliente() ");
			respuesta =getAltaClienteFacade().validarIdentificador(entrada);
			logger.debug("Orquestador: Despues de ingresar a crearCliente() ");
			logger.debug("crearCliente:despues");
		}
		catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("altaCliente():end");
		return respuesta;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ActivacionLineaOutDTO altaLineaWeb(AltaLineaWebDTO alta) throws VentasException, RemoteException {
		// UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));
		logger.info("altaLineaWeb, inicio");
		ActivacionLineaOutDTO resultado = new ActivacionLineaOutDTO();
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		//Inicio P-CSR-11002 JLGN 24-04-2011
		DatosGeneralesVentaDTO respCreaLinea = new DatosGeneralesVentaDTO();
		//Fin P-CSR-11002 JLGN 24-04-2011
		try {
			cabecera = getDatosWeb(alta);
			cabecera.setCodUsoLinea(alta.getCodUsoLinea());
			boolean cabeceraOK = true;
			if (cabeceraOK == true) {
				logger.debug("altaLinea() --> validacionLinea()");
				ParametrosValidacionDTO[] detalleArchivo = validacionLineaWeb(alta);
				if (detalleArchivo.length > 0) {
					// -- CREACION DE LINEAS
					logger.debug("altaLinea() --> antes:crearLineas()");
					//Inicio P-CSR-11002 JLGN 24-04-2011
					//crearLineasWeb(detalleArchivo, cabecera, alta);
					respCreaLinea = crearLineasWeb(detalleArchivo, cabecera, alta);
					//Fin P-CSR-11002 JLGN 24-04-2011
					logger.debug("altaLinea() --> despues:crearLineas()");
				}
				// (+) EV 16/11/09, graba solicitud
				SolicitudVentaDTO solicitudVentaDTO = new SolicitudVentaDTO();
				solicitudVentaDTO.setNumVenta(alta.getNumeroVenta());
				solicitudVentaDTO.setTipoSolicitud(alta.getCodTipoSolicitud());
				solicitudVentaDTO.setNomUsuarora(alta.getNombreUsuarOra());
				getVentasFacade().guardarSolicitudVenta(solicitudVentaDTO);
				// (-) EV 16/11/09, graba solicitud
			}
		}
		catch (VentasException e) {
			logger.error("VentasException");
			context.setRollbackOnly();
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			if (cabecera.getNumeroVenta() != 0) {
				e.setMessageUser(String.valueOf(cabecera.getNumeroVenta()));
			}
			throw e;
		}
		catch (Exception e) {
			logger.error("Exception");
			context.setRollbackOnly();
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		//Inicio P-CSR-11002 JLGN 24-04-2011		
		resultado.setNumAbonado(respCreaLinea.getNum_abonado());
		resultado.setNumMovimiento(respCreaLinea.getNumMovimiento());
		//Fin P-CSR-11002 JLGN 24-04-2011
		logger.info("altaLineaWeb, fin");
		
		return resultado;
	}
	
	public CabeceraArchivoCOLDTO getDatosVentaWeb(AltaLineaWebDTO actLinea) 
		throws VentasException, TasacionException, RemoteException
	{
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		try {
							
			cabecera.setCodigoVendedor(actLinea.getCodDistribuidor());
			if( actLinea.getCodVendedor() != null && !actLinea.getCodVendedor().trim().equals("")){
				cabecera.setCodigoVenDealer(Long.valueOf(actLinea.getCodVendedor()).longValue());
			}else 
				cabecera.setCodigoVenDealer(0);
			
			
			cabecera.setCodigoCliente(actLinea.getCodCliente());
			cabecera.setCod_planTarif(actLinea.getCodPlanTarif());
			//TODO:cambiar a properties
			cabecera.setNumeroSeries("1");
			cabecera.setNro_icc(actLinea.getNumSerie());
			cabecera.setNro_imei(actLinea.getNumEquipo());
			cabecera.setNombreUsuario(actLinea.getNombreUsuarOra().toUpperCase());
			cabecera.setTipoCliente(actLinea.getCodTipoCliente());
			cabecera.setInd_ofiter(actLinea.getIndOfiter());			
			cabecera.setCod_actabo(actLinea.getCodActabo());
			
			//Llenado de valores de DTO ParametrosSeleccionados de CabeceraArchivo DTO		
			ParametrosSeleccionadosDTO parametrosSelec = new ParametrosSeleccionadosDTO();			
		
			
			ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();
			modalidadPago.setCodigoModalidadPago(actLinea.getCodModalidadVenta());
			modalidadPago = getVentasFacade().getModalidadPago(modalidadPago);
			parametrosSelec.setModalidadPagoDTO(modalidadPago);			
			
			NumeroCuotasDTO numeroCoutas = new NumeroCuotasDTO();
			numeroCoutas.setCodigo(actLinea.getCodCuotas()); //El parametro que envian corresponde al cod_cuota no al nro
			parametrosSelec.setNumeroCuotas(numeroCoutas);			
			
			/*VendedorDTO vendedor = new VendedorDTO();
			vendedor.setCodigoVendedor(actLinea.getCodDistribuidor());			
			vendedor.setCodigoVendedorDealer(cabecera.getCodV);
			vendedor = getVentasFacade().getVendedor(vendedor);*/			
			TipoComisionistaDTO tipoComisionista = new TipoComisionistaDTO();
			tipoComisionista.setCodigoTipoComisionista(actLinea.getCodTipoComisionista());		
			parametrosSelec.setTipoComisionista(tipoComisionista);			
			
			PlanTarifarioDTO planTarif = new PlanTarifarioDTO();
			planTarif.setCodigoPlanTarifario(actLinea.getCodPlanTarif());
			planTarif.setCodigoProducto(config.getString("codigo.producto"));
			planTarif.setCodigoTecnologia(actLinea.getCodCelda());
			cabecera.setIdentificadorEmpresa(getTasacionFacade().getPlanTarifario(planTarif).getCodigoTipoPlan());			
			//Obtiene parametros comerciales
			ParametrosComercialesDTO  parametrosComercialesDTO = getParametrosComerciales(cabecera);			
			//Setea datos del Cliente
			logger.debug("parametrosComercialesDTO.getNumeroIdentificacion() : " + parametrosComercialesDTO.getNumeroIdentificacion() );
			cabecera.setCodigoTipoIdentificacion(parametrosComercialesDTO.getCodigoTipoIdentificacion());
			cabecera.setNumeroIdentificacion(parametrosComercialesDTO.getNumeroIdentificacion());
			
			cabecera.setNombreCliente(parametrosComercialesDTO.getNombreCliente());
			cabecera.setCodigoActividadCliente(parametrosComercialesDTO.getCodigoActividadCliente());
			cabecera.setCodigoCalidadCliente(parametrosComercialesDTO.getCodigoCalidadCliente());
			
			cabecera.setCodigoCeldaCliente(parametrosComercialesDTO.getCodigoCeldaCliente());
			cabecera.setCodigoCicloCliente(parametrosComercialesDTO.getCodigoCicloCliente());
			cabecera.setCodigoCuentaCliente(parametrosComercialesDTO.getCodigoCuentaCliente());
			
			cabecera.setFechaNacimientoCliente(parametrosComercialesDTO.getFechaNacimientoCliente());
			cabecera.setIndicadorEstadoCivilCliente(parametrosComercialesDTO.getIndicadorEstadoCivilCliente());
			cabecera.setIndicadorSexoCliente(parametrosComercialesDTO.getIndicadorSexoCliente());
			
			cabecera.setIndicativoFacturableCliente(parametrosComercialesDTO.getIndicativoFacturableCliente());
			cabecera.setNombreApellido1Cliente(parametrosComercialesDTO.getNombreApellido1Cliente());
			cabecera.setNombreApellido2Cliente(parametrosComercialesDTO.getNombreApellido2Cliente());
			
			cabecera.setDireccionCliente(parametrosComercialesDTO.getDireccionCliente());
			cabecera.setCodigoEmpresa(parametrosComercialesDTO.getCodigoEmpresa());
			cabecera.setPlanComercialCliente(parametrosComercialesDTO.getPlanComercialCliente());
					
			//Setea datos del documento
			cabecera.setCodigoDocumento(parametrosComercialesDTO.getDocumento().getCodigo());
			cabecera.setTipoFoliacion(parametrosComercialesDTO.getDocumento().getTipoFoliacion());
			cabecera.setCategoriaTributaria(parametrosComercialesDTO.getDocumento().getCategoriaTributaria());
					
			//Setea datos vendedor
			cabecera.setCodigoVenDealer(parametrosComercialesDTO.getCodigoVenDealer());
			cabecera.setCodigoVendedorRaiz(parametrosComercialesDTO.getCodigoVendedorRaiz());
			cabecera.setDireccionVendedor(parametrosComercialesDTO.getDireccionVendedor());
			cabecera.setOficinaVendedor(parametrosComercialesDTO.getOficinaVendedor());
			cabecera.setIndicadorTipoVenta(parametrosComercialesDTO.getIndicadorTipoVenta());
			cabecera.setCodigoOperadora(parametrosComercialesDTO.getCodigoOperadora());
			logger.debug("cabecera.setIndicadorTipoVenta : " + cabecera.getIndicadorTipoVenta() );
			
			
			CreditoConsumoDTO[] listaCreditoConsumo = null;
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();			
			CreditoConsumoDTO creditoConsumo = new CreditoConsumoDTO();
			creditoConsumo.setCodigoCliente(null);
			creditoConsumo.setCodigoCreditoConsumo(listaCreditoConsumo[0].getCodigoCreditoConsumo());
			creditoConsumo.setDescripcionCreditoConsumo(null);
			parametrosSelec.setCreditoConsumo(creditoConsumo);
			
			
			CreditoMorosidadDTO[] listaCreditoMorosidad = null;
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();			
			CreditoMorosidadDTO creditoMorosidad = new CreditoMorosidadDTO();
			creditoMorosidad.setCodigoCreditoMorosidad(listaCreditoMorosidad[0].getCodigoCreditoMorosidad());
			creditoMorosidad.setDescripcionCreditoMorosidad(null);
			parametrosSelec.setCreditoMorosidadDTO(creditoMorosidad);
		
			
			ContratosDTO[] listaTipoContrato = null;
			
			/*listaCampanasVigentes = parametrosComercialesDTO.getCampanasVigentes();
			listaCausalDescuento = parametrosComercialesDTO.getCausalDescuento();
			listaCreditoConsumo = parametrosComercialesDTO.getCreditoConsumo();
			listaCreditoMorosidad = parametrosComercialesDTO.getCreditoMorosidad();
			listaGrupoAfinidad = parametrosComercialesDTO.getGrupoAfinidad();
			listaGrupoCobroServicio = parametrosComercialesDTO.getGrupoCobroServicio();
			listaPlanIndemnizacion = parametrosComercialesDTO.getListaPlanIndemnizacion();
			listaPlanServicio = parametrosComercialesDTO.getListaPlanServicio();*/		
			listaTipoContrato = parametrosComercialesDTO.getListaTipoContrato();		
			/*Se almacena en el objeto de sesion todos los datos del contrato de la venta*/
			ContratosDTO contrato = new ContratosDTO();
			contrato.setCodigoTipoContrato(actLinea.getCodTipoContrato());
			contrato = getTipoContrato(contrato);
			
			//Para este sistema siempre sera contrato nuevo = 1
			contrato.setIndicadorContratoNuevo(Integer.parseInt(config.getString("indicador.contrato")));
			logger.debug("contrato.getIndicadorContratoNuevo() : " + contrato.getIndicadorContratoNuevo() );
			if (contrato.getIndicadorContratoNuevo() == 1)
			{
			
				ContratosDTO nuevoContrato = obtenerContratoNuevo();
				logger.debug("nuevo contrato nroContrato: " + nuevoContrato.getNumeroContrato() );
				logger.debug("nuevo Contrato nroMesesContrato: " + nuevoContrato.getNumeroMesesContrato() );
				if (nuevoContrato!=null){
					contrato.setNumeroContrato(nuevoContrato.getNumeroContrato());
				}
			}else{
				logger.debug("contrato.getNumeroContrato() : " + contrato.getNumeroContrato() );
				contrato.setNumeroContrato(contrato.getNumeroContrato());
			}
	
			String numAnexo=null;			
			numAnexo=contrato.getNumeroContrato().substring(0,(contrato.getNumeroContrato().length()-1));
			numAnexo=numAnexo+String.valueOf(1);
			cabecera.setNumAnexo(numAnexo);
			
			ContratoDTO nroMeses = new ContratoDTO();
			nroMeses.setCodigoTipoContrato(actLinea.getCodTipoContrato());
			nroMeses = getVentasFacade().getNroMesesContrato(nroMeses);			
			contrato.setNumeroMesesSeleccionado(nroMeses.getNumeroMeses());
			logger.debug("NRO MESES CONTRATO : " + nroMeses.getNumeroMeses());			
			logger.debug("NUMERO CONTRATO : " + contrato.getNumeroContrato());
			logger.debug("TIPO CONTRATO : " + contrato.getCodigoTipoContrato());
			parametrosSelec.setContrato(contrato);
			
			//Obtiene parametros generales
			CabeceraArchivoDTO  cabeceraPG = getParametrosGenerales(cabecera);			
			cabecera.setParametroCalCliente(cabeceraPG.getParametroCalCliente());
			cabecera.setParametroCodigoAbc(cabeceraPG.getParametroCodigoAbc());
			cabecera.setParametroCodigo123(cabeceraPG.getParametroCodigo123());
			cabecera.setParametroCodigoEstadoCobros(cabeceraPG.getParametroCodigoEstadoCobros());
			cabecera.setParametroCodigoTerminalGSM(cabeceraPG.getParametroCodigoTerminalGSM());
			cabecera.setParametroCodigoSimcardGSM(cabeceraPG.getParametroCodigoSimcardGSM());
			cabecera.setTipoPlanPostpago(cabeceraPG.getTipoPlanPostpago());
			cabecera.setTipoPlanHibrido(cabeceraPG.getTipoPlanHibrido());
			cabecera.setDecimalesFormulario(cabeceraPG.getDecimalesFormulario());
			cabecera.setDecimalesBD(cabeceraPG.getDecimalesBD());
			cabecera.setDecimalesPorcentajeDescuento(cabeceraPG.getDecimalesPorcentajeDescuento());
			cabecera.setIndTelefono(cabeceraPG.getIndTelefono());
			
			cabecera.setNumeroVenta(actLinea.getNumeroVenta());			
			cabecera.setNumeroTransaccionVenta(actLinea.getNumeroTransaccionVenta());
			cabecera.setCodGrpPrestacion(actLinea.getCodGrpPrestacion());					
			cabecera.setParametros(parametrosSelec);
			
		}catch(VentasException e){		
			logger.debug(" e.getCodigo : "  + e.getCodigo() );
			logger.debug(" e.getCodigo : "  + e.getCodigoEvento() );
			logger.debug(" e.getCodigo : "  + e.getMessage() );
			logger.debug("Fin:altaLinea");
			logger.debug("IntegracionSIGAException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			// printTrazas(e);
			throw e;
		}
		return cabecera;
	}

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ActivacionLineaOutDTO altaVentaWeb(AltaLineaWebDTO alta) 
		throws VentasException, RemoteException 
	{		
		UtilLog.setLog(config.getString("ActivacionMasivaORQEJB.log"));		
		logger.debug("altaVentaWeb(), inicio");
		ActivacionLineaOutDTO resultado = new ActivacionLineaOutDTO();
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();		
		VendedorDTO vendedor = new VendedorDTO();
		try {			
			logger.debug("altaVentaWeb() --> getdatos()");
			cabecera = getDatosVentaWeb(alta);
			//cabecera.setCodUsoLinea(alta.getCodUsoLinea());
			
			boolean cabeceraOK = true;
			
			if (cabeceraOK == true)
			{			
				logger.debug("altaVentaWeb() --> validacionLinea()");				
				//if (detalleArchivo.length>0)
				//{					
					 //-- CREACION DE LINEAS
					logger.debug("		altaVentaWeb() --> crearLineas()");					
					
					vendedor.setCodigoVendedor(cabecera.getCodigoVendedor());
					vendedor.setCodigoVendedorDealer(cabecera.getCodigoVenDealer());
					vendedor = getVentasFacade().getVendedor(vendedor);								
					
					ParametrosSeleccionadosDTO parametros = cabecera.getParametros();					
					CiudadDTO ciudad = new CiudadDTO();
					ciudad.setCodigoCiudad(vendedor.getDireccion().getCiudad());		
					parametros.setCiudad(ciudad);
					ProvinciaDTO provincia = new ProvinciaDTO();
					provincia.setCodigoProvincia(vendedor.getDireccion().getProvincia());					
					parametros.setProvincia(provincia);
					RegionDTO region = new RegionDTO();
					region.setCodigoRegion(vendedor.getDireccion().getRegion());
					parametros.setRegion(region);				
					
					cabecera.setParametros(parametros);
					cabecera.setCodigoCalificacion(alta.getCodCalificacion());
					cabecera.setCodTipoSolicitud(alta.getCodTipoSolicitud());
					
					logger.debug("		altaVentaWeb() --> obtieneCargos()");
					RegCargosDTO objetoCargos = obtieneCargos(cabecera);
					String aplicaTipoCargo = config.getString("aplica.tipo.cargo");
					objetoCargos.setAplicaTipoCargo(aplicaTipoCargo!=null & aplicaTipoCargo.equals("true")?true:false);					
					CargoDTO[] cargosVenta = objetoCargos.getCargos();
					
					//--Registrar Cargos
					RegCargosDTO listadoCargosDTO = new RegCargosDTO();
					listadoCargosDTO.setObjetoSesion(cabecera);
					CargoDTO[] cargos = cargosVenta;
					listadoCargosDTO.setCargos(cargos);
					
					logger.debug("cargos: " + cargos.length);
					logger.debug("altaVentaWeb() --> registrarCargos()");
					ResultadoRegCargosDTO resultadoRegCargos = registrarCargos(listadoCargosDTO);
					
					//Aceptar presupuesto		
					logger.debug("altaVentaWeb() --> aceptarPresupuesto()");
					//aceptarPresupuesto(cabecera);					
					
					//--Cierre venta
					String numeroContrato =cabecera.getParametros().getContrato().getNumeroContrato(); 
					String numAnexo = numeroContrato.substring(0,(numeroContrato.length()-String.valueOf(1).length()));
					numAnexo=numAnexo+String.valueOf(1);
					
					logger.debug("altaVentaWeb() --> cierreVenta()");
					cabecera.setCodGrpPrestacion(alta.getCodGrpPrestacion());
					cabecera.setCodTipoSolicitud(alta.getCodTipoSolicitud());
					//Inicio P-CSR-11002 JLGN 24-04-2011
					cabecera.setArrayNumAbonado(alta.getArrayNumAbonado());
					cabecera.setArrayNumMovimiento(alta.getArrayNumMovimiento());
					//Fin P-CSR-11002 JLGN 24-04-2011
					
					cierreVenta(cabecera);
					
					GaDocVentasDTO gaDocVentasDTO=new GaDocVentasDTO();
					gaDocVentasDTO.setNum_Venta(new Long(cabecera.getNumeroVenta()));
					gaDocVentasDTO.setNum_Folio(numAnexo);					
					gaDocVentasDTO=getVentasFacade().insertGaDocVentas(gaDocVentasDTO);
					
					//Inserta datos cliente factura
					logger.debug("Inicio:crearCliente() --> Inserta cliente factura imprimible");
					if(alta.getNumeroIdentClienteFactura() != null && !alta.getNumeroIdentClienteFactura().trim().equals(""))
					{
						ClienteAltaDTO cliente = new ClienteAltaDTO();
						cliente.setCodigoCliente(alta.getCodCliente());
						cliente.setNombreClienteFactura(alta.getNombreClienteFactura()); 
						cliente.setApellido1ClienteFactura(alta.getApellido1ClienteFactura());
						cliente.setApellido2ClienteFactura(alta.getApellido2ClienteFactura());
						cliente.setTipoIdentClienteFactura(alta.getTipoIdentClienteFactura());			
						cliente.setNumeroIdentClienteFactura(alta.getNumeroIdentClienteFactura());
						cliente.setTipoFacturaClienteFactura(config.getString("tipo.factura.cliente.factura").trim());
						cliente.setTipoDocumentoClienteFactura(Long.valueOf(config.getString("tipo.documento.cliente.factura").trim()));
						cliente.setNumVentaClienteFactura(new Long(alta.getNumeroVenta()));
						cliente.setNombreUsuarOra(alta.getNombreUsuarOra());
						getAltaClienteFacade().crearClienteFacturaImprimible(cliente);
					}
					
					//-- SOLICITUD SCORING
					if(alta.getCodTipoSolicitud().trim().equals(config.getString("tipo.solicitud.scoring")) || 
							alta.getActualizadaScoringNormal() == 1 )
					{
						SolScoringVentaDTO scoringVenta = new SolScoringVentaDTO();
						scoringVenta.setNumSolScoring(alta.getNumSolScoring());
						scoringVenta.setNumVenta(alta.getNumeroVenta());
						
						EstadoScoringDTO estadoScoring = new EstadoScoringDTO();
						estadoScoring.setCodVendedor(Long.valueOf(cabecera.getCodigoVendedor()).longValue());
						estadoScoring.setNumSolScoring(alta.getNumSolScoring());
						estadoScoring.setCodEstado(alta.getCodEstadoEscoring());
						getVentasFacade().insertaSolScoringVenta(scoringVenta, estadoScoring);
					}
					
					//-- DATOS PARA LA SALIDA					
					resultado.setNumVenta(String.valueOf(alta.getNumeroVenta()));
					logger.debug("altaVentaWeb() numVenta:"+ alta.getNumeroVenta());
			}				
		}
		catch (VentasException e) {			
			logger.debug("e.getMessage(): " +  e.getMessage());
			logger.error("VentasException");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error [" + log + "]");	
			if(cabecera.getNumeroVenta() != 0) 	{
				e.setMessageUser(String.valueOf(cabecera.getNumeroVenta()));
			}
			throw e;			
		}
		catch (Exception e) {
			logger.debug("Exception");
			context.setRollbackOnly();
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("altaVentaWeb(), fin");
		return resultado;		
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada) 
		throws VentasException, RemoteException , GeneralException
	{
		logger.debug("getCargosVta():start");
		//Por problema de sesion expirada se reversa la venta en caso que se este formalizando por segunda vez ya que no se hizo el proceso completo
		getVentasFacade().reversaCargosFormalizacion(new Long(entrada.getNumVenta()));
		CargoSolicitudDTO[] resultado = null;
		
		
		//Para prepago no se calculan cargos adelantados
		if(!entrada.getCodTipoCliente().trim().equals("3"))
		{
			CargoDTO[] arregloCargos =null;
			List listaCargos = new ArrayList();
			//Antes de obtener los cargos se deben registrar los cargos faltantes asociados al Plan Tarifario y los SS
			//filtrados por cobro adelantado. Se debe hacer en este momento por el prorrateo		
			ParametrosObtencionCargosDTO parametros = new ParametrosObtencionCargosDTO();
			parametros.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
			parametros.setCodigoVendedor(String.valueOf(entrada.getCodVendedor()));			
			parametros.setEsSolicitudVenta(false);
			parametros.setCodigoModalidadVenta(String.valueOf(entrada.getCodModalidadVenta()));
			
			
			ContratoDTO nroMeses = new ContratoDTO();
			nroMeses.setCodigoTipoContrato(entrada.getCodTipoContrato());
			nroMeses = getVentasFacade().getNroMesesContrato(nroMeses);
			parametros.setNumeroMesesContrato(nroMeses.getNumeroMeses());			
			
			parametros.setTipoPlanPostPago(config.getString("tipo.plan.postpago").trim());
			parametros.setTipoPlanPrepago(config.getString("tipo.plan.prepago").trim());
			
			logger.debug("entrada.getIndOfiter():"+entrada.getIndOfiter());			
			
			if(entrada.getIndOfiter()!= null && entrada.getIndOfiter().trim().equals("O")) 
			{
				parametros.setCod_actabo(config.getString("codigo.actuacion.venta.oficina").trim());	
				parametros.setIndicadorTipoVenta(0);
			}else if(entrada.getIndOfiter()!= null && entrada.getIndOfiter().trim().equals("T")){
				parametros.setCod_actabo(config.getString("codigo.actuacion.venta.terreno").trim());
				parametros.setIndicadorTipoVenta(1);
			}
			
			ObtencionCargosDTO objetoCargos= getVentasFacade().obtenerCargos(parametros);
							
			CargosDTO[] cargos =objetoCargos.getCargos();
			if (cargos !=null){
				if (cargos.length>0){
					for (int i=0;i<cargos.length;i++)
					{						
						CargoDTO cargo = new CargoDTO();
						cargo.setCodigoArticuloServicio(cargos[i].getAtributo().getCodigoArticuloServicio());
						cargo.setTipoProducto(cargos[i].getAtributo().getTipoProducto());
						cargo.setCantidad(cargos[i].getCantidad());
						PrecioDTO precio = cargos[i].getPrecio();
						cargo.setCodigoConceptoPrecio(precio.getCodigoConcepto());
						cargo.setDescripcionConceptoPrecio(precio.getDescripcionConcepto());
						cargo.setMontoConceptoPrecio(new Double(precio.getMonto()).floatValue());
						cargo.setCodigoMoneda(precio.getUnidad().getCodigo());
						cargo.setDescripcionMoneda(precio.getUnidad().getDescripcion());
						cargo.setInd_equipo(precio.getDatosAnexos().getInd_equipo());
						cargo.setInd_paquete(precio.getDatosAnexos().getInd_paquete());
						cargo.setNum_abonado(precio.getDatosAnexos().getNum_abonado());
						cargo.setNum_terminal(precio.getDatosAnexos().getNum_terminal());
						if(precio.getDatosAnexos().getEsCobroAdelantado()==0)
						{
							cargo.setEsCobroAdelantado(0);
						}else{
							cargo.setEsCobroAdelantado(1);
							cargo.setTipoServicioCobroAdelantado(precio.getDatosAnexos().getTipoServicioCobroAdelantado());
						}
						cargo.setNum_serie(precio.getNroSerie());
						cargo.setCod_bodega(precio.getCodBodega());						
						DescuentoDTO[] arregloDescuento = cargos[i].getDescuento();				
						
						if (arregloDescuento!=null)
							if (arregloDescuento.length>0)
							{
								/*Recorre los descuentos. Si existe descuento automatico se asigna este como descuento del cargo, 
								en caso contrario toma el código del descuento manual. Si existen los dos tipos de descuentos toma
								el codigo concepto del descuento automatico*/
								for (int k=0;k<arregloDescuento.length;k++)
								{
									if (arregloDescuento[k].getTipo()==null)
									{
										if (arregloDescuento[k].getCodigoConcepto()!=null && cargo.getCodigoDescuento()==null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
									}else if (arregloDescuento[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)))
									{
										if (arregloDescuento[k].getCodigoConcepto()!=null){
											cargo.setCodigoDescuento(arregloDescuento[k].getCodigoConcepto());
										}
										cargo.setDescripcionDescuento(arregloDescuento[k].getDescripcionConcepto());
										cargo.setMontoDescuento(arregloDescuento[k].getMonto());
										cargo.setTipoDescuento(arregloDescuento[k].getTipoAplicacion());		
									}																		
								}														
							}else{
								cargo.setCodigoDescuento("");
								cargo.setMontoDescuento(0);
							}								
						else{
							cargo.setMontoDescuento(0);
						}
						cargo.setDescuentoManual(1);						
						listaCargos.add(cargo);											
					}
				}
			}
			arregloCargos =(CargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCargos.toArray(), CargoDTO.class);		
			
			//--Registrar Cargos
			RegCargosDTO listadoCargos = new RegCargosDTO();
			listadoCargos.setCargos(arregloCargos);
			logger.debug("cargos !!!!!! : " + cargos.length);
			ParametrosRegistroCargosDTO registro = new ParametrosRegistroCargosDTO();	
			
			registro.setCargos(cargos);
			registro.setCodigoCliente(String.valueOf(entrada.getCodCliente()));
			registro.setCodigoVendedor(String.valueOf(entrada.getCodVendedor()));
			registro.setCodigoOficina(entrada.getCodOficina());
			registro.setModalidadVenta(String.valueOf(entrada.getCodModalidadVenta()));
			registro.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
			registro.setNumeroTransaccion(String.valueOf(entrada.getNumTransaccionVenta()));
			
			
			//Busca Datos del Cliente
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodigoCliente(String.valueOf(entrada.getCodCliente()));			
			cliente = getVentasFacade().getCliente(cliente);
			registro.setCodigoPlanComercial(cliente.getPlanComercial());
			
			List listaCargos2 = new ArrayList();
		
			for (int i=0;i<arregloCargos.length;i++){			
				CargosDTO cargo = new CargosDTO();
				
				PrecioDTO precio = new PrecioDTO();
				precio.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoConceptoPrecio());
				precio.setMonto(listadoCargos.getCargos()[i].getMontoConceptoPrecio()/listadoCargos.getCargos()[i].getCantidad());
				MonedaDTO moneda = new MonedaDTO();
				moneda.setCodigo(listadoCargos.getCargos()[i].getCodigoMoneda());
				precio.setUnidad(moneda);	
				precio.setNroSerie(listadoCargos.getCargos()[i].getNum_serie());
				precio.setCodBodega(listadoCargos.getCargos()[i].getCod_bodega());
				
				
				DescuentoDTO[] arregloDescuento = new DescuentoDTO[2];			
				
				DescuentoDTO descuento = new DescuentoDTO();
				descuento.setTipo(String.valueOf(TipoDescuentos.Manual)); // Manual
				descuento.setTipoAplicacion(listadoCargos.getCargos()[i].getTipoDescuentoManual());//0-Monto 1-Porcentaje
				descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuentoManual());
				descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
				arregloDescuento[0] = descuento;
				descuento = new DescuentoDTO();
				descuento.setCodigoConcepto(listadoCargos.getCargos()[i].getCodigoDescuento());
				descuento.setTipo(String.valueOf(TipoDescuentos.Automatico)); // Automatico
				descuento.setTipoAplicacion(listadoCargos.getCargos()[i].getTipoDescuento());//0-Monto 1-Porcentaje
				descuento.setMonto(listadoCargos.getCargos()[i].getMontoDescuento());
				arregloDescuento[1] = descuento;
				AtributosMigracionDTO atributo = new AtributosMigracionDTO();
				if (entrada.getCodCuota()!=null && !entrada.getCodCuota().trim().equals(""))
				{	
					atributo.setCuotas(Integer.parseInt(entrada.getCodCuota()));
				}else {				
					atributo.setCuotas(0);
				}			
				atributo.setInd_equipo(listadoCargos.getCargos()[i].getInd_equipo());			
				atributo.setInd_paquete(listadoCargos.getCargos()[i].getInd_paquete());			
				atributo.setTipoProducto(listadoCargos.getCargos()[i].getTipoProducto());			
				atributo.setCodigoArticuloServicio(listadoCargos.getCargos()[i].getCodigoArticuloServicio());
				atributo.setTipoServicioCobroAdelantado(listadoCargos.getCargos()[i].getTipoServicioCobroAdelantado());
				if(listadoCargos.getCargos()[i].getEsCobroAdelantado()==0)
				{	
					atributo.setEsCobroAdelantado(0);
				}else {
					atributo.setEsCobroAdelantado(1);
				}
				//Para la formalizacion el idncador de cuotas es siempre 0
				atributo.setInd_cuota("0");			
				cargo.setPrecio(precio);
				cargo.setDescuento(arregloDescuento);
				cargo.setAtributo(atributo);
				cargo.setCantidad(listadoCargos.getCargos()[i].getCantidad());
				
				cargo.setNum_abonado(listadoCargos.getCargos()[i].getNum_abonado());
				cargo.setNum_terminal(listadoCargos.getCargos()[i].getNum_terminal());				
				
				listaCargos2.add(cargo);			
			}
	
			CargosDTO[] arregloCargos2 =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCargos2.toArray(), CargosDTO.class);
			
			registro.setCargos(arregloCargos2);
			registro.setNombreUsuario(entrada.getNombreUsuario());
			getVentasFacade().registrarCargos(registro);
		}
		
		resultado = getVentasFacade().getCargosVta(entrada);
		logger.debug("getCargosVta():end");
		return resultado;
	}//fin getCargosVta
	
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * @throws AltaClienteException 
	 * @throws VentasException 
	 * @throws RemoteException 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoAltaCarrierPasilloLDIDTO altaCarrierPasilloLDI(AltaCarrierPasilloLDIDTO dto) throws VentasException, RemoteException, AltaClienteException 
	{
		logger.info("Inicio");
		ResultadoAltaCarrierPasilloLDIDTO r = new ResultadoAltaCarrierPasilloLDIDTO();
		logger.debug("Argumentos: AltaCarrierPasilloLDIDTO dto: ");
		logger.debug(dto.toString());
		
		final AltaClienteFacadeSTL altaClienteFacade = getAltaClienteFacade();
		final VentasFacadeSTL ventasFacade = getVentasFacade();
		
		com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO oficinaDTO = ventasFacade.getDireccionOficina(dto.getCodOficina());
		
		logger.debug("oficinaDTO.getCodigoRegion(): " + oficinaDTO.getCodigoRegion());
		logger.debug("oficinaDTO.getCodigoProvincia(): " + oficinaDTO.getCodigoProvincia());
		logger.debug("oficinaDTO.getCodigoCiudad(): " + oficinaDTO.getCodigoCiudad());
		
		ClienteAltaDTO clienteDTO = new ClienteAltaDTO();
		
		clienteDTO.setCodigoOficina(dto.getCodOficina());		
		
		if (dto.getCodTipoCliente().trim().equals(config.getString("tipo.cliente.particular").trim())) {
			clienteDTO.setNombreCliente(dto.getNombres());
			logger.debug("clienteAltaDTO.getNombreCliente(): " + clienteDTO.getNombreCliente());

			clienteDTO.setNombreApellido1(dto.getApellido1());
			logger.debug("clienteAltaDTO.getNombreApellido1(): " + clienteDTO.getNombreApellido1());

			String apellido2 = dto.getApellido2();
			clienteDTO.setNombreApellido2(apellido2);
			logger.debug("clienteAltaDTO.getNombreApellido2(): " + clienteDTO.getNombreApellido2());
		}
		else if (dto.getCodTipoCliente().trim().equals(config.getString("tipo.cliente.empresa").trim())&&
				dto.getCodTipoCliente().trim().equals(config.getString("tipo.cliente.pyme").trim())) {//MA-184592
			String nombreEmpresa = dto.getNombreEmpresa();
			clienteDTO.setNombreCliente(nombreEmpresa);
			logger.debug("clienteAltaDTO.getNombreCliente(): " + clienteDTO.getNombreCliente());

			String razonSocial = dto.getRazonSocial();
			clienteDTO.setRazonSocial(razonSocial);
			logger.debug("clienteAltaDTO.getRazonSocial(): " + clienteDTO.getRazonSocial());

			String apellido1 = "*";
			clienteDTO.setNombreApellido1(apellido1);
			logger.debug("clienteAltaDTO.getNombreApellido1(): " + clienteDTO.getNombreApellido1());

			String apellido2 = "*";
			clienteDTO.setNombreApellido2(apellido2);
		
			logger.debug("clienteAltaDTO.getNombreApellido2(): " + clienteDTO.getNombreApellido2());
		}
		
		clienteDTO.setCant_antLaborando(new Long(config.getString("cliente.por.defecto.cant_anlabor")));
		clienteDTO.setCategoriaTributaria(config.getString("cliente.por.defecto.cod_catribut"));
		clienteDTO.setCodigoCategImpos(config.getString("cliente.por.defecto.cod_catimpos"));
		clienteDTO.setCodigo123(config.getString("cliente.por.defecto.cod_123"));
		clienteDTO.setCodigoABC(config.getString("cliente.por.defecto.cod_abc"));
		clienteDTO.setCodigoCalidadCliente(config.getString("cliente.por.defecto.cod_calclien"));
		clienteDTO.setCodCalificacion(config.getString("cliente.por.defecto.cod_calificacion"));
		clienteDTO.setCodigoCategoria(config.getString("cliente.por.defecto.cod_categoria"));
		clienteDTO.setCodColor(config.getString("cliente.por.defecto.cod_color"));
		clienteDTO.setCodCrediticia(config.getString("cliente.por.defecto.cod_crediticia"));
		clienteDTO.setCodigoIdioma(config.getString("cliente.por.defecto.cod_idioma"));
		clienteDTO.setCodigoNPI(config.getString("cliente.por.defecto.cod_npi"));
		
		// Incidencia 132694. Plan Tarifario viene desde pantalla
		clienteDTO.setCodigoPlanTarifario(dto.getCodigoPlanTarifario());
		logger.debug("clienteDTO.getCodigoPlanTarifario(): " + clienteDTO.getCodigoPlanTarifario());
		clienteDTO.setCodSegmento(config.getString("cliente.por.defecto.cod_segmento"));
		clienteDTO.setCodigoTipoCliente(dto.getCodTipoCliente().trim());
		clienteDTO.setCodigoUso(config.getString("cod_uso.carrier"));
		logger.trace("clienteDTO.getCodigoUso(): " + clienteDTO.getCodigoUso());
		clienteDTO.setIndicadorAcepVenta(config.getString("cliente.por.defecto.ind_acepvent"));
		clienteDTO.setIndicadorAgente(config.getString("cliente.por.defecto.ind_agente"));
		clienteDTO.setIndicadorAlta(config.getString("cliente.por.defecto.ind_alta"));
		clienteDTO.setIndicadorDebito(config.getString("cliente.por.defecto.ind_debito"));
		clienteDTO.setIndicativoFacturable(new Integer(config.getString("cliente.por.defecto.ind_factur")).intValue());
		clienteDTO.setFacturaElectronica(config.getString("cliente.por.defecto.ind_facturaelectronica"));
		clienteDTO.setIndicadorSituacion(config.getString("cliente.por.defecto.ind_situacion"));
		clienteDTO.setIndicadirTipPersona(config.getString("cliente.por.defecto.ind_tippersona"));
		clienteDTO.setIndicadorTraspaso(config.getString("cliente.por.defecto.ind_traspaso"));
		clienteDTO.setNumeroAbotrunk(config.getString("cliente.por.defecto.num_abotrunk"));
		clienteDTO.setNumeroAbotrek(config.getString("cliente.por.defecto.num_abotrek"));
		ModalidadCancelacionComDTO modalidad = new ModalidadCancelacionComDTO();
		modalidad.setCodigo(config.getString("cliente.por.defecto.ind_debito"));
		clienteDTO.setModalidadCancelacionComDTO(modalidad);
		clienteDTO.setNombreUsuarOra(dto.getNomUsuarioOra());
		logger.debug("clienteDTO.getNombreUsuarOra(): " + clienteDTO.getNombreUsuarOra());

		clienteDTO.setCodigoOperadora(dto.getCodOperadora());

		String codOperadoraGuatemala = config.getString("codigo.operadora.guatemala");
		String codOperadoraElSalvador = config.getString("codigo.operadora.salvador");
		logger.debug("codOperadoraGuatemala: " + codOperadoraGuatemala);
		logger.debug("codOperadoraElSalvador: " + codOperadoraElSalvador);
		if (dto.getCodOperadora().trim().equals(codOperadoraGuatemala.trim())) {
			clienteDTO.setCodigoTipoIdentificacion(config.getString("cliente.por.defecto.cod_tipident.guatemala"));
			clienteDTO.setNumeroIdentificacion(config.getString("cliente.por.defecto.num_ident.guatemala"));
			clienteDTO.setNumeroIdentificacionTributaria(config.getString("cliente.por.defecto.num_ident.guatemala"));
		}
		else if (dto.getCodOperadora().trim().equals(codOperadoraElSalvador.trim())) {
				clienteDTO.setCodigoTipoIdentificacion(config.getString("cliente.por.defecto.cod_tipident.salvador"));
				clienteDTO.setNumeroIdentificacion(config.getString("cliente.por.defecto.num_ident.salvador"));
				clienteDTO.setNumeroIdentificacionTributaria(config.getString("cliente.por.defecto.num_ident.salvador"));
		}

		logger.debug("clienteDTO.getCodigoTipoIdentificacion(): " + clienteDTO.getCodigoTipoIdentificacion());
		logger.debug("clienteDTO.getNumeroIdentificacion(): " + clienteDTO.getNumeroIdentificacion());
		logger.debug("clienteDTO.getNumeroIdentificacionTributaria(): "
				+ clienteDTO.getNumeroIdentificacionTributaria());

		DireccionNegocioWebDTO[] dirs = new DireccionNegocioWebDTO[3];
		dirs[0] = new DireccionNegocioWebDTO();
		dirs[0].setTipo(Integer.valueOf(config.getString("codigo.tipo.dir.facturacion").trim()).intValue());
		logger.debug("dirs[0].getTipo(): " + dirs[0].getTipo());
		
		dirs[0].setCodDepartamento(dto.getCodRegion());
		logger.debug("dirs[0].getCodDepartamento(): " + dirs[0].getCodDepartamento());
		
		dirs[0].setCodMunicipio(dto.getCodProvincia());
		logger.debug("dirs[0].getCodMunicipio(): " + dirs[0].getCodMunicipio());
		
		
		// Incidencia 134089: setear el valor de comuna (Loc/Barrio)
		dirs[0].setCodZonaDistrito(dto.getCodCiudad());
		logger.trace("dirs[0].getCodZonaDistrito(): " + dirs[0].getCodZonaDistrito());
		
		dirs[0].setLocBarrio(dto.getCodComuna());
		logger.debug("dirs[0].getLocBarrio(): " + dirs[0].getLocBarrio());
		
		dirs[0].setDesDirec1(dto.getDesDireccion1());
		logger.trace("dirs[0].getDesDireccion1(): " + dirs[0].getDesDirec1());
		
		dirs[0].setDesDirec2(dto.getDesDireccion2());
		logger.trace("dirs[0].getDesDireccion2(): " + dirs[0].getDesDirec2());
		
		dirs[0].setCodSiglaDomicilio(dto.getCodTipoCalle());
		logger.debug("dirs[0].getCodSiglaDomicilio(): " + dirs[0].getCodSiglaDomicilio());
		
		dirs[0].setCodigoPostalDireccion(dto.getCodZIP());
		logger.debug("dirs[0].getCodigoPostalDireccion(): " + dirs[0].getCodigoPostalDireccion());
		
		dirs[0].setNombreCalle(dto.getNomCalle());
		logger.debug("dirs[0].getNombreCalle(): " + dirs[0].getNombreCalle());
		
		dirs[0].setNumeroCalle(dto.getNumCalle());
		logger.debug("dirs[0].getNumeroCalle(): " + dirs[0].getNumeroCalle());
		
		dirs[0].setObservacionDireccion(dto.getObsDireccion());
		logger.debug("dirs[0].getObservacionDireccion(): " + dirs[0].getObservacionDireccion());
		
		dirs[0].setReplicada(false);

		dirs[1] = new DireccionNegocioWebDTO();
		dirs[1].setTipo(Integer.valueOf(config.getString("codigo.tipo.dir.personal").trim()).intValue());
		logger.debug("dirs[1].getTipo(): " + dirs[1].getTipo());
		dirs[1].setReplicada(true);

		dirs[2] = new DireccionNegocioWebDTO();
		dirs[2].setTipo(Integer.valueOf(config.getString("codigo.tipo.dir.correspondencia").trim()).intValue());
		logger.debug("dirs[2].getTipo(): " + dirs[2].getTipo());
		dirs[2].setReplicada(true);
		clienteDTO.setDirecciones(dirs);

		DatosGeneralesVentaDTO lineaDTO = new DatosGeneralesVentaDTO();
		
		lineaDTO.setCodigoCelda(dto.getCodCelda());
		lineaDTO.setCodigoCentral(dto.getCodCentral());
		lineaDTO.setCodigoCreditoMorosidad(config.getString("linea.por.defecto.cod_credmor"));
		lineaDTO.setCodigoCreditoConsumo(config.getString("linea.por.defecto.cod_crencon"));
		lineaDTO.setCodigoEstado(config.getString("linea.por.defecto.cod_estado"));
		lineaDTO.setCodigoGrupoServicio(config.getString("linea.por.defecto.cod_grpserv"));
		lineaDTO.setCodigoPlanIndemnizacion(config.getString("linea.por.defecto.cod_indemnizacion"));
		
		
		lineaDTO.setCodigoModalidadVenta(config.getString("linea.por.defecto.cod_modventa"));
		lineaDTO.setCodPlanServ(config.getString("linea.por.defecto.cod_planserv"));
		
		lineaDTO.setCodTipPrestacion(config.getString("cod_prestacion.carrier")); 
		logger.debug("lineaDTO.getCodTipPrestacion(): " + lineaDTO.getCodTipPrestacion());
		lineaDTO.setCodGrupoPrestacion(config.getString("grupo.prestacion.carrier"));
		logger.debug("lineaDTO.getCodGrupoPrestacion(): " + lineaDTO.getCodGrupoPrestacion());
		lineaDTO.setCodigoTecnologia(config.getString("linea.por.defecto.cod_tecnologia"));
		logger.debug("lineaDTO.getCodigoTecnologia(): " + lineaDTO.getCodigoTecnologia());
		lineaDTO.setCodigoTipoContrato(config.getString("linea.por.defecto.cod_tipcontrato"));
		
		lineaDTO.setCodUso(new Integer(config.getString("cod_uso.carrier")).intValue());
		logger.trace("lineaDTO.getCodUso(): " + lineaDTO.getCodUso());
		
		lineaDTO.setIndicadorComodato(config.getString("linea.por.defecto.ind_eqprestado")); 
		lineaDTO.setIndicadorFacturable(config.getString("linea.por.defecto.ind_factur"));
		lineaDTO.setIndTelefono(new Long(config.getString("linea.por.defecto.ind_telefono")));
		lineaDTO.setNombreUsuarioOracle(dto.getNomUsuarioOra());
		lineaDTO.setNumeroSerieTerminal(config.getString("linea.por.defecto.num_serie"));
		lineaDTO.setTipoTerminal(config.getString("linea.por.defecto.tip_terminal"));
		lineaDTO.setNumeroCelular(dto.getNumCelularExterno());
		lineaDTO.setCodigoRegion(oficinaDTO.getCodigoRegion());
		lineaDTO.setCodigoProvincia(oficinaDTO.getCodigoProvincia());
		lineaDTO.setCodigoCiudad(oficinaDTO.getCodigoCiudad());
		lineaDTO.setCodigoVendedor(new Long(dto.getCodVendedor()).toString());
		lineaDTO.setCodigoVendedorDealer("0");		
		lineaDTO.setCodigoVendedor(new Long(dto.getCodVendedor()).toString());
		lineaDTO.setCodigoVendedorRaiz(lineaDTO.getCodigoVendedor());
		lineaDTO.setNumMesesContrato(new Long(config.getString("linea.por.defecto.num_mesescontrato")));
		lineaDTO.setCodTipoCliente(dto.getCodTipoCliente().trim());
		lineaDTO.setCodigoPlanTarifario(dto.getCodigoPlanTarifario());
		logger.trace("lineaDTO.getCodigoPlanTarifario(): " + lineaDTO.getCodigoPlanTarifario());
		
		String fechaActual = Formatting.dateTime(new Date(), "dd/MM/yyyy HH:mm:ss");
		lineaDTO.setFechaActual(fechaActual);

		FacturaDTO datosCicloFacturacion = altaClienteFacade.getDatosCicloFacturacion();
		String codigoCiclo = datosCicloFacturacion.getCodigoCiclo();
		logger.debug("codigoCiclo: " + codigoCiclo);
		clienteDTO.setCodigoCicloFacturacion(codigoCiclo);
		clienteDTO.setCodigoCategCambio(config.getString("cliente.por.defecto.cod.categoria.cambio"));
		ClienteAltaDTO clienteAltaDTO = altaClienteFacade.crearCliente(clienteDTO);
		String codigoCliente = clienteAltaDTO.getCodigoCliente();
		logger.debug("codigoCliente: " + codigoCliente);
		
		//Incidencia 132694. JIB (02/10/2010)
		//Limite de Consumo no aplica para pasillo LDI
		lineaDTO.setCodLimiteConsumo(null);
		
		//Incidencia 145797. JIB (16/09/2010)
		//Límite de Consumo ahora si aplica. Req. Adicional
		PlanTarifarioComDTO planTarifarioComDTO = new PlanTarifarioComDTO();
		planTarifarioComDTO.setCodigoCliente(codigoCliente);
		planTarifarioComDTO.setCodigoPlanTarifario(dto.getCodigoPlanTarifario());
		logger.debug("planTarifarioComDTO.getCodigoCliente() [" + planTarifarioComDTO.getCodigoCliente() + "]");
		logger.debug("planTarifarioComDTO.getCodigoPlanTarifario() [" + planTarifarioComDTO.getCodigoPlanTarifario() + "]");
		
		String codLimiteConsumo = null;
		double impLimiteConsumo = 0;
		
		final PlanTarifarioComDTO[] limitesConsumo = altaClienteFacade.getLimitesConsumo(planTarifarioComDTO);
		logger.debug("limitesConsumo.length [" + limitesConsumo.length + "]");
		for (int i = 0; i < limitesConsumo.length; i++) {
			logger.debug("limitesConsumo[i].getIndicadorDefault() [" + limitesConsumo[i].getIndicadorDefault() + "]");
			if (limitesConsumo[i].getIndicadorDefault().equals("S")) {
				// codLimiteConsumo viene del PL concatenado con "-" y rownum. Se quitan.
				codLimiteConsumo = limitesConsumo[i].getCodigoLimiteConsumo();
				codLimiteConsumo = codLimiteConsumo.split("-")[0];
				impLimiteConsumo = limitesConsumo[i].getMontoCons();
				break;
			}
		}
		
		lineaDTO.setCodLimiteConsumo(codLimiteConsumo);
		lineaDTO.setImpLimiteConsumo(impLimiteConsumo);
		logger.debug("lineaDTO.getCodLimiteConsumo() [" + lineaDTO.getCodLimiteConsumo() + "]");
		logger.debug("lineaDTO.getImpLimiteConsumo() [" + lineaDTO.getImpLimiteConsumo() + "]");
		
		lineaDTO.setCodigoCliente(codigoCliente);
		Integer c = new Integer(codigoCiclo);
		lineaDTO.setCod_ciclo(c.intValue());
		lineaDTO.setIdentificadorEmpresa(config.getString("identificador.empresa"));
		lineaDTO.setNumeroPerContrato(config.getString("numero.per.contrato"));
		UsuarioWebDTO usuarioWebDTO = new UsuarioWebDTO();
		usuarioWebDTO.setNomUsuario(clienteDTO.getNombreCliente());
		usuarioWebDTO.setDirecciones(clienteDTO.getDirecciones());
		usuarioWebDTO.setNomApell1(clienteDTO.getNombreApellido1());
		usuarioWebDTO.setNomApell2(clienteDTO.getNombreApellido2());
		usuarioWebDTO.setNumTelefono(clienteDTO.getNumeroCelular());
		usuarioWebDTO.setNumIdent(clienteDTO.getNumeroIdentificacion());
		usuarioWebDTO.setTipIdent(clienteDTO.getCodigoTipoIdentificacion());
		RegistroVentaDTO registroVta = ventasFacade.getSecuenciaVenta();
		String numeroVenta = new Long(registroVta.getNumeroVenta()).toString();
		logger.debug("numeroVenta: " + numeroVenta);
		lineaDTO.setNumeroVenta(numeroVenta);
		
		//Obtiene valores del contrato
		ContratosDTO contrato = new ContratosDTO();
		contrato.setCodigoTipoContrato(config.getString("linea.por.defecto.cod_tipcontrato"));
		contrato = getTipoContrato(contrato);
		ContratosDTO nuevoContrato = obtenerContratoNuevo();
		if (nuevoContrato != null) {
			contrato.setNumeroContrato(nuevoContrato.getNumeroContrato());
		}		
		String numAnexo = null;			
		numAnexo = contrato.getNumeroContrato().substring(0, (contrato.getNumeroContrato().length()-1));
		numAnexo = numAnexo + String.valueOf(1);
		lineaDTO.setNumeroContrato(contrato.getNumeroContrato());
		lineaDTO.setNumAnexo(numAnexo);
		DatosGeneralesVentaDTO datosGenerales = ventasFacade.crearLineaWeb(lineaDTO, usuarioWebDTO);
		SolicitudVentaDTO solicitudVentaDTO = new SolicitudVentaDTO();
		solicitudVentaDTO.setNumVenta(new Long(numeroVenta).longValue());
		solicitudVentaDTO.setTipoSolicitud("2"); 
		solicitudVentaDTO.setNomUsuarora(dto.getNomUsuarioOra());
		try {
			getVentasFacade().guardarSolicitudVenta(solicitudVentaDTO);
		}
		catch (GeneralException e) {
			throw new VentasException(e);
		}
		CabeceraArchivoDTO cabeceraDTO = new CabeceraArchivoDTO();
		cabeceraDTO.setNumeroVenta(new Long(numeroVenta).longValue());
		cabeceraDTO.setCodigoOperadora(dto.getCodOperadora().trim());
		cabeceraDTO.setCodigoCliente(codigoCliente);
		cabeceraDTO.setCodigoCicloCliente(new Integer(codigoCiclo).intValue());
		cabeceraDTO.setNumeroIdentificacion(clienteDTO.getNumeroIdentificacion());
		cabeceraDTO.setCategoriaTributaria(clienteDTO.getCategoriaTributaria());
		cabeceraDTO.setClasificacionCreditica(clienteDTO.getCodCrediticia());
		cabeceraDTO.setCodigoTipoCliente(dto.getCodTipoCliente());
		cabeceraDTO.setCodigoTipoIdentificacion(clienteDTO.getCodigoTipoIdentificacion());
		cabeceraDTO.setCodigoVendedor(new Integer(clienteDTO.getCodigoVendedor()).toString());		
		cabeceraDTO.setNombreCliente(clienteDTO.getNombreCliente());
		cabeceraDTO.setNombreApellido1Cliente(clienteDTO.getNombreApellido1());
		cabeceraDTO.setNombreApellido2Cliente(clienteDTO.getNombreApellido2());
		cabeceraDTO.setCodTipoSolicitud(solicitudVentaDTO.getTipoSolicitud());
		
		//Obtiene Transaccion de venta
		RegistroVentaDTO registroTransVta = ventasFacade.getSecuenciaTransacabo();
		String transVta = new Long(registroTransVta.getNumeroTransaccionVenta()).toString();
		logger.debug("numeroTransaccionVenta: " + transVta);		
		
		AltaLineaWebDTO altaLineaWebDTO = new AltaLineaWebDTO();
		altaLineaWebDTO.setImpLimiteConsumo(impLimiteConsumo);
		altaLineaWebDTO.setCodLimiteConsumo(codLimiteConsumo);
		
		logger.debug("altaLineaWebDTO.getCodLimiteConsumo() [" + altaLineaWebDTO.getCodLimiteConsumo() + "]");
		logger.debug("altaLineaWebDTO.getImpLimiteConsumo() [" + altaLineaWebDTO.getImpLimiteConsumo() + "]");
		
		altaLineaWebDTO.setCodDistribuidor(new Long(dto.getCodVendedor()).toString());
		altaLineaWebDTO.setCodCliente(codigoCliente);
		// Incidencia 132694. Plan Tarifario viene desde pantalla
		altaLineaWebDTO.setCodPlanTarif(dto.getCodigoPlanTarifario());
		logger.trace("alta.getCodPlanTarif(): " +  altaLineaWebDTO.getCodPlanTarif());
		altaLineaWebDTO.setNumSerie("");
		altaLineaWebDTO.setNumEquipo(config.getString("linea.por.defecto.num_serie"));
		altaLineaWebDTO.setNombreUsuarOra(dto.getNomUsuarioOra());
		altaLineaWebDTO.setCodTipoCliente(dto.getCodTipoCliente().trim());
		altaLineaWebDTO.setIndOfiter(config.getString("venta.oficina"));
		altaLineaWebDTO.setCodActabo(config.getString("codigo.actuacion.ventaoficina"));
		altaLineaWebDTO.setCodModalidadVenta(config.getString("linea.por.defecto.cod_modventa"));
		altaLineaWebDTO.setCodCuotas(""); //No hay cuotas se vende al contado
		altaLineaWebDTO.setCodTipoComisionista(dto.getCodTipComis()); 
		altaLineaWebDTO.setCodTipoContrato(config.getString("linea.por.defecto.cod_tipcontrato"));
		altaLineaWebDTO.setNumeroVenta(new Long(numeroVenta).longValue());
		altaLineaWebDTO.setNumeroTransaccionVenta(Long.valueOf(transVta).longValue());
		altaLineaWebDTO.setCodGrpPrestacion(config.getString("grupo.prestacion.carrier"));
		altaLineaWebDTO.setCodTipoSolicitud(config.getString("cod_prestacion.carrier"));
		
		altaVentaWeb(altaLineaWebDTO);
		
		//Acepta presupuesto
		GaVentasDTO entrada = new GaVentasDTO();
		entrada.setNumVenta(Long.valueOf(numeroVenta));
		entrada.setNomUsuarora(dto.getNomUsuarioOra());
		entrada.setImpVenta(new Float(0));
		entrada.setIndOfiter(config.getString("venta.oficina"));
		ventasFacade.aceptarPresupuesto(entrada);
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(datosGenerales.getNum_abonado().longValue());
		abonado.setCodSituacion(config.getString("codigo.situacion.abonado.final"));
		try {
			ventasFacade.updCodigoSituacionAbo(abonado);
		}
		catch (GeneralException e) {
			throw new VentasException(e);
		}
		logger.info("Fin");
		r.setCodCliente(codigoCliente);
		r.setNumVenta(numeroVenta);
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public long getSecuencia(String nombreSecuencia) throws GeneralException
	{
		logger.debug("Inicio: getSecuencia()");
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(nombreSecuencia);
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
		logger.debug("Fin: getSecuencia()");
		return datosGrales.getSecuencia();
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->	
	 * @throws GeneralException 
	 * @throws  
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String descripcionArticulo(String codArticulo) throws CustomerDomainException {
		logger.debug("Inicio: descripcionArticulo()");
		String resultado = datosGeneralesBO.descripcionArticulo(codArticulo);
		logger.debug("Fin: descripcionArticulo()");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 18-10-2011
}
