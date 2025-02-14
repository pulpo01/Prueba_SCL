/**
 * 
 */
package com.tmmas.cl.scl.ventas.negocio.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleCargosSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleLineaSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetallePrecioSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroResultadoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SimcardInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SimcardOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioActInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteCOLDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConceptoVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DependenciasModalidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DetalleInformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.EstadoProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoAfinidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.InformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoCargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasListOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanIndemnizacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoContratoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TiposContratoListOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ReporteScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.SolScoringVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ResourceDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.TOLException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FormasPagoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametroDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroSolicitudesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioInDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorOutDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DireccionesListOutDTO;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EquipoKitDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.IpDTO;
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
import com.tmmas.cl.scl.ventas.service.servicios.VentasSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="VentasFacadeSTL"	
 *           description="An EJB named VentasFacadeSTL"
 *           display-name="VentasFacadeSTL"
 *           jndi-name="VentasFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class VentasFacadeSTLBean implements javax.ejb.SessionBean {
	
	private static final long serialVersionUID = 1L;
	private VentasSrv srv = new VentasSrv();
	private final Logger logger = Logger.getLogger(VentasFacadeSTLBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;	
	
	
	
	public VentasFacadeSTLBean() {
		logger.debug("VentasFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("VentasFacadeSTLBean():End");
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
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  String prueba()  
	throws VentasException, RemoteException
	{	
		
		return  srv.prueba();
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
	/*public  UsuarioDTO getUsuarios(UsuarioDTO entrada) 
		throws VentasException, RemoteException
	{
		cat.debug("Ingreso a getUsuarios de VentasEJB");
		cat.debug("getListadoCampanasVigentes:start");
		UsuarioDTO ret; 
		try {
			ret = srv.getUsuarios(entrada) ;
		}
		catch(CustomerDomainException e){
			cat.debug("getListadoCampanasVigentes:end");
			cat.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		cat.debug("getListadoCampanasVigentes:end");
		return ret;
	}*/
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  VendedorOutDTO lstVendedor(VendedorDTO vendedor) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("lstVendedor:start");
		VendedorOutDTO ret; 
		try {
			ret = srv.lstVendedor(vendedor);
		}
		catch(CustomerDomainException e){
			logger.debug("getListadoCampanasVigentes:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCampanasVigentes:end");
		return ret;
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
	public  void updUsuario(UsuarioInDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("updUsuario:start");
		try {
			srv.updUsuario(entrada) ;
		}
		catch(CustomerDomainException e){
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("updUsuario:start");
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

	public DireccionesListOutDTO lstDirecCliente(DirecClienteDTO lstDireccion)
		throws CustomerDomainException,RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:lstDirecCliente");
		DireccionesListOutDTO ret = new DireccionesListOutDTO();
		ret = srv.lstDirecCliente(lstDireccion);
		logger.debug("Fin:lstDirecCliente");
		return ret;
	}// fin lstDireccion
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  CampanaVigenteDTO[] getListadoCampanasVigentes()  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCampanasVigentes:start");
		CampanaVigenteDTO[] ret; 
		try {
			ret = srv.getListadoCampanasVigentes();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCampanasVigentes:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getMessage());
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoCampanasVigentes:end");
		return ret;
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
	public  CausalDescuentoDTO[] getListadoCausalDescuento(Long codUso)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCausalDescuento:star");
		CausalDescuentoDTO[] ret; 
		try {
			ret = srv.getListadoCausalDescuento(codUso);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCausalDescuento:end");
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
		logger.debug("getListadoCausalDescuento:star");
		return ret;
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
	public CreditoConsumoDTO[] getListadoCreditoConsumo(CreditoConsumoDTO creditoConsumoDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCreditoConsumo:star");
		CreditoConsumoDTO[] ret; 
		try {
			ret = srv.getListadoCreditoConsumo(creditoConsumoDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCreditoConsumo:end");
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
		logger.debug("getListadoCreditoConsumo:star");
		return ret;
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
	public CreditoMorosidadDTO[] getListadoCreditoMorosidad(DatosComercialesDTO datoscomerciales)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCreditoMorosidad:star");
		CreditoMorosidadDTO[] ret; 
		try {
			ret = srv.getListadoCreditoMorosidad(datoscomerciales);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCreditoMorosidad:end");
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
		logger.debug("getListadoCreditoMorosidad:end");
		return ret;
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
	public GrupoAfinidadDTO[] getListadoGrupoAfinidad(DatosComercialesDTO datoscomerciales)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoGrupoAfinidad:star");
		GrupoAfinidadDTO[] ret; 
		try {
			ret = srv.getListadoGrupoAfinidad(datoscomerciales);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoGrupoAfinidad:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoGrupoAfinidad:end");
		return ret;
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
	public GrupoCobroServicioDTO[] getListadoGrupoCobroServicio()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoGrupoCobroServicio:star");
		GrupoCobroServicioDTO[] ret; 
		try {
			ret = srv.getListadoGrupoCobroServicio();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoGrupoCobroServicio:end");
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
		logger.debug("getListadoGrupoCobroServicio:end");
		return ret;
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
	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoModalidadPago:star");
		ModalidadPagoDTO[] ret; 
		try {
			ret = srv.getListadoModalidadPago(modalidad);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoModalidadPago:end");
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
		logger.debug("getListadoModalidadPago:star");
		return ret;
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
	public PlanIndemnizacionDTO[] getListadoPlanIndemnizacion()  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoPlanIndemnizacion:star");
		PlanIndemnizacionDTO[] ret; 
		try {
			ret = srv.getListadoPlanIndemnizacion();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoPlanIndemnizacion:end");
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
		logger.debug("getListadoPlanIndemnizacion:star");
		return ret;
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
	public PlanServicioDTO[] getListadoPlanServicio(PlanServicioDTO entrada)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoPlanServicio:start");
		PlanServicioDTO[] ret; 
		try {
			ret = srv.getListadoPlanServicio(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoPlanServicio:end");
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
		logger.debug("getListadoPlanServicio:start");
		return ret;
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
	public ClienteDTO getCliente(ClienteDTO cliente)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getCliente:start");
		ClienteDTO resultado = new ClienteDTO(); 
		try {
			resultado = srv.getCliente(cliente);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getCliente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
			//throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCliente:end");
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
	public ContratoDTO listadoContratosCliente(ContratoDTO contrato)  
		throws VentasException, RemoteException
    {
		UtilLog.setLog(config.getString("VentasEJB.log"));
	    logger.debug("listadoContratosCliente:start");
	    ContratoDTO ret; 
		try {
			ret = srv.listadoContratosCliente(contrato);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("listadoContratosCliente:end");
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
	logger.debug("listadoContratosCliente:end");
	return ret;
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
	public VendedorDTO getVendedor(VendedorDTO vendedor)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getVendedor:start");
		VendedorDTO ret; 
		try {
			ret = srv.getVendedor(vendedor);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getVendedor:end");
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
		logger.debug("getVendedor:end");
		return ret;
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
	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoTipoContrato:start");
		ContratoDTO[] ret; 
		try {
			ret = srv.getListadoTipoContrato(contrato);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoTipoContrato:end");
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
		logger.debug("getListadoTipoContrato:start");
		return ret;
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
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoNumeroMesesContrato:start");
		ContratoDTO ret; 
		try {
			ret = srv.getListadoNumeroMesesContrato(contrato);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoNumeroMesesContrato:end");
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
		logger.debug("getListadoNumeroMesesContrato:start");
		return ret;
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
	public ContratoDTO getTipoContrato(ContratoDTO contrato)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getTipoContrato:start");
		ContratoDTO ret = new ContratoDTO(); 
		try {
			ret = srv.getTipoContrato(contrato);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getTipoContrato:end");
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
		logger.debug("getTipoContrato:start");
		return ret;
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
	public NumeroCuotasDTO[] getListadoNumeroCuotas(ModalidadPagoDTO modalidad)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoNumeroCuotas:start");
		NumeroCuotasDTO[] ret; 
		try {
			ret = srv.getListadoNumeroCuotas(modalidad);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoNumeroCuotas:end");
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
		logger.debug("getListadoNumeroCuotas:start");
		return ret;
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
	public DocumentoDTO getListadoTipoDocumento(DatosComercialesDTO datoscomerciales)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoTipoDocumento:start");
		DocumentoDTO ret; 
		try {
			ret = srv.getListadoTipoDocumento(datoscomerciales);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoTipoDocumento:end");
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
		logger.debug("getListadoTipoDocumento:end");
		return ret;
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
	public RegionDTO[] getListadoRegiones()  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoRegiones:start");
		RegionDTO[] ret; 
		try {
			ret = srv.getListadoRegiones();
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoRegiones:end");
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
		logger.debug("getListadoRegiones:end");
		return ret;
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
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoProvincias:start");
		ProvinciaDTO[] ret; 
		try {
			ret = srv.getListadoProvincias(region);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoProvincias:end");
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
		logger.debug("getListadoProvincias:end");
		return ret;
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
	public CiudadDTO[] getListadoCiudades(ProvinciaDTO provincia)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCiudades:start");
		CiudadDTO[] ret; 
		try {
			ret = srv.getListadoCiudades(provincia);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCiudades:end");
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
		logger.debug("getListadoCiudades:end");
		return ret;
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
	public EstadoProcesoDTO getProgreso(EstadoProcesoDTO progreso)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getProgreso:start");
		EstadoProcesoDTO ret; 
		try {
			ret = srv.getProgreso(progreso);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getProgreso:end");
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
		logger.debug("getProgreso:end");
		return ret;
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
	public ResultadoValidacionVentaDTO validacionLinea(ParametrosValidacionVentasDTO entradaValidacionVentas)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("validacionLinea:start");
		ResultadoValidacionVentaDTO ret=null; 
		try {
			ret = srv.validacionLinea(entradaValidacionVentas);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("validacionLinea:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//throw new VentasException(e.getMessage(),e);
			ret = new ResultadoValidacionVentaDTO();
			ret.setEstado("NOK");
			ret.setDetalleEstado("Línea no cumple validación de ventas");
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//throw new VentasException(e);
			ret.setEstado("NOK");
			ret.setDetalleEstado("Línea no cumple validación de ventas");
		}
		logger.debug("validacionLinea:end");
		return ret;
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
	public void insertaProceso(EstadoProcesoDTO proceso)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("insertaProceso:start");
		try {
			srv.insertaProceso(proceso);
		}
		catch(CustomerDomainException e){
			logger.debug("insertaProceso:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertaProceso:end");
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
	public void modificaProceso(EstadoProcesoDTO proceso)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("modificaProceso:start");
		try {
			srv.modificaProceso(proceso);
		}
		catch(CustomerDomainException e){
			logger.debug("modificaProceso:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("modificaProceso:end");
		
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
	public void eliminaProceso(EstadoProcesoDTO proceso)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("eliminaProceso:start");
		try {
			srv.eliminaProceso(proceso);
		}
		catch(CustomerDomainException e){
			logger.debug("eliminaProceso:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("eliminaProceso:end");
		
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
	public DatosValidacionDTO getValidaNuevoContratoCliente(ContratoDTO contrato)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getValidaNuevoContratoCliente:start");
		DatosValidacionDTO ret = new DatosValidacionDTO(); 
		try {
			ret = srv.getValidaNuevoContratoCliente(contrato);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getValidaNuevoContratoCliente:end");
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
		logger.debug("getValidaNuevoContratoCliente:end");
		return ret;
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
	public ResultadoValidacionVentaDTO existeEvaluacionRiesgo(ParametrosValidacionVentasDTO parametroEvaluacion)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("existeEvaluacionRiesgo:start");
		ResultadoValidacionVentaDTO ret = new ResultadoValidacionVentaDTO(); 
		try {
			ret = srv.existeEvaluacionRiesgo(parametroEvaluacion);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("existeEvaluacionRiesgo:end");
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
		logger.debug("existeEvaluacionRiesgo:end");
		return ret;
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
	public ResultadoValidacionVentaDTO existeEvalRiesgoPlanTarif(ParametrosValidacionVentasDTO parametroEvaluacion)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("existeEvalRiesgoPlanTarif:start");
		ResultadoValidacionVentaDTO ret = new ResultadoValidacionVentaDTO(); 
		try {
			ret = srv.existeEvalRiesgoPlanTarif(parametroEvaluacion);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("existeEvalRiesgoPlanTarif:end");
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
		logger.debug("existeEvalRiesgoPlanTarif:end");
		return ret;
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
	public void bloqueaDesbloqueaVendedor(VendedorDTO vendedor)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:bloqueaDesbloqueaVendedor");
		try {
			srv.bloqueaDesbloqueaVendedor(vendedor);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("bloqueaDesbloqueaVendedor:end");
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
		logger.debug("Fin:bloqueaDesbloqueaVendedor");
	}//fin bloqueaDesbloqueaVendedor

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaDTO getCuenta(CuentaDTO cuentaDTO)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getCuenta");
		CuentaDTO ret; 
		try {
			ret = srv.getCuenta(cuentaDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getCuenta:end");
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
		logger.debug("Fin:getCuenta");
		return ret;
	}//fin getCuenta
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public UsuarioDTO creaUsuario(UsuarioDTO usuarioWS) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:creaUsuario");
		UsuarioDTO ret; 
		try {
			ret = srv.creacionUsuario(usuarioWS);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("creaUsuario:end");
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
		logger.debug("Fin:creaUsuario");
		return ret;
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
	public ParametroDTO getValorParametro(ParametroDTO parametroEntrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getValorParametro");
		ParametroDTO ret = new ParametroDTO(); 
		try {
			ret = srv.getValorParametro(parametroEntrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getValorParametro:end");
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
		logger.debug("Fin:getValorParametro");
		return ret;
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
	public UsuarioDTO getSecuenciaUsuario()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getSecuenciaUsuario");
		UsuarioDTO ret = new UsuarioDTO(); 
		try {
			ret = srv.getSecuenciaUsuario();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getSecuenciaUsuario:end");
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
		logger.debug("Fin:getSecuenciaUsuario");
		return ret;
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
	public CuentaDTO getSubCuenta(CuentaDTO entrada) 
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getSubCuenta");
		CuentaDTO ret = new CuentaDTO(); 
		try {
			ret = srv.getSubCuenta(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getSubCuenta:end");
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
		logger.debug("Fin:getSubCuenta");
		return ret;
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
	public AbonadoDTO getOficinaPrincipal (VendedorDTO entrada)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getOficinaPrincipal");
		AbonadoDTO ret = new AbonadoDTO(); 
		try {
			ret = srv.getOficinaPrincipal(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getOficinaPrincipal:end");
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
		logger.debug("Fin:getOficinaPrincipal");
		return ret;
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
	public AbonadoDTO getSecuenciaAbonado()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getSecuenciaAbonado");
		AbonadoDTO ret = new AbonadoDTO(); 
		try {
			ret = srv.getSecuenciaAbonado();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getSecuenciaAbonado:end");
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
		logger.debug("Fin:getSecuenciaAbonado");
		return ret;
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
	public RegistroVentaDTO getSecuenciaVenta()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getSecuenciaVenta");
		RegistroVentaDTO ret = new RegistroVentaDTO(); 
		try {
			ret = srv.getSecuenciaVenta();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getSecuenciaVenta:end");
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
		logger.debug("Fin:getSecuenciaVenta");
		return ret;
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
	public RegistroVentaDTO getSecuenciaTransacabo()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getSecuenciaTransacabo");
		RegistroVentaDTO ret = new RegistroVentaDTO(); 
		try {
			ret = srv.getSecuenciaTransacabo();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getSecuenciaTransacabo:end");
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
		logger.debug("Fin:getSecuenciaTransacabo");
		return ret;
	}//fin getSecuenciaTransacabo
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void creaAbonado(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:creaAbonado");
		try {
			srv.creaAbonado(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("creaAbonado:end");
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
		logger.debug("Fin:creaAbonado");
		
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
	public void creaSimcardAboser(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:creaSimcardAboser");
		try {
			srv.creaSimcardAboser(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("creaSimcardAboser:end");
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
		logger.debug("Fin:creaSimcardAboser");
		
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
	public void creaTerminalAboser(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:creaTerminalAboser");
		try {
			srv.creaTerminalAboser(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("creaTerminalAboser:end");
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
		logger.debug("Fin:creaTerminalAboser");
		
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
	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getPrefijoMin");
		RegistroVentaDTO ret = new RegistroVentaDTO(); 
		try {
			ret= srv.getPrefijoMin(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getPrefijoMin:end");
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
		logger.debug("Fin:getPrefijoMin");
		return ret;
		
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
	public ModalidadPagoDTO getModalidadPago(ModalidadPagoDTO modalidad)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getModalidadPago");
		ModalidadPagoDTO ret = new ModalidadPagoDTO(); 
		try {
			ret= srv.getModalidadPago(modalidad);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getModalidadPago:end");
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
		logger.debug("Fin:getModalidadPago");
		return ret;
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
	public void creaSSAbonado(ServicioSuplementarioDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:creaSSAbonado");
		try {
			srv.creaSSAbonado(entrada);
		}
		catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("creaSSAbonado:end");
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
		logger.debug("Fin:creaSSAbonado");
		
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
	public CeldaDTO obtieneDatosCelda(CeldaDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		CeldaDTO resultado = new CeldaDTO();
		logger.debug("Inicio:obtieneDatosCelda");
		try {
			resultado = srv.obtieneDatosCelda(entrada);
		}
		catch(ResourceDomainException e){
			context.setRollbackOnly();
			logger.debug("obtieneDatosCelda:end");
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
		logger.debug("Fin:obtieneDatosCelda");
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
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		CentralDTO[] resultado = null;
		logger.debug("Inicio:getListadoCentrales");
		try {
			resultado = srv.getListadoCentrales(entrada);
		}
		catch(ResourceDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCentrales:end");
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
		logger.debug("Fin:getListadoCentrales");
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
	public CeldaDTO[] getListadoCeldas(CiudadDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		CeldaDTO[] resultado = null;
		logger.debug("Inicio:getListadoCeldas");
		try {
			resultado = srv.getListadoCeldas(entrada);
		}
		catch(ResourceDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCeldas:end");
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
		logger.debug("Fin:getListadoCeldas");
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
	public CelularDTO getNumeroCelularAut(CelularDTO entrada) 
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		CelularDTO resultado = null;
		logger.debug("Inicio:getNumeroCelularAut");
		try {
			resultado = srv.getNumeroCelularAut(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getNumeroCelularAut:end");
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
		logger.debug("Fin:getNumeroCelularAut");
		return resultado;
	}//fin getNumeroCelularAut
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CelularDTO setReservaNumeroCelular(CelularDTO entrada) 
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		CelularDTO resultado = null;
		logger.debug("Inicio:setReservaNumeroCelular");
		try {
			resultado = srv.setReservaNumeroCelular(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("setReservaNumeroCelular:end");
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
		logger.debug("Fin:setReservaNumeroCelular");
		return resultado;
	}//fin setReservaNumeroCelular
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RegistroEvaluacionRiesgoDTO getEvalRiesgoPlanTarif(RegistroEvaluacionRiesgoDTO entrada)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		RegistroEvaluacionRiesgoDTO resultado = null;
		logger.debug("Inicio:getEvalRiesgoPlanTarif");
		try {
			resultado = srv.getEvalRiesgoPlanTarif(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getEvalRiesgoPlanTarif:end");
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
		logger.debug("Fin:getEvalRiesgoPlanTarif");
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
	public DatosGeneralesVentaDTO crearLinea(DatosGeneralesVentaDTO datosGeneralesVentas,UsuarioActInDTO  usuarioWS)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		DatosGeneralesVentaDTO resultado = null;
		logger.debug("creacionLinea:start");
		//ParametrosValidacionVentasDTO ret; //-- ??? 
		try {
			//ret = srv.creacionLineas(datosGeneralesVentas); //-- ???
			resultado = srv.creacionLineas(datosGeneralesVentas, usuarioWS);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			
			logger.debug("10/05/07 Error Prueba:end");
			logger.debug("creacionLinea:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
				context.setRollbackOnly();
				
				logger.debug("10/05/07 Error Prueba:end");
				logger.debug("creacionLinea:end");
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
		logger.debug("creacionLinea:end");
		return resultado;
	}//fin creacionLinea

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCreditoConsumo:star");
		AbonadoDTO[] ret; 
		try {
			ret = srv.getListaAbonadosVenta(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Inicio:getListaAbonadosVenta()");
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
		logger.debug("Fin:getListaAbonadosVenta()");
		return ret;
	}//fin getListaAbonadosVenta

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO entrada)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		ObtencionCargosDTO resultado;
		logger.debug("Inicio:obtenerCargos");
		try {
			
			resultado = srv.obtenerCargos(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:obtenerCargos");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:obtenerCargos");
			logger.debug("ProductDomainException");
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
		logger.debug("Fin:obtenerCargos");
		return resultado;
	}//fin obtenerCargos
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametrosObtencionCargosDTO validacionesGeneralesCargos(ParametrosObtencionCargosDTO parametros)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		ParametrosObtencionCargosDTO resultado = new ParametrosObtencionCargosDTO();
		logger.debug("Inicio:validacionesGeneralesCargos");
		try {
			
			resultado = srv.validacionesGeneralesCargos(parametros);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:validacionesGeneralesCargos");
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
		logger.debug("Fin:validacionesGeneralesCargos");
		return resultado;
	}//fin validacionesGeneralesCargos

	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoValidacionVentaDTO validaCodigoVendedor (VendedorDTO vendedordto)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		ResultadoValidacionVentaDTO resultadovalidacion;
		logger.debug("Inicio:validaCodigoVendedor");
		try {
			resultadovalidacion = srv.validaCodigoVendedor(vendedordto);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:validaCodigoVendedor");
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
		logger.debug("Fin:validaCodigoVendedor");
		return resultadovalidacion;
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoRegistroCargosDTO registrarCargos(ParametrosRegistroCargosDTO cargos)
		throws RemoteException, GeneralException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		ResultadoRegistroCargosDTO resultadoRegistroCargos;
		logger.debug("Inicio:registrarCargos");
		try {
		
			resultadoRegistroCargos = srv.registrarCargos(cargos);			
		}catch(FrameworkCargosException e){
			context.setRollbackOnly();
			logger.debug("Fin:registrarCargos");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:registrarCargos");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:registrarCargos");
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch (GeneralException e) {
			logger.debug("GeneralException");
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			logger.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
			throw e;			
		} catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:registrarCargos");
		return resultadoRegistroCargos;
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
	public FormasPagoDTO[] obtenerFormasPago(ParametrosRegistroCargosDTO parametrosCargos)
		throws VentasException, RemoteException
	{		
		UtilLog.setLog(config.getString("VentasEJB.log"));
		FormasPagoDTO[] arrayFormasPago = null;
		try {
			arrayFormasPago = srv.obtenerFormasPago(parametrosCargos);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
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
		return arrayFormasPago;		
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
	public void cierreVenta(GaVentasDTO gaVentasDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("cierreVenta:start");		
		try {			
			srv.cierreVenta(gaVentasDTO);
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("cierreVenta:end");
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("cierreVenta:end");
			logger.debug("ProductDomainException");
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
		logger.debug("cierreVenta:end");
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
	public String FormatearValor(Float Valor)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		String valor= new String();
		logger.debug("Formatea Valor:start");		
		try {			
			valor= srv.FormatearValor(Valor);
			
		}catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("cierreVenta:end");
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("cierreVenta:end");
			logger.debug("ProductDomainException");
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
		logger.debug("cierreVenta:end");
		return valor;
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
	public ResultadoValidacionDTO validacionesGeneralesCargo(ParametrosValidacionDTO entrada) 
		throws VentasException, RemoteException
	{		
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("validacionesGeneralesCargo:start");
		ResultadoValidacionDTO resultado=new ResultadoValidacionDTO();
		try {
			
			resultado=srv.validacionesGeneralesCargo(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("validacionesGeneralesCargo:end");
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("validacionesGeneralesCargo:end");
			logger.debug("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validacionesGeneralesCargo:end");
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
	public String getCodigoOperadora()
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getCodigoOperadora");
		String ret = null; 
		try {
			ret = srv.getCodigoOperadora();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:getCodigoOperadora");
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
		logger.debug("Fin:getCodigoOperadora");
		return ret;
	}//fin getCodigoOperadora
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String getDescripcionOperadora()
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:getDescripcionOperadora");
		String ret = null; 
		try {
			ret = srv.getDescripcionOperadora();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:getDescripcionOperadora");
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
		logger.debug("Fin:getDescripcionOperadora");
		return ret;
	}//fin getDescripcionOperadora
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:ejecutarFacturacion");
		try {
			srv.ejecutarFacturacion(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:ejecutarFacturacion");
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
		logger.debug("Fin:ejecutarFacturacion");
		
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
	public Long provisionandoLinea(GaVentasDTO parametros)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		Long numMovimiento = null;
		logger.debug("Inicio:provisionandoLinea");
		try {
			numMovimiento = srv.provisionandoLinea(parametros);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:provisionandoLinea");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:provisionandoLinea");
			logger.debug("ProductDomainException");
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
		logger.debug("Fin:provisionandoLinea");
		return numMovimiento;
		
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
	public ContratoDTO obtenerContratoNuevo()
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:obtenerContratoNuevo");
		ContratoDTO contrato = new ContratoDTO();
		try {
			contrato = srv.obtenerContratoNuevo();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("Fin:obtenerContratoNuevo");
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
		logger.debug("Fin:obtenerContratoNuevo");
		return contrato;
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
	public GaVentasDTO procesosPreCierre(GaVentasDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("procesosPreCierre:start");
		GaVentasDTO resultado;
		try {
			resultado = srv.procesosPreCierre(entrada);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("procesosPreCierre:end");
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
		logger.debug("procesosPreCierre:end");
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
	public void creaVenta(GaVentasDTO gaVentasDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("creaVenta:start");
		try {
			srv.creaVenta(gaVentasDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("creaVenta:end");
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("creaVenta:end");
			logger.debug("ProductDomainException");
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
		logger.debug("creaVenta:end");

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
	public RegistroSolicitudesDTO solicitarAprobaciones(RegistroSolicitudesDTO[] registroSolicitudesDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("solicitarAprobaciones:start");
		RegistroSolicitudesDTO resultado = new RegistroSolicitudesDTO();
		try {
			resultado = srv.solicitarAprobaciones(registroSolicitudesDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("solicitarAprobaciones:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("solicitarAprobaciones:end");
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
	public RegistroSolicitudesDTO consultaEstadoSolicitud(RegistroSolicitudesDTO registroSolicitudesDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("consultaEstadoSolicitud:start");
		try {
			registroSolicitudesDTO = srv.consultaEstadoSolicitud(registroSolicitudesDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("consultaEstadoSolicitud:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("consultaEstadoSolicitud:end");
		return registroSolicitudesDTO;
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
	public InformePresupuestoDTO obtenerInformePresupuesto(InformePresupuestoDTO objetoEntradaDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("obtenerInformePresupuesto:start");
		try {
			objetoEntradaDTO = srv.obtenerInformePresupuesto(objetoEntradaDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("obtenerInformePresupuesto:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("obtenerInformePresupuesto:end");
		return objetoEntradaDTO;
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
	public IdentificadorCivilDTO[] getListadoIdentificadorCivil()
		throws VentasException, RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoIdentificadorCivil:start");
		IdentificadorCivilDTO[] arrayIdentCivil = null; 
		
		try {
			arrayIdentCivil = srv.getListadoIdentificadorCivil();
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoIdentificadorCivil:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("getListadoIdentificadorCivil:end");
		return arrayIdentCivil;
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
	public CuentaDTO[] getListadoCuentas(CuentaDTO criterioBusquedaCuenta)
		throws VentasException, RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoCuentas:start");
		CuentaDTO[] arrayCuentas = null; 
		
		try {
			arrayCuentas = srv.getListadoCuentas(criterioBusquedaCuenta);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoCuentas:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("getListadoCuentas:end");
		return arrayCuentas;
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
	public ResultadoValidacionVentaDTO clienteAgenteComercial(ParametrosValidacionVentasDTO parametrosValidacionVentasDTO)
		throws VentasException, RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("clienteAgenteComercial:start");
		ResultadoValidacionVentaDTO resultadoValidacionVentaDTO = null; 
		try {
			resultadoValidacionVentaDTO = srv.clienteAgenteComercial(parametrosValidacionVentasDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("clienteAgenteComercial:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("clienteAgenteComercial:end");
		return resultadoValidacionVentaDTO;
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
	public RegistroEvaluacionRiesgoDTO getExcepcion(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		RegistroEvaluacionRiesgoDTO resultado = null;
		logger.debug("Inicio:getExcepcion");
		try {
			resultado = srv.getExcepcion(registroEvaluacionRiesgoDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getExcepcion:end");
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
		logger.debug("Fin:getExcepcion");
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
	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
		throws VentasException,RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		RegistroEvaluacionRiesgoDTO resultado = null;
		logger.debug("Inicio:getEvaluacionRiesgoVigenteCliente");
		try {
			resultado = srv.getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getEvaluacionRiesgoVigenteCliente:end");
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
		logger.debug("Fin:getEvaluacionRiesgoVigenteCliente");
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
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getCampanaVigente:start");
		CampanaVigenteDTO resultado = null;
		try {
			resultado = srv.getCampanaVigente(entrada);
		}
		catch(CustomerDomainException e){					
			logger.debug("getCampanaVigente:end");
			logger.debug("VentasException");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCampanaVigente:end");
		return resultado;
	}//fin getCampanaVigente

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO entrada)  
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getListadoSS:start");
		ListadoSSOutDTO[] ret; 
		try {
			ret = srv.getListadoSS(entrada);
		}
		catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("getListadoSS:end");
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
		logger.debug("getListadoSS:end");
		return ret;
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

    public ArticuloOutDTO[] getListadoArticulos(ArticuloInDTO articulo) 
		throws ProductDomainException
	{
    	UtilLog.setLog(config.getString("VentasEJB.log"));
    	ArticuloOutDTO[] resultado ;
		logger.debug("Inicio:getListadoArticulo()");
		resultado = srv.getListadoArticulos(articulo); 
		logger.debug("Fin:getListadoArticulo()");
		return resultado;    	
    }//fin getListadoArticulo
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("registraCampanaVigente:start");
		try {
			srv.registraCampanaVigente(entrada);
		}
		catch(CustomerDomainException e){
			logger.debug("registraCampanaVigente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("registraCampanaVigente:end");
	}//fin registraCampanaVigente
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CampanaVigenteDTO getCampanaVigenteDefault(CampanaVigenteCOLDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("registraCampanaVigente:start");
		CampanaVigenteDTO campanaVigente = new CampanaVigenteDTO();
		try {
			campanaVigente = srv.getCampanaVigenteDefault(entrada);
		}
		catch(CustomerDomainException e){
			e.printStackTrace();
			logger.debug("registraCampanaVigente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			throw new VentasException(e.getDescripcionEvento(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());	
		}catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}	
		logger.debug("registraCampanaVigente:end");
		return campanaVigente;
	}//fin registraCampanaVigente
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GrupoCobroServicioDTO getGrupoCobroServicioDefault(Long codigoProducto)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("registraCampanaVigente:start");
		GrupoCobroServicioDTO grupoCobroServicio = new GrupoCobroServicioDTO();
		try {
			grupoCobroServicio = srv.getGrupoCobroServicioDefault(codigoProducto);
		}
		catch(CustomerDomainException e){
			logger.debug("registraCampanaVigente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}	
		logger.debug("registraCampanaVigente:end");
		return grupoCobroServicio;
	}//fin registraCampanaVigente
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public  PlanTarifarioDTO[] getListPlanTarif(PlanTarifarioDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		PlanTarifarioDTO[] resultado = null;			
		logger.debug("getListPlanTarif:start");		 
		try {
			resultado = srv.getListPlanTarif(entrada) ;
		}
		catch(ProductDomainException e){
			logger.debug("getListPlanTarif:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListPlanTarif:end");		
		return resultado;
	}//fin getListPlanTarif

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarif(LstPTaPlanTarifarioInDTO entrada)
		throws VentasException, RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		LstPTaPlanTarifarioListOutDTO resultado = new LstPTaPlanTarifarioListOutDTO();		
		logger.debug("lstPlanTarif:start");		 
		try {
			resultado = srv.lstPlanTarif(entrada);
			UtilLog.setLog(config.getString("VentasEJB.log"));			
			logger.debug("Error ["+resultado.getCodError()+"]");
		}
		catch(ProductDomainException e){
			UtilLog.setLog(config.getString("VentasEJB.log"));			
			String code = e.getCodigo() == null ? "" : e.getCodigo();
			if (code != null && !code.trim().equals("")) 
				resultado.setCodError(new Long(code));
			else
				resultado.setCodError(new Long(-1));
			
			resultado.setCodEvento(new Long(e.getCodigoEvento()));
			resultado.setMsgError(e.getDescripcionEvento());			
		} 
		catch (Exception e) {
			UtilLog.setLog(config.getString("VentasEJB.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("lstPlanTarif:end");		
		return resultado;
	}//fin lstPlanTarif
	

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarifPosventa(LstPTaPlanTarifarioInDTO entrada)
		throws VentasException, RemoteException 
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		LstPTaPlanTarifarioListOutDTO resultado = new LstPTaPlanTarifarioListOutDTO();		
		logger.debug("lstPlanTarifPosventa:start");		 
		try {
			resultado = srv.lstPlanTarifPosventa(entrada);
		}
		catch(ProductDomainException e){
			String code = e.getCodigo() == null ? "" : e.getCodigo();
			if (code != null && !code.trim().equals("")) 
				resultado.setCodError(new Long(code));
			else
				resultado.setCodError(new Long(-1));
			
			resultado.setCodEvento(new Long(e.getCodigoEvento()));
			resultado.setMsgError(e.getDescripcionEvento());			
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("lstPlanTarifPosventa:end");		
		return resultado;
	}//fin lstPlanTarifPosventa
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  ClienteDTO[] getDatosCliente(BusquedaClienteDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		ClienteDTO resultado[] = null;		
		logger.debug("getDatosCliente:start");		 
		try {
			resultado = srv.getDatosCliente(entrada) ;
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		} 
		catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosCliente:end");		
		return resultado;
	}//fin getDatosCliente

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  LstVtaRegistroResultadoDTO getListVentas(RegistroVentaDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		LstVtaRegistroResultadoDTO resultado = null;
		logger.debug("getListVentas:start");		 
		try {
			resultado = srv.getListVentas(entrada); 
		}
		catch(CustomerDomainException e){
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListVentas:end");		
		return resultado;
	}//fin getListVentas
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConceptoVenta validarModalidadVenta(DependenciasModalidadDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));		
		ConceptoVenta resultado = null;				
		logger.debug("getListVentas:start");		 
		try {
			resultado = srv.ValidarModalidadVenta(entrada);			
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getListVentas:end");
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
		logger.debug("getListVentas:end");		
		return resultado;
	}//fin getListVentas	
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public HomeLineaDTO obtieneHomeLinea(HomeLineaDTO entrada)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));		
		HomeLineaDTO resultado = null;				
		logger.debug("obtieneHomeLinea:start");		 
		try {
			resultado = srv.obtieneHomeLinea(entrada);			
		}
		catch(ProductDomainException e){
			context.setRollbackOnly();
			logger.debug("obtieneHomeLinea:end");
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
		logger.debug("obtieneHomeLinea:end");		
		return resultado;
	}//fin obtieneHomeLinea	
	
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ContratoDTO getNroMesesContrato(ContratoDTO entrada) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));		
		ContratoDTO resultado = null;				
		logger.debug("getNroMesesContrato:start");		 
		try {
			resultado = srv.getNroMesesContrato(entrada);			
		}
		catch(CustomerDomainException e){
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
		logger.debug("getNroMesesContrato:end");		
		return resultado;
	}//fin getNroMesesContrato

	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:insertGaDocVentas");		
		try {
			gaDocVentasDTO=srv.insertGaDocVentas(gaDocVentasDTO);
		}
		catch(CustomerDomainException e){
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
		return gaDocVentasDTO;
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
	
	public void liberarSeries(String nroSimcard, String nroTerminal, String procEquipo,Long nroVenta, String codVendedor) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:insertGaDocVentas");		
		try {
			SimcardDTO simcardDTO = new SimcardDTO();
			simcardDTO.setNumeroSerie(nroSimcard);
			simcardDTO.setNumeroVenta(String.valueOf(nroVenta));
			
			TerminalDTO terminalDTO = new TerminalDTO();
			terminalDTO.setNumeroSerie(nroTerminal);
			if(procEquipo.trim().equals("I"))
			{
				terminalDTO.setProcedenciaInterna("I")
				;
			}
			terminalDTO.setNumeroVenta(String.valueOf(nroVenta));
			
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(codVendedor);
			srv.liberarSeries(simcardDTO, terminalDTO , vendedorDTO);
		}
		catch(ProductDomainException e){
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
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("ListaTipoContrato");
		TiposContratoListOutDTO ret = new TiposContratoListOutDTO();
		TipoContratoDTO[] TiposContrato; 
		try {
			TiposContrato = srv.ListaTipoContrato();
			ret.setAllTipoContratoDTO(TiposContrato);			
		}
		catch(CustomerDomainException e){
			logger.debug("ListaTipoContrato:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("ListaTipoContrato:start");
		return ret;
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
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("validacionSimcard");
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		SimcardOutDTO ret = new SimcardOutDTO();
		try {
			resultado = srv.validacionSimcard(entrada);			
			ret.setCodError(new Long(resultado.getCodigoError()));
			ret.setMsgError(resultado.getDetalleEstado());
		}catch(CustomerDomainException e){
			logger.debug("validacionSimcard:end");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			VentasException v = new VentasException();
			v.setMessage(e.getMessage());
			v.setCodigo(e.getCodigo());
			v.setCodigoEvento(e.getCodigoEvento());
			v.setDescripcionEvento(e.getDescripcionEvento());
			throw v;
		}catch(ProductDomainException e){
				logger.debug("validacionSimcard:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validacionSimcard:start");
		return ret;
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
	public RegistroEvaluacionRiesgoDTO validaExistenciaEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:validaExistenciaEvRiesgo()");
		RegistroEvaluacionRiesgoDTO respuesta = new RegistroEvaluacionRiesgoDTO();
		try {		
			respuesta = srv.validaExistenciaEvRiesgo(registroEvaluacionRiesgo);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("validaExistenciaEvRiesgo:end");
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
		logger.debug("Fin:validaExistenciaEvRiesgo");
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
	
	public void validaPlanTarifarioEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:validaPlanTarifarioEvRiesgo()");
		try {		
			srv.validaPlanTarifarioEvRiesgo(registroEvaluacionRiesgo); 
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("validaPlanTarifarioEvRiesgo:end");
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
		logger.debug("Fin:validaPlanTarifarioEvRiesgo");
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
	
	public SalidaOutDTO bloqueaSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:bloqueaSolicitudEvRiesgo()");
		SalidaOutDTO resultado = new SalidaOutDTO();
		
		try {		
			srv.bloqueaSolicitudEvRiesgo(registroEvaluacionRiesgo);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			String code = e.getCodigo() == null ? "" : e.getCodigo();
			if (code != null && !code.trim().equals("")) 
				resultado.setCodError(new Long(code));
			else
				resultado.setCodError(new Long(-1));
			
			resultado.setCodEvento(new Long(e.getCodigoEvento()));
			resultado.setMsgError(e.getDescripcionEvento());			
		} 
		catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:bloqueaSolicitudEvRiesgo");
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
	public SalidaOutDTO desBloqueaEstadoSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:desBloqueaEstadoSolicitudEvRiesgo()");

		SalidaOutDTO resultado = new SalidaOutDTO();
		try {		
			srv.desBloqueaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo); 
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			String code = e.getCodigo() == null ? "" : e.getCodigo();
			if (code != null && !code.trim().equals("")) 
				resultado.setCodError(new Long(code));
			else
				resultado.setCodError(new Long(-1));
			
			resultado.setCodEvento(new Long(e.getCodigoEvento()));
			resultado.setMsgError(e.getDescripcionEvento());			
		} 
		catch (Exception e) {
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:desBloqueaEstadoSolicitudEvRiesgo");
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
	public void udp_EvRiesgo_registroPlanes(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:udp_EvRiesgo_registroPlanes()");
		try {
			srv.udp_EvRiesgo_registroPlanes(registroEvaluacionRiesgo); 
	}
	catch(CustomerDomainException e){
		context.setRollbackOnly();
		logger.debug("udp_EvRiesgo_registroPlanes:end");
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
	logger.debug("Fin:udp_EvRiesgo_registroPlanes");					
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
	public void validaDireccion (DireccionNegocioDTO direccion) 
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("Inicio:uvalidaDireccion()");
		try {
			srv.validaDireccion(direccion);
		}
		catch(CustomerDomainException e){
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin:validaDireccion");					
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

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		context = arg0;
		// TODO Auto-generated method stub

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
	public void reversaVenta(GaVentasDTO gaVentasDTO)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		try {
			srv.reversaVenta(gaVentasDTO);
			context.setRollbackOnly();
		}catch(CustomerDomainException e){
			logger.debug("reversaVenta:Fin");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
	}// fin reversaVenta
	
	
	/***************************** Metodos para pantalla datos de venta GUATEMALA _ EL SALVADOR *****************************/
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getListTiposComisionistas() 
		throws VentasException, RemoteException
	{
		VendedorDTO[] vendedorDTOs= null;
		try {
			logger.debug("getListTiposComisionistas():start");
			vendedorDTOs = srv.getListTiposComisionistas();
		}catch(CustomerDomainException e){
			logger.debug("getListTiposComisionistas:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListTiposComisionistas():end");
		return vendedorDTOs; 
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
	public  VendedorDTO[] getListadoVendedores(VendedorDTO vendedorDTO)  
		throws VentasException, RemoteException
	{
		logger.debug("getListadoVendedores:start");
		VendedorDTO[] ret; 
		try {
			ret = srv.getListadoVendedores(vendedorDTO);
		}
		catch(CustomerDomainException e){
			logger.debug("getListadoVendedores:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedores:end");
		return ret;
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
	public  VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedorDTO)  
		throws VentasException, RemoteException
	{
		logger.debug("getListadoVendedoresDealer:start");
		VendedorDTO[] ret; 
		try {
			ret = srv.getListadoVendedoresDealer(vendedorDTO);
		}
		catch(CustomerDomainException e){
			logger.debug("getListadoVendedoresDealer:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedoresDealer:end");
		return ret;
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
	public  BodegaDTO[] getBodegasXVendedor(BodegaDTO vendedorDTO)  
		throws VentasException, RemoteException
	{
		logger.debug("getBodegasXVendedor:start");
		BodegaDTO[] ret; 
		try {
			ret = srv.getBodegasXVendedor(vendedorDTO);
		}
		catch(ProductDomainException e){
			logger.debug("getBodegasXVendedor:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getBodegasXVendedor:end");
		return ret;
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
	public  ArticuloInDTO[] getArticulos(ArticuloInDTO entrada)  
		throws VentasException, RemoteException
	{
		logger.debug("getArticulos:start");
		ArticuloInDTO[] ret; 
		try {
			ret = srv.getArticulos(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getArticulos:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getArticulos:end");
		return ret;
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
	public GrupoPrestacionDTO[] getGruposPrestacion() 
		throws VentasException, RemoteException
	{
		logger.debug("getGruposPrestacion:start");
		GrupoPrestacionDTO[] ret; 
		try {
			ret = srv.getGruposPrestacion();
		}
		catch(ProductDomainException e){
			logger.debug("getGruposPrestacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getGruposPrestacion:end");
		return ret;
		
	}//fin getGruposPrestacion		
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
		throws VentasException, RemoteException
	{
		logger.debug("getTiposPrestacion:start");
		TipoPrestacionDTO[] ret; 
		try {
			ret = srv.getTiposPrestacion(codGrupoPrestacion, tipoCliente);
		}
		catch(ProductDomainException e){
			logger.debug("getTiposPrestacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getTiposPrestacion:end");
		return ret;
	}//fin getTiposPrestacion
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public UsoDTO[] getUsos(UsoDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("getUsos:start");
		UsoDTO[] ret; 
		try {
			ret = srv.getUsos(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getUsos:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getUsos:end");
		return ret;
	}//fin getUsos
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SeguroDTO[] getSeguros() 
		throws VentasException, RemoteException
	{
		logger.debug("getSeguros:start");
		SeguroDTO[] ret; 
		try {
			ret = srv.getSeguros();
		}
		catch(ProductDomainException e){
			logger.debug("getSeguros:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSeguros:end");
		return ret;
	}//fin getSeguros
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public Long getIndSeguro(Long entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("getIndSeguro:start");
		Long ret; 
		try {
			ret = srv.getIndSeguro(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getIndSeguro:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getIndSeguro:end");
		return ret;
	}//fin getIndSeguro
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CentralDTO[] getDatosCentral(CentralDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("getIndSeguro:start");
		CentralDTO[] ret; 
		try {
			ret = srv.getDatosCentral(entrada);
		}
		catch(ResourceDomainException e){
			logger.debug("getIndSeguro:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getIndSeguro:end");
		return ret;
	}//fin getDatosCentral
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SerieDTO[] buscarSerie(SerieDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("buscarSerie:start");
		SerieDTO[] ret; 
		try {
			ret = srv.buscarSerie(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("buscarSerie:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("buscarSerie:end");
		return ret;
	}//fin getDatosCentral
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SerieDTO[] listarSerie(SerieDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("listarSerie:start");
		SerieDTO[] ret; 
		try {
			ret = srv.listarSerie(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("listarSerie:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarSerie:end");
		return ret;
	}//fin listarSerie
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void generarDatosIP(IpDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("generarDatosIP:start");		
		try {
			srv.generarDatosIP(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("generarDatosIP:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("generarDatosIP:end");		
	}//fin generarDatosIP
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insertaSeguroAbonado(SeguroDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("insertaSeguroAbonado:start");		
		try {
			srv.insertaSeguroAbonado(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("insertaSeguroAbonado:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertaSeguroAbonado:end");		
	}//fin insertaSeguroAbonado

	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SeguroDTO obtieneDatosSeguro(SeguroDTO entrada) 
		throws VentasException, RemoteException
	{
		logger.debug("obtieneDatosSeguro:start");	
		SeguroDTO resultado = new SeguroDTO();
		try {
			resultado = srv.obtieneDatosSeguro(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("obtieneDatosSeguro:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneDatosSeguro:end");		
		return resultado;
	}//fin obtieneDatosSeguro

	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipoTerminalDTO[] listarTiposTerminal(String codTecnologia) 
		throws VentasException, RemoteException
	{
		logger.debug("listarTiposTerminal:start");
		TipoTerminalDTO[] resultado = null;
		try {
			resultado = srv.listarTiposTerminal(codTecnologia);
		}
		catch(ProductDomainException e){
			logger.debug("listarTiposTerminal:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarTiposTerminal:end");
		return resultado;
	}//fin listarTiposTerminal
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public MonedaDTO[] listarMonedas() 
		throws VentasException, RemoteException
	{
		logger.debug("listarMonedas:start");
		MonedaDTO[] resultado = null;
		try {
			resultado = srv.listarMonedas();
		}
		catch(ProductDomainException e){
			logger.debug("listarMonedas:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("listarMonedas:end");
		return resultado;
	}//fin listarMonedas
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO) 
		throws VentasException, RemoteException
	{
		//Para Numeracion Reutilizable
		logger.debug("obtieneNumeracionReutilizable:start");
		SeleccionNumeroCelularDTO[] resultado = null;
		try {
			resultado = srv.obtieneNumeracionReutilizable(datosNumeracionVO);
		}
		catch(ProductDomainException e){
			logger.debug("obtieneNumeracionReutilizable:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionReutilizable:end");
		return resultado;
	}//fin obtieneNumeracionReutilizable
	
 
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReservada(DatosNumeracionDTO datosNumeracionVO)
		throws VentasException, RemoteException
	{
		//Para Numeracion Reservada
		logger.debug("obtieneNumeracionReservada:start");
		SeleccionNumeroCelularDTO[] resultado = null;
		try {
			resultado = srv.obtieneNumeracionReservada(datosNumeracionVO);
		}
		catch(ProductDomainException e){
			logger.debug("obtieneNumeracionReservada:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionReservada:end");
		return resultado;
	}//fin obtieneNumeracionReservada
	
   	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SeleccionNumeroCelularRangoDTO[] obtieneNumeracionRango(DatosNumeracionDTO datosNumeracionVO)
		throws VentasException, RemoteException
	{
		//Para Numeracion nueva
		logger.debug("obtieneNumeracionRango:start");
		SeleccionNumeroCelularRangoDTO[] resultado = null;
		try {
			resultado = srv.obtieneNumeracionRango(datosNumeracionVO);
		}
		catch(ProductDomainException e){
			logger.debug("listarMonedas:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionRango:end");
		return resultado;
	}//fin obtieneNumeracionReservada
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String obtieneCategoria(DatosNumeracionDTO datosNumeracionVO)
		throws VentasException, RemoteException
	{
		String arrCat = "";
		logger.debug("obtieneCategoria:start");		
		try {
			arrCat = srv.obtieneCategoria(datosNumeracionVO);
		}
		catch(ProductDomainException e){
			logger.debug("obtieneCategoria:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneCategoria:end");
		return arrCat;
	}//fin obtieneCategoria

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionVO)
		throws VentasException, RemoteException
	{
		DatosNumeracionDTO resultado = new DatosNumeracionDTO();
		logger.debug("obtieneNumeracionAutomatica:start");		
		try {
			resultado = srv.obtieneNumeracionAutomatica(datosNumeracionVO);
		}
		catch(ProductDomainException e){
			logger.debug("obtieneNumeracionAutomatica:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtieneNumeracionAutomatica:end");
		return resultado;
	}//fin obtieneCategoria
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesVentaDTO crearLineaWeb(DatosGeneralesVentaDTO datosGeneralesVentas,UsuarioWebDTO  usuario)
		throws VentasException, RemoteException	
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		DatosGeneralesVentaDTO resultado = null;
		logger.debug("creacionLinea:start");
		//ParametrosValidacionVentasDTO ret; //-- ??? 
		try {
			//ret = srv.creacionLineas(datosGeneralesVentas); //-- ???
			resultado = srv.creacionLineasWeb(datosGeneralesVentas, usuario);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			
			logger.debug("10/05/07 Error Prueba:end");
			logger.debug("creacionLinea:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}catch(ProductDomainException e){
				context.setRollbackOnly();
				
				logger.debug("10/05/07 Error Prueba:end");
				logger.debug("creacionLinea:end");
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
		logger.debug("creacionLinea:end");
		return resultado;
	}//fin creacionLinea
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada)
		throws VentasException, RemoteException
	{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		logger.debug("getParametroGeneral:start");		
		try {
			resultado = srv.getParametroGeneral(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getParametroGeneral:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getParametroGeneral:end");
		return resultado;
	}//fin getParametroGeneral
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OficinaDTO getDireccionOficina(String codOficina)
		throws VentasException, RemoteException
	{
		OficinaDTO resultado = new OficinaDTO();
		logger.debug("getDireccionOficina:start");		
		try {
			resultado = srv.getDireccionOficina(codOficina);
		}
		catch(CustomerDomainException e){
			logger.debug("getDireccionOficina:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDireccionOficina:end");
		return resultado;
	}//fin getDireccionOficina
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void validarPlanCompartido(Long codCliente, String codPlanTarif)
		throws VentasException, RemoteException
	{
		logger.debug("validarPlanCompartido:start");		
		try {
			srv.validarPlanCompartido(codCliente, codPlanTarif);
		}
		catch(CustomerDomainException e){
			logger.debug("validarPlanCompartido:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validarPlanCompartido:end");		
	}//fin validarPlanCompartido
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public UsuarioSCLDTO ValidaUsuarioSinPerfil(UsuarioSCLDTO entrada)
		throws VentasException, RemoteException
	{
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		logger.debug("ValidaUsuarioSinPerfil:start");		
		try {
			respuesta=srv.validarUsuarioSinPerfil(entrada);
		}
		catch(CustomerDomainException e){
			logger.debug("ValidaUsuarioSinPerfil:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("ValidaUsuarioSinPerfil:end");
		return respuesta;		
	}//fin validarPlanCompartido
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insReservaArticulo(ArticuloDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("insReservaArticulo:start");		
		try {
			srv.insReservaArticulo(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("insReservaArticulo:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insReservaArticulo:end");				
	}//fin insReservaArticulo
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ArticuloDTO actualizaStock(ArticuloDTO entrada)
		throws VentasException, RemoteException
	{
		ArticuloDTO respuesta = new ArticuloDTO();
		logger.debug("actualizaStock:start");		
		try {
			respuesta = srv.ActualizaStock(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("actualizaStock:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("actualizaStock:end");
		return respuesta;		
	}//fin actualizaStock
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SimcardDTO getSimcard(SimcardDTO entrada)
		throws VentasException, RemoteException
	{
		SimcardDTO respuesta = new SimcardDTO();
		logger.debug("getSimcard:start");		
		try {
			respuesta = srv.getSimcard(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getSimcard:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSimcard:end");
		return respuesta;		
	}//fin getSimcard
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TerminalDTO getTerminal(TerminalDTO entrada)
		throws VentasException, RemoteException
	{
		TerminalDTO respuesta = new TerminalDTO();
		logger.debug("actualizaStock:start");		
		try {
			respuesta = srv.getTerminal(entrada);
		}
		catch(ProductDomainException e){
			logger.debug("getTerminal:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getTerminal:end");
		return respuesta;		
	}//fin getTerminal
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoValidacionVentaDTO validacionLineaWeb(ParametrosValidacionVentasDTO entrada)
		throws VentasException, RemoteException
	{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		logger.debug("validacionLineaWeb:start");		
		try {
			resultado = srv.validacionLineaWeb(entrada);
			if(resultado.getEstado().equals("NOK")) 
			{
				throw new VentasException(resultado.getCodigoError(), 0, resultado.getDetalleEstado() );
			}
		} catch (VentasException e) {
			context.setRollbackOnly();
			logger.debug("VentasException", e);
			throw(e);	
		}catch(ProductDomainException e){
			logger.debug("validacionLineaWeb:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validacionLineaWeb:end");
		return resultado;
	}//fin obtieneCategoria
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public FolioDTO getFolio(FolioDTO entrada)
		throws VentasException, RemoteException
	{
		FolioDTO resultado = new FolioDTO();
		logger.debug("validacionLineaWeb:start");		
		try {
			resultado = srv.getFolio(entrada);
		}catch(CustomerDomainException e){
			logger.debug("validacionLineaWeb:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validacionLineaWeb:end");
		return resultado;
	}//fin getFolio
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("reservaNumeroCelular:start");		
		try {
			srv.reservaNumeroCelular(numeracionCelularVO);
		}catch(ProductDomainException e){
			logger.debug("reservaNumeroCelular:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reservaNumeroCelular:end");		
	}//fin reservaNumeroCelular	
	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("insertarNumeroCelularReservado:start");		
		try {
			srv.insertarNumeroCelularReservado(numeracionCelularVO);
		}catch(ProductDomainException e){
			logger.debug("insertarNumeroCelularReservado:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertarNumeroCelularReservado:end");		
	}//fin insertarNumeroCelularReservado

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("reponerNumeracion:start");		
		try {
			srv.reponerNumeracion(numeracionCelularVO);
		}catch(ProductDomainException e){
			logger.debug("reponerNumeracion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reponerNumeracion:end");		
	}//fin reponerNumeracion
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws VentasException, RemoteException
	{
		logger.debug("desReservaNumeroCelular:start");		
		try {
			srv.desReservaNumeroCelular(numeracionCelularVO);
		}catch(ProductDomainException e){
			logger.debug("desReservaNumeroCelular:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("desReservaNumeroCelular");		
	}//fin desReservaNumeroCelular
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EquipoKitDTO getSerieEquipoKit(EquipoKitDTO entrada)
		throws VentasException, RemoteException
	{
		EquipoKitDTO resultado = new EquipoKitDTO();
		logger.debug("getSerieEquipoKit:start");		
		try {
			resultado = srv.getSerieEquipoKit(entrada);
		}catch(ProductDomainException e){
			logger.debug("getSerieEquipoKit:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSerieEquipoKit");
		return resultado;
	}//fin getSerieEquipoKit
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void validaNumeroInternet(NumeroInternetDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("validaNumeroInternet:start");		
		try {
			srv.validaNumeroInternet(entrada);
		}catch(ProductDomainException e){
			logger.debug("validaNumeroInternet:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaNumeroInternet");		
	}//fin validaNumeroInternet
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getVentasXVendedor:start");
		ListadoVentasDTO[] resultado = null;
		try {
			resultado = srv.getVentasXVendedor(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getVentasXVendedor:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getVentasXVendedor");
		return resultado;
	}//fin getVentasXVendedor
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedor)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoVendedoresXOficina:start");	
		VendedorDTO[] resultado = null;
		try {
			resultado = srv.getListadoVendedoresXOficina(vendedor);
		}catch(CustomerDomainException e){
			logger.debug("getListadoVendedoresXOficina:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoVendedoresXOficina");
		return resultado;
	}//fin getListadoVendedoresXOficina
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO[] getListadoAbonadosVenta(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getListadoAbonadosVenta:start");	
		AbonadoDTO[] resultado = null;
		try {
			resultado = srv.getListadoAbonadosVenta(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getListadoAbonadosVenta:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getListadoAbonadosVenta");
		return resultado;
	}//fin getListadoAbonadosVenta
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor)
		throws VentasException, RemoteException
	{
		logger.debug("getRangoDescuento:start");	
		VendedorDTO resultado = null;
		try {
			resultado = srv.getRangoDescuento(vendedor);
		}catch(CustomerDomainException e){
			logger.debug("getListadoAbonadosVenta:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getRangoDescuento");
		return resultado;
	}//fin getRangoDescuento
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void eliminaAbonado(AbonadoDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("eliminaAbonado:start");
		try {
			srv.eliminaAbonado(entrada);
		}catch(CustomerDomainException e){
			logger.debug("eliminaAbonado:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("eliminaAbonado");		
	}//fin eliminaAbonado
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getCargosVta:start");
		CargoSolicitudDTO[] resultado = null;
		try {
			resultado = srv.getCargosVta(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getCargosVta:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCargosVta");
		return resultado;
	}//fin getCargosVta
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ImpuestosDTO actualizarDsctosManuales(ListadoCargoSolicitudDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("actualizarDsctosManuales:start");	
		ImpuestosDTO resultado = new ImpuestosDTO();
		try {
			resultado = srv.actualizarDsctosManuales(entrada);
		}catch(CustomerDomainException e){
			logger.debug("actualizarDsctosManuales:end");
			logger.debug("VentasException");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("actualizarDsctosManuales");
		return resultado;
	}//fin actualizarDsctosManuales;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ResultadoValidacionVentaDTO validaSerieExterna(ParametrosValidacionVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("validaSerieExterna:start");
		ResultadoValidacionVentaDTO resultado= new ResultadoValidacionVentaDTO();
		try {
			resultado= srv.validaSerieExterna(entrada);
		}catch(CustomerDomainException e){
			logger.debug("validaSerieExterna:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaSerieExterna");
		return resultado;		
	}//fin validaSerieExterna;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void aceptarPresupuesto(GaVentasDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("aceptarPresupuesto:start");		
		try {
			srv.aceptarPresupuesto(entrada);
		}catch(CustomerDomainException e){
			logger.debug("aceptarPresupuesto:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("aceptarPresupuesto");		
	}//fin aceptarPresupuesto;
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public NumeroCuotasListOutDTO Lista_Cuotas()  
	throws VentasException, RemoteException
	{
		logger.debug("Lista_Cuotas:start");
		NumeroCuotasListOutDTO ret = new NumeroCuotasListOutDTO();
		NumeroCuotasDTO[] cuotas; 
		try {
			cuotas = srv.Lista_Cuotas();
			ret.setallNumeroCuotasDTO(cuotas);			
		}
		catch(CustomerDomainException e){
			logger.debug("LegalizaVenta:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("Lista_Cuotas:start");
		return ret;
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
	public void desbloqueoLinea(AbonadoDTO entrada)  
	throws VentasException, RemoteException
	{
		logger.debug("desbloqueoLinea:start");
		try {
			srv.desbloqueoLinea(entrada);						
		}
		catch(CustomerDomainException e){
			logger.debug("desbloqueoLinea:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("desbloqueoLinea:start");
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
	public UsuarioSCLDTO getMenuUsuario(UsuarioSCLDTO usuario)
		throws VentasException, RemoteException
	{
		logger.debug("getMenuUsuario:start");
		UsuarioSCLDTO resultado = new UsuarioSCLDTO();
		try {
			resultado = srv.getMenuUsuario(usuario);						
		}
		catch(CustomerDomainException e){
			logger.debug("desbloqueoLinea:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getMenuUsuario:start");
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
	public void setRegistrarCargosInstalacion(RegistroCargosDTO cargosInstalacionDTO)
		throws GeneralException
	{
		logger.debug("setRegistrarCargosInstalacion:start");
		try {
			srv.setRegistrarCargosInstalacion(cargosInstalacionDTO);						
		}
		catch(CustomerDomainException e){
			logger.debug("setRegistrarCargosInstalacion:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("setRegistrarCargosInstalacion:start");
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
	public void reversaCargosFormalizacion(Long numVenta)
		throws VentasException, RemoteException
	{
		logger.debug("reversaCargosFormalizacion:start");
		try {
			srv.reversaCargosFormalizacion(numVenta);						
		}
		catch(CustomerDomainException e){
			logger.debug("reversaCargosFormalizacion:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("reversaCargosFormalizacion:start");
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
		public FaConceptoDTO getFaConcepto(FaConceptoDTO faConceptoDTO)
			throws GeneralException, RemoteException
		{
		logger.debug("getFaConcepto:start");		
		try {
			faConceptoDTO = srv.getFaConcepto(faConceptoDTO);						
		}
		catch(GeneralException e){
			logger.debug("desbloqueoLinea:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getFaConcepto:start");
		return faConceptoDTO;
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
		public VendedorDTO busquedaVendedor(VendedorDTO vendedor)
			throws GeneralException, RemoteException
		{
		logger.debug("busquedaVendedor:start");		
		try {
			vendedor = srv.busquedaVendedor(vendedor);						
		}
		catch(GeneralException e){
			logger.debug("busquedaVendedor:end");
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
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("busquedaVendedor:start");
		return vendedor;
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
		public String obtenerEstadoContratacionPA(Long numVenta)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerEstadoContratacionPA:start");		
			String estado = "";
			try {
				estado = srv.obtenerEstadoContratacionPA(numVenta);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerEstadoContratacionPA:end");
			return estado;
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
		public PagareDTO obtenerDatosPagare(Long numVenta)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDatosPagare:start");		
			PagareDTO resultado = new PagareDTO();
			try {
				resultado = srv.obtenerDatosPagare(numVenta);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDatosPagare:end");
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
		public FichaClienteDTO obtenerDatosFichaCliente(Long numAbonado)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDatosFichaCliente:start");		
			FichaClienteDTO resultado = new FichaClienteDTO();
			try {
				resultado = srv.obtenerDatosFichaCliente(numAbonado);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDatosFichaCliente:end");
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
		public FichaSalidaBodegaDTO obtenerDatosSalidaBodega(Long numVenta)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDatosSalidaBodega:start");		
			FichaSalidaBodegaDTO resultado = new FichaSalidaBodegaDTO();
			try {
				resultado = srv.obtenerDatosSalidaBodega(numVenta);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDatosSalidaBodega:end");
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
		public FichaContratoPrestacionDTO obtenerDatosContratoPrestacion(Long numVenta)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDatosContratoPrestacion:start");		
			FichaContratoPrestacionDTO resultado = new FichaContratoPrestacionDTO();
			try {
				resultado = srv.obtenerDatosContratoPrestacion(numVenta);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDatosContratoPrestacion:end");
			return resultado;
		}
		
		
		/************************************** METODOS DISTRIBUICION DE BOLSA **************************************/
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 * //TODO: Must provide implementation for bean method stub
		 */
		public DistribucionBolsaDTO obtenerDatosBolsa( String codPlanTarif )
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDatosBolsa:start");		
			DistribucionBolsaDTO resultado = new DistribucionBolsaDTO();
			try {
				resultado = srv.obtenerDatosBolsa(codPlanTarif);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDatosBolsa:end");
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
		public Long obtenerVentasAnteriores( Long numVenta, Long codCliente )
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerVentasAnteriores:start");		
			Long resultado = null;
			try {
				resultado = srv.obtenerVentasAnteriores(numVenta, codCliente);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerVentasAnteriores:end");
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
		public Long obtenerVentasAnterioresPorPlan( Long numVenta, Long codCliente, String codPlanTarif )
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerVentasAnterioresPorPlan:start");		
			Long resultado = null;
			try {
				resultado = srv.obtenerVentasAnterioresPorPlan(numVenta, codCliente, codPlanTarif);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerVentasAnterioresPorPlan:end");
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
		public TipoPrestacionDTO validarPlanDist(Long codCliente)
			throws GeneralException, RemoteException
		{
			logger.debug("validarPlanDist:start");		
			TipoPrestacionDTO resultado = new TipoPrestacionDTO();
			try {
				resultado = srv.validarPlanDist(codCliente);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("validarPlanDist:end");
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
		public BolsaAbonadoDTO[] obtenerDistribucionBolsa(CustomerAccountDTO dto)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerDistribucionBolsa:start");		
			BolsaAbonadoDTO[] resultado;
			try {
				resultado = srv.obtenerDistribucionBolsa(dto);
			}
			catch(TOLException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDistribucionBolsa:end");
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
		public void guardarDistribucionBolsa(DistribucionBolsaDTO dto) 
			throws GeneralException, RemoteException
		{
			logger.debug("guardarDistribucionBolsa:start");					
			try {
				srv.guardarDistribucionBolsa(dto);
			}
			catch(TOLException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("guardarDistribucionBolsa:end");
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
		public void guardarSolicitudVenta(SolicitudVentaDTO entrada) 
			throws GeneralException, RemoteException
		{
			logger.debug("guardarSolicitudVenta:start");					
			try {
				srv.guardarSolicitudVenta(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("guardarSolicitudVenta:end");
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
		public TipoSolicitudDTO[] obtenerTiposSolicitudes()
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerTiposSolicitudes:start");
			TipoSolicitudDTO[] resultado;
			try {
				resultado = srv.obtenerTiposSolicitudes();
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerTiposSolicitudes:end");
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
		public EstadoSolicitudDTO[] listarEstadosSolicitud(SolicitudVentaDTO entrada)
			throws GeneralException, RemoteException
		{
			logger.debug("listarEstadosSolicitud:start");
			EstadoSolicitudDTO[] resultado;
			try {
				resultado = srv.listarEstadosSolicitud(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("listarEstadosSolicitud:end");
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
		public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long numVenta) 
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerPlanesDistribuidos:start");
			PlanTarifarioDTO[] resultado;
			try {
				resultado = srv.obtenerPlanesDistribuidos(numVenta);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerPlanesDistribuidos:end");
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
		public PlanTarifarioDTO[] obtenerPlanesDistribuidosAutomaticos(Long numVenta) 
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerPlanesDistribuidosAutomaticos:start");
			PlanTarifarioDTO[] resultado;
			try {
				resultado = srv.obtenerPlanesDistribuidosAutomaticos(numVenta);
			}
			catch(ProductDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerPlanesDistribuidosAutomaticos:end");
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
		public AbonadoDTO[] obtenerAbonadosDistribuidos(AbonadoDTO entrada)
			throws GeneralException, RemoteException
		{
			logger.debug("obtenerAbonadosDistribuidos:start");
			AbonadoDTO[] resultado;
			try {
				resultado = srv.obtenerAbonadosDistribuidos(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerAbonadosDistribuidos:end");
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
		public void actualizaSolVentaEval(SolicitudVentaDTO entrada)
			throws GeneralException
		{
			logger.debug("actualizaSolVentaEval:start");
			try {
				srv.actualizaSolVentaEval(entrada);						
			}
			catch(ProductDomainException e){
				logger.debug("actualizaSolVentaEval:end");
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
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("actualizaSolVentaEval:start");
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
		public DetalleInformePresupuestoDTO[] obtenerDetallePresupuesto(Long entrada) 
			throws GeneralException
		{
			logger.debug("obtenerDetallePresupuesto:start");
			DetalleInformePresupuestoDTO[] resultado;
			try {
				resultado = srv.obtenerDetallePresupuesto(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerDetallePresupuesto:end");
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
		public DetallePrecioSolicitudDTO[] obtenerPrecioSSAbo(ServicioSuplementarioDTO entrada)
			throws GeneralException
		{
			logger.debug("obtenerPrecioSSAbo:start");
			DetallePrecioSolicitudDTO[] resultado;
			try {
				resultado = srv.obtenerPrecioSSAbo(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("ProductDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtenerPrecioSSAbo:end");
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
		public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO entrada)
			throws GeneralException
		{
			logger.debug("aplicaImpuestoImporte:start");
			RegistroFacturacionDTO resultado;
			try {
				resultado = srv.aplicaImpuestoImporte(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("CustomerDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("aplicaImpuestoImporte:end");
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
		public void updCodigoSituacionAbo(AbonadoDTO entrada) 
			throws GeneralException
		{
			logger.debug("updCodigoSituacionAbo:start");
			try {
				srv.updCodigoSituacionAbo(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("CustomerDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("updCodigoSituacionAbo:end");
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
		public String getDatosInstalacion(Long entrada) 
			throws GeneralException
		{
			logger.debug("getDatosInstalacion:start");
			String resultado = null;
			try {
				resultado = srv.getDatosInstalacion(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("CustomerDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("getDatosInstalacion:end");
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
		public RangoDTO[] obtieneRangosDisponibles(Integer codCentral)
			throws GeneralException
		{
			logger.debug("obtieneRangosDisponibles:start");
			RangoDTO[] resultado = null;
			try {
				resultado = srv.obtieneRangosDisponibles(codCentral);
			}
			catch(ProductDomainException e){
				logger.debug("ProductDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtieneRangosDisponibles:end");
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
		public void insertaRangoAsociadoNroPiloto(NumeroPilotoDTO entrada)
			throws GeneralException
		{
			logger.debug("insertaRangoAsociadoNroPiloto:start");
			try {
				srv.insertaRangoAsociadoNroPiloto(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("ProductDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("insertaRangoAsociadoNroPiloto:end");	
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
		public NivelPrestacionDTO[] obtieneNivelesPrestacion(NivelPrestacionDTO entrada)
			throws GeneralException
		{
			logger.debug("obtieneNivelesPrestacion:start");
			NivelPrestacionDTO[] resultado = null;
			try {
				resultado = srv.obtieneNivelesPrestacion(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("ProductDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("obtieneNivelesPrestacion:end");	
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
		public void eliminarRangos(Long entrada)
			throws GeneralException
		{
			logger.debug("eliminarRangos:start");			
			try {
				srv.eliminarRangos(entrada);
			}
			catch(ProductDomainException e){
				logger.debug("ProductDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("eliminarRangos:end");
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
		public Integer consultaVentasCliente(Long codCliente) 
			throws GeneralException
		{
			logger.debug("consultaVentasCliente:start");
			Integer resultado = null;
			try {
				resultado = srv.consultaVentasCliente(codCliente);
			}
			catch(CustomerDomainException e){
				logger.debug("CustomerDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("consultaVentasCliente:end");	
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
		public void updWimaxMacAddress(AbonadoDTO entrada) 
			throws GeneralException
		{
			logger.debug("updWimaxMacAddress:start");
			try {
				srv.updWimaxMacAddress(entrada);
			}
			catch(CustomerDomainException e){
				logger.debug("CustomerDomainException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("updWimaxMacAddress:end");
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
		public Long insertarDocDigitalizado(DocDigitalizadoDTO docDigitalizadoDTO) 
			throws CustomerDomainException 
		{
			logger.debug("Inicio");
			Long r = srv.insertarDocDigitalizado(docDigitalizadoDTO);
			logger.debug("Fin");
			return r;
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
		public void eliminarDocDigitalizado(Long numCorrelativo) 
			throws CustomerDomainException 
		{
			logger.debug("Inicio");
			srv.eliminarDocDigitalizado(numCorrelativo.longValue());
			logger.debug("Fin");
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
		public DocDigitalizadoDTO obtenerDocDigitalizado( Long numCorrelativo) 
			throws CustomerDomainException 
		{
			logger.debug("Inicio");
			DocDigitalizadoDTO r = srv.obtenerDocDigitalizado( numCorrelativo.longValue());
			logger.debug("Fin");
			return r;
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
		public DocDigitalizadoDTO[] obtenerDocDigitalizados(Long numVenta) 
			throws CustomerDomainException 
		{
			logger.debug("Inicio");
			DocDigitalizadoDTO[] r = srv.obtenerDocDigitalizados(numVenta.longValue());
			logger.debug("Fin");
			return r;
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
		public TipoDocDigitalizadoDTO[] obtenerTiposDocDigitalizado() 
			throws CustomerDomainException 
		{
			logger.debug("Inicio");
			TipoDocDigitalizadoDTO[] r = srv.obtenerTiposDocDigitalizado();
			logger.debug("Fin");
			return r;
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
		public SeguridadPerfilesDTO validaFiltroImpresion(SeguridadPerfilesDTO seguridadPerfilesDTO) 
			throws VentasException, RemoteException 
		{
			logger.debug("validaFiltroImpresion:start");		
			try {
				seguridadPerfilesDTO = srv.validaFiltroImpresion(seguridadPerfilesDTO);
			}catch(CustomerDomainException e){
				logger.debug("validaFiltroImpresion:end");
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("validaFiltroImpresion:end");
			
			return seguridadPerfilesDTO;		
		}//fin validaFiltroImpresion
		
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 * //TODO: Must provide implementation for bean method stub
		 */		
		public CargoSolicitudDTO[] getCargosPARecSolicitud(CargoSolicitudDTO entrada) 
			throws VentasException, RemoteException 
		{
			logger.debug("getCargosPARecSolicitud:start");
			CargoSolicitudDTO[] resultado = null;
			try {
				resultado = srv.getCargosPARecSolicitud(entrada);
			}catch(CustomerDomainException e){
				logger.debug("validaFiltroImpresion:end");
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("validaFiltroImpresion:end");
			
			return resultado;		
		}//fin getCargosPARecSolicitud
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 * //TODO: Must provide implementation for bean method stub
		 */		
		public void insertaNumerosSMS(FormularioNumerosSMSDTO entrada) 
			throws VentasException, RemoteException 
		{
			logger.debug("insertaNumerosSMS:start");			
			try {
				srv.insertaNumerosSMS(entrada);
			}catch(ProductDomainException e){
				logger.debug("validaFiltroImpresion:end");
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("insertaNumerosSMS:end");
		}//fin insertaNumerosSMS
		
		/** 
		 *
		 * <!-- begin-xdoclet-definition --> 
		 * @ejb.interface-method view-type="remote"
		 * <!-- end-xdoclet-definition --> 
		 * @generated
		 *
		 * //TODO: Must provide implementation for bean method stub
		 */		
		public void existeNumeroSMS(Long entrada) 
			throws VentasException, RemoteException 
		{
			logger.debug("existeNumeroSMS:start");			
			try {
				srv.existeNumeroSMS(entrada);
			}catch(ProductDomainException e){
				logger.debug("validaFiltroImpresion:end");
				logger.debug("VentasException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e.getMessage(),e);
			} catch (Exception e) {
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new VentasException(e);
			}
			logger.debug("existeNumeroSMS:end");
		}//fin existeNumeroSMS

		
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated 
	 */
	public Boolean validaVendedorLN(String codVendedor) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.info("Inicio");
		try {
			r = srv.validaVendedorLN(codVendedor);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException [" + StackTraceUtl.getStackTrace(e) + "]");
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated 
	 */
	public Boolean validaVendedorDealerLN(String codVendedorDealer) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = srv.validaVendedorDealerLN(codVendedorDealer);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException [" + StackTraceUtl.getStackTrace(e) + "]");
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated 
	 */
	public Boolean validaSerieLN(String numSerie) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = srv.validaSerieLN(numSerie);
		}
		catch (ProductDomainException e) {
			logger.debug("ProductDomainException [" + StackTraceUtl.getStackTrace(e) + "]");
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public Boolean validaClienteLN(String codCliente) throws VentasException {
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = srv.validaClienteLN(codCliente);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException [" + StackTraceUtl.getStackTrace(e) + "]");
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated //TODO: Must provide implementation for bean method stub
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) 
		throws VentasException, RemoteException 
	{
		Boolean r = Boolean.FALSE;
		logger.debug("Inicio");
		try {
			r = srv.validaClienteLN(numIdent, codTipIdent);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException [" + StackTraceUtl.getStackTrace(e) + "]");
			VentasException ex = new VentasException();
			ex.setCodigo(e.getCodigo());
			ex.setCodigoEvento(e.getCodigoEvento());
			ex.setDescripcionEvento(e.getDescripcionEvento());
			ex.setMessage(e.getMessage());
			throw ex;
		}
		catch (Exception e) {
			logger.debug("Exception [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.debug("Fin");
		return r;
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
	public void insertaCargosOverride(DetalleLineaSolicitudDTO[] entrada) 
		throws  VentasException, RemoteException 
	{
		logger.debug("insertaCargosOverride:start");			
		try {
			srv.insertaCargosOverride(entrada);
		}catch(CustomerDomainException e){
			logger.debug("insertaCargosOverride:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertaCargosOverride:end");		
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
	public DetalleCargosSolicitudDTO[] recuperaCargosOverride(Long numVenta, String codOrigenTransaccion) 
		throws VentasException, RemoteException 
	{
		logger.debug("Inicio");
		DetalleCargosSolicitudDTO[] r = null;
		try {
			r = srv.recuperaCargosOverride(numVenta, codOrigenTransaccion);
		}
		catch (CustomerDomainException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error[" + log + "]");
			throw new VentasException(e.getMessage(), e);
		}
		catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error[" + log + "]");
			throw new VentasException(e);
		}

		logger.debug("Fin");
		return r;
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
	public ProrrateoDTO getProrrateo(ProrrateoDTO entrada) 
		throws VentasException, RemoteException 
	{
		logger.debug("getProrrateo:start");
		ProrrateoDTO resultado = new ProrrateoDTO();
		try {
			resultado = srv.getProrrateo(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getProrrateo:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getProrrateo:end");
		
		return resultado;		
	}//fin getProrrateo
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public Long creaDireccion(DireccionNegocioWebDTO entrada) 
		throws VentasException, RemoteException 
	{
		logger.debug("creaDireccion:start");
		Long resultado = null;
		try {
			resultado = srv.creaDireccion(entrada);
		}catch(CustomerDomainException e){
			logger.debug("creaDireccion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("creaDireccion:end");
		return resultado;		
	}//fin creaDireccion
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) 
		throws VentasException, RemoteException 
	{
		logger.debug("getCodigoCicloFacturacion:start");
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		try {
			resultado = srv.getCodigoCicloFacturacion(cliente);
		}catch(CustomerDomainException e){
			logger.debug("getCodigoCicloFacturacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getCodigoCicloFacturacion:end");
		return resultado;		
	}//fin getCodigoCicloFacturacion
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validarTelefonoLDI(String telefono) 
		throws VentasException, RemoteException 
	{
		logger.info("validarTelefonoLDI, inicio");
		logger.debug("telefono: " + telefono);
		boolean r = false;
		try {
			r = srv.validarTelefonoLDI(telefono);
		}
		catch (Exception e) {
			logger.error("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("validarTelefonoLDI, fin");
		return r;
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
	public ScoreClienteDTO[] getSolicitudesScoring(BusquedaSolScoringDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getSolicitudesScoring:start");
		ScoreClienteDTO[] resultado = null;
		try {
			resultado = srv.getSolicitudesScoring(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getSolicitudesScoring:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getSolicitudesScoring");
		return resultado;
	}//fin getSolicitudesScoring
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated //TODO: Must provide implementation for bean method stub
	 */
	public long insertarSolicitudScoring(ScoreClienteDTO dto, EstadoScoringDTO estadoScoringDTO)
			throws VentasException, RemoteException {
		logger.info("grabaScoringPendienteEnviar, inicio");
		long numSolScoring = 0;
		try {
			numSolScoring = srv.insertarSolicitudScoring(dto);
			dto.setNumSolScoring(numSolScoring);
			logger.debug("dto.getNumSolScoring(): " + dto.getNumSolScoring());
			dto.getDatosGeneralesScoringDTO().setNumSolScoring(numSolScoring);
			srv.grabarDatosGeneralesScoring(dto.getDatosGeneralesScoringDTO());
			estadoScoringDTO.setNumSolScoring(numSolScoring);
			srv.insertaEstadoScoring(estadoScoringDTO);
		}
		catch (CustomerDomainException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("grabaScoringPendienteEnviar, fin");
		return numSolScoring;
	}// fin insertarSolicitudScoring
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void liberarSeriesYTelefono(Long numVenta) 
		throws VentasException, RemoteException
	{
		logger.debug("liberarSeriesYTelefono:start");		
		try {
			srv.liberarSeriesYTelefono(numVenta);
		}catch(CustomerDomainException e){
			logger.debug("liberarSeriesYTelefono:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("liberarSeriesYTelefono");		
	}//fin liberarSeriesYTelefono
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ScoreClienteDTO getSolicitudScoring(Long numSolicitud)
		throws VentasException, RemoteException
	{
		logger.info("getSolicitudScoring, inicio");
		ScoreClienteDTO resultado = null;
		try {
			resultado = srv.getSolicitudScoring(numSolicitud);
		}
		catch(CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("getSolicitudScoring, fin");
		return resultado;
	}//fin getSolicitudScoring

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReporteScoringDTO getReporteSolicitudScoring(Long numSolicitud)
		throws VentasException, RemoteException
	{
		logger.info("getReporteSolicitudScoring, inicio");
		ReporteScoringDTO resultado = null;
		try {
			resultado = srv.getReporteSolicitudScoring(numSolicitud);
		}
		catch(CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("getReporteSolicitudScoring, fin");
		return resultado;
	}//fin getReporteSolicitudScoring	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  EstadoScoringDTO[] getEstadosSolicitudScoring(Long numSolicitud)
		throws VentasException, RemoteException
	{
		logger.info("getEstadosSolicitudScoring, inicio");
		 EstadoScoringDTO[] resultado = null;
		try {
			resultado = srv.getEstadosSolicitudScoring(numSolicitud);
		}
		catch(CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} 
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("getEstadosSolicitudScoring, fin");
		return resultado;
	}//fin getReporteSolicitudScoring		
	
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated //TODO: Must provide implementation for bean method stub
	 */
	public Double obtieneCapacidadPagoScoring(ScoreClienteDTO dto) throws VentasException,
			RemoteException {
		logger.info("obtieneCapacidadPagoScoring, inicio");
		Double r = null;
		try {
			logger.debug(dto.toString());
			srv.actualizaScoreCliente(dto);
			ArrayList lineas = dto.getLineas();
			for (Iterator i = lineas.iterator(); i.hasNext();) {
				LineaSolicitudScoringDTO linea = (LineaSolicitudScoringDTO) i.next();
				long numLineaScoring = srv.insertarLineaScoring(linea, new Long(dto.getCodCliente()));
				logger.debug("numLineaScoring [" + numLineaScoring + "]");
				linea.setNumLineaScoring(numLineaScoring);
				logger.debug("setea numero de linea");
				if (linea != null && linea.getArrayListServSup() != null) {
					logger.debug("linea != null");
					ArrayList servSups = linea.getArrayListServSup();
					if (servSups != null && servSups.size() > 0) {
						logger.debug("servSups != null");
						for (Iterator j = servSups.iterator(); j.hasNext();) {
							ListadoSSOutDTO ss = (ListadoSSOutDTO) j.next();
							srv.insertarServSupScoring(ss, dto.getNumSolScoring(), numLineaScoring);
						}
					}
					ProductoOfertadoDTO[] arrayPA = linea.getArrayPA();
					if (arrayPA != null && arrayPA.length > 0) {
						logger.debug("arrayPA != null");
						for (int k = 0; k < arrayPA.length; k++) {
							ProductoOfertadoDTO item = arrayPA[k];
							logger.debug("item.toString() [" + item.toString() + "]");
							srv.insertarPAScoring(item, dto.getNumSolScoring(), numLineaScoring);
						}
					}
				}
			}
			r = srv.calcularCapacidadPago(new Long(dto.getNumSolScoring()));
		}
		catch (CustomerDomainException e) {
			logger.error("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error [" + log + "]");
			logger.debug("e.getCodigo() [" + e.getCodigo() + "]");
			logger.debug("e.getCodigoEvento() [" + e.getCodigoEvento() + "]");
			logger.debug("e.getDescripcionEvento() [" + e.getDescripcionEvento() + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (ProductDomainException e) {
			logger.error("ProductDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error [" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error [" + log + "]");
			throw new VentasException(e);
		}
		
		logger.info("obtieneCapacidadPagoScoring, fin");
		return r;
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
	public LineaSolicitudScoringDTO[] getlineasSolScoring(Long entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getlineasSolScoring:start");
		LineaSolicitudScoringDTO[] resultado = null;
		try {
			resultado = srv.getlineasSolScoring(entrada);
		}catch(CustomerDomainException e){
			logger.debug("getSolicitudesScoring:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getlineasSolScoring");
		return resultado;
	}//fin getlineasSolScoring
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipoPrestacionDTO getDatosPrestacion(String codPrestacion)
		throws VentasException, RemoteException
	{
		logger.debug("getlineasSolScoring:start");
		TipoPrestacionDTO resultado = null;
		try {
			resultado = srv.getDatosPrestacion(codPrestacion);
		}catch(ProductDomainException e){
			logger.debug("getDatosPrestacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosPrestacion");
		return resultado;
	}//fin getDatosPrestacion
	
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void insertarResultadoScoreCliente(ResultadoScoreClienteDTO dto) throws VentasException, RemoteException {
		logger.info("insertarResultadoScoreCliente, inicio");
		try {
			logger.debug("antes de srv.insertarResultadoScoreCliente(dto)");
			logger.debug(dto.toString());
			srv.insertarResultadoScoreCliente(dto);
			logger.debug("después de srv.insertarResultadoScoreCliente(dto)");
			DocDigitalizadoScoringDTO[] requeridos = dto.getArrayDocumentosRequeridos();
			for (int i = 0; i < requeridos.length; i++) {
				DocDigitalizadoScoringDTO docDigitalizadoScoringDTO = requeridos[i];
				logger.debug(docDigitalizadoScoringDTO.toString());
				srv.insertarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
			}
			DocDigitalizadoScoringDTO[] opcionales = dto.getArrayDocumentosOpcionales();
			for (int i = 0; i < opcionales.length; i++) {
				DocDigitalizadoScoringDTO docDigitalizadoScoringDTO = opcionales[i];
				logger.debug(docDigitalizadoScoringDTO.toString());
				srv.insertarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
			}
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("insertarResultadoScoreCliente, fin");
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
	public LineaSolicitudScoringDTO getDetalleLineaScoring(Long numLineaScoring)
		throws VentasException, RemoteException
	{
		logger.debug("getDetalleLineaScoring:start");
		LineaSolicitudScoringDTO resultado = null;
		try {
			resultado = srv.getDetalleLineaScoring(numLineaScoring);
		}catch(CustomerDomainException e){
			logger.debug("getDetalleLineaScoring:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDetalleLineaScoring");
		return resultado;
	}//fin getDetalleLineaScoring
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void updLineaScoringReplicada(Long numLineaScoring, Long numAbonado)
		throws VentasException, RemoteException
	{
		logger.debug("updLineaScoringReplicada:start");		
		try {
			srv.updLineaScoringReplicada(numLineaScoring, numAbonado);
		}catch(CustomerDomainException e){
			logger.debug("updLineaScoringReplicada:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("updLineaScoringReplicada");		
	}//fin updLineaScoringReplicada;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insertaSolScoringVenta(SolScoringVentaDTO entrada , EstadoScoringDTO estadoScoring)
		throws VentasException, RemoteException
	{
		logger.debug("insertaSolScoringVenta:start");		
		try {
			srv.insertaSolScoringVenta(entrada, estadoScoring);
		}catch(CustomerDomainException e){
			logger.debug("insertaSolScoringVenta:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insertaSolScoringVenta");		
	}//fin insertaSolScoringVenta;
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public DocDigitalizadoScoringDTO[] obtenerDocDigitalizadosScoring(Long numSolScoring) throws VentasException,
			RemoteException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO[] r;
		try {
			logger.debug("srv.obtenerDocDigitalizadosScoring, antes");
			r = srv.obtenerDocDigitalizadosScoring(numSolScoring);
			logger.debug("srv.obtenerDocDigitalizadosScoring, después");
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public DocDigitalizadoScoringDTO obtenerDocDigitalizadoScoring(Long numCorrelativo, Long numSolScoring) throws VentasException,
			RemoteException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO r;
		try {
			logger.debug("srv.obtenerDocDigitalizadosScoring, antes");
			r = srv.obtenerDocDigitalizadoScoring(numCorrelativo, numSolScoring);
			logger.debug("srv.obtenerDocDigitalizadosScoring, después");
		}
		
		
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void actualizarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
	throws VentasException,
	RemoteException{
		logger.info("actualizarDocDigitalizadoScoring, Inicio");
		try {
			srv.actualizarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("actualizarDocDigitalizadoScoring, Fin");
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public EstadoDTO[] obtenerEstadosDestino(String codPrograma, String codEstadoOrigen, String nomTabla) throws VentasException,
			RemoteException {
		logger.info("obtenerEstadosDestino, Inicio");
		EstadoDTO[] r ;
		try {
			logger.debug("srv.obtenerEstadosDestino, antes");
			r = srv.obtenerEstadosDestino(codPrograma, codEstadoOrigen, nomTabla);
			logger.debug("srv.obtenerEstadosDestino, después");
		}
		
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerEstadosDestino, Fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated //TODO: Must provide implementation for bean method stub
	 */
	public void insertaEstadoScoring(EstadoScoringDTO estadoScoringDTO) throws VentasException,
			RemoteException {
		logger.info("insertaEstadoScoring, inicio");
		try {
			srv.insertaEstadoScoring(estadoScoringDTO);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("insertaEstadoScoring, fin");
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
	public Long obtenerNroventaSolScoring(Long numSolScoring)
		throws VentasException, RemoteException
	{
		logger.debug("obtenerNroventaSolScoring:start");
		Long resultado = null;
		try {
			resultado = srv.obtenerNroventaSolScoring(numSolScoring);
		}catch(CustomerDomainException e){
			logger.debug("insertaSolScoringVenta:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("obtenerNroventaSolScoring");
		return resultado;
	}//fin obtenerNroventaSolScoring;
	
	/**
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public boolean verificaPrestacionCliente(Long codCliente, String codPrestacion) throws VentasException,
			RemoteException {
		logger.info("verificaPrestacionCliente, inicio");
		boolean resultado = false;
		try {
			resultado = srv.verificaPrestacionCliente(codCliente, codPrestacion);
		}
		catch (CustomerDomainException e) {
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("verificaPrestacionCliente, fin");
		return resultado;
	}// fin obtenerNroventaSolScoring;
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReglaSSDTO[] getReglasdeValidacionSS(ReglaSSDTO entrada)
		throws VentasException, RemoteException
	{
		logger.debug("getReglasdeValidacionSS:start");
		ReglaSSDTO[] resultado = null;
		try {
			resultado = srv.getReglasdeValidacionSS(entrada);
		}catch(ProductDomainException e){
			logger.debug("getReglasdeValidacionSS:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getReglasdeValidacionSS");
		return resultado;
	}//fin getReglasdeValidacionSS;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EstadoScoringDTO[] obtenerEstadosSolicitudScoringXNumTarjeta(String codTipTarjetaSCL, String numTarjeta) throws VentasException,
			RemoteException {
		logger.info("obtenerEstadoSolicitudScoringXNumTarjeta, inicio");
		logger.debug("numTarjeta [" + numTarjeta + "]");
		EstadoScoringDTO[] r = null;
		try {
			r = srv.obtenerEstadosSolicitudScoringXNumTarjeta(codTipTarjetaSCL, numTarjeta);
		}
		catch (CustomerDomainException e) {
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error("log error [" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerEstadoSolicitudScoringXNumTarjeta, fin");
		return r;
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
	public void updIngresosMensualesCliente(ClienteDTO cliente)
		throws VentasException, RemoteException
	{
		logger.debug("updIngresosMensualesCliente:start");		
		try {
			srv.updIngresosMensualesCliente(cliente);
		}catch(CustomerDomainException e){
			logger.debug("updIngresosMensualesCliente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("updIngresosMensualesCliente");		
	}//fin updIngresosMensualesCliente;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public ResultadoScoreClienteDTO getResultadoScoring(Long numSolScoring) throws VentasException {
		logger.info("getResultadoScoring, inicio");
		ResultadoScoreClienteDTO resultado = null;
		try {
			resultado = srv.getResultadoScoring(numSolScoring);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("getResultadoScoring, fin");
		return resultado;
	}//fin getResultadoScoring
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public void updEstadoMovProductoSolicitud(Long numVenta) 
		throws VentasException 
	{
		logger.info("updEstadoMovProductoSolicitud, inicio");		
		try {
			srv.updEstadoMovProductoSolicitud(numVenta);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("updEstadoMovProductoSolicitud, fin");		
	}//fin updEstadoMovProductoSolicitud
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public TipoComportamientoDTO[] obtenerTiposComportamiento() 
		throws VentasException 
	{
		logger.info("obtenerTiposComportamiento, inicio");
		TipoComportamientoDTO[] resultado = null;
		try {
			resultado = srv.obtenerTiposComportamiento();
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerTiposComportamiento, fin");
		return resultado;
	}//fin obtenerTiposComportamiento

	/** 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public ProductoOfertadoDTO[] obtenerProductosOfertadosXFiltros(final String codPlanTarif, final String codCanal,
			final String nivel, final String codPrestacion, final String[] codigosTipoComportamiento)
			throws VentasException {
		logger.info("obtenerProductosOfertadosXFiltros, inicio");
		ProductoOfertadoDTO[] r = null;
		try {
			r = srv.obtenerProductosOfertadosXFiltros(codPlanTarif, codCanal, nivel, codPrestacion, codigosTipoComportamiento);
		}
		catch (CustomerDomainException e) {
			logger.error("CustomerDomainException");
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error("Exception");
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerProductosOfertadosXFiltros, fin");
		return r;
	}//fin obtenerProductosOfertadosXFiltros
	
	/** 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public ProductoOfertadoDTO[] obtenerProductosObligatoriosPT(final String codPlanTarif, 
																final String codCanal,
																final String nivel, 
																final String codPrestacion)
		   throws VentasException {
		logger.info("obtenerProductosObligatoriosPT, inicio");
		ProductoOfertadoDTO[] r = null;
		try {
			r = srv.obtenerProductosObligatoriosPT(codPlanTarif, codCanal, nivel, codPrestacion);
		}
		catch (CustomerDomainException e) {
			logger.error("CustomerDomainException");
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error("Exception");
			logger.error("log error[" + StackTraceUtl.getStackTrace(e) + "]");
			throw new VentasException(e);
		}
		logger.info("obtenerProductosObligatoriosPT, fin");
		return r;
	}//fin obtenerProductosObligatoriosPT
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 */
	public String consultaExistenPlanes(Long numSolScoring)throws VentasException 
	{
		logger.info("consultaExistenPlanes, inicio");
		String resultado = null;
		try {
			resultado = srv.consultaExistenPlanes(numSolScoring);
		}
		catch (CustomerDomainException e) {
			logger.debug("CustomerDomainException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.info("consultaExistenPlanes, fin");
		return resultado;
	}
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * @author JIB
	 * @param numImei
	 * @return
	 * @throws VentasException
	 */
	public boolean existeAbonadoXImei(Long numImei) 
	throws VentasException {
		final String nombreMetodo = "existeAbonadoXImei";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numImei [" + numImei + "]");
		boolean r = false;
		try {
			r = srv.existeAbonadoXImei(numImei);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}

	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * @author JIB
	 * @param numSerie
	 * @return
	 * @throws VentasException
	 */
	public boolean existeAbonadoXSimcard(Long numSerie)
			throws VentasException {
		final String nombreMetodo = "existeAbonadoXSimcard";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numSerie [" + numSerie + "]");
		boolean r = false;
		try {
			r = srv.existeAbonadoXSimcard(numSerie);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * @param codTiplan
	 * @return
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodTiplan(String codTiplan) throws VentasException {
		logger.info("getListadoCampaniasVigentesXCodTiplan, inicio");
		logger.debug("codTiplan [" + codTiplan + "]");
		CampanaVigenteDTO[] r = null;
		try {
			r = srv.getListadoCampaniasVigentesXCodTiplan(codTiplan);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw new VentasException(e);
		}
		logger.info("getListadoCampaniasVigentesXCodTiplan, fin");
		return r;
	}
	//	Inicio P-CSR-11002 JLGN 21-04-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * @param alta
	 * @return
	 * @throws CustomerDomainException
	 *
	 */
	public boolean insertaPANormal(AltaLineaWebDTO alta, Long numAbonado, long numMovimiento)
		throws VentasException,CustomerDomainException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		boolean resultado = true;
		logger.debug("insertaPANormal:start"); 
		try {
			resultado = srv.insertaPANormal(alta,numAbonado,numMovimiento);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("insertaPANormal:end");
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
		logger.debug("insertaPANormal:end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 21-04-2011
	//Inicio P-CSR-11002 JLGN 27-04-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void actualizaUsoTerminal(ArticuloDTO entrada, String codUsoNuevo)
		throws VentasException, RemoteException
	{
		logger.debug("actualizaUsoTerminal:start");		
		try {
			srv.actualizaUsoTerminal(entrada,codUsoNuevo);
		}
		catch(ProductDomainException e){
			logger.debug("actualizaUsoTerminal:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("actualizaUsoTerminal:end");	
	}//fin actualizaUsoTerminal
	//Fin P-CSR-11002 JLGN 27-04-2011
	
	//	Inicio P-CSR-11002 JLGN 12-05-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO getDatosCliente(String codCliente) throws VentasException, RemoteException
	{
		logger.debug("getDatosCliente:start");
		ClienteDTO clienteDTO = null;
		try {
			clienteDTO = srv.getDatosCliente(codCliente);
			logger.debug("Numero Identificacion: "+ clienteDTO.getNumeroIdentificacion());
			logger.debug("Tipo Identificacion: "+ clienteDTO.getCodigoTipoIdentificacion());
		}
		catch(CustomerDomainException e){
			logger.debug("getDatosCliente:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("getDatosCliente:end");	
		return clienteDTO;
	}//fin getDatosCliente
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaPassClasificacion(String passCalificacion) throws VentasException, RemoteException
	{
		logger.debug("validaPassClasificacion:start");
		boolean flagCalificacion = true;
		try {
			flagCalificacion = srv.validaPassClasificacion(passCalificacion);
		}
		catch(CustomerDomainException e){
			logger.debug("validaPassClasificacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("validaPassClasificacion:end");	
		return flagCalificacion;
	}//fin getDatosCliente
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insExcepcioCalificacion(String codCliente, String codPlanTarif, String nomUserOra, String codPass, String limiteCredito) throws VentasException, RemoteException
	{
		logger.debug("insExcepcioCalificacion:start");
		try {
			srv.insExcepcioCalificacion(codCliente, codPlanTarif, nomUserOra, codPass, limiteCredito);
		}
		catch(CustomerDomainException e){
			logger.debug("insExcepcioCalificacion:end");
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e.getMessage(),e);
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new VentasException(e);
		}
		logger.debug("insExcepcioCalificacion:end");	
	}//fin insExcepcioCalificacion
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 26-05-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosContrato obtenerDatosContrato(String numVenta)
		throws VentasException, RemoteException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("obtenerDatosContrato:start");
		DatosContrato datosContrato = null;
		try {
			datosContrato = srv.obtenerDatosContrato(numVenta);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("obtenerDatosContrato:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("obtenerDatosContrato:end");
		return datosContrato;
	}
	//Fin P-CSR-11002 JLGN 26-05-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String obtenerDirecPerCli(String codCliente)
		throws CustomerDomainException, VentasException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("obtenerDirecPerCli:start");
		String codDireccion;
		try {
			codDireccion = srv.obtenerDirecPerCli(codCliente);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("obtenerDatosContrato:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("obtenerDirecPerCli:end");
		return codDireccion;
	}
	//Fin P-CSR-11002 JLGN 14-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public long getCargoPlanTarif(String codPlanTarif)
		throws CustomerDomainException, VentasException
	{
		UtilLog.setLog(config.getString("VentasEJB.log"));
		logger.debug("getCargoPlanTarif:start");
		long resultado = 0;
		try {
			resultado = srv.getCargoPlanTarif(codPlanTarif);
		}
		catch(CustomerDomainException e){
			context.setRollbackOnly();
			logger.debug("getCargoPlanTarif:end");
			logger.debug("CustomerDomainException");
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
		logger.debug("getCargoPlanTarif:end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 14-06-2011
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String obtenerNombreFactura(long numVenta) throws CustomerDomainException{
		logger.debug("obtenerNombreFactura():start");		
		String resultado = srv.obtenerNombreFactura(numVenta);
		logger.debug("obtenerNombreFactura():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 29-10-2011
	
	//Inicio P-CSR-11002 JLGN 10-11-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insertRutaContrato(String numVenta, String rutaContrato) throws CustomerDomainException {
		logger.debug("Inicio:insertRutaContrato()");	
		srv.insertRutaContrato(numVenta, rutaContrato);
		logger.debug("Fin insertRutaContrato()");
	}
	//Fin P-CSR-11002 JLGN 10-11-2011
	//Inicio P-CSR-11002 JLGN 11-11-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String obtenerRutaContrato(long numVenta) throws CustomerDomainException{
		logger.debug("obtenerRutaContrato():start");		
		String resultado = srv.obtenerRutaContrato(numVenta);
		logger.debug("obtenerRutaContrato():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 11-11-2011
	
	//Inicio P-CSR-11002 JLGN 14-11-2011
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * @throws VentasException 
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void validaDisponibilidadNumero(String numCelular)throws ProductDomainException 
	{
		logger.debug("validaDisponibilidadNumero:start");
		srv.validaDisponibilidadNumero(numCelular);
		logger.debug("validaDisponibilidadNumero:end");
	}	
	//Fin P-CSR-11002 JLGN 14-11-2011
}
