package com.tmmas.cl.scl.portalventas.web.delegate;

import java.io.File;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.ejb.CreateException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.Logger;

import scorecliente.ScoreCliente;
import sujetos.ResultadoFisico;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.activacionmasiva.soa.ejb.session.ActivacionMasivaORQ;
import com.tmmas.cl.scl.activacionmasiva.soa.ejb.session.ActivacionMasivaORQHome;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ActivacionLineaOutDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoCOLDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.RegCargosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ResultadoAltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.SolicitudAutorizacionDescuentoDTO;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTL;
import com.tmmas.cl.scl.altacliente.negocio.ejb.session.AltaClienteFacadeSTLHome;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanTarifarioComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleCargosSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleLineaSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetallePrecioSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DetalleInformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.InformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoCargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasListOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DominioScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ReporteScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MenuUsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.direccion.negocio.ejb.session.DireccionFacadeSTL;
import com.tmmas.cl.scl.direccion.negocio.ejb.session.DireccionFacadeSTLHome;
import com.tmmas.cl.scl.direccioncommon.commonapp.exception.DireccionException;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.ScoringHelper;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EquipoKitDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NivelPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroInternetDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroPilotoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularRangoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.UsoDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTL;
import com.tmmas.cl.scl.ventas.negocio.ejb.session.VentasFacadeSTLHome;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacade;
import com.tmmas.scl.operations.crm.bean.ejb.session.CusRelManFacadeHome;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;

import consultas.Consulta;

public class PortalVentasDelegate {

	private static PortalVentasDelegate instance = null;

	private static Logger logger = Logger.getLogger(PortalVentasDelegate.class);

	public static PortalVentasDelegate getInstance() {
		if (instance == null) {
			instance = new PortalVentasDelegate();
		}
		return instance;
	}
	
	protected ServiceLocator svcLocator = ServiceLocator.getInstance();

	private Global global = Global.getInstance();
	
	private AltaClienteFacadeSTL getAltaClienteFacade()
	throws AltaClienteException {

		logger.debug("getAltaClienteFacade():start");
		
		String jndi = global.getValorExterno("jndi.AltaClienteFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValorExterno("url.AltaClienteFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");

		String initialContextFactory =  global.getValorExterno("initial.context.factory").trim();
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		
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
		
		AltaClienteFacadeSTLHome facadeHome = (AltaClienteFacadeSTLHome) PortableRemoteObject.narrow(obj, AltaClienteFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de AltaClienteFacadeSTL...");
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
		logger.debug("getAltaClienteFacade():end");
		return facade;
	}
	
	private VentasFacadeSTL getVentasFacade()
	throws VentasException {

		logger.debug("getVentasFacade():start");
		String jndi = global.getValorExterno("jndi.VentasFacadeSTLFacade");
		logger.debug("Buscando servicio [" + jndi + "]");
		String url = global.getValorExterno("url.VentasFacadeSTLProvider");
		logger.debug("Url provider [" + url + "]");

		String initialContextFactory =  global.getValorExterno("initial.context.factory").trim();
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		
		Context context = null;
		try {
			//logger.debug("Inicializando contexto:antes");
			context = new InitialContext(env);
			//logger.debug("Inicializando contexto:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		Object obj = null;
		try {
			//logger.debug("Buscando jndi:antes");
			obj = context.lookup(jndi);
			//logger.debug("Buscando jndi:despues");
		} catch (NamingException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("NamingException[" + loge + "]");
		}
		
		VentasFacadeSTLHome facadeHome = (VentasFacadeSTLHome) PortableRemoteObject.narrow(obj, VentasFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de VentasFacadeSTL...");
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
		logger.debug("getVentasFacade():end");
		return facade;
	}
	
	private DireccionFacadeSTL getDireccionFacade()
	throws DireccionException {

		logger.debug("getDireccionFacade():start");
		
		String jndi = global.getValorExterno("jndi.DireccionFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValorExterno("url.DireccionFacadeSTLProvider");
		logger.debug("Url provider[" + url + "]");

		String initialContextFactory =  global.getValorExterno("initial.context.factory").trim();
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		
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
		
		DireccionFacadeSTLHome facadeHome = (DireccionFacadeSTLHome) PortableRemoteObject.narrow(obj, DireccionFacadeSTLHome.class);	
		
		logger.debug("Recuperada interfaz home de DireccionFacadeSTL...");
		DireccionFacadeSTL facade = null;
		try {
			facade = facadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + loge + "]");
			throw new DireccionException(e);
			
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + loge + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDireccionFacade():end");
		return facade;
	}
	
	 private CusRelManFacade getCusRelManFacade() throws VentasException 
	{
			logger.debug("getCusRelManFacade():start");
			String jndi = global.getValorExterno("jndi.CusRelManFacade");
			logger.debug("Buscando servicio[" + jndi + "]");
			String url = global.getValorExterno("url.CusRelManEJBProvider");
			logger.debug("Url provider[" + url + "]");

			String initialContextFactory =  global.getValorExterno("initial.context.factory").trim();
			
			Hashtable env = new Hashtable();
			env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
			env.put(Context.PROVIDER_URL, url);
			
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
			
			CusRelManFacadeHome facadeHome = (CusRelManFacadeHome) PortableRemoteObject.narrow(obj, CusRelManFacadeHome.class);	
			
			logger.debug("Recuperada interfaz home de CusRelManFacade...");
			CusRelManFacade facade = null;
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
			logger.debug("getCusRelManFacade():end");
			return facade;
	}
	 
	public OficinaComDTO[] getOficinas(OficinaComDTO oficinaComDTO) throws AltaClienteException, RemoteException {
		logger.debug("getOficinas():start");
		OficinaComDTO[] retorno = null;
		try {
			retorno = getAltaClienteFacade().getOficinas(oficinaComDTO);			
		} catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getOficinas():end");
		return retorno;
	}
	
	public VendedorDTO[] getListTiposComisionistas()throws VentasException, RemoteException{
		logger.debug("getListTiposComisionistas():start");
		VendedorDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListTiposComisionistas();			
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListTiposComisionistas():end");
		return retorno;
	}
	
	public  VendedorDTO[] getListadoVendedores(VendedorDTO vendedorDTO)	throws VentasException, RemoteException{
		logger.debug("getListadoVendedores():start");
		VendedorDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoVendedores(vendedorDTO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedores():end");
		return retorno;
	}	
	
	public  VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedorDTO) throws VentasException, RemoteException{
		logger.debug("getListadoVendedoresDealer():start");
		VendedorDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoVendedoresDealer(vendedorDTO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedoresDealer():end");
		return retorno;
	}	
	
	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato) throws VentasException, RemoteException{
		logger.debug("getListadoTipoContrato():start");
		ContratoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoTipoContrato(contrato);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoTipoContrato():end");
		return retorno;
	}
	
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws VentasException, RemoteException{
		logger.debug("getListadoNumeroMesesContrato():start");
		ContratoDTO retorno = null;
		try {
			retorno = getVentasFacade().getListadoNumeroMesesContrato(contrato);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoNumeroMesesContrato():end");
		return retorno;
	}	
	
	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad) throws VentasException, RemoteException{
		logger.debug("getListadoModalidadPago():start");
		ModalidadPagoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoModalidadPago(modalidad);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoModalidadPago():end");
		return retorno;
	}	
	
	public DatosGeneralesDTO[] getListCodigo(DatosGeneralesDTO datosGenerales)	throws AltaClienteException, RemoteException {
		logger.debug("getListCodigo():start");
		DatosGeneralesDTO[] tiposCliente = null;
		logger.debug("CodigoModulo="+datosGenerales.getCodigoModulo());
		logger.debug("Tabla="+datosGenerales.getTabla());
		logger.debug("Columna="+datosGenerales.getColumna());
		
		try {
			tiposCliente = getAltaClienteFacade().getListCodigo(datosGenerales);
		} catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getListCodigo():end");
		return tiposCliente;
	}
	
	public ClienteDTO[] getDatosCliente(BusquedaClienteDTO cliente) throws VentasException {
		logger.debug("getDatosCliente():start");
		ClienteDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getDatosCliente(cliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosCliente():end");
		return retorno;
	}
	
	public IdentificadorCivilComDTO[] getTipoIdentificadoresCiviles() throws AltaClienteException, RemoteException {
		logger.debug("getTipoIdentificadoresCiviles():start");
		IdentificadorCivilComDTO[] identificadorCivilComDTO = null;
		try {
			identificadorCivilComDTO = getAltaClienteFacade().getTipoIdentificadoresCiviles();
		} catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getTipoIdentificadoresCiviles():end");
		return identificadorCivilComDTO;
	}	
	
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada)
	throws AltaClienteException, RemoteException {
		logger.debug("validarIdentificador():start");
		NumeroIdentificacionDTO numeroIdentificacionDTO = null;
		try {
			logger.debug("validarIdentificador:antes");
			numeroIdentificacionDTO = getAltaClienteFacade().validarIdentificador(entrada);
			logger.debug("validarIdentificador:despues");
		} catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("validarIdentificador():end");
		return numeroIdentificacionDTO;
		
	}
	
	public GrupoPrestacionDTO[] getGruposPrestacion() throws VentasException, RemoteException{
		logger.debug("getGruposPrestacion():start");
		GrupoPrestacionDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getGruposPrestacion();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getGruposPrestacion():end");
		return retorno;
	}

	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion,String CodTipoCliente) 
		throws VentasException, RemoteException
	{
		logger.debug("getTiposPrestacion():start");
		TipoPrestacionDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getTiposPrestacion(codGrupoPrestacion, CodTipoCliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getTiposPrestacion():end");
		return retorno;
	}
	
	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO)
		throws DireccionException, RemoteException 
	{
		logger.debug("getDatosDireccion():start");
		DireccionDTO direccionDTO2 = null;
		try {
			logger.debug("getDatosDireccion:antes");
			direccionDTO2 = getDireccionFacade().getDatosDireccion(direccionDTO);
			logger.debug("getDatosDireccion:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDatosDireccion():end");
		return direccionDTO2;
	}
	
	public ProvinciaDireccionDTO getProvincias(ProvinciaDireccionDTO provinciaDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getProvincias():start");
		ProvinciaDireccionDTO provinciaDireccionDTO2 = null;
		try {
			logger.debug("getProvincias:antes");
			provinciaDireccionDTO2 = getDireccionFacade().getProvincias(provinciaDireccionDTO);
			logger.debug("getProvincias:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getProvincias():end");
		return provinciaDireccionDTO2;
	}
	public CiudadDireccionDTO getCiudades(CiudadDireccionDTO ciudadDireccionDTO)
	throws DireccionException, RemoteException {
		logger.debug("getCiudades():start");
		CiudadDireccionDTO ciudadDireccionDTO2 = null;
		try {
			logger.debug("getCiudades:antes");
			ciudadDireccionDTO2 = getDireccionFacade().getCiudades(ciudadDireccionDTO);
			logger.debug("getCiudades:despues");
		} catch (DireccionException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("DireccionException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getCiudades():end");
		return ciudadDireccionDTO2;
	}

	public CeldaDTO[] getListadoCeldas(CiudadDTO ciudad) throws VentasException, RemoteException{
		logger.debug("getListadoCeldas():start");
		CeldaDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoCeldas(ciudad);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCeldas():end");
		return retorno;
	}
	
	public CentralDTO[] getListadoCentrales(CeldaDTO celda) throws VentasException, RemoteException{
		logger.debug("getListadoCentrales():start");
		CentralDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoCentrales(celda);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCentrales():end");
		return retorno;
	}	
	
	public CreditoConsumoDTO[] getListadoCreditoConsumo(CreditoConsumoDTO credito) throws VentasException, RemoteException{
		logger.debug("getListadoCreditoConsumo():start");
		CreditoConsumoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoCreditoConsumo(credito);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCreditoConsumo():end");
		return retorno;
	}
	
	public GrupoCobroServicioDTO[] getListadoGrupoCobroServicio() throws VentasException, RemoteException{
		logger.debug("getListadoGrupoCobroServicio():start");
		GrupoCobroServicioDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoGrupoCobroServicio();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoGrupoCobroServicio():end");
		return retorno;
	}	
	
	public CampanaVigenteDTO[] getListadoCampanasVigentes() throws VentasException, RemoteException{
		logger.debug("getListadoCampanasVigentes():start");
		CampanaVigenteDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoCampanasVigentes();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCampanasVigentes():end");
		return retorno;
	}	

	public PlanServicioDTO[] getListadoPlanServicio(PlanServicioDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoPlanServicio():start");
		PlanServicioDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoPlanServicio(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoPlanServicio():end");
		return retorno;
	}
	
	public UsoDTO[] getUsos(UsoDTO entrada) throws VentasException, RemoteException{
		logger.debug("getUsos():start");
		UsoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getUsos(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getUsos():end");
		return retorno;
	}
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarif(LstPTaPlanTarifarioInDTO entrada) throws VentasException, RemoteException{
		logger.debug("lstPlanTarif():start");
		LstPTaPlanTarifarioListOutDTO retorno = null;
		try {
			retorno = getVentasFacade().lstPlanTarif(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("lstPlanTarif():end");
		return retorno;
	}	
	
	public PlanTarifarioComDTO[] getLimitesConsumo(PlanTarifarioComDTO entrada)
	throws AltaClienteException, RemoteException {
		logger.debug("getLimitesConsumo():start");
		PlanTarifarioComDTO[] retorno = null;
		try {
			retorno = getAltaClienteFacade().getLimitesConsumo(entrada);
		} catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("AltaClienteException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new AltaClienteException(e);
		}
		logger.debug("getLimitesConsumo():end");
		return retorno;
		
	}
	
	public TipoTerminalDTO[] listarTiposTerminal(String codTecnologia) throws VentasException, RemoteException{
		logger.debug("listarTiposTerminal():start");
		TipoTerminalDTO[] retorno = null;
		try {
			retorno = getVentasFacade().listarTiposTerminal(codTecnologia);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarTiposTerminal():end");
		return retorno;
	}
	
	public CausalDescuentoDTO[] getListadoCausalDescuento(Long codUso) 
		throws VentasException, RemoteException
	{
		logger.debug("getListadoCausalDescuento():start");
		CausalDescuentoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoCausalDescuento(codUso);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCausalDescuento():end");
		return retorno;
	}	
	
	public SeguroDTO[] getSeguros() throws VentasException, RemoteException{
		logger.debug("getSeguros():start");
		SeguroDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getSeguros();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSeguros():end");
		return retorno;
	}
	
	public SerieDTO[] buscarSerie(SerieDTO entrada) throws VentasException, RemoteException{
		logger.debug("buscarSerie():start");
		SerieDTO[] retorno = null;
		try {
			retorno = getVentasFacade().buscarSerie(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("buscarSerie():end");
		return retorno;
	}
	
	
	public SerieDTO[] listarSerie(SerieDTO entrada) throws VentasException, RemoteException{
		logger.debug("listarSerie():start");
		SerieDTO[] retorno = null;
		try {
			retorno = getVentasFacade().listarSerie(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarSerie():end");
		return retorno;
	}	

	
	public MonedaDTO[] listarMonedas() throws VentasException, RemoteException{
		logger.debug("listarMonedas():start");
		MonedaDTO[] retorno = null;
		try {
			retorno = getVentasFacade().listarMonedas();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarMonedas():end");
		return retorno;
	}
	
	private ActivacionMasivaORQ getOrquestadorFacade()
		throws VentasException 
	{
	
		logger.debug("getOrquestadorFacade():start");
		
		String jndi = global.getValorExterno("jndi.ActivacionMasivaORQFacade");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = global.getValorExterno("url.ActivacionMasivaORQProvider");
		logger.debug("Url provider[" + url + "]");
	
		String initialContextFactory =  global.getValorExterno("initial.context.factory").trim();
		
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);		
		env.put(Context.PROVIDER_URL, url);
		
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
		
		ActivacionMasivaORQHome facadeHome = (ActivacionMasivaORQHome) PortableRemoteObject.narrow(obj, ActivacionMasivaORQHome.class);	
		
		logger.debug("Recuperada interfaz home de getOrquestadorFacade...");
		ActivacionMasivaORQ facade = null;
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
		logger.debug("getOrquestadorFacade():end");
		return facade;
	}
	
	public ActivacionLineaOutDTO altaLineaWeb(AltaLineaWebDTO actLinea)
		throws VentasException, RemoteException
	{
		logger.debug("altaLineaWeb():start");
		ActivacionLineaOutDTO retorno = null;
		try {
			logger.debug("actLinea.getCodRegion() [" + actLinea.getCodRegion() + "]");
			logger.debug("actLinea.getCodProvincia() [" + actLinea.getCodProvincia() + "]");
			retorno = getOrquestadorFacade().altaLineaWeb(actLinea);
			logger.info("NumAbonado:" + retorno.getNumAbonado());
			logger.info("NumCelular:" + retorno.getNumCelular());
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
		logger.debug("altaLineaWeb():end");
		return retorno;
	}
	
	
	public BodegaDTO[] getBodegasXVendedor(BodegaDTO entrada) throws VentasException, RemoteException{
		logger.debug("getBodegasXVendedor():start");
		BodegaDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getBodegasXVendedor(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getBodegasXVendedor():end");
		return retorno;
	}	
	
	public ArticuloInDTO[] getArticulos(ArticuloInDTO entrada) throws VentasException, RemoteException{
		logger.debug("getArticulos():start");
		ArticuloInDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getArticulos(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getArticulos():end");
		return retorno;
	}	
	
	public CentralDTO[] getDatosCentral(CentralDTO entrada) throws VentasException, RemoteException{
		logger.debug("getDatosCentral():start");
		CentralDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getDatosCentral(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosCentral():end");
		return retorno;
	}	
	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReservada(DatosNumeracionDTO entrada) throws VentasException, RemoteException{
		logger.debug("obtieneNumeracionReservada():start");
		SeleccionNumeroCelularDTO[] retorno = null;
		try {
			retorno = getVentasFacade().obtieneNumeracionReservada(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionReservada():end");
		return retorno;
	}
	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO entrada) throws VentasException, RemoteException{
		logger.debug("obtieneNumeracionReutilizable():start");
		SeleccionNumeroCelularDTO[] retorno = null;
		try {
			retorno = getVentasFacade().obtieneNumeracionReutilizable(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionReutilizable():end");
		return retorno;
	}	 
	 
	public SeleccionNumeroCelularRangoDTO[] obtieneNumeracionRango(DatosNumeracionDTO entrada) throws VentasException, RemoteException{
		logger.debug("obtieneNumeracionRango():start");
		SeleccionNumeroCelularRangoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().obtieneNumeracionRango(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionRango():end");
		return retorno;
	}	
	
	public String obtieneCategoria(DatosNumeracionDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("obtieneCategoria():start");
		String retorno = null;
		try {
			retorno = getVentasFacade().obtieneCategoria(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneCategoria():end");
		return retorno;
	}
	
	public OficinaDTO getDireccionOficina(String codOficina)
		throws VentasException, RemoteException
	{
		logger.debug("getDireccionOficina():start");
	    OficinaDTO retorno = null;
		try {
			retorno = getVentasFacade().getDireccionOficina(codOficina);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDireccionOficina():end");
		return retorno;
	}
	
	public void validarPlanCompartido(Long codCliente, String codPlanTarif)
		throws VentasException, RemoteException
	{
		logger.debug("validarPlanCompartido():start");	    
		try {
			getVentasFacade().validarPlanCompartido(codCliente, codPlanTarif);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validarPlanCompartido():end");	
	}
	
	
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO entrada) throws VentasException, RemoteException{
		logger.debug("obtieneNumeracionAutomatica():start");
		DatosNumeracionDTO retorno = null;
		try {
			retorno = getVentasFacade().obtieneNumeracionAutomatica(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionAutomatica():end");
		return retorno;
	}
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws VentasException, RemoteException{
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retorno = null;
		try {
			retorno = getVentasFacade().getParametroGeneral(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getParametroGeneral():end");
		return retorno;
	}
	
	public ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO entrada) throws VentasException, RemoteException{
		logger.debug("getListadoSS():start");
		ListadoSSOutDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoSS(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoSS():end");
		return retorno;
	}
	public UsuarioSCLDTO validaUsuarioSinPerfil(UsuarioSCLDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("validaUsuarioSinPerfil():start");
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		try {
			respuesta=getVentasFacade().ValidaUsuarioSinPerfil(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaUsuarioSinPerfil():end");
		return respuesta;
	}
	
	public CabeceraArchivoDTO getParametrosVenta(CabeceraArchivoCOLDTO cabecera)
		throws VentasException, RemoteException
	{
		logger.debug("validaUsuarioSinPerfil():start");
		CabeceraArchivoDTO respuesta = new CabeceraArchivoDTO();
		try {
			respuesta=getOrquestadorFacade().getParametrosVenta(cabecera);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaUsuarioSinPerfil():end");
		return respuesta;
	}	
	
	public void bloqueaDesbloqueaVendedor(VendedorDTO vendedorDTO) throws VentasException, RemoteException {
		logger.info("bloqueaDesbloqueaVendedor(), inicio");
		logger.debug("vendedorDTO.toString() [" + vendedorDTO.toString() + "]");
		try {
			getVentasFacade().bloqueaDesbloqueaVendedor(vendedorDTO);
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (RemoteException e) {
			logger.error("RemoteException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("bloqueaDesbloqueaVendedor(), fin");
	}
	
	public NumeroCuotasListOutDTO listarCuotas() throws VentasException, RemoteException {
		logger.info("listarCuotas, start");
		NumeroCuotasListOutDTO ListCuotas = null;
		try {
			ListCuotas = getVentasFacade().Lista_Cuotas();
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("listarCuotas, end");
		return ListCuotas;
	}
	
	public ActivacionLineaOutDTO altaVentaWeb(AltaLineaWebDTO actLinea)
		throws VentasException, RemoteException
	{
		logger.debug("altaVentaWeb():start");
		ActivacionLineaOutDTO retorno = null;
		try {
			retorno = getOrquestadorFacade().altaVentaWeb(actLinea);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
		logger.debug("altaVentaWeb():end");
		return retorno;
	}	
	
	public Long getIndSeguro(Long entrada) throws VentasException, RemoteException{
		logger.debug("getIndSeguro():start");
		Long retorno = null;
		try {
			retorno = getVentasFacade().getIndSeguro(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getIndSeguro():end");
		return retorno;
	}
	
	public SeguroDTO obtieneDatosSeguro(SeguroDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("obtieneDatosSeguro():start");
		SeguroDTO retorno = new SeguroDTO();
		try {
			retorno = getVentasFacade().obtieneDatosSeguro(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneDatosSeguro():end");
		return retorno;
	}
	
	public ArticuloDTO actualizaStock(ArticuloDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("actualizaStock():start");
		ArticuloDTO retorno = null;
		try {
			retorno = getVentasFacade().actualizaStock(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("actualizaStock():end");
		return retorno;
	}
	
	
	public SimcardDTO getSimcard(SimcardDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getSimcard():start");
		SimcardDTO retorno = null;
		try {
			retorno = getVentasFacade().getSimcard(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSimcard():end");
		return retorno;
	}
	
	public TerminalDTO getTerminal(TerminalDTO entrada)
		throws VentasException, RemoteException
	{		
		logger.debug("getTerminal():start");
		TerminalDTO retorno = null;
		try {
			retorno = getVentasFacade().getTerminal(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getTerminal():end");
		return retorno;
	}
	public ResultadoValidacionVentaDTO validacionLineaWeb(ParametrosValidacionVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.info("validacionLineaWeb():start");
		ResultadoValidacionVentaDTO retorno = new ResultadoValidacionVentaDTO();
		try {
			retorno = getVentasFacade().validacionLineaWeb(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("validacionLineaWeb():end");
		return retorno;
	}
		
	public boolean verificaEstadoVendedor(VendedorDTO entrada) throws VentasException {
		logger.debug("VerificaEstadoVendedor():start");
		try {
			getVentasFacade().validaCodigoVendedor(entrada);
		}
		catch (VentasException e) {
			logger.debug("VentasException[" + StackTraceUtl.getStackTrace(e) + "]");
			return false;
		}
		catch (RemoteException e) {
			logger.debug("RemoteException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("VerificaEstadoVendedor():end");
		return true;
	}
		
	public FolioDTO getFolio(FolioDTO entrada)
		throws VentasException, RemoteException
	{
			logger.debug("getFolio():start");
			FolioDTO retorno = null;
			try {
				retorno = getVentasFacade().getFolio(entrada);
			} catch (VentasException e) {
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("VentasException[" + log + "]");
				throw e;
			} catch (RemoteException e) {
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("RemoteException[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("getFolio():end");
			return retorno;
	}
	
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("reservaNumeroCelular():start");			
		try {
			getVentasFacade().reservaNumeroCelular(numeracionCelularVO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reservaNumeroCelular():end");			
	}
		
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("insertarNumeroCelularReservado():start");			
		try {
			getVentasFacade().insertarNumeroCelularReservado(numeracionCelularVO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertarNumeroCelularReservado():end");			
	}
		
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("reponerNumeracion():start");			
		try {
			getVentasFacade().reponerNumeracion(numeracionCelularVO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reponerNumeracion():end");			
	}
		
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("desReservaNumeroCelular():start");		
		try {
			getVentasFacade().desReservaNumeroCelular(numeracionCelularVO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("desReservaNumeroCelular():end");		
	}
	
	public RegistroVentaDTO getSecuenciaTransacabo()
		throws VentasException, RemoteException
	{
		logger.debug("getSecuenciaTransacabo():start");		
		RegistroVentaDTO retorno = new RegistroVentaDTO();
		try {
			retorno = getVentasFacade().getSecuenciaTransacabo();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSecuenciaTransacabo():end");
		return retorno;
	}//getSecuenciaTransacabo
	
	public void validaNumeroInternet(NumeroInternetDTO numeroInternetDTO)
		throws VentasException, RemoteException
	{
		logger.debug("validaNumeroInternet():start");		
		try {
			getVentasFacade().validaNumeroInternet(numeroInternetDTO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaNumeroInternet():end");
	}//validaNumeroInternet
	
	public EquipoKitDTO getSerieEquipoKit(EquipoKitDTO equipoKitDTO)
		throws VentasException, RemoteException
	{
		logger.debug("getSerieEquipoKit():start");	
		EquipoKitDTO retorno = new EquipoKitDTO();
		try {
			retorno = getVentasFacade().getSerieEquipoKit(equipoKitDTO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSerieEquipoKit():end");
		return retorno;
	}//getSerieEquipoKit
	
	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getVentasXVendedor():start");	
		ListadoVentasDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getVentasXVendedor(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getVentasXVendedor():end");
		return retorno;
	}//getVentasXVendedor
	
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedor)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoVendedoresXOficina():start");	
		VendedorDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoVendedoresXOficina(vendedor);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedoresXOficina():end");
		return retorno;
	}//getListadoVendedoresXOficina
	
	public String getCodigoOperadora()
		throws VentasException, RemoteException
	{
		logger.debug("getCodigoOperadora():start");	
		String retorno = null;
		try {
			retorno = getVentasFacade().getCodigoOperadora();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCodigoOperadora():end");
		return retorno;
	}
	
	public AbonadoDTO[] getListadoAbonadosVenta(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoAbonadosVenta():start");	
		AbonadoDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getListadoAbonadosVenta(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoAbonadosVenta():end");
		return retorno;
	}//getListadoAbonadosVenta
	
	
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor)
		throws VentasException, RemoteException
	{
		logger.debug("getRangoDescuento():start");	
		VendedorDTO retorno = null;
		try {
			retorno = getVentasFacade().getRangoDescuento(vendedor);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getRangoDescuento():end");
		return retorno;
	}//getRangoDescuento
	
	public void eliminaAbonado(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("eliminaAbonado():start");
		try {
			getVentasFacade().eliminaAbonado(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("eliminaAbonado():end");		
	}//eliminaAbonado
	
	public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada)
		throws VentasException, RemoteException, GeneralException
	{
		logger.debug("getCargosVta():start");
		CargoSolicitudDTO[] resultado = null;
		try {
			resultado = getOrquestadorFacade().getCargosVta(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCargosVta():end");
		return resultado;
	}//getCargosVta
	
	public SolicitudAutorizacionDescuentoDTO solicitarAprobaciones(RegCargosDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("solicitarAprobaciones():start");
		SolicitudAutorizacionDescuentoDTO retorno = null;
		try {
			retorno = getOrquestadorFacade().solicitarAprobaciones(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
		logger.debug("solicitarAprobaciones():end");
		return retorno;
	}
	
	public InformePresupuestoDTO obtenerInformePresupuesto(InformePresupuestoDTO entrada)
	throws VentasException, RemoteException
	{
		logger.debug("obtenerInformePresupuesto():start");	
		InformePresupuestoDTO retorno = null;
		try {
			retorno = getVentasFacade().obtenerInformePresupuesto(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerInformePresupuesto():end");
		return retorno;
	}
	
	public SolicitudAutorizacionDescuentoDTO consultaEstadoSolicitud(SolicitudAutorizacionDescuentoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("consultaEstadoSolicitud():start");
		SolicitudAutorizacionDescuentoDTO retorno = null;
		try {
			retorno = getOrquestadorFacade().consultaEstadoSolicitud(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
		logger.debug("consultaEstadoSolicitud():end");
		return retorno;
	}
	
	public ImpuestosDTO actualizarDsctosManuales(ListadoCargoSolicitudDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("actualizarDsctosManuales():start");
		ImpuestosDTO resultado = new ImpuestosDTO();
		try {
			resultado = getVentasFacade().actualizarDsctosManuales(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("actualizarDsctosManuales():end");		
		return resultado;
	}
	
	
	public ResultadoValidacionVentaDTO validaSeriesExternas(ParametrosValidacionVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("validaSeriesExternas():start");		
		ResultadoValidacionVentaDTO resultado= new ResultadoValidacionVentaDTO();
		try {
			resultado=getVentasFacade().validaSerieExterna(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaSeriesExternas():end");
		return resultado;
	}
	
	public void aceptarPresupuesto(GaVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("aceptarPresupuesto():start");		
		try {
			getVentasFacade().aceptarPresupuesto(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("aceptarPresupuesto():end");
	}
	
	public void desbloqueoLinea(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("desbloqueoLinea():start");		
		try {
			getVentasFacade().desbloqueoLinea(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("desbloqueoLinea():end");
	}
	
	public void reversaVenta(GaVentasDTO entrada)	
		throws VentasException, RemoteException
	{
		logger.debug("reversaVenta():start");		
		try {
			getVentasFacade().reversaVenta(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reversaVenta():end");
	}
	
	public UsuarioSCLDTO getMenuUsuario(UsuarioSCLDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getMenuUsuario():start");		
		UsuarioSCLDTO resultado= new UsuarioSCLDTO();
		try {
			resultado=getVentasFacade().getMenuUsuario(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getMenuUsuario():end");
		return resultado;
	}
	
	public void registrarCargosInstalacion(RegistroCargosDTO cargosInstalacionDTO)
		throws GeneralException,RemoteException
	{		
		logger.debug("registrarCargosInstalacion():start");		
		try {
			ParametrosGeneralesDTO parametrosGeneralesDTO= new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo("GA");
			parametrosGeneralesDTO.setCodigoproducto("1");
			parametrosGeneralesDTO.setNombreparametro("CON_CARGO_INST_ADIC");
			parametrosGeneralesDTO=getVentasFacade().getParametroGeneral(parametrosGeneralesDTO);
			cargosInstalacionDTO.setCodigoConceptoPrecio(parametrosGeneralesDTO.getValorparametro());
			getVentasFacade().setRegistrarCargosInstalacion(cargosInstalacionDTO);
		} catch (GeneralException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
	}
	
	public void reversaCargosFormalizacion(Long numVenta)
		throws VentasException, RemoteException
	{
		logger.debug("reversaCargosFormalizacion():start");
		try {
			getVentasFacade().reversaCargosFormalizacion(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reversaCargosFormalizacion():end");	
	}
	
	public FaConceptoDTO getFaConcepto(FaConceptoDTO faConceptoDTO)
		throws GeneralException, RemoteException
	{
		logger.debug("getFaConcepto():start");		
		
		try {
			faConceptoDTO=getVentasFacade().getFaConcepto(faConceptoDTO);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("v():end");
		return faConceptoDTO;
	}
	
	public VendedorDTO buscarVendedor(VendedorDTO vendedor)
		throws GeneralException, RemoteException
	{
		logger.debug("buscarVendedor():start");		
		
		try {
			vendedor =getVentasFacade().busquedaVendedor(vendedor);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("buscarVendedor():end");
		return vendedor;
	}
	
	public 	RetornoDTO  sendToQueueActivacionProductosPorDefecto(DatosVentaDTO datosVenta)
		throws GeneralException, RemoteException
	{
		logger.debug("sendToQueueActivacionProductosPorDefecto():start");		
		RetornoDTO retorno= new RetornoDTO();
		try {
			getCusRelManFacade().sendToQueueActivacionProductosPorDefecto(datosVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("sendToQueueActivacionProductosPorDefecto():end");
		return retorno;
	}
	
	public String obtenerEstadoContratacionPA(Long numVenta)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerEstadoContratacionPA():start");		
		String retorno="";
		try {
			retorno = getVentasFacade().obtenerEstadoContratacionPA(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerEstadoContratacionPA():end");
		return retorno;
	}
	
	public FichaContratoPrestacionDTO obtenerDatosContratoPrestacion(Long numVenta)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDatosContratoPrestacion():start");		
		FichaContratoPrestacionDTO resultado= new FichaContratoPrestacionDTO();
		try {
			resultado = getVentasFacade().obtenerDatosContratoPrestacion(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosContratoPrestacion():end");
		return resultado;
	}
	
	public PagareDTO obtenerDatosPagare(Long numVenta)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDatosPagare():start");		
		PagareDTO resultado= new PagareDTO();
		try {
			resultado = getVentasFacade().obtenerDatosPagare(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosPagare():end");
		return resultado;
	}
	
	public FichaClienteDTO obtenerDatosFichaCliente(Long numAbonado)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDatosFichaCliente():start");		
		FichaClienteDTO resultado= new FichaClienteDTO();
		try {
			resultado = getVentasFacade().obtenerDatosFichaCliente(numAbonado);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosFichaCliente():end");
		return resultado;
	}
	
	public FichaSalidaBodegaDTO obtenerDatosSalidaBodega(Long numVenta) throws GeneralException, RemoteException {
		logger.debug("obtenerDatosSalidaBodega():start");
		logger.debug("numVenta [" + numVenta + "]");
		FichaSalidaBodegaDTO resultado = new FichaSalidaBodegaDTO();
		try {
			resultado = getVentasFacade().obtenerDatosSalidaBodega(numVenta);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosSalidaBodega():end");
		return resultado;
	}
	
	
	/** Metodos distribucion de bolsa **/
	
	public DistribucionBolsaDTO obtenerDatosBolsa( String codPlanTarif )
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDatosBolsa():start");		
		DistribucionBolsaDTO resultado= new DistribucionBolsaDTO();
		try {
			resultado = getVentasFacade().obtenerDatosBolsa(codPlanTarif);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDatosBolsa():end");
		return resultado;
	}
	
	public Long obtenerVentasAnteriores( Long numVenta, Long codCliente)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerVentasAnteriores():start");		
		Long resultado= null;
		try {
			resultado = getVentasFacade().obtenerVentasAnteriores(numVenta, codCliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerVentasAnteriores():end");
		return resultado;
	}
	
	public Long obtenerVentasAnterioresPorPlan( Long numVenta, Long codCliente, String codPlanTarif)
	throws GeneralException, RemoteException
	{
		logger.debug("obtenerVentasAnterioresPorPlan():start");		
		Long resultado= null;
		try {
			resultado = getVentasFacade().obtenerVentasAnterioresPorPlan(numVenta, codCliente, codPlanTarif);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerVentasAnterioresPorPlan():end");
		return resultado;
	}
	
	public TipoPrestacionDTO validarPlanDist(Long codCliente)
		throws GeneralException, RemoteException
	{
		logger.debug("validarPlanDist():start");		
		TipoPrestacionDTO resultado= new TipoPrestacionDTO();
		try {
			resultado = getVentasFacade().validarPlanDist(codCliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("validarPlanDist():end");
		return resultado;
	}
	
	public BolsaAbonadoDTO[] obtenerDistribucionBolsa(CustomerAccountDTO dto)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDistribucionBolsa():start");		
		BolsaAbonadoDTO[] resultado;
		try {
			resultado = getVentasFacade().obtenerDistribucionBolsa(dto);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDistribucionBolsa():end");
		return resultado;
	}
	
	public void guardarDistribucionBolsa(DistribucionBolsaDTO dto) 
		throws GeneralException, RemoteException
	{
		logger.debug("guardarDistribucionBolsa():start");	
		try {
			getVentasFacade().guardarDistribucionBolsa(dto);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("guardarDistribucionBolsa():end");	
	}
	
	public void guardarSolicitudVenta(SolicitudVentaDTO entrada)  
		throws GeneralException, RemoteException
	{
		logger.debug("guardarSolicitudVenta():start");	
		try {
			getVentasFacade().guardarSolicitudVenta(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("guardarSolicitudVenta():end");	
	}
	
	public TipoSolicitudDTO[]  obtenerTiposSolicitudes() 
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerTiposSolicitudes():start");	
		TipoSolicitudDTO[] resultado;
		try {
			resultado = getVentasFacade().obtenerTiposSolicitudes();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerTiposSolicitudes():end");
		return resultado;
	}
	
	public EstadoSolicitudDTO[]  listarEstadosSolicitud(SolicitudVentaDTO entrada) 
		throws GeneralException, RemoteException
	{
		logger.debug("listarEstadosSolicitud():start");	
		EstadoSolicitudDTO[] resultado;
		try {
			resultado = getVentasFacade().listarEstadosSolicitud(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("listarEstadosSolicitud():end");
		return resultado;
	}
	
	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO dto)
		throws GeneralException, RemoteException
	{
		logger.debug("getListaAbonadosVenta():start");	
		AbonadoDTO[] resultado = null;
		try {
			resultado = getVentasFacade().getListaAbonadosVenta(dto);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListaAbonadosVenta():end");
		return resultado;
	}

	public PlanTarifarioDTO[] obtenerPlanesDistribuidos( Long numVenta )
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerPlanesDistribuidos():start");	
		PlanTarifarioDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerPlanesDistribuidos(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerPlanesDistribuidos():end");
		return resultado;
	}

	public PlanTarifarioDTO[] obtenerPlanesDistribuidosAutomaticos( Long numVenta )
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerPlanesDistribuidosAutomaticos():start");	
		PlanTarifarioDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerPlanesDistribuidosAutomaticos(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerPlanesDistribuidosAutomaticos():end");
		return resultado;
	}
	
	public AbonadoDTO[] obtenerAbonadosDistribuidos(AbonadoDTO entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerAbonadosDistribuidos():start");	
		AbonadoDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerAbonadosDistribuidos(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerAbonadosDistribuidos():end");
		return resultado;
	}
		
	public ModalidadPagoDTO getModalidadPago(ModalidadPagoDTO  entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("getModalidadPago():start");	
		ModalidadPagoDTO resultado = null;
		try {
			resultado = getVentasFacade().getModalidadPago(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getModalidadPago():end");
		return resultado;
	}
	
	public ContratoDTO getTipoContrato(ContratoDTO  entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("getTipoContrato():start");	
		ContratoDTO resultado = null;
		try {
			resultado = getVentasFacade().getTipoContrato(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getTipoContrato():end");
		return resultado;
	}
	
	public void actualizaSolVentaEval(SolicitudVentaDTO  entrada) 
		throws GeneralException, RemoteException
	{
		logger.debug("actualizaSolVentaEval():start");	
		try {
			getVentasFacade().actualizaSolVentaEval(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("actualizaSolVentaEval():end");
	}
	
	public DetalleInformePresupuestoDTO[] obtenerDetallePresupuesto(Long numVenta) 
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerDetallePresupuesto():start");
		logger.debug("numVenta [" + numVenta + "]");
		DetalleInformePresupuestoDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerDetallePresupuesto(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerDetallePresupuesto():end");
		return resultado;	
	}
	
	public DetallePrecioSolicitudDTO[] obtenerPrecioSSAbo(ServicioSuplementarioDTO entrada) 
		throws GeneralException, RemoteException
	{
		logger.debug("obtenerPrecioSSAbo():start");	
		DetallePrecioSolicitudDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerPrecioSSAbo(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtenerPrecioSSAbo():end");
		return resultado;	
	}
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO entrada) 
		throws GeneralException, RemoteException
	{
		logger.debug("aplicaImpuestoImporte():start");	
		RegistroFacturacionDTO resultado = null;
		try {
			resultado = getVentasFacade().aplicaImpuestoImporte(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("aplicaImpuestoImporte():end");
		return resultado;	
	}	
	
	public void updCodigoSituacionAbo(AbonadoDTO entrada) 
		throws GeneralException, RemoteException
	{
		logger.debug("updCodigoSituacionAbo():start");	
		try {
			getVentasFacade().updCodigoSituacionAbo(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("updCodigoSituacionAbo():end");
	}
	
	public String getDatosInstalacion(Long numAbonado) 
		throws GeneralException, RemoteException
	{
		logger.debug("getDatosInstalacion():start");
		String resultado = null;
		try {
			resultado = getVentasFacade().getDatosInstalacion(numAbonado);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getDatosInstalacion():end");
		return resultado;
	}
	
	public RangoDTO[] obtieneRangosDisponibles(Integer codCentral)
		throws GeneralException, RemoteException
	{
		logger.debug("obtieneRangosDisponibles():start");
		RangoDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtieneRangosDisponibles(codCentral);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtieneRangosDisponibles():end");
		return resultado;
	}
	
	public void insertaRangoAsociadoNroPiloto(NumeroPilotoDTO entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("insertaRangoAsociadoNroPiloto():start");
		try {
			getVentasFacade().insertaRangoAsociadoNroPiloto(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("insertaRangoAsociadoNroPiloto():end");	
	}
	
	public NivelPrestacionDTO[] obtieneNivelesPrestacion(NivelPrestacionDTO entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("obtieneNivelesPrestacion():start");
		NivelPrestacionDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtieneNivelesPrestacion(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("obtieneNivelesPrestacion():end");	
		return resultado;
	}
	
	public void eliminarRangos(Long entrada)
		throws GeneralException, RemoteException
	{
		logger.debug("eliminarRangos():start");		
		try {
			getVentasFacade().eliminarRangos(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("eliminarRangos():end");
	}	
	
	public Integer consultaVentasCliente(Long codCliente)
			throws GeneralException, RemoteException 
	{
		logger.debug("consultaVentasCliente():start");
		Integer resultado = null;
		try {
			resultado = getVentasFacade().consultaVentasCliente(codCliente);			
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("consultaVentasCliente():end");
		return resultado;
	}
	
	public void updWimaxMacAddress(AbonadoDTO entrada) 
	throws GeneralException, RemoteException
{
	logger.debug("updWimaxMacAddress():start");	
	try {
		getVentasFacade().updWimaxMacAddress(entrada);
	} catch (VentasException e) {
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("GeneralException[" + log + "]");
		throw e;
	} catch (RemoteException e) {
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + log + "]");
		throw new GeneralException(e);
	}
	logger.debug("updWimaxMacAddress():end");
}

	public Long insertarDocDigitalizado(DocDigitalizadoDTO docDigitalizadoDTO)
		throws  GeneralException, RemoteException   
	{
		logger.debug("Inicio");
		Long r = getVentasFacade().insertarDocDigitalizado(docDigitalizadoDTO);
		logger.debug("Fin");
		return r;
	}

	public void eliminarDocDigitalizado(Long numCorrelativo) 
		throws  GeneralException, RemoteException  
	{
		logger.debug("Inicio");
		getVentasFacade().eliminarDocDigitalizado(numCorrelativo);
		logger.debug("Fin");
	}

	public DocDigitalizadoDTO obtenerDocDigitalizado(Long numCorrelativo)
		throws  GeneralException, RemoteException 
	{
		logger.debug("Inicio");
		DocDigitalizadoDTO r = getVentasFacade().obtenerDocDigitalizado( numCorrelativo);
		logger.debug("Fin");
		return r;
	}

	public DocDigitalizadoDTO[] obtenerDocDigitalizados(Long numVenta) 
		throws  GeneralException, RemoteException  
	{
		logger.debug("Inicio");
		DocDigitalizadoDTO[] r = getVentasFacade().obtenerDocDigitalizados(numVenta);
		logger.debug("Fin");
		return r;
	}
	
	public TipoDocDigitalizadoDTO[] obtenerTiposDocDigitalizado() 
		throws  GeneralException, RemoteException 
	{
		logger.debug("Inicio");
		TipoDocDigitalizadoDTO[] r = getVentasFacade().obtenerTiposDocDigitalizado();
		logger.debug("Fin");
		return r;
	}
		
	public SeguridadPerfilesDTO validaFiltroImpresion(SeguridadPerfilesDTO seguridadPerfilesDTO) 
		throws GeneralException, RemoteException 
	{
		logger.debug("validaFiltroImpresion():start");	
		try {
			seguridadPerfilesDTO = getVentasFacade().validaFiltroImpresion(seguridadPerfilesDTO);	
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("validaFiltroImpresion():end");
		return seguridadPerfilesDTO;
	}
	
	public CargoSolicitudDTO[] getCargosSolicitud(CargoSolicitudDTO entrada)
		throws VentasException, RemoteException, GeneralException
	{
		logger.debug("getCargosVta():start");
		CargoSolicitudDTO[] resultado = null;
		try {
			resultado = getVentasFacade().getCargosVta(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCargosVta():end");
		return resultado;
	}//getCargosSolicitud
	
	
	public ObtencionCargosDTO getCargosSolicitudAdelantados(ParametrosObtencionCargosDTO entrada)
		throws VentasException, RemoteException, GeneralException
	{
		logger.debug("getCargosSolicitudAdelantados():start");
		ObtencionCargosDTO resultado = null;
		try {
			resultado = getVentasFacade().obtenerCargos(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCargosSolicitudAdelantados():end");
		return resultado;
	}//getCargosSolicitudAdelantados
	
	public CargoSolicitudDTO[] getCargosPARecSolicitud(CargoSolicitudDTO entrada)
		throws VentasException, RemoteException, GeneralException
	{
		logger.debug("getCargosPARecSolicitud():start");
		CargoSolicitudDTO[] resultado = null;
		try {
			resultado = getVentasFacade().getCargosPARecSolicitud(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCargosPARecSolicitud():end");
		return resultado;
	}//getCargosPARecSolicitud
	
	public ResultadoAltaCarrierPasilloLDIDTO altaCarrierPasilloLDI(AltaCarrierPasilloLDIDTO dto) 
		throws VentasException 
	{
		ResultadoAltaCarrierPasilloLDIDTO r = null;
		logger.debug("Inicio");
		try {
			logger.debug("Antes");
			ActivacionMasivaORQ orquestadorFacade = getOrquestadorFacade();
			logger.debug("Despues");
			r = orquestadorFacade.altaCarrierPasilloLDI(dto);
		}
		catch (AltaClienteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("AltaClienteException [" + log + "]");
			throw new VentasException(e);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("VentasException [" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("RemoteException [" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	public void existeNumeroSMS(Long entrada)
		throws VentasException, RemoteException, GeneralException
	{
		logger.debug("existeNumeroSMS():start");		
		try {
			getVentasFacade().existeNumeroSMS(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("existeNumeroSMS():end");		
	}//existeNumeroSMS;
	
	/**
	 * @author mwn40031
	 * @param codVendedor
	 * @return
	 * @throws VentasException
	 */
	public Boolean validaVendedorLN(String codVendedor) throws VentasException {
		logger.info("Inicio");
		Boolean r = Boolean.FALSE;
		try {
			r = getVentasFacade().validaVendedorLN(codVendedor);
		}
		catch (VentasException e) {
			logger.debug("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("Fin");
		return r;
	}
	
	/**
	 * @author mwn40031
	 * @param codVendedorDealer
	 * @return
	 * @throws VentasException
	 */
	public Boolean validaVendedorDealerLN(String codVendedorDealer) throws VentasException {
		logger.info("Inicio");
		Boolean r = Boolean.FALSE;
		try {
			r = getVentasFacade().validaVendedorDealerLN(codVendedorDealer);
		}
		catch (VentasException e) {
			logger.debug("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("Fin");
		return r;
	}
	
	/**
	 * @author mwn40031
	 * @param numSerie
	 * @return
	 * @throws VentasException
	 */
	public Boolean validaSerieLN(String numSerie) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = getVentasFacade().validaSerieLN(numSerie);
		}
		catch (VentasException e) {
			logger.debug("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	/**
	 * @author mwn40031
	 * @param codCliente
	 * @return
	 * @throws VentasException
	 */
	public Boolean validaClienteLN(String codCliente) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = getVentasFacade().validaClienteLN(codCliente);
		}
		catch (VentasException e) {
			logger.debug("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	} 
	
	/**
	 * @author mwn40031
	 * @param numIdent
	 * @param codTipIdent
	 * @return
	 * @throws VentasException
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = getVentasFacade().validaClienteLN(numIdent, codTipIdent);
		}
		catch (VentasException e) {
			logger.debug("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	} 
	
	public void insertaCargosOverride(DetalleLineaSolicitudDTO[] lineas) throws VentasException, RemoteException,
			GeneralException {
		logger.info("insertaCargosOverride(), inicio");
		try {
			getVentasFacade().insertaCargosOverride(lineas);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("insertaCargosOverride(), fin");
	}// insertaCargosOverride;
	
	/**
	 * @author JIB
	 * @param numVenta
	 * @return
	 * @throws VentasException
	 */
	public DetalleCargosSolicitudDTO[] recuperaCargosOverride(Long numVenta, String codOrigenTransaccion) 
		throws VentasException
	{
		DetalleCargosSolicitudDTO[] r = null;
		logger.debug("recuperaCargosOverride():start");
		try {
			 r = getVentasFacade().recuperaCargosOverride(numVenta, codOrigenTransaccion);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("recuperaCargosOverride():end");
		return r;
	}// recuperaCargosOverride
	
	public ProrrateoDTO getProrrateo(ProrrateoDTO entrada) 
		throws VentasException
	{
		ProrrateoDTO resultado = new ProrrateoDTO();
		logger.debug("getProrrateo():start");
		try {
			resultado = getVentasFacade().getProrrateo(entrada);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getProrrateo():end");
		return resultado;
	}// getProrrateo
	
	public boolean validarTelefonoLDI(String telefono) 
		throws VentasException 
	{
		logger.info("validarTelefonoLDI, Inicio");
		boolean r = false;
		try {
			r = getVentasFacade().validarTelefonoLDI(telefono);
		}
		catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("Exception: " + log);
			throw new VentasException(e);
		}
		logger.debug("Valor de retorno: " +  r);
		logger.info("validarTelefonoLDI, Fin");
		return r;
	}
	
	public ResultadoScoreClienteDTO getSujetoFisico(ScoreClienteDTO dto) throws VentasException {
		logger.info("getSujetoFisico, inicio");
		final String urlScoreCliente = global.getValorExterno("url.webservice.scoring.scorecliente").trim();
		logger.debug("urlScoreCliente: " + urlScoreCliente);
		String formatFechaScoring = global.getValorExterno("scoring.formato_fecha.scorecliente").trim();
		formatFechaScoring = !Utilidades.emptyOrNull(formatFechaScoring) ? formatFechaScoring : "yyyyMMdd";
		logger.debug("formatFechaScoring [" + formatFechaScoring + "]");
		ResultadoScoreClienteDTO r = null;
		try {
			ScoringHelper.validarSujetoFisico(dto);
			logger.debug("Scoring de Cliente...");
			final ScoreCliente scoreClienteInstance = ScoringHelper.getScoreClienteInstance(urlScoreCliente);
			SimpleDateFormat sdf = new SimpleDateFormat(formatFechaScoring);
			final String I_fecha_nacimiento = sdf.format(dto.getFecha_nacimiento());
			logger.debug("I_fecha_nacimiento [" + I_fecha_nacimiento + "]");
			final String I_fecha_creacion = sdf.format(new Date()); //Hoy
			logger.debug("I_fecha_creacion [" + I_fecha_creacion + "]");
			ResultadoFisico score = scoreClienteInstance.getSujetoFisico(dto.getI_creado_por(), 
					dto.getAplicaTarjeta(), dto.getCodTipoTarjeta(), I_fecha_creacion, dto.getPrimer_nombre(), dto.getSegundo_nombre(), 
					dto.getPrimer_apellido(), dto.getSegundo_apellido(), dto.getCodTipoDocumento(), 
					dto.getDocumento(), dto.getNit(), I_fecha_nacimiento, dto.getCapacidad_pago(), dto.getCodNacionalidad(), 
					dto.getCodNivelAcademico(), dto.getCodEstadoCivil(), dto.getCodTipoEmpresa(), dto.getAntiguedad_laboral(), 
					dto.getTip_producto(), dto.getI_cod_elementoid());
			r = new ResultadoScoreClienteDTO(score.getMensaje(), score.getReferencia(), score.getClasificacion(), score
					.getPunteo(), score.getDocumentosRequeridos(), score.getDocumentosOpcionales());
			logger.debug("Scoring de Cliente...OK");
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException("Ocurrió un error al ejecutar scoring de cliente", e);
		}
		logger.info("getSujetoFisico, fin");
		return r;
	}
	
	private DominioScoringDTO[] obtenerDominioScoring(String nombreDominio) throws RemoteException {
		logger.info("obtenerDominioScoring, inicio");
		logger.debug("nombreDominio [" + nombreDominio + "]");
		final String urlScoringConsulta = global.getValorExterno("url.webservice.scoring.consulta");
		logger.debug("urlScoringConsulta: " + urlScoringConsulta);
		final Consulta consultaInstance = ScoringHelper.getConsultaInstance(urlScoringConsulta);
		String resultadoConsulta = null;
		if (consultaInstance != null) {
			resultadoConsulta = consultaInstance.getDatos(nombreDominio);
		}
		else {
			logger.debug("consultaInstance [" + consultaInstance + "]");
		}
		logger.debug("resultadoConsulta [" + resultadoConsulta + "]");
		final DominioScoringDTO[] r = DominioScoringDTO.obtenerArrayDominiosDesdeString(resultadoConsulta);
		logger.info("obtenerDominioScoring, fin");
		return r;
	}
	
	public DominioScoringDTO[] obtenerDominioEstadoCivil() 
		throws RemoteException 
	{
		final String dominioEstadoCivil = global.getValorExterno("parametro.webservice.scoring.consulta.estado_civil"); //"ESTADO CIVIL";
		logger.debug("dominioEstadoCivil: " + dominioEstadoCivil);
		return obtenerDominioScoring(dominioEstadoCivil);
	}
	
	public DominioScoringDTO[] obtenerDominioTipoTarjeta()
		throws RemoteException 
	{
		final String dominioTipoTarjeta = global.getValorExterno("parametro.webservice.scoring.consulta.tipo_tarjeta"); //"TIPO TARJETA";
		logger.debug("dominioTipoTarjeta: " + dominioTipoTarjeta);
		return obtenerDominioScoring(dominioTipoTarjeta);
	}

	public DominioScoringDTO[] obtenerDominioNacionalidad() 
		throws RemoteException 
	{
		final String dominioNacionalidad = global.getValorExterno("parametro.webservice.scoring.consulta.nacionalidad"); //"NACIONALIDAD";
		logger.debug("dominioNacionalidad: " + dominioNacionalidad );
		return obtenerDominioScoring(dominioNacionalidad);
	}

	public DominioScoringDTO[] obtenerDominioNivelAcademico() 
		throws RemoteException 
	{
		final String dominioNivelAcademico = global.getValorExterno("parametro.webservice.scoring.consulta.nivel_academico"); //"NIVEL ACADEMICO";
		logger.debug("dominioNivelAcademico: " + dominioNivelAcademico);
		return obtenerDominioScoring(dominioNivelAcademico);
	}

	public DominioScoringDTO[] obtenerDominioTipoEmpresa() 
		throws RemoteException 
	{
		final String dominioTipoEmpresa = global.getValorExterno("parametro.webservice.scoring.consulta.tipo_empresa"); //"TIPO EMPRESA";
		logger.debug("dominioTipoEmpresa: " + dominioTipoEmpresa );
		return obtenerDominioScoring(dominioTipoEmpresa);
	}
	
	public DominioScoringDTO[] obtenerDominioTipoDocumento() throws RemoteException, AltaClienteException {
		logger.info("obtenerDominioTipoDocumento, inicio");
		String codTipoDocumentoCedulaScoring = global.getValor("cod_tipo_documento.scoring.CEDULA").trim();
		String codTipoDocumentoPasaporteScoring = global.getValor("cod_tipo_documento.scoring.PASAPORTE")
				.trim();
		String desTipoDocumentoCedulaScoring = global.getValor("des_tipo_documento.scoring.CEDULA").trim();
		String desTipoDocumentoPasaporteScoring = global.getValor("des_tipo_documento.scoring.PASAPORTE")
				.trim();
		DominioScoringDTO[] r = new DominioScoringDTO[2];
		r[0] = new DominioScoringDTO();
		r[0].setCodigo(codTipoDocumentoCedulaScoring);
		r[0].setValor(desTipoDocumentoCedulaScoring);
		r[1] = new DominioScoringDTO();
		r[1].setCodigo(codTipoDocumentoPasaporteScoring);
		r[1].setValor(desTipoDocumentoPasaporteScoring);
		logger.info("obtenerDominioTipoDocumento, fin");
		return r;
	}
	
	public DominioScoringDTO[] obtenerDominioAplicaTarjeta() {
		logger.info("obtenerDominioAplicaTarjeta, inicio");
		DominioScoringDTO[] r = new DominioScoringDTO[2];
		r[0] = new DominioScoringDTO();
		r[0].setCodigo("SI");
		r[0].setValor("SI");
		r[1] = new DominioScoringDTO();
		r[1].setCodigo("NO");
		r[1].setValor("NO");
		logger.info("obtenerDominioAplicaTarjeta, fin");
		return r;
	}
	
	public ScoreClienteDTO[] getSolicitudesScoring(BusquedaSolScoringDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getSolicitudesScoring():start");	
		ScoreClienteDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getSolicitudesScoring(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSolicitudesScoring():end");
		return retorno;
	}//getSolicitudesScoring
	
	/**
	 * @author JIB
	 * @param dto
	 * @return
	 * @throws VentasException
	 */
	public long insertarSolicitudScoring(ScoreClienteDTO dto, EstadoScoringDTO estadoScoringDTO) 
		throws VentasException 
	{
		logger.debug("insertarSolicitudScoring, inicio");
		long resultado = 0;
		try {
			ScoringHelper.validarSolicitudScoring(dto);
			resultado = getVentasFacade().insertarSolicitudScoring(dto, estadoScoringDTO);
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException("Ocurrió un error al crear solicitud scoring", e);
		}
		logger.debug("insertarSolicitudScoring, fin");
		return resultado;
	}//fin insertarSolicitudScoring
	
	public void liberarSeriesYTelefono(Long numVenta) 
		throws VentasException, RemoteException
	{
		logger.debug("liberarSeriesYTelefono():start");
		try {
			getVentasFacade().liberarSeriesYTelefono(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("liberarSeriesYTelefono");		
	}//liberarSeriesYTelefono
	
	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws VentasException
	 */
	public ScoreClienteDTO getSolicitudScoring(Long numSolScoring) 
		throws VentasException 
	{
		logger.debug("getSolicitudScoring, inicio");
		ScoreClienteDTO resultado = null;
		try {
			resultado = getVentasFacade().getSolicitudScoring(numSolScoring);
		}
		catch (VentasException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw e;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("getSolicitudScoring, fin");
		return resultado;
	}//fin getSolicitudScoring

	/**
	 * @author pv
	 * @param numSolicitud
	 * @return
	 * @throws VentasException
	 */
	public ReporteScoringDTO getReporteSolicitudScoring(Long numSolicitud) 
		throws VentasException {
		logger.info("getReporteSolicitudScoring, inicio");
		ReporteScoringDTO resultado = null;
		logger.debug("numSolicitud [" + numSolicitud + "]");
		try {
			resultado = getVentasFacade().getReporteSolicitudScoring(numSolicitud);
		}
		catch (RemoteException e) {
			throw new VentasException(e);
		}
		logger.info("getReporteSolicitudScoring, fin");
		return resultado;
	}//fin getReporteSolicitudScoring	

	/**
	 * @author pv
	 * @param numSolicitud
	 * @return
	 * @throws VentasException
	 */
	public EstadoScoringDTO[] getEstadosSolicitudScoring(Long numSolicitud) 
		throws VentasException 
	{
		logger.debug("getEstadosSolicitudScoring, inicio");
		EstadoScoringDTO[] resultado = null;
		try {
			resultado = getVentasFacade().getEstadosSolicitudScoring(numSolicitud);
		}
		catch (RemoteException e) {
			throw new VentasException(e);
		}
		logger.debug("getEstadosSolicitudScoring, fin");
		return resultado;
	}//fin getEstadosSolicitudScoring		
	
	/**
	 * @author JIB
	 * @param scoreClienteDTO
	 * @return
	 * @throws VentasException
	 */
	public Double calcularCapacidadPago(ScoreClienteDTO scoreClienteDTO) 
		throws VentasException {
		logger.info("obtenerCapacidadPagoScoring, inicio");
		Double r = null;
		try {
			if (scoreClienteDTO.getNumSolScoring() == 0) {
				VentasException e = new VentasException("Ocurrio un error al calcular la capacidad de pago");
				e.setDescripcionEvento("N° Solicitud Scoring no válido");
				throw e;
			}
			r = getVentasFacade().obtieneCapacidadPagoScoring(scoreClienteDTO);
		}
		catch (VentasException e) {
			logger.error("VentasException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		} 
		catch (Exception e) {
			logger.error("RemoteException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerCapacidadPagoScoring, fin");
		return r;
	}//obtenerCapacidadPagoScoring
	
	public LineaSolicitudScoringDTO[] getlineasSolScoring(Long entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getlineasSolScoring():start");	
		LineaSolicitudScoringDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getlineasSolScoring(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getlineasSolScoring():end");
		return retorno;
	}//getlineasSolScoring
	
		
	/**
	 * @author JIB
	 * @return
	 * @throws DireccionException
	 * @throws RemoteException
	 */
	public DatosDireccionDTO[] getArrayRegiones() throws DireccionException, RemoteException {
		DatosDireccionDTO[] r = null;
		DireccionDTO direccionDTO = getDatosDireccion(null);
		if (direccionDTO != null && direccionDTO.getConceptoDireccionDTOs() != null) {
			for (int i = 0; i < direccionDTO.getConceptoDireccionDTOs().length; i++) {
				if (direccionDTO.getConceptoDireccionDTOs()[i].getCodigoConcepto() == TipoAtributoDireccion.region) {
					r = direccionDTO.getConceptoDireccionDTOs()[i].getDatosDireccionDTO();
					break;
				}
			}
		}
		return r;
	}
	
	
	public TipoPrestacionDTO getDatosPrestacion(String codPrestacion)
		throws VentasException, RemoteException
	{
		logger.debug("getDatosPrestacion():start");	
		TipoPrestacionDTO retorno = null;
		try {
			retorno = getVentasFacade().getDatosPrestacion(codPrestacion);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosPrestacion():end");
		return retorno;
	}//getDatosPrestacion
	
	
	/**
	 * @author JIB
	 * @param resultadoScoreClienteDTO
	 * @return
	 * @throws VentasException
	 */
	public void insertarResultadoScoreCliente(ResultadoScoreClienteDTO resultadoScoreClienteDTO) 
		throws VentasException 
	{
		logger.info("insertarResultadoScoreCliente, inicio");
		try {
			logger.debug("antes de getVentasFacade().insertarResultadoScoreCliente(resultadoScoreClienteDTO)");
			getVentasFacade().insertarResultadoScoreCliente(resultadoScoreClienteDTO);
			logger.debug("despues de getVentasFacade().insertarResultadoScoreCliente(resultadoScoreClienteDTO)");
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + log + "]");
			throw new VentasException(e);
		}
		
		logger.info("insertarResultadoScoreCliente, fin");
	}//insertarResultadoScoreCliente
	
	
	public LineaSolicitudScoringDTO getDetalleLineaScoring(Long numLineaScoring)
		throws VentasException, RemoteException
	{
		logger.debug("getDetalleLineaScoring():start");	
		LineaSolicitudScoringDTO retorno = null;
		try {
			retorno = getVentasFacade().getDetalleLineaScoring(numLineaScoring);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDetalleLineaScoring():end");
		return retorno;
	}//getDetalleLineaScoring	
	
	
	public void actualizarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
			throws VentasException {
		try {
			getVentasFacade().actualizarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		
	}
	
	public DocDigitalizadoScoringDTO obtenerDocDigitalizadoScoring(Long numCorrelativo, Long numSolScoring)
			throws VentasException {
		DocDigitalizadoScoringDTO dto = null;
		try {
			dto = getVentasFacade().obtenerDocDigitalizadoScoring(numCorrelativo, numSolScoring);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		return dto;
	}
	
	public DocDigitalizadoScoringDTO[] obtenerDocDigitalizadosScoring(Long numSolScoring)
			throws VentasException {
		DocDigitalizadoScoringDTO[] dto = null;
		try {
			dto = getVentasFacade().obtenerDocDigitalizadosScoring(numSolScoring);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		return dto;
	}
	
	public EstadoDTO[] obtenerEstadosDestino(String codPrograma, String codEstadoOrigen, String nomTabla)
			throws VentasException {
		logger.info("obtenerEstadosDestino, inicio");
		EstadoDTO[] r = null;
		logger.debug("codPrograma [" + codPrograma + "]");
		logger.debug("codEstadoOrigen [" + codEstadoOrigen + "]");
		logger.debug("nomTabla [" + nomTabla + "]");
		try {
			r = getVentasFacade().obtenerEstadosDestino(codPrograma, codEstadoOrigen, nomTabla);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerEstadosDestino, fin");
		return r;
	}

	public void insertaEstadoScoring(EstadoScoringDTO estadoScoringDTO) throws VentasException {
		try {
			getVentasFacade().insertaEstadoScoring(estadoScoringDTO);
		}
		catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		}
		catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
	}

	public boolean consultarParametro(String codProducto, String codModulo, String nombreParametro)
			throws VentasException, RemoteException {
		logger.info("consultarParametro, Inicio");
		boolean r = false;
		ParametrosGeneralesDTO dto = new ParametrosGeneralesDTO();
		dto.setCodigoproducto(codProducto);
		dto.setCodigomodulo(codModulo);
		dto.setNombreparametro(nombreParametro);
		logger.debug("nombreParametro: " + nombreParametro);
		try {
			dto = getParametroGeneral(dto);
			if (dto != null && dto.getValorparametro().equals("1")) {
				r = true;
			}
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al consultar parámetro: " + nombreParametro);
			logger.error(e.getMessage());
			return r;
		}
		logger.info("Valor de " + nombreParametro + " [" + r + "]");
		logger.info("consultarParametro, Fin");
		return r;
	}
	
	public Long obtenerNroventaSolScoring(Long numSolScoring)
		throws VentasException, RemoteException
	{
		logger.debug("obtenerNroventaSolScoring():start");	
		Long retorno = null;
		try {
			retorno = getVentasFacade().obtenerNroventaSolScoring(numSolScoring);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerNroventaSolScoring():end");
		return retorno;
	}//obtenerNroventaSolScoring
	
	public boolean verificaPrestacionCliente(Long codCliente, String codPrestacion) throws VentasException, RemoteException {
		logger.info("verificaPrestacionCliente, inicio");
		boolean r = false;
		try {
			r = getVentasFacade().verificaPrestacionCliente(codCliente, codPrestacion);
		}
		catch (VentasException e) {
			logger.debug("VentasException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (RemoteException e) {
			logger.debug("RemoteException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("verificaPrestacionCliente, fin");
		return r;
	}// obtenerNroventaSolScoring
	
	
	public ReglaSSDTO[] getReglasdeValidacionSS(ReglaSSDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getReglasdeValidacionSS():start");	
		ReglaSSDTO[] retorno = null;
		try {
			retorno = getVentasFacade().getReglasdeValidacionSS(entrada);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getReglasdeValidacionSS():end");
		return retorno;
	}//getReglasdeValidacionSS
	
	/**
	 * @author JIB
	 * @param codVendedor
	 * @throws VentasException
	 * @throws RemoteException
	 */
	public boolean habilitarFormularioUsuario(String codigoPrograma, long numVersion, String nombreUsuario,
			String formulario) throws VentasException, RemoteException {
		logger.info("habilitarFormularioUsuario, inicio");
		logger.debug("codigoPrograma [" + codigoPrograma + "]");
		logger.debug("numVersion [" + numVersion + "]");
		logger.debug("nombreUsuario [" + nombreUsuario + "]");
		logger.debug("formulario [" + formulario + "]");
		if (Utilidades.emptyOrNull(codigoPrograma) || Utilidades.emptyOrNull(nombreUsuario)
				|| Utilidades.emptyOrNull(formulario)) {
			logger.info("habilitarFormularioUsuario [false], fin");
			return false;
		}
		UsuarioSCLDTO usuarioSCL = new UsuarioSCLDTO();
		usuarioSCL.setCodigoPrograma(codigoPrograma);
		usuarioSCL.setNumVersion(numVersion);
		usuarioSCL.setNombreUsuario(nombreUsuario);
		final MenuUsuarioSCLDTO[] arrayMenuUsuario = this.getMenuUsuario(usuarioSCL).getArrayMenuUsuario();
		for (int i = 0; i < arrayMenuUsuario.length; i++) {
			String item = arrayMenuUsuario[i].getFormulario().trim();
			if (!Utilidades.emptyOrNull(item)) {
				if (formulario.equals(item)) {
					logger.debug("item encontrado [" + item + "]");
					logger.info("habilitarFormularioUsuario [true], fin");
					return true;
				}
			}
		}
		logger.info("habilitarFormularioUsuario [false], fin");
		return false;
	}
	
	/**
	 * @author JIB
	 * @param codVendedor
	 * @throws VentasException
	 * @throws RemoteException
	 */
	public EstadoScoringDTO[] obtenerEstadosScoringXNumTarjeta(String codTipTarjetaSCL, String numTarjeta) throws VentasException {
		logger.info("obtenerEstadosSolicitudScoringXNumTarjeta, inicio");
		logger.debug("codTipoTarjeta [" + codTipTarjetaSCL + "]");
		logger.debug("numTarjeta [" + numTarjeta + "]");
		EstadoScoringDTO[] r = null;
		try {
			r = getVentasFacade().obtenerEstadosSolicitudScoringXNumTarjeta(codTipTarjetaSCL, numTarjeta);
		}
		catch (VentasException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.info("obtenerEstadosSolicitudScoringXNumTarjeta, fin");
		return r;
	}
	
	
	/**
	 * @author JIB
	 * @param codVendedor
	 * @throws VentasException
	 * @throws RemoteException
	 */
	public void bloquearVendedor(String codVendedor) throws VentasException, RemoteException {
		logger.info("bloquearVendedor, inicio");
		final String codigoAccionBloqueo = "B";
		VendedorDTO vendedorDTO = new VendedorDTO();
		vendedorDTO.setCodigoAccionBloqueo(codigoAccionBloqueo);
		vendedorDTO.setCodigoVendedor(codVendedor);
		bloqueaDesbloqueaVendedor(vendedorDTO);
		logger.info("bloquearVendedor, fin");
	}
	
	/**
	 * @author JIB
	 * @param codVendedor
	 * @throws VentasException
	 * @throws RemoteException
	 */
	public void desbloquearVendedor(String codVendedor) throws VentasException, RemoteException {
		logger.info("desbloquearVendedor, inicio");
		final String codigoAccionBloqueo = "D";
		VendedorDTO vendedorDTO = new VendedorDTO();
		vendedorDTO.setCodigoAccionBloqueo(codigoAccionBloqueo);
		vendedorDTO.setCodigoVendedor(codVendedor);
		bloqueaDesbloqueaVendedor(vendedorDTO);
		logger.info("desbloquearVendedor, fin");
	}
	
	public void updIngresosMensualesCliente(ClienteDTO cliente)
		throws VentasException, RemoteException
	{
		logger.debug("updIngresosMensualesCliente():start");
		try {
			getVentasFacade().updIngresosMensualesCliente(cliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("updIngresosMensualesCliente():end");		
	}//updIngresosMensualesCliente
	
	/**
	 * @author JIB
	 * @param codVendedor
	 * @throws VentasException
	 */
	public ConceptosRecaudacionComDTO[] getBancos() throws VentasException {
		logger.info("getBancos, inicio");
		ConceptosRecaudacionComDTO[] r = new ConceptosRecaudacionComDTO[0];
		try {
			r = getAltaClienteFacade().getBancos();
		}
		catch (AltaClienteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			throw ex;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("encontrados [" + r.length + "]");
		logger.info("getBancos, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param tarjetaDTO
	 * @return
	 * @throws VentasException
	 */
	public TarjetaDTO validarTarjeta(TarjetaDTO tarjetaDTO) throws VentasException { 
		logger.info("validarTarjeta, inicio");
		logger.debug("tarjetaDTO [" + tarjetaDTO + "]");
		TarjetaDTO r = null;
		try {
			r = getAltaClienteFacade().validarTarjeta(tarjetaDTO);
		}
		catch (AltaClienteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			throw ex;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.info("validarTarjeta, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @return
	 * @throws VentasException
	 */
	public ConceptosRecaudacionComDTO[] getTiposTarjetaSCL() throws VentasException {
		logger.info("getTiposTarjetaSCL, inicio");
		ConceptosRecaudacionComDTO[] r = new ConceptosRecaudacionComDTO[0];
		try {
			r = getAltaClienteFacade().getTiposTarjetas();
		}
		catch (AltaClienteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			throw ex;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("encontrados [" + r.length + "]");
		logger.info("getTiposTarjetaSCL, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws VentasException
	 */
	public ResultadoScoreClienteDTO getResultadoScoring(Long numSolScoring) throws VentasException {
		logger.info("getResultadoScoring, inicio");
		ResultadoScoreClienteDTO r = null;
		try {
			r = getVentasFacade().getResultadoScoring(numSolScoring);
		}
		catch (VentasException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw e;
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.info("getResultadoScoring, fin");
		return r;
	}//getResultadoScoring

	public void updEstadoMovProductoSolicitud(Long numVenta)
		throws VentasException, RemoteException
	{
		logger.debug("updEstadoMovProductoSolicitud():start");
		try {
			getVentasFacade().updEstadoMovProductoSolicitud(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("updEstadoMovProductoSolicitud():end");		
	}//updEstadoMovProductoSolicitud
	
	public TipoComportamientoDTO[] obtenerTiposComportamiento()
		throws VentasException, RemoteException
	{
		logger.debug("obtenerTiposComportamiento():start");
		TipoComportamientoDTO[] resultado = null;
		try {
			resultado = getVentasFacade().obtenerTiposComportamiento();
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerTiposComportamiento():end");		
		return resultado;
	}//obtenerTiposComportamiento
	
	/**
	 * @author JIB
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @param codigosTipoComportamiento
	 * @return
	 * @throws VentasException
	 * @throws RemoteException
	 */
	public ProductoOfertadoDTO[] obtenerProductosOfertadosXFiltros(final String codPlanTarif, final String codCanal,
			final String nivel, final String codPrestacion, final String[] codigosTipoComportamiento)
			throws VentasException, RemoteException {
		logger.info("obtenerProductosOfertadosXFiltros, inicio");
		ProductoOfertadoDTO[] r = new ProductoOfertadoDTO[0];
		logger.debug("codPlanTarif [" + codPlanTarif + "]");
		logger.debug("codCanal [" + codCanal + "]");
		logger.debug("nivel [" + nivel + "]");
		logger.debug("codPrestacion [" + codPrestacion + "]");
		logger.debug("codigosTipoComportamiento [" + codigosTipoComportamiento + "]");
		try {
			r = getVentasFacade().obtenerProductosOfertadosXFiltros(codPlanTarif, codCanal, nivel, codPrestacion,
					codigosTipoComportamiento);
		}
		catch (VentasException e) {
			logger.error("VentasException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (RemoteException e) {
			logger.error("RemoteException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		//logger.debug("r.length [" + r.length + "]");
		logger.info("obtenerProductosOfertadosXFiltros, fin");
		return r;
	}//obtenerProductosOfertadosXFiltros
	
	/**
	 * @author Jacqueline Mendez Ortega 16-11-2010 INC-155400
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @return ProductoOfertadoDTO[]
	 * @throws VentasException
	 * @throws RemoteException
	 * 
	 * Obtiene los planes opcionales obligatorios configurados para el Plan Tarifario
	 */
	public ProductoOfertadoDTO[] obtenerProductosObligatoriosPT(final String codPlanTarif, 
																final String codCanal,
																final String nivel, 
																final String codPrestacion)
		   throws VentasException, RemoteException {
		logger.info("obtenerProductosObligatoriosPT, inicio");
		ProductoOfertadoDTO[] r = new ProductoOfertadoDTO[0];
		logger.debug("codPlanTarif [" + codPlanTarif + "]");
		logger.debug("codCanal [" + codCanal + "]");
		logger.debug("nivel [" + nivel + "]");
		logger.debug("codPrestacion [" + codPrestacion + "]");
		try {
			r = getVentasFacade().obtenerProductosObligatoriosPT(codPlanTarif, codCanal, nivel, codPrestacion);
		}
		catch (VentasException e) {
			logger.error("VentasException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw e;
		}
		catch (RemoteException e) {
			logger.error("RemoteException[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("r.length [" + r.length + "]");
		logger.info("obtenerProductosObligatoriosPT, fin");
		return r;
	}//obtenerProductosObligatoriosPT

	public String consultaExistenPlanes(Long numSolScoring)throws VentasException, RemoteException
	{
		logger.debug("consultaExistenPlanes():start");
		String resultado = null;
		try {
			resultado = getVentasFacade().consultaExistenPlanes(numSolScoring);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("consultaExistenPlanes():end");		
		return resultado;
	}

	/**
	 * @author JIB
	 * @param numSerie
	 * @return
	 * @throws VentasException
	 * 
	 * Incidencia: 149133. Se valida que series (simcard) como imei (terminales) no exista en un abonado existente AAA, tanto internas como externas.
	 */
	public boolean existeAbonadoXSimcard(Long numSerie) throws VentasException {
		final String nombreMetodo = "existeAbonadoXSimcard";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numSerie [" + numSerie + "]");
		boolean r = false;
		try {
			r = getVentasFacade().existeAbonadoXSimcard(numSerie);
		}
		catch (RemoteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param numImei
	 * @return
	 * @throws VentasException
	 * 
	 * Incidencia: 149133. Se valida que series (simcard) como imei (terminales) no exista en un abonado existente AAA, tanto internas como externas.
	 */
	public boolean existeAbonadoXImei(Long numImei) throws VentasException {
		final String nombreMetodo = "existeAbonadoXImei";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numImei [" + numImei + "]");
		boolean r = false;
		try {
			r = getVentasFacade().existeAbonadoXImei(numImei);
		}
		catch (RemoteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param codTiplan
	 * @return
	 * @throws VentasException
	 * 
	 * Incidencia: 149995 (29/10/2010)
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodTiplan(String codTiplan) throws VentasException {
		logger.info("getListadoCampaniasVigentesXCodTiplan, inicio");
		logger.debug("codTiplan [" + codTiplan + "]");
		CampanaVigenteDTO[] r = null;
		try {
			r = getVentasFacade().getListadoCampaniasVigentesXCodTiplan(codTiplan);
		}
		catch (RemoteException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("r.length [" + r.length + "]");
		logger.info("getListadoCampaniasVigentesXCodTiplan, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param codUso
	 * @return
	 * @throws Exception
	 * 
	 * Incidencia: 149995 (29/10/2010)
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodUso(String codUso) throws VentasException {
		logger.info("getListadoCampaniasVigentesXCodUso, inicio");
		final String CLAVE_COD_USO_X_COD_TIPLAN = "cod_tiplan.para.cod_uso";
		String codTiplan = global.getValor(CLAVE_COD_USO_X_COD_TIPLAN + "." + codUso);
		CampanaVigenteDTO[] r  = getListadoCampaniasVigentesXCodTiplan(codTiplan);
		logger.info("getListadoCampaniasVigentesXCodUso, fin");
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 27-04-2011	
	public void actualizaUsoTerminal(ArticuloDTO entrada,String codUsoNuevo)
	throws VentasException, RemoteException{
	logger.debug("actualizaUsoTerminal():start");	
	try {
		getVentasFacade().actualizaUsoTerminal(entrada, codUsoNuevo);
	} catch (VentasException e) {
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("VentasException[" + log + "]");
		throw e;
	} catch (RemoteException e) {
		String log = StackTraceUtl.getStackTrace(e);
		logger.debug("RemoteException[" + log + "]");
		throw new VentasException(e);
	}
	logger.debug("actualizaUsoTerminal():end");
	} 
	//Fin P-CSR-11002 JLGN 27-04-2011
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	public ClienteDTO getDatosCliente(String codCliente) throws VentasException, RemoteException{
		ClienteDTO clienteDTO = null;
		logger.debug("getDatosCliente():start");
		clienteDTO = getVentasFacade().getDatosCliente(codCliente);
		logger.debug("Numero Identificacion: "+clienteDTO.getNumeroIdentificacion());
		logger.debug("Tipo Identificacion: "+clienteDTO.getCodigoTipoIdentificacion());
		logger.debug("getDatosCliente():end");
		return clienteDTO;
	}
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 16-05-2011
	public boolean validaPassClasificacion(String passCalificacion) throws VentasException, RemoteException{
		logger.debug("validaPassClasificacion():start");
		boolean resultado = false;
		resultado = getVentasFacade().validaPassClasificacion(passCalificacion);
		logger.debug("validaPassClasificacion():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 17-05-2011
	public void insExcepcioCalificacion(String codCliente, String codPlanTarif, String nomUserOra, String codPass, String limiteCredito) throws VentasException, RemoteException{
		logger.debug("insExcepcioCalificacion():start");
		getVentasFacade().insExcepcioCalificacion(codCliente, codPlanTarif, nomUserOra, codPass, limiteCredito);
		logger.debug("insExcepcioCalificacion():end");
	}
	//Fin P-CSR-11002 JLGN 17-05-2011
	
	//Inicio P-CSR-11002 JLGN 26-05-2011
	public DatosContrato obtenerDatosContrato(String numVenta)
	throws VentasException, RemoteException
	{
		logger.debug("obtenerDatosContrato():start");	
		DatosContrato retorno = null;
		try {
			retorno = getVentasFacade().obtenerDatosContrato(numVenta);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerDatosContrato():end");
		return retorno;
	}
	//Fin P-CSR-11002 JLGN 26-05-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011
	public String obtenerDirecPerCli(String codCliente)
	throws VentasException, RemoteException, CustomerDomainException
	{
		logger.debug("obtenerDirecPerCli():start");	
		String retorno;
		try {
			retorno = getVentasFacade().obtenerDirecPerCli(codCliente);
		} catch (VentasException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("VentasException[" + log + "]");
			throw e;
		} catch (RemoteException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerDirecPerCli():end");
		return retorno;
	}
	//Fin P-CSR-11002 JLGN 14-06-2011
	
	//Inicio P-CSR-11002 JLGN 24-06-2011	
	public HashMap cabeceraContrato(DatosContrato datosContrato){
		HashMap params = new HashMap(); //Parametros para el contrato
		
	    logger.debug("Setea Datos a la Variable Params");
	    //Datos Cliente
		params.put("fecVenta",datosContrato.getFecVenta());
		params.put("numVenta",datosContrato.getNumVenta());
		params.put("altaContrato",datosContrato.getAltaContrato());
		params.put("migracion",datosContrato.getMigracion());
		params.put("cambioTitular",datosContrato.getCambioTitular());
		params.put("solicitudPortabilidad",datosContrato.getSolicPortabilidad());
		params.put("codPuntoVenta",datosContrato.getCodPuntoVenta());
		params.put("nomPuntoVenta",datosContrato.getNomPuntoVenta());		
		params.put("tipIdent",datosContrato.getTipIdent());
		params.put("numIdent",datosContrato.getNumIdent());
		params.put("cliParticular",datosContrato.getTipCliParti());
		params.put("cliPyme",datosContrato.getTipCliPyme());
		params.put("cliEmpresa",datosContrato.getTipCliEmpre());
		params.put("apellidosCliente",datosContrato.getApellidosCliente());
		params.put("nomCliente",datosContrato.getNombreCliente());
		params.put("domicilio",datosContrato.getDesDomicilio());
		params.put("provincia",datosContrato.getDesProvincia());
		params.put("canton",datosContrato.getDesCanton());
		params.put("mail",datosContrato.getDesMail());
		params.put("nomRepresentante",datosContrato.getNomRepresentante());
		params.put("tipIdentRepre",datosContrato.getTipIdentRepre());
		params.put("numIdentRepresenta",datosContrato.getNumIdentRepresentante());
		params.put("numMesesContrato",datosContrato.getNumMesesContrato());
		params.put("mensPromSi",datosContrato.getMensPromSi());
		params.put("mensPromNo",datosContrato.getMensPromNo());
		params.put("infTerSI",datosContrato.getInfTerSI());
		params.put("infTerNO",datosContrato.getInfTerNO());
		//Datos Banco Cliente
		params.put("codBanco",datosContrato.getCodBanco());
		params.put("moneda",datosContrato.getMoneda());
		params.put("numCuentaCorriente",datosContrato.getNumCuentaCorriente());
		params.put("entidad",datosContrato.getEntidad());
		params.put("tipTarjeta",datosContrato.getTipTarjeta());
		params.put("numTarjeta",datosContrato.getNumTarjeta());	
		//P-CSR-11002 JLGN 08-11-2011
		String sRutaFirma = System.getProperty("user.dir")  + global.getValorExterno("firma.reporte");
		params.put("rutaFirma",sRutaFirma);
		
		return params;
	}	
	
	public byte[] rellenaFormatoContrato(HashMap params, DatosContrato datosContrato, int guardaRuta) throws Exception{
	try{	
			boolean flag2Hoja = false;
			boolean flagRellena = false;		
			JasperPrint filename = null;
			JasperPrint filename2 = null;
			String sRutaContrato = System.getProperty("user.dir")  + global.getValorExterno("contrato.reporte");		
			
			logger.debug("Ruta Contrato: "+sRutaContrato);
		    File reportFile = new File(sRutaContrato);
		    logger.debug("Estado reporte :Existe="+reportFile.exists()+", Largo="+reportFile.length());
			
			//Contador de PA
			int cantPAL1 = 0;
			int cantPAL2 = 0;
			int cantPAL3 = 0;
			int cantPAL4 = 0;
			//contador de SS
			int cantSSL1 = 0;
			int cantSSL2 = 0;
					
			int cantSSL3 = 0;
			int cantSSL4 = 0;
			
			int cantMayor = 0;
			
			//Son menos de 4 lineas
			logger.debug("Son menos de 4 lineas");
			if (datosContrato.getLineascontrato().length == 1){
				logger.debug("es solo 1 linea");	
				//Linea1
				params.put("numCelular",datosContrato.getLineascontrato()[0].getNumCelular());
				params.put("tipTerminalLinea1",datosContrato.getLineascontrato()[0].getTipTerminal());
				params.put("numImeiLinea1",datosContrato.getLineascontrato()[0].getNumImei());
				params.put("modTerLinea1",datosContrato.getLineascontrato()[0].getDesTerminal());
				params.put("simcardLinea1",datosContrato.getLineascontrato()[0].getNumSerie());
				params.put("planTarifLinea1",datosContrato.getLineascontrato()[0].getPlanTarif());
				params.put("cargoLinea1",datosContrato.getLineascontrato()[0].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea1",datosContrato.getLineascontrato()[0].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea1",datosContrato.getLineascontrato()[0].getLdiSI());
				params.put("ldiNoLinea1",datosContrato.getLineascontrato()[0].getLdiNO());
				//Linea2
				params.put("numCelular2","");
				params.put("tipTerminalLinea2","");
				params.put("numImeiLinea2","");
				params.put("modTerLinea2","");
				params.put("simcardLinea2","");
				params.put("planTarifLinea2","");
				params.put("cargoLinea2","");
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea2","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea2","");
				params.put("ldiNoLinea2","");
				//Linea3
				params.put("numCelular3","");
				params.put("tipTerminalLinea3","");
				params.put("numImeiLinea3","");
				params.put("modTerLinea3","");
				params.put("simcardLinea3","");
				params.put("planTarifLinea3","");
				params.put("cargoLinea3","");
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea3","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea3","");
				params.put("ldiNoLinea3","");
				//Linea4
				params.put("numCelular4","");
				params.put("tipTerminalLinea4","");
				params.put("numImeiLinea4","");
				params.put("modTerLinea4","");
				params.put("simcardLinea4","");
				params.put("planTarifLinea4","");
				params.put("cargoLinea4","");
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea4","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea4","");
				params.put("ldiNoLinea4","");
				
				logger.debug("consulta cantidad de PA por linea");
				cantPAL1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales().length;
				cantSSL1 = datosContrato.getLineascontrato()[0].getServSupl().length;
				cantPAL2 = 0;
				cantSSL2 = 0;
				cantPAL3 = 0;
				cantSSL3 = 0;
				cantPAL4 = 0;
				cantSSL4 = 0;				
			}else if(datosContrato.getLineascontrato().length == 2){
				logger.debug("son 2 lineas");
				//Linea1
				params.put("numCelular",datosContrato.getLineascontrato()[0].getNumCelular());
				params.put("tipTerminalLinea1",datosContrato.getLineascontrato()[0].getTipTerminal());
				params.put("numImeiLinea1",datosContrato.getLineascontrato()[0].getNumImei());
				params.put("modTerLinea1",datosContrato.getLineascontrato()[0].getDesTerminal());
				params.put("simcardLinea1",datosContrato.getLineascontrato()[0].getNumSerie());
				params.put("planTarifLinea1",datosContrato.getLineascontrato()[0].getPlanTarif());
				params.put("cargoLinea1",datosContrato.getLineascontrato()[0].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea1",datosContrato.getLineascontrato()[0].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea1",datosContrato.getLineascontrato()[0].getLdiSI());
				params.put("ldiNoLinea1",datosContrato.getLineascontrato()[0].getLdiNO());
				//Linea2
				params.put("numCelular2",datosContrato.getLineascontrato()[1].getNumCelular());
				params.put("tipTerminalLinea2",datosContrato.getLineascontrato()[1].getTipTerminal());
				params.put("numImeiLinea2",datosContrato.getLineascontrato()[1].getNumImei());
				params.put("modTerLinea2",datosContrato.getLineascontrato()[1].getDesTerminal());
				params.put("simcardLinea2",datosContrato.getLineascontrato()[1].getNumSerie());
				params.put("planTarifLinea2",datosContrato.getLineascontrato()[1].getPlanTarif());
				params.put("cargoLinea2",datosContrato.getLineascontrato()[1].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea2",datosContrato.getLineascontrato()[1].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea2",datosContrato.getLineascontrato()[1].getLdiSI());
				params.put("ldiNoLinea2",datosContrato.getLineascontrato()[1].getLdiNO());
				//Linea3
				params.put("numCelular3","");
				params.put("tipTerminalLinea3","");
				params.put("numImeiLinea3","");
				params.put("modTerLinea3","");
				params.put("simcardLinea3","");
				params.put("planTarifLinea3","");
				params.put("cargoLinea3","");
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea3","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea3","");
				params.put("ldiNoLinea3","");
				//Linea4
				params.put("numCelular4","");
				params.put("tipTerminalLinea4","");
				params.put("numImeiLinea4","");
				params.put("modTerLinea4","");
				params.put("simcardLinea4","");
				params.put("planTarifLinea4","");
				params.put("cargoLinea4","");		
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea4","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea4","");
				params.put("ldiNoLinea4","");
				
				logger.debug("consulta cantidad de PA por linea");
				cantPAL1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales().length;
				cantSSL1 = datosContrato.getLineascontrato()[0].getServSupl().length;
				cantPAL2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales().length;
				cantSSL2 = datosContrato.getLineascontrato()[1].getServSupl().length;
				cantPAL3 = 0;
				cantSSL3 = 0;
				cantPAL4 = 0;
				cantSSL4 = 0;				
			}else if(datosContrato.getLineascontrato().length == 3){
				logger.debug("son 3 lineas");
				//Linea1
				params.put("numCelular",datosContrato.getLineascontrato()[0].getNumCelular());
				params.put("tipTerminalLinea1",datosContrato.getLineascontrato()[0].getTipTerminal());
				params.put("numImeiLinea1",datosContrato.getLineascontrato()[0].getNumImei());
				params.put("modTerLinea1",datosContrato.getLineascontrato()[0].getDesTerminal());
				params.put("simcardLinea1",datosContrato.getLineascontrato()[0].getNumSerie());
				params.put("planTarifLinea1",datosContrato.getLineascontrato()[0].getPlanTarif());
				params.put("cargoLinea1",datosContrato.getLineascontrato()[0].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea1",datosContrato.getLineascontrato()[0].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea1",datosContrato.getLineascontrato()[0].getLdiSI());
				params.put("ldiNoLinea1",datosContrato.getLineascontrato()[0].getLdiNO());
				//Linea2
				params.put("numCelular2",datosContrato.getLineascontrato()[1].getNumCelular());
				params.put("tipTerminalLinea2",datosContrato.getLineascontrato()[1].getTipTerminal());
				params.put("numImeiLinea2",datosContrato.getLineascontrato()[1].getNumImei());
				params.put("modTerLinea2",datosContrato.getLineascontrato()[1].getDesTerminal());
				params.put("simcardLinea2",datosContrato.getLineascontrato()[1].getNumSerie());
				params.put("planTarifLinea2",datosContrato.getLineascontrato()[1].getPlanTarif());
				params.put("cargoLinea2",datosContrato.getLineascontrato()[1].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea2",datosContrato.getLineascontrato()[1].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea2",datosContrato.getLineascontrato()[1].getLdiSI());
				params.put("ldiNoLinea2",datosContrato.getLineascontrato()[1].getLdiNO());
				//Linea3
				params.put("numCelular3",datosContrato.getLineascontrato()[2].getNumCelular());
				params.put("tipTerminalLinea3",datosContrato.getLineascontrato()[2].getTipTerminal());
				params.put("numImeiLinea3",datosContrato.getLineascontrato()[2].getNumImei());
				params.put("modTerLinea3",datosContrato.getLineascontrato()[2].getDesTerminal());
				params.put("simcardLinea3",datosContrato.getLineascontrato()[2].getNumSerie());
				params.put("planTarifLinea3",datosContrato.getLineascontrato()[2].getPlanTarif());
				params.put("cargoLinea3",datosContrato.getLineascontrato()[2].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea3",datosContrato.getLineascontrato()[2].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea3",datosContrato.getLineascontrato()[2].getLdiSI());
				params.put("ldiNoLinea3",datosContrato.getLineascontrato()[2].getLdiNO());
				//Linea4
				params.put("numCelular4","");
				params.put("tipTerminalLinea4","");
				params.put("numImeiLinea4","");
				params.put("modTerLinea4","");
				params.put("simcardLinea4","");
				params.put("planTarifLinea4","");
				params.put("cargoLinea4","");	
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea4","");
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea4","");
				params.put("ldiNoLinea4","");
				
				logger.debug("consulta cantidad de PA por linea");
				cantPAL1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales().length;
				cantSSL1 = datosContrato.getLineascontrato()[0].getServSupl().length;
				cantPAL2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales().length;
				cantSSL2 = datosContrato.getLineascontrato()[1].getServSupl().length;
				cantPAL3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales().length;
				cantSSL3 = datosContrato.getLineascontrato()[2].getServSupl().length;
				cantPAL4 = 0;
				cantSSL4 = 0;
			}else if(datosContrato.getLineascontrato().length == 4){
				logger.debug("son 4 lineas");
				//Linea1
				params.put("numCelular",datosContrato.getLineascontrato()[0].getNumCelular());
				params.put("tipTerminalLinea1",datosContrato.getLineascontrato()[0].getTipTerminal());
				params.put("numImeiLinea1",datosContrato.getLineascontrato()[0].getNumImei());
				params.put("modTerLinea1",datosContrato.getLineascontrato()[0].getDesTerminal());
				params.put("simcardLinea1",datosContrato.getLineascontrato()[0].getNumSerie());
				params.put("planTarifLinea1",datosContrato.getLineascontrato()[0].getPlanTarif());
				params.put("cargoLinea1",datosContrato.getLineascontrato()[0].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea1",datosContrato.getLineascontrato()[0].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea1",datosContrato.getLineascontrato()[0].getLdiSI());
				params.put("ldiNoLinea1",datosContrato.getLineascontrato()[0].getLdiNO());
				//Linea2
				params.put("numCelular2",datosContrato.getLineascontrato()[1].getNumCelular());
				params.put("tipTerminalLinea2",datosContrato.getLineascontrato()[1].getTipTerminal());
				params.put("numImeiLinea2",datosContrato.getLineascontrato()[1].getNumImei());
				params.put("modTerLinea2",datosContrato.getLineascontrato()[1].getDesTerminal());
				params.put("simcardLinea2",datosContrato.getLineascontrato()[1].getNumSerie());
				params.put("planTarifLinea2",datosContrato.getLineascontrato()[1].getPlanTarif());
				params.put("cargoLinea2",datosContrato.getLineascontrato()[1].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea2",datosContrato.getLineascontrato()[1].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea2",datosContrato.getLineascontrato()[1].getLdiSI());
				params.put("ldiNoLinea2",datosContrato.getLineascontrato()[1].getLdiNO());
				//Linea3
				params.put("numCelular3",datosContrato.getLineascontrato()[2].getNumCelular());
				params.put("tipTerminalLinea3",datosContrato.getLineascontrato()[2].getTipTerminal());
				params.put("numImeiLinea3",datosContrato.getLineascontrato()[2].getNumImei());
				params.put("modTerLinea3",datosContrato.getLineascontrato()[2].getDesTerminal());
				params.put("simcardLinea3",datosContrato.getLineascontrato()[2].getNumSerie());
				params.put("planTarifLinea3",datosContrato.getLineascontrato()[2].getPlanTarif());
				params.put("cargoLinea3",datosContrato.getLineascontrato()[2].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea3",datosContrato.getLineascontrato()[2].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea3",datosContrato.getLineascontrato()[2].getLdiSI());
				params.put("ldiNoLinea3",datosContrato.getLineascontrato()[2].getLdiNO());
				//Linea4
				params.put("numCelular4",datosContrato.getLineascontrato()[3].getNumCelular());
				params.put("tipTerminalLinea4",datosContrato.getLineascontrato()[3].getTipTerminal());
				params.put("numImeiLinea4",datosContrato.getLineascontrato()[3].getNumImei());
				params.put("modTerLinea4",datosContrato.getLineascontrato()[3].getDesTerminal());
				params.put("simcardLinea4",datosContrato.getLineascontrato()[3].getNumSerie());
				params.put("planTarifLinea4",datosContrato.getLineascontrato()[3].getPlanTarif());
				params.put("cargoLinea4",datosContrato.getLineascontrato()[3].getCargoPT());
				//P-CSR-11002 JLGN 20-10-2011
				params.put("limiteConsumoLinea4",datosContrato.getLineascontrato()[3].getLimiteConsumoLinea());
				//P-CSR-11002 JLGN 25-10-2011
				params.put("ldiSiLinea4",datosContrato.getLineascontrato()[3].getLdiSI());
				params.put("ldiNoLinea4",datosContrato.getLineascontrato()[3].getLdiNO());
				
				logger.debug("consulta cantidad de PA por linea");
				cantPAL1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales().length;
				cantSSL1 = datosContrato.getLineascontrato()[0].getServSupl().length;
				cantPAL2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales().length;
				cantSSL2 = datosContrato.getLineascontrato()[1].getServSupl().length;
				cantPAL3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales().length;
				cantSSL3 = datosContrato.getLineascontrato()[2].getServSupl().length;
				cantPAL4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales().length;
				cantSSL4 = datosContrato.getLineascontrato()[3].getServSupl().length;
			}			
			
			if(cantPAL1 >= cantPAL2 && cantPAL1 >= cantPAL3 && cantPAL1 >= cantPAL4 &&
					cantPAL1 >= cantSSL1 && cantPAL1 >= cantSSL2 && cantPAL1 >= cantSSL3 && cantPAL1 >= cantSSL4 ){
				logger.debug("PA Linea 1 tiene mas planes");
				cantMayor = cantPAL1; 
			}else if(cantPAL2 >= cantPAL1 && cantPAL2 >= cantPAL3 && cantPAL2 >= cantPAL4 &&
					cantPAL2 >= cantSSL1 && cantPAL2 >= cantSSL2 && cantPAL2 >= cantSSL3 && cantPAL2 >= cantSSL4 ){
				logger.debug("PA Linea 2 tiene mas planes");
				cantMayor = cantPAL2;
			}else if(cantPAL3 >= cantPAL1 && cantPAL3 >= cantPAL2 && cantPAL3 >= cantPAL4 &&
					cantPAL3 >= cantSSL1 && cantPAL3 >= cantSSL2 && cantPAL3 >= cantSSL3 && cantPAL3 >= cantSSL4 ){
				logger.debug("PA Linea 3 tiene mas planes");
				cantMayor = cantPAL3;
			}else if(cantPAL4 >= cantPAL1 && cantPAL4 >= cantPAL2 && cantPAL4 >= cantPAL3 &&
					cantPAL4 >= cantSSL1 && cantPAL4 >= cantSSL2 && cantPAL4 >= cantSSL3 && cantPAL4 >= cantSSL4 ){
				logger.debug("PA Linea 4 tiene mas planes");
				cantMayor = cantPAL4;
			}else if(cantSSL1 >= cantPAL1 && cantSSL1 >= cantPAL2 && cantSSL1 >= cantPAL3 &&
					cantSSL1 >= cantPAL4 && cantSSL1 >= cantSSL2 && cantSSL1 >= cantSSL3 && cantSSL1 >= cantSSL4 ){
				logger.debug("SS Linea 1 tiene mas servicios");
				cantMayor = cantSSL1;
			}else if(cantSSL2 >= cantPAL1 && cantSSL2 >= cantPAL2 && cantSSL2 >= cantPAL3 &&
					cantSSL2 >= cantPAL4 && cantSSL2 >= cantSSL1 && cantSSL2 >= cantSSL3 && cantSSL2 >= cantSSL4 ){
				logger.debug("SS Linea 2 tiene mas servicios");
				cantMayor = cantSSL2;
			}else if(cantSSL3 >= cantPAL1 && cantSSL3 >= cantPAL2 && cantSSL3 >= cantPAL3 &&
					cantSSL3 >= cantPAL4 && cantSSL3 >= cantSSL1 && cantSSL3 >= cantSSL2 && cantSSL3 >= cantSSL4 ){
				logger.debug("SS Linea 3 tiene mas servicios");
				cantMayor = cantSSL3;
			}else if(cantSSL4 >= cantPAL1 && cantSSL4 >= cantPAL2 && cantSSL4 >= cantPAL3 &&
					cantSSL4 >= cantPAL4 && cantSSL4 >= cantSSL1 && cantSSL4 >= cantSSL2 && cantSSL4 >= cantSSL3 ){
				logger.debug("SS Linea 4 tiene mas servicios");
				cantMayor = cantSSL4;
			}
			
			List detalleContrato = new ArrayList();
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(detalleContrato);
			
			//Obtiene Planes Adiacionales de las lineas			
			int auxPAL1 = cantPAL1;
			int aux2PAL1 = 0;
			boolean flagPAL1 = true;
			int auxSSL1 = cantSSL1;
			int aux2SSL1 = 0;
			boolean flagSSL1 = true;			
			
			int auxPAL2 = cantPAL2;
			int aux2PAL2 = 0;
			boolean flagPAL2 = true;
			int auxSSL2 = cantSSL2;
			int aux2SSL2 = 0;
			boolean flagSSL2 = true;
			
			int auxPAL3 = cantPAL3;
			int aux2PAL3 = 0;
			boolean flagPAL3 = true;
			int auxSSL3 = cantSSL3;
			int aux2SSL3 = 0;
			boolean flagSSL3 = true;
			
			int auxPAL4 = cantPAL4;
			int aux2PAL4 = 0;
			boolean flagPAL4 = true;
			int auxSSL4 = cantSSL4;
			int aux2SSL4 = 0;
			boolean flagSSL4 = true;
			
			int cuenta=0;
			
			logger.debug("Cantidad Mayor: "+ cantMayor);
			logger.debug("Obtiene PA de las Lineas");
			
			//while(cuenta <= cantMayor){
			if (cantMayor == 0){
				//No existen PA ni SS opcionales en las lineas				
				params = rellenaSSPAOpcionalesContrato(params);	
				logger.debug("Rellena Primera pagina del contrato");
				filename = JasperFillManager.fillReport(sRutaContrato, params, ds);
			}else{
				while(cuenta < cantMayor){
					//SS Linea 1				
					logger.debug("SS Linea 1");
					if(cantSSL1 != 0){
						if(cantSSL1%2 == 0){
							//Cantidad de SS es Par
							logger.debug("Cantidad de SS es Par");
							if((auxSSL1 - 4 >= 0)&&(flagSSL1)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS();
								String valSS1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS();
								String ss2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS();
								String valSS2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS();
								String ss3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS();
								String valSS3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS();
								String ss4L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getNomSS();
								String valSS4L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getValSS();
								
								params.put("servSup1Linea1",ss1L1);
								params.put("valSS1Linea1",valSS1L1);
								params.put("servSup2Linea1",ss2L1);
								params.put("valSS2Linea1",valSS2L1);
								params.put("servSup3Linea1",ss3L1);
								params.put("valSS3Linea1",valSS3L1);	
								params.put("servSup4Linea1",ss4L1);
								params.put("valSS4Linea1",valSS4L1);	
								
								aux2SSL1 = aux2SSL1 + 4;
								auxSSL1 = auxSSL1 - 4;								
							}else if((auxSSL1 - 2 >= 0)&&(flagSSL1)){
								logger.debug("Quedan 2 SS");
								String ss1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS();
								String valSS1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS();
								String ss2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS();
								String valSS2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS();
								String ss3L1 = "";
								String valSS3L1 = "";
								String ss4L1 = "";
								String valSS4L1 = "";
								
								params.put("servSup1Linea1",ss1L1);
								params.put("valSS1Linea1",valSS1L1);
								params.put("servSup2Linea1",ss2L1);
								params.put("valSS2Linea1",valSS2L1);
								params.put("servSup3Linea1",ss3L1);
								params.put("valSS3Linea1",valSS3L1);	
								params.put("servSup4Linea1",ss4L1);
								params.put("valSS4Linea1",valSS4L1);	
								
								aux2SSL1 = aux2SSL1 + 4;
								auxSSL1 = auxSSL1 - 4;			
								flagSSL1 = false;
							}else{
								logger.debug("SS vacio 1");
								params.put("servSup1Linea1","");
								params.put("valSS1Linea1","");
								params.put("servSup2Linea1","");
								params.put("valSS2Linea1","");
								params.put("servSup3Linea1","");
								params.put("valSS3Linea1","");	
								params.put("servSup4Linea1","");
								params.put("valSS4Linea1","");	
							}						
						}else if(cantSSL1%2 == 1){
							//Cantidad de SS es Impar
							logger.debug("Cantidad de SS es Impar");
							if((auxSSL1 - 4 >= 0)&&(flagSSL1)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS();
								String valSS1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS();
								String ss2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS();
								String valSS2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS();
								String ss3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS();
								String valSS3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS();
								String ss4L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getNomSS();
								String valSS4L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getValSS();
								
								params.put("servSup1Linea1",ss1L1);
								params.put("valSS1Linea1",valSS1L1);
								params.put("servSup2Linea1",ss2L1);
								params.put("valSS2Linea1",valSS2L1);
								params.put("servSup3Linea1",ss3L1);
								params.put("valSS3Linea1",valSS3L1);	
								params.put("servSup4Linea1",ss4L1);
								params.put("valSS4Linea1",valSS4L1);	
								
								aux2SSL1 = aux2SSL1 + 4;
								auxSSL1 = auxSSL1 - 4;								
							}else if((auxSSL1 - 3 >= 0)&&(flagSSL1)){
								logger.debug("Quedan 3 SS");
								String ss1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS();
								String valSS1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS();
								String ss2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS();
								String valSS2L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS();
								String ss3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS();
								String valSS3L1 = datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS();
								String ss4L1 = "";
								String valSS4L1 = "";
								
								params.put("servSup1Linea1",ss1L1);
								params.put("valSS1Linea1",valSS1L1);
								params.put("servSup2Linea1",ss2L1);
								params.put("valSS2Linea1",valSS2L1);
								params.put("servSup3Linea1",ss3L1);
								params.put("valSS3Linea1",valSS3L1);	
								params.put("servSup4Linea1",ss4L1);
								params.put("valSS4Linea1",valSS4L1);	
								
								aux2SSL1 = aux2SSL1 + 4;
								auxSSL1 = auxSSL1 - 4;			
								flagSSL1 = false;
							}else if((auxSSL1 - 1 >= 0)&&(flagSSL1)){
								logger.debug("Queda 1 SS");
								String ss1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS();
								String valSS1L1 = datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS();
								String ss2L1 = "";
								String valSS2L1 = "";
								String ss3L1 = "";
								String valSS3L1 = "";
								String ss4L1 = "";
								String valSS4L1 = "";
								
								params.put("servSup1Linea1",ss1L1);
								params.put("valSS1Linea1",valSS1L1);
								params.put("servSup2Linea1",ss2L1);
								params.put("valSS2Linea1",valSS2L1);
								params.put("servSup3Linea1",ss3L1);
								params.put("valSS3Linea1",valSS3L1);	
								params.put("servSup4Linea1",ss4L1);
								params.put("valSS4Linea1",valSS4L1);	
								
								aux2SSL1 = aux2SSL1 + 4;
								auxSSL1 = auxSSL1 - 4;			
								flagSSL1 = false;
							}else{
								logger.debug("SS vacio 2");
								params.put("servSup1Linea1","");
								params.put("valSS1Linea1","");
								params.put("servSup2Linea1","");
								params.put("valSS2Linea1","");
								params.put("servSup3Linea1","");
								params.put("valSS3Linea1","");	
								params.put("servSup4Linea1","");
								params.put("valSS4Linea1","");	
							}						
						}					
					}else{
						logger.debug("SS vacio 3");
						params.put("servSup1Linea1","");
						params.put("valSS1Linea1","");
						params.put("servSup2Linea1","");
						params.put("valSS2Linea1","");
						params.put("servSup3Linea1","");
						params.put("valSS3Linea1","");	
						params.put("servSup4Linea1","");
						params.put("valSS4Linea1","");	
					}				
					//PA Linea 1				
					if(cantPAL1 != 0){
						if(cantPAL1%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL1 - 4 >= 0)&&(flagPAL1)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi();
								String valPA1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi();
								String pa2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi();
								String valPA2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi();
								String pa3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi();
								String valPA3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi();
								String pa4L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getNomPlanAdi();
								String valPA4L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getValPlanAdi();
								
								params.put("planAdi1Linea1",pa1L1);
								params.put("valPA1Linea1",valPA1L1);
								params.put("planAdi2Linea1",pa2L1);
								params.put("valPA2Linea1",valPA2L1);
								params.put("planAdi3Linea1",pa3L1);
								params.put("valPA3Linea1",valPA3L1);
								params.put("planAdi4Linea1",pa4L1);
								params.put("valPA4Linea1",valPA4L1);
								
								aux2PAL1 = aux2PAL1 + 4;
								auxPAL1 = auxPAL1 - 4;								
							}else if((auxPAL1 - 2 >= 0)&&(flagPAL1)){
								logger.debug("Quedan 2 PA");
								String pa1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi();
								String valPA1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi();
								String pa2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi();
								String valPA2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi();
								String pa3L1 = "";
								String valPA3L1 = "";
								String pa4L1 = "";
								String valPA4L1 = "";
								
								params.put("planAdi1Linea1",pa1L1);
								params.put("valPA1Linea1",valPA1L1);
								params.put("planAdi2Linea1",pa2L1);
								params.put("valPA2Linea1",valPA2L1);
								params.put("planAdi3Linea1",pa3L1);
								params.put("valPA3Linea1",valPA3L1);
								params.put("planAdi4Linea1",pa4L1);
								params.put("valPA4Linea1",valPA4L1);
								
								aux2PAL1 = aux2PAL1 + 4;
								auxPAL1 = auxPAL1 - 4;	
								flagPAL1 = false;
							}else{
								params.put("planAdi1Linea1","");
								params.put("valPA1Linea1","");
								params.put("planAdi2Linea1","");
								params.put("valPA2Linea1","");
								params.put("planAdi3Linea1","");
								params.put("valPA3Linea1","");
								params.put("planAdi4Linea1","");
								params.put("valPA4Linea1","");
							}
							
						}else if(cantPAL1%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL1 - 4 >= 0)&&(flagPAL1)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi();
								String valPA1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi();
								String pa2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi();
								String valPA2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi();
								String pa3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi();
								String valPA3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi();
								String pa4L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getNomPlanAdi();
								String valPA4L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getValPlanAdi();
								
								params.put("planAdi1Linea1",pa1L1);
								params.put("valPA1Linea1",valPA1L1);
								params.put("planAdi2Linea1",pa2L1);
								params.put("valPA2Linea1",valPA2L1);
								params.put("planAdi3Linea1",pa3L1);
								params.put("valPA3Linea1",valPA3L1);
								params.put("planAdi4Linea1",pa4L1);
								params.put("valPA4Linea1",valPA4L1);
								
								aux2PAL1 = aux2PAL1 + 4;
								auxPAL1 = auxPAL1 - 4;								
							}else if((auxPAL1 - 3 >= 0)&&(flagPAL1)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								String pa1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi();
								String valPA1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi();
								String pa2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi();
								String valPA2L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi();
								String pa3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi();
								String valPA3L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi();
								String pa4L1 = "";
								String valPA4L1 = "";
								
								params.put("planAdi1Linea1",pa1L1);
								params.put("valPA1Linea1",valPA1L1);
								params.put("planAdi2Linea1",pa2L1);
								params.put("valPA2Linea1",valPA2L1);
								params.put("planAdi3Linea1",pa3L1);
								params.put("valPA3Linea1",valPA3L1);
								params.put("planAdi4Linea1",pa4L1);
								params.put("valPA4Linea1",valPA4L1);
								
								aux2PAL1 = aux2PAL1 + 4;
								auxPAL1 = auxPAL1 - 4;			
								flagPAL1 = false;
							}else if((auxPAL1 - 1 >= 0)&&(flagPAL1)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								String pa1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi();
								String valPA1L1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi();
								String pa2L1 = "";
								String valPA2L1 = "";
								String pa3L1 = "";
								String valPA3L1 = "";
								String pa4L1 = "";
								String valPA4L1 = "";
								
								params.put("planAdi1Linea1",pa1L1);
								params.put("valPA1Linea1",valPA1L1);
								params.put("planAdi2Linea1",pa2L1);
								params.put("valPA2Linea1",valPA2L1);
								params.put("planAdi3Linea1",pa3L1);
								params.put("valPA3Linea1",valPA3L1);
								params.put("planAdi4Linea1",pa4L1);
								params.put("valPA4Linea1",valPA4L1);
								
								aux2PAL1 = aux2PAL1 + 4;
								auxPAL1 = auxPAL1 - 4;			
								flagPAL1 = false;
							}else{
								params.put("planAdi1Linea1","");
								params.put("valPA1Linea1","");
								params.put("planAdi2Linea1","");
								params.put("valPA2Linea1","");
								params.put("planAdi3Linea1","");
								params.put("valPA3Linea1","");
								params.put("planAdi4Linea1","");
								params.put("valPA4Linea1","");	
							}						
						}					
					}else{
						params.put("planAdi1Linea1","");
						params.put("valPA1Linea1","");
						params.put("planAdi2Linea1","");
						params.put("valPA2Linea1","");
						params.put("planAdi3Linea1","");
						params.put("valPA3Linea1","");
						params.put("planAdi4Linea1","");
						params.put("valPA4Linea1","");
					}				
					//SS Linea 2				
					if(cantSSL2 != 0){
						if(cantSSL2%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL2 - 4 >= 0)&&(flagSSL2)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS();
								String valSS1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS();
								String ss2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS();
								String valSS2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS();
								String ss3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS();
								String valSS3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS();
								String ss4L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getNomSS();
								String valSS4L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getValSS();
								
								params.put("servSup1Linea2",ss1L2);
								params.put("valSS1Linea2",valSS1L2);
								params.put("servSup2Linea2",ss2L2);
								params.put("valSS2Linea2",valSS2L2);
								params.put("servSup3Linea2",ss3L2);
								params.put("valSS3Linea2",valSS3L2);	
								params.put("servSup4Linea2",ss4L2);
								params.put("valSS4Linea2",valSS4L2);	
								
								aux2SSL2 = aux2SSL2 + 4;
								auxSSL2 = auxSSL2 - 4;								
							}else if((auxSSL2 - 2 >= 0)&&(flagSSL2)){
								logger.debug("Quedan 2 SS");
								String ss1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS();
								String valSS1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS();
								String ss2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS();
								String valSS2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS();
								String ss3L2 = "";
								String valSS3L2 = "";
								String ss4L2 = "";
								String valSS4L2 = "";
								
								params.put("servSup1Linea2",ss1L2);
								params.put("valSS1Linea2",valSS1L2);
								params.put("servSup2Linea2",ss2L2);
								params.put("valSS2Linea2",valSS2L2);
								params.put("servSup3Linea2",ss3L2);
								params.put("valSS3Linea2",valSS3L2);	
								params.put("servSup4Linea2",ss4L2);
								params.put("valSS4Linea2",valSS4L2);	
								
								aux2SSL2 = aux2SSL2 + 4;
								auxSSL2 = auxSSL2 - 4;			
								flagSSL2 = false;
							}else{
								params.put("servSup1Linea2","");
								params.put("valSS1Linea2","");
								params.put("servSup2Linea2","");
								params.put("valSS2Linea2","");
								params.put("servSup3Linea2","");
								params.put("valSS3Linea2","");	
								params.put("servSup4Linea2","");
								params.put("valSS4Linea2","");	
							}						
						}else if(cantSSL2%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL2 - 4 >= 0)&&(flagSSL2)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS();
								String valSS1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS();
								String ss2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS();
								String valSS2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS();
								String ss3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS();
								String valSS3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS();
								String ss4L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getNomSS();
								String valSS4L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getValSS();
								
								params.put("servSup1Linea2",ss1L2);
								params.put("valSS1Linea2",valSS1L2);
								params.put("servSup2Linea2",ss2L2);
								params.put("valSS2Linea2",valSS2L2);
								params.put("servSup3Linea2",ss3L2);
								params.put("valSS3Linea2",valSS3L2);	
								params.put("servSup4Linea2",ss4L2);
								params.put("valSS4Linea2",valSS4L2);	
								
								aux2SSL2 = aux2SSL2 + 4;
								auxSSL2 = auxSSL2 - 4;								
							}else if((auxSSL2 - 3 >= 0)&&(flagSSL2)){
								//Quedan 3 SS
								logger.debug("Quedan 3 SS");
								String ss1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS();
								String valSS1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS();
								String ss2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS();
								String valSS2L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS();
								String ss3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS();
								String valSS3L2 = datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS();
								String ss4L2 = "";
								String valSS4L2 = "";
								
								params.put("servSup1Linea2",ss1L2);
								params.put("valSS1Linea2",valSS1L2);
								params.put("servSup2Linea2",ss2L2);
								params.put("valSS2Linea2",valSS2L2);
								params.put("servSup3Linea2",ss3L2);
								params.put("valSS3Linea2",valSS3L2);	
								params.put("servSup4Linea2",ss4L2);
								params.put("valSS4Linea2",valSS4L2);	
								
								aux2SSL2 = aux2SSL2 + 4;
								auxSSL2 = auxSSL2 - 4;	
								flagSSL2 = false;
							}else if((auxSSL2 - 1 >= 0)&&(flagSSL2)){
								logger.debug("Queda 1");
								String ss1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS();
								String valSS1L2 = datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS();
								String ss2L2 = "";
								String valSS2L2 = "";
								String ss3L2 = "";
								String valSS3L2 = "";
								String ss4L2 = "";
								String valSS4L2 = "";
								
								params.put("servSup1Linea2",ss1L2);
								params.put("valSS1Linea2",valSS1L2);
								params.put("servSup2Linea2",ss2L2);
								params.put("valSS2Linea2",valSS2L2);
								params.put("servSup3Linea2",ss3L2);
								params.put("valSS3Linea2",valSS3L2);	
								params.put("servSup4Linea2",ss4L2);
								params.put("valSS4Linea2",valSS4L2);	
								
								aux2SSL2 = aux2SSL2 + 4;
								auxSSL2 = auxSSL2 - 4;	
								flagSSL2 = false;
							}else{
								params.put("servSup1Linea2","");
								params.put("valSS1Linea2","");
								params.put("servSup2Linea2","");
								params.put("valSS2Linea2","");
								params.put("servSup3Linea2","");
								params.put("valSS3Linea2","");	
								params.put("servSup4Linea2","");
								params.put("valSS4Linea2","");		
							}						
						}					
					}else{
						params.put("servSup1Linea2","");
						params.put("valSS1Linea2","");
						params.put("servSup2Linea2","");
						params.put("valSS2Linea2","");
						params.put("servSup3Linea2","");
						params.put("valSS3Linea2","");	
						params.put("servSup4Linea2","");
						params.put("valSS4Linea2","");	
					}				
					//PA Linea 2			
					if(cantPAL2 != 0){
						if(cantPAL2%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL2 - 4 >= 0)&&(flagPAL2)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi();
								String valPA1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi();
								String pa2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi();
								String valPA2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi();
								String pa3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi();
								String valPA3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi();
								String pa4L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getNomPlanAdi();
								String valPA4L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getValPlanAdi();
								
								params.put("planAdi1Linea2",pa1L2);
								params.put("valPA1Linea2",valPA1L2);
								params.put("planAdi2Linea2",pa2L2);
								params.put("valPA2Linea2",valPA2L2);
								params.put("planAdi3Linea2",pa3L2);
								params.put("valPA3Linea2",valPA3L2);
								params.put("planAdi4Linea2",pa4L2);
								params.put("valPA4Linea2",valPA4L2);
								
								aux2PAL2 = aux2PAL2 + 4;
								auxPAL2 = auxPAL2 - 4;								
							}else if((auxPAL2 - 2 >= 0)&&(flagPAL2)){
								logger.debug("Quedan 2 PA");
								String pa1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi();
								String valPA1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi();
								String pa2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi();
								String valPA2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi();
								String pa3L2 = "";
								String valPA3L2 = "";
								String pa4L2 = "";
								String valPA4L2 = "";
								
								params.put("planAdi1Linea2",pa1L2);
								params.put("valPA1Linea2",valPA1L2);
								params.put("planAdi2Linea2",pa2L2);
								params.put("valPA2Linea2",valPA2L2);
								params.put("planAdi3Linea2",pa3L2);
								params.put("valPA3Linea2",valPA3L2);
								params.put("planAdi4Linea2",pa4L2);
								params.put("valPA4Linea2",valPA4L2);
								
								aux2PAL2 = aux2PAL2 + 4;
								auxPAL2 = auxPAL2 - 4;	
								flagPAL2 = false;
							}else{
								params.put("planAdi1Linea2","");
								params.put("valPA1Linea2","");
								params.put("planAdi2Linea2","");
								params.put("valPA2Linea2","");
								params.put("planAdi3Linea2","");
								params.put("valPA3Linea2","");
								params.put("planAdi4Linea2","");
								params.put("valPA4Linea2","");
							}						
						}else if(cantPAL2%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL2 - 4 >= 0)&&(flagPAL2)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi();
								String valPA1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi();
								String pa2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi();
								String valPA2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi();
								String pa3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi();
								String valPA3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi();
								String pa4L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getNomPlanAdi();
								String valPA4L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getValPlanAdi();
								
								params.put("planAdi1Linea2",pa1L2);
								params.put("valPA1Linea2",valPA1L2);
								params.put("planAdi2Linea2",pa2L2);
								params.put("valPA2Linea2",valPA2L2);
								params.put("planAdi3Linea2",pa3L2);
								params.put("valPA3Linea2",valPA3L2);
								params.put("planAdi4Linea2",pa4L2);
								params.put("valPA4Linea2",valPA4L2);
								
								aux2PAL2 = aux2PAL2 + 4;
								auxPAL2 = auxPAL2 - 4;								
							}else if((auxPAL2 - 3 >= 0)&&(flagPAL2)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								String pa1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi();
								String valPA1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi();
								String pa2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi();
								String valPA2L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi();
								String pa3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi();
								String valPA3L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi();
								String pa4L2 = "";
								String valPA4L2 = "";
								
								params.put("planAdi1Linea2",pa1L2);
								params.put("valPA1Linea2",valPA1L2);
								params.put("planAdi2Linea2",pa2L2);
								params.put("valPA2Linea2",valPA2L2);
								params.put("planAdi3Linea2",pa3L2);
								params.put("valPA3Linea2",valPA3L2);
								params.put("planAdi4Linea2",pa4L2);
								params.put("valPA4Linea2",valPA4L2);
								
								aux2PAL2 = aux2PAL2 + 4;
								auxPAL2 = auxPAL2 - 4;	
								flagPAL2 = false;
							}else if((auxPAL2 - 1 >= 0)&&(flagPAL2)){
								//Queda 1 PA
								String pa1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi();
								String valPA1L2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi();
								String pa2L2 = "";
								String valPA2L2 = "";
								String pa3L2 = "";
								String valPA3L2 = "";
								String pa4L2 = "";
								String valPA4L2 = "";
								
								params.put("planAdi1Linea2",pa1L2);
								params.put("valPA1Linea2",valPA1L2);
								params.put("planAdi2Linea2",pa2L2);
								params.put("valPA2Linea2",valPA2L2);
								params.put("planAdi3Linea2",pa3L2);
								params.put("valPA3Linea2",valPA3L2);
								params.put("planAdi4Linea2",pa4L2);
								params.put("valPA4Linea2",valPA4L2);
								
								aux2PAL2 = aux2PAL2 + 4;
								auxPAL2 = auxPAL2 - 4;	
								flagPAL2 = false;
							}else{
								params.put("planAdi1Linea2","");
								params.put("valPA1Linea2","");
								params.put("planAdi2Linea2","");
								params.put("valPA2Linea2","");
								params.put("planAdi3Linea2","");
								params.put("valPA3Linea2","");
								params.put("planAdi4Linea2","");
								params.put("valPA4Linea2","");
							}						
						}					
					}else{
						params.put("planAdi1Linea2","");
						params.put("valPA1Linea2","");
						params.put("planAdi2Linea2","");
						params.put("valPA2Linea2","");
						params.put("planAdi3Linea2","");
						params.put("valPA3Linea2","");
						params.put("planAdi4Linea2","");
						params.put("valPA4Linea2","");
					}				
					//SS Linea 3				
					if(cantSSL3 != 0){
						if(cantSSL3%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL3 - 4 >= 0)&&(flagSSL3)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS();
								String valSS1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS();
								String ss2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS();
								String valSS2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS();
								String ss3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS();
								String valSS3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS();
								String ss4L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getNomSS();
								String valSS4L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getValSS();
								
								params.put("servSup1Linea3",ss1L3);
								params.put("valSS1Linea3",valSS1L3);
								params.put("servSup2Linea3",ss2L3);
								params.put("valSS2Linea3",valSS2L3);
								params.put("servSup3Linea3",ss3L3);
								params.put("valSS3Linea3",valSS3L3);	
								params.put("servSup4Linea3",ss4L3);
								params.put("valSS4Linea3",valSS4L3);	
								
								aux2SSL3 = aux2SSL3 + 4;
								auxSSL3 = auxSSL3 - 4;								
							}else if((auxSSL3 - 2 >= 0)&&(flagSSL3)){
								logger.debug("Quedan 2 SS");
								String ss1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS();
								String valSS1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS();
								String ss2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS();
								String valSS2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS();
								String ss3L3 = "";
								String valSS3L3 = "";
								String ss4L3 = "";
								String valSS4L3 = "";
								
								params.put("servSup1Linea3",ss1L3);
								params.put("valSS1Linea3",valSS1L3);
								params.put("servSup2Linea3",ss2L3);
								params.put("valSS2Linea3",valSS2L3);
								params.put("servSup3Linea3",ss3L3);
								params.put("valSS3Linea3",valSS3L3);	
								params.put("servSup4Linea3",ss4L3);
								params.put("valSS4Linea3",valSS4L3);	
								
								aux2SSL3 = aux2SSL3 + 4;
								auxSSL3 = auxSSL3 - 4;	
								flagSSL3 = false;
							}else{
								params.put("servSup1Linea3","");
								params.put("valSS1Linea3","");
								params.put("servSup2Linea3","");
								params.put("valSS2Linea3","");
								params.put("servSup3Linea3","");
								params.put("valSS3Linea3","");	
								params.put("servSup4Linea3","");
								params.put("valSS4Linea3","");	
							}						
						}else if(cantSSL3%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL3 - 4 >= 0)&&(flagSSL3)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS();
								String valSS1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS();
								String ss2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS();
								String valSS2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS();
								String ss3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS();
								String valSS3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS();
								String ss4L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getNomSS();
								String valSS4L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getValSS();
								
								params.put("servSup1Linea3",ss1L3);
								params.put("valSS1Linea3",valSS1L3);
								params.put("servSup2Linea3",ss2L3);
								params.put("valSS2Linea3",valSS2L3);
								params.put("servSup3Linea3",ss3L3);
								params.put("valSS3Linea3",valSS3L3);	
								params.put("servSup4Linea3",ss4L3);
								params.put("valSS4Linea3",valSS4L3);	
								
								aux2SSL3 = aux2SSL3 + 4;
								auxSSL3 = auxSSL3 - 4;								
							}else if((auxSSL3 - 3 >= 0)&&(flagSSL3)){
								//Quedan 3 SS
								logger.debug("Quedan 3 SS");
								String ss1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS();
								String valSS1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS();
								String ss2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS();
								String valSS2L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS();
								String ss3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS();
								String valSS3L3 = datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS();
								String ss4L3 = "";
								String valSS4L3 = "";
								
								params.put("servSup1Linea3",ss1L3);
								params.put("valSS1Linea3",valSS1L3);
								params.put("servSup2Linea3",ss2L3);
								params.put("valSS2Linea3",valSS2L3);
								params.put("servSup3Linea3",ss3L3);
								params.put("valSS3Linea3",valSS3L3);	
								params.put("servSup4Linea3",ss4L3);
								params.put("valSS4Linea3",valSS4L3);	
								
								aux2SSL3 = aux2SSL3 + 4;
								auxSSL3 = auxSSL3 - 4;	
								flagSSL3 = false;
							}else if((auxSSL3 - 1 >= 0)&&(flagSSL3)){
								logger.debug("Queda 1");
								String ss1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS();
								String valSS1L3 = datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS();
								String ss2L3 = "";
								String valSS2L3 = "";
								String ss3L3 = "";
								String valSS3L3 = "";
								String ss4L3 = "";
								String valSS4L3 = "";
								
								params.put("servSup1Linea3",ss1L3);
								params.put("valSS1Linea3",valSS1L3);
								params.put("servSup2Linea3",ss2L3);
								params.put("valSS2Linea3",valSS2L3);
								params.put("servSup3Linea3",ss3L3);
								params.put("valSS3Linea3",valSS3L3);	
								params.put("servSup4Linea3",ss4L3);
								params.put("valSS4Linea3",valSS4L3);	
								
								aux2SSL3 = aux2SSL3 + 4;
								auxSSL3 = auxSSL3 - 4;	
								flagSSL3 = false;
							}else{
								params.put("servSup1Linea3","");
								params.put("valSS1Linea3","");
								params.put("servSup2Linea3","");
								params.put("valSS2Linea3","");
								params.put("servSup3Linea3","");
								params.put("valSS3Linea3","");	
								params.put("servSup4Linea3","");
								params.put("valSS4Linea3","");	
							}						
						}					
					}else{
						params.put("servSup1Linea3","");
						params.put("valSS1Linea3","");
						params.put("servSup2Linea3","");
						params.put("valSS2Linea3","");
						params.put("servSup3Linea3","");
						params.put("valSS3Linea3","");	
						params.put("servSup4Linea3","");
						params.put("valSS4Linea3","");
					}				
					//PA Linea 3		
					if(cantPAL3 != 0){
						if(cantPAL3%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL3 - 4 >= 0)&&(flagPAL3)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi();
								String valPA1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi();
								String pa2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi();
								String valPA2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi();
								String pa3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi();
								String valPA3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi();
								String pa4L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getNomPlanAdi();
								String valPA4L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getValPlanAdi();
								
								params.put("planAdi1Linea3",pa1L3);
								params.put("valPA1Linea3",valPA1L3);
								params.put("planAdi2Linea3",pa2L3);
								params.put("valPA2Linea3",valPA2L3);
								params.put("planAdi3Linea3",pa3L3);
								params.put("valPA3Linea3",valPA3L3);
								params.put("planAdi4Linea3",pa4L3);
								params.put("valPA4Linea3",valPA4L3);
								
								aux2PAL3 = aux2PAL3 + 4;
								auxPAL3 = auxPAL3 - 4;								
							}else if((auxPAL3 - 2 >= 0)&&(flagPAL3)){
								logger.debug("Quedan 2 PA");
								String pa1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi();
								String valPA1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi();
								String pa2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi();
								String valPA2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi();
								String pa3L3 = "";
								String valPA3L3 = "";
								String pa4L3 = "";
								String valPA4L3 = "";
								
								params.put("planAdi1Linea3",pa1L3);
								params.put("valPA1Linea3",valPA1L3);
								params.put("planAdi2Linea3",pa2L3);
								params.put("valPA2Linea3",valPA2L3);
								params.put("planAdi3Linea3",pa3L3);
								params.put("valPA3Linea3",valPA3L3);
								params.put("planAdi4Linea3",pa4L3);
								params.put("valPA4Linea3",valPA4L3);
								
								aux2PAL3 = aux2PAL3 + 4;
								auxPAL3 = auxPAL3 - 4;	
								flagPAL3 = false;
							}else{
								params.put("planAdi1Linea3","");
								params.put("valPA1Linea3","");
								params.put("planAdi2Linea3","");
								params.put("valPA2Linea3","");
								params.put("planAdi3Linea3","");
								params.put("valPA3Linea3","");
								params.put("planAdi4Linea3","");
								params.put("valPA4Linea3","");
							}						
						}else if(cantPAL3%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL3 - 4 >= 0)&&(flagPAL3)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi();
								String valPA1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi();
								String pa2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi();
								String valPA2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi();
								String pa3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi();
								String valPA3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi();
								String pa4L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getNomPlanAdi();
								String valPA4L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getValPlanAdi();
								
								params.put("planAdi1Linea3",pa1L3);
								params.put("valPA1Linea3",valPA1L3);
								params.put("planAdi2Linea3",pa2L3);
								params.put("valPA2Linea3",valPA2L3);
								params.put("planAdi3Linea3",pa3L3);
								params.put("valPA3Linea3",valPA3L3);
								params.put("planAdi4Linea3",pa4L3);
								params.put("valPA4Linea3",valPA4L3);
								
								aux2PAL3 = aux2PAL3 + 4;
								auxPAL3 = auxPAL3 - 4;								
							}else if((auxPAL3 - 3 >= 0)&&(flagPAL3)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								String pa1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi();
								String valPA1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi();
								String pa2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi();
								String valPA2L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi();
								String pa3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi();
								String valPA3L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi();
								String pa4L3 = "";
								String valPA4L3 = "";
								
								params.put("planAdi1Linea3",pa1L3);
								params.put("valPA1Linea3",valPA1L3);
								params.put("planAdi2Linea3",pa2L3);
								params.put("valPA2Linea3",valPA2L3);
								params.put("planAdi3Linea3",pa3L3);
								params.put("valPA3Linea3",valPA3L3);
								params.put("planAdi4Linea3",pa4L3);
								params.put("valPA4Linea3",valPA4L3);
								
								aux2PAL3 = aux2PAL3 + 4;
								auxPAL3 = auxPAL3 - 4;	
								flagPAL3 = false;
							}else if((auxPAL3 - 1 >= 0)&&(flagPAL3)){
								//Queda 1 PA
								String pa1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi();
								String valPA1L3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi();
								String pa2L3 = "";
								String valPA2L3 = "";
								String pa3L3 = "";
								String valPA3L3 = "";
								String pa4L3 = "";
								String valPA4L3 = "";
								
								params.put("planAdi1Linea3",pa1L3);
								params.put("valPA1Linea3",valPA1L3);
								params.put("planAdi2Linea3",pa2L3);
								params.put("valPA2Linea3",valPA2L3);
								params.put("planAdi3Linea3",pa3L3);
								params.put("valPA3Linea3",valPA3L3);
								params.put("planAdi4Linea3",pa4L3);
								params.put("valPA4Linea3",valPA4L3);
								
								aux2PAL3 = aux2PAL3 + 4;
								auxPAL3 = auxPAL3 - 4;	
								flagPAL3 = false;
							}else{
								params.put("planAdi1Linea3","");
								params.put("valPA1Linea3","");
								params.put("planAdi2Linea3","");
								params.put("valPA2Linea3","");
								params.put("planAdi3Linea3","");
								params.put("valPA3Linea3","");
								params.put("planAdi4Linea3","");
								params.put("valPA4Linea3","");
							}						
						}					
					}else{
						params.put("planAdi1Linea3","");
						params.put("valPA1Linea3","");
						params.put("planAdi2Linea3","");
						params.put("valPA2Linea3","");
						params.put("planAdi3Linea3","");
						params.put("valPA3Linea3","");
						params.put("planAdi4Linea3","");
						params.put("valPA4Linea3","");
					}				
					//SS Linea 4				
					if(cantSSL4 != 0){
						if(cantSSL4%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL4 - 4 >= 0)&&(flagSSL4)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS();
								String valSS1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS();
								String ss2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS();
								String valSS2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS();
								String ss3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS();
								String valSS3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS();
								String ss4L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getNomSS();
								String valSS4L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getValSS();
								
								params.put("servSup1Linea4",ss1L4);
								params.put("valSS1Linea4",valSS1L4);
								params.put("servSup2Linea4",ss2L4);
								params.put("valSS2Linea4",valSS2L4);
								params.put("servSup3Linea4",ss3L4);
								params.put("valSS3Linea4",valSS3L4);	
								params.put("servSup4Linea4",ss4L4);
								params.put("valSS4Linea4",valSS4L4);	
								
								aux2SSL4 = aux2SSL4 + 4;
								auxSSL4 = auxSSL4 - 4;							
							}else if((auxSSL4 - 2 >= 0)&&(flagSSL4)){
								logger.debug("Quedan 2 SS");
								String ss1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS();
								String valSS1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS();
								String ss2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS();
								String valSS2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS();
								String ss3L4 = "";
								String valSS3L4 = "";
								String ss4L4 = "";
								String valSS4L4 = "";
								
								params.put("servSup1Linea4",ss1L4);
								params.put("valSS1Linea4",valSS1L4);
								params.put("servSup2Linea4",ss2L4);
								params.put("valSS2Linea4",valSS2L4);
								params.put("servSup3Linea4",ss3L4);
								params.put("valSS3Linea4",valSS3L4);	
								params.put("servSup4Linea4",ss4L4);
								params.put("valSS4Linea4",valSS4L4);	
								
								aux2SSL4 = aux2SSL4 + 4;
								auxSSL4 = auxSSL4 - 4;	
								flagSSL4 = false;
							}else{
								params.put("servSup1Linea4","");
								params.put("valSS1Linea4","");
								params.put("servSup2Linea4","");
								params.put("valSS2Linea4","");
								params.put("servSup3Linea4","");
								params.put("valSS3Linea4","");	
								params.put("servSup4Linea4","");
								params.put("valSS4Linea4","");	
							}						
						}else if(cantSSL4%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL4 - 4 >= 0)&&(flagSSL4)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								String ss1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS();
								String valSS1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS();
								String ss2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS();
								String valSS2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS();
								String ss3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS();
								String valSS3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS();
								String ss4L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getNomSS();
								String valSS4L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getValSS();
								
								params.put("servSup1Linea4",ss1L4);
								params.put("valSS1Linea4",valSS1L4);
								params.put("servSup2Linea4",ss2L4);
								params.put("valSS2Linea4",valSS2L4);
								params.put("servSup3Linea4",ss3L4);
								params.put("valSS3Linea4",valSS3L4);	
								params.put("servSup4Linea4",ss4L4);
								params.put("valSS4Linea4",valSS4L4);	
								
								aux2SSL4 = aux2SSL4 + 4;
								auxSSL4 = auxSSL4 - 4;								
							}else if((auxSSL4 - 3 >= 0)&&(flagSSL4)){
								//Quedan 3 SS
								logger.debug("Quedan 3 SS");
								String ss1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS();
								String valSS1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS();
								String ss2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS();
								String valSS2L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS();
								String ss3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS();
								String valSS3L4 = datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS();
								String ss4L4 = "";
								String valSS4L4 = "";
								
								params.put("servSup1Linea4",ss1L4);
								params.put("valSS1Linea4",valSS1L4);
								params.put("servSup2Linea4",ss2L4);
								params.put("valSS2Linea4",valSS2L4);
								params.put("servSup3Linea4",ss3L4);
								params.put("valSS3Linea4",valSS3L4);	
								params.put("servSup4Linea4",ss4L4);
								params.put("valSS4Linea4",valSS4L4);	
								
								aux2SSL4 = aux2SSL4 + 4;
								auxSSL4 = auxSSL4 - 4;	
								flagSSL4 = false;
							}else if((auxSSL4 - 1 >= 0)&&(flagSSL4)){
								logger.debug("Queda 1");
								String ss1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS();
								String valSS1L4 = datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS();
								String ss2L4 = "";
								String valSS2L4 = "";
								String ss3L4 = "";
								String valSS3L4 = "";
								String ss4L4 = "";
								String valSS4L4 = "";
								
								params.put("servSup1Linea4",ss1L4);
								params.put("valSS1Linea4",valSS1L4);
								params.put("servSup2Linea4",ss2L4);
								params.put("valSS2Linea4",valSS2L4);
								params.put("servSup3Linea4",ss3L4);
								params.put("valSS3Linea4",valSS3L4);	
								params.put("servSup4Linea4",ss4L4);
								params.put("valSS4Linea4",valSS4L4);	
								
								aux2SSL4 = aux2SSL4 + 4;
								auxSSL4 = auxSSL4 - 4;	
								flagSSL4 = false;
							}else{
								params.put("servSup1Linea4","");
								params.put("valSS1Linea4","");
								params.put("servSup2Linea4","");
								params.put("valSS2Linea4","");
								params.put("servSup3Linea4","");
								params.put("valSS3Linea4","");	
								params.put("servSup4Linea4","");
								params.put("valSS4Linea4","");	
							}						
						}					
					}else{
						params.put("servSup1Linea4","");
						params.put("valSS1Linea4","");
						params.put("servSup2Linea4","");
						params.put("valSS2Linea4","");
						params.put("servSup3Linea4","");
						params.put("valSS3Linea4","");	
						params.put("servSup4Linea4","");
						params.put("valSS4Linea4","");
					}				
					//PA Linea 4		
					if(cantPAL4 != 0){
						if(cantPAL4%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL4 - 4 >= 0)&&(flagPAL4)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								String pa1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi();
								String valPA1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi();
								String pa2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi();
								String valPA2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi();
								String pa3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi();
								String valPA3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi();
								String pa4L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getNomPlanAdi();
								String valPA4L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getValPlanAdi();
								
								params.put("planAdi1Linea4",pa1L4);
								params.put("valPA1Linea4",valPA1L4);
								params.put("planAdi2Linea4",pa2L4);
								params.put("valPA2Linea4",valPA2L4);
								params.put("planAdi3Linea4",pa3L4);
								params.put("valPA3Linea4",valPA3L4);
								params.put("planAdi4Linea4",pa4L4);
								params.put("valPA4Linea4",valPA4L4);
								
								aux2PAL4 = aux2PAL4 + 4;
								auxPAL4 = auxPAL4 - 4;								
							}else if((auxPAL4 - 2 >= 0)&&(flagPAL4)){
								logger.debug("Quedan 2 PA");
								String pa1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi();
								String valPA1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi();
								String pa2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi();
								String valPA2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi();
								String pa3L4 = "";
								String valPA3L4 = "";
								String pa4L4 = "";
								String valPA4L4 = "";
								
								params.put("planAdi1Linea4",pa1L4);
								params.put("valPA1Linea4",valPA1L4);
								params.put("planAdi2Linea4",pa2L4);
								params.put("valPA2Linea4",valPA2L4);
								params.put("planAdi3Linea4",pa3L4);
								params.put("valPA3Linea4",valPA3L4);
								params.put("planAdi4Linea4",pa4L4);
								params.put("valPA4Linea4",valPA4L4);
								
								aux2PAL4 = aux2PAL4 + 4;
								auxPAL4 = auxPAL4 - 4;	
								flagPAL4 = false;
							}else{
								params.put("planAdi1Linea4","");
								params.put("valPA1Linea4","");
								params.put("planAdi2Linea4","");
								params.put("valPA2Linea4","");
								params.put("planAdi3Linea4","");
								params.put("valPA3Linea4","");
								params.put("planAdi4Linea4","");
								params.put("valPA4Linea4","");
							}						
						}else if(cantPAL4%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL4 - 4 >= 0)&&(flagPAL4)){
								//Quedan 4 PA o mas
								String pa1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi();
								String valPA1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi();
								String pa2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi();
								String valPA2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi();
								String pa3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi();
								String valPA3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi();
								String pa4L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getNomPlanAdi();
								String valPA4L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getValPlanAdi();
								
								params.put("planAdi1Linea4",pa1L4);
								params.put("valPA1Linea4",valPA1L4);
								params.put("planAdi2Linea4",pa2L4);
								params.put("valPA2Linea4",valPA2L4);
								params.put("planAdi3Linea4",pa3L4);
								params.put("valPA3Linea4",valPA3L4);
								params.put("planAdi4Linea4",pa4L4);
								params.put("valPA4Linea4",valPA4L4);
								
								aux2PAL4 = aux2PAL4 + 4;
								auxPAL4 = auxPAL4 - 4;								
							}else if((auxPAL4 - 3 >= 0)&&(flagPAL4)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								String pa1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi();
								String valPA1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi();
								String pa2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi();
								String valPA2L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi();
								String pa3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi();
								String valPA3L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi();
								String pa4L4 = "";
								String valPA4L4 = "";
								
								params.put("planAdi1Linea4",pa1L4);
								params.put("valPA1Linea4",valPA1L4);
								params.put("planAdi2Linea4",pa2L4);
								params.put("valPA2Linea4",valPA2L4);
								params.put("planAdi3Linea4",pa3L4);
								params.put("valPA3Linea4",valPA3L4);
								params.put("planAdi4Linea4",pa4L4);
								params.put("valPA4Linea4",valPA4L4);
								
								aux2PAL4 = aux2PAL4 + 4;
								auxPAL4 = auxPAL4 - 4;	
								flagPAL4 = false;
							}else if((auxPAL4 - 1 >= 0)&&(flagPAL4)){
								//Queda 1 PA
								String pa1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi();
								String valPA1L4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi();
								String pa2L4 = "";
								String valPA2L4 = "";
								String pa3L4 = "";
								String valPA3L4 = "";
								String pa4L4 = "";
								String valPA4L4 = "";
								
								params.put("planAdi1Linea4",pa1L4);
								params.put("valPA1Linea4",valPA1L4);
								params.put("planAdi2Linea4",pa2L4);
								params.put("valPA2Linea4",valPA2L4);
								params.put("planAdi3Linea4",pa3L4);
								params.put("valPA3Linea4",valPA3L4);
								params.put("planAdi4Linea4",pa4L4);
								params.put("valPA4Linea4",valPA4L4);
								
								aux2PAL4 = aux2PAL4 + 4;
								auxPAL4 = auxPAL4 - 4;	
								flagPAL4 = false;
							}else{
								params.put("planAdi1Linea4","");
								params.put("valPA1Linea4","");
								params.put("planAdi2Linea4","");
								params.put("valPA2Linea4","");
								params.put("planAdi3Linea4","");
								params.put("valPA3Linea4","");
								params.put("planAdi4Linea4","");
								params.put("valPA4Linea4","");
							}						
						}					
					}else{
						params.put("planAdi1Linea4","");
						params.put("valPA1Linea4","");
						params.put("planAdi2Linea4","");
						params.put("valPA2Linea4","");
						params.put("planAdi3Linea4","");
						params.put("valPA3Linea4","");
						params.put("planAdi4Linea4","");
						params.put("valPA4Linea4","");
					}				
					if(flag2Hoja){
						//Datos Cliente
						params.put("codPuntoVenta","");
						params.put("nomPuntoVenta","");		
						params.put("tipIdent","");
						params.put("numIdent","");
						params.put("cliParticular","");
						params.put("cliPyme","");
						params.put("cliEmpresa","");
						params.put("apellidosCliente","");
						params.put("nomCliente","");
						params.put("domicilio","");
						params.put("provincia","");
						params.put("canton","");
						params.put("mail","");
						params.put("nomRepresentante","");
						params.put("tipIdentRepre","");
						params.put("numIdentRepresenta","");
						params.put("numMesesContrato","");
						params.put("mensPromSi","");
						params.put("mensPromNo","");					
						//Datos Banco Cliente
						params.put("codBanco","");
						params.put("codSucursal","");
						params.put("numCuentaCorriente","");
						params.put("entidad","");
						params.put("tipTarjeta","");
						params.put("numTarjeta","");
						//Linea1
						params.put("numCelular","");
						params.put("tipTerminalLinea1","");
						params.put("numImeiLinea1","");
						params.put("modTerLinea1","");
						params.put("simcardLinea1","");
						params.put("planTarifLinea1","");
						params.put("cargoLinea1","");
						//P-CSR-11002 JLGN 20-10-2011
						params.put("limiteConsumoLinea1","");
						//P-CSR-11002 JLGN 25-10-2011
						params.put("ldiSiLinea1","");
						params.put("ldiNoLinea1","");
						//Linea2
						params.put("numCelular2","");
						params.put("tipTerminalLinea2","");
						params.put("numImeiLinea2","");
						params.put("modTerLinea2","");
						params.put("simcardLinea2","");
						params.put("planTarifLinea2","");
						params.put("cargoLinea2","");
						//P-CSR-11002 JLGN 20-10-2011
						params.put("limiteConsumoLinea2","");
						//P-CSR-11002 JLGN 25-10-2011
						params.put("ldiSiLinea2","");
						params.put("ldiNoLinea2","");
						//Linea3
						params.put("numCelular3","");
						params.put("tipTerminalLinea3","");
						params.put("numImeiLinea3","");
						params.put("modTerLinea3","");
						params.put("simcardLinea3","");
						params.put("planTarifLinea3","");
						params.put("cargoLinea3","");
						//P-CSR-11002 JLGN 20-10-2011
						params.put("limiteConsumoLinea3","");
						//P-CSR-11002 JLGN 25-10-2011
						params.put("ldiSiLinea3","");
						params.put("ldiNoLinea3","");
						//Linea4
						params.put("numCelular4","");
						params.put("tipTerminalLinea4","");
						params.put("numImeiLinea4","");
						params.put("modTerLinea4","");
						params.put("simcardLinea4","");
						params.put("planTarifLinea4","");
						params.put("cargoLinea4","");	
						//P-CSR-11002 JLGN 20-10-2011
						params.put("limiteConsumoLinea4","");
						//P-CSR-11002 JLGN 25-10-2011
						params.put("ldiSiLinea4","");
						params.put("ldiNoLinea4","");
						
						//Rellenar el informe con datos
						filename2 = JasperFillManager.fillReport(sRutaContrato, params, ds);
						logger.debug("Rellena el resto de las paginas del contrato");
						flagRellena = true;					
					}else{
						//Rellenar el informe con datos
						logger.debug("Rellena Primera pagina del contrato");
						filename = JasperFillManager.fillReport(sRutaContrato, params, ds);
						flag2Hoja = true;					
					}				
					if(flagRellena){					
						logger.debug("agrega paginas al contrato");
						JRPrintPage page = filename2.removePage(0);
						filename.addPage(page);
					}				
					cuenta = cuenta + 4;
				}
			}	
			//Inicio P-CSR-11002 JLGN 09-12-2011
			if (guardaRuta == 1){
				//Inicio P-CSR-11002 JLGN 10-11-2011
				//Se guarda pdf en una ruta dentro del dominio del portal
				String rutaReportePDF = null;
				rutaReportePDF = System.getProperty("user.dir")  + global.getValorExterno("ruta.reporte.pdf") + "Contrato["+datosContrato.getNumVenta()+"].pdf";
				logger.debug("rutaReportePDF: "+ rutaReportePDF);
				logger.debug("Inserta Ruta Inicio");
				getVentasFacade().insertRutaContrato(datosContrato.getNumVenta(), global.getValorExterno("ruta.reporte.pdf") + "Contrato["+datosContrato.getNumVenta()+"].pdf");
				logger.debug("Inserta Ruta Fin");
				JasperExportManager.exportReportToPdfFile(filename, rutaReportePDF);
				//Fin P-CSR-11002 JLGN 10-11-2011
			}	
			//Fin P-CSR-11002 JLGN 09-12-2011
			return JasperExportManager.exportReportToPdf(filename);
		}catch(JRException e){
			logger.debug("JRException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}
	}
	
	//Contrato con anexo de contrato
	public byte[] formatoContratoAnexo(HashMap params, DatosContrato datosContrato, int guardaRuta) throws JRException, Exception{
		boolean flag2Hoja = false;
		boolean flagRellena = false;		
		JasperPrint filename = null;
		JasperPrint filename2 = null;
		JasperPrint filenameFinal = null;
		String sRutaContrato = System.getProperty("user.dir")  + global.getValorExterno("contrato.reporte");		
		
		logger.debug("Ruta Contrato: "+sRutaContrato);
	    File reportFile = new File(sRutaContrato);
	    logger.debug("Estado reporte :Existe="+reportFile.exists()+", Largo="+reportFile.length());
		
		//Las primeras 4 lineas se imprimen con el formato del contrato
		logger.debug("son 4 lineas");
		//Contador de PA
		int cantPAL1 = 0;
		int cantPAL2 = 0;
		int cantPAL3 = 0;
		int cantPAL4 = 0;			
		//contador de SS
		int cantSSL1 = 0;
		int cantSSL2 = 0;
		int cantSSL3 = 0;
		int cantSSL4 = 0;			
		int cantMayor = 0;
		//Linea1
		params.put("numCelular",datosContrato.getLineascontrato()[0].getNumCelular());
		params.put("tipTerminalLinea1",datosContrato.getLineascontrato()[0].getTipTerminal());
		params.put("numImeiLinea1",datosContrato.getLineascontrato()[0].getNumImei());
		params.put("modTerLinea1",datosContrato.getLineascontrato()[0].getDesTerminal());
		params.put("simcardLinea1",datosContrato.getLineascontrato()[0].getNumSerie());
		params.put("planTarifLinea1",datosContrato.getLineascontrato()[0].getPlanTarif());
		params.put("cargoLinea1",datosContrato.getLineascontrato()[0].getCargoPT());
		//P-CSR-11002 JLGN 20-10-2011
		params.put("limiteConsumoLinea1",datosContrato.getLineascontrato()[0].getLimiteConsumoLinea());
		//P-CSR-11002 JLGN 25-10-2011
		params.put("ldiSiLinea1",datosContrato.getLineascontrato()[0].getLdiSI());
		params.put("ldiNoLinea1",datosContrato.getLineascontrato()[0].getLdiNO());
		//Linea2
		params.put("numCelular2",datosContrato.getLineascontrato()[1].getNumCelular());
		params.put("tipTerminalLinea2",datosContrato.getLineascontrato()[1].getTipTerminal());
		params.put("numImeiLinea2",datosContrato.getLineascontrato()[1].getNumImei());
		params.put("modTerLinea2",datosContrato.getLineascontrato()[1].getDesTerminal());
		params.put("simcardLinea2",datosContrato.getLineascontrato()[1].getNumSerie());
		params.put("planTarifLinea2",datosContrato.getLineascontrato()[1].getPlanTarif());
		params.put("cargoLinea2",datosContrato.getLineascontrato()[1].getCargoPT());
		//P-CSR-11002 JLGN 20-10-2011
		params.put("limiteConsumoLinea2",datosContrato.getLineascontrato()[1].getLimiteConsumoLinea());
		//P-CSR-11002 JLGN 25-10-2011
		params.put("ldiSiLinea2",datosContrato.getLineascontrato()[1].getLdiSI());
		params.put("ldiNoLinea2",datosContrato.getLineascontrato()[1].getLdiNO());
		//Linea3
		params.put("numCelular3",datosContrato.getLineascontrato()[2].getNumCelular());
		params.put("tipTerminalLinea3",datosContrato.getLineascontrato()[2].getTipTerminal());
		params.put("numImeiLinea3",datosContrato.getLineascontrato()[2].getNumImei());
		params.put("modTerLinea3",datosContrato.getLineascontrato()[2].getDesTerminal());
		params.put("simcardLinea3",datosContrato.getLineascontrato()[2].getNumSerie());
		params.put("planTarifLinea3",datosContrato.getLineascontrato()[2].getPlanTarif());
		params.put("cargoLinea3",datosContrato.getLineascontrato()[2].getCargoPT());
		//P-CSR-11002 JLGN 20-10-2011
		params.put("limiteConsumoLinea3",datosContrato.getLineascontrato()[2].getLimiteConsumoLinea());
		//P-CSR-11002 JLGN 25-10-2011
		params.put("ldiSiLinea3",datosContrato.getLineascontrato()[2].getLdiSI());
		params.put("ldiNoLinea3",datosContrato.getLineascontrato()[2].getLdiNO());
		//Linea4
		params.put("numCelular4",datosContrato.getLineascontrato()[3].getNumCelular());
		params.put("tipTerminalLinea4",datosContrato.getLineascontrato()[3].getTipTerminal());
		params.put("numImeiLinea4",datosContrato.getLineascontrato()[3].getNumImei());
		params.put("modTerLinea4",datosContrato.getLineascontrato()[3].getDesTerminal());
		params.put("simcardLinea4",datosContrato.getLineascontrato()[3].getNumSerie());
		params.put("planTarifLinea4",datosContrato.getLineascontrato()[3].getPlanTarif());
		params.put("cargoLinea4",datosContrato.getLineascontrato()[3].getCargoPT());
		//P-CSR-11002 JLGN 20-10-2011
		params.put("limiteConsumoLinea4",datosContrato.getLineascontrato()[3].getLimiteConsumoLinea());
		//P-CSR-11002 JLGN 25-10-2011
		params.put("ldiSiLinea4",datosContrato.getLineascontrato()[3].getLdiSI());
		params.put("ldiNoLinea4",datosContrato.getLineascontrato()[3].getLdiNO());		
		
		logger.debug("consulta cantidad de PA por linea");
		cantPAL1 = datosContrato.getLineascontrato()[0].getPlanesAdicionales().length;
		cantSSL1 = datosContrato.getLineascontrato()[0].getServSupl().length;
		cantPAL2 = datosContrato.getLineascontrato()[1].getPlanesAdicionales().length;
		cantSSL2 = datosContrato.getLineascontrato()[1].getServSupl().length;
		cantPAL3 = datosContrato.getLineascontrato()[2].getPlanesAdicionales().length;
		cantSSL3 = datosContrato.getLineascontrato()[2].getServSupl().length;
		cantPAL4 = datosContrato.getLineascontrato()[3].getPlanesAdicionales().length;
		cantSSL4 = datosContrato.getLineascontrato()[3].getServSupl().length;
		
		if(cantPAL1 >= cantPAL2 && cantPAL1 >= cantPAL3 && cantPAL1 >= cantPAL4 &&
				cantPAL1 >= cantSSL1 && cantPAL1 >= cantSSL2 && cantPAL1 >= cantSSL3 && cantPAL1 >= cantSSL4 ){
			logger.debug("PA Linea 1 tiene mas planes");
			cantMayor = cantPAL1; 
		}else if(cantPAL2 >= cantPAL1 && cantPAL2 >= cantPAL3 && cantPAL2 >= cantPAL4 &&
				cantPAL2 >= cantSSL1 && cantPAL2 >= cantSSL2 && cantPAL2 >= cantSSL3 && cantPAL2 >= cantSSL4 ){
			logger.debug("PA Linea 2 tiene mas planes");
			cantMayor = cantPAL2;
		}else if(cantPAL3 >= cantPAL1 && cantPAL3 >= cantPAL2 && cantPAL3 >= cantPAL4 &&
				cantPAL3 >= cantSSL1 && cantPAL3 >= cantSSL2 && cantPAL3 >= cantSSL3 && cantPAL3 >= cantSSL4 ){
			logger.debug("PA Linea 3 tiene mas planes");
			cantMayor = cantPAL3;
		}else if(cantPAL4 >= cantPAL1 && cantPAL4 >= cantPAL2 && cantPAL4 >= cantPAL3 &&
				cantPAL4 >= cantSSL1 && cantPAL4 >= cantSSL2 && cantPAL4 >= cantSSL3 && cantPAL4 >= cantSSL4 ){
			logger.debug("PA Linea 4 tiene mas planes");
			cantMayor = cantPAL4;
		}else if(cantSSL1 >= cantPAL1 && cantSSL1 >= cantPAL2 && cantSSL1 >= cantPAL3 &&
				cantSSL1 >= cantPAL4 && cantSSL1 >= cantSSL2 && cantSSL1 >= cantSSL3 && cantSSL1 >= cantSSL4 ){
			logger.debug("SS Linea 1 tiene mas servicios");
			cantMayor = cantSSL1;
		}else if(cantSSL2 >= cantPAL1 && cantSSL2 >= cantPAL2 && cantSSL2 >= cantPAL3 &&
				cantSSL2 >= cantPAL4 && cantSSL2 >= cantSSL1 && cantSSL2 >= cantSSL3 && cantSSL2 >= cantSSL4 ){
			logger.debug("SS Linea 2 tiene mas servicios");
			cantMayor = cantSSL2;
		}else if(cantSSL3 >= cantPAL1 && cantSSL3 >= cantPAL2 && cantSSL3 >= cantPAL3 &&
				cantSSL3 >= cantPAL4 && cantSSL3 >= cantSSL1 && cantSSL3 >= cantSSL2 && cantSSL3 >= cantSSL4 ){
			logger.debug("SS Linea 3 tiene mas servicios");
			cantMayor = cantSSL3;
		}else if(cantSSL4 >= cantPAL1 && cantSSL4 >= cantPAL2 && cantSSL4 >= cantPAL3 &&
				cantSSL4 >= cantPAL4 && cantSSL4 >= cantSSL1 && cantSSL4 >= cantSSL2 && cantSSL4 >= cantSSL3 ){
			logger.debug("SS Linea 4 tiene mas servicios");
			cantMayor = cantSSL4;
		}
		
		List detalleContrato = new ArrayList();
		JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(detalleContrato);
		
		//Obtiene Planes Adiacionales de las lineas			
		int auxPAL1 = cantPAL1;
		int aux2PAL1 = 0;
		boolean flagPAL1 = true;
		int auxSSL1 = cantSSL1;
		int aux2SSL1 = 0;
		boolean flagSSL1 = true;			
		
		int auxPAL2 = cantPAL2;
		int aux2PAL2 = 0;
		boolean flagPAL2 = true;
		int auxSSL2 = cantSSL2;
		int aux2SSL2 = 0;
		boolean flagSSL2 = true;
		
		int auxPAL3 = cantPAL3;
		int aux2PAL3 = 0;
		boolean flagPAL3 = true;
		int auxSSL3 = cantSSL3;
		int aux2SSL3 = 0;
		boolean flagSSL3 = true;
		
		int auxPAL4 = cantPAL4;
		int aux2PAL4 = 0;
		boolean flagPAL4 = true;
		int auxSSL4 = cantSSL4;
		int aux2SSL4 = 0;
		boolean flagSSL4 = true;
		
		int cuenta=0;
		
		logger.debug("Obtiene PA y SS de las Lineas");
		logger.debug("cuenta: "+ cuenta);
		logger.debug("cantMayor: "+ cantMayor);
		
		if (cantMayor == 0){
			//No existen PA ni SS opcionales en las lineas				
			params = rellenaSSPAOpcionalesContrato(params);	
			logger.debug("Rellena Primera pagina del contrato");
			filename = JasperFillManager.fillReport(sRutaContrato, params, ds);
		}else{
			while(cuenta < cantMayor){
				//SS Linea 1				
				if(cantSSL1 != 0){
					if(cantSSL1%2 == 0){
						//Cantidad de SS es Par
						if((auxSSL1 - 4 >= 0)&&(flagSSL1)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS());
							params.put("valSS1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS());
							params.put("servSup2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS());
							params.put("valSS2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS());
							params.put("servSup3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS());
							params.put("valSS3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS());	
							params.put("servSup4Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getNomSS());
							params.put("valSS4Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getValSS());	
							
							aux2SSL1 = aux2SSL1 + 4;
							auxSSL1 = auxSSL1 - 4;								
						}else if((auxSSL1 - 2 >= 0)&&(flagSSL1)){
							logger.debug("Quedan 2 SS");
							params.put("servSup1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS());
							params.put("valSS1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS());
							params.put("servSup2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS());
							params.put("valSS2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS());
							params.put("servSup3Linea1","");
							params.put("valSS3Linea1","");	
							params.put("servSup4Linea1","");
							params.put("valSS4Linea1","");	
							
							aux2SSL1 = aux2SSL1 + 4;
							auxSSL1 = auxSSL1 - 4;			
							flagSSL1 = false;
						}else{
							params = ssOpcionalVacio(params, "1");
						}						
					}else if(cantSSL1%2 == 1){
						//Cantidad de SS es Impar
						if((auxSSL1 - 4 >= 0)&&(flagSSL1)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS());
							params.put("valSS1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS());
							params.put("servSup2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS());
							params.put("valSS2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS());
							params.put("servSup3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS());
							params.put("valSS3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS());	
							params.put("servSup4Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getNomSS());
							params.put("valSS4Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+3)].getValSS());	
							
							aux2SSL1 = aux2SSL1 + 4;
							auxSSL1 = auxSSL1 - 4;								
						}else if((auxSSL1 - 3 >= 0)&&(flagSSL1)){
							logger.debug("Quedan 3 SS");
							params.put("servSup1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS());
							params.put("valSS1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS());
							params.put("servSup2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getNomSS());
							params.put("valSS2Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+1)].getValSS());
							params.put("servSup3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getNomSS());
							params.put("valSS3Linea1",datosContrato.getLineascontrato()[0].getServSupl()[(aux2SSL1+2)].getValSS());		
							params.put("servSup4Linea1","");
							params.put("valSS4Linea1","");	
							
							aux2SSL1 = aux2SSL1 + 4;
							auxSSL1 = auxSSL1 - 4;			
							flagSSL1 = false;
						}else if((auxSSL1 - 1 >= 0)&&(flagSSL1)){
							logger.debug("Queda 1 SS");
							params.put("servSup1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getNomSS());
							params.put("valSS1Linea1",datosContrato.getLineascontrato()[0].getServSupl()[aux2SSL1].getValSS());
							params.put("servSup2Linea1","");
							params.put("valSS2Linea1","");
							params.put("servSup3Linea1","");
							params.put("valSS3Linea1","");	
							params.put("servSup4Linea1","");
							params.put("valSS4Linea1","");	
							
							aux2SSL1 = aux2SSL1 + 4;
							auxSSL1 = auxSSL1 - 4;			
							flagSSL1 = false;
						}else{
							params = ssOpcionalVacio(params, "1");
						}						
					}					
				}else{
					params = ssOpcionalVacio(params, "1");	
				}				
				//PA Linea 1				
				if(cantPAL1 != 0){
					if(cantPAL1%2 == 0){
						//Cantidad de SS es Par
						if((auxPAL1 - 4 >= 0)&&(flagPAL1)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi());
							params.put("valPA1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi());
							params.put("planAdi2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi());
							params.put("valPA2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi());
							params.put("planAdi3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi());
							params.put("valPA3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi());
							params.put("planAdi4Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getNomPlanAdi());
							params.put("valPA4Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getValPlanAdi());
							
							aux2PAL1 = aux2PAL1 + 4;
							auxPAL1 = auxPAL1 - 4;								
						}else if((auxPAL1 - 2 >= 0)&&(flagPAL1)){
							logger.debug("Quedan 2 PA");
							params.put("planAdi1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi());
							params.put("valPA1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi());
							params.put("planAdi2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi());
							params.put("valPA2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi());
							params.put("planAdi3Linea1","");
							params.put("valPA3Linea1","");
							params.put("planAdi4Linea1","");
							params.put("valPA4Linea1","");
							
							aux2PAL1 = aux2PAL1 + 4;
							auxPAL1 = auxPAL1 - 4;	
							flagPAL1 = false;
						}else{
							params = paOpcionalVacio(params, "1");	
						}
						
					}else if(cantPAL1%2 == 1){
						//Cantidad de PA es Impar
						if((auxPAL1 - 4 >= 0)&&(flagPAL1)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi());
							params.put("valPA1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi());
							params.put("planAdi2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi());
							params.put("valPA2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi());
							params.put("planAdi3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi());
							params.put("valPA3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi());
							params.put("planAdi4Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getNomPlanAdi());
							params.put("valPA4Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+3)].getValPlanAdi());
							
							aux2PAL1 = aux2PAL1 + 4;
							auxPAL1 = auxPAL1 - 4;							
						}else if((auxPAL1 - 3 >= 0)&&(flagPAL1)){
							//Quedan 3 PA
							logger.debug("Quedan 3 PA");
							params.put("planAdi1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi());
							params.put("valPA1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi());
							params.put("planAdi2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getNomPlanAdi());
							params.put("valPA2Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+1)].getValPlanAdi());
							params.put("planAdi3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getNomPlanAdi());
							params.put("valPA3Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[(aux2PAL1+2)].getValPlanAdi());
							params.put("planAdi4Linea1","");
							params.put("valPA4Linea1","");
							
							aux2PAL1 = aux2PAL1 + 4;
							auxPAL1 = auxPAL1 - 4;			
							flagPAL1 = false;
						}else if((auxPAL1 - 1 >= 0)&&(flagPAL1)){
							//Queda 1 PA
							logger.debug("Queda 1 PA");
							params.put("planAdi1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getNomPlanAdi());
							params.put("valPA1Linea1",datosContrato.getLineascontrato()[0].getPlanesAdicionales()[aux2PAL1].getValPlanAdi());
							params.put("planAdi2Linea1","");
							params.put("valPA2Linea1","");
							params.put("planAdi3Linea1","");
							params.put("valPA3Linea1","");
							params.put("planAdi4Linea1","");
							params.put("valPA4Linea1","");
							
							aux2PAL1 = aux2PAL1 + 4;
							auxPAL1 = auxPAL1 - 4;			
							flagPAL1 = false;
						}else{
							params = paOpcionalVacio(params, "1");	
						}						
					}					
				}else{
					params = paOpcionalVacio(params, "1");
				}				
				//SS Linea 2				
				if(cantSSL2 != 0){
					if(cantSSL2%2 == 0){
						//Cantidad de SS es Par
						if((auxSSL2 - 4 >= 0)&&(flagSSL2)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS());
							params.put("valSS1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS());
							params.put("servSup2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS());
							params.put("valSS2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS());
							params.put("servSup3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS());
							params.put("valSS3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS());	
							params.put("servSup4Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getNomSS());
							params.put("valSS4Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getValSS());	
							
							aux2SSL2 = aux2SSL2 + 4;
							auxSSL2 = auxSSL2 - 4;								
						}else if((auxSSL2 - 2 >= 0)&&(flagSSL2)){
							logger.debug("Quedan 2 SS");
							params.put("servSup1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS());
							params.put("valSS1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS());
							params.put("servSup2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS());
							params.put("valSS2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS());
							params.put("servSup3Linea2","");
							params.put("valSS3Linea2","");	
							params.put("servSup4Linea2","");
							params.put("valSS4Linea2","");	
							
							aux2SSL2 = aux2SSL2 + 4;
							auxSSL2 = auxSSL2 - 4;			
							flagSSL2 = false;
						}else{
							params = ssOpcionalVacio(params, "2");	
						}
						
					}else if(cantSSL2%2 == 1){
						//Cantidad de SS es Impar
						if((auxSSL2 - 4 >= 0)&&(flagSSL2)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS());
							params.put("valSS1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS());
							params.put("servSup2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS());
							params.put("valSS2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS());
							params.put("servSup3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS());
							params.put("valSS3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS());	
							params.put("servSup4Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getNomSS());
							params.put("valSS4Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+3)].getValSS());		
							
							aux2SSL2 = aux2SSL2 + 4;
							auxSSL2 = auxSSL2 - 4;								
						}else if((auxSSL2 - 3 >= 0)&&(flagSSL2)){
							//Quedan 3 SS
							logger.debug("Quedan 3 SS");
							params.put("servSup1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS());
							params.put("valSS1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS());
							params.put("servSup2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getNomSS());
							params.put("valSS2Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+1)].getValSS());
							params.put("servSup3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getNomSS());
							params.put("valSS3Linea2",datosContrato.getLineascontrato()[1].getServSupl()[(aux2SSL2+2)].getValSS());		
							params.put("servSup4Linea2","");
							params.put("valSS4Linea2","");	
							
							aux2SSL2 = aux2SSL2 + 4;
							auxSSL2 = auxSSL2 - 4;	
							flagSSL2 = false;
						}else if((auxSSL2 - 1 >= 0)&&(flagSSL2)){
							logger.debug("Queda 1");
							params.put("servSup1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getNomSS());
							params.put("valSS1Linea2",datosContrato.getLineascontrato()[1].getServSupl()[aux2SSL2].getValSS());
							params.put("servSup2Linea2","");
							params.put("valSS2Linea2","");
							params.put("servSup3Linea2","");
							params.put("valSS3Linea2","");	
							params.put("servSup4Linea2","");
							params.put("valSS4Linea2","");	
							
							aux2SSL2 = aux2SSL2 + 4;
							auxSSL2 = auxSSL2 - 4;	
							flagSSL2 = false;
						}else{
							params = ssOpcionalVacio(params, "2");			
						}						
					}					
				}else{
					params = ssOpcionalVacio(params, "2");		
				}				
				//PA Linea 2			
				if(cantPAL2 != 0){
					if(cantPAL2%2 == 0){
						//Cantidad de SS es Par
						if((auxPAL2 - 4 >= 0)&&(flagPAL2)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi());
							params.put("valPA1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi());
							params.put("planAdi2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi());
							params.put("valPA2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi());
							params.put("planAdi3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi());
							params.put("valPA3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi());
							params.put("planAdi4Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getNomPlanAdi());
							params.put("valPA4Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getValPlanAdi());
							
							aux2PAL2 = aux2PAL2 + 4;
							auxPAL2 = auxPAL2 - 4;								
						}else if((auxPAL2 - 2 >= 0)&&(flagPAL2)){
							logger.debug("Quedan 2 PA");
							params.put("planAdi1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi());
							params.put("valPA1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi());
							params.put("planAdi2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi());
							params.put("valPA2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi());
							params.put("planAdi3Linea2","");
							params.put("valPA3Linea2","");
							params.put("planAdi4Linea2","");
							params.put("valPA4Linea2","");
							
							aux2PAL2 = aux2PAL2 + 4;
							auxPAL2 = auxPAL2 - 4;	
							flagPAL2 = false;
						}else{
							params = paOpcionalVacio(params, "2");
						}						
					}else if(cantPAL2%2 == 1){
						//Cantidad de PA es Impar
						if((auxPAL2 - 4 >= 0)&&(flagPAL2)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi());
							params.put("valPA1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi());
							params.put("planAdi2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi());
							params.put("valPA2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi());
							params.put("planAdi3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi());
							params.put("valPA3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi());
							params.put("planAdi4Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getNomPlanAdi());
							params.put("valPA4Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+3)].getValPlanAdi());
							
							aux2PAL2 = aux2PAL2 + 4;
							auxPAL2 = auxPAL2 - 4;								
						}else if((auxPAL2 - 3 >= 0)&&(flagPAL2)){
							//Quedan 3 PA
							logger.debug("Quedan 3 PA");
							params.put("planAdi1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi());
							params.put("valPA1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi());
							params.put("planAdi2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getNomPlanAdi());
							params.put("valPA2Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+1)].getValPlanAdi());
							params.put("planAdi3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getNomPlanAdi());
							params.put("valPA3Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[(aux2PAL2+2)].getValPlanAdi());
							params.put("planAdi4Linea2","");
							params.put("valPA4Linea2","");
							
							aux2PAL2 = aux2PAL2 + 4;
							auxPAL2 = auxPAL2 - 4;	
							flagPAL2 = false;
						}else if((auxPAL2 - 1 >= 0)&&(flagPAL2)){
							//Queda 1 PA
							params.put("planAdi1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getNomPlanAdi());
							params.put("valPA1Linea2",datosContrato.getLineascontrato()[1].getPlanesAdicionales()[aux2PAL2].getValPlanAdi());
							params.put("planAdi2Linea2","");
							params.put("valPA2Linea2","");
							params.put("planAdi3Linea2","");
							params.put("valPA3Linea2","");
							params.put("planAdi4Linea2","");
							params.put("valPA4Linea2","");
							
							aux2PAL2 = aux2PAL2 + 4;
							auxPAL2 = auxPAL2 - 4;	
							flagPAL2 = false;
						}else{
							params = paOpcionalVacio(params, "2");
						}						
					}					
				}else{
					params = paOpcionalVacio(params, "2");
				}				
				//SS Linea 3				
				if(cantSSL3 != 0){
					if(cantSSL3%2 == 0){
						//Cantidad de SS es Par
						if((auxSSL3 - 4 >= 0)&&(flagSSL3)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS());
							params.put("valSS1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS());
							params.put("servSup2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS());
							params.put("valSS2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS());
							params.put("servSup3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS());
							params.put("valSS3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS());	
							params.put("servSup4Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getNomSS());
							params.put("valSS4Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getValSS());	
							
							aux2SSL3 = aux2SSL3 + 4;
							auxSSL3 = auxSSL3 - 4;								
						}else if((auxSSL3 - 2 >= 0)&&(flagSSL3)){
							logger.debug("Quedan 2 SS");
							params.put("servSup1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS());
							params.put("valSS1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS());
							params.put("servSup2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS());
							params.put("valSS2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS());
							params.put("servSup3Linea3","");
							params.put("valSS3Linea3","");	
							params.put("servSup4Linea3","");
							params.put("valSS4Linea3","");	
							
							aux2SSL3 = aux2SSL3 + 4;
							auxSSL3 = auxSSL3 - 4;	
							flagSSL3 = false;
						}else{
							params = ssOpcionalVacio(params, "3");	
						}						
					}else if(cantSSL3%2 == 1){
						//Cantidad de SS es Impar
						if((auxSSL3 - 4 >= 0)&&(flagSSL3)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS());
							params.put("valSS1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS());
							params.put("servSup2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS());
							params.put("valSS2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS());
							params.put("servSup3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS());
							params.put("valSS3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS());	
							params.put("servSup4Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getNomSS());
							params.put("valSS4Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+3)].getValSS());		
							
							aux2SSL3 = aux2SSL3 + 4;
							auxSSL3 = auxSSL3 - 4;								
						}else if((auxSSL3 - 3 >= 0)&&(flagSSL3)){
							//Quedan 3 SS
							logger.debug("Quedan 3 SS");
							params.put("servSup1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS());
							params.put("valSS1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS());
							params.put("servSup2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getNomSS());
							params.put("valSS2Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+1)].getValSS());
							params.put("servSup3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getNomSS());
							params.put("valSS3Linea3",datosContrato.getLineascontrato()[2].getServSupl()[(aux2SSL3+2)].getValSS());		
							params.put("servSup4Linea3","");
							params.put("valSS4Linea3","");	
							
							aux2SSL3 = aux2SSL3 + 4;
							auxSSL3 = auxSSL3 - 4;	
							flagSSL3 = false;
						}else if((auxSSL3 - 1 >= 0)&&(flagSSL3)){
							logger.debug("Queda 1");
							params.put("servSup1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getNomSS());
							params.put("valSS1Linea3",datosContrato.getLineascontrato()[2].getServSupl()[aux2SSL3].getValSS());
							params.put("servSup2Linea3","");
							params.put("valSS2Linea3","");
							params.put("servSup3Linea3","");
							params.put("valSS3Linea3","");	
							params.put("servSup4Linea3","");
							params.put("valSS4Linea3","");	
							
							aux2SSL3 = aux2SSL3 + 4;
							auxSSL3 = auxSSL3 - 4;	
							flagSSL3 = false;
						}else{
							params = ssOpcionalVacio(params, "3");	
						}						
					}					
				}else{
					params = ssOpcionalVacio(params, "3");
				}				
				//PA Linea 3		
				if(cantPAL3 != 0){
					if(cantPAL3%2 == 0){
						//Cantidad de SS es Par
						if((auxPAL3 - 4 >= 0)&&(flagPAL3)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");							
							params.put("planAdi1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi());
							params.put("valPA1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi());
							params.put("planAdi2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi());
							params.put("valPA2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi());
							params.put("planAdi3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi());
							params.put("valPA3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi());
							params.put("planAdi4Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getNomPlanAdi());
							params.put("valPA4Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getValPlanAdi());
							
							aux2PAL3 = aux2PAL3 + 4;
							auxPAL3 = auxPAL3 - 4;								
						}else if((auxPAL3 - 2 >= 0)&&(flagPAL3)){
							logger.debug("Quedan 2 PA");
							params.put("planAdi1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi());
							params.put("valPA1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi());
							params.put("planAdi2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi());
							params.put("valPA2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi());
							params.put("planAdi3Linea3","");
							params.put("valPA3Linea3","");
							params.put("planAdi4Linea3","");
							params.put("valPA4Linea3","");
							
							aux2PAL3 = aux2PAL3 + 4;
							auxPAL3 = auxPAL3 - 4;	
							flagPAL3 = false;
						}else{
							params = paOpcionalVacio(params, "3");
						}						
					}else if(cantPAL3%2 == 1){
						//Cantidad de PA es Impar
						if((auxPAL3 - 4 >= 0)&&(flagPAL3)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi());
							params.put("valPA1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi());
							params.put("planAdi2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi());
							params.put("valPA2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi());
							params.put("planAdi3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi());
							params.put("valPA3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi());
							params.put("planAdi4Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getNomPlanAdi());
							params.put("valPA4Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+3)].getValPlanAdi());
							
							aux2PAL3 = aux2PAL3 + 4;
							auxPAL3 = auxPAL3 - 4;								
						}else if((auxPAL3 - 3 >= 0)&&(flagPAL3)){
							//Quedan 3 PA
							logger.debug("Quedan 3 PA");
							params.put("planAdi1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi());
							params.put("valPA1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi());
							params.put("planAdi2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getNomPlanAdi());
							params.put("valPA2Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+1)].getValPlanAdi());
							params.put("planAdi3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getNomPlanAdi());
							params.put("valPA3Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[(aux2PAL3+2)].getValPlanAdi());
							params.put("planAdi4Linea3","");
							params.put("valPA4Linea3","");
							
							aux2PAL3 = aux2PAL3 + 4;
							auxPAL3 = auxPAL3 - 4;	
							flagPAL3 = false;
						}else if((auxPAL3 - 1 >= 0)&&(flagPAL3)){
							//Queda 1 PA
							params.put("planAdi1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getNomPlanAdi());
							params.put("valPA1Linea3",datosContrato.getLineascontrato()[2].getPlanesAdicionales()[aux2PAL3].getValPlanAdi());
							params.put("planAdi2Linea3","");
							params.put("valPA2Linea3","");
							params.put("planAdi3Linea3","");
							params.put("valPA3Linea3","");
							params.put("planAdi4Linea3","");
							params.put("valPA4Linea3","");
							
							aux2PAL3 = aux2PAL3 + 4;
							auxPAL3 = auxPAL3 - 4;	
							flagPAL3 = false;
						}else{
							params = paOpcionalVacio(params, "3");
						}						
					}					
				}else{
					params = paOpcionalVacio(params, "3");
				}				
				//SS Linea 4				
				if(cantSSL4 != 0){
					if(cantSSL4%2 == 0){
						//Cantidad de SS es Par
						if((auxSSL4 - 4 >= 0)&&(flagSSL4)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS());
							params.put("valSS1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS());
							params.put("servSup2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS());
							params.put("valSS2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS());
							params.put("servSup3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS());
							params.put("valSS3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS());	
							params.put("servSup4Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getNomSS());
							params.put("valSS4Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getValSS());	
							
							aux2SSL4 = aux2SSL4 + 4;
							auxSSL4 = auxSSL4 - 4;							
						}else if((auxSSL4 - 2 >= 0)&&(flagSSL4)){
							logger.debug("Quedan 2 SS");
							params.put("servSup1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS());
							params.put("valSS1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS());
							params.put("servSup2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS());
							params.put("valSS2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS());
							params.put("servSup3Linea4","");
							params.put("valSS3Linea4","");	
							params.put("servSup4Linea4","");
							params.put("valSS4Linea4","");	
							
							aux2SSL4 = aux2SSL4 + 4;
							auxSSL4 = auxSSL4 - 4;	
							flagSSL4 = false;
						}else{
							params = ssOpcionalVacio(params, "4");	
						}						
					}else if(cantSSL4%2 == 1){
						//Cantidad de SS es Impar
						if((auxSSL4 - 4 >= 0)&&(flagSSL4)){
							//Quedan 4 SS o mas
							logger.debug("Quedan 4 SS o mas");
							params.put("servSup1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS());
							params.put("valSS1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS());
							params.put("servSup2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS());
							params.put("valSS2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS());
							params.put("servSup3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS());
							params.put("valSS3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS());	
							params.put("servSup4Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getNomSS());
							params.put("valSS4Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+3)].getValSS());		
							
							aux2SSL4 = aux2SSL4 + 4;
							auxSSL4 = auxSSL4 - 4;								
						}else if((auxSSL4 - 3 >= 0)&&(flagSSL4)){
							//Quedan 3 SS
							logger.debug("Quedan 3 SS");
							params.put("servSup1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS());
							params.put("valSS1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS());
							params.put("servSup2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getNomSS());
							params.put("valSS2Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+1)].getValSS());
							params.put("servSup3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getNomSS());
							params.put("valSS3Linea4",datosContrato.getLineascontrato()[3].getServSupl()[(aux2SSL4+2)].getValSS());		
							params.put("servSup4Linea4","");
							params.put("valSS4Linea4","");	
							
							aux2SSL4 = aux2SSL4 + 4;
							auxSSL4 = auxSSL4 - 4;	
							flagSSL4 = false;
						}else if((auxSSL4 - 1 >= 0)&&(flagSSL4)){
							logger.debug("Queda 1");
							params.put("servSup1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getNomSS());
							params.put("valSS1Linea4",datosContrato.getLineascontrato()[3].getServSupl()[aux2SSL4].getValSS());
							params.put("servSup2Linea4","");
							params.put("valSS2Linea4","");
							params.put("servSup3Linea4","");
							params.put("valSS3Linea4","");	
							params.put("servSup4Linea4","");
							params.put("valSS4Linea4","");	
							
							aux2SSL4 = aux2SSL4 + 4;
							auxSSL4 = auxSSL4 - 4;	
							flagSSL4 = false;
						}else{
							params = ssOpcionalVacio(params, "4");		
						}						
					}					
				}else{
					params = ssOpcionalVacio(params, "4");	
				}				
				//PA Linea 4		
				if(cantPAL4 != 0){
					if(cantPAL4%2 == 0){
						//Cantidad de SS es Par
						if((auxPAL4 - 4 >= 0)&&(flagPAL4)){
							//Quedan 4 PA o mas
							logger.debug("Quedan 4 PA o mas");
							params.put("planAdi1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi());
							params.put("valPA1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi());
							params.put("planAdi2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi());
							params.put("valPA2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi());
							params.put("planAdi3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi());
							params.put("valPA3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi());
							params.put("planAdi4Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getNomPlanAdi());
							params.put("valPA4Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getValPlanAdi());
							
							aux2PAL4 = aux2PAL4 + 4;
							auxPAL4 = auxPAL4 - 4;								
						}else if((auxPAL4 - 2 >= 0)&&(flagPAL4)){
							logger.debug("Quedan 2 PA");
							params.put("planAdi1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi());
							params.put("valPA1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi());
							params.put("planAdi2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi());
							params.put("valPA2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi());
							params.put("planAdi3Linea4","");
							params.put("valPA3Linea4","");
							params.put("planAdi4Linea4","");
							params.put("valPA4Linea4","");
							
							aux2PAL4 = aux2PAL4 + 4;
							auxPAL4 = auxPAL4 - 4;	
							flagPAL4 = false;
						}else{
							params = paOpcionalVacio(params, "4");	
						}						
					}else if(cantPAL4%2 == 1){
						//Cantidad de PA es Impar
						if((auxPAL4 - 4 >= 0)&&(flagPAL4)){
							//Quedan 4 PA o mas
							params.put("planAdi1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi());
							params.put("valPA1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi());
							params.put("planAdi2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi());
							params.put("valPA2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi());
							params.put("planAdi3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi());
							params.put("valPA3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi());
							params.put("planAdi4Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getNomPlanAdi());
							params.put("valPA4Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+3)].getValPlanAdi());
							
							aux2PAL4 = aux2PAL4 + 4;
							auxPAL4 = auxPAL4 - 4;								
						}else if((auxPAL4 - 3 >= 0)&&(flagPAL4)){
							//Quedan 3 PA
							logger.debug("Quedan 3 PA");
							params.put("planAdi1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi());
							params.put("valPA1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi());
							params.put("planAdi2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getNomPlanAdi());
							params.put("valPA2Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+1)].getValPlanAdi());
							params.put("planAdi3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getNomPlanAdi());
							params.put("valPA3Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[(aux2PAL4+2)].getValPlanAdi());
							params.put("planAdi4Linea4","");
							params.put("valPA4Linea4","");
							
							aux2PAL4 = aux2PAL4 + 4;
							auxPAL4 = auxPAL4 - 4;	
							flagPAL4 = false;
						}else if((auxPAL4 - 1 >= 0)&&(flagPAL4)){
							//Queda 1 PA
							params.put("planAdi1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getNomPlanAdi());
							params.put("valPA1Linea4",datosContrato.getLineascontrato()[3].getPlanesAdicionales()[aux2PAL4].getValPlanAdi());
							params.put("planAdi2Linea4","");
							params.put("valPA2Linea4","");
							params.put("planAdi3Linea4","");
							params.put("valPA3Linea4","");
							params.put("planAdi4Linea4","");
							params.put("valPA4Linea4","");
							
							aux2PAL4 = aux2PAL4 + 4;
							auxPAL4 = auxPAL4 - 4;	
							flagPAL4 = false;
						}else{
							params = paOpcionalVacio(params, "4");
						}						
					}					
				}else{
					params = paOpcionalVacio(params, "4");
				}				
				if(flag2Hoja){
					//Datos Cliente
					params.put("codPuntoVenta","");
					params.put("nomPuntoVenta","");		
					params.put("tipIdent","");
					params.put("numIdent","");
					params.put("cliParticular","");
					params.put("cliPyme","");
					params.put("cliEmpresa","");
					params.put("apellidosCliente","");
					params.put("nomCliente","");
					params.put("domicilio","");
					params.put("provincia","");
					params.put("canton","");
					params.put("mail","");
					params.put("nomRepresentante","");
					params.put("tipIdentRepre","");
					params.put("numIdentRepresenta","");
					params.put("numMesesContrato","");
					params.put("mensPromSi","");
					params.put("mensPromNo","");					
					//Datos Banco Cliente
					params.put("codBanco","");
					params.put("codSucursal","");
					params.put("numCuentaCorriente","");
					params.put("entidad","");
					params.put("tipTarjeta","");
					params.put("numTarjeta","");
					//Linea1
					params.put("numCelular","");
					params.put("tipTerminalLinea1","");
					params.put("numImeiLinea1","");
					params.put("modTerLinea1","");
					params.put("simcardLinea1","");
					params.put("planTarifLinea1","");
					params.put("cargoLinea1","");	
					//P-CSR-11002 JLGN 20-10-2011
					params.put("limiteConsumoLinea1","");
					//P-CSR-11002 JLGN 25-10-2011
					params.put("ldiSiLinea1","");
					params.put("ldiNoLinea1","");
					//Linea2
					params.put("numCelular2","");
					params.put("tipTerminalLinea2","");
					params.put("numImeiLinea2","");
					params.put("modTerLinea2","");
					params.put("simcardLinea2","");
					params.put("planTarifLinea2","");
					params.put("cargoLinea2","");
					//P-CSR-11002 JLGN 20-10-2011
					params.put("limiteConsumoLinea2","");
					//P-CSR-11002 JLGN 25-10-2011
					params.put("ldiSiLinea2","");
					params.put("ldiNoLinea2","");				
					//Linea3
					params.put("numCelular3","");
					params.put("tipTerminalLinea3","");
					params.put("numImeiLinea3","");
					params.put("modTerLinea3","");
					params.put("simcardLinea3","");
					params.put("planTarifLinea3","");
					params.put("cargoLinea3","");
					//P-CSR-11002 JLGN 20-10-2011
					params.put("limiteConsumoLinea3","");
					//P-CSR-11002 JLGN 25-10-2011
					params.put("ldiSiLinea3","");
					params.put("ldiNoLinea3","");				
					//Linea4
					params.put("numCelular4","");
					params.put("tipTerminalLinea4","");
					params.put("numImeiLinea4","");
					params.put("modTerLinea4","");
					params.put("simcardLinea4","");
					params.put("planTarifLinea4","");
					params.put("cargoLinea4","");	
					//P-CSR-11002 JLGN 20-10-2011
					params.put("limiteConsumoLinea4","");
					//P-CSR-11002 JLGN 25-10-2011
					params.put("ldiSiLinea4","");
					params.put("ldiNoLinea4","");				
					
					//Rellenar el informe con datos
					filename2 = JasperFillManager.fillReport(sRutaContrato, params, ds);
					logger.debug("Rellena el resto de las paginas del contrato");
					flagRellena = true;					
				}else{
					//Rellenar el informe con datos
					logger.debug("Rellena Primera pagina del contrato");
					filename = JasperFillManager.fillReport(sRutaContrato, params, ds);
					flag2Hoja = true;					
				}				
				if(flagRellena){					
					logger.debug("agrega paginas al contrato");
					JRPrintPage page = filename2.removePage(0);
					filename.addPage(page);
				}				
				cuenta = cuenta + 4;
			}
		}	
		//Se termina de Rellenar el contrato con las 4 primeras lineas 			
		filenameFinal = anexoContrato(datosContrato, filename);
		//Inicio P-CSR-11002 JLGN 09-12-2011
		if (guardaRuta == 1){
			//Inicio P-CSR-11002 JLGN 10-11-2011
			//Se guarda pdf en una ruta dentro del dominio del portal
			String rutaReportePDF = null;
			rutaReportePDF = System.getProperty("user.dir")  + global.getValorExterno("ruta.reporte.pdf") + "Contrato["+datosContrato.getNumVenta()+"].pdf";
			logger.debug("rutaReportePDF: "+ rutaReportePDF);
			logger.debug("Inserta Ruta Inicio");
			getVentasFacade().insertRutaContrato(datosContrato.getNumVenta(), global.getValorExterno("ruta.reporte.pdf") + "Contrato["+datosContrato.getNumVenta()+"].pdf");
			logger.debug("Inserta Ruta Fin");
			JasperExportManager.exportReportToPdfFile(filenameFinal, rutaReportePDF);
			//Fin P-CSR-11002 JLGN 10-11-2011
		}	
		//Fin P-CSR-11002 JLGN 09-12-2011
		return JasperExportManager.exportReportToPdf(filenameFinal);
	}
	
	public JasperPrint anexoContrato (DatosContrato datosContrato, JasperPrint filename) throws JRException, Exception{
		//Se empieza a rellenar los datos de las lineas en el formato del anexo			
		int lineasAnexo = datosContrato.getLineascontrato().length - 4; // Se cuenta cuantas lineas se deben insertar en el anexo
		int lineasAnexo2 = 0;
		boolean flagAnexoContrato = false;
		HashMap params2 = new HashMap(); //Parametros para el anexo
		HashMap params3 = new HashMap(); //Parametros para el anexo
		JasperPrint filename3 = null;
		logger.debug("lineas Anexo: "+lineasAnexo);	
		String sRutaAnexo = System.getProperty("user.dir")  + global.getValorExterno("anexo.contrato.reporte");
		
	    logger.debug("Ruta Contrato: "+sRutaAnexo);
	    File reportFile2 = new File(sRutaAnexo);
	    logger.debug("Estado reporte :Existe="+reportFile2.exists()+", Largo="+reportFile2.length());
		
		//while(lineasAnexo2 < lineasAnexo){
		while(lineasAnexo > 0){
			//cuenta SS
			int cantSSL5 = 0;
			int cantSSL6 = 0;
			int cantSSL7 = 0;
			int cantSSL8 = 0;
			int cantSSL9 = 0;
			int cantSSL10 = 0;
			int cantSSL11 = 0;
			int cantSSL12 = 0;
			int cantSSL13 = 0;
			int cantSSL14 = 0;
			int cantSSL15 = 0;
			int cantSSL16 = 0;
			//cuenta PA	
			int cantPAL5 = 0;
			int cantPAL6 = 0;
			int cantPAL7 = 0;
			int cantPAL8 = 0;
			int cantPAL9 = 0;
			int cantPAL10 = 0;
			int cantPAL11 = 0;
			int cantPAL12 = 0;
			int cantPAL13 = 0;
			int cantPAL14 = 0;
			int cantPAL15 = 0;
			int cantPAL16 = 0;
			int cantMayor = 0;
			flagAnexoContrato = false;
			
			//Se obtiene numero de linea
			params3 = numLineaAnexo(datosContrato, lineasAnexo2);
			
			if (lineasAnexo < 12){
				if (lineasAnexo == 1){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;

				}else if (lineasAnexo == 2){					
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 3){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 4){
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 5){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 6){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 7){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
					cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 8){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
					cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
					cantPAL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 9){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
					cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
					cantPAL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl().length;
					cantPAL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl().length;
					
				}else if (lineasAnexo == 10){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
					cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
					cantPAL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl().length;
					cantPAL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl().length;
					cantPAL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl().length;
				}else if (lineasAnexo == 11){	
					params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
					
					cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
					cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
					cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
					cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
					cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
					cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
					cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
					cantPAL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl().length;
					cantPAL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl().length;
					cantPAL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl().length;
					cantPAL15 = datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales().length;
					cantSSL15 = datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl().length;
				}						
			}else{//Son mas de 12 lineas	
				params2 = rellenaLinea(params3, datosContrato, lineasAnexo2);
				
				cantPAL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL5 = datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl().length;
				cantPAL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL6 = datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl().length;
				cantPAL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL7 = datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl().length;
				cantPAL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL8 = datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl().length;
				cantPAL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL9 = datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl().length;
				cantPAL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL10 = datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl().length;
				cantPAL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL11 = datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl().length;
				cantPAL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL12 = datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl().length;
				cantPAL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL13 = datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl().length;
				cantPAL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL14 = datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl().length;
				cantPAL15 = datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL15 = datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl().length;
				cantPAL16 = datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales().length;
				cantSSL16 = datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl().length;
			}		
			//Se obtiene cantidad mayor
			
			cantMayor = cantidadMayor(cantPAL5,cantPAL6,cantPAL7,cantPAL8,cantPAL9,cantPAL10,cantPAL11,cantPAL12,cantPAL13,cantPAL14,
									  cantPAL15,cantPAL16,cantSSL5,cantSSL6,cantSSL7,cantSSL8,cantSSL9,cantSSL10,cantSSL11,cantSSL12,
									  cantSSL13,cantSSL14,cantSSL15,cantSSL16);
			
			
			List detalleAnexo = new ArrayList();
			JRBeanCollectionDataSource da = new JRBeanCollectionDataSource(detalleAnexo);
			
			//Obtiene Planes Adiacionales de las lineas			
			//Variables Linea 5
			int auxPAL5 = cantPAL5;
			int aux2PAL5 = 0;
			boolean flagPAL5 = true;
			int auxSSL5 = cantSSL5;
			int aux2SSL5 = 0;
			boolean flagSSL5 = true;
			//Variables Linea 5
			int auxPAL6 = cantPAL6;
			int aux2PAL6 = 0;
			boolean flagPAL6 = true;
			int auxSSL6 = cantSSL6;
			int aux2SSL6 = 0;
			boolean flagSSL6 = true;
			//Variables Linea 7
			int auxPAL7 = cantPAL7;
			int aux2PAL7 = 0;
			boolean flagPAL7 = true;
			int auxSSL7 = cantSSL7;
			int aux2SSL7 = 0;
			boolean flagSSL7 = true;
			//Variables Linea 8
			int auxPAL8 = cantPAL8;
			int aux2PAL8 = 0;
			boolean flagPAL8 = true;
			int auxSSL8 = cantSSL8;
			int aux2SSL8 = 0;
			boolean flagSSL8 = true;
			//Variables Linea 9
			int auxPAL9 = cantPAL9;
			int aux2PAL9 = 0;
			boolean flagPAL9 = true;
			int auxSSL9 = cantSSL9;
			int aux2SSL9 = 0;
			boolean flagSSL9 = true;
			//Variables Linea 10
			int auxPAL10 = cantPAL10;
			int aux2PAL10 = 0;
			boolean flagPAL10 = true;
			int auxSSL10 = cantSSL10;
			int aux2SSL10 = 0;
			boolean flagSSL10 = true;
			//Variables Linea 11
			int auxPAL11 = cantPAL11;
			int aux2PAL11 = 0;
			boolean flagPAL11 = true;
			int auxSSL11 = cantSSL11;
			int aux2SSL11 = 0;
			boolean flagSSL11 = true;
			//Variables Linea 12
			int auxPAL12 = cantPAL12;
			int aux2PAL12 = 0;
			boolean flagPAL12 = true;
			int auxSSL12 = cantSSL12;
			int aux2SSL12 = 0;
			boolean flagSSL12 = true;
			//Variables Linea 13
			int auxPAL13 = cantPAL13;
			int aux2PAL13 = 0;
			boolean flagPAL13 = true;
			int auxSSL13 = cantSSL13;
			int aux2SSL13 = 0;
			boolean flagSSL13 = true;
			//Variables Linea 14
			int auxPAL14 = cantPAL14;
			int aux2PAL14 = 0;
			boolean flagPAL14 = true;
			int auxSSL14 = cantSSL14;
			int aux2SSL14 = 0;
			boolean flagSSL14 = true;
			//Variables Linea 15
			int auxPAL15 = cantPAL15;
			int aux2PAL15 = 0;
			boolean flagPAL15 = true;
			int auxSSL15 = cantSSL15;
			int aux2SSL15 = 0;
			boolean flagSSL15 = true;
			//Variables Linea 16
			int auxPAL16 = cantPAL16;
			int aux2PAL16 = 0;
			boolean flagPAL16 = true;
			int auxSSL16 = cantSSL16;
			int aux2SSL16 = 0;
			boolean flagSSL16 = true;
			
			int cuentaAnexo = 0;
			
			logger.debug("cuentaAnexo: "+ cuentaAnexo);
			logger.debug("cantMayor: "+ cantMayor);
			
			if(cantMayor == 0){
				//No existen PA ni SS opcionales en las lineas				
				params2 = rellenaSSPAOpcionales(params2);				
				filename3 = JasperFillManager.fillReport(sRutaAnexo, params2, da);
				logger.debug("Rellena el resto de las paginas del contrato");				
				logger.debug("agrega paginas al contrato");
				JRPrintPage page = filename3.removePage(0);
				filename.addPage(page);				
			}else{			
				while(cuentaAnexo < cantMayor){
					//La primera vez muestra los datos del Plan de la linea
					//La segunda vez no los muestra
					if (flagAnexoContrato){
						//Entra cuando esta en verdadero
						//Se insertan datos en el anexo de contrato
						if (flagAnexoContrato){				
							//Linea5				
							params2.put("numeroLinea5","");
							params2.put("tipTerminalLinea5","");
							params2.put("numImeiLinea5","");
							params2.put("modeloLinea5","");
							params2.put("numSerieLinea5","");
							params2.put("planTarifLinea5","");
							params2.put("cargoLinea5","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea5","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea5","");
							params2.put("ldiNoLinea5","");
							//Linea6
							params2.put("numeroLinea6","");
							params2.put("tipTerminalLinea6","");
							params2.put("numImeiLinea6","");
							params2.put("modeloLinea6","");
							params2.put("numSerieLinea6","");
							params2.put("planTarifLinea6","");
							params2.put("cargoLinea6","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea6","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea6","");
							params2.put("ldiNoLinea6","");
							//Linea7
							params2.put("numeroLinea7","");
							params2.put("tipTerminalLinea7","");
							params2.put("numImeiLinea7","");
							params2.put("modeloLinea7","");
							params2.put("numSerieLinea7","");
							params2.put("planTarifLinea7","");
							params2.put("cargoLinea7","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea7","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea7","");
							params2.put("ldiNoLinea7","");
							//Linea8
							params2.put("numeroLinea8","");
							params2.put("tipTerminalLinea8","");
							params2.put("numImeiLinea8","");
							params2.put("modeloLinea8","");
							params2.put("numSerieLinea8","");
							params2.put("planTarifLinea8","");
							params2.put("cargoLinea8","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea8","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea8","");
							params2.put("ldiNoLinea8","");
							//Linea9
							params2.put("numeroLinea9","");
							params2.put("tipTerminalLinea9","");
							params2.put("numImeiLinea9","");
							params2.put("modeloLinea9","");
							params2.put("numSerieLinea9","");
							params2.put("planTarifLinea9","");
							params2.put("cargoLinea9","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea9","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea9","");
							params2.put("ldiNoLinea9","");
							//Linea10
							params2.put("numeroLinea10","");
							params2.put("tipTerminalLinea10","");
							params2.put("numImeiLinea10","");
							params2.put("modeloLinea10","");
							params2.put("numSerieLinea10","");
							params2.put("planTarifLinea10","");
							params2.put("cargoLinea10","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea10","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea10","");
							params2.put("ldiNoLinea10","");
							//Linea11
							params2.put("numeroLinea11","");
							params2.put("tipTerminalLinea11","");
							params2.put("numImeiLinea11","");
							params2.put("modeloLinea11","");
							params2.put("numSerieLinea11","");
							params2.put("planTarifLinea11","");
							params2.put("cargoLinea11","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea11","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea11","");
							params2.put("ldiNoLinea11","");
							//Linea12
							params2.put("numeroLinea12","");
							params2.put("tipTerminalLinea12","");
							params2.put("numImeiLinea12","");
							params2.put("modeloLinea12","");
							params2.put("numSerieLinea12","");
							params2.put("planTarifLinea12","");
							params2.put("cargoLinea12","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea12","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea12","");
							params2.put("ldiNoLinea12","");
							//Linea13
							params2.put("numeroLinea13","");
							params2.put("tipTerminalLinea13","");
							params2.put("numImeiLinea13","");
							params2.put("modeloLinea13","");
							params2.put("numSerieLinea13","");
							params2.put("planTarifLinea13","");
							params2.put("cargoLinea13","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea13","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea13","");
							params2.put("ldiNoLinea13","");
							//Linea14
							params2.put("numeroLinea14","");
							params2.put("tipTerminalLinea14","");
							params2.put("numImeiLinea14","");
							params2.put("modeloLinea14","");
							params2.put("numSerieLinea14","");
							params2.put("planTarifLinea14","");
							params2.put("cargoLinea14","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea14","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea14","");
							params2.put("ldiNoLinea14","");
							//Linea15
							params2.put("numeroLinea15","");
							params2.put("tipTerminalLinea15","");
							params2.put("numImeiLinea15","");
							params2.put("modeloLinea15","");
							params2.put("numSerieLinea15","");
							params2.put("planTarifLinea15","");
							params2.put("cargoLinea15","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea15","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea15","");
							params2.put("ldiNoLinea15","");
							//Linea16
							params2.put("numeroLinea16","");
							params2.put("tipTerminalLinea16","");
							params2.put("numImeiLinea16","");
							params2.put("modeloLinea16","");
							params2.put("numSerieLinea16","");
							params2.put("planTarifLinea16","");
							params2.put("cargoLinea16","");
							//P-CSR-11002 JLGN 20-10-2011
							params2.put("limiteConsumoLinea16","");
							//P-CSR-11002 JLGN 25-10-2011
							params2.put("ldiSiLinea16","");
							params2.put("ldiNoLinea16","");
						}
					}
					
					//SS Linea 5				
					if(cantSSL5 != 0){
						if(cantSSL5%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL5 - 4 >= 0)&&(flagSSL5)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");								
								params2.put("servSup1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getNomSS());
								params2.put("valSS1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getValSS());
								params2.put("servSup2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getNomSS());
								params2.put("valSS2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getValSS());
								params2.put("servSup3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getNomSS());
								params2.put("valSS3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getValSS());	
								params2.put("servSup4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+3)].getNomSS());
								params2.put("valSS4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+3)].getValSS());	
								
								aux2SSL5 = aux2SSL5 + 4;
								auxSSL5 = auxSSL5 - 4;								
							}else if((auxSSL5 - 2 >= 0)&&(flagSSL5)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getNomSS());
								params2.put("valSS1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getValSS());
								params2.put("servSup2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getNomSS());
								params2.put("valSS2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getValSS());
								params2.put("servSup3Linea5","");
								params2.put("valSS3Linea5","");	
								params2.put("servSup4Linea5","");
								params2.put("valSS4Linea5","");	
								
								aux2SSL5 = aux2SSL5 + 4;
								auxSSL5 = auxSSL5 - 4;			
								flagSSL5 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "5");
							}						
						}else if(cantSSL5%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL5 - 4 >= 0)&&(flagSSL5)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getNomSS());
								params2.put("valSS1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getValSS());
								params2.put("servSup2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getNomSS());
								params2.put("valSS2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getValSS());
								params2.put("servSup3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getNomSS());
								params2.put("valSS3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getValSS());	
								params2.put("servSup4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+3)].getNomSS());
								params2.put("valSS4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+3)].getValSS());	
								
								aux2SSL5 = aux2SSL5 + 4;
								auxSSL5 = auxSSL5 - 4;								
							}else if((auxSSL5 - 3 >= 0)&&(flagSSL5)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getNomSS());
								params2.put("valSS1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getValSS());
								params2.put("servSup2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getNomSS());
								params2.put("valSS2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+1)].getValSS());
								params2.put("servSup3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getNomSS());
								params2.put("valSS3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[(aux2SSL5+2)].getValSS());	
								params2.put("servSup4Linea5","");
								params2.put("valSS4Linea5","");	
								
								aux2SSL5 = aux2SSL5 + 4;
								auxSSL5 = auxSSL5 - 4;			
								flagSSL5 = false;
							}else if((auxSSL5 - 1 >= 0)&&(flagSSL5)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getNomSS());
								params2.put("valSS1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getServSupl()[aux2SSL5].getValSS());
								params2.put("servSup2Linea5","");
								params2.put("valSS2Linea5","");
								params2.put("servSup3Linea5","");
								params2.put("valSS3Linea5","");	
								params2.put("servSup4Linea5","");
								params2.put("valSS4Linea5","");	
								
								aux2SSL5 = aux2SSL5 + 4;
								auxSSL5 = auxSSL5 - 4;			
								flagSSL5 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "5");
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "5");
					}				
					//PA Linea 5				
					if(cantPAL5 != 0){
						if(cantPAL5%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL5 - 4 >= 0)&&(flagPAL5)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getNomPlanAdi());
								params2.put("valPA1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getValPlanAdi());
								params2.put("planAdi2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getNomPlanAdi());
								params2.put("valPA2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getValPlanAdi());
								params2.put("planAdi3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getNomPlanAdi());
								params2.put("valPA3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getValPlanAdi());
								params2.put("planAdi4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+3)].getNomPlanAdi());
								params2.put("valPA4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+3)].getValPlanAdi());
								
								aux2PAL5 = aux2PAL5 + 4;
								auxPAL5 = auxPAL5 - 4;								
							}else if((auxPAL5 - 2 >= 0)&&(flagPAL5)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getNomPlanAdi());
								params2.put("valPA1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getValPlanAdi());
								params2.put("planAdi2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getNomPlanAdi());
								params2.put("valPA2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getValPlanAdi());
								params2.put("planAdi3Linea5","");
								params2.put("valPA3Linea5","");
								params2.put("planAdi4Linea5","");
								params2.put("valPA4Linea5","");
								
								aux2PAL5 = aux2PAL5 + 4;
								auxPAL5 = auxPAL5 - 4;	
								flagPAL5 = false;
							}else{
								params2 = paOpcionalVacio(params2, "5");
							}
							
						}else if(cantPAL5%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL5 - 4 >= 0)&&(flagPAL5)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getNomPlanAdi());
								params2.put("valPA1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getValPlanAdi());
								params2.put("planAdi2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getNomPlanAdi());
								params2.put("valPA2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getValPlanAdi());
								params2.put("planAdi3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getNomPlanAdi());
								params2.put("valPA3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getValPlanAdi());
								params2.put("planAdi4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+3)].getNomPlanAdi());
								params2.put("valPA4Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+3)].getValPlanAdi());
								
								aux2PAL5 = aux2PAL5 + 4;
								auxPAL5 = auxPAL5 - 4;									
							}else if((auxPAL5 - 3 >= 0)&&(flagPAL5)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getNomPlanAdi());
								params2.put("valPA1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getValPlanAdi());
								params2.put("planAdi2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getNomPlanAdi());
								params2.put("valPA2Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+1)].getValPlanAdi());
								params2.put("planAdi3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getNomPlanAdi());
								params2.put("valPA3Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL5+2)].getValPlanAdi());
								params2.put("planAdi4Linea5","");
								params2.put("valPA4Linea5","");
								
								aux2PAL5 = aux2PAL5 + 4;
								auxPAL5 = auxPAL5 - 4;					
								flagPAL5 = false;
							}else if((auxPAL5 - 1 >= 0)&&(flagPAL5)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getNomPlanAdi());
								params2.put("valPA1Linea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanesAdicionales()[aux2PAL5].getValPlanAdi());
								params2.put("planAdi2Linea5","");
								params2.put("valPA2Linea5","");
								params2.put("planAdi3Linea5","");
								params2.put("valPA3Linea5","");
								params2.put("planAdi4Linea5","");
								params2.put("valPA4Linea5","");
								
								aux2PAL5 = aux2PAL5 + 4;
								auxPAL5 = auxPAL5 - 4;					
								flagPAL5 = false;
							}else{
								params2 = paOpcionalVacio(params2, "5");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "5");
					}
					
					//SS Linea 6			
					if(cantSSL6 != 0){
						if(cantSSL6%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL6 - 4 >= 0)&&(flagSSL6)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getNomSS());
								params2.put("valSS1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getValSS());
								params2.put("servSup2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getNomSS());
								params2.put("valSS2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getValSS());
								params2.put("servSup3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getNomSS());
								params2.put("valSS3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getValSS());	
								params2.put("servSup4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+3)].getNomSS());
								params2.put("valSS4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+3)].getValSS());	
								
								aux2SSL6 = aux2SSL6 + 4;
								auxSSL6 = auxSSL6 - 4;								
							}else if((auxSSL6 - 2 >= 0)&&(flagSSL6)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getNomSS());
								params2.put("valSS1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getValSS());
								params2.put("servSup2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getNomSS());
								params2.put("valSS2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getValSS());
								params2.put("servSup3Linea6","");
								params2.put("valSS3Linea6","");	
								params2.put("servSup4Linea6","");
								params2.put("valSS4Linea6","");	
								
								aux2SSL6 = aux2SSL6 + 4;
								auxSSL6 = auxSSL6 - 4;			
								flagSSL6 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "6");
							}						
						}else if(cantSSL6%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL6 - 4 >= 0)&&(flagSSL6)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getNomSS());
								params2.put("valSS1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getValSS());
								params2.put("servSup2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getNomSS());
								params2.put("valSS2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getValSS());
								params2.put("servSup3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getNomSS());
								params2.put("valSS3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getValSS());	
								params2.put("servSup4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+3)].getNomSS());
								params2.put("valSS4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+3)].getValSS());	
								
								aux2SSL6 = aux2SSL6 + 4;
								auxSSL6 = auxSSL6 - 4;									
							}else if((auxSSL6 - 3 >= 0)&&(flagSSL6)){
								logger.debug("Quedan 3 SS");								
								params2.put("servSup1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getNomSS());
								params2.put("valSS1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getValSS());
								params2.put("servSup2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getNomSS());
								params2.put("valSS2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+1)].getValSS());
								params2.put("servSup3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getNomSS());
								params2.put("valSS3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[(aux2SSL6+2)].getValSS());		
								params2.put("servSup4Linea6","");
								params2.put("valSS4Linea6","");	
								
								aux2SSL6 = aux2SSL6 + 4;
								auxSSL6 = auxSSL6 - 4;				
								flagSSL6 = false;
							}else if((auxSSL6 - 1 >= 0)&&(flagSSL6)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getNomSS());
								params2.put("valSS1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getServSupl()[aux2SSL6].getValSS());
								params2.put("servSup2Linea6","");
								params2.put("valSS2Linea6","");
								params2.put("servSup3Linea6","");
								params2.put("valSS3Linea6","");	
								params2.put("servSup4Linea6","");
								params2.put("valSS4Linea6","");	
								
								aux2SSL6 = aux2SSL6 + 4;
								auxSSL6 = auxSSL6 - 4;				
								flagSSL6 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "6");
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "6");	
					}				
					//PA Linea 6			
					if(cantPAL6 != 0){
						if(cantPAL6%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL6 - 4 >= 0)&&(flagPAL6)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getNomPlanAdi());
								params2.put("valPA1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getValPlanAdi());
								params2.put("planAdi2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getNomPlanAdi());
								params2.put("valPA2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getValPlanAdi());
								params2.put("planAdi3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getNomPlanAdi());
								params2.put("valPA3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getValPlanAdi());
								params2.put("planAdi4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+3)].getNomPlanAdi());
								params2.put("valPA4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+3)].getValPlanAdi());
								
								aux2PAL6 = aux2PAL6 + 4;
								auxPAL6 = auxPAL6 - 4;								
							}else if((auxPAL6 - 2 >= 0)&&(flagPAL6)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getNomPlanAdi());
								params2.put("valPA1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getValPlanAdi());
								params2.put("planAdi2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getNomPlanAdi());
								params2.put("valPA2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getValPlanAdi());
								params2.put("planAdi3Linea6","");
								params2.put("valPA3Linea6","");
								params2.put("planAdi4Linea6","");
								params2.put("valPA4Linea6","");
								
								aux2PAL6 = aux2PAL6 + 4;
								auxPAL6 = auxPAL6 - 4;	
								flagPAL6 = false;
							}else{
								params2 = paOpcionalVacio(params2, "6");
							}						
						}else if(cantPAL6%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL6 - 4 >= 0)&&(flagPAL6)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getNomPlanAdi());
								params2.put("valPA1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getValPlanAdi());
								params2.put("planAdi2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getNomPlanAdi());
								params2.put("valPA2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getValPlanAdi());
								params2.put("planAdi3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getNomPlanAdi());
								params2.put("valPA3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getValPlanAdi());
								params2.put("planAdi4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+3)].getNomPlanAdi());
								params2.put("valPA4Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+3)].getValPlanAdi());
								
								aux2PAL6 = aux2PAL6 + 4;
								auxPAL6 = auxPAL6 - 4;									
							}else if((auxPAL6 - 3 >= 0)&&(flagPAL6)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getNomPlanAdi());
								params2.put("valPA1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getValPlanAdi());
								params2.put("planAdi2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getNomPlanAdi());
								params2.put("valPA2Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+1)].getValPlanAdi());
								params2.put("planAdi3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getNomPlanAdi());
								params2.put("valPA3Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL6+2)].getValPlanAdi());
								params2.put("planAdi4Linea6","");
								params2.put("valPA4Linea6","");
								
								aux2PAL6 = aux2PAL6 + 4;
								auxPAL6 = auxPAL6 - 4;					
								flagPAL6 = false;
							}else if((auxPAL6 - 1 >= 0)&&(flagPAL6)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");								
								params2.put("planAdi1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getNomPlanAdi());
								params2.put("valPA1Linea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanesAdicionales()[aux2PAL6].getValPlanAdi());
								params2.put("planAdi2Linea6","");
								params2.put("valPA2Linea6","");
								params2.put("planAdi3Linea6","");
								params2.put("valPA3Linea6","");
								params2.put("planAdi4Linea6","");
								params2.put("valPA4Linea6","");
								
								aux2PAL6 = aux2PAL6 + 4;
								auxPAL6 = auxPAL6 - 4;					
								flagPAL6 = false;
							}else{
								params2 = paOpcionalVacio(params2, "6");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "6");
					}
	
					//SS Linea 7			
					if(cantSSL7 != 0){
						if(cantSSL7%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL7 - 4 >= 0)&&(flagSSL7)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getNomSS());
								params2.put("valSS1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getValSS());
								params2.put("servSup2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getNomSS());
								params2.put("valSS2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getValSS());
								params2.put("servSup3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getNomSS());
								params2.put("valSS3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getValSS());	
								params2.put("servSup4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+3)].getNomSS());
								params2.put("valSS4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+3)].getValSS());	
								
								aux2SSL7 = aux2SSL7 + 4;
								auxSSL7 = auxSSL7 - 4;								
							}else if((auxSSL7 - 2 >= 0)&&(flagSSL7)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getNomSS());
								params2.put("valSS1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getValSS());
								params2.put("servSup2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getNomSS());
								params2.put("valSS2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getValSS());
								params2.put("servSup3Linea7","");
								params2.put("valSS3Linea7","");	
								params2.put("servSup4Linea7","");
								params2.put("valSS4Linea7","");	
								
								aux2SSL7 = aux2SSL7 + 4;
								auxSSL7 = auxSSL7 - 4;		
								flagSSL7 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "7");	
							}						
						}else if(cantSSL7%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL7 - 4 >= 0)&&(flagSSL7)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getNomSS());
								params2.put("valSS1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getValSS());
								params2.put("servSup2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getNomSS());
								params2.put("valSS2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getValSS());
								params2.put("servSup3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getNomSS());
								params2.put("valSS3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getValSS());	
								params2.put("servSup4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+3)].getNomSS());
								params2.put("valSS4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+3)].getValSS());		
								
								aux2SSL7 = aux2SSL7 + 4;
								auxSSL7 = auxSSL7 - 4;									
							}else if((auxSSL7 - 3 >= 0)&&(flagSSL7)){
								logger.debug("Quedan 3 SS");								
								params2.put("servSup1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getNomSS());
								params2.put("valSS1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getValSS());
								params2.put("servSup2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getNomSS());
								params2.put("valSS2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+1)].getValSS());
								params2.put("servSup3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getNomSS());
								params2.put("valSS3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[(aux2SSL7+2)].getValSS());	
								params2.put("servSup4Linea7","");
								params2.put("valSS4Linea7","");	
								
								aux2SSL7 = aux2SSL7 + 4;
								auxSSL7 = auxSSL7 - 4;				
								flagSSL7 = false;
							}else if((auxSSL7 - 1 >= 0)&&(flagSSL7)){
								logger.debug("Queda 1 SS");								
								params2.put("servSup1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getNomSS());
								params2.put("valSS1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getServSupl()[aux2SSL7].getValSS());
								params2.put("servSup2Linea7","");
								params2.put("valSS2Linea7","");
								params2.put("servSup3Linea7","");
								params2.put("valSS3Linea7","");	
								params2.put("servSup4Linea7","");
								params2.put("valSS4Linea7","");	
								
								aux2SSL7 = aux2SSL7 + 4;
								auxSSL7 = auxSSL7 - 4;				
								flagSSL7 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "7");
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "7");
					}				
					//PA Linea 7			
					if(cantPAL7 != 0){
						if(cantPAL7%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL7 - 4 >= 0)&&(flagPAL7)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getNomPlanAdi());
								params2.put("valPA1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getValPlanAdi());
								params2.put("planAdi2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getNomPlanAdi());
								params2.put("valPA2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getValPlanAdi());
								params2.put("planAdi3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getNomPlanAdi());
								params2.put("valPA3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getValPlanAdi());
								params2.put("planAdi4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+3)].getNomPlanAdi());
								params2.put("valPA4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+3)].getValPlanAdi());
								
								aux2PAL7 = aux2PAL7 + 4;
								auxPAL7 = auxPAL7 - 4;								
							}else if((auxPAL7 - 2 >= 0)&&(flagPAL7)){
								logger.debug("Quedan 2 PA");								
								params2.put("planAdi1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getNomPlanAdi());
								params2.put("valPA1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getValPlanAdi());
								params2.put("planAdi2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getNomPlanAdi());
								params2.put("valPA2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getValPlanAdi());
								params2.put("planAdi3Linea7","");
								params2.put("valPA3Linea7","");
								params2.put("planAdi4Linea7","");
								params2.put("valPA4Linea7","");
								
								aux2PAL7 = aux2PAL7 + 4;
								auxPAL7 = auxPAL7 - 4;	
								flagPAL7 = false;
							}else{
								params2 = paOpcionalVacio(params2, "7");
							}						
						}else if(cantPAL7%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL7 - 4 >= 0)&&(flagPAL7)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getNomPlanAdi());
								params2.put("valPA1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getValPlanAdi());
								params2.put("planAdi2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getNomPlanAdi());
								params2.put("valPA2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getValPlanAdi());
								params2.put("planAdi3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getNomPlanAdi());
								params2.put("valPA3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getValPlanAdi());
								params2.put("planAdi4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+3)].getNomPlanAdi());
								params2.put("valPA4Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+3)].getValPlanAdi());
								
								aux2PAL7 = aux2PAL7 + 4;
								auxPAL7 = auxPAL7 - 4;									
							}else if((auxPAL7 - 3 >= 0)&&(flagPAL7)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");								
								params2.put("planAdi1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getNomPlanAdi());
								params2.put("valPA1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getValPlanAdi());
								params2.put("planAdi2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getNomPlanAdi());
								params2.put("valPA2Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+1)].getValPlanAdi());
								params2.put("planAdi3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getNomPlanAdi());
								params2.put("valPA3Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL7+2)].getValPlanAdi());
								params2.put("planAdi4Linea7","");
								params2.put("valPA4Linea7","");
								
								aux2PAL7 = aux2PAL7 + 4;
								auxPAL7 = auxPAL7 - 4;	
								flagPAL7 = false;
							}else if((auxPAL7 - 1 >= 0)&&(flagPAL7)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");								
								params2.put("planAdi1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getNomPlanAdi());
								params2.put("valPA1Linea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanesAdicionales()[aux2PAL7].getValPlanAdi());
								params2.put("planAdi2Linea7","");
								params2.put("valPA2Linea7","");
								params2.put("planAdi3Linea7","");
								params2.put("valPA3Linea7","");
								params2.put("planAdi4Linea7","");
								params2.put("valPA4Linea7","");
								
								aux2PAL7 = aux2PAL7 + 4;
								auxPAL7 = auxPAL7 - 4;	
								flagPAL7 = false;
							}else{
								params2 = paOpcionalVacio(params2, "7");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "7");
					}				
					
					//SS Linea 8			
					if(cantSSL8 != 0){
						if(cantSSL8%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL8 - 4 >= 0)&&(flagSSL8)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getNomSS());
								params2.put("valSS1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getValSS());
								params2.put("servSup2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getNomSS());
								params2.put("valSS2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getValSS());
								params2.put("servSup3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getNomSS());
								params2.put("valSS3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getValSS());	
								params2.put("servSup4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+3)].getNomSS());
								params2.put("valSS4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+3)].getValSS());	
								
								aux2SSL8 = aux2SSL8 + 4;
								auxSSL8 = auxSSL8 - 4;								
							}else if((auxSSL8 - 2 >= 0)&&(flagSSL8)){
								logger.debug("Quedan 2 SS");								
								params2.put("servSup1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getNomSS());
								params2.put("valSS1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getValSS());
								params2.put("servSup2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getNomSS());
								params2.put("valSS2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getValSS());
								params2.put("servSup3Linea8","");
								params2.put("valSS3Linea8","");	
								params2.put("servSup4Linea8","");
								params2.put("valSS4Linea8","");	
								
								aux2SSL8 = aux2SSL8 + 4;
								auxSSL8 = auxSSL8 - 4;						
								flagSSL8 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "8");	
							}						
						}else if(cantSSL8%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL8 - 4 >= 0)&&(flagSSL8)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getNomSS());
								params2.put("valSS1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getValSS());
								params2.put("servSup2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getNomSS());
								params2.put("valSS2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getValSS());
								params2.put("servSup3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getNomSS());
								params2.put("valSS3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getValSS());	
								params2.put("servSup4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+3)].getNomSS());
								params2.put("valSS4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+3)].getValSS());		
								
								aux2SSL8 = aux2SSL8 + 4;
								auxSSL8 = auxSSL8 - 4;					
							}else if((auxSSL8 - 3 >= 0)&&(flagSSL8)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getNomSS());
								params2.put("valSS1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getValSS());
								params2.put("servSup2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getNomSS());
								params2.put("valSS2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+1)].getValSS());
								params2.put("servSup3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getNomSS());
								params2.put("valSS3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[(aux2SSL8+2)].getValSS());		
								params2.put("servSup4Linea8","");
								params2.put("valSS4Linea8","");	
								
								aux2SSL8 = aux2SSL8 + 4;
								auxSSL8 = auxSSL8 - 4;						
								flagSSL8 = false;
							}else if((auxSSL8 - 1 >= 0)&&(flagSSL8)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getNomSS());
								params2.put("valSS1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getServSupl()[aux2SSL8].getValSS());
								params2.put("servSup2Linea8","");
								params2.put("valSS2Linea8","");
								params2.put("servSup3Linea8","");
								params2.put("valSS3Linea8","");	
								params2.put("servSup4Linea8","");
								params2.put("valSS4Linea8","");	
								
								aux2SSL8 = aux2SSL8 + 4;
								auxSSL8 = auxSSL8 - 4;						
								flagSSL8 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "8");
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "8");
					}				
					//PA Linea 8		
					if(cantPAL8 != 0){
						if(cantPAL8%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL8 - 4 >= 0)&&(flagPAL8)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getNomPlanAdi());
								params2.put("valPA1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getValPlanAdi());
								params2.put("planAdi2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getNomPlanAdi());
								params2.put("valPA2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getValPlanAdi());
								params2.put("planAdi3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getNomPlanAdi());
								params2.put("valPA3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getValPlanAdi());
								params2.put("planAdi4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+3)].getNomPlanAdi());
								params2.put("valPA4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+3)].getValPlanAdi());
								
								aux2PAL8 = aux2PAL8 + 4;
								auxPAL8 = auxPAL8 - 4;								
							}else if((auxPAL8 - 2 >= 0)&&(flagPAL8)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getNomPlanAdi());
								params2.put("valPA1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getValPlanAdi());
								params2.put("planAdi2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getNomPlanAdi());
								params2.put("valPA2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getValPlanAdi());
								params2.put("planAdi3Linea8","");
								params2.put("valPA3Linea8","");
								params2.put("planAdi4Linea8","");
								params2.put("valPA4Linea8","");
								
								aux2PAL8 = aux2PAL8 + 4;
								auxPAL8 = auxPAL8 - 4;	
								flagPAL8 = false;
							}else{
								params2 = paOpcionalVacio(params2, "8");
							}						
						}else if(cantPAL8%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL8 - 4 >= 0)&&(flagPAL8)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getNomPlanAdi());
								params2.put("valPA1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getValPlanAdi());
								params2.put("planAdi2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getNomPlanAdi());
								params2.put("valPA2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getValPlanAdi());
								params2.put("planAdi3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getNomPlanAdi());
								params2.put("valPA3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getValPlanAdi());
								params2.put("planAdi4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+3)].getNomPlanAdi());
								params2.put("valPA4Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+3)].getValPlanAdi());
								
								aux2PAL8 = aux2PAL8 + 4;
								auxPAL8 = auxPAL8 - 4;												
							}else if((auxPAL8 - 3 >= 0)&&(flagPAL8)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getNomPlanAdi());
								params2.put("valPA1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getValPlanAdi());
								params2.put("planAdi2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getNomPlanAdi());
								params2.put("valPA2Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+1)].getValPlanAdi());
								params2.put("planAdi3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getNomPlanAdi());
								params2.put("valPA3Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL8+2)].getValPlanAdi());
								params2.put("planAdi4Linea8","");
								params2.put("valPA4Linea8","");
								
								aux2PAL8 = aux2PAL8 + 4;
								auxPAL8 = auxPAL8 - 4;				
								flagPAL8 = false;
							}else if((auxPAL8 - 1 >= 0)&&(flagPAL8)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getNomPlanAdi());
								params2.put("valPA1Linea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanesAdicionales()[aux2PAL8].getValPlanAdi());
								params2.put("planAdi2Linea8","");
								params2.put("valPA2Linea8","");
								params2.put("planAdi3Linea8","");
								params2.put("valPA3Linea8","");
								params2.put("planAdi4Linea8","");
								params2.put("valPA4Linea8","");
								
								aux2PAL8 = aux2PAL8 + 4;
								auxPAL8 = auxPAL8 - 4;				
								flagPAL8 = false;
							}else{
								params2 = paOpcionalVacio(params2, "8");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "8");
					}			
					
					//SS Linea 9			
					if(cantSSL9 != 0){
						if(cantSSL9%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL9 - 4 >= 0)&&(flagSSL9)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getNomSS());
								params2.put("valSS1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getValSS());
								params2.put("servSup2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getNomSS());
								params2.put("valSS2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getValSS());
								params2.put("servSup3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getNomSS());
								params2.put("valSS3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getValSS());	
								params2.put("servSup4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+3)].getNomSS());
								params2.put("valSS4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+3)].getValSS());	
								
								aux2SSL9 = aux2SSL9 + 4;
								auxSSL9 = auxSSL9 - 4;								
							}else if((auxSSL9 - 2 >= 0)&&(flagSSL9)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getNomSS());
								params2.put("valSS1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getValSS());
								params2.put("servSup2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getNomSS());
								params2.put("valSS2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getValSS());
								params2.put("servSup3Linea9","");
								params2.put("valSS3Linea9","");	
								params2.put("servSup4Linea9","");
								params2.put("valSS4Linea9","");	
								
								aux2SSL9 = aux2SSL9 + 4;
								auxSSL9 = auxSSL9 - 4;						
								flagSSL9 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "9");	
							}						
						}else if(cantSSL9%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL9 - 4 >= 0)&&(flagSSL9)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getNomSS());
								params2.put("valSS1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getValSS());
								params2.put("servSup2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getNomSS());
								params2.put("valSS2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getValSS());
								params2.put("servSup3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getNomSS());
								params2.put("valSS3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getValSS());	
								params2.put("servSup4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+3)].getNomSS());
								params2.put("valSS4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+3)].getValSS());		
								
								aux2SSL9 = aux2SSL9 + 4;
								auxSSL9 = auxSSL9 - 4;					
							}else if((auxSSL9 - 3 >= 0)&&(flagSSL9)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getNomSS());
								params2.put("valSS1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getValSS());
								params2.put("servSup2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getNomSS());
								params2.put("valSS2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+1)].getValSS());
								params2.put("servSup3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getNomSS());
								params2.put("valSS3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[(aux2SSL9+2)].getValSS());		
								params2.put("servSup4Linea9","");
								params2.put("valSS4Linea9","");	
								
								aux2SSL9 = aux2SSL9 + 4;
								auxSSL9 = auxSSL9 - 4;						
								flagSSL9 = false;
							}else if((auxSSL9 - 1 >= 0)&&(flagSSL9)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getNomSS());
								params2.put("valSS1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getServSupl()[aux2SSL9].getValSS());
								params2.put("servSup2Linea9","");
								params2.put("valSS2Linea9","");
								params2.put("servSup3Linea9","");
								params2.put("valSS3Linea9","");	
								params2.put("servSup4Linea9","");
								params2.put("valSS4Linea9","");	
								
								aux2SSL9 = aux2SSL9 + 4;
								auxSSL9 = auxSSL9 - 4;						
								flagSSL9 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "9");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "9");	
					}				
					//PA Linea 9		
					if(cantPAL9 != 0){
						if(cantPAL9%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL9 - 4 >= 0)&&(flagPAL9)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getNomPlanAdi());
								params2.put("valPA1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getValPlanAdi());
								params2.put("planAdi2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getNomPlanAdi());
								params2.put("valPA2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getValPlanAdi());
								params2.put("planAdi3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getNomPlanAdi());
								params2.put("valPA3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getValPlanAdi());
								params2.put("planAdi4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+3)].getNomPlanAdi());
								params2.put("valPA4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+3)].getValPlanAdi());
								
								aux2PAL9 = aux2PAL9 + 4;
								auxPAL9 = auxPAL9 - 4;								
							}else if((auxPAL9 - 2 >= 0)&&(flagPAL9)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getNomPlanAdi());
								params2.put("valPA1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getValPlanAdi());
								params2.put("planAdi2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getNomPlanAdi());
								params2.put("valPA2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getValPlanAdi());
								params2.put("planAdi3Linea9","");
								params2.put("valPA3Linea9","");
								params2.put("planAdi4Linea9","");
								params2.put("valPA4Linea9","");
								
								aux2PAL9 = aux2PAL9 + 4;
								auxPAL9 = auxPAL9 - 4;	
								flagPAL9 = false;
							}else{
								params2 = paOpcionalVacio(params2, "9");
							}						
						}else if(cantPAL9%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL9 - 4 >= 0)&&(flagPAL9)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getNomPlanAdi());
								params2.put("valPA1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getValPlanAdi());
								params2.put("planAdi2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getNomPlanAdi());
								params2.put("valPA2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getValPlanAdi());
								params2.put("planAdi3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getNomPlanAdi());
								params2.put("valPA3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getValPlanAdi());
								params2.put("planAdi4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+3)].getNomPlanAdi());
								params2.put("valPA4Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+3)].getValPlanAdi());
								
								aux2PAL9 = aux2PAL9 + 4;
								auxPAL9 = auxPAL9 - 4;												
							}else if((auxPAL9 - 3 >= 0)&&(flagPAL9)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getNomPlanAdi());
								params2.put("valPA1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getValPlanAdi());
								params2.put("planAdi2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getNomPlanAdi());
								params2.put("valPA2Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+1)].getValPlanAdi());
								params2.put("planAdi3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getNomPlanAdi());
								params2.put("valPA3Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL9+2)].getValPlanAdi());
								params2.put("planAdi4Linea9","");
								params2.put("valPA4Linea9","");
								
								aux2PAL9 = aux2PAL9 + 4;
								auxPAL9 = auxPAL9 - 4;				
								flagPAL9 = false;
							}else if((auxPAL9 - 1 >= 0)&&(flagPAL9)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getNomPlanAdi());
								params2.put("valPA1Linea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanesAdicionales()[aux2PAL9].getValPlanAdi());
								params2.put("planAdi2Linea9","");
								params2.put("valPA2Linea9","");
								params2.put("planAdi3Linea9","");
								params2.put("valPA3Linea9","");
								params2.put("planAdi4Linea9","");
								params2.put("valPA4Linea9","");
								
								aux2PAL9 = aux2PAL9 + 4;
								auxPAL9 = auxPAL9 - 4;				
								flagPAL9 = false;
							}else{
								params2 = paOpcionalVacio(params2, "9");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "9");
					}				
					
					//SS Linea 10			
					if(cantSSL10 != 0){
						if(cantSSL10%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL10 - 4 >= 0)&&(flagSSL10)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getNomSS());
								params2.put("valSS1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getValSS());
								params2.put("servSup2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getNomSS());
								params2.put("valSS2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getValSS());
								params2.put("servSup3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getNomSS());
								params2.put("valSS3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getValSS());	
								params2.put("servSup4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+3)].getNomSS());
								params2.put("valSS4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+3)].getValSS());	
								
								aux2SSL10 = aux2SSL10 + 4;
								auxSSL10 = auxSSL10 - 4;								
							}else if((auxSSL10 - 2 >= 0)&&(flagSSL10)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getNomSS());
								params2.put("valSS1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getValSS());
								params2.put("servSup2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getNomSS());
								params2.put("valSS2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getValSS());
								params2.put("servSup3Linea10","");
								params2.put("valSS3Linea10","");	
								params2.put("servSup4Linea10","");
								params2.put("valSS4Linea10","");	
								
								aux2SSL10 = aux2SSL10 + 4;
								auxSSL10 = auxSSL10 - 4;						
								flagSSL10 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "10");	
							}						
						}else if(cantSSL10%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL10 - 4 >= 0)&&(flagSSL10)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getNomSS());
								params2.put("valSS1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getValSS());
								params2.put("servSup2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getNomSS());
								params2.put("valSS2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getValSS());
								params2.put("servSup3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getNomSS());
								params2.put("valSS3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getValSS());	
								params2.put("servSup4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+3)].getNomSS());
								params2.put("valSS4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+3)].getValSS());
								
								aux2SSL10 = aux2SSL10 + 4;
								auxSSL10 = auxSSL10 - 4;					
							}else if((auxSSL10 - 3 >= 0)&&(flagSSL10)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getNomSS());
								params2.put("valSS1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getValSS());
								params2.put("servSup2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getNomSS());
								params2.put("valSS2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+1)].getValSS());
								params2.put("servSup3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getNomSS());
								params2.put("valSS3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[(aux2SSL10+2)].getValSS());
								params2.put("servSup4Linea10","");
								params2.put("valSS4Linea10","");	
								
								aux2SSL10 = aux2SSL10 + 4;
								auxSSL10 = auxSSL10 - 4;						
								flagSSL10 = false;
							}else if((auxSSL10 - 1 >= 0)&&(flagSSL10)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getNomSS());
								params2.put("valSS1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getServSupl()[aux2SSL10].getValSS());
								params2.put("servSup2Linea10","");
								params2.put("valSS2Linea10","");
								params2.put("servSup3Linea10","");
								params2.put("valSS3Linea10","");	
								params2.put("servSup4Linea10","");
								params2.put("valSS4Linea10","");	
								
								aux2SSL10 = aux2SSL10 + 4;
								auxSSL10 = auxSSL10 - 4;						
								flagSSL10 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "10");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "10");	
					}				
					//PA Linea 10		
					if(cantPAL10 != 0){
						if(cantPAL10%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL10 - 4 >= 0)&&(flagPAL10)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getNomPlanAdi());
								params2.put("valPA1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getValPlanAdi());
								params2.put("planAdi2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getNomPlanAdi());
								params2.put("valPA2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getValPlanAdi());
								params2.put("planAdi3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getNomPlanAdi());
								params2.put("valPA3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getValPlanAdi());
								params2.put("planAdi4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+3)].getNomPlanAdi());
								params2.put("valPA4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+3)].getValPlanAdi());
								
								aux2PAL10 = aux2PAL10 + 4;
								auxPAL10 = auxPAL10 - 4;								
							}else if((auxPAL10 - 2 >= 0)&&(flagPAL10)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getNomPlanAdi());
								params2.put("valPA1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getValPlanAdi());
								params2.put("planAdi2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getNomPlanAdi());
								params2.put("valPA2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getValPlanAdi());
								params2.put("planAdi3Linea10","");
								params2.put("valPA3Linea10","");
								params2.put("planAdi4Linea10","");
								params2.put("valPA4Linea10","");
								
								aux2PAL10 = aux2PAL10 + 4;
								auxPAL10 = auxPAL10 - 4;	
								flagPAL10 = false;
							}else{
								params2 = paOpcionalVacio(params2, "10");
							}						
						}else if(cantPAL10%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL10 - 4 >= 0)&&(flagPAL10)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getNomPlanAdi());
								params2.put("valPA1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getValPlanAdi());
								params2.put("planAdi2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getNomPlanAdi());
								params2.put("valPA2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getValPlanAdi());
								params2.put("planAdi3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getNomPlanAdi());
								params2.put("valPA3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getValPlanAdi());
								params2.put("planAdi4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+3)].getNomPlanAdi());
								params2.put("valPA4Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+3)].getValPlanAdi());
								
								aux2PAL10 = aux2PAL10 + 4;
								auxPAL10 = auxPAL10 - 4;												
							}else if((auxPAL10 - 3 >= 0)&&(flagPAL10)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getNomPlanAdi());
								params2.put("valPA1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getValPlanAdi());
								params2.put("planAdi2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getNomPlanAdi());
								params2.put("valPA2Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+1)].getValPlanAdi());
								params2.put("planAdi3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getNomPlanAdi());
								params2.put("valPA3Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL10+2)].getValPlanAdi());
								params2.put("planAdi4Linea10","");
								params2.put("valPA4Linea10","");
								
								aux2PAL10 = aux2PAL10 + 4;
								auxPAL10 = auxPAL10 - 4;				
								flagPAL10 = false;
							}else if((auxPAL10 - 1 >= 0)&&(flagPAL10)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getNomPlanAdi());
								params2.put("valPA1Linea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanesAdicionales()[aux2PAL10].getValPlanAdi());
								params2.put("planAdi2Linea10","");
								params2.put("valPA2Linea10","");
								params2.put("planAdi3Linea10","");
								params2.put("valPA3Linea10","");
								params2.put("planAdi4Linea10","");
								params2.put("valPA4Linea10","");
								
								aux2PAL10 = aux2PAL10 + 4;
								auxPAL10 = auxPAL10 - 4;				
								flagPAL10 = false;
							}else{
								params2 = paOpcionalVacio(params2, "10");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "10");
					}								
					
					//SS Linea 11			
					if(cantSSL11 != 0){
						if(cantSSL11%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL11 - 4 >= 0)&&(flagSSL11)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");								
								params2.put("servSup1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getNomSS());
								params2.put("valSS1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getValSS());
								params2.put("servSup2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getNomSS());
								params2.put("valSS2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getValSS());
								params2.put("servSup3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getNomSS());
								params2.put("valSS3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getValSS());	
								params2.put("servSup4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+3)].getNomSS());
								params2.put("valSS4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+3)].getValSS());	
								
								aux2SSL11 = aux2SSL11 + 4;
								auxSSL11 = auxSSL11 - 4;								
							}else if((auxSSL11 - 2 >= 0)&&(flagSSL11)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getNomSS());
								params2.put("valSS1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getValSS());
								params2.put("servSup2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getNomSS());
								params2.put("valSS2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getValSS());
								params2.put("servSup3Linea11","");
								params2.put("valSS3Linea11","");	
								params2.put("servSup4Linea11","");
								params2.put("valSS4Linea11","");	
								
								aux2SSL11 = aux2SSL11 + 4;
								auxSSL11 = auxSSL11 - 4;						
								flagSSL11 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "11");	
							}						
						}else if(cantSSL11%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL11 - 4 >= 0)&&(flagSSL11)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getNomSS());
								params2.put("valSS1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getValSS());
								params2.put("servSup2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getNomSS());
								params2.put("valSS2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getValSS());
								params2.put("servSup3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getNomSS());
								params2.put("valSS3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getValSS());	
								params2.put("servSup4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+3)].getNomSS());
								params2.put("valSS4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+3)].getValSS());	
								
								aux2SSL11 = aux2SSL11 + 4;
								auxSSL11 = auxSSL11 - 4;					
							}else if((auxSSL11 - 3 >= 0)&&(flagSSL11)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getNomSS());
								params2.put("valSS1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getValSS());
								params2.put("servSup2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getNomSS());
								params2.put("valSS2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+1)].getValSS());
								params2.put("servSup3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getNomSS());
								params2.put("valSS3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[(aux2SSL11+2)].getValSS());
								params2.put("servSup4Linea11","");
								params2.put("valSS4Linea11","");	
								
								aux2SSL11 = aux2SSL11 + 4;
								auxSSL11 = auxSSL11 - 4;						
								flagSSL11 = false;
							}else if((auxSSL11 - 1 >= 0)&&(flagSSL11)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getNomSS());
								params2.put("valSS1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getServSupl()[aux2SSL11].getValSS());
								params2.put("servSup2Linea11","");
								params2.put("valSS2Linea11","");
								params2.put("servSup3Linea11","");
								params2.put("valSS3Linea11","");	
								params2.put("servSup4Linea11","");
								params2.put("valSS4Linea11","");	
								
								aux2SSL11 = aux2SSL11 + 4;
								auxSSL11 = auxSSL11 - 4;						
								flagSSL11 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "11");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "11");	
					}				
					//PA Linea 11		
					if(cantPAL11 != 0){
						if(cantPAL11%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL11 - 4 >= 0)&&(flagPAL11)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getNomPlanAdi());
								params2.put("valPA1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getValPlanAdi());
								params2.put("planAdi2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getNomPlanAdi());
								params2.put("valPA2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getValPlanAdi());
								params2.put("planAdi3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getNomPlanAdi());
								params2.put("valPA3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getValPlanAdi());
								params2.put("planAdi4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+3)].getNomPlanAdi());
								params2.put("valPA4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+3)].getValPlanAdi());
								
								aux2PAL11 = aux2PAL11 + 4;
								auxPAL11 = auxPAL11 - 4;								
							}else if((auxPAL11 - 2 >= 0)&&(flagPAL11)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getNomPlanAdi());
								params2.put("valPA1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getValPlanAdi());
								params2.put("planAdi2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getNomPlanAdi());
								params2.put("valPA2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getValPlanAdi());
								params2.put("planAdi3Linea11","");
								params2.put("valPA3Linea11","");
								params2.put("planAdi4Linea11","");
								params2.put("valPA4Linea11","");
								
								aux2PAL11 = aux2PAL11 + 4;
								auxPAL11 = auxPAL11 - 4;	
								flagPAL11 = false;
							}else{
								params2 = paOpcionalVacio(params2, "11");
							}						
						}else if(cantPAL11%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL11 - 4 >= 0)&&(flagPAL11)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getNomPlanAdi());
								params2.put("valPA1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getValPlanAdi());
								params2.put("planAdi2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getNomPlanAdi());
								params2.put("valPA2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getValPlanAdi());
								params2.put("planAdi3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getNomPlanAdi());
								params2.put("valPA3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getValPlanAdi());
								params2.put("planAdi4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+3)].getNomPlanAdi());
								params2.put("valPA4Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+3)].getValPlanAdi());
								
								aux2PAL11 = aux2PAL11 + 4;
								auxPAL11 = auxPAL11 - 4;												
							}else if((auxPAL11 - 3 >= 0)&&(flagPAL11)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getNomPlanAdi());
								params2.put("valPA1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getValPlanAdi());
								params2.put("planAdi2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getNomPlanAdi());
								params2.put("valPA2Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+1)].getValPlanAdi());
								params2.put("planAdi3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getNomPlanAdi());
								params2.put("valPA3Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL11+2)].getValPlanAdi());
								params2.put("planAdi4Linea11","");
								params2.put("valPA4Linea11","");
								
								aux2PAL11 = aux2PAL11 + 4;
								auxPAL11 = auxPAL11 - 4;				
								flagPAL11 = false;
							}else if((auxPAL11 - 1 >= 0)&&(flagPAL11)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getNomPlanAdi());
								params2.put("valPA1Linea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanesAdicionales()[aux2PAL11].getValPlanAdi());
								params2.put("planAdi2Linea11","");
								params2.put("valPA2Linea11","");
								params2.put("planAdi3Linea11","");
								params2.put("valPA3Linea11","");
								params2.put("planAdi4Linea11","");
								params2.put("valPA4Linea11","");
								
								aux2PAL11 = aux2PAL11 + 4;
								auxPAL11 = auxPAL11 - 4;				
								flagPAL11 = false;
							}else{
								params2 = paOpcionalVacio(params2, "11");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "11");
					}				
					
					//SS Linea 12			
					if(cantSSL12 != 0){
						if(cantSSL12%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL12 - 4 >= 0)&&(flagSSL12)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getNomSS());
								params2.put("valSS1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getValSS());
								params2.put("servSup2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getNomSS());
								params2.put("valSS2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getValSS());
								params2.put("servSup3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getNomSS());
								params2.put("valSS3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getValSS());	
								params2.put("servSup4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+3)].getNomSS());
								params2.put("valSS4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+3)].getValSS());	
								
								aux2SSL12 = aux2SSL12 + 4;
								auxSSL12 = auxSSL12 - 4;								
							}else if((auxSSL12 - 2 >= 0)&&(flagSSL12)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getNomSS());
								params2.put("valSS1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getValSS());
								params2.put("servSup2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getNomSS());
								params2.put("valSS2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getValSS());
								params2.put("servSup3Linea12","");
								params2.put("valSS3Linea12","");	
								params2.put("servSup4Linea12","");
								params2.put("valSS4Linea12","");	
								
								aux2SSL12 = aux2SSL12 + 4;
								auxSSL12 = auxSSL12 - 4;						
								flagSSL12 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "12");	
							}						
						}else if(cantSSL12%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL12 - 4 >= 0)&&(flagSSL12)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getNomSS());
								params2.put("valSS1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getValSS());
								params2.put("servSup2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getNomSS());
								params2.put("valSS2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getValSS());
								params2.put("servSup3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getNomSS());
								params2.put("valSS3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getValSS());	
								params2.put("servSup4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+3)].getNomSS());
								params2.put("valSS4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+3)].getValSS());	
								
								aux2SSL12 = aux2SSL12 + 4;
								auxSSL12 = auxSSL12 - 4;					
							}else if((auxSSL12 - 3 >= 0)&&(flagSSL12)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getNomSS());
								params2.put("valSS1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getValSS());
								params2.put("servSup2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getNomSS());
								params2.put("valSS2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+1)].getValSS());
								params2.put("servSup3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getNomSS());
								params2.put("valSS3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[(aux2SSL12+2)].getValSS());
								params2.put("servSup4Linea12","");
								params2.put("valSS4Linea12","");	
								
								aux2SSL12 = aux2SSL12 + 4;
								auxSSL12 = auxSSL12 - 4;						
								flagSSL12 = false;
							}else if((auxSSL12 - 1 >= 0)&&(flagSSL12)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getNomSS());
								params2.put("valSS1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getServSupl()[aux2SSL12].getValSS());
								params2.put("servSup2Linea12","");
								params2.put("valSS2Linea12","");
								params2.put("servSup3Linea12","");
								params2.put("valSS3Linea12","");	
								params2.put("servSup4Linea12","");
								params2.put("valSS4Linea12","");	
								
								aux2SSL12 = aux2SSL12 + 4;
								auxSSL12 = auxSSL12 - 4;						
								flagSSL12 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "12");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "12");	
					}				
					//PA Linea 12		
					if(cantPAL12 != 0){
						if(cantPAL12%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL12 - 4 >= 0)&&(flagPAL12)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getNomPlanAdi());
								params2.put("valPA1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getValPlanAdi());
								params2.put("planAdi2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getNomPlanAdi());
								params2.put("valPA2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getValPlanAdi());
								params2.put("planAdi3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getNomPlanAdi());
								params2.put("valPA3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getValPlanAdi());
								params2.put("planAdi4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+3)].getNomPlanAdi());
								params2.put("valPA4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+3)].getValPlanAdi());
								
								aux2PAL12 = aux2PAL12 + 4;
								auxPAL12 = auxPAL12 - 4;								
							}else if((auxPAL12 - 2 >= 0)&&(flagPAL12)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getNomPlanAdi());
								params2.put("valPA1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getValPlanAdi());
								params2.put("planAdi2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getNomPlanAdi());
								params2.put("valPA2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getValPlanAdi());
								params2.put("planAdi3Linea12","");
								params2.put("valPA3Linea12","");
								params2.put("planAdi4Linea12","");
								params2.put("valPA4Linea12","");
								
								aux2PAL12 = aux2PAL12 + 4;
								auxPAL12 = auxPAL12 - 4;	
								flagPAL12 = false;
							}else{
								params2 = paOpcionalVacio(params2, "12");
							}						
						}else if(cantPAL12%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL12 - 4 >= 0)&&(flagPAL12)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getNomPlanAdi());
								params2.put("valPA1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getValPlanAdi());
								params2.put("planAdi2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getNomPlanAdi());
								params2.put("valPA2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getValPlanAdi());
								params2.put("planAdi3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getNomPlanAdi());
								params2.put("valPA3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getValPlanAdi());
								params2.put("planAdi4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+3)].getNomPlanAdi());
								params2.put("valPA4Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+3)].getValPlanAdi());
								
								aux2PAL12 = aux2PAL12 + 4;
								auxPAL12 = auxPAL12 - 4;												
							}else if((auxPAL12 - 3 >= 0)&&(flagPAL12)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getNomPlanAdi());
								params2.put("valPA1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getValPlanAdi());
								params2.put("planAdi2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getNomPlanAdi());
								params2.put("valPA2Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+1)].getValPlanAdi());
								params2.put("planAdi3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getNomPlanAdi());
								params2.put("valPA3Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL12+2)].getValPlanAdi());
								params2.put("planAdi4Linea12","");
								params2.put("valPA4Linea12","");
								
								aux2PAL12 = aux2PAL12 + 4;
								auxPAL12 = auxPAL12 - 4;				
								flagPAL12 = false;
							}else if((auxPAL12 - 1 >= 0)&&(flagPAL12)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getNomPlanAdi());
								params2.put("valPA1Linea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanesAdicionales()[aux2PAL12].getValPlanAdi());
								params2.put("planAdi2Linea12","");
								params2.put("valPA2Linea12","");
								params2.put("planAdi3Linea12","");
								params2.put("valPA3Linea12","");
								params2.put("planAdi4Linea12","");
								params2.put("valPA4Linea12","");
								
								aux2PAL12 = aux2PAL12 + 4;
								auxPAL12 = auxPAL12 - 4;				
								flagPAL12 = false;
							}else{
								params2 = paOpcionalVacio(params2, "12");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "12");
					}				
					
					//SS Linea 13			
					if(cantSSL13 != 0){
						if(cantSSL13%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL13 - 4 >= 0)&&(flagSSL13)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getNomSS());
								params2.put("valSS1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getValSS());
								params2.put("servSup2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getNomSS());
								params2.put("valSS2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getValSS());
								params2.put("servSup3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getNomSS());
								params2.put("valSS3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getValSS());	
								params2.put("servSup4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+3)].getNomSS());
								params2.put("valSS4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+3)].getValSS());	
								
								aux2SSL13 = aux2SSL13 + 4;
								auxSSL13 = auxSSL13 - 4;								
							}else if((auxSSL13 - 2 >= 0)&&(flagSSL13)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getNomSS());
								params2.put("valSS1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getValSS());
								params2.put("servSup2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getNomSS());
								params2.put("valSS2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getValSS());
								params2.put("servSup3Linea13","");
								params2.put("valSS3Linea13","");	
								params2.put("servSup4Linea13","");
								params2.put("valSS4Linea13","");	
								
								aux2SSL13 = aux2SSL13 + 4;
								auxSSL13 = auxSSL13 - 4;						
								flagSSL13 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "13");	
							}						
						}else if(cantSSL13%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL13 - 4 >= 0)&&(flagSSL13)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getNomSS());
								params2.put("valSS1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getValSS());
								params2.put("servSup2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getNomSS());
								params2.put("valSS2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getValSS());
								params2.put("servSup3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getNomSS());
								params2.put("valSS3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getValSS());	
								params2.put("servSup4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+3)].getNomSS());
								params2.put("valSS4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+3)].getValSS());		
								
								aux2SSL13 = aux2SSL13 + 4;
								auxSSL13 = auxSSL13 - 4;					
							}else if((auxSSL13 - 3 >= 0)&&(flagSSL13)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getNomSS());
								params2.put("valSS1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getValSS());
								params2.put("servSup2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getNomSS());
								params2.put("valSS2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+1)].getValSS());
								params2.put("servSup3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getNomSS());
								params2.put("valSS3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[(aux2SSL13+2)].getValSS());
								params2.put("servSup4Linea13","");
								params2.put("valSS4Linea13","");	
								
								aux2SSL13 = aux2SSL13 + 4;
								auxSSL13 = auxSSL13 - 4;						
								flagSSL13 = false;
							}else if((auxSSL13 - 1 >= 0)&&(flagSSL13)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getNomSS());
								params2.put("valSS1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getServSupl()[aux2SSL13].getValSS());
								params2.put("servSup2Linea13","");
								params2.put("valSS2Linea13","");
								params2.put("servSup3Linea13","");
								params2.put("valSS3Linea13","");	
								params2.put("servSup4Linea13","");
								params2.put("valSS4Linea13","");	
								
								aux2SSL13 = aux2SSL13 + 4;
								auxSSL13 = auxSSL13 - 4;						
								flagSSL13 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "13");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "13");	
					}				
					//PA Linea 13		
					if(cantPAL13 != 0){
						if(cantPAL13%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL13 - 4 >= 0)&&(flagPAL13)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getNomPlanAdi());
								params2.put("valPA1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getValPlanAdi());
								params2.put("planAdi2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getNomPlanAdi());
								params2.put("valPA2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getValPlanAdi());
								params2.put("planAdi3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getNomPlanAdi());
								params2.put("valPA3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getValPlanAdi());
								params2.put("planAdi4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+3)].getNomPlanAdi());
								params2.put("valPA4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+3)].getValPlanAdi());
								
								aux2PAL13 = aux2PAL13 + 4;
								auxPAL13 = auxPAL13 - 4;								
							}else if((auxPAL13 - 2 >= 0)&&(flagPAL13)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getNomPlanAdi());
								params2.put("valPA1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getValPlanAdi());
								params2.put("planAdi2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getNomPlanAdi());
								params2.put("valPA2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getValPlanAdi());
								params2.put("planAdi3Linea13","");
								params2.put("valPA3Linea13","");
								params2.put("planAdi4Linea13","");
								params2.put("valPA4Linea13","");
								
								aux2PAL13 = aux2PAL13 + 4;
								auxPAL13 = auxPAL13 - 4;	
								flagPAL13 = false;
							}else{
								params2 = paOpcionalVacio(params2, "13");
							}						
						}else if(cantPAL13%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL13 - 4 >= 0)&&(flagPAL13)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getNomPlanAdi());
								params2.put("valPA1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getValPlanAdi());
								params2.put("planAdi2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getNomPlanAdi());
								params2.put("valPA2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getValPlanAdi());
								params2.put("planAdi3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getNomPlanAdi());
								params2.put("valPA3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getValPlanAdi());
								params2.put("planAdi4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+3)].getNomPlanAdi());
								params2.put("valPA4Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+3)].getValPlanAdi());
								
								aux2PAL13 = aux2PAL13 + 4;
								auxPAL13 = auxPAL13 - 4;												
							}else if((auxPAL13 - 3 >= 0)&&(flagPAL13)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getNomPlanAdi());
								params2.put("valPA1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getValPlanAdi());
								params2.put("planAdi2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getNomPlanAdi());
								params2.put("valPA2Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+1)].getValPlanAdi());
								params2.put("planAdi3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getNomPlanAdi());
								params2.put("valPA3Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL13+2)].getValPlanAdi());
								params2.put("planAdi4Linea13","");
								params2.put("valPA4Linea13","");
								
								aux2PAL13 = aux2PAL13 + 4;
								auxPAL13 = auxPAL13 - 4;				
								flagPAL13 = false;
							}else if((auxPAL13 - 1 >= 0)&&(flagPAL13)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getNomPlanAdi());
								params2.put("valPA1Linea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanesAdicionales()[aux2PAL13].getValPlanAdi());
								params2.put("planAdi2Linea13","");
								params2.put("valPA2Linea13","");
								params2.put("planAdi3Linea13","");
								params2.put("valPA3Linea13","");
								params2.put("planAdi4Linea13","");
								params2.put("valPA4Linea13","");
								
								aux2PAL13 = aux2PAL13 + 4;
								auxPAL13 = auxPAL13 - 4;				
								flagPAL13 = false;
							}else{
								params2 = paOpcionalVacio(params2, "13");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "13");
					}				
					
					//SS Linea 14			
					if(cantSSL14 != 0){
						if(cantSSL14%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL14 - 4 >= 0)&&(flagSSL14)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");								
								params2.put("servSup1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getNomSS());
								params2.put("valSS1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getValSS());
								params2.put("servSup2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getNomSS());
								params2.put("valSS2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getValSS());
								params2.put("servSup3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getNomSS());
								params2.put("valSS3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getValSS());	
								params2.put("servSup4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+3)].getNomSS());
								params2.put("valSS4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+3)].getValSS());	
								
								aux2SSL14 = aux2SSL14 + 4;
								auxSSL14 = auxSSL14 - 4;								
							}else if((auxSSL14 - 2 >= 0)&&(flagSSL14)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getNomSS());
								params2.put("valSS1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getValSS());
								params2.put("servSup2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getNomSS());
								params2.put("valSS2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getValSS());
								params2.put("servSup3Linea14","");
								params2.put("valSS3Linea14","");	
								params2.put("servSup4Linea14","");
								params2.put("valSS4Linea14","");	
								
								aux2SSL14 = aux2SSL14 + 4;
								auxSSL14 = auxSSL14 - 4;						
								flagSSL14 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "14");	
							}						
						}else if(cantSSL14%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL14 - 4 >= 0)&&(flagSSL14)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getNomSS());
								params2.put("valSS1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getValSS());
								params2.put("servSup2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getNomSS());
								params2.put("valSS2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getValSS());
								params2.put("servSup3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getNomSS());
								params2.put("valSS3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getValSS());	
								params2.put("servSup4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+3)].getNomSS());
								params2.put("valSS4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+3)].getValSS());	
								
								aux2SSL14 = aux2SSL14 + 4;
								auxSSL14 = auxSSL14 - 4;					
							}else if((auxSSL14 - 3 >= 0)&&(flagSSL14)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getNomSS());
								params2.put("valSS1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getValSS());
								params2.put("servSup2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getNomSS());
								params2.put("valSS2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+1)].getValSS());
								params2.put("servSup3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getNomSS());
								params2.put("valSS3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[(aux2SSL14+2)].getValSS());
								params2.put("servSup4Linea14","");
								params2.put("valSS4Linea14","");	
								
								aux2SSL14 = aux2SSL14 + 4;
								auxSSL14 = auxSSL14 - 4;						
								flagSSL14 = false;
							}else if((auxSSL14 - 1 >= 0)&&(flagSSL14)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getNomSS());
								params2.put("valSS1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getServSupl()[aux2SSL14].getValSS());
								params2.put("servSup2Linea14","");
								params2.put("valSS2Linea14","");
								params2.put("servSup3Linea14","");
								params2.put("valSS3Linea14","");	
								params2.put("servSup4Linea14","");
								params2.put("valSS4Linea14","");	
								
								aux2SSL14 = aux2SSL14 + 4;
								auxSSL14 = auxSSL14 - 4;						
								flagSSL14 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "14");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "14");	
					}				
					//PA Linea 14		
					if(cantPAL14 != 0){
						if(cantPAL14%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL14 - 4 >= 0)&&(flagPAL14)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getNomPlanAdi());
								params2.put("valPA1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getValPlanAdi());
								params2.put("planAdi2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getNomPlanAdi());
								params2.put("valPA2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getValPlanAdi());
								params2.put("planAdi3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getNomPlanAdi());
								params2.put("valPA3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getValPlanAdi());
								params2.put("planAdi4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+3)].getNomPlanAdi());
								params2.put("valPA4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+3)].getValPlanAdi());
								
								aux2PAL14 = aux2PAL14 + 4;
								auxPAL14 = auxPAL14 - 4;								
							}else if((auxPAL14 - 2 >= 0)&&(flagPAL14)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getNomPlanAdi());
								params2.put("valPA1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getValPlanAdi());
								params2.put("planAdi2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getNomPlanAdi());
								params2.put("valPA2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getValPlanAdi());
								params2.put("planAdi3Linea14","");
								params2.put("valPA3Linea14","");
								params2.put("planAdi4Linea14","");
								params2.put("valPA4Linea14","");
								
								aux2PAL14 = aux2PAL14 + 4;
								auxPAL14 = auxPAL14 - 4;	
								flagPAL14 = false;
							}else{
								params2 = paOpcionalVacio(params2, "14");
							}						
						}else if(cantPAL14%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL14 - 4 >= 0)&&(flagPAL14)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getNomPlanAdi());
								params2.put("valPA1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getValPlanAdi());
								params2.put("planAdi2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getNomPlanAdi());
								params2.put("valPA2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getValPlanAdi());
								params2.put("planAdi3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getNomPlanAdi());
								params2.put("valPA3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getValPlanAdi());
								params2.put("planAdi4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+3)].getNomPlanAdi());
								params2.put("valPA4Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+3)].getValPlanAdi());
								
								aux2PAL14 = aux2PAL14 + 4;
								auxPAL14 = auxPAL14 - 4;												
							}else if((auxPAL14 - 3 >= 0)&&(flagPAL14)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getNomPlanAdi());
								params2.put("valPA1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getValPlanAdi());
								params2.put("planAdi2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getNomPlanAdi());
								params2.put("valPA2Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+1)].getValPlanAdi());
								params2.put("planAdi3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getNomPlanAdi());
								params2.put("valPA3Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL14+2)].getValPlanAdi());
								params2.put("planAdi4Linea14","");
								params2.put("valPA4Linea14","");
								
								aux2PAL14 = aux2PAL14 + 4;
								auxPAL14 = auxPAL14 - 4;				
								flagPAL14 = false;
							}else if((auxPAL14 - 1 >= 0)&&(flagPAL14)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getNomPlanAdi());
								params2.put("valPA1Linea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanesAdicionales()[aux2PAL14].getValPlanAdi());
								params2.put("planAdi2Linea14","");
								params2.put("valPA2Linea14","");
								params2.put("planAdi3Linea14","");
								params2.put("valPA3Linea14","");
								params2.put("planAdi4Linea14","");
								params2.put("valPA4Linea14","");
								
								aux2PAL14 = aux2PAL14 + 4;
								auxPAL14 = auxPAL14 - 4;				
								flagPAL14 = false;
							}else{
								params2 = paOpcionalVacio(params2, "14");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "14");
					}				
					
					//SS Linea 15			
					if(cantSSL15 != 0){
						if(cantSSL15%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL15 - 4 >= 0)&&(flagSSL15)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");								
								params2.put("servSup1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getNomSS());
								params2.put("valSS1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getValSS());
								params2.put("servSup2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getNomSS());
								params2.put("valSS2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getValSS());
								params2.put("servSup3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getNomSS());
								params2.put("valSS3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getValSS());	
								params2.put("servSup4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+3)].getNomSS());
								params2.put("valSS4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+3)].getValSS());	
								
								aux2SSL15 = aux2SSL15 + 4;
								auxSSL15 = auxSSL15 - 4;								
							}else if((auxSSL15 - 2 >= 0)&&(flagSSL15)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getNomSS());
								params2.put("valSS1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getValSS());
								params2.put("servSup2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getNomSS());
								params2.put("valSS2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getValSS());
								params2.put("servSup3Linea15","");
								params2.put("valSS3Linea15","");	
								params2.put("servSup4Linea15","");
								params2.put("valSS4Linea15","");	
								
								aux2SSL15 = aux2SSL15 + 4;
								auxSSL15 = auxSSL15 - 4;						
								flagSSL15 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "15");	
							}						
						}else if(cantSSL15%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL15 - 4 >= 0)&&(flagSSL15)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getNomSS());
								params2.put("valSS1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getValSS());
								params2.put("servSup2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getNomSS());
								params2.put("valSS2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getValSS());
								params2.put("servSup3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getNomSS());
								params2.put("valSS3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getValSS());	
								params2.put("servSup4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+3)].getNomSS());
								params2.put("valSS4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+3)].getValSS());
								
								aux2SSL15 = aux2SSL15 + 4;
								auxSSL15 = auxSSL15 - 4;					
							}else if((auxSSL15 - 3 >= 0)&&(flagSSL15)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getNomSS());
								params2.put("valSS1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getValSS());
								params2.put("servSup2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getNomSS());
								params2.put("valSS2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+1)].getValSS());
								params2.put("servSup3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getNomSS());
								params2.put("valSS3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[(aux2SSL15+2)].getValSS());
								params2.put("servSup4Linea15","");
								params2.put("valSS4Linea15","");	
								
								aux2SSL15 = aux2SSL15 + 4;
								auxSSL15 = auxSSL15 - 4;						
								flagSSL15 = false;
							}else if((auxSSL15 - 1 >= 0)&&(flagSSL15)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getNomSS());
								params2.put("valSS1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getServSupl()[aux2SSL15].getValSS());
								params2.put("servSup2Linea15","");
								params2.put("valSS2Linea15","");
								params2.put("servSup3Linea15","");
								params2.put("valSS3Linea15","");	
								params2.put("servSup4Linea15","");
								params2.put("valSS4Linea15","");	
								
								aux2SSL15 = aux2SSL15 + 4;
								auxSSL15 = auxSSL15 - 4;						
								flagSSL15 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "15");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "15");	
					}				
					//PA Linea 15		
					if(cantPAL15 != 0){
						if(cantPAL15%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL15 - 4 >= 0)&&(flagPAL15)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getNomPlanAdi());
								params2.put("valPA1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getValPlanAdi());
								params2.put("planAdi2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getNomPlanAdi());
								params2.put("valPA2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getValPlanAdi());
								params2.put("planAdi3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getNomPlanAdi());
								params2.put("valPA3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getValPlanAdi());
								params2.put("planAdi4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+3)].getNomPlanAdi());
								params2.put("valPA4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+3)].getValPlanAdi());
								
								aux2PAL15 = aux2PAL15 + 4;
								auxPAL15 = auxPAL15 - 4;								
							}else if((auxPAL15 - 2 >= 0)&&(flagPAL15)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getNomPlanAdi());
								params2.put("valPA1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getValPlanAdi());
								params2.put("planAdi2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getNomPlanAdi());
								params2.put("valPA2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getValPlanAdi());
								params2.put("planAdi3Linea15","");
								params2.put("valPA3Linea15","");
								params2.put("planAdi4Linea15","");
								params2.put("valPA4Linea15","");
								
								aux2PAL15 = aux2PAL15 + 4;
								auxPAL15 = auxPAL15 - 4;	
								flagPAL15 = false;
							}else{
								params2 = paOpcionalVacio(params2, "15");
							}						
						}else if(cantPAL15%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL15 - 4 >= 0)&&(flagPAL15)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getNomPlanAdi());
								params2.put("valPA1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getValPlanAdi());
								params2.put("planAdi2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getNomPlanAdi());
								params2.put("valPA2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getValPlanAdi());
								params2.put("planAdi3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getNomPlanAdi());
								params2.put("valPA3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getValPlanAdi());
								params2.put("planAdi4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+3)].getNomPlanAdi());
								params2.put("valPA4Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+3)].getValPlanAdi());
								
								aux2PAL15 = aux2PAL15 + 4;
								auxPAL15 = auxPAL15 - 4;												
							}else if((auxPAL15 - 3 >= 0)&&(flagPAL15)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getNomPlanAdi());
								params2.put("valPA1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getValPlanAdi());
								params2.put("planAdi2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getNomPlanAdi());
								params2.put("valPA2Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+1)].getValPlanAdi());
								params2.put("planAdi3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getNomPlanAdi());
								params2.put("valPA3Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL15+2)].getValPlanAdi());
								params2.put("planAdi4Linea15","");
								params2.put("valPA4Linea15","");
								
								aux2PAL15 = aux2PAL15 + 4;
								auxPAL15 = auxPAL15 - 4;				
								flagPAL15 = false;
							}else if((auxPAL15 - 1 >= 0)&&(flagPAL15)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getNomPlanAdi());
								params2.put("valPA1Linea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanesAdicionales()[aux2PAL15].getValPlanAdi());
								params2.put("planAdi2Linea15","");
								params2.put("valPA2Linea15","");
								params2.put("planAdi3Linea15","");
								params2.put("valPA3Linea15","");
								params2.put("planAdi4Linea15","");
								params2.put("valPA4Linea15","");
								
								aux2PAL15 = aux2PAL15 + 4;
								auxPAL15 = auxPAL15 - 4;				
								flagPAL15 = false;
							}else{
								params2 = paOpcionalVacio(params2, "15");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "15");
					}				
					
					//SS Linea 16			
					if(cantSSL16 != 0){
						if(cantSSL16%2 == 0){
							//Cantidad de SS es Par
							if((auxSSL16 - 4 >= 0)&&(flagSSL16)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");								
								params2.put("servSup1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getNomSS());
								params2.put("valSS1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getValSS());
								params2.put("servSup2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getNomSS());
								params2.put("valSS2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getValSS());
								params2.put("servSup3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getNomSS());
								params2.put("valSS3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getValSS());	
								params2.put("servSup4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+3)].getNomSS());
								params2.put("valSS4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+3)].getValSS());	
								
								aux2SSL16 = aux2SSL16 + 4;
								auxSSL16 = auxSSL16 - 4;								
							}else if((auxSSL16 - 2 >= 0)&&(flagSSL16)){
								logger.debug("Quedan 2 SS");
								params2.put("servSup1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getNomSS());
								params2.put("valSS1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getValSS());
								params2.put("servSup2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getNomSS());
								params2.put("valSS2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getValSS());
								params2.put("servSup3Linea16","");
								params2.put("valSS3Linea16","");	
								params2.put("servSup4Linea16","");
								params2.put("valSS4Linea16","");	
								
								aux2SSL16 = aux2SSL16 + 4;
								auxSSL16 = auxSSL16 - 4;						
								flagSSL16 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "16");	
							}						
						}else if(cantSSL16%2 == 1){
							//Cantidad de SS es Impar
							if((auxSSL16 - 4 >= 0)&&(flagSSL16)){
								//Quedan 4 SS o mas
								logger.debug("Quedan 4 SS o mas");
								params2.put("servSup1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getNomSS());
								params2.put("valSS1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getValSS());
								params2.put("servSup2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getNomSS());
								params2.put("valSS2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getValSS());
								params2.put("servSup3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getNomSS());
								params2.put("valSS3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getValSS());	
								params2.put("servSup4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+3)].getNomSS());
								params2.put("valSS4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+3)].getValSS());	
								
								aux2SSL16 = aux2SSL16 + 4;
								auxSSL16 = auxSSL16 - 4;					
							}else if((auxSSL16 - 3 >= 0)&&(flagSSL16)){
								logger.debug("Quedan 3 SS");
								params2.put("servSup1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getNomSS());
								params2.put("valSS1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getValSS());
								params2.put("servSup2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getNomSS());
								params2.put("valSS2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+1)].getValSS());
								params2.put("servSup3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getNomSS());
								params2.put("valSS3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[(aux2SSL16+2)].getValSS());
								params2.put("servSup4Linea16","");
								params2.put("valSS4Linea16","");	
								
								aux2SSL16 = aux2SSL16 + 4;
								auxSSL16 = auxSSL16 - 4;						
								flagSSL16 = false;
							}else if((auxSSL16 - 1 >= 0)&&(flagSSL16)){
								logger.debug("Queda 1 SS");
								params2.put("servSup1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getNomSS());
								params2.put("valSS1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getServSupl()[aux2SSL16].getValSS());
								params2.put("servSup2Linea16","");
								params2.put("valSS2Linea16","");
								params2.put("servSup3Linea16","");
								params2.put("valSS3Linea16","");	
								params2.put("servSup4Linea16","");
								params2.put("valSS4Linea16","");	
								
								aux2SSL16 = aux2SSL16 + 4;
								auxSSL16 = auxSSL16 - 4;						
								flagSSL16 = false;
							}else{
								params2 = ssOpcionalVacio(params2, "16");	
							}						
						}					
					}else{
						params2 = ssOpcionalVacio(params2, "16");	
					}				
					//PA Linea 16		
					if(cantPAL16 != 0){
						if(cantPAL16%2 == 0){
							//Cantidad de SS es Par
							if((auxPAL16 - 4 >= 0)&&(flagPAL16)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");								
								params2.put("planAdi1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getNomPlanAdi());
								params2.put("valPA1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getValPlanAdi());
								params2.put("planAdi2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getNomPlanAdi());
								params2.put("valPA2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getValPlanAdi());
								params2.put("planAdi3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getNomPlanAdi());
								params2.put("valPA3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getValPlanAdi());
								params2.put("planAdi4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+3)].getNomPlanAdi());
								params2.put("valPA4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+3)].getValPlanAdi());
								
								aux2PAL16 = aux2PAL16 + 4;
								auxPAL16 = auxPAL16 - 4;								
							}else if((auxPAL16 - 2 >= 0)&&(flagPAL16)){
								logger.debug("Quedan 2 PA");
								params2.put("planAdi1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getNomPlanAdi());
								params2.put("valPA1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getValPlanAdi());
								params2.put("planAdi2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getNomPlanAdi());
								params2.put("valPA2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getValPlanAdi());
								params2.put("planAdi3Linea16","");
								params2.put("valPA3Linea16","");
								params2.put("planAdi4Linea16","");
								params2.put("valPA4Linea16","");
								
								aux2PAL16 = aux2PAL16 + 4;
								auxPAL16 = auxPAL16 - 4;	
								flagPAL16 = false;
							}else{
								params2 = paOpcionalVacio(params2, "16");
							}						
						}else if(cantPAL16%2 == 1){
							//Cantidad de PA es Impar
							if((auxPAL16 - 4 >= 0)&&(flagPAL16)){
								//Quedan 4 PA o mas
								logger.debug("Quedan 4 PA o mas");
								params2.put("planAdi1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getNomPlanAdi());
								params2.put("valPA1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getValPlanAdi());
								params2.put("planAdi2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getNomPlanAdi());
								params2.put("valPA2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getValPlanAdi());
								params2.put("planAdi3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getNomPlanAdi());
								params2.put("valPA3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getValPlanAdi());
								params2.put("planAdi4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+3)].getNomPlanAdi());
								params2.put("valPA4Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+3)].getValPlanAdi());
								
								aux2PAL16 = aux2PAL16 + 4;
								auxPAL16 = auxPAL16 - 4;												
							}else if((auxPAL16 - 3 >= 0)&&(flagPAL16)){
								//Quedan 3 PA
								logger.debug("Quedan 3 PA");
								params2.put("planAdi1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getNomPlanAdi());
								params2.put("valPA1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getValPlanAdi());
								params2.put("planAdi2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getNomPlanAdi());
								params2.put("valPA2Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+1)].getValPlanAdi());
								params2.put("planAdi3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getNomPlanAdi());
								params2.put("valPA3Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[(aux2PAL16+2)].getValPlanAdi());
								params2.put("planAdi4Linea16","");
								params2.put("valPA4Linea16","");
								
								aux2PAL16 = aux2PAL16 + 4;
								auxPAL16 = auxPAL16 - 4;				
								flagPAL16 = false;
							}else if((auxPAL16 - 1 >= 0)&&(flagPAL16)){
								//Queda 1 PA
								logger.debug("Queda 1 PA");
								params2.put("planAdi1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getNomPlanAdi());
								params2.put("valPA1Linea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanesAdicionales()[aux2PAL16].getValPlanAdi());
								params2.put("planAdi2Linea16","");
								params2.put("valPA2Linea16","");
								params2.put("planAdi3Linea16","");
								params2.put("valPA3Linea16","");
								params2.put("planAdi4Linea16","");
								params2.put("valPA4Linea16","");
								
								aux2PAL16 = aux2PAL16 + 4;
								auxPAL16 = auxPAL16 - 4;				
								flagPAL16 = false;
							}else{
								params2 = paOpcionalVacio(params2, "16");
							}						
						}					
					}else{
						params2 = paOpcionalVacio(params2, "16");
					}
					
					filename3 = JasperFillManager.fillReport(sRutaAnexo, params2, da);
					logger.debug("Rellena el resto de las paginas del contrato");
					
					logger.debug("agrega paginas al contrato");
					JRPrintPage page = filename3.removePage(0);
					filename.addPage(page);					
					flagAnexoContrato = true;
					
					cuentaAnexo = cuentaAnexo + 4;
				}
			}
			lineasAnexo2 = lineasAnexo2 + 12;
			lineasAnexo = lineasAnexo - 12;
		}			
		
		return filename;		
	}
	
	
	public HashMap numLineaAnexo(DatosContrato datosContrato, int lineasAnexo2){
		HashMap params2 = new HashMap(); //Parametros para el anexo
		//Indicar de Numero de la Linea
		params2.put("fecVenta",datosContrato.getFecVenta());
		params2.put("numVenta",datosContrato.getNumVenta());				
		params2.put("numLinea5",String.valueOf(5+lineasAnexo2));
		params2.put("numLinea6",String.valueOf(6+lineasAnexo2));
		params2.put("numLinea7",String.valueOf(7+lineasAnexo2));
		params2.put("numLinea8",String.valueOf(8+lineasAnexo2));
		params2.put("numLinea9",String.valueOf(9+lineasAnexo2));
		params2.put("numLinea10",String.valueOf(10+lineasAnexo2));
		params2.put("numLinea11",String.valueOf(11+lineasAnexo2));
		params2.put("numLinea12",String.valueOf(12+lineasAnexo2));
		params2.put("numLinea13",String.valueOf(13+lineasAnexo2));
		params2.put("numLinea14",String.valueOf(14+lineasAnexo2));
		params2.put("numLinea15",String.valueOf(15+lineasAnexo2));
		params2.put("numLinea16",String.valueOf(16+lineasAnexo2));
		//P-CSR-11002 JLGN 08-11-2011
		String sRutaFirma = System.getProperty("user.dir")  + global.getValorExterno("firma.reporte");
		params2.put("firmaAnexo",sRutaFirma);
		
		return params2;
	}
	
	public int cantidadMayor(int cantPAL5, int cantPAL6, int cantPAL7, int cantPAL8, int cantPAL9, int cantPAL10,
							 int cantPAL11, int cantPAL12, int cantPAL13, int cantPAL14, int cantPAL15, int cantPAL16,
							 int cantSSL5, int cantSSL6, int cantSSL7, int cantSSL8, int cantSSL9, int cantSSL10, int cantSSL11,
							 int cantSSL12, int cantSSL13, int cantSSL14, int cantSSL15, int cantSSL16){
		int cantMayor = 0;
		
		if(cantPAL5 >= cantPAL6 && cantPAL5 >= cantPAL7 && cantPAL5 >= cantPAL8 && cantPAL5 >= cantPAL9 && cantPAL5 >= cantPAL10 && 
		   cantPAL5 >= cantPAL11 && cantPAL5 >= cantPAL12 && cantPAL5 >= cantPAL13 && cantPAL5 >= cantPAL14 && cantPAL5 >= cantPAL15 &&
	       cantPAL5 >= cantPAL16 && cantPAL5 >= cantSSL5 && cantPAL5 >= cantSSL6 && cantPAL5 >= cantSSL7 && cantPAL5 >= cantSSL8 &&
		   cantPAL5 >= cantSSL9 && cantPAL5 >= cantSSL10 && cantPAL5 >= cantSSL11 && cantPAL5 >= cantSSL12 && cantPAL5 >= cantSSL13 &&
		   cantPAL5 >= cantSSL14 && cantPAL5 >= cantSSL15 && cantPAL5 >= cantSSL16){					
			logger.debug("PA Linea 5 tiene mas planes");
			cantMayor = cantPAL5;						 
		}else if(cantPAL6 >= cantPAL5 && cantPAL6 >= cantPAL7 && cantPAL6 >= cantPAL8 && cantPAL6 >= cantPAL9 && cantPAL6 >= cantPAL10 && 
				 cantPAL6 >= cantPAL11 && cantPAL6 >= cantPAL12 && cantPAL6 >= cantPAL13 && cantPAL6 >= cantPAL14 && cantPAL6 >= cantPAL15 &&
				 cantPAL6 >= cantPAL16 && cantPAL6 >= cantSSL5 && cantPAL6 >= cantSSL6 && cantPAL6 >= cantSSL7 && cantPAL6 >= cantSSL8 &&
				 cantPAL6 >= cantSSL9 && cantPAL6 >= cantSSL10 && cantPAL6 >= cantSSL11 && cantPAL6 >= cantSSL12 && cantPAL6 >= cantSSL13 &&
				 cantPAL6 >= cantSSL14 && cantPAL6 >= cantSSL15 && cantPAL6 >= cantSSL16){
			logger.debug("PA Linea 6 tiene mas planes");
			cantMayor = cantPAL6;
		}else if(cantPAL7 >= cantPAL5 && cantPAL7 >= cantPAL6 && cantPAL7 >= cantPAL8 && cantPAL7 >= cantPAL9 && cantPAL7 >= cantPAL10 && 
				 cantPAL7 >= cantPAL11 && cantPAL7 >= cantPAL12 && cantPAL7 >= cantPAL13 && cantPAL7 >= cantPAL14 && cantPAL7 >= cantPAL15 &&
				 cantPAL7 >= cantPAL16 && cantPAL7 >= cantSSL5 && cantPAL7 >= cantSSL6 && cantPAL7 >= cantSSL7 && cantPAL7 >= cantSSL8 &&
				 cantPAL7 >= cantSSL9 && cantPAL7 >= cantSSL10 && cantPAL7 >= cantSSL11 && cantPAL7 >= cantSSL12 && cantPAL7 >= cantSSL13 &&
				 cantPAL7 >= cantSSL14 && cantPAL7 >= cantSSL15 && cantPAL7 >= cantSSL16){
			logger.debug("PA Linea 7 tiene mas planes");
			cantMayor = cantPAL7;
		}else if(cantPAL8 >= cantPAL5 && cantPAL8 >= cantPAL6 && cantPAL8 >= cantPAL7 && cantPAL8 >= cantPAL9 && cantPAL8 >= cantPAL10 && 
				 cantPAL8 >= cantPAL11 && cantPAL8 >= cantPAL12 && cantPAL8 >= cantPAL13 && cantPAL8 >= cantPAL14 && cantPAL8 >= cantPAL15 &&
				 cantPAL8 >= cantPAL16 && cantPAL8 >= cantSSL5 && cantPAL8 >= cantSSL6 && cantPAL8 >= cantSSL7 && cantPAL8 >= cantSSL8 &&
				 cantPAL8 >= cantSSL9 && cantPAL8 >= cantSSL10 && cantPAL8 >= cantSSL11 && cantPAL8 >= cantSSL12 && cantPAL8 >= cantSSL13 &&
				 cantPAL8 >= cantSSL14 && cantPAL8 >= cantSSL15 && cantPAL8 >= cantSSL16){
			logger.debug("PA Linea 8 tiene mas planes");
			cantMayor = cantPAL8;
		}else if(cantPAL9 >= cantPAL5 && cantPAL9 >= cantPAL6 && cantPAL9 >= cantPAL7 && cantPAL9 >= cantPAL8 && cantPAL9 >= cantPAL10 && 
				 cantPAL9 >= cantPAL11 && cantPAL9 >= cantPAL12 && cantPAL9 >= cantPAL13 && cantPAL9 >= cantPAL14 && cantPAL9 >= cantPAL15 &&
				 cantPAL9 >= cantPAL16 && cantPAL9 >= cantSSL5 && cantPAL9 >= cantSSL6 && cantPAL9 >= cantSSL7 && cantPAL9 >= cantSSL8 &&
				 cantPAL9 >= cantSSL9 && cantPAL9 >= cantSSL10 && cantPAL9 >= cantSSL11 && cantPAL9 >= cantSSL12 && cantPAL9 >= cantSSL13 &&
				 cantPAL9 >= cantSSL14 && cantPAL9 >= cantSSL15 && cantPAL9 >= cantSSL16){
			logger.debug("PA Linea 9 tiene mas planes");
			cantMayor = cantPAL9;
		}else if(cantPAL10 >= cantPAL5 && cantPAL10 >= cantPAL6 && cantPAL10 >= cantPAL7 && cantPAL10 >= cantPAL8 && cantPAL10 >= cantPAL9 && 
				 cantPAL10 >= cantPAL11 && cantPAL10 >= cantPAL12 && cantPAL10 >= cantPAL13 && cantPAL10 >= cantPAL14 && cantPAL10 >= cantPAL15 &&
				 cantPAL10 >= cantPAL16 && cantPAL10 >= cantSSL5 && cantPAL10 >= cantSSL6 && cantPAL10 >= cantSSL7 && cantPAL10 >= cantSSL8 &&
				 cantPAL10 >= cantSSL9 && cantPAL10 >= cantSSL10 && cantPAL10 >= cantSSL11 && cantPAL10 >= cantSSL12 && cantPAL10 >= cantSSL13 &&
				 cantPAL10 >= cantSSL14 && cantPAL10 >= cantSSL15 && cantPAL10 >= cantSSL16){
			logger.debug("PA Linea 10 tiene mas planes");
			cantMayor = cantPAL10;
		}else if(cantPAL11 >= cantPAL5 && cantPAL11 >= cantPAL6 && cantPAL11 >= cantPAL7 && cantPAL11 >= cantPAL8 && cantPAL11 >= cantPAL9 && 
				 cantPAL11 >= cantPAL10 && cantPAL11 >= cantPAL12 && cantPAL11 >= cantPAL13 && cantPAL11 >= cantPAL14 && cantPAL11 >= cantPAL15 &&
				 cantPAL11 >= cantPAL16 && cantPAL11 >= cantSSL5 && cantPAL11 >= cantSSL6 && cantPAL11 >= cantSSL7 && cantPAL11 >= cantSSL8 &&
				 cantPAL11 >= cantSSL9 && cantPAL11 >= cantSSL10 && cantPAL11 >= cantSSL11 && cantPAL11 >= cantSSL12 && cantPAL11 >= cantSSL13 &&
				 cantPAL11 >= cantSSL14 && cantPAL11 >= cantSSL15 && cantPAL11 >= cantSSL16){
			logger.debug("PA Linea 11 tiene mas planes");
			cantMayor = cantPAL11;
		}else if(cantPAL12 >= cantPAL5 && cantPAL12 >= cantPAL6 && cantPAL12 >= cantPAL7 && cantPAL12 >= cantPAL8 && cantPAL12 >= cantPAL9 && 
				 cantPAL12 >= cantPAL10 && cantPAL12 >= cantPAL11 && cantPAL12 >= cantPAL13 && cantPAL12 >= cantPAL14 && cantPAL12 >= cantPAL15 &&
				 cantPAL12 >= cantPAL16 && cantPAL12 >= cantSSL5 && cantPAL12 >= cantSSL6 && cantPAL12 >= cantSSL7 && cantPAL12 >= cantSSL8 &&
				 cantPAL12 >= cantSSL9 && cantPAL12 >= cantSSL10 && cantPAL12 >= cantSSL11 && cantPAL12 >= cantSSL12 && cantPAL12 >= cantSSL13 &&
				 cantPAL12 >= cantSSL14 && cantPAL12 >= cantSSL15 && cantPAL12 >= cantSSL16){
			logger.debug("PA Linea 12 tiene mas planes");
			cantMayor = cantPAL12;
		}else if(cantPAL13 >= cantPAL5 && cantPAL13 >= cantPAL6 && cantPAL13 >= cantPAL7 && cantPAL13 >= cantPAL8 && cantPAL13 >= cantPAL9 && 
				 cantPAL13 >= cantPAL10 && cantPAL13 >= cantPAL11 && cantPAL13 >= cantPAL12 && cantPAL13 >= cantPAL14 && cantPAL13 >= cantPAL15 &&
				 cantPAL13 >= cantPAL16 && cantPAL13 >= cantSSL5 && cantPAL13 >= cantSSL6 && cantPAL13 >= cantSSL7 && cantPAL13 >= cantSSL8 &&
				 cantPAL13 >= cantSSL9 && cantPAL13 >= cantSSL10 && cantPAL13 >= cantSSL11 && cantPAL13 >= cantSSL12 && cantPAL13 >= cantSSL13 &&
				 cantPAL13 >= cantSSL14 && cantPAL13 >= cantSSL15 && cantPAL13 >= cantSSL16){
			logger.debug("PA Linea 13 tiene mas planes");
			cantMayor = cantPAL13;
		}else if(cantPAL14 >= cantPAL5 && cantPAL14 >= cantPAL6 && cantPAL14 >= cantPAL7 && cantPAL14 >= cantPAL8 && cantPAL14 >= cantPAL9 && 
				 cantPAL14 >= cantPAL10 && cantPAL14 >= cantPAL11 && cantPAL14 >= cantPAL12 && cantPAL14 >= cantPAL13 && cantPAL14 >= cantPAL15 &&
				 cantPAL14 >= cantPAL16 && cantPAL14 >= cantSSL5 && cantPAL14 >= cantSSL6 && cantPAL14 >= cantSSL7 && cantPAL14 >= cantSSL8 &&
				 cantPAL14 >= cantSSL9 && cantPAL14 >= cantSSL10 && cantPAL14 >= cantSSL11 && cantPAL14 >= cantSSL12 && cantPAL14 >= cantSSL13 &&
				 cantPAL14 >= cantSSL14 && cantPAL14 >= cantSSL15 && cantPAL14 >= cantSSL16){
			logger.debug("PA Linea 14 tiene mas planes");
			cantMayor = cantPAL14;
		}else if(cantPAL15 >= cantPAL5 && cantPAL15 >= cantPAL6 && cantPAL15 >= cantPAL7 && cantPAL15 >= cantPAL8 && cantPAL15 >= cantPAL9 && 
				 cantPAL15 >= cantPAL10 && cantPAL15 >= cantPAL11 && cantPAL15 >= cantPAL12 && cantPAL15 >= cantPAL13 && cantPAL15 >= cantPAL14 &&
				 cantPAL15 >= cantPAL16 && cantPAL15 >= cantSSL5 && cantPAL15 >= cantSSL6 && cantPAL15 >= cantSSL7 && cantPAL15 >= cantSSL8 &&
				 cantPAL15 >= cantSSL9 && cantPAL15 >= cantSSL10 && cantPAL15 >= cantSSL11 && cantPAL15 >= cantSSL12 && cantPAL15 >= cantSSL13 &&
				 cantPAL15 >= cantSSL14 && cantPAL15 >= cantSSL15 && cantPAL15 >= cantSSL16){
			logger.debug("PA Linea 15 tiene mas planes");
			cantMayor = cantPAL15;
		}else if(cantPAL16 >= cantPAL5 && cantPAL16 >= cantPAL6 && cantPAL16 >= cantPAL7 && cantPAL16 >= cantPAL8 && cantPAL16 >= cantPAL9 && 
				 cantPAL16 >= cantPAL10 && cantPAL16 >= cantPAL11 && cantPAL16 >= cantPAL12 && cantPAL16 >= cantPAL13 && cantPAL16 >= cantPAL14 &&
				 cantPAL16 >= cantPAL15 && cantPAL16 >= cantSSL5 && cantPAL16 >= cantSSL6 && cantPAL16 >= cantSSL7 && cantPAL16 >= cantSSL8 &&
				 cantPAL16 >= cantSSL9 && cantPAL16 >= cantSSL10 && cantPAL16 >= cantSSL11 && cantPAL16 >= cantSSL12 && cantPAL16 >= cantSSL13 &&
				 cantPAL16 >= cantSSL14 && cantPAL16 >= cantSSL15 && cantPAL16 >= cantSSL16){
			logger.debug("PA Linea 16 tiene mas planes");
			cantMayor = cantPAL16;
		}else if(cantSSL5 >= cantPAL5 && cantSSL5 >= cantPAL6 && cantSSL5 >= cantPAL7 && cantSSL5 >= cantPAL8 && cantSSL5 >= cantPAL9 && 
				 cantSSL5 >= cantPAL10 && cantSSL5 >= cantPAL11 && cantSSL5 >= cantPAL12 && cantSSL5 >= cantPAL13 && cantSSL5 >= cantPAL14 &&
				 cantSSL5 >= cantPAL15 && cantSSL5 >= cantPAL16 && cantSSL5 >= cantSSL6 && cantSSL5 >= cantSSL7 && cantSSL5 >= cantSSL8 &&
				 cantSSL5 >= cantSSL9 && cantSSL5 >= cantSSL10 && cantSSL5 >= cantSSL11 && cantSSL5 >= cantSSL12 && cantSSL5 >= cantSSL13 &&
				 cantSSL5 >= cantSSL14 && cantSSL5 >= cantSSL15 && cantSSL5 >= cantSSL16){
			logger.debug("SS Linea 5 tiene mas servicios");
			cantMayor = cantSSL5;
		}else if(cantSSL6 >= cantPAL5 && cantSSL6 >= cantPAL6 && cantSSL6 >= cantPAL7 && cantSSL6 >= cantPAL8 && cantSSL6 >= cantPAL9 && 
				 cantSSL6 >= cantPAL10 && cantSSL6 >= cantPAL11 && cantSSL6 >= cantPAL12 && cantSSL6 >= cantPAL13 && cantSSL6 >= cantPAL14 &&
				 cantSSL6 >= cantPAL15 && cantSSL6 >= cantPAL16 && cantSSL6 >= cantSSL5 && cantSSL6 >= cantSSL7 && cantSSL6 >= cantSSL8 &&
				 cantSSL6 >= cantSSL9 && cantSSL6 >= cantSSL10 && cantSSL6 >= cantSSL11 && cantSSL6 >= cantSSL12 && cantSSL6 >= cantSSL13 &&
				 cantSSL6 >= cantSSL14 && cantSSL6 >= cantSSL15 && cantSSL6 >= cantSSL16){
			logger.debug("SS Linea 6 tiene mas servicios");
			cantMayor = cantSSL6;
		}else if(cantSSL7 >= cantPAL5 && cantSSL7 >= cantPAL6 && cantSSL7 >= cantPAL7 && cantSSL7 >= cantPAL8 && cantSSL7 >= cantPAL9 && 
				 cantSSL7 >= cantPAL10 && cantSSL7 >= cantPAL11 && cantSSL7 >= cantPAL12 && cantSSL7 >= cantPAL13 && cantSSL7 >= cantPAL14 &&
				 cantSSL7 >= cantPAL15 && cantSSL7 >= cantPAL16 && cantSSL7 >= cantSSL5 && cantSSL7 >= cantSSL6 && cantSSL7 >= cantSSL8 &&
				 cantSSL7 >= cantSSL9 && cantSSL7 >= cantSSL10 && cantSSL7 >= cantSSL11 && cantSSL7 >= cantSSL12 && cantSSL7 >= cantSSL13 &&
				 cantSSL7 >= cantSSL14 && cantSSL7 >= cantSSL15 && cantSSL7 >= cantSSL16){
			logger.debug("SS Linea 7 tiene mas servicios");
			cantMayor = cantSSL7;
		}else if(cantSSL8 >= cantPAL5 && cantSSL8 >= cantPAL6 && cantSSL8 >= cantPAL7 && cantSSL8 >= cantPAL8 && cantSSL8 >= cantPAL9 && 
				 cantSSL8 >= cantPAL10 && cantSSL8 >= cantPAL11 && cantSSL8 >= cantPAL12 && cantSSL8 >= cantPAL13 && cantSSL8 >= cantPAL14 &&
				 cantSSL8 >= cantPAL15 && cantSSL8 >= cantPAL16 && cantSSL8 >= cantSSL5 && cantSSL8 >= cantSSL6 && cantSSL8 >= cantSSL7 &&
				 cantSSL8 >= cantSSL9 && cantSSL8 >= cantSSL10 && cantSSL8 >= cantSSL11 && cantSSL8 >= cantSSL12 && cantSSL8 >= cantSSL13 &&
				 cantSSL8 >= cantSSL14 && cantSSL8 >= cantSSL15 && cantSSL8 >= cantSSL16){
			logger.debug("SS Linea 8 tiene mas servicios");
			cantMayor = cantSSL8;
		}else if(cantSSL9 >= cantPAL5 && cantSSL9 >= cantPAL6 && cantSSL9 >= cantPAL7 && cantSSL9 >= cantPAL8 && cantSSL9 >= cantPAL9 && 
				 cantSSL9 >= cantPAL10 && cantSSL9 >= cantPAL11 && cantSSL9 >= cantPAL12 && cantSSL9 >= cantPAL13 && cantSSL9 >= cantPAL14 &&
				 cantSSL9 >= cantPAL15 && cantSSL9 >= cantPAL16 && cantSSL9 >= cantSSL5 && cantSSL9 >= cantSSL6 && cantSSL9 >= cantSSL7 &&
				 cantSSL9 >= cantSSL8 && cantSSL9 >= cantSSL10 && cantSSL9 >= cantSSL11 && cantSSL9 >= cantSSL12 && cantSSL9 >= cantSSL13 &&
				 cantSSL9 >= cantSSL14 && cantSSL9 >= cantSSL15 && cantSSL9 >= cantSSL16){
			logger.debug("SS Linea 9 tiene mas servicios");
			cantMayor = cantSSL9;
		}else if(cantSSL10 >= cantPAL5 && cantSSL10 >= cantPAL6 && cantSSL10 >= cantPAL7 && cantSSL10 >= cantPAL8 && cantSSL10 >= cantPAL9 && 
				 cantSSL10 >= cantPAL10 && cantSSL10 >= cantPAL11 && cantSSL10 >= cantPAL12 && cantSSL10 >= cantPAL13 && cantSSL10 >= cantPAL14 &&
				 cantSSL10 >= cantPAL15 && cantSSL10 >= cantPAL16 && cantSSL10 >= cantSSL5 && cantSSL10 >= cantSSL6 && cantSSL10 >= cantSSL7 &&
				 cantSSL10 >= cantSSL8 && cantSSL10 >= cantSSL9 && cantSSL10 >= cantSSL11 && cantSSL10 >= cantSSL12 && cantSSL10 >= cantSSL13 &&
				 cantSSL10 >= cantSSL14 && cantSSL10 >= cantSSL15 && cantSSL10 >= cantSSL16){
			logger.debug("SS Linea 10 tiene mas servicios");
			cantMayor = cantSSL10;
		}else if(cantSSL11 >= cantPAL5 && cantSSL11 >= cantPAL6 && cantSSL11 >= cantPAL7 && cantSSL11 >= cantPAL8 && cantSSL11 >= cantPAL9 && 
				 cantSSL11 >= cantPAL10 && cantSSL11 >= cantPAL11 && cantSSL11 >= cantPAL12 && cantSSL11 >= cantPAL13 && cantSSL11 >= cantPAL14 &&
				 cantSSL11 >= cantPAL15 && cantSSL11 >= cantPAL16 && cantSSL11 >= cantSSL5 && cantSSL11 >= cantSSL6 && cantSSL11 >= cantSSL7 &&
				 cantSSL11 >= cantSSL8 && cantSSL11 >= cantSSL9 && cantSSL11 >= cantSSL10 && cantSSL11 >= cantSSL12 && cantSSL11 >= cantSSL13 &&
				 cantSSL11 >= cantSSL14 && cantSSL11 >= cantSSL15 && cantSSL11 >= cantSSL16){
			logger.debug("SS Linea 11 tiene mas servicios");
			cantMayor = cantSSL11;
		}else if(cantSSL12 >= cantPAL5 && cantSSL12 >= cantPAL6 && cantSSL12 >= cantPAL7 && cantSSL12 >= cantPAL8 && cantSSL12 >= cantPAL9 && 
				 cantSSL12 >= cantPAL10 && cantSSL12 >= cantPAL11 && cantSSL12 >= cantPAL12 && cantSSL12 >= cantPAL13 && cantSSL12 >= cantPAL14 &&
				 cantSSL12 >= cantPAL15 && cantSSL12 >= cantPAL16 && cantSSL12 >= cantSSL5 && cantSSL12 >= cantSSL6 && cantSSL12 >= cantSSL7 &&
				 cantSSL12 >= cantSSL8 && cantSSL12 >= cantSSL9 && cantSSL12 >= cantSSL10 && cantSSL12 >= cantSSL11 && cantSSL12 >= cantSSL13 &&
				 cantSSL12 >= cantSSL14 && cantSSL12 >= cantSSL15 && cantSSL12 >= cantSSL16){
			logger.debug("SS Linea 12 tiene mas servicios");
			cantMayor = cantSSL12;
		}else if(cantSSL13 >= cantPAL5 && cantSSL13 >= cantPAL6 && cantSSL13 >= cantPAL7 && cantSSL13 >= cantPAL8 && cantSSL13 >= cantPAL9 && 
				 cantSSL13 >= cantPAL10 && cantSSL13 >= cantPAL11 && cantSSL13 >= cantPAL12 && cantSSL13 >= cantPAL13 && cantSSL13 >= cantPAL14 &&
				 cantSSL13 >= cantPAL15 && cantSSL13 >= cantPAL16 && cantSSL13 >= cantSSL5 && cantSSL13 >= cantSSL6 && cantSSL13 >= cantSSL7 &&
				 cantSSL13 >= cantSSL8 && cantSSL13 >= cantSSL9 && cantSSL13 >= cantSSL10 && cantSSL13 >= cantSSL11 && cantSSL13 >= cantSSL12 &&
				 cantSSL13 >= cantSSL14 && cantSSL13 >= cantSSL15 && cantSSL13 >= cantSSL16){
			logger.debug("SS Linea 13 tiene mas servicios");
			cantMayor = cantSSL13;
		}else if(cantSSL14 >= cantPAL5 && cantSSL14 >= cantPAL6 && cantSSL14 >= cantPAL7 && cantSSL14 >= cantPAL8 && cantSSL14 >= cantPAL9 && 
				 cantSSL14 >= cantPAL10 && cantSSL14 >= cantPAL11 && cantSSL14 >= cantPAL12 && cantSSL14 >= cantPAL13 && cantSSL14 >= cantPAL14 &&
				 cantSSL14 >= cantPAL15 && cantSSL14 >= cantPAL16 && cantSSL14 >= cantSSL5 && cantSSL14 >= cantSSL6 && cantSSL14 >= cantSSL7 &&
				 cantSSL14 >= cantSSL8 && cantSSL14 >= cantSSL9 && cantSSL14 >= cantSSL10 && cantSSL14 >= cantSSL11 && cantSSL14 >= cantSSL12 &&
				 cantSSL14 >= cantSSL13 && cantSSL14 >= cantSSL15 && cantSSL14 >= cantSSL16){
			logger.debug("SS Linea 14 tiene mas servicios");
			cantMayor = cantSSL14;
		}else if(cantSSL15 >= cantPAL5 && cantSSL15 >= cantPAL6 && cantSSL15 >= cantPAL7 && cantSSL15 >= cantPAL8 && cantSSL15 >= cantPAL9 && 
				 cantSSL15 >= cantPAL10 && cantSSL15 >= cantPAL11 && cantSSL15 >= cantPAL12 && cantSSL15 >= cantPAL13 && cantSSL15 >= cantPAL14 &&
				 cantSSL15 >= cantPAL15 && cantSSL15 >= cantPAL16 && cantSSL15 >= cantSSL5 && cantSSL15 >= cantSSL6 && cantSSL15 >= cantSSL7 &&
				 cantSSL15 >= cantSSL8 && cantSSL15 >= cantSSL9 && cantSSL15 >= cantSSL10 && cantSSL15 >= cantSSL11 && cantSSL15 >= cantSSL12 &&
				 cantSSL15 >= cantSSL13 && cantSSL15 >= cantSSL14 && cantSSL15 >= cantSSL16){
			logger.debug("SS Linea 15 tiene mas servicios");
			cantMayor = cantSSL15;
		}else if(cantSSL16 >= cantPAL5 && cantSSL16 >= cantPAL6 && cantSSL16 >= cantPAL7 && cantSSL16 >= cantPAL8 && cantSSL16 >= cantPAL9 && 
				 cantSSL16 >= cantPAL10 && cantSSL16 >= cantPAL11 && cantSSL16 >= cantPAL12 && cantSSL16 >= cantPAL13 && cantSSL16 >= cantPAL14 &&
				 cantSSL16 >= cantPAL15 && cantSSL16 >= cantPAL16 && cantSSL16 >= cantSSL5 && cantSSL16 >= cantSSL6 && cantSSL16 >= cantSSL7 &&
				 cantSSL16 >= cantSSL8 && cantSSL16 >= cantSSL9 && cantSSL16 >= cantSSL10 && cantSSL16 >= cantSSL11 && cantSSL16 >= cantSSL12 &&
				 cantSSL16 >= cantSSL13 && cantSSL16 >= cantSSL14 && cantSSL16 >= cantSSL15){
			logger.debug("SS Linea 16 tiene mas servicios");
			cantMayor = cantSSL16;
		}
		return cantMayor;
	}
	//Fin P-CSR-11002 JLGN 24-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	public long getCargoPlanTarif(String codPlanTarif) throws VentasException, CustomerDomainException, RemoteException {
		logger.info("getCargoPlanTarif, inicio");
		long r  = getVentasFacade().getCargoPlanTarif(codPlanTarif);
		logger.info("getCargoPlanTarif, fin");
		return r;
	}
	//Fin P-CSR-11002 JLGN 01-07-2011
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	public long getSecuencia(String nombreSecuencia) throws GeneralException, RemoteException {
		logger.info("getSecuencia, inicio");
		long r  = getOrquestadorFacade().getSecuencia(nombreSecuencia);
		logger.info("getSecuencia, fin");
		return r;
	}
	
	public String descripcionArticulo(String codArticulo) throws CustomerDomainException, RemoteException, VentasException {
		logger.debug("Inicio: descripcionArticulo()");
		String resultado = getOrquestadorFacade().descripcionArticulo(codArticulo);
		logger.debug("Fin: descripcionArticulo()");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 18-10-2011
	
	public HashMap rellenaLinea (HashMap params2, DatosContrato datosContrato, int lineasAnexo2) throws Exception{			
		HashMap params = new HashMap(); //Parametros para el anexo
		params = params2;
		
		//Linea5
		if((4+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 5");
			params.put("numeroLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumCelular() == null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumImei());
			params.put("modeloLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea5",datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(4+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 5 vacia");
			params.put("numeroLinea5","");
			params.put("tipTerminalLinea5","");
			params.put("numImeiLinea5","");
			params.put("modeloLinea5","");
			params.put("numSerieLinea5","");
			params.put("planTarifLinea5","");
			params.put("cargoLinea5","");
			params.put("limiteConsumoLinea5","");
			params.put("ldiSiLinea5","");
			params.put("ldiNoLinea5","");			
		}
		
		//Linea6
		if((5+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 6");
			params.put("numeroLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumImei());
			params.put("modeloLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea6",datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(5+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 6 vacia");
			params.put("numeroLinea6","");
			params.put("tipTerminalLinea6","");
			params.put("numImeiLinea6","");
			params.put("modeloLinea6","");
			params.put("numSerieLinea6","");
			params.put("planTarifLinea6","");
			params.put("cargoLinea6","");
			params.put("limiteConsumoLinea6","");
			params.put("ldiSiLinea6","");
			params.put("ldiNoLinea6","");			
		}	
		
		//Linea7
		if((6+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 7");
			params.put("numeroLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumImei());
			params.put("modeloLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea7",datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(6+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 7 vacia");
			params.put("numeroLinea7","");
			params.put("tipTerminalLinea7","");
			params.put("numImeiLinea7","");
			params.put("modeloLinea7","");
			params.put("numSerieLinea7","");
			params.put("planTarifLinea7","");
			params.put("cargoLinea7","");
			params.put("limiteConsumoLinea7","");
			params.put("ldiSiLinea7","");
			params.put("ldiNoLinea7","");			
		}	
		
		//Linea8
		if((7+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 8");
			params.put("numeroLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumImei());
			params.put("modeloLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea8",datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(7+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 8 vacia");
			params.put("numeroLinea8","");
			params.put("tipTerminalLinea8","");
			params.put("numImeiLinea8","");
			params.put("modeloLinea8","");
			params.put("numSerieLinea8","");
			params.put("planTarifLinea8","");
			params.put("cargoLinea8","");
			params.put("limiteConsumoLinea8","");
			params.put("ldiSiLinea8","");
			params.put("ldiNoLinea8","");			
		}		
		
		//Linea9
		if((8+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 9");
			params.put("numeroLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumImei());
			params.put("modeloLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea9",datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(8+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 9 vacia");
			params.put("numeroLinea9","");
			params.put("tipTerminalLinea9","");
			params.put("numImeiLinea9","");
			params.put("modeloLinea9","");
			params.put("numSerieLinea9","");
			params.put("planTarifLinea9","");
			params.put("cargoLinea9","");
			params.put("limiteConsumoLinea9","");
			params.put("ldiSiLinea9","");
			params.put("ldiNoLinea9","");			
		}
		
		//Linea10
		if((9+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 10");
			params.put("numeroLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumImei());
			params.put("modeloLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea10",datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(9+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 10 vacia");
			params.put("numeroLinea10","");
			params.put("tipTerminalLinea10","");
			params.put("numImeiLinea10","");
			params.put("modeloLinea10","");
			params.put("numSerieLinea10","");
			params.put("planTarifLinea10","");
			params.put("cargoLinea10","");
			params.put("limiteConsumoLinea10","");
			params.put("ldiSiLinea10","");
			params.put("ldiNoLinea10","");			
		}	
		
		//Linea11
		if((10+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 11");
			params.put("numeroLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumImei());
			params.put("modeloLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea11",datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(10+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 11 vacia");
			params.put("numeroLinea11","");
			params.put("tipTerminalLinea11","");
			params.put("numImeiLinea11","");
			params.put("modeloLinea11","");
			params.put("numSerieLinea11","");
			params.put("planTarifLinea11","");
			params.put("cargoLinea11","");
			params.put("limiteConsumoLinea11","");
			params.put("ldiSiLinea11","");
			params.put("ldiNoLinea11","");			
		}
		
		//Linea12
		if((11+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 12");
			params.put("numeroLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumImei());
			params.put("modeloLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea12",datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(11+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 12 vacia");
			params.put("numeroLinea12","");
			params.put("tipTerminalLinea12","");
			params.put("numImeiLinea12","");
			params.put("modeloLinea12","");
			params.put("numSerieLinea12","");
			params.put("planTarifLinea12","");
			params.put("cargoLinea12","");
			params.put("limiteConsumoLinea12","");
			params.put("ldiSiLinea12","");
			params.put("ldiNoLinea12","");			
		}
		
		//Linea13
		if((12+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 13");
			params.put("numeroLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumImei());
			params.put("modeloLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea13",datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(12+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 13 vacia");
			params.put("numeroLinea13","");
			params.put("tipTerminalLinea13","");
			params.put("numImeiLinea13","");
			params.put("modeloLinea13","");
			params.put("numSerieLinea13","");
			params.put("planTarifLinea13","");
			params.put("cargoLinea13","");
			params.put("limiteConsumoLinea13","");
			params.put("ldiSiLinea13","");
			params.put("ldiNoLinea13","");			
		}
		
		//Linea14
		if((13+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 14");
			params.put("numeroLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumImei());
			params.put("modeloLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea14",datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(13+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 14 vacia");
			params.put("numeroLinea14","");
			params.put("tipTerminalLinea14","");
			params.put("numImeiLinea14","");
			params.put("modeloLinea14","");
			params.put("numSerieLinea14","");
			params.put("planTarifLinea14","");
			params.put("cargoLinea14","");
			params.put("limiteConsumoLinea14","");
			params.put("ldiSiLinea14","");
			params.put("ldiNoLinea14","");			
		}	
		
		//Linea15
		if((14+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 15");
			params.put("numeroLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumImei());
			params.put("modeloLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea15",datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(14+lineasAnexo2)].getLdiNO());
		}else{
			logger.debug("linea 15 vacia");
			params.put("numeroLinea15","");
			params.put("tipTerminalLinea15","");
			params.put("numImeiLinea15","");
			params.put("modeloLinea15","");
			params.put("numSerieLinea15","");
			params.put("planTarifLinea15","");
			params.put("cargoLinea15","");
			params.put("limiteConsumoLinea15","");
			params.put("ldiSiLinea15","");
			params.put("ldiNoLinea15","");			
		}
		
		//Linea16
		if((15+lineasAnexo2)<datosContrato.getLineascontrato().length){
			logger.debug("linea 16");
			params.put("numeroLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumCelular()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumCelular());
			params.put("tipTerminalLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getTipTerminal()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getTipTerminal());
			params.put("numImeiLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumImei()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumImei());
			params.put("modeloLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getDesTerminal()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getDesTerminal());
			params.put("numSerieLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumSerie()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getNumSerie());
			params.put("planTarifLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanTarif()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getPlanTarif());
			params.put("cargoLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getCargoPT()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getCargoPT());
			//P-CSR-11002 JLGN 20-10-2011
			params.put("limiteConsumoLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLimiteConsumoLinea()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLimiteConsumoLinea());
			//P-CSR-11002 JLGN 25-10-2011
			params.put("ldiSiLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLdiSI()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLdiSI());
			params.put("ldiNoLinea16",datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLdiNO()== null ? "" : datosContrato.getLineascontrato()[(15+lineasAnexo2)].getLdiNO());	
		}else{
			logger.debug("linea 16 vacia");
			params.put("numeroLinea16","");
			params.put("tipTerminalLinea16","");
			params.put("numImeiLinea16","");
			params.put("modeloLinea16","");
			params.put("numSerieLinea16","");
			params.put("planTarifLinea16","");
			params.put("cargoLinea16","");
			params.put("limiteConsumoLinea16","");
			params.put("ldiSiLinea16","");
			params.put("ldiNoLinea16","");			
		}
		return params;		
	}
	
	public HashMap rellenaSSPAOpcionales(HashMap params2) throws Exception{
		//Linea 5
		params2.put("servSup1Linea5","");
		params2.put("valSS1Linea5","");
		params2.put("servSup2Linea5","");
		params2.put("valSS2Linea5","");
		params2.put("servSup3Linea5","");
		params2.put("valSS3Linea5","");	
		params2.put("servSup4Linea5","");
		params2.put("valSS4Linea5","");
		params2.put("planAdi1Linea5","");
		params2.put("valPA1Linea5","");
		params2.put("planAdi2Linea5","");
		params2.put("valPA2Linea5","");
		params2.put("planAdi3Linea5","");
		params2.put("valPA3Linea5","");
		params2.put("planAdi4Linea5","");
		params2.put("valPA4Linea5","");
		//Linea 6
		params2.put("servSup1Linea6","");
		params2.put("valSS1Linea6","");
		params2.put("servSup2Linea6","");
		params2.put("valSS2Linea6","");
		params2.put("servSup3Linea6","");
		params2.put("valSS3Linea6","");	
		params2.put("servSup4Linea6","");
		params2.put("valSS4Linea6","");
		params2.put("planAdi1Linea6","");
		params2.put("valPA1Linea6","");
		params2.put("planAdi2Linea6","");
		params2.put("valPA2Linea6","");
		params2.put("planAdi3Linea6","");
		params2.put("valPA3Linea6","");
		params2.put("planAdi4Linea6","");
		params2.put("valPA4Linea6","");
		//Linea 7
		params2.put("servSup1Linea7","");
		params2.put("valSS1Linea7","");
		params2.put("servSup2Linea7","");
		params2.put("valSS2Linea7","");
		params2.put("servSup3Linea7","");
		params2.put("valSS3Linea7","");	
		params2.put("servSup4Linea7","");
		params2.put("valSS4Linea7","");
		params2.put("planAdi1Linea7","");
		params2.put("valPA1Linea7","");
		params2.put("planAdi2Linea7","");
		params2.put("valPA2Linea7","");
		params2.put("planAdi3Linea7","");
		params2.put("valPA3Linea7","");
		params2.put("planAdi4Linea7","");
		params2.put("valPA4Linea7","");
		//Linea 8
		params2.put("servSup1Linea8","");
		params2.put("valSS1Linea8","");
		params2.put("servSup2Linea8","");
		params2.put("valSS2Linea8","");
		params2.put("servSup3Linea8","");
		params2.put("valSS3Linea8","");	
		params2.put("servSup4Linea8","");
		params2.put("valSS4Linea8","");
		params2.put("planAdi1Linea8","");
		params2.put("valPA1Linea8","");
		params2.put("planAdi2Linea8","");
		params2.put("valPA2Linea8","");
		params2.put("planAdi3Linea8","");
		params2.put("valPA3Linea8","");
		params2.put("planAdi4Linea8","");
		params2.put("valPA4Linea8","");
		//Linea 9
		params2.put("servSup1Linea9","");
		params2.put("valSS1Linea9","");
		params2.put("servSup2Linea9","");
		params2.put("valSS2Linea9","");
		params2.put("servSup3Linea9","");
		params2.put("valSS3Linea9","");	
		params2.put("servSup4Linea9","");
		params2.put("valSS4Linea9","");
		params2.put("planAdi1Linea9","");
		params2.put("valPA1Linea9","");
		params2.put("planAdi2Linea9","");
		params2.put("valPA2Linea9","");
		params2.put("planAdi3Linea9","");
		params2.put("valPA3Linea9","");
		params2.put("planAdi4Linea9","");
		params2.put("valPA4Linea9","");
		//Linea 10
		params2.put("servSup1Linea10","");
		params2.put("valSS1Linea10","");
		params2.put("servSup2Linea10","");
		params2.put("valSS2Linea10","");
		params2.put("servSup3Linea10","");
		params2.put("valSS3Linea10","");	
		params2.put("servSup4Linea10","");
		params2.put("valSS4Linea10","");
		params2.put("planAdi1Linea10","");
		params2.put("valPA1Linea10","");
		params2.put("planAdi2Linea10","");
		params2.put("valPA2Linea10","");
		params2.put("planAdi3Linea10","");
		params2.put("valPA3Linea10","");
		params2.put("planAdi4Linea10","");
		params2.put("valPA4Linea10","");
		//Linea 11
		params2.put("servSup1Linea11","");
		params2.put("valSS1Linea11","");
		params2.put("servSup2Linea11","");
		params2.put("valSS2Linea11","");
		params2.put("servSup3Linea11","");
		params2.put("valSS3Linea11","");	
		params2.put("servSup4Linea11","");
		params2.put("valSS4Linea11","");
		params2.put("planAdi1Linea11","");
		params2.put("valPA1Linea11","");
		params2.put("planAdi2Linea11","");
		params2.put("valPA2Linea11","");
		params2.put("planAdi3Linea11","");
		params2.put("valPA3Linea11","");
		params2.put("planAdi4Linea11","");
		params2.put("valPA4Linea11","");
		//Linea 12
		params2.put("servSup1Linea12","");
		params2.put("valSS1Linea12","");
		params2.put("servSup2Linea12","");
		params2.put("valSS2Linea12","");
		params2.put("servSup3Linea12","");
		params2.put("valSS3Linea12","");	
		params2.put("servSup4Linea12","");
		params2.put("valSS4Linea12","");
		params2.put("planAdi1Linea12","");
		params2.put("valPA1Linea12","");
		params2.put("planAdi2Linea12","");
		params2.put("valPA2Linea12","");
		params2.put("planAdi3Linea12","");
		params2.put("valPA3Linea12","");
		params2.put("planAdi4Linea12","");
		params2.put("valPA4Linea12","");
		//Linea 13
		params2.put("servSup1Linea13","");
		params2.put("valSS1Linea13","");
		params2.put("servSup2Linea13","");
		params2.put("valSS2Linea13","");
		params2.put("servSup3Linea13","");
		params2.put("valSS3Linea13","");	
		params2.put("servSup4Linea13","");
		params2.put("valSS4Linea13","");
		params2.put("planAdi1Linea13","");
		params2.put("valPA1Linea13","");
		params2.put("planAdi2Linea13","");
		params2.put("valPA2Linea13","");
		params2.put("planAdi3Linea13","");
		params2.put("valPA3Linea13","");
		params2.put("planAdi4Linea13","");
		params2.put("valPA4Linea13","");
		//Linea 14
		params2.put("servSup1Linea14","");
		params2.put("valSS1Linea14","");
		params2.put("servSup2Linea14","");
		params2.put("valSS2Linea14","");
		params2.put("servSup3Linea14","");
		params2.put("valSS3Linea14","");	
		params2.put("servSup4Linea14","");
		params2.put("valSS4Linea14","");
		params2.put("planAdi1Linea14","");
		params2.put("valPA1Linea14","");
		params2.put("planAdi2Linea14","");
		params2.put("valPA2Linea14","");
		params2.put("planAdi3Linea14","");
		params2.put("valPA3Linea14","");
		params2.put("planAdi4Linea14","");
		params2.put("valPA4Linea14","");
		//Linea 15
		params2.put("servSup1Linea15","");
		params2.put("valSS1Linea15","");
		params2.put("servSup2Linea15","");
		params2.put("valSS2Linea15","");
		params2.put("servSup3Linea15","");
		params2.put("valSS3Linea15","");	
		params2.put("servSup4Linea15","");
		params2.put("valSS4Linea15","");
		params2.put("planAdi1Linea15","");
		params2.put("valPA1Linea15","");
		params2.put("planAdi2Linea15","");
		params2.put("valPA2Linea15","");
		params2.put("planAdi3Linea15","");
		params2.put("valPA3Linea15","");
		params2.put("planAdi4Linea15","");
		params2.put("valPA4Linea15","");
		//Linea 16
		params2.put("servSup1Linea16","");
		params2.put("valSS1Linea16","");
		params2.put("servSup2Linea16","");
		params2.put("valSS2Linea16","");
		params2.put("servSup3Linea16","");
		params2.put("valSS3Linea16","");	
		params2.put("servSup4Linea16","");
		params2.put("valSS4Linea16","");
		params2.put("planAdi1Linea16","");
		params2.put("valPA1Linea16","");
		params2.put("planAdi2Linea16","");
		params2.put("valPA2Linea16","");
		params2.put("planAdi3Linea16","");
		params2.put("valPA3Linea16","");
		params2.put("planAdi4Linea16","");
		params2.put("valPA4Linea16","");
		
		return params2;
	}
	
	public HashMap ssOpcionalVacio(HashMap params2, String numLinea) throws Exception{
		params2.put("servSup1Linea"+numLinea,"");
		params2.put("valSS1Linea"+numLinea,"");
		params2.put("servSup2Linea"+numLinea,"");
		params2.put("valSS2Linea"+numLinea,"");
		params2.put("servSup3Linea"+numLinea,"");
		params2.put("valSS3Linea"+numLinea,"");	
		params2.put("servSup4Linea"+numLinea,"");
		params2.put("valSS4Linea"+numLinea,"");
		return params2;		
	}
	
	public HashMap paOpcionalVacio(HashMap params2, String numLinea) throws Exception{
		params2.put("planAdi1Linea"+numLinea,"");
		params2.put("valPA1Linea"+numLinea,"");
		params2.put("planAdi2Linea"+numLinea,"");
		params2.put("valPA2Linea"+numLinea,"");
		params2.put("planAdi3Linea"+numLinea,"");
		params2.put("valPA3Linea"+numLinea,"");
		params2.put("planAdi4Linea"+numLinea,"");
		params2.put("valPA4Linea"+numLinea,"");
		return params2;		
	}
	
	public HashMap rellenaSSPAOpcionalesContrato(HashMap params2) throws Exception{
		//Linea 1
		params2.put("servSup1Linea1","");
		params2.put("valSS1Linea1","");
		params2.put("servSup2Linea1","");
		params2.put("valSS2Linea1","");
		params2.put("servSup3Linea1","");
		params2.put("valSS3Linea1","");	
		params2.put("servSup4Linea1","");
		params2.put("valSS4Linea1","");
		params2.put("planAdi1Linea1","");
		params2.put("valPA1Linea1","");
		params2.put("planAdi2Linea1","");
		params2.put("valPA2Linea1","");
		params2.put("planAdi3Linea1","");
		params2.put("valPA3Linea1","");
		params2.put("planAdi4Linea1","");
		params2.put("valPA4Linea1","");
		//Linea 2
		params2.put("servSup1Linea2","");
		params2.put("valSS1Linea2","");
		params2.put("servSup2Linea2","");
		params2.put("valSS2Linea2","");
		params2.put("servSup3Linea2","");
		params2.put("valSS3Linea2","");	
		params2.put("servSup4Linea2","");
		params2.put("valSS4Linea2","");
		params2.put("planAdi1Linea2","");
		params2.put("valPA1Linea2","");
		params2.put("planAdi2Linea2","");
		params2.put("valPA2Linea2","");
		params2.put("planAdi3Linea2","");
		params2.put("valPA3Linea2","");
		params2.put("planAdi4Linea2","");
		params2.put("valPA4Linea2","");
		//Linea 3
		params2.put("servSup1Linea3","");
		params2.put("valSS1Linea3","");
		params2.put("servSup2Linea3","");
		params2.put("valSS2Linea3","");
		params2.put("servSup3Linea3","");
		params2.put("valSS3Linea3","");	
		params2.put("servSup4Linea3","");
		params2.put("valSS4Linea3","");
		params2.put("planAdi1Linea3","");
		params2.put("valPA1Linea3","");
		params2.put("planAdi2Linea3","");
		params2.put("valPA2Linea3","");
		params2.put("planAdi3Linea3","");
		params2.put("valPA3Linea3","");
		params2.put("planAdi4Linea3","");
		params2.put("valPA4Linea3","");
		//Linea 4
		params2.put("servSup1Linea4","");
		params2.put("valSS1Linea4","");
		params2.put("servSup2Linea4","");
		params2.put("valSS2Linea4","");
		params2.put("servSup3Linea4","");
		params2.put("valSS3Linea4","");	
		params2.put("servSup4Linea4","");
		params2.put("valSS4Linea4","");
		params2.put("planAdi1Linea4","");
		params2.put("valPA1Linea4","");
		params2.put("planAdi2Linea4","");
		params2.put("valPA2Linea4","");
		params2.put("planAdi3Linea4","");
		params2.put("valPA3Linea4","");
		params2.put("planAdi4Linea4","");
		params2.put("valPA4Linea4","");	
		
		return params2;
	}
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public String obtenerNombreFactura(long numVenta) throws CustomerDomainException, RemoteException, VentasException{
		logger.debug("obtenerNombreFactura():start");		
		String resultado =getVentasFacade().obtenerNombreFactura(numVenta);
		logger.debug("obtenerNombreFactura():end");
		return resultado;
	}
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public String obtenerRutaContrato(long numVenta) throws CustomerDomainException, RemoteException, VentasException{
		logger.debug("obtenerRutaContrato():start");		
		String resultado =getVentasFacade().obtenerRutaContrato(numVenta);
		logger.debug("obtenerRutaContrato():end");
		return resultado;
	}
	
	//Inicio P-CSR-11002 JLGN 14-11-2011
	public void validaDisponibilidadNumero(String numCelular)throws ProductDomainException, RemoteException, VentasException 
	{
		logger.debug("validaDisponibilidadNumero:start");
		getVentasFacade().validaDisponibilidadNumero(numCelular);
		logger.debug("validaDisponibilidadNumero:end");
	}
	
	//Inicio MA-180655 HOM
	public DatosAnexoTerminalesDTO getDatosAnexoTerminales(Long numVenta) throws CustomerDomainException, RemoteException, VentasException, AltaClienteException{
		logger.debug("getDatosAnexoTerminales():start");
		DatosAnexoTerminalesDTO resultado = getAltaClienteFacade().getDatosAnexoTerminales(numVenta);
		logger.debug("getDatosAnexoTerminales():end");
		return resultado;		
	}
}
