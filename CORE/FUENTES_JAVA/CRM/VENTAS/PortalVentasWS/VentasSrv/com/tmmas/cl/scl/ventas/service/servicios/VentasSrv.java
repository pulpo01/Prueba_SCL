/**
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10/01/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.ventas.service.servicios;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
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
import com.tmmas.cl.scl.commonbusinessentities.dto.ProgramaDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroResultadoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SimcardInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioActInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.IdentificadorProceso;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AgenteVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.BitacoraDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteCOLDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConceptoVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareaPrebillingDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareaPreliquidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConversionMonetariaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DependenciasModalidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosComercialesVendExtDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosMotorCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanIndemnizacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.Producto;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoContratoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DatosGeneralesScoringDTO;
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
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Abonado;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CampanaVigente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CausalDescuento;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Ciudad;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Contrato;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CreditoConsumo;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CreditoMorosidad;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cuenta;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Direccion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DocDigitalizado;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Documento;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.EstadoProceso;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Factura;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.FormasPago;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.GrupoAfinidad;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.GrupoCobroServicio;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.IdentificadorCivil;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.InterfazCentral;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.ModalidadPago;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.ModalidadVenta;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Oficina;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.PlanIndemnizacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.PlanServicio;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Provincia;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Region;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroCargos;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroEvaluacionRiesgo;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroFacturacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroSolicitudes;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroVenta;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Scoring;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Usuario;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.UsuarioSCL;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Vendedor;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AlPetiGuiasAboDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CobroAdelantadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FormasPagoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.InterfazCentralDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MatrizEstadosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.NivelAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametroDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroSolicitudesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RenovacionAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioInDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorOutDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DireccionesListOutDTO;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.motorv1.ProcesadorCargos;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglaPlanTarifarioDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioOcacionalDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioSuplementarioDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasTerminalDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.PreBillingVE;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.PreliquidacionVE;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasPlanesTarifarios;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasServiciosSuplementarios;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSimcard;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasTerminal;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Articulo;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Bodega;
import com.tmmas.cl.scl.productdomain.businessobject.bo.DistribucionBolsa;
import com.tmmas.cl.scl.productdomain.businessobject.bo.HomeLinea;
import com.tmmas.cl.scl.productdomain.businessobject.bo.NumeracionCelularBO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ParametrosGenerales;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Prestacion;
import com.tmmas.cl.scl.productdomain.businessobject.bo.RangoNumero;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ServicioSuplementario;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Simcard;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Terminal;
import com.tmmas.cl.scl.productdomain.businessobject.bo.TipoStockSerie;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosGenerDTO;
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
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoTerminalDTO;
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
import com.tmmas.cl.scl.resourcedomain.businessobject.bo.Celda;
import com.tmmas.cl.scl.resourcedomain.businessobject.bo.Central;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;
import com.tmmas.cl.scl.ventas.service.helper.Global;

public class VentasSrv {	    
	private ModalidadVenta modalidadVentaBO = new ModalidadVenta();
	private PlanServicio planServicioBO = new PlanServicio();
	private Cliente clienteBO = new Cliente();
	private Vendedor vendedorBO = new Vendedor();
	private Documento documentoBO = new Documento();
	private Region regionBO = new Region();
	private Provincia provinciaBO = new Provincia();
	private Ciudad ciudadBO = new Ciudad();
	private EstadoProceso progresoProcesoBO = new EstadoProceso();
	private Abonado abonadoBO = new Abonado();
	private Contrato contratoBO = new Contrato();
	private RegistroEvaluacionRiesgo registroEvaluacionRiesgoBO = new RegistroEvaluacionRiesgo();
	private Cuenta cuentaBO = new Cuenta();
	private Usuario usuarioBO=new Usuario();
	private DatosGenerales datosGeneralesBO = new DatosGenerales();
	private RegistroVenta registroVentaBO = new RegistroVenta();
	private ServicioSuplementario servicioSuplementarioBO = new ServicioSuplementario();
	private Celda celdaBO = new Celda();
	private Central centralBO = new Central();
	private Terminal terminalBO = new Terminal();
	private PlanTarifario planTarifarioBO = new PlanTarifario();
	private ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
	private FormasPago formasPagoBO = new FormasPago();
	private Simcard simcardBO  = new Simcard();
	private CampanaVigente campanaBO = new CampanaVigente();
	private Direccion direccionBO  = new Direccion();
	private CampanaVigente campanaVigenteBO  = new CampanaVigente();
	private GrupoCobroServicio grupoCobroBO  = new GrupoCobroServicio();
	private HomeLinea homeLineaBO  = new HomeLinea();	
	private RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
	private TipoStockSerie tipoStockSerieBO = new TipoStockSerie();
	private Articulo articuloBO = new Articulo(); //*-- MAYORISTA
	private Bodega bodegaBO = new Bodega();
	private Prestacion prestacionBO = new Prestacion();	
	private NumeracionCelularBO numeracionBO = new NumeracionCelularBO();
	private Oficina oficinaBO = new Oficina();
	private UsuarioSCL usuarioSCLBO= new UsuarioSCL();
	private Factura facturaBO= new Factura();
	private CausalDescuento descuentoBO= new CausalDescuento();
	ModalidadPago modalidadPagoBO = new ModalidadPago();
	protected RegistroCargos registroCargosBO = new RegistroCargos();
	private DistribucionBolsa distribucionBolsaBO= new DistribucionBolsa();
	private RangoNumero rangoNumeroBO= new RangoNumero();
	private DocDigitalizado docDigitalizadoBO = new DocDigitalizado();
	private Scoring scoringBO = new Scoring();
	
	Global global = Global.getInstance();
	private ProgramaDTO datosPrograma = ProgramaDTO.getInstance();
	
	private final Logger logger = Logger.getLogger(VentasSrv.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	
	public VentasSrv()
	{
		logger.debug("VentasSrv():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("VentasSrv.log"));
		logger.debug("VentasSrv():End");		
	}
	
	
	public  String prueba()	throws VentasException, RemoteException
	{	
		return "llego a Ventas Srv";
	}
	
	public VendedorOutDTO lstVendedor(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:lstVendedor()");
		VendedorOutDTO resultado;
		resultado = vendedorBO.lstVendedor(vendedor);
		logger.debug("Inicio:lstVendedor()");
		return resultado;
	}//fin getCodigoOperadora
	
	public void updUsuario(UsuarioInDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:updUsuario()");
		usuarioBO.updUsuario(entrada);
		logger.debug("Inicio:updUsuario()");
	}//fin updUsuarios
	
	public DireccionesListOutDTO lstDirecCliente(DirecClienteDTO direcClienteDTO)
		throws CustomerDomainException  
	{
	    DireccionesListOutDTO resultado;
		logger.debug("Inicio:lstDirecCliente()");
		resultado = direccionBO.lstDirecCliente(direcClienteDTO);
		logger.debug("Fin:lstDirecCliente()");
	    return resultado;
	}
	
	/**
	 * Permite obtener codigo de la operadora
	 * @param N/A
	 * @return String
	 * @throws CustomerDomainException
	 */
	public String getCodigoOperadora()
		throws CustomerDomainException,ProductDomainException
	{
		logger.debug("Inicio:getCodigoOperadora()");
		String resultado;
		resultado = datosGeneralesBO.getCodigoOperadora();
		logger.debug("Inicio:getCodigoOperadora()");
		return resultado;
	}//fin getCodigoOperadora
	
	/**
	 * Permite obtener descripción de la operadora
	 * @param N/A
	 * @return String
	 * @throws CustomerDomainException
	 */
	public String getDescripcionOperadora() 
		throws CustomerDomainException,ProductDomainException
	{
		logger.debug("Inicio:getDescripcionOperadora()");
		String resultado;
		resultado = datosGeneralesBO.getDescripcionOperadora();
		logger.debug("Fin:getDescripcionOperadora()");
		return resultado;
	}//fin getDescripcionOperadora

	public CampanaVigenteDTO[] getListadoCampanasVigentes() 
		throws CustomerDomainException 
	{
		CampanaVigente campanasVigentesBO = new CampanaVigente();
		logger.debug("getListadoCampanaVigente():start");
		CampanaVigenteDTO[] resultado = campanasVigentesBO.getListadoCampanaVigente();
		logger.debug("getListadoCampanaVigente():end");
		return resultado;
	}
	
	public CausalDescuentoDTO[] getListadoCausalDescuento(Long codUso) 
		throws CustomerDomainException 
	{
		CausalDescuento causalDescuentoBO = new CausalDescuento();
		logger.debug("getListadoCausalDescuento():start");
		CausalDescuentoDTO[] resultado = causalDescuentoBO.getListadoCausalDescuento(codUso);
		logger.debug("getListadoCausalDescuento():end");
		return resultado;
	}
	
	public CreditoConsumoDTO[] getListadoCreditoConsumo(CreditoConsumoDTO creditoConsumoDTO) 
		throws CustomerDomainException 
	{
		CreditoConsumo creditoConsumoBO = new CreditoConsumo();
		logger.debug("getListadoCreditoConsumo():start");
		creditoConsumoDTO.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		CreditoConsumoDTO[] resultado = creditoConsumoBO.getListadoCreditoConsumo(creditoConsumoDTO);
		logger.debug("getListadoCreditoConsumo():end");
		return resultado;
	}
	
	public CreditoMorosidadDTO[] getListadoCreditoMorosidad(DatosComercialesDTO datoscomerciales) 
		throws CustomerDomainException 
	{
		CreditoMorosidad creditoMorosidadBO = new CreditoMorosidad();
		logger.debug("getListadoCreditoMorosidad():start");
		CreditoMorosidadDTO[] resultado = creditoMorosidadBO.getListadoCreditoMorosidad(datoscomerciales);
		logger.debug("getListadoCreditoMorosidad():end");
		return resultado;
	}
	
	public GrupoAfinidadDTO[] getListadoGrupoAfinidad(DatosComercialesDTO datoscomerciales) 
		throws CustomerDomainException 
	{
		GrupoAfinidad grupoAfinidadBO = new GrupoAfinidad();
		logger.debug("getListadoGrupoAfinidad():start");
		GrupoAfinidadDTO[] resultado = grupoAfinidadBO.getListadoGrupoAfinidad(datoscomerciales);
		logger.debug("getListadoGrupoAfinidad():end");
		return resultado;
	}
	
	public GrupoCobroServicioDTO[] getListadoGrupoCobroServicio()
		throws CustomerDomainException 
	{
		GrupoCobroServicio grupoCobroServicioBO = new GrupoCobroServicio();
		logger.debug("getListadoGrupoCobroServicio():start");
		GrupoCobroServicioDTO[] resultado = grupoCobroServicioBO.getListadoGrupoCobroServicio();
		logger.debug("getListadoGrupoCobroServicio():end");
		return resultado;
	}
	
	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoModalidadPago():start");		
		modalidad.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		modalidad.setCodigoOperacion(global.getValor("valor.columna.cod_operacion"));
		
		datosPrograma.setCodigoPrograma(global.getValor("programa.codigo"));
		datosPrograma.setNumeroVersion(Integer.parseInt(global.getValor("programa.version")));
		datosPrograma.setNumeroSubVersion(Integer.parseInt(global.getValor("programa.subversion")));
		modalidad.setDatosPrograma(datosPrograma);
		
		ModalidadPagoDTO[] resultado = modalidadPagoBO.getListadoModalidadPago(modalidad);
		logger.debug("getListadoModalidadPago():end");
		return resultado;
	}
	
	public PlanIndemnizacionDTO[] getListadoPlanIndemnizacion() 
		throws CustomerDomainException 
	{
		PlanIndemnizacion planIndemnizacionBO = new PlanIndemnizacion();
		logger.debug("getListadoPlanIndemnizacion():start");
		PlanIndemnizacionDTO[] resultado = planIndemnizacionBO.getListadoPlanIndemnizacion();
		logger.debug("getListadoPlanIndemnizacion():end");
		return resultado;
	}
	
	public PlanServicioDTO[] getListadoPlanServicio(PlanServicioDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoPlanServicio():start");
		PlanServicioDTO[] resultado = planServicioBO.getListadoPlanServicio(entrada);
		logger.debug("getListadoPlanServicio():end");
		return resultado;
	}	

	public ClienteDTO getCliente(ClienteDTO cliente)
		throws CustomerDomainException 
	{
		logger.debug("getCliente():start");
		//ClienteDTO cliente= clienteBO.getCliente(cliente);
		cliente= clienteBO.getCliente(cliente);
		cliente = clienteBO.getPlanComercial(cliente);
		logger.debug("getCliente():end");
		return cliente;
	}
	
	public ContratoDTO listadoContratosCliente(ContratoDTO contrato) 
		throws CustomerDomainException 
	{
		logger.debug("listadoContratosCliente():start");
		ContratoDTO resultado= clienteBO.listadoContratosCliente(contrato);
		logger.debug("listadoContratosCliente():end");
		return resultado;
	}
	
	public VendedorDTO getVendedor(VendedorDTO vendedor) 
		throws CustomerDomainException 
	{
		logger.debug("getVendedor():start");
		VendedorDTO resultado= vendedorBO.getVendedor(vendedor);
		logger.debug("getVendedor():end");
		return resultado;
	}
	/**
	 * Obtiene los tipos de contrato de la venta
	 * @param contrato
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato) 
		throws CustomerDomainException  
	{
		logger.debug("getListadoTipoContrato():start");
		contrato.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		if(contrato.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
		{		
			contrato.setIndContSeg(global.getValor("valor.columna.ind_contseg.prepago"));	
		}else {
			contrato.setIndContSeg(global.getValor("valor.columna.ind_contseg"));
		}
		contrato.setIndContCel(global.getValor("valor.columna.ind_contcel"));
		
		
		datosPrograma.setCodigoPrograma(global.getValor("programa.codigo"));
		datosPrograma.setNumeroVersion(Integer.parseInt(global.getValor("programa.version")));
		datosPrograma.setNumeroSubVersion(Integer.parseInt(global.getValor("programa.subversion")));
		contrato.setDatosPrograma(datosPrograma);
		
		ContratoDTO[] resultado= contratoBO.getListadoTipoContrato(contrato);
		logger.debug("getListadoTipoContrato():end");
		return resultado;
	}
	/**
	 * Busca los meses de duración asociado al tipo de contrato de venta
	 * @param contrato
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoNumeroMesesContrato():start");
		contrato.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		ContratoDTO resultado= contratoBO.getListadoNumeroMesesContrato(contrato);
		logger.debug("getListadoNumeroMesesContrato():end");
		return resultado;
	}
	
	/**
	 * Consulta el tipo de contrato de la venta
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ContratoDTO getTipoContrato(ContratoDTO contrato) 
		throws CustomerDomainException 
	{
		logger.debug("getTipoContrato():start");
		contrato.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		ContratoDTO resultado= contratoBO.getTipoContrato(contrato);
		logger.debug("getTipoContrato():end");
		return resultado;
	}

	
	public NumeroCuotasDTO[] getListadoNumeroCuotas(ModalidadPagoDTO modalidad) 
		throws CustomerDomainException 
	{
		ModalidadPago modalidadPagoBO = new ModalidadPago();
		logger.debug("getListadoNumeroCuotas():start");
		modalidad.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		NumeroCuotasDTO[] resultado = modalidadPagoBO.getListadoNumeroCuotas(modalidad);
		logger.debug("getListadoNumeroCuotas():end");
		return resultado;
	}
	
	public DocumentoDTO getListadoTipoDocumento(DatosComercialesDTO datoscomerciales) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoTipoDocumento():start");		
		boolean bExisteTipoFactura=false;
		datoscomerciales.setIndicadorAgente(global.getValor("valor.columna.ind_agente"));
		datoscomerciales.setIndicadorSituacion(global.getValor("valor.columna.ind_situacion"));
		datoscomerciales.setCodigoProducto(global.getValor("codigo.producto"));
		datoscomerciales.setParametroAmiCiclo(global.getValor("parametro.amiciclo"));
		datoscomerciales.setCodigoModulo(global.getValor("codigo.modulo.GA"));		
		DocumentoDTO[] arregloDocumentos = documentoBO.getListadoTipoDocumento(datoscomerciales);		
		DocumentoDTO resultado = new DocumentoDTO(); 
		if (arregloDocumentos!=null)
			for (int i=0; i<arregloDocumentos.length; i++)
			{
				//if (arregloDocumentos[i].getCodigo().equals(global.getValor("codigo.factura")))
				//{					
					bExisteTipoFactura = true;
					resultado.setCodigo(arregloDocumentos[i].getCodigo());
					resultado.setDescripcion(arregloDocumentos[i].getDescripcion());
					resultado.setCategoriaTributaria(arregloDocumentos[i].getCategoriaTributaria());
					resultado.setTipoFoliacion(arregloDocumentos[i].getTipoFoliacion());
				//}
			}
		if (!bExisteTipoFactura)
			throw new CustomerDomainException("No se encontro ningún tipo de documento Factura");
		
			
		logger.debug("getListadoTipoDocumento():end");
		return resultado;
	}
	
	public RegionDTO[] getListadoRegiones() 
		throws CustomerDomainException 
	{
		logger.debug("getListadoRegiones():start");
		RegionDTO[] resultado = regionBO.getListadoRegiones();
		logger.debug("getListadoRegiones():end");
		return resultado;
	}
	
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoProvincias():start");
		ProvinciaDTO[] resultado = provinciaBO.getListadoProvincias(region);
		logger.debug("getListadoProvincias():end");
		return resultado;
	}
	
	public CiudadDTO[] getListadoCiudades(ProvinciaDTO provincia) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoCiudades():start");
		CiudadDTO[] resultado = ciudadBO.getListadoCiudades(provincia);
		logger.debug("getListadoCiudades():end");
		return resultado;
	}
	
	public EstadoProcesoDTO getProgreso(EstadoProcesoDTO progreso) 
		throws CustomerDomainException 
	{
		logger.debug("getProgreso():start");
		EstadoProcesoDTO resultado = progresoProcesoBO.getProgreso(progreso);
		logger.debug("getProgreso():end");
		return resultado;
	}

	public CelularDTO getNumeroCelularAut(CelularDTO celular) 
		throws CustomerDomainException 
	{
		logger.debug("getNumeroCelularAut():start");
		CelularDTO resultado = registroVentaBO.getNumeroCelularAut(celular);
		logger.debug("getNumeroCelularAut():end");
		return resultado;
	}//fin getNumeroCelularAut

	public CelularDTO setReservaNumeroCelular(CelularDTO celular) 
		throws CustomerDomainException 
	{
		logger.debug("setReservaNumeroCelular():start");
		CelularDTO resultado = registroVentaBO.setReservaNumeroCelular(celular);
		logger.debug("setReservaNumeroCelular():end");
		return resultado;
	}//fin setReservaNumeroCelular
	
	public UsuarioDTO creacionUsuario(UsuarioDTO usuarioWS)
		throws CustomerDomainException
	{		
		// Voy a asumir que usuarioWS viene con todos los datos nececsarios para los insert
		logger.debug("Inicio:creacionUsuario()");
		// Creacion de usuario
		UsuarioDTO usuarioSec = usuarioBO.getSecuenciaUsuario();
		usuarioWS.setCodigoUsuario(usuarioSec.getCodigoUsuario());
		usuarioWS = usuarioBO.creaNuevoUsuario(usuarioWS);
		// Creacion de direccion 
		Direccion direccionBO = new Direccion();
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();		
		datosGenerales.setCodigoSecuencia(global.getValor("secuencia.direccion"));
		datosGenerales  = datosGeneralesBO.getSecuencia(datosGenerales);
		
		DireccionNegocioDTO dirNeg = usuarioWS.getDireccionNegocioDTO()[0];
		String secDireccion = String.valueOf(datosGenerales.getSecuencia()); 
		dirNeg.setCodigo(secDireccion);
		
		//direccionBO.setDireccion(dirNeg);
		
		
		//Crea y asigna direcciones al usuario
		DireccionNegocioDTO[] arrDirecciones = new DireccionNegocioDTO[2];
		for(int i=0; i<2;i++)
		{			
			DireccionNegocioDTO dirDTO = new DireccionNegocioDTO();
			dirDTO.setCodigo(secDireccion);
			dirDTO.setTipo(i+2);
			arrDirecciones[i] = dirDTO;
		}		
		
		usuarioWS.setDireccionNegocioDTO(arrDirecciones);
		usuarioBO.insDireccionUsuario(usuarioWS);

		logger.debug("Fin:creacionUsuario()");		
		
		return usuarioWS;

	}
	/**
	 * Realiza validación de Ventas a nueva linea.
	 * @param entrada
	 * @return resultadoValidacion
	 * @throws CustomerDomainException
	 */
	
	public ResultadoValidacionVentaDTO validacionLinea(ParametrosValidacionVentasDTO entrada)
		throws CustomerDomainException,ProductDomainException,ResourceDomainException
	{
		ResultadoValidacionVentaDTO resultadoValidacion = null;
		logger.debug("Inicio:validacionLinea()");		
		
		//Modalidad de venta cuando es vendedor externo
		ParametrosComercialesVendExtDTO  parametrosComerciales = new ParametrosComercialesVendExtDTO(0, null);				
		AgenteVenta agente = new AgenteVenta(entrada.getCodigoCanal(), null);				
		Producto producto = new Producto(entrada.getNumeroSerieSimcard());				
		ConceptoVenta conceptoVenta = new ConceptoVenta(Integer.parseInt(
				entrada.getCodigoModalidadVenta()), null);
		DependenciasModalidadDTO depModalidad =
			new DependenciasModalidadDTO(agente, parametrosComerciales, producto, conceptoVenta);
		ConceptoVenta concepto = ValidarModalidadVenta(depModalidad);				
		entrada.setCodigoModalidadVenta(String.valueOf(concepto.getCodigo()));
		
		// ( 43 ) Verifica si serie simcard existe en abonado					
		resultadoValidacion = abonadoBO.existeSerieSimcardEnAbonado(entrada);
		if (resultadoValidacion.isResultado()){
			logger.debug("INICIO validacionLinea VentasSrv 1 NOK ");
			resultadoValidacion.setCodigoError("-1");
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setDetalleEstado("Serie simcard existe en abonado");
			return resultadoValidacion;
		}
		
		//Valida que el vendedor tenga acceso a bodega de la simcard	
		SimcardDTO simcard = new SimcardDTO();
		simcard.setNumeroSerie(entrada.getNumeroSerie());
		simcard = simcardBO.getSimcard(simcard);
		entrada.setCodigoBodega(simcard.getCodigoBodega());
		resultadoValidacion = vendedorBO.vendedorExisteEnBodegaSimcard(entrada);		
		if (!resultadoValidacion.isResultado())
		{
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setCodigoError("-1");
			resultadoValidacion.setDetalleEstado("Vendedor no tiene acceso a la bodega de la simcard");
			return resultadoValidacion;
		}		
		
		 //-- OBTIENE PARAMETRO : PRECIO LISTA
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		String sPrecioLista = parametrosGeneralesDTO.getValorparametro();		
		
		//Valida que el articulo asociado a la simcard tenga configurado precio
		ParametrosCargoSimcardDTO parametrosCargoSimcardDTO = new ParametrosCargoSimcardDTO();
		parametrosCargoSimcardDTO.setCodigoArticulo(simcard.getCodigoArticulo());
		logger.debug(" Precio SIMCARD simcard.getCodigoArticulo() : " + simcard.getCodigoArticulo() );
		parametrosCargoSimcardDTO.setCodigoUso(entrada.getCodigoUsoLinea());
		logger.debug(" Precio SIMCARD simcard.getCodigoUso() : " + simcard.getCodigoUso() );		
		parametrosCargoSimcardDTO.setEstado(simcard.getEstado());
		logger.debug(" Precio SIMCARD simcard.getEstado() : " + simcard.getEstado() );
		parametrosCargoSimcardDTO.setModalidadVenta(entrada.getCodigoModalidadVenta());
		logger.debug(" Precio SIMCARD simcard.setModalidadVenta() : " + entrada.getCodigoModalidadVenta() );
		parametrosCargoSimcardDTO.setTipoContrato(entrada.getCodigoTipoContrato());
		logger.debug(" Precio SIMCARD simcard.getCodigoTipoContrato() : " + entrada.getCodigoTipoContrato() );
		parametrosCargoSimcardDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
		logger.debug(" Precio SIMCARD simcard.getCodigoPlanTarifario() : " + entrada.getCodigoPlanTarifario() );
		parametrosCargoSimcardDTO.setCodigoUsoPrepago(global.getValor("codigo.uso.prepago"));
		boolean esMayoristaSimcard = false;
		boolean aplicaPrecioSimcard = true;
		if(entrada.isEsMayoristaSimcard())
		{
			esMayoristaSimcard = true;
			parametrosCargoSimcardDTO.setTipoStock("2");
		}else{
			parametrosCargoSimcardDTO.setTipoStock(simcard.getTipoStock());
			logger.debug(" Precio SIMCARD simcard.getTipoStock() : " + simcard.getTipoStock() );						
		}	
		
		if( esMayoristaSimcard && entrada.getCodigoModalidadVenta().trim().equals("1"))
		{
			aplicaPrecioSimcard = false;
		}
		logger.debug(" Precio SIMCARD parametrosCargoSimcardDTO.setCodigoUsoPrepago : " + parametrosCargoSimcardDTO.getCodigoUsoPrepago() );
		parametrosCargoSimcardDTO.setCodigoCategoria(simcard.getCodigoCategoria());
		logger.debug(" Precio SIMCARD parametrosCargoSimcardDTO.getCodigoCategoria : " + simcard.getCodigoCategoria() );
		parametrosCargoSimcardDTO.setIndicadorEquipo(global.getValor("indicador.equiacc"));
		logger.debug(" Precio SIMCARD parametrosCargoSimcardDTO.setIndicadorEquipo : " + parametrosCargoSimcardDTO.getIndicadorEquipo() );
		PrecioCargoDTO[] precioCargoDTOs = null;		
		try{
			if( aplicaPrecioSimcard )
			{
				if (sPrecioLista.equals(global.getValor("indicador.precio.lista"))){
					parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.preciolista"));
					precioCargoDTOs = simcardBO.getPrecioCargoSimcard_PrecioLista(parametrosCargoSimcardDTO);				
				}else{				
					parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.nolista"));
					precioCargoDTOs = simcardBO.getPrecioCargoSimcard_NoPrecioLista(parametrosCargoSimcardDTO);
				}
				if (precioCargoDTOs == null)
				{				
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setCodigoError("-2126");				
					resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
					return resultadoValidacion;
				}
			}
		}catch(ProductDomainException e){
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setCodigoError("-2126");
			resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
			return resultadoValidacion;
		}
		
		// Verifica si el vendedor tiene acceso a la bodega del teminal
		TerminalDTO terminal = new TerminalDTO();
		terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
		terminal = terminalBO.getTerminal(terminal);
		entrada.setCodigoBodega(terminal.getCodigoBodega());
		resultadoValidacion = vendedorBO.vendedorExisteEnBodegaTerminal(entrada);
		logger.debug("INICIO validacionLinea VentasSrv 12 terminal.getIndProcEq() : " + terminal.getIndProcEq() );
		
		if (!resultadoValidacion.isResultado() && terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
		{			
			resultadoValidacion.setEstado("NOK");
			resultadoValidacion.setCodigoError("-1");
			resultadoValidacion.setDetalleEstado("Vendedor no tiene acceso a la bodega del terminal");
			return resultadoValidacion;
		}		
		
		//Verifica que el Articulo asociado al terminal tenga precio.
		if (terminal.getIndProcEq() != null && terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
		{	
			
			ParametrosCargoTerminalDTO parametrosCargoTerminalDTO = new ParametrosCargoTerminalDTO();
			parametrosCargoTerminalDTO.setCodigoArticulo(terminal.getCodigoArticulo());
			parametrosCargoTerminalDTO.setCodigoUso(entrada.getCodigoUsoLinea());
			parametrosCargoTerminalDTO.setEstado(terminal.getEstado());
			parametrosCargoTerminalDTO.setModalidadVenta(entrada.getCodigoModalidadVenta());
			parametrosCargoTerminalDTO.setTipoContrato(entrada.getCodigoTipoContrato());
			parametrosCargoTerminalDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
			parametrosCargoTerminalDTO.setCodigoUsoPrepago(global.getValor("codigo.uso.prepago"));
			boolean esMayoristaTerminal = false;
			boolean aplicaPrecioTerminal = true;
			if(entrada.isEsMayoristaTerminal())
			{	
				esMayoristaTerminal = true;
				parametrosCargoTerminalDTO.setTipoStock("2");								
			}else{
				parametrosCargoTerminalDTO.setTipoStock(terminal.getTipoStock());				
			}			
			if( esMayoristaTerminal && entrada.getCodigoModalidadVenta().trim().equals("1"))
			{
				aplicaPrecioTerminal = false;
			}
			parametrosCargoTerminalDTO.setCodigoCategoria(terminal.getCodigoCategoria());
			parametrosCargoTerminalDTO.setIndicadorEquipo(global.getValor("indicador.equiacc"));			
			try{
				if( aplicaPrecioTerminal )
				{
					if (sPrecioLista.equals(global.getValor("indicador.precio.lista")))
					{
						parametrosCargoTerminalDTO.setIndiceRecambio(global.getValor("indice.recambio.preciolista"));					
						precioCargoDTOs = terminalBO.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);					
					}
					else{
						parametrosCargoTerminalDTO.setIndiceRecambio(global.getValor("indice.recambio.nolista"));					
						precioCargoDTOs = terminalBO.getPrecioCargoTerminal_NoPrecioLista(parametrosCargoTerminalDTO);					
					}
					if (precioCargoDTOs == null){
						resultadoValidacion.setEstado("NOK");
						resultadoValidacion.setCodigoError("-2127");
						resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
						return resultadoValidacion;
					}
				}
			}catch(ProductDomainException e){				
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setCodigoError("-2127");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
				return resultadoValidacion;
			}			


			// mtigua ( 55 ) Verifica si serie terminal existe en abonado					
			resultadoValidacion = abonadoBO.existeSerieTerminalEnAbonado(entrada);
			if (resultadoValidacion.isResultado()){	
				logger.debug("INICIO validacionLinea VentasSrv 20 NOK");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Serie terminal existe en abonado");
				resultadoValidacion.setCodigoError("-1");
				return resultadoValidacion;
			}
		
		}
		
		
		
		// Varifica si la modalidad de venta es credito, el terminal no sea externo
		if (!terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna"))){
		
			
			// ( 58 ) Verifica si serie terminal esta en lista negras
			resultadoValidacion = abonadoBO.validaSerieTermialEnListaNegra(entrada);
			if (resultadoValidacion.isResultado()){
				logger.debug("INICIO validacionLinea VentasSrv 22 NOK");
				resultadoValidacion.setEstado("NOK");
				//resultadoValidacion.setDetalleEstado("Formato de serie terminal inválido o se encuentra en listas negras");
				//resultadoValidacion.setCodigoError("-1");
				return resultadoValidacion;
			}
			
			ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
			parametrosGral.setNombreparametro(global.getValor("parametro.modalidad.venta.credito"));
			parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
			
			if (parametrosGral.getValorparametro().equals(entrada.getCodigoModalidadVenta())){
				logger.debug("INICIO validacionLinea VentasSrv 25 NOK");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Para venta a credito terminal no puede ser externo");
				resultadoValidacion.setCodigoError("-1");
				return resultadoValidacion;
			}
		}		
		/*mtiguacomment*/
		/*RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
		registroEvaluacionRiesgoDTO.setNumIdentificacion(entrada.getNumeroIdentificador());
		registroEvaluacionRiesgoDTO.setCodigoTipoIdentificacion(entrada.getTipoIdentificador());
		registroEvaluacionRiesgoDTO = registroEvaluacionRiesgoBO.existeExcepcion(registroEvaluacionRiesgoDTO);*/	
		resultadoValidacion.setEstado("OK");
		resultadoValidacion.setDetalleEstado("-");
		logger.debug("Fin:validacionLinea()");		
		return resultadoValidacion;
	}//fin validacionLinea
	
	public void insertaProceso(EstadoProcesoDTO proceso) 
		throws CustomerDomainException 
	{
		logger.debug("insertaProceso():start");
	    progresoProcesoBO.insertaProceso(proceso);
		logger.debug("insertaProceso():end");
	}
	
	public void modificaProceso(EstadoProcesoDTO proceso) 
		throws CustomerDomainException 
	{
		logger.debug("modificaProceso():start");
	    progresoProcesoBO.modificaProceso(proceso);
		logger.debug("modificaProceso():end");
	}
	
	public void eliminaProceso(EstadoProcesoDTO proceso) 
		throws CustomerDomainException 
	{
		logger.debug("eliminaProceso():start");
	    progresoProcesoBO.eliminaProceso(proceso);
		logger.debug("eliminaProceso():end");
	}
	
	public DatosValidacionDTO getValidaNuevoContratoCliente(ContratoDTO contrato) 
		throws CustomerDomainException
	{
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		logger.debug("getValidaNuevoContratoCliente():start");
	    resultado = contratoBO.getValidaNuevoContratoCliente(contrato);
		logger.debug("getValidaNuevoContratoCliente():end");
		return resultado;
	}
	
	public ResultadoValidacionVentaDTO existeEvaluacionRiesgo(ParametrosValidacionVentasDTO parametroEvaluacion)
		throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		logger.debug("existeEvaluacionRiesgo():start");
		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(parametroEvaluacion.getCodigoCliente());
		cliente = clienteBO.getCliente(cliente);
		parametroEvaluacion.setTipoIdentificador(cliente.getCodigoTipoIdentificacion());
		parametroEvaluacion.setNumeroIdentificador(cliente.getNumeroIdentificacion());
		parametroEvaluacion.setTipoSolicitudEvalRiesgo(global.getValor("tipo.solicitud"));
		parametroEvaluacion.setIndicadorEventoEvalRiesgo(global.getValor("indicador.evento"));
		parametroEvaluacion.setEstadoEvaluacionRiesgo(global.getValor("estado.vigente.evaluacionriesgo"));
		resultado = registroEvaluacionRiesgoBO.existeEvaluacionRiesgo(parametroEvaluacion);
		logger.debug("existeEvaluacionRiesgo():end");
		return resultado;
    }
	
	public ResultadoValidacionVentaDTO existeEvalRiesgoPlanTarif(ParametrosValidacionVentasDTO parametroEvaluacion)
		throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		logger.debug("getExisteEvalRiesgoPlanTarif():start");
		resultado = registroEvaluacionRiesgoBO.existeEvalRiesgoPlanTarif(parametroEvaluacion);
		logger.debug("getExisteEvalRiesgoPlanTarif():end");
		return resultado;
	
    }

	public void bloqueaDesbloqueaVendedor(VendedorDTO vendedor) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio:bloqueaDesbloqueaVendedor");
	    vendedorBO.bloquearDesbloquearVendedor(vendedor);
		logger.debug("Fin:bloqueaDesbloqueaVendedor");
	}//fin bloqueaDesbloqueaVendedor

	public CuentaDTO getCuenta(CuentaDTO cuentaDTO) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio:VentasSrv:getCuenta()");
		CuentaDTO resultado= cuentaBO.getCuenta(cuentaDTO);
		logger.debug("Fin:VentasSrv:getCuenta()");
		return resultado;
	}//fin datosCuenta
	
	public ParametroDTO getValorParametro(ParametroDTO parametroEntrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getValorParametro()");
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoParametro(parametroEntrada.getCodigoParametro());
		datosGenerales.setCodigoModulo(parametroEntrada.getCodigoModulo());
		datosGenerales.setCodigoProducto(parametroEntrada.getCodigoProducto());
		datosGenerales= datosGeneralesBO.getValorParametro(datosGenerales);
		ParametroDTO resultado = new ParametroDTO();
		resultado.setCodigoParametro(datosGenerales.getCodigoParametro());
		resultado.setValorParametro(datosGenerales.getValorParametro());
		logger.debug("Fin:getValorParametro()");
		
		return resultado;
	}
	
	public UsuarioDTO getSecuenciaUsuario()
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSecuenciaUsuario()");
		UsuarioDTO resultado = new UsuarioDTO();
		resultado = usuarioBO.getSecuenciaUsuario();
		logger.debug("Fin:getSecuenciaUsuario()");
		return resultado;
	}
	
	public CuentaDTO getSubCuenta(CuentaDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSubCuenta()");
		CuentaDTO resultado = new CuentaDTO();
		resultado = cuentaBO.getSubCuenta(entrada);
		logger.debug("Fin:getSubCuenta()");
		return resultado;
	}
	
	public AbonadoDTO getOficinaPrincipal(VendedorDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getOficinaPrincipal()");
		AbonadoDTO resultado = new AbonadoDTO();
		resultado = abonadoBO.getOficinaPrincipal(entrada);
		logger.debug("Fin:getOficinaPrincipal()");
		return resultado;
	}
	
	/**
	 * Obtiene secuencia del Abonado
	 * @param 
	 * @return abonado
	 * @throws CustomerDomainException
	 */
	
	public AbonadoDTO getSecuenciaAbonado()
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSecuenciaAbonado()");
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setCodigoSecuencia(global.getValor("secuencia.abonado"));
		abonado = abonadoBO.getSecuenciaAbonado(abonado);
		logger.debug("Fin:getSecuenciaAbonado()");
		return abonado;
	}
	
	/**
	 * Obtiene secuencia de la venta
	 * @param 
	 * @return secuenciaVenta
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaVenta()
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSecuenciaVenta()");
		RegistroVentaDTO secuenciaVenta = new RegistroVentaDTO();
		secuenciaVenta.setCodigoSecuencia(global.getValor("secuencia.venta"));
		secuenciaVenta = registroVentaBO.getSecuenciaVenta(secuenciaVenta);
		logger.debug("Fin:getSecuenciaVenta()");
		return secuenciaVenta;
	}
	
	/**
	 * Obtiene secuencia de transacabo
	 * @param
	 * @return secuenciaTransacabo
	 * @throws CustomerDomainException
	 */
	public RegistroVentaDTO getSecuenciaTransacabo()
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSecuenciaTransacabo()");
		RegistroVentaDTO secuenciaTransacabo = new RegistroVentaDTO();
		secuenciaTransacabo.setCodigoSecuencia(global.getValor("secuencia.transacabo"));
		secuenciaTransacabo = registroVentaBO.getSecuenciaTransacabo(secuenciaTransacabo);
		logger.debug("Fin:getSecuenciaTransacabo()");
		return secuenciaTransacabo;
	}

	public void creaAbonado(AbonadoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:creaAbonado()");
		abonadoBO.creaAbonado(entrada);
		logger.debug("Fin:creaAbonado()");		
	}

	public void creaSimcardAboser(AbonadoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:creaSimcardAboser()");
		abonadoBO.creaSimcardAboser(entrada);
		logger.debug("Fin:creaSimcardAboser()");
	}
	
	public void creaTerminalAboser(AbonadoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:creaTerminalAboser()");
		abonadoBO.creaTerminalAboser(entrada);
		logger.debug("Fin:creaTerminalAboser()");
	}
	
	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getPrefijoMin()");
		RegistroVentaDTO resultado = null;
		resultado = registroVentaBO.getPrefijoMin(entrada);
		logger.debug("Fin:getPrefijoMin()");
		return resultado;
	}

	public void creaSSAbonado(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:creaSSAbonado()");
		servicioSuplementarioBO.creaSSAbonado(entrada);
		logger.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado
	
	public void creaSSOpAbonado(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:creaSSAbonado()");
		servicioSuplementarioBO.insSSAdicionales(entrada);
		logger.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado
	
	
	public ModalidadPagoDTO getModalidadPago(ModalidadPagoDTO modalidad) 
		throws CustomerDomainException
	{
		logger.debug("INICIO getModalidadPago VentasSRV");
		ModalidadPago modalidadPagoBO = new ModalidadPago();
		logger.debug("Inicio:getModalidadPago()");
		ModalidadPagoDTO resultado = new ModalidadPagoDTO();
		logger.debug("INICIO getModalidadPago VentasSRV 1");
		resultado = modalidadPagoBO.getModalidadPago(modalidad);
		logger.debug("Fin:getModalidadPago()");
		return resultado;
	}
	/**
	 * Busca Datos de la Celda
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */
	public CeldaDTO obtieneDatosCelda(CeldaDTO entrada) 
		throws ResourceDomainException
	{
		logger.debug("Inicio:obtieneDatosCelda()");
		CeldaDTO resultado = new CeldaDTO();
		resultado =celdaBO.obtieneDatosCelda(entrada);
		logger.debug("Fin:obtieneDatosCelda()");
		return resultado;
	}
	
	/**
	 * Busca Listado de Centrales
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) 
		throws ResourceDomainException
	{
		logger.debug("Inicio:getListadoCentrales()");
		CentralDTO[] resultado = centralBO.getListadoCentrales(entrada);
		logger.debug("Fin:getListadoCentrales()");
		return resultado;
	}
	
	/**
	 * Busca Listado de Celdas
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */
	
	public CeldaDTO[] getListadoCeldas(CiudadDTO entrada) 
		throws ResourceDomainException
	{
		logger.debug("Inicio:getListadoCeldas()");
		CeldaDTO[] resultado = celdaBO.getListadoCeldas(entrada);
		logger.debug("Fin:getListadoCeldas()");
		return resultado;
	}
	
	/**
	 * Busca evaluación de riesgo de un plan tarifario especifico generada a un cliente
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO getEvalRiesgoPlanTarif(RegistroEvaluacionRiesgoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getEvalRiesgoPlanTarif()");
		RegistroEvaluacionRiesgoDTO resultado = null;
		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(entrada.getCliente().getCodigoCliente());
		cliente = clienteBO.getCliente(cliente);
		entrada.setCliente(cliente);
		entrada.setTipoSolicitud(global.getValor("tipo.solicitud"));
		entrada.setIndicadorEvento(global.getValor("indicador.evento"));
		entrada.setEstadosVigentes(global.getValor("estado.vigente.evaluacionriesgo"));		
		resultado = registroEvaluacionRiesgoBO.getEvalRiesgoPlanTarif(entrada);
		logger.debug("Fin:getEvalRiesgoPlanTarif()");
		return resultado;
	}
	
	/**
	 * Permite la creación de la línea asociada a un abonado.
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public DatosGeneralesVentaDTO creacionLineas(DatosGeneralesVentaDTO datosGeneralesVenta,UsuarioActInDTO  usuarioWS)
		throws CustomerDomainException,ProductDomainException
	{	
			logger.info("Inicio:creacionLineas()");
			DatosGeneralesVentaDTO resultado = datosGeneralesVenta;
	    	resultado.setEstadoError("OK");
	    	resultado.setDetalleError("-");
			
			String sNumeroMovtoSerieSimcard = null;
			String sNumeroMovtoSerieTerminal = null;
			
			Date fecha = new Date();
			Articulo articuloBO = new Articulo();
			
			AbonadoDTO abonadoAux = new AbonadoDTO();
			ServicioSuplementarioDTO servicioSuplementario = new ServicioSuplementarioDTO();
			UsuarioDTO usuario=new UsuarioDTO();
			ClienteDTO cliente = new ClienteDTO();
			AbonadoDTO abonado = new AbonadoDTO();
			CuentaDTO subCuenta = new CuentaDTO();
			SimcardDTO simcard = new SimcardDTO();					
			TerminalDTO terminal = new TerminalDTO();
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			VendedorDTO vendedor = new VendedorDTO();
			ArticuloDTO articulo = new ArticuloDTO();			
			
			//-- BUSCAR SERIE			
			simcard.setNumeroSerie(datosGeneralesVenta.getNumeroSerieSimcard());
			simcard = simcardBO.getSimcard(simcard);			

			//-- BUSCAR TERMINAL
			terminal.setNumeroSerie(datosGeneralesVenta.getNumeroSerieTerminal());
			terminal = terminalBO.getTerminal(terminal);			

			//RESERVA SERIE SIMCARD
			if(simcard.getEstado().equals(datosGeneralesVenta.getEstadoSerieSimcard()))
			{				
				logger.info("SIMCARD:RESERVA DEL ARTICULO");
				//-- RESERVA DEL ARTICULO
				articulo.setNumeroLinea(datosGeneralesVenta.getCorrelativoLinea());
                articulo.setNumeroOrden(datosGeneralesVenta.getNumeroOrden());
                articulo.setCodigo(Long.parseLong(simcard.getCodigoArticulo()));
				articulo.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
				articulo.setCodigoBodega(Integer.parseInt(simcard.getCodigoBodega()));
				articulo.setTipoStock(Integer.parseInt(simcard.getTipoStock()));
				articulo.setCodigoUso(simcard.getCodigoUso());
				articulo.setCodigoEstado(Integer.parseInt(simcard.getEstado()));
				articulo.setNombreUsuario(datosGeneralesVenta.getNombreUsuarioOracle());//???
				articulo.setNumeroSerie(simcard.getNumeroSerie());				
				
				try {
					articuloBO.insReservaArticulo(articulo);
			    	logger.info("SIMCARD:ACTUALIZA STOCK");
					//-- ACTUALIZA STOCK  
					articulo.setTipoMovimiento(global.getValor("tipo.movto.resventa"));
					articulo.setTipoStock(Integer.parseInt(simcard.getTipoStock()));
					articulo.setCodigoBodega(Integer.parseInt(simcard.getCodigoBodega()));
	                articulo.setCodigo(Long.parseLong(simcard.getCodigoArticulo()));
					articulo.setCodigoUso(simcard.getCodigoUso());
					articulo.setCodigoEstado(Integer.parseInt(simcard.getEstado()));
					articulo.setNumeroVenta(datosGeneralesVenta.getNumeroVenta());
					articulo.setNumeroSerie(simcard.getNumeroSerie());					
					
					try {
						articulo  = articuloBO.ActualizaStock(articulo);
						sNumeroMovtoSerieSimcard = articulo.getNumeroMovimiento();
						
						//-- RESERVA SERIE TERMINAL
				    	boolean bsigue = false;
				    	if(!terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
				    		bsigue =true;
				    	else
				    		if(terminal.getEstado().equals(terminal.getEstado()))
				    			bsigue =true;
				    	
						if(bsigue)
						{				
							logger.info("TERMINAL:RESERVA DEL ARTICULO");
							//-- RESERVA DEL ARTICULO
					    	if(terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
					    	{
					    		articulo.setNumeroLinea(datosGeneralesVenta.getCorrelativoLinea());
				                articulo.setNumeroOrden(datosGeneralesVenta.getNumeroOrden());
				                articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
								articulo.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
								articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
								articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
								articulo.setCodigoUso(terminal.getCodigoUso());
								articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
								articulo.setNombreUsuario(datosGeneralesVenta.getNombreUsuarioOracle());//???
								articulo.setNumeroSerie(terminal.getNumeroSerie());								
					    	}
							try {								
								if(terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna"))){
																		
									articuloBO.insReservaArticulo(articulo);
							    	logger.info("TERMINAL:ACTUALIZA STOCK");
									//-- ACTUALIZA STOCK  
									articulo.setTipoMovimiento(global.getValor("tipo.movto.resventa"));
									articulo.setTipoStock(Integer.parseInt(terminal.getTipoStock()));
									articulo.setCodigoBodega(Integer.parseInt(terminal.getCodigoBodega()));
					                articulo.setCodigo(Long.parseLong(terminal.getCodigoArticulo()));
									articulo.setCodigoUso(terminal.getCodigoUso());
									articulo.setCodigoEstado(Integer.parseInt(terminal.getEstado()));
									articulo.setNumeroVenta(datosGeneralesVenta.getNumeroVenta());
									articulo.setNumeroSerie(terminal.getNumeroSerie());									
								}
								try {
									if(terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna"))){
										articulo  = articuloBO.ActualizaStock(articulo);
										sNumeroMovtoSerieTerminal = articulo.getNumeroMovimiento();
									}									
									//-- BUSCA CLIENTE
									cliente.setCodigoCliente(datosGeneralesVenta.getCodigoCliente());									
									cliente = clienteBO.getCliente(cliente);									
									
									//-- BUSCA OFICINA PRINCIPAL VENDEDOR
									vendedor.setCodigoVendedor(datosGeneralesVenta.getCodigoVendedor());
									vendedor.setCodigoVendedorDealer(Long.valueOf(datosGeneralesVenta.getCodigoVendedorDealer()).longValue());
									vendedor = getVendedor(vendedor);
									abonadoAux = getOficinaPrincipal(vendedor);									
									
									//-- BUSCA SUBCUENTA
									subCuenta.setCodigoCuenta(cliente.getCodigoCuenta());
									subCuenta = getSubCuenta(subCuenta);
									cliente.setCodigoSubCuenta(subCuenta.getCodigoSubCuenta());
									
									//-- BUSCAR PLAN TARIFARIO
									planTarifario.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
									planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
									planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
									planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
									String sEstadoError = "OK";
									String sDetalleError = "-";
									//-- Datos de usuario	
									usuario.setTipoIdentificador(usuarioWS.getTipIdent());
									usuario.setNumeroIdentificador(usuarioWS.getNumIdent());
									usuario.setNombreUsuario(usuarioWS.getNomUsuario());
									usuario.setNombreApell1(usuarioWS.getNomApell1());
									usuario.setNombreApell2(usuarioWS.getNomApell2());
									usuario.setFechaNacimiento(usuarioWS.getFechaNacimiento());
									usuario.setCodigoSexo(usuarioWS.getIndSexo());
									usuario.setNombreMail(usuarioWS.getEmail());
									cliente.setIndicadorEstadoCivil(usuarioWS.getCodEstCivil());
									cliente.setCodigoEstrato(usuarioWS.getCodEstrato());
									usuario.setDatosCliente(cliente);
									
									// Datos de direcciones
									DireccionNegocioDTO arrDir[] =  new DireccionNegocioDTO[1];
									DireccionNegocioDTO dir = new DireccionNegocioDTO();
									dir.setProvincia(usuarioWS.getCodProvincia());
									dir.setRegion(usuarioWS.getCodRegion());
									dir.setCiudad(usuarioWS.getCodCiudad());
									dir.setComuna(usuarioWS.getCodComuna());
									dir.setTipoCalle(usuarioWS.getTipoCalle());
									dir.setCalle(usuarioWS.getNomCalle());
									dir.setObservacionDescripcion(usuarioWS.getObservacionDireccion());
									arrDir[0] = dir;
									usuario.setDireccionNegocioDTO(arrDir);
									
									
									try{
										usuario = creacionUsuario(usuario);
										
										if (usuario.getExitoCreacionUusario()==false)
										{											
											sEstadoError = "NOK";
											sDetalleError = "Ocurrio un error al crear el Usuario";
											throw new CustomerDomainException("156", 0,
													"Ocurrio un error al crear el Usuario");
										}
			
										//-- OBTIENE SECUENCIA-NUMERO ABONADO
										sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al crear el Abonado";
									    abonado = getSecuenciaAbonado();
										abonado.setFecAlta(datosGeneralesVenta.getFechaActual());
										abonado.setNumCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));										
										abonado.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));										
										abonado.setCodCliente(Long.parseLong(cliente.getCodigoCliente()));										
										abonado.setCodCuenta(Long.parseLong(cliente.getCodigoCuenta()));										
										abonado.setCodSubCuenta(cliente.getCodigoSubCuenta());										
										abonado.setCodUsuario(Long.parseLong(usuario.getCodigoUsuario()));										
										abonado.setCodRegion(datosGeneralesVenta.getCodigoRegion());										
										abonado.setCodProvincia(datosGeneralesVenta.getCodigoProvincia());										
										abonado.setCodCiudad(datosGeneralesVenta.getCodigoCiudad());
										if(datosGeneralesVenta.getCodigoTecnologia().trim().equals("codigo.tecnologia.GSM"))
										{
											abonado.setNumSerieSimcard(simcard.getNumeroSerie());
											abonado.setNumImei(terminal.getNumeroSerie());
										}else {											
											abonado.setNumSerieSimcard(datosGeneralesVenta.getNumeroSerieTerminal());
											abonado.setNumImei("");
										}
										
									    abonado.setCodBodegaSimcard(simcard.getCodigoBodega());
									    abonado.setCapcodeSimcard(simcard.getCapCode());
									    abonado.setTipoStockSimcard(Long.parseLong(simcard.getTipoStock()));
									    abonado.setCodigoArticuloSimcard(simcard.getCodigoArticulo());
									    abonado.setDesArticuloSimcard(simcard.getDescripcionArticulo());
									    abonado.setCodEstadoSimcard(global.getValor("estado.articulo"));
									    abonado.setCodUsoSimcard(simcard.getCodigoUso());
									    if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){									    	
									    	abonado.setCodUso(10);
									    	
									    }else{
									    	abonado.setCodUso(2);
									    }									    										
									    abonado.setCodPassword(simcard.getNumeroSerie().substring(simcard.getNumeroSerie().length()-4,simcard.getNumeroSerie().length()));									    
									    abonado.setNumSerieTerminal(terminal.getNumeroSerie());
									    abonado.setCodBodegaTerminal(terminal.getCodigoBodega());
									    abonado.setCapcodeTerminal(terminal.getCapCode());
									    if (terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
									    {									    	
									    	abonado.setTipoStockTerminal(Long.parseLong(terminal.getTipoStock()));
									    	abonado.setCodigoArticuloTerminal(terminal.getCodigoArticulo());
										    abonado.setDesArticuloTerminal(terminal.getDescripcionArticulo());
										    abonado.setCodUsoTerminal(terminal.getCodigoUso());
										    abonado.setCodEstadoTerminal(terminal.getEstado());
									    } else {									    	
									    	ParametrosGeneralesDTO parametroTerminal = new ParametrosGeneralesDTO();									    	
									    	/*--Busca Código Articulo por defecto asignado a equipos externos--*/
									    	/*Para COLOMBIA no se reliza esta parte ya que el equipo cuando es externo viene el valor del articulo */
									    	/*parametroTerminal.setCodigomodulo(global.getValor("codigo.modulo.GA"));
									    	parametroTerminal.setCodigoproducto(global.getValor("codigo.producto"));
									    	parametroTerminal.setNombreparametro(global.getValor("parametro.articulo.terminal.externo"));
									    	parametroTerminal = parametrosGeneralesBO.getParametroGeneral(parametroTerminal);*/
									    	
									    	parametroTerminal.setValorparametro(datosGeneralesVenta.getCodigoArticuloTerminal());									    	
									    	articulo.setCodigo(Long.parseLong(parametroTerminal.getValorparametro()));
									    	articulo = articuloBO.getArticulo(articulo);
									    	abonado.setCodigoArticuloTerminal(String.valueOf(articulo.getCodigo()));
										    abonado.setDesArticuloTerminal(articulo.getDescripcion());										    
										    ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();										    
										    if (planTarifario.getCodigoTipoPlan().equals(datosGeneralesVenta.getTipoPlanPostpago()))
										    {										    
										    	parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
										    	parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
										    	parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.usoVentaPostpago"));
										    	parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);										    
										    }  else{										    	
										    	parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
										    	parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
										    	parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.usoVentaHibrido"));
										    	parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);										    	
										    }
										    if (parametrosGeneralesDTO.getValorparametro()!=null)
										    {	
										    	abonado.setCodUsoTerminal(Integer.parseInt(parametrosGeneralesDTO.getValorparametro()));
										    }	
										    //Tipo stock terminal cuando es externa la procedencia
										    parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
									    	parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
									    	parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.tipoStockExterno"));
									    	parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);		
										    abonado.setTipoStockTerminal(Long.valueOf(parametrosGeneralesDTO.getValorparametro()).longValue());
									    }									    
										abonado.setIndProcEqTerminal(terminal.getIndProcEq());
										abonado.setTipPlantarif(planTarifario.getTipoPlanTarifario());
										abonado.setCodCargoBasico(planTarifario.getCodigoCargoBasico());
										abonado.setCodPlanServ(planTarifario.getCodigoPlanServicio());
										abonado.setCodLimConsumo(planTarifario.getCodigoLimiteConsumo());
										abonado.setCodCelda(datosGeneralesVenta.getCodigoCelda());  
										abonado.setCodCentral(Integer.parseInt(datosGeneralesVenta.getCodigoCentral()));
										abonado.setCodSituacion(global.getValor("codigo.situacion"));
 										abonado.setIndProcAlta(String.valueOf(vendedor.getIndicadorTipoVenta()));
										abonado.setIndProcEqSimcard(global.getValor("indicador.procedencia.equipo.simcard"));
										abonado.setCodVendedor(Long.parseLong(datosGeneralesVenta.getCodigoVendedor()));
										abonado.setCodVendedorAgente(Long.parseLong(datosGeneralesVenta.getCodigoVendedorRaiz()));
										
										//Se obtiene de GED_PARAMETROS cod_producto=1 cod_modulo=AL nom_parametro=COD_SIMCARD_GSM
//										//Para la tabla ga_abocer se utiliza este valor para la de equipo se utiliza el parametro asociado al terminal										
										abonado.setTipTerminal(datosGeneralesVenta.getCodigoSimcardGSM());										
										abonado.setCodPlanTarif(datosGeneralesVenta.getCodigoPlanTarifario());
										abonado.setNumSerieHex(global.getValor("numero.serie.hexadecimal"));
										abonado.setNomUsuarOra(datosGeneralesVenta.getNombreUsuarioOracle());
										abonado.setNumPerContrato(Integer.parseInt(datosGeneralesVenta.getNumeroPerContrato()));
										abonado.setCodigoEstado(datosGeneralesVenta.getCodigoEstado());
										abonado.setNumSerieMec(null);										
										if (datosGeneralesVenta.getIdentificadorEmpresa().equals(global.getValor("identificador.empresa")))
											abonado.setCodEmpresa(cliente.getCodigoEmpresa());
									    abonado.setCodGrpSrv(datosGeneralesVenta.getCodigoGrupoServicio());
									    abonado.setIndSuperTel(Integer.parseInt(global.getValor("indicador.supertelefono")));
										abonado.setNumTeleFija(null);
										abonado.setIndPrepago(Integer.parseInt(global.getValor("indicador.prepago")));
										abonado.setIndPlexSys(Integer.parseInt(global.getValor("indicador.plexsys")));
										abonado.setNumVenta(Long.parseLong(datosGeneralesVenta.getNumeroVenta()));
										abonado.setCodModVenta(Long.parseLong(datosGeneralesVenta.getCodigoModalidadVenta()));
										abonado.setCodTipContrato(datosGeneralesVenta.getCodigoTipoContrato());
										abonado.setNumContrato(datosGeneralesVenta.getNumeroContrato());
										abonado.setNumAnexo(datosGeneralesVenta.getNumAnexo());
										Calendar cal = new GregorianCalendar(); 
									    cal.setTimeInMillis(fecha.getTime()); 
									    cal.add(Calendar.MONTH, datosGeneralesVenta.getNumMesesContrato().intValue() ); 
									    Date fechaFinContrato = new Date(cal.getTimeInMillis()); 
									    String fechaFinContratoFormateada = Formatting.dateTime(fechaFinContrato,"dd/MM/yyyy HH:mm:ss");
									    cal = new GregorianCalendar(); 
									    cal.setTimeInMillis(fecha.getTime()); 
									    cal.add(Calendar.DATE,planTarifario.getNumDias()); 
									    Date fechaFecCumpPlan = new Date(cal.getTimeInMillis()); 
									    String fechaFecCumpPlanFormateada = Formatting.dateTime(fechaFecCumpPlan,"dd/MM/yyyy HH:mm:ss");
									    abonado.setFecCumPlan(fechaFecCumpPlanFormateada);
									    abonado.setCodCredMor(datosGeneralesVenta.getCodigoCreditoMorosidad());
									    abonado.setCodCredCon(datosGeneralesVenta.getCodigoCreditoConsumo());
									    abonado.setCodCiclo(cliente.getCodigoCiclo());									    
									    abonado.setCodFactur(Integer.parseInt(datosGeneralesVenta.getIndicadorFacturable()));
									    abonado.setIndSuspen(Integer.parseInt(global.getValor("indicador.ind_suspen")));
									    abonado.setIndReHabi(Integer.parseInt(global.getValor("indicador.ind_rehabi")));
									    abonado.setInsGuias(Integer.parseInt(global.getValor("indicador.ind_insguias")));
									    abonado.setFecFinContra(fechaFinContratoFormateada);
									    abonado.setFecRecDocu(null);	//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecCumplimen(null);	//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecAcepVenta(null);	//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecActCen(null);		//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecBaja(null);		//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecBajaCen(null);	//Valor por defecto null.... Se asigna fecha actual
									    abonado.setFecUltMod(datosGeneralesVenta.getFechaActual());
									    abonado.setCodCausaBaja(null);//Valor por defecto null no utilizada en VB
									    abonado.setNumPersonal(null); //Valor por defecto null no utilizada en VB
									    abonado.setIndSeguro(Integer.parseInt(global.getValor("indicador.ind_seguro")));
									    abonado.setClaseServicio(null);//Valor por defecto null no utilizada en VB
									    abonado.setPerfilAbonado(null);
									    /*Obtiene prefijo min y min mdn*/
									    RegistroVentaDTO registroVenta = new RegistroVentaDTO();
									    registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
									    registroVenta = getPrefijoMin(registroVenta);
									    if (registroVenta != null)
									    	abonado.setNumMin(registroVenta.getPrefijoMin());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)
									    if (registroVenta == null){
									    	registroVenta = new RegistroVentaDTO();
									    	registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
									    }									    
									    registroVenta = registroVentaBO.getMinMDN(registroVenta);									    
									    abonado.setNumMinMdn(registroVenta.getMinMDN());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)									    
									    if( datosGeneralesVenta.getCodigoVendedorDealer() !=null && 
									    		!datosGeneralesVenta.getCodigoVendedorDealer().trim().equals(""))
									    {
									    	abonado.setCodVendealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
									    }									    
									    abonado.setIndPassword(null);	//nulo por defecto
									    abonado.setCodAfinidad(datosGeneralesVenta.getCodigoGrupoAfinidad());
									    abonado.setFecProrroga(null);									    
									    abonado.setIndEqPrestadoTerminal(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));
									    abonado.setFlgContDigi(null);	//Valor por defecto null, no es llenado en VB
									    abonado.setFecAltanTras(null); 	//Valor por defecto null, no es llenado en VB									    	
									    if( datosGeneralesVenta.getCodigoPlanIndemnizacion() != null && 
									    	!datosGeneralesVenta.getCodigoPlanIndemnizacion().trim().equals(""))
								    	{
								    		abonado.setCodIndemnizacion(Integer.parseInt(datosGeneralesVenta.getCodigoPlanIndemnizacion()));
								    	}									    
									    abonado.setNumImei(datosGeneralesVenta.getNumeroSerieTerminal());									    
									    abonado.setCodTecnologia(global.getValor("codigo.tecnologia.GSM"));
									    abonado.setFecActivacion(null);	//Valor por defecto null, no es llenado en VB
									    abonado.setCodOficinaPrincipal(abonadoAux.getCodOficinaPrincipal());
									    
									    //Se modifica la causal de descuento por defecto para activaciones WEB FaseII
									    ParametrosGeneralesDTO parametrosGral1 = new ParametrosGeneralesDTO();
									    parametrosGral1.setCodigoproducto(global.getValor("codigo.producto"));
										parametrosGral1.setCodigomodulo(global.getValor("codigo.modulo.GA"));
										parametrosGral1.setNombreparametro(global.getValor("causal.descuento.default"));
										parametrosGral1 = parametrosGeneralesBO.getParametroGeneral(parametrosGral1);
										String sCausalDescuento = parametrosGral1.getValorparametro();
										logger.info("sCausalDescuento : " + sCausalDescuento);									    
									    abonado.setCodCausaVenta(sCausalDescuento);	//Valor por defecto null, no es llenado en VB
									    //Se modifica codigo de operacion por defecto para activaciones WEB FaseII
									    String sCodOperacion = global.getValor("codigo.operacion");
									    abonado.setCodOperacion(sCodOperacion);	//Valor por defecto null, no es llenado en VB
									    abonado.setCodCuota(Integer.parseInt(datosGeneralesVenta.getIndicadorCuotas()));
			
									    /* Datos nuevos GUATEMALA - EL SALVADOR */
									    abonado.setCodTipoPrestacion(datosGeneralesVenta.getCodTipPrestacion());
									    abonado.setMontoPreautorizado(datosGeneralesVenta.getMontoPreautorizado());
									    abonado.setCodMoneda(datosGeneralesVenta.getCodMoneda());									    
									    
									    //-- CREA ABONADO
									    sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al crear los SS";
										logger.info("INICIO creacionLineas SRV 33 Antes crear abonado");
										abonado.setIndTelefono(Integer.valueOf(global.getValor("indicador.telefono")).intValue());
									    creaAbonado(abonado);
									    logger.info("INICIO creacionLineas SRV 34 Despues crear abonado");
							
									    //Ejecuta creación Abonados Red Celular ga_abocel (Simcard y Terminal).
									    abonado.setIndComodato(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));
									    abonado.setTipTerminalEquipo(datosGeneralesVenta.getCodigoTerminalGSM());
									    abonado.setTipTerminalSimcard(datosGeneralesVenta.getCodigoSimcardGSM());
									    logger.info("INICIO creacionLineas SRV 34.1");
									    if(datosGeneralesVenta.getIndicadorCuotas() != null){
									    	if(!datosGeneralesVenta.getIndicadorCuotas().equals("0"))
									    	   abonado.setIndPropiedad(global.getValor("indicador.propiedad.externo"));
									    	else
									    	   abonado.setIndPropiedad(global.getValor("indicador.propiedad.cuotas"));
									    }
									    else
									    	abonado.setIndPropiedad(global.getValor("indicador.propiedad.externo"));
									    logger.info("INICIO creacionLineas SRV 34.2");
										abonado.setIndEqAcc(global.getValor("indicador.equiacc"));	
										if(datosGeneralesVenta.getCodCuota() != null)
										{
											abonado.setCodCuota(datosGeneralesVenta.getCodCuota().intValue());
										}
						                //-- INSERTA EN ga_servsuplabo ( SERVICIOS SUPLEMENTARIOS )
										servicioSuplementario.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
									    servicioSuplementario.setCodigoPlan(abonado.getCodPlanTarif());
									    servicioSuplementario.setNumeroTerminal(String.valueOf(abonado.getNumCelular()));
									    servicioSuplementario.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
									    logger.info("INICIO creacionLineas SRV 34.3 Antes creaSSAbonado ");
									    creaSSAbonado(servicioSuplementario);
									    //aqui deberia generar los SS opcionales
									    servicioSuplementario.setCadenaCodServs(datosGeneralesVenta.getServSuplAdicionales());
									    if (servicioSuplementario.getCadenaCodServs()!= null &&
									    		!servicioSuplementario.getCadenaCodServs().trim().equals(""))
									    { 
									    	creaSSOpAbonado(servicioSuplementario);
									    }
									    logger.info("INICIO creacionLineas SRV 34.3 Despues creaSSAbonado ");
									    logger.info("INICIO creacionLineas SRV 35 ");
			
									    //-- INSERTA EN ga_equipaboser
									    sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al asociar la simcard con el abonado";
									    abonado.setNumeroMovimiento(sNumeroMovtoSerieSimcard);
									    logger.info("INICIO creacionLineas SRV 34.3 Antes creaSimcardAboser ");
									    if(datosGeneralesVenta.getCodigoTecnologia().trim().equals("codigo.tecnologia.GSM"))
									    {
									    	creaSimcardAboser(abonado);
									    }
								    	logger.info("INICIO creacionLineas SRV 34.3 Despues creaSSAbonado ");								    	
			
						                //-- INSERTA EN ga_equipaboser
								    	sEstadoError = "NOK";
										sDetalleError = "Ocurrio un error al asociar el terminal con el Abonado";
									    abonado.setNumeroMovimiento(sNumeroMovtoSerieTerminal);									    
									    abonado.setTipTerminal(datosGeneralesVenta.getCodigoTerminalGSM());
									    creaTerminalAboser(abonado);
									    logger.info("INICIO creacionLineas SRV Despues creaTerminalAboser ");
									    if (datosGeneralesVenta.getNumeroSolicitud()!=0){
									    	sEstadoError = "NOK";
											sDetalleError = "Ocurrio un error al actualizar los terminales vendidos en la Ev. de Riesgo";
									    	RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
									    	registroEvaluacionRiesgoDTO.setNumeroSolicitud(datosGeneralesVenta.getNumeroSolicitud());
									    	registroEvaluacionRiesgoDTO.setCantidadTerminales(1);
									    	registroEvaluacionRiesgoDTO.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
									    	registroEvaluacionRiesgoBO.actualizaTerminalesVendidos(registroEvaluacionRiesgoDTO);
									    }
									    logger.info("INICIO creacionLineas SRV 37 ");
									    resultado.setNum_abonado(new Long(abonado.getNumAbonado()));
									    
									    //release II
									    resultado.setCod_ciclo(abonado.getCodCiclo());
									}catch(CustomerDomainException e){
										logger.info("INICIO creacionLineas SRV 37.1 ");										
										resultado.setEstadoError(sEstadoError);
								    	resultado.setDetalleError(sDetalleError);
								    	throw e;
									}catch(ProductDomainException e){
										logger.info("INICIO creacionLineas SRV 37.2 ");										
										resultado.setEstadoError(sEstadoError);
								    	resultado.setDetalleError(sDetalleError);
								    	throw e;
									}
									  logger.info("INICIO creacionLineas SRV 37.3 ");
								}// ActualizaStock (terminal) 
								catch (ProductDomainException e){
									logger.info("INICIO creacionLineas SRV 38 NOK");
							    	logger.info("[ERROR] Problemas al actualizar stock del articulo (terminal) : " + simcard.getNumeroSerie());
							    	resultado.setEstadoError("NOK");
							    	resultado.setDetalleError("Problemas al actualizar stock del articulo (terminal)");
								}

							}// insReservaArticulo (terminal)
							catch (ProductDomainException e){
								logger.info("INICIO creacionLineas SRV 39 NOK");
						    	logger.info("[ERROR] Problemas al reservar articulo (terminal) : " + simcard.getNumeroSerie());
						    	resultado.setEstadoError("NOK");
						    	resultado.setDetalleError("Problemas al reservar articulo (terminal)");
							}
						}
						else {		
							logger.info("INICIO creacionLineas SRV 40 NOK");
					    	logger.info("[ERROR] Estado de la serie terminal no es el mismo. Serie fue tomada por otro vendedor. ");
					    	resultado.setEstadoError("NOK");
					    	resultado.setDetalleError("Estado de la serie terminal no es el mismo. Serie fue tomada por otro vendedor");
						}
					}// ActualizaStock (simcard) 
					catch (ProductDomainException e){
						logger.info("INICIO creacionLineas SRV 41 NOK");
				    	logger.info("[ERROR] Problemas al actualizar stock del articulo (simcard) : " + simcard.getNumeroSerie());
				    	resultado.setEstadoError("NOK");
				    	resultado.setDetalleError("Problemas al actualizar stock del articulo (simcard)");
					}
				}// insReservaArticulo (simcard)
				catch (ProductDomainException e){
					logger.info("INICIO creacionLineas SRV 42 NOK");
			    	logger.info("[ERROR] Problemas al reservar articulo (simcard) : " + simcard.getNumeroSerie());
			    	resultado.setEstadoError("NOK");
			    	resultado.setDetalleError("Problemas al reservar articulo (simcard)");
				}
			}// estado (simcard)
			else {				
				logger.info("INICIO creacionLineas SRV 43 NOK");
		    	logger.info("[ERROR] Estado de la serie simcard no es el mismo. Serie fue tomada por otro vendedor. ");
		    	resultado.setEstadoError("NOK");
		    	resultado.setDetalleError("Estado de la serie simcard no es el mismo. Serie fue tomada por otro vendedor");
			}
			logger.info("Fin:creacionLineas()");
			
			//-- Registra campaña a nivel de abonado
			logger.info("codigo campana vigente: " + datosGeneralesVenta.getAplicaCampanaA());
			  logger.info("INICIO creacionLineas SRV 37.4 ");
			if(!resultado.getEstadoError().equals("NOK")){ //-- no hubo error
				logger.info("INICIO creacionLineas SRV 37.5 ");
				if (datosGeneralesVenta.getAplicaCampanaA() !=null && 
						datosGeneralesVenta.getAplicaCampanaA().equals(global.getValor("aplica.campana.a.abonado")))
				{
					logger.info("INICIO creacionLineas SRV 37.6 ");
					logger.info("aplica campaña a abonado..." + abonado.getNumAbonado());
					CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
					campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
					campanaVigenteDTO.setCodigoCliente(Long.parseLong(datosGeneralesVenta.getCodigoCliente()));
					campanaVigenteDTO.setNumeroAbonado(abonado.getNumAbonado());
					registraCampanaVigente(campanaVigenteDTO);
				}
			}
			logger.info("FIN creacionLineas SRV");
			
			
			return resultado;
	}//fin creacionLineas
	
	/**
	 * Obtiene un listado de abonados en base al numero de la Venta.
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getListaAbonadosVenta()");
		AbonadoDTO[] resultado = abonadoBO.getListaAbonadosVenta(entrada);
		logger.debug("Fin:getListaAbonadosVenta()");
		return resultado;
	}//fin getListaAbonadosVenta
	
	
	/**
	 * Metodo que obtiene los cargos asociados a la venta
	 * @param ParametrosObtencionCargosDTO parametros
	 * @return cargos
	 * @throws CustomerDomainException, ProductDomainException, FrameworkCargosException
	 */
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)
		throws CustomerDomainException,ProductDomainException , FrameworkCargosException
	{
		logger.debug("Inicio:obtenerCargos()");
		ObtencionCargosDTO resultado = new ObtencionCargosDTO();	
		RegistroVentaDTO regVenta = new RegistroVentaDTO();		
		regVenta.setNumeroVenta(Long.parseLong(parametros.getNumeroVenta()));		
		AbonadoDTO[] listaAbonados = abonadoBO.getListaAbonadosVenta(regVenta);
		
		logger.debug("INICIO obtenercargos listaAbonados: " + listaAbonados.length);
		ProcesadorCargos procesadorCargos = new ProcesadorCargos();
				

		//Verifica si el tipo de articulo de la simard corresponde a kit en ese caso no se cobra el equipo
		ParametrosGeneralesDTO parametrosKit = new ParametrosGeneralesDTO();
		
		parametrosKit.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosKit.setCodigomodulo(global.getValor("codigo.modulo.AL"));
		parametrosKit.setNombreparametro(global.getValor("parametro.tip_articulo_kit"));
		parametrosKit = getParametroGeneral(parametrosKit);
		
		for(int i=0;i<listaAbonados.length;i++)
		{
			ArrayList arregloReglas = new ArrayList();
			
			//-- BUSCA CLIENTE
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodigoCliente(String.valueOf(listaAbonados[i].getCodCliente()));									
			cliente = clienteBO.getCliente(cliente);
			parametros.setTipoCliente(cliente.getTipoCliente());
			parametros.setCodigoCalificacion(cliente.getCodCalificacion());
			
			//-- CARGOS PLAN TARIFARIO : CARGO BASICO
			//---------------------------------------
			//Se verifica si el plan tarifario corresponde a cobto adelantado (A) si es asi setea el cargo
			
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();		
			planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
			planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
			planTarifario.setCodigoPlanTarifario(listaAbonados[i].getCodPlanTarif());
			planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
			
			
			if(!parametros.isEsSolicitudVenta())
			{
				//Cuando es una ev crediticia o es override no debe filtrar por tipo de cobro se debe mostrar ya sea si es adelantado o vencido
				if(planTarifario.getTipoCobro().trim().equals(global.getValor("tipo.cobro.adelantado")) 
						|| parametros.isEsEvCrediticia() || parametros.isEsOverride())
				{			
					ReglasPlanesTarifarios reglaPlanTarifario = new ReglasPlanesTarifarios(getParametrosReglaPlanTarifario(parametros,listaAbonados[i]));					
					arregloReglas.add(reglaPlanTarifario);
				}
				
				if(!parametros.isEsEvCrediticia() && !parametros.isEsOverride())
				{
	
					//-- CARGOS SERVICIOS SUPLEMENTARIOS
					//----------------------------------
					ServicioSuplementarioDTO entradaServSupl = new ServicioSuplementarioDTO();
					entradaServSupl.setNumeroAbonado(String.valueOf(listaAbonados[i].getNumAbonado()));
		
					ServicioSuplementarioDTO[] listaServiciosSuplemantarios = null;
					try{
						listaServiciosSuplemantarios =  servicioSuplementarioBO.getSSAbonado(entradaServSupl);
					}catch(Exception e){
						logger.debug("No se pudo obtener abonados");
					}					
					
					if (listaServiciosSuplemantarios!=null)
					{
						for(int j=0;j<listaServiciosSuplemantarios.length;j++)
						{
							ReglasServiciosSuplementarios reglaServicioSuplementario = new ReglasServiciosSuplementarios(
									getParametrosReglaServicioSuplementario(parametros,listaAbonados[i],listaServiciosSuplemantarios[j]));
							arregloReglas.add(reglaServicioSuplementario);
							
						}//fin for
									
					}				
					
					//-- CARGOS SERVICIOS OCACIONALES
					//-------------------------------
					//ReglasServiciosOcasionales reglaServicioOcacional = new ReglasServiciosOcasionales(getParametrosReglaServicioOcacional(parametros,listaAbonados[i]));
					//arregloReglas.add(reglaServicioOcacional);					
				}
			} else {
				//-- CARGOS SIMCARD
				//-----------------
				ParametrosReglasSimcardDTO paramSimcard = null;
				if(listaAbonados[i].getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM")) && 
						!listaAbonados[i].getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.SMS")))
				{		    
					paramSimcard = getParametrosReglaSimcard(parametros,listaAbonados[i]);
					ReglasSimcard reglaSimcard = new ReglasSimcard(paramSimcard);
					arregloReglas.add(reglaSimcard);					
				}
				
				if(paramSimcard != null && !paramSimcard.getTipoArticulo().trim().equals(parametrosKit.getValorparametro()))
				{			
					//-- CARGOS TERMINAL
					//------------------
					ReglasTerminal reglaTerminal = new ReglasTerminal(getParametrosReglaTerminal(parametros,listaAbonados[i]));
					arregloReglas.add(reglaTerminal);					
				}
				
				
				//-- CARGOS INSTALACION
				//------------------
				//-- BUSCAR SI LA PRESTACION REQUIERE CARGO DE INSTALACION		
				TipoPrestacionDTO datosPrestacion = getDatosPrestacion(listaAbonados[i].getCodTipoPrestacion());
				if(datosPrestacion.getIndDirInstalacion() == 1 || 
						(datosPrestacion.getCodServicioInstalacion() != null && !datosPrestacion.getCodServicioInstalacion().trim().equals(""))) 
				{	
					    ServicioSuplementarioDTO servicio = new ServicioSuplementarioDTO();
					    servicio.setCodigoServicio(datosPrestacion.getCodServicioInstalacion());
					    servicio.setEsCargoInstalacion("1");
					    
						ReglasServiciosSuplementarios reglaServicioSuplementario = new ReglasServiciosSuplementarios(
								getParametrosReglaServicioSuplementario(parametros,listaAbonados[i],servicio));
						arregloReglas.add(reglaServicioSuplementario);
				}		

			}
			
			ReglaListaPrecio[] coleccionReglas =(ReglaListaPrecio[])ArrayUtl.copiaArregloTipoEspecifico(arregloReglas.toArray(), 
					ReglaListaPrecio.class);		
			procesadorCargos.calcularCargos(coleccionReglas);
			//procesadorCargos.agruparCargos();
		}
		
		CargosDTO[] cargos = procesadorCargos.obtenerCargos();
		VendedorDTO vendedor = new VendedorDTO();
		vendedor.setCodigoVendedor(parametros.getCodigoVendedor());
		vendedor = vendedorBO.getRangoDescuento(vendedor);
		resultado.setAplicaDescuentoVendedor(vendedor.isAplicaDescuento());		
		
		if (resultado.isAplicaDescuentoVendedor()){
			resultado.setPorcentajeDesctoInferior(vendedor.getPorcentajeDesctoInferior());
			logger.debug("porcentaje 1: " + resultado.getPorcentajeDesctoInferior());
			resultado.setPorcentajeDesctoSuperior(vendedor.getPorcentajeDesctoSuperior());
			logger.debug("porcentaje 2: " + resultado.getPorcentajeDesctoSuperior());
			resultado.setPuntoDesctoInferior(vendedor.getPuntoDesctoInferior());
			resultado.setPuntoDesctoSuperior(vendedor.getPuntoDesctoSuperior());
		}
		resultado.setCargos(cargos);		
		logger.debug("Fin:obtenerCargos()");		
		return resultado;
	}//fin obtenerCargos
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Plan Tarifario
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametrosReglaPlanTarifario
	 * @throws CustomerDomainException,ProductDomainException
	 */	
	private ParametrosReglaPlanTarifarioDTO getParametrosReglaPlanTarifario(ParametrosObtencionCargosDTO parametros, 
			AbonadoDTO abonado) 
		throws CustomerDomainException, ProductDomainException
	{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		ParametrosReglaPlanTarifarioDTO parametrosReglaPlanTarifario = new ParametrosReglaPlanTarifarioDTO();
		
		parametrosReglaPlanTarifario.setCodigoCargoBasico(abonado.getCodCargoBasico());
		parametrosReglaPlanTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametrosReglaPlanTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosReglaPlanTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		parametrosReglaPlanTarifario.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametrosReglaPlanTarifario.setCodigoUsoLinea(abonado.getCodUso());
		
		ParametrosDescuentoDTO parametrosDescuentoPlanTarifario = new ParametrosDescuentoDTO();
		parametrosDescuentoPlanTarifario.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoPlanTarifario.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		parametrosDescuentoPlanTarifario.setIndiceVentaExterna(String.valueOf(parametros.getIndicadorTipoVenta()));
		parametrosDescuentoPlanTarifario.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		
		parametrosDescuentoPlanTarifario.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoPlanTarifario.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoPlanTarifario.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoPlanTarifario.setCodigoCausaVenta(abonado.getCodCausaVenta());
		parametrosDescuentoPlanTarifario.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoPlanTarifario.setCodigoArticulo("");
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoPlanTarifario.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoPlanTarifario.setClaseDescuento(parametrosGral.getValorparametro());
				
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoPlanTarifario.setCodigoCategoria(planTarifario.getCodigoCategoria());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		parametrosReglaPlanTarifario.setIndicadorCargoHabilitacion(planTarifario.getIndicadorCargoHabilitacion());
		
		
		parametrosDescuentoPlanTarifario.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoPlanTarifario.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoPlanTarifario.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoPlanTarifario.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoPlanTarifario.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoPlanTarifario.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosDescuentoPlanTarifario.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan().trim());
		parametrosReglaPlanTarifario.setParametrosDescuento(parametrosDescuentoPlanTarifario);		
		parametrosReglaPlanTarifario.setNum_abonado(new Long(abonado.getNumAbonado()));
		parametrosReglaPlanTarifario.setNum_terminal(new Long(abonado.getNumCelular()));		
		parametrosReglaPlanTarifario.setCodigoUsoLinea(parametros.getCodUsoVenta());
		parametrosReglaPlanTarifario.setCodigoCalificacion(parametros.getCodigoCalificacion());		
		parametrosReglaPlanTarifario.setTipoServicioCobroAdelantado(1);
		parametrosReglaPlanTarifario.setTipoCobro(planTarifario.getTipoCobro());
		return parametrosReglaPlanTarifario;
	}
	
		
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Simcard
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSimcard
	 * @throws CustomerDomainException,ProductDomainException
	 */	
	private ParametrosReglasSimcardDTO getParametrosReglaSimcard(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
		throws CustomerDomainException,ProductDomainException
	{
		logger.debug("Ingreso a getParametrosReglaSimcard ");
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();		
		ParametrosReglasSimcardDTO parametroReglaSimcard = new ParametrosReglasSimcardDTO();
	
	    //-- OBTIENE PARAMETRO : PRECIO LISTA
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sPrecioLista = parametrosGral.getValorparametro();		
		
		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGIA GSM			
		String sGrupoTecGSM = abonado.getCodTecnologia();		

		//-- OBTIENE PARAMETRO : GRUPO TECNOLOGICO
		parametrosGral.setNombreparametro(global.getValor("codigo.tecnologia.GSM"));
		parametrosGral = parametrosGeneralesBO.getParametroGrupoTecnologico(parametrosGral);
		String sGrupoTecnologico = parametrosGral.getValorparametro();		
		
		// -- OBTIENE PARAMETRO : CAUSAL DE DESCUENTO		
		String sCausalDescuento = abonado.getCodCausaVenta(); //Causa venta--> causa descuento
		logger.debug("sCausalDescuento : " + sCausalDescuento);
		
		//BUSCA LA SIMCARD
		SimcardDTO simcard = new SimcardDTO();			
		simcard.setNumeroSerie(abonado.getNumSerieSimcard());
		simcard = simcardBO.getSimcard(simcard);
		
		parametroReglaSimcard.setCodigoArticulo(simcard.getCodigoArticulo());
		parametroReglaSimcard.setTipoArticulo(simcard.getTipoArticulo());
		parametroReglaSimcard.setNroSerie(abonado.getNumSerieSimcard());
		parametroReglaSimcard.setCodBodega(simcard.getCodigoBodega());		
		 
	    parametroReglaSimcard.setEsMayorista("FALSE");  
		parametroReglaSimcard.setTipoStock(simcard.getTipoStock());
		parametroReglaSimcard.setCodigoUso(simcard.getCodigoUso());
		parametroReglaSimcard.setEstado(global.getValor("estado.articulo"));
		parametroReglaSimcard.setCodigoCategoria(simcard.getCodigoCategoria());
		parametroReglaSimcard.setIndicadorValorar(simcard.getIndicadorValorar());
		parametroReglaSimcard.setIndicadorPrecioLista(sPrecioLista);		
		parametroReglaSimcard.setGrupoTecnologiaGSM(sGrupoTecGSM);
		parametroReglaSimcard.setGrupoTecnologico(sGrupoTecnologico);
		parametroReglaSimcard.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaSimcard.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaSimcard.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaSimcard.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaSimcard.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametroReglaSimcard.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaSimcard.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));		
		
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoSimcard = new ParametrosDescuentoDTO();
		parametrosDescuentoSimcard.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoSimcard.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoSimcard.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoSimcard.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		
		
		parametrosDescuentoSimcard.setIndiceVentaExterna(String.valueOf(parametros.getIndicadorTipoVenta()));
		
		parametrosDescuentoSimcard.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
		parametrosDescuentoSimcard.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoSimcard.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoSimcard.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoSimcard.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoSimcard.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoSimcard.setCodigoArticulo(simcard.getCodigoArticulo());
		parametrosDescuentoSimcard.setCodigoCausaVenta(sCausalDescuento);		
		
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		parametrosDescuentoSimcard.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoSimcard.setCodAbonocel(parametrosGral.getValorparametro());		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoSimcard.setClaseDescuento(parametrosGral.getValorparametro());
		
		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoSimcard.setCodigoCategoria(planTarifario2.getCodigoCategoria());
		
		parametrosDescuentoSimcard.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoSimcard.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoSimcard.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoSimcard.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoSimcard.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoSimcard.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaSimcard.setParametrosDescuento(parametrosDescuentoSimcard);
				
		parametroReglaSimcard.setNum_abonado(new Long(abonado.getNumAbonado()));
		parametroReglaSimcard.setNum_terminal(new Long(abonado.getNumCelular()));
		parametroReglaSimcard.setCodOficina(parametros.getCodOficina());
		parametroReglaSimcard.setCodigoCalificacion(parametros.getCodigoCalificacion());
		parametroReglaSimcard.setCodigoUso(abonado.getCodUso());	
		parametroReglaSimcard.setTipoCliente(parametros.getTipoCliente());
		
		//parametroReglaSimcard.setIndRenovacion(abonado.getIndRenovacion()); P-CSR-11002 JLGN 25-05-2011
		parametroReglaSimcard.setIndRenovacion(Integer.parseInt(abonado.getIndRenovacion())); //P-CSR-11002 JLGN 25-05-2011
		return parametroReglaSimcard;
	}

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */	 
	private ParametrosReglasTerminalDTO getParametrosReglaTerminal(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
		throws CustomerDomainException,ProductDomainException
	{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
		ParametrosReglasTerminalDTO parametroReglaTerminal = new ParametrosReglasTerminalDTO();
		
        //-- OBTIENE PARAMETRO : PRECIO LISTA
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sPrecioLista = parametrosGral.getValorparametro();
		
		//-- OBTIENE PARAMETRO : CAUSAL DE DESCUENTO
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("causal.descuento.default"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sCausalDescuento = parametrosGral.getValorparametro();
		logger.debug("sCausalDescuento : " + sCausalDescuento);
		
		//-- BUSCAR DATOS DEL TERMINAL
		terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		terminal = terminalBO.getTerminal(terminal);
		
		parametroReglaTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		parametroReglaTerminal.setNroSerie(abonado.getNumSerieTerminal());
		parametroReglaTerminal.setCodBodega(terminal.getCodigoBodega());
		parametroReglaTerminal.setTipoStock(terminal.getTipoStock());
		parametroReglaTerminal.setEsMayorista("FALSE");
		
		parametroReglaTerminal.setCodigoUso(terminal.getCodigoUso());
		parametroReglaTerminal.setEstado(global.getValor("estado.articulo"));
		parametroReglaTerminal.setCodigoCategoria(terminal.getCodigoCategoria());
		parametroReglaTerminal.setIndicadorValorar(terminal.getIndicadorValorar());
		parametroReglaTerminal.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaTerminal.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaTerminal.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaTerminal.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaTerminal.setIndicadorProcEquipo(terminal.getIndProcEq());
		parametroReglaTerminal.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametroReglaTerminal.setNumeroSerie(abonado.getNumSerieTerminal());
		parametroReglaTerminal.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaTerminal.setTipoContrato(parametros.getTipoContrato());
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		
		
		parametrosDescuentoTerminal.setIndiceVentaExterna(String.valueOf(parametros.getIndicadorTipoVenta()));
		
		parametrosDescuentoTerminal.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		
		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		parametrosDescuentoTerminal.setCodigoCausaVenta(sCausalDescuento);
		
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		parametrosDescuentoTerminal.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());
		
		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());
		
		
		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario2.getCodigoCategoria());
		
		
		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaTerminal.setParametrosDescuento(parametrosDescuentoTerminal);
		
		parametroReglaTerminal.setNum_abonado(new Long(abonado.getNumAbonado()));
		parametroReglaTerminal.setNum_terminal(new Long(abonado.getNumCelular()));
		parametroReglaTerminal.setCodOficina(parametros.getCodOficina());
		parametroReglaTerminal.setCodigoUso(abonado.getCodUso());
		parametroReglaTerminal.setCodigoCalificacion(parametros.getCodigoCalificacion());
		parametroReglaTerminal.setTipoCliente(parametros.getTipoCliente());
		
		//parametroReglaTerminal.setIndRenovacion(abonado.getIndRenovacion()); P-CSR-11002 JLGN 25-05-2011
		parametroReglaTerminal.setIndRenovacion(Integer.parseInt(abonado.getIndRenovacion())); //P-CSR-11002 JLGN 25-05-2011
		
		return parametroReglaTerminal;
	}//fin getParametrosReglaTerminal
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */	
	private ParametrosReglasServicioSuplementarioDTO getParametrosReglaServicioSuplementario(
			ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado,ServicioSuplementarioDTO servicio) 
		throws CustomerDomainException,ProductDomainException
	{
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
        ParametrosReglasServicioSuplementarioDTO parametrosReglaServicioSuplementario = new ParametrosReglasServicioSuplementarioDTO();
		
        //-- BUSCAR DATOS DEL TERMINAL
		terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		terminal = terminalBO.getTerminal(terminal);
		
		parametrosReglaServicioSuplementario.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosReglaServicioSuplementario.setCodigoServicio(servicio.getCodigoServicio());
		parametrosReglaServicioSuplementario.setCodigoPlanServicio(abonado.getCodPlanServ());
		parametrosReglaServicioSuplementario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametrosReglaServicioSuplementario.setCodigoCliente(String.valueOf(abonado.getCodCliente()));		
		parametrosReglaServicioSuplementario.setEsCargoInstalacion(servicio.getEsCargoInstalacion());
		
		
		//-- BUSCAR CODIGO ACTUACION
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);

		logger.debug("parametros.getTipoPlanPostPago():["+parametros.getTipoPlanPostPago()+"]");
		logger.debug("parametros.getCod_actabo():["+parametros.getCod_actabo()+"]");
		logger.debug("planTarifario.getCodigoTipoPlan():["+planTarifario.getCodigoTipoPlan()+"]");
				
		if (planTarifario.getCodigoTipoPlan().trim().equals(parametros.getTipoPlanPostPago().trim()))
			parametrosReglaServicioSuplementario.setCodigoActuacion(parametros.getCod_actabo());
		else if (planTarifario.getCodigoTipoPlan().trim().equals(parametros.getTipoPlanPrepago().trim()))
			parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.prepago"));
		else 
			parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.hibrido"));
		
		//Solicitan en una incidencia (mail enviado por JB):
		//Cuando es Hibrido va a buscar el precio con HH y cuando es pospago VO si 
		//es venta de oficina ( vendedor interno) VT venta externa ( vendedor externo).
		if( abonado.getCodUso() == 10 )  parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.hibrido"));
		if( abonado.getCodUso() == 3 ) parametrosReglaServicioSuplementario.setCodigoActuacion(global.getValor("codigo.actuacion.prepago"));
		if( abonado.getCodUso() == 2 ) parametrosReglaServicioSuplementario.setCodigoActuacion(parametros.getCod_actabo());
		
		/*-- Inicio Parametros Descuentos --*/		
	    ParametrosDescuentoDTO parametrosDescuentoSS = new ParametrosDescuentoDTO();
		parametrosDescuentoSS.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoSS.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		parametrosDescuentoSS.setIndiceVentaExterna(String.valueOf(parametros.getIndicadorTipoVenta()));
		parametrosDescuentoSS.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		
		parametrosDescuentoSS.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoSS.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoSS.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoSS.setCodigoCausaVenta(abonado.getCodCausaVenta());
		parametrosDescuentoSS.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoSS.setCodigoArticulo(terminal.getCodigoArticulo());
		parametrosDescuentoSS.setCodigoCalificaion(parametros.getCodigoCalificacion());		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoSS.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoSS.setClaseDescuento(parametrosGral.getValorparametro());		
		parametrosDescuentoSS.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());
		//planTarifario = new PlanTarifarioDTO();
		//planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoSS.setCodigoCategoria(planTarifario.getCodigoCategoria());
		
		parametrosDescuentoSS.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoSS.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoSS.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoSS.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoSS.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoSS.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosReglaServicioSuplementario.setParametrosDescuento(parametrosDescuentoSS);
		
		parametrosReglaServicioSuplementario.setNum_abonado(new Long(abonado.getNumAbonado()));
		parametrosReglaServicioSuplementario.setNum_terminal(new Long(abonado.getNumCelular()));
		if(parametrosReglaServicioSuplementario.getEsCargoInstalacion() != null && 
				!parametrosReglaServicioSuplementario.getEsCargoInstalacion().trim().equals("") &&
				!parametrosReglaServicioSuplementario.getEsCargoInstalacion().trim().equals("1"))
		{
			parametrosReglaServicioSuplementario.setTipoServicioCobroAdelantado(2);
		}
		return parametrosReglaServicioSuplementario;
	}//fin getParametrosReglaServicioSuplementario

	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios Ocacionales
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */	
	private ParametrosReglasServicioOcacionalDTO getParametrosReglaServicioOcacional(
												ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
		throws CustomerDomainException,ProductDomainException
	{
		
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		ParametrosReglasServicioOcacionalDTO parametrosReglaServicioOcacional = new ParametrosReglasServicioOcacionalDTO();
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		TerminalDTO terminal = new TerminalDTO();
		 
        //-- BUSCAR DATOS DEL TERMINAL
		terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		terminal = terminalBO.getTerminal(terminal);

		//-- BUSCAR DATOS COMODATO
		
		parametrosReglaServicioOcacional.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosReglaServicioOcacional.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametrosReglaServicioOcacional.setCodigoArticulo(terminal.getCodigoArticulo());
		parametrosReglaServicioOcacional.setCodigoUso(terminal.getCodigoUso());
		parametrosReglaServicioOcacional.setTipoStock(String.valueOf(terminal.getTipoStock()));
		parametrosReglaServicioOcacional.setIndicadorComodato(String.valueOf(parametros.getIndComodato()));
		parametrosReglaServicioOcacional.setModalidadVenta(parametros.getCodigoModalidadVenta());
		parametrosReglaServicioOcacional.setNumeroMeses(String.valueOf(parametros.getNumeroMesesContrato()));
		parametrosReglaServicioOcacional.setEsComodato(global.getValor("indicador.comodato"));
		
		//-- BUSCAR SI LA PRESTACION REQUIERE CARGO DE INSTALACION		
		TipoPrestacionDTO datosPrestacion = getDatosPrestacion(abonado.getCodTipoPrestacion());
		parametrosReglaServicioOcacional.setIndicadorInstalacion(datosPrestacion.getIndDirInstalacion());
		
		if(datosPrestacion.getIndDirInstalacion() ==1)
		{
			
			//TODO: falta definir de donde se sacaran estos parametros cuando es fijo 
			//ya que no se encuentra en la al_series solo en la al_articulos
			parametrosReglaServicioOcacional.setCodigoArticulo("522");
			parametrosReglaServicioOcacional.setCodigoUso(2);
			parametrosReglaServicioOcacional.setTipoStock("1"); 
		}
		
		//-- BUSCAR CODIGO ACTUACION
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);

		if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanPostPago()))
			parametrosReglaServicioOcacional.setCodigoActuacion(parametros.getCod_actabo()); //release II
		else 
			parametrosReglaServicioOcacional.setCodigoActuacion(global.getValor("codigo.actuacion.hibrido"));

		/*-- Inicio Parametros Descuentos --*/		
		
	    ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		parametrosDescuentoTerminal.setIndiceVentaExterna(String.valueOf(parametros.getIndicadorTipoVenta()));
		
		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaVenta(abonado.getCodCausaVenta());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(abonado.getCodigoArticuloTerminal());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());
		
		planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario = planTarifarioBO.getCategoriaPlanTarifario(planTarifario);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario.getCodigoCategoria());
	
		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametrosReglaServicioOcacional.setParametrosDescuento(parametrosDescuentoTerminal);
	
		parametrosReglaServicioOcacional.setNum_abonado(new Long(abonado.getNumAbonado()));
		parametrosReglaServicioOcacional.setNum_terminal(new Long(abonado.getNumCelular()));
		
		return parametrosReglaServicioOcacional;
	}//fin getParametrosReglaServicioOcacional
	
	/**
	 *Busca datos necesarios para crear los cargos asociados a la venta
	 * @param ClienteDTO cliente
	 * @return ParametrosObtencionCargosDTO resultado
	 * @throws CustomerDomainException,ProductDomainException
	 */
	
	public ParametrosObtencionCargosDTO validacionesGeneralesCargos(ParametrosObtencionCargosDTO parametros)
		throws CustomerDomainException
	{
		return null;
		
	}//fin validacionesGeneralesCargos

	public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto)
		throws CustomerDomainException
	{
		logger.debug("Inicio:validaCodigoVendedor()");
		ResultadoValidacionVentaDTO resultadovalidacion = vendedorBO.validaCodigoVendedor(vendedordto);;
		logger.debug("Fin:validaCodigoVendedor()");
		return resultadovalidacion;
	}//fin obtenerCargos
	
	/**
	 *Registra los cargos asociados a la venta
	 * @param ParametrosRegistroCargosDTO cargos
	 * @return 
	 * @throws GeneralException 
	 */
	
	public ResultadoRegistroCargosDTO registrarCargos(ParametrosRegistroCargosDTO cargos)
		throws GeneralException
	{
		
		logger.debug("Inicio:registrarCargos()");
		ResultadoRegistroCargosDTO resultado = new ResultadoRegistroCargosDTO();		
		List listaTareas = new ArrayList();
		
		//Secuencia numero peticion 
		AlPetiGuiasAboDTO alPetiGuiasAboDTO=new AlPetiGuiasAboDTO(); 
		alPetiGuiasAboDTO=getSecuenciaNumeroPeticion();
		logger.debug("alPetiGuiasAboDTO : " + alPetiGuiasAboDTO.getNum_peticion());
		
		ParametrosMotorCargosDTO parametrosMotor = new ParametrosMotorCargosDTO();
		parametrosMotor.setCodigoCliente(cargos.getCodigoCliente());
		parametrosMotor.setNumeroProceso(cargos.getNumeroVenta());
		parametrosMotor.setNumeroTransaccion(cargos.getNumeroTransaccion());
		parametrosMotor.setCodigoProducto(global.getValor("codigo.producto"));
		parametrosMotor.setCodigoSecuenciaCargo(global.getValor("secuencia.cargos"));
		parametrosMotor.setCodigoSecuenciaPaquete(global.getValor("secuencia.paquete"));
		parametrosMotor.setCodigoPlanComercialCliente(cargos.getCodigoPlanComercial());
		parametrosMotor.setParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));
		parametrosMotor.setModuloParametroDiaVctoFact(global.getValor("parametro.dias.vcto.fact"));
		
		
		//Obtiene codigo de moneda local
		ParametrosGeneralesDTO parametrosGeneralesDTO = getMonedaLocal();
		String codMonedaLocal = parametrosGeneralesDTO.getValorparametro();		
		
		parametrosMotor.setCodMonedaLocal(codMonedaLocal);
		
		/*Utilizados para ejecutar el Prebilling*/
		parametrosMotor.setNombreSecuenciaProcesoFacturacion(global.getValor("secuencia.num.proceso.fac"));
		parametrosMotor.setNombreParametroDocumentoGuia(global.getValor("parametro.documento.guia"));
		parametrosMotor.setModuloParametroDocumentoGuia(global.getValor("codigo.modulo.GA"));
		parametrosMotor.setNombreParametroFacturaGlobal(global.getValor("parametro.factura.global"));
		parametrosMotor.setModuloParametroFacturaGlobal(global.getValor("codigo.modulo.GA"));
		parametrosMotor.setParametroFlagCentroFac(global.getValor("parametro.flag.centro.emision.fact"));
		parametrosMotor.setModuloParametroFlagCentroFac(global.getValor("codigo.modulo.GA"));
		parametrosMotor.setCodigoTipoMovimiento(global.getValor("codigo.tipo.movimiento"));
		parametrosMotor.setCodigoTipoDocumento(cargos.getCodigoDocumento());
		parametrosMotor.setTipoFoliacionDocumento(cargos.getTipoFoliacion());
		parametrosMotor.setCodigoOficina(cargos.getCodigoOficina());
		parametrosMotor.setCategoriaTributaria(cargos.getCategoriaTributaria());
		parametrosMotor.setModalidadVenta(cargos.getModalidadVenta());
		parametrosMotor.setFacturacionaCiclo(cargos.isFacturacionaCiclo());
		
		parametrosMotor.setNum_abonado(cargos.getNum_abonado());
		parametrosMotor.setNum_terminal(cargos.getNum_terminal());
		
		parametrosMotor.setUsuario(cargos.getNombreUsuario());
		parametrosMotor.setNumeroPeticion(alPetiGuiasAboDTO.getNum_peticion());		
		
		ConfiguradorTareaPreliquidacionDTO confPreliquidacion = parametrosPreliquidacion(cargos);
		PreliquidacionVE tareaPreliquidacion = new PreliquidacionVE(confPreliquidacion);		

		ProcesadorCargos procesadorCargos = new ProcesadorCargos(parametrosMotor,cargos.getCargos());
		ConfiguradorTareasDTO configuradorTareas = new ConfiguradorTareasDTO();
		listaTareas.add(tareaPreliquidacion);		
		
		ConfiguradorTareaPrebillingDTO confPrebilling =parametrosPrebilling(cargos);
		confPrebilling.setPrebilling(true);
		PreBillingVE tareaPreBilling = new PreBillingVE(confPrebilling);
		listaTareas.add(tareaPreBilling);		
		
		TareasRegistroCargos[] arregloTareas =(TareasRegistroCargos[])ArrayUtl.copiaArregloTipoEspecifico(listaTareas.toArray(), 
				TareasRegistroCargos.class);		
		try{
		procesadorCargos.registrarCargos(arregloTareas);
		}catch (GeneralException e) {
			logger.debug("GeneralException");
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			logger.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
			throw e;			
		}
		
		ImpuestosDTO impuestos = procesadorCargos.obtenerImpuestos();		
		resultado.setImpuestos(impuestos);		
		
		BitacoraDTO bitacora = procesadorCargos.obtenerBitacora();
		if (bitacora != null) {
			ProcesoDTO[] procesos = bitacora.getProcesos();
			resultado.setPrebillingOK(true);
			for (int i=0;i<procesos.length;i++){
				if (procesos[i].getIdentificadorProceso() == IdentificadorProceso.EjecutaPrebilling){
					resultado.setPrebillingOK(false);
				}
					
			}
		}				
		logger.debug("Fin:registrarCargos()");		
		return resultado;
	}


	private ParametrosGeneralesDTO getMonedaLocal() 
		throws ProductDomainException 
	{
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.moneda.local"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		return parametrosGeneralesDTO;
	}
	
		
	public FormasPagoDTO[] obtenerFormasPago(ParametrosRegistroCargosDTO parametrosCargos) 
		throws CustomerDomainException,	ProductDomainException 
	{
		logger.debug("Inicio:obtenerFormasPago()");
		String codigoProducto = global.getValor("codigo.producto");
		String codigoModulo = global.getValor("codigo.modulo.GA");
		//Obtencion parametro mostrar tipo de pago
		ParametrosGeneralesDTO parametroMostrarTipoPago = new ParametrosGeneralesDTO();
		parametroMostrarTipoPago.setCodigoproducto(codigoProducto);
		parametroMostrarTipoPago.setCodigomodulo(codigoModulo);
		parametroMostrarTipoPago.setNombreparametro(global.getValor("parametro.mostrartipopago"));
		parametroMostrarTipoPago = parametrosGeneralesBO.getParametroGeneral(parametroMostrarTipoPago);

		FormasPagoDTO[] arrayformaspago = null;
		if (parametroMostrarTipoPago.getValorparametro().equalsIgnoreCase("TRUE")){
			// 1. Ver si la venta tiene planes freedom asociados
			// Se necesitan 4 parametros para esta consulta
			// Debo sacar el numero de venta, este lo tengo pendiente 
			// Parametro indicador de proporcionalidad (TRUE,FALSE)
			ParametrosGeneralesDTO parametroProporcVta = new ParametrosGeneralesDTO();
			parametroProporcVta.setCodigoproducto(codigoProducto);
			parametroProporcVta.setCodigomodulo(codigoModulo);
			parametroProporcVta.setNombreparametro(global.getValor("parametro.indproporcvta"));
			parametroProporcVta = parametrosGeneralesBO.getParametroGeneral(parametroProporcVta);
			// Parametro indicador de proporcionalidad 1 (1)
			ParametrosGeneralesDTO parametroProporc1 = new ParametrosGeneralesDTO();
			parametroProporc1.setCodigoproducto(codigoProducto);
			parametroProporc1.setCodigomodulo(codigoModulo);
			parametroProporc1.setNombreparametro(global.getValor("parametro.indproporc1"));
			parametroProporc1 = parametrosGeneralesBO.getParametroGeneral(parametroProporc1);
			// Parametro indicador de proporcionalidad 2 (2)
			ParametrosGeneralesDTO parametroProporc2 = new ParametrosGeneralesDTO();
			parametroProporc2.setCodigoproducto(codigoProducto);
			parametroProporc2.setCodigomodulo(codigoModulo);
			parametroProporc2.setNombreparametro(global.getValor("parametro.indproporc2"));
			parametroProporc2 = parametrosGeneralesBO.getParametroGeneral(parametroProporc2);
			// LLamada al procedimiento
			RegistroVentaDTO registroventa  = registroVentaBO.existePlanFreedomEnVenta(parametrosCargos,parametroProporcVta,parametroProporc1,parametroProporc2);

			// 2.- Consultar la categoria tributaria del cliente (Factura F, o Boleta B)
	 		ClienteDTO cliente = new ClienteDTO();
	 		cliente.setCodigoCliente(parametrosCargos.getCodigoCliente());
	 		cliente =  clienteBO.getCategoriaTributariaCliente(cliente);
			
			// 3.- Obtener el parametro orden de compra. 
			ParametrosGeneralesDTO parametroOrdenCompra = new ParametrosGeneralesDTO();
			parametroOrdenCompra.setCodigoproducto(codigoProducto);
			parametroOrdenCompra.setCodigomodulo(codigoModulo);
			parametroOrdenCompra.setNombreparametro(global.getValor("parametro.codigoordencompra"));
			parametroOrdenCompra = parametrosGeneralesBO.getParametroGeneral(parametroOrdenCompra);

			// Obtencion de las formas de pago
			arrayformaspago = formasPagoBO.getArrayFormasPago(parametroOrdenCompra,registroventa,cliente);
			
		}
		logger.debug("Fin:obtenerFormasPago()");
		return arrayformaspago;
	}
	
	/**
	 *Metodo privado que genera los parametros necesarios para ejecutar la tarea prebilling
	 * @param  parametrosCargos
	 * @return configuradorTareas
	 * @throws 
	 */
	
	private ConfiguradorTareaPrebillingDTO parametrosPrebilling(ParametrosRegistroCargosDTO parametrosCargos)
	{
		ConfiguradorTareaPrebillingDTO configuradorTareas = new ConfiguradorTareaPrebillingDTO();
		configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
		configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
		configuradorTareas.setNumeroTransaccionVenta(parametrosCargos.getNumeroTransaccion());
		configuradorTareas.setCategoriaTributaria(parametrosCargos.getCategoriaTributaria());
		configuradorTareas.setNombreSecuenciaTransacabo(global.getValor("secuencia.transacabo"));
		configuradorTareas.setActuacionPrebilling(global.getValor("codigo.actuacion.prebilling"));
		configuradorTareas.setProductoGeneral(global.getValor("codigo.producto.general"));
		configuradorTareas.setFacturacionaCiclo(parametrosCargos.isFacturacionaCiclo());
		configuradorTareas.setPrebilling(true);
		return configuradorTareas;
	}
	
	public Long cierreVenta(GaVentasDTO gaVentasDTO)
		throws CustomerDomainException,ProductDomainException 
	{
		
		logger.debug("cierreVenta():start");
		Long numMovimiento = null;
		ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();
		gaVentasDTO.setIndVenta(global.getValor("venta.indicador.venta"));
		gaVentasDTO.setIndOfiter(global.getValor("venta.oficina"));
		gaVentasDTO.setIndChkDicom(global.getValor("venta.chkdicom"));		
		ClienteDTO clienteDTO = new ClienteDTO();
		clienteDTO.setCodigoCliente(gaVentasDTO.getCodCliente().toString());
		clienteDTO = clienteBO.ObtienePlazaCliente(clienteDTO);
		gaVentasDTO.setCodPlaza(clienteDTO.getCodigoPlaza());
		gaVentasDTO.setCodOperadora(getCodigoOperadora());
		
		//se procede a efectuar los codigos alternativos
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.modalidad.venta.credito"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		
		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
			gaVentasDTO.setCuotas(true);
		}		
		
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.tarjeta.credito"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago())){
			gaVentasDTO.setTrajCredito(true);
		}
		
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.codigo.cheque"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		gaVentasDTO.setCodModPago(gaVentasDTO.getCodModPago()==null?"":gaVentasDTO.getCodModPago());
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		
		if (parametrosGeneralesDTO.getValorparametro().equals(gaVentasDTO.getCodModPago()))
		{
			gaVentasDTO.setCheque(true);
		}		
		
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.decimal.despliegue"));
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		
		String mascara =new String(); 
		String TotalFormateado= new String();
		
		
		for (int i=0;i<Integer.parseInt(parametrosGeneralesDTO.getValorparametro());i++){
			mascara= mascara + "0";
			}
		
		if (mascara.equals("")){
			mascara="##0";
		}else{
			mascara="##0." + mascara;
		} 
			
		TotalFormateado= (Formatting.number(gaVentasDTO.getImpVenta().floatValue(), mascara));
		
		gaVentasDTO.setImpVentaS(TotalFormateado);
		
		registroVentaBO.updateVentas(gaVentasDTO);		
		
		
		if(!gaVentasDTO.isCuotas()){
			if (!gaVentasDTO.isAciclo()){
				if (gaVentasDTO.isTrajCredito()){
					registroVentaBO.updateVentasEscenarioA(gaVentasDTO);
				}
				if (gaVentasDTO.isCheque()){
					registroVentaBO.updateVentasEscenarioB(gaVentasDTO);
				}
				if (!gaVentasDTO.isTrajCredito()&&gaVentasDTO.isCheque()){
					registroVentaBO.updateVentasEscenarioC(gaVentasDTO);
				}
			}else{
				registroVentaBO.updateVentasEscenarioD(gaVentasDTO);
			}			
		} 
		
		
		//Se actualiza código situación de los abonados en la solicitud de vta debe quedar en APF
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		abonadoDTO.setNumVenta(gaVentasDTO.getNumVenta().longValue());
		abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.final.nueva"));
		abonadoBO.updCodigoSituacion(abonadoDTO);	
		logger.debug("cierreVenta():end");
		return numMovimiento;
	}
	
	/**
	 *Metodo privado que Formatea un Valor de acuerdo a un valor parametrizado
	 * @param  parametrosCargos
	 * @return configuradorTareas
	 * @throws 
	 */
	
	public String FormatearValor(Float Valor)
		throws CustomerDomainException,ProductDomainException 
	{
		logger.debug("Formatear Valor ():start");
		String valor= new String();
		ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();		
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.decimal.despliegue"));
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
		
		String mascara =new String(); 
		String TotalFormateado= new String();
		
		for (int i=0;i<Integer.parseInt(parametrosGeneralesDTO.getValorparametro());i++){
			mascara= mascara + "0";
			}
		
		if (mascara.equals("")){
			mascara="##0";
		}else{
			mascara="##0." + mascara;
		} 
			
		TotalFormateado=(Formatting.number(Valor.floatValue(), mascara));
		
		valor = (TotalFormateado);
		
		return valor; 
	}	
	
	
	
	/**
	 *Metodo que verifica si la venta es a ciclo o no a ciclo
	 * @param  entrada
	 * @return resultado
	 * @throws CustomerDomainException,ProductDomainException
	 */
	
	public ResultadoValidacionDTO validacionesGeneralesCargo(ParametrosValidacionDTO entrada) 
		throws CustomerDomainException,ProductDomainException 
	{
		logger.debug("validacionesGeneralesCargo():start");
		ResultadoValidacionDTO resultado = new ResultadoValidacionDTO();
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.modalidad.venta.credito"));
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		if (parametrosGral.getValorparametro().equals(entrada.getCodigoModalidadVenta()))
			resultado.setResultado(true);
		resultado.setResultado(false);
		logger.debug("validacionesGeneralesCargo():end");
		return resultado;
		
	}
	
	
	/**
	 *Metodo que ejecuta la facturación del motor de cargos
	 * @param  entrada
	 * @return resultado
	 * @throws CustomerDomainException,ProductDomainException
	 */
	
	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO entrada) 
		throws CustomerDomainException,ProductDomainException,FrameworkCargosException 
	{
		logger.debug("ejecutarFacturacion():start");		
		ProcesadorCargos procesadorCargos = new ProcesadorCargos();
		entrada.setEstadoProceso(global.getValor("resultado.estado.proceso.OK"));
		entrada.setEstadoDocumento(global.getValor("vta.ingresada"));
		
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.dias.vcto.fact"));
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		
		entrada.setNroDiasVencimiento(Long.valueOf(parametrosGral.getValorparametro()));
		procesadorCargos.ejecutarFacturacion(entrada);
		logger.debug("ejecutarFacturacion():end");
	}
	
	/**
	 *Metodo que implementa caso de uso provisionar lineas, el cual crea movimiento en centrales
	 * @param  entrada
	 * @return resultado
	 * @throws CustomerDomainException,ProductDomainException,ResourceDomainException
	 */
	
	public Long provisionandoLinea(GaVentasDTO parametros) 
		throws CustomerDomainException,ProductDomainException,ResourceDomainException 
	{
		logger.debug("provisionandoLinea():inicio");		
		InterfazCentral interfazCentralBO = new InterfazCentral();
		String codigoActuacionProceso;
		//String sIndAkeys=null;
        String codigoAccion=null;
        String valorServicio=null;
        String codigoActuacionCentral = null;
        
        //Se actualiza código situación de los abonados
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		abonadoDTO.setNumVenta(parametros.getNumVenta().longValue());
		logger.debug("Actualiza Situacion Aboando parametros.getIndOfiter ["+parametros.getIndOfiter()+"]");
		
		if(parametros.getTipoCliente() != null && parametros.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
		{
			abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalO"));
		}else{
			if (parametros.getIndOfiter().equals("O")) {
				abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalO"));
			}else if(parametros.getIndOfiter().equals("T")){
				abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalT"));
			}
		}
		abonadoBO.updCodigoSituacion(abonadoDTO);
        
		//no se valida si es simcard externa ya que solo se maneja simcard Internas.
		ParametrosGeneralesDTO parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro(global.getValor("parametro.ind.telefono.out"));
		parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		
		
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario.setCodigoTecnologia(parametros.getAbonado().getCodTecnologia().trim());
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		float fImportePlan = planTarifario.getImporteCargoBasico();
				
		//Inicio P-CSR-11002 JLGN 14-06-2011
		SimcardDTO simcard = new SimcardDTO();
		
		simcard.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
		simcard.setIndicadorTelefono(parametrosGrales.getValorparametro());
		simcard = simcardBO.getIndicadorTelefono(simcard);		
		simcard.setIndProcEq(global.getValor("indicador.procedencia.equipo.simcard"));
		
		logger.debug("simcard.getIndicadorTelefono(): "+simcard.getIndicadorTelefono());
		
		if (!simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.noprogramada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bodega.desactivada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.infobox"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))
			&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.espera")))
			{
				throw new CustomerDomainException(
						"Linea " + parametros.getAbonado().getNumCelular() + "con simcard en estado desconocido " + 
						simcard.getIndicadorTelefono() + ", no es posible aprovicionar en red");
			}else if(simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))){
				codigoActuacionProceso = global.getValor("central.alta.prepago.vx");
				logger.debug("codigoActuacionProceso: "+codigoActuacionProceso);
			}else{			
				//codigoActuacionProceso = parametros.getCodigoActuacionDefecto().trim().equals(global.getValor("codigo.actuacion.prepago"))
				//				?global.getValor("central.alta.prepago.va"):parametros.getCodigoActuacionDefecto();
				codigoActuacionProceso = parametros.getCodigoActuacionDefecto().trim().equals(global.getValor("codigo.actuacion.prepago")) //INC 185192 JVA Soporte Ventas Se comenta ya que no existe el codigo de actuacion para la venta kit prepago 06-06-2012
								?global.getValor("central.alta.prepago.vx"):parametros.getCodigoActuacionDefecto();
				logger.debug("codigoActuacionProceso: "+codigoActuacionProceso);				
			}	
		//Fin P-CSR-11002 JLGN 14-06-2011
						
		if(parametros.getAbonado().getCodGrpPrestacion().trim().equals("TM") && 
				!parametros.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
		{
			simcard.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
			simcard.setIndicadorTelefono(parametrosGrales.getValorparametro());
			simcard = simcardBO.getIndicadorTelefono(simcard);		
			simcard.setIndProcEq(global.getValor("indicador.procedencia.equipo.simcard"));
			
			if (!planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()))
			{
				if (!simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.noprogramada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bodega.desactivada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.infobox"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.espera")))
				{
					throw new CustomerDomainException(
							"Linea " + parametros.getAbonado().getNumCelular() + "con simcard en estado desconocido " + 
							simcard.getIndicadorTelefono() + ", no es posible aprovicionar en red");
				}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada")))
				{
						if (parametros.getCodigoActuacionDefecto().equals(global.getValor("codigo.actuacion.venta")))
							codigoActuacionProceso = global.getValor("central.venta.oficina");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.terreno")))
							codigoActuacionProceso = global.getValor("central.venta.terreno");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.ctc")))
							codigoActuacionProceso = global.getValor("central.venta.ctc");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.ofic")))
							codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.ofic");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.terr")))
							codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.terr");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.renta.phone")))
							codigoActuacionProceso = global.getValor("central.alta.renta.phone");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.oficina");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");
				}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada")))
				{
						if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.oficina");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");
				}
					
			} else { 
				codigoActuacionProceso = global.getValor("codigo.actuacion.hibrido");
			}
			
		}else if(parametros.getAbonado().getCodGrpPrestacion().trim().equals("TM") && 
				parametros.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
		{
			simcard.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
			simcard.setIndicadorTelefono(parametrosGrales.getValorparametro());
			simcard = simcardBO.getIndicadorTelefono(simcard);		
			simcard.setIndProcEq(global.getValor("indicador.procedencia.equipo.simcard"));
			
			if (!planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()))
			{
				if (!simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.noprogramada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bodega.desactivada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.infobox"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada"))
				&& !simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.espera")))
				{
					throw new CustomerDomainException(
							"Linea " + parametros.getAbonado().getNumCelular() + "con simcard en estado desconocido " + 
							simcard.getIndicadorTelefono() + ", no es posible aprovicionar en red");
				}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.bloqueada")))
				{
						if (parametros.getCodigoActuacionDefecto().equals(global.getValor("codigo.actuacion.venta")))
							codigoActuacionProceso = global.getValor("central.venta.oficina");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.terreno")))
							codigoActuacionProceso = global.getValor("central.venta.terreno");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.ctc")))
							codigoActuacionProceso = global.getValor("central.venta.ctc");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.ofic")))
							codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.ofic");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.venta.cuenta.cont.terr")))
							codigoActuacionProceso = global.getValor("central.venta.cuenta.cont.terr");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.renta.phone")))
							codigoActuacionProceso = global.getValor("central.alta.renta.phone");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.oficina");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");
				}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.bloqueada").trim()))
				{
					//P-CSR-11002 JLGN 20-06-2011
					codigoActuacionProceso = global.getValor("central.alta.prepago.vx");
						/*if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.oficina")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.va");
						else if (parametros.getCodigoActuacionDefecto().equals(global.getValor("actuacion.alta.prepago.terreno")))
							codigoActuacionProceso = global.getValor("central.alta.prepago.terreno");*/
				}else if (simcard.getIndicadorTelefono().equals(global.getValor("indice.simcard.act.prepago.espera").trim()))
				{
					//codigoActuacionProceso = global.getValor("central.alta.prepago.va"); //INC 185192 JVA Soporte Ventas Se comenta ya que no existe el codigo de actuacion para la venta kit prepago 06-06-2012
					codigoActuacionProceso = global.getValor("central.alta.prepago.vx");
				}	
			} else 
				codigoActuacionProceso = global.getValor("codigo.actuacion.hibrido");
		}
		
		logger.debug("Codigo Actuacion proceso: "+ codigoActuacionProceso);
		
		/*Recupera código de actuación en centrales asociado al código de actuación de procesamiento*/
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoActuacionAbonado(codigoActuacionProceso);
		datosGrales.setCodigoProducto(global.getValor("codigo.producto"));
		datosGrales.setCodigoTecnologia(parametros.getAbonado().getCodTecnologia().trim());
		datosGrales = datosGeneralesBO.getActuacionCentral(datosGrales);
		codigoActuacionCentral = datosGrales.getCodigoActuacionCentral();
		logger.debug("codigo Actuacion Central: "+codigoActuacionCentral);
		
		if (codigoActuacionCentral ==null)
		{
			throw new CustomerDomainException(
					"Línea, " + parametros.getAbonado().getNumCelular() + "no es posible aprovicionar en red");
		}
		
		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();
		
		if(parametros.getAbonado().getCodGrpPrestacion().trim().equals("TM"))
		{
		
			/*Valida autenticación de Serie Simcard*/
			ProcesoDTO proceso = new ProcesoDTO();
			proceso = simcardBO.validaAutenticacionSerie(simcard);
			
			if (proceso.getCodigoError()==0){
				logger.debug("codigoAccion: " + proceso.getMensajeError().substring(1,3));
				//sIndAkeys = proceso.getMensajeError().substring(1,1);
				codigoAccion = proceso.getMensajeError().substring(1,3);
		        valorServicio = proceso.getMensajeError().substring(3,9);
		        logger.debug("valorServicio: " + proceso.getMensajeError().substring(3,9));
			}
			logger.debug("Codigo Accion" + codigoAccion);
			
			if (codigoAccion.equals(global.getValor("codigo.accion.uno")) 
					|| codigoAccion.equals(global.getValor("codigo.accion.tres")))
					intCentralDTO.setCodigoServicio(valorServicio);
			
			/*Valida código de acción devuelto en la autenticación de la serie*/			
			
			
			if (!codigoAccion.equals(global.getValor("codigo.accion.uno"))  
			&& !codigoAccion.equals(global.getValor("codigo.accion.dos")) 
			&& !codigoAccion.equals(global.getValor("codigo.accion.tres"))
			&& !codigoAccion.equals(global.getValor("codigo.accion.cuatro"))){
				
				throw new CustomerDomainException(
				"Ha ocurrido un error al momento de insertar movimiento en centrales");
	
			}
			else if (!codigoAccion.equals(global.getValor("codigo.accion.dos"))  
		             && parametros.getCodOperadora().equals(global.getValor("codigo.operadora.val.central")))
				throw new CustomerDomainException(
						"Ha ocurrido un error al momento de insertar movimiento en centrales");
			
		}
		
		
		/*Obtiene secuencia movimiento a centrales */
		//Inicio P-CSR-11002 JLGN 24-04-2011
		/*datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);*/		
		//intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
		logger.debug("Antes de Setear numMovimiento");
		intCentralDTO.setNumeroMovimiento(parametros.getNumMovimiento());		
		logger.debug("Despuesde Setear numMovimiento: "+ intCentralDTO.getNumeroMovimiento());
		 //FIn P-CSR-11002 JLGN 24-04-2011
		
		parametros.setNumeroMovtoAnterior(String.valueOf(intCentralDTO.getNumeroMovimiento()));
		intCentralDTO.setNumeroAbonado(parametros.getAbonado().getNumAbonado());
		intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("indicador.en.espera.centrales")));
		intCentralDTO.setCodActabo(codigoActuacionProceso);
		intCentralDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		intCentralDTO.setCodigoActuacion(codigoActuacionCentral);
		intCentralDTO.setCodigoUsuario(parametros.getCodigoUsuario());
		
		logger.debug("numMovimiento: "+intCentralDTO.getNumeroMovimiento());
		logger.debug("numAbonado: "+intCentralDTO.getNumeroAbonado());
		
		intCentralDTO.setFechaIngreso(new java.sql.Timestamp( System.currentTimeMillis()));
		intCentralDTO.setTipoTerminal(parametros.getAbonado().getTipTerminal());
		intCentralDTO.setCodigoCentral(parametros.getAbonado().getCodCentral());
		intCentralDTO.setNumeroCelular(parametros.getAbonado().getNumCelular());
		intCentralDTO.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());		
		intCentralDTO.setNumMin(parametros.getAbonado().getNumMin());
		
		CentralDTO central = new CentralDTO();
		central.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		central.setCodigoCentral(String.valueOf(parametros.getAbonado().getCodCentral()));
		central = centralBO.getCentral(central);
		intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());
		if(parametros.getAbonado().getCodGrpPrestacion().trim().equals("TM"))
		{
			simcard.setCodigoImsi(global.getValor("codigo.imsi"));
			simcard = simcardBO.getImsiSimcard(simcard);		
			intCentralDTO.setImsi(simcard.getValorImsi());
			intCentralDTO.setImei(parametros.getAbonado().getNumSerieTerminal());
			intCentralDTO.setIcc(parametros.getAbonado().getNumSerieSimcard());
		}
		
		if(planTarifario.getPlanComverse() != null)
		{
			intCentralDTO.setPlan(planTarifario.getPlanComverse());
		}else intCentralDTO.setPlan(planTarifario.getCodigoPlanTarifario());
		
		if(parametros.getAbonado().getCodGrpPrestacion().trim().equals("TM"))
		{
			if(simcard.getCarga() != null)
			{
				intCentralDTO.setCarga(simcard.getCarga());
			}else intCentralDTO.setCarga("0");
		}		
		
		if ( !(codigoActuacionProceso.trim().equals("HH")) && !(codigoActuacionProceso.trim().equals("AM")) && 
				!(codigoActuacionProceso.trim().equals("VA")) )
		{
		   intCentralDTO.setCarga(null);
		   intCentralDTO.setPlan(null);
		} 
		
		
		if(codigoActuacionProceso != null && ( codigoActuacionProceso.trim().equals("HH") || codigoActuacionProceso.trim().equals("AM") || 
				codigoActuacionProceso.trim().equals("VA")))
		{
			parametrosGrales = new ParametrosGeneralesDTO();
			parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGrales.setNombreparametro(global.getValor("parametro.categoria.cta.segura"));
			parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
			
			String sCuentaSegura = parametrosGrales.getValorparametro();
			parametrosGrales = new ParametrosGeneralesDTO();
			parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGrales.setNombreparametro(global.getValor("parametro.prorrateo.movimiento"));
			parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);			
			String sProrrateo = parametrosGrales.getValorparametro();
			
			PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
			planTarifarioDTO.setCodigoPlanTarifario(parametros.getAbonado().getCodPlanTarif());
			planTarifarioDTO = planTarifarioBO.getCategoriaPlanTarifario(planTarifarioDTO);
			
			ClienteDTO clienteDTO = new ClienteDTO();
			clienteDTO.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
			clienteDTO = clienteBO.getCliente(clienteDTO);
			
			//Si se cumple condición se realiza prorrateo, en caso contrario se mantieneel valor
			//del importe del plan y se le aplica los impuestos correspondientes
			if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido())
			&& !planTarifarioDTO.getCodigoCategoria().equals(sCuentaSegura)
			&& sProrrateo.equals(global.getValor("indicador.prorrateo"))){
				parametrosGrales = new ParametrosGeneralesDTO();
				parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GE"));
				parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
				parametrosGrales.setNombreparametro(global.getValor("parametro.formato.fecha1"));
				parametrosGrales=parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
				
				RegistroFacturacionDTO registroFacturacionDTO = new RegistroFacturacionDTO();
				registroFacturacionDTO.setCodigoCicloFacturacion(clienteDTO.getCodigoCiclo());
				registroFacturacionDTO.setFormatoFecha(parametrosGrales.getValorparametro());
				
				registroFacturacionDTO = registroFacturacionBO.getDiasProrrateo(registroFacturacionDTO);
				if (registroFacturacionDTO!=null){
					fImportePlan = (fImportePlan * registroFacturacionDTO.getDiasDiferencia()/ registroFacturacionDTO.getDiasProrrateo());
				}
				intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());
			}
			//intCentralDTO.setPlan(planTarifario.getPlanComverse()==null?planTarifario.getCodigoPlanTarifario():planTarifario.getPlanComverse());
			
			RegistroFacturacionDTO registroFacturacionDTO2 = new RegistroFacturacionDTO();
			registroFacturacionDTO2.setCodigoCliente(String.valueOf(parametros.getCodCliente().longValue()));
			registroFacturacionDTO2.setCodigoOficina(parametros.getCodOficina());
			Double  dValorImporteAux = new Double((fImportePlan*Math.pow(10,parametros.getNumDecimalBD()))/Math.pow(10,parametros.getNumDecimalBD()));
			fImportePlan =  dValorImporteAux.floatValue();
			registroFacturacionDTO2.setImportePlan(fImportePlan);			
			registroFacturacionDTO2 = registroFacturacionBO.aplicaImpuestoImporte(registroFacturacionDTO2);
			
			if (registroFacturacionDTO2!=null)
				fImportePlan = registroFacturacionDTO2.getImporteTotal();
			
			if (planTarifario.getCodigoTipoPlan().equals(parametros.getTipoPlanHibrido()))
			{
				intCentralDTO.setValorPlan(fImportePlan);
				//solo prepagos
				if(codigoActuacionProceso != null && ( codigoActuacionProceso.trim().equals("AM") || 
						codigoActuacionProceso.trim().equals("VA")))
				{
					SimcardDTO simcardDTO = new SimcardDTO();
					simcardDTO.setNumeroSerie(parametros.getAbonado().getNumSerieSimcard());
					simcardDTO = simcardBO.getSimcard(simcardDTO);
					intCentralDTO.setCarga(simcard.getCarga());
				}
			}			
		}else parametros.setTipoPlanHibrido("");
		
		interfazCentralBO.provisionaLinea(intCentralDTO);
		
		parametros.setCodTecnologia(parametros.getAbonado().getCodTecnologia().trim());
		parametros.setParametroCodigoSimcardGSM(parametros.getAbonado().getTipTerminal());
		parametros.setCodigoActuacion(codigoActuacionProceso);
		parametros.setPlan(intCentralDTO.getPlan());
		parametros.setValorPlan(intCentralDTO.getValorPlan());
		parametros.setCarga(intCentralDTO.getCarga());
		enviaMovtoSSCentrales(parametros);
		
		logger.debug("provisionandoLinea():fin");		
		return new Long(intCentralDTO.getNumeroMovimiento());
		
	}//fin provicionandoLinea

	/**
	 * Metodo que envia movimiento a centrales, relacionado a los servicios suplementarios
	 * @param datosVenta abonado
	 * @return void
	 * @throws CustomerDomainException, ProductDomainException,ResourceDomainException
	 */	
	private void enviaMovtoSSCentrales(GaVentasDTO datosVenta) 
		throws CustomerDomainException,ProductDomainException,ResourceDomainException 
	{		
		logger.debug("Inicio:enviaMovtoSSCentrales()");

		InterfazCentral interfazCentralBO = new InterfazCentral();
		InterfazCentralDTO intCentralDTO = new InterfazCentralDTO();
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		
		SimcardDTO simcard = new SimcardDTO();
		datosGrales = new DatosGeneralesDTO();

		String valorAuntentificacion = null;
        String numeroMin = null;
        String actuacionServSupl = null;
        String actuacionCentral = null;
        String actuacionCentralSS = null;
        String cadenaSS = null;
        String preactivacion = global.getValor("codigo.actuacion.preactivacion");
		
	    //-- VERIFICA SERVICIO 460001
        //---------------------------
		valorAuntentificacion = "0";
		ParametrosGeneralesDTO parametrosGrales = new ParametrosGeneralesDTO();
		parametrosGrales.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGrales.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGrales.setNombreparametro(global.getValor("parametro.ind.autentificacion"));
		parametrosGrales = parametrosGeneralesBO.getParametroGeneral(parametrosGrales);
		valorAuntentificacion = parametrosGrales.getValorparametro();	    	

		if (valorAuntentificacion==null) 
	    	valorAuntentificacion = "0";
	    	
	    //-- OBTIENE PREFIJO DEL NUM_MIN DE GA_ABOCEL
        //-------------------------------------------
	    numeroMin = datosVenta.getAbonado().getNumMin();

	    
	    if (numeroMin.equals(""))
	    	logger.debug("enviaMovtoSSCentrales: No existe Prefijo asociado al Abonado");
	    
	    //-- OBTIENE CODIGO ACTUACION SERVICIOS SUPLEMENTARIOS
        //----------------------------------------------------
	    actuacionServSupl = global.getValor("codigo.actuacion.servsupl");

	    //-- OBTIENE CODIGO ACTUACION CENTRAL PARA LA ACTUACION DEL ABONADO Y TECNOLOGIA
        //------------------------------------------------------------------------------
	    DatosGeneralesDTO datos = new DatosGeneralesDTO();
	    datos.setCodigoProducto(global.getValor("codigo.producto"));
	    datos.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
	    if( datosVenta.getTipoPlanHibrido()!= null && !datosVenta.getTipoPlanHibrido().trim().equals(""))
	    {
	    	//Verifica si es prepago o hibrido
	    	logger.debug("actuacionCentral la busca por HH");
	    	if(!datosVenta.getCodigoActuacion().trim().equals(global.getValor("actuacion.alta.prepago.oficina")) && 
	    			!datosVenta.getCodigoActuacion().trim().equals(global.getValor("central.alta.prepago.va")))
	    	{
	    		preactivacion = global.getValor("codigo.actuacion.preactivacion.hibrido");
	    		datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.hibrido"));
	    	}else{
	    		//datos.setCodigoActuacionAbonado(global.getValor("central.alta.prepago.va")); INC 185192 JVA Soporte Ventas Se comenta ya que no existe el codigo de actuacion para la venta kit prepago 06-06-2012
	    		datos.setCodigoActuacionAbonado(global.getValor("central.alta.prepago.vx"));
	    	}
	    }else {
	    	//Contrato
	    	logger.debug("actuacionCentral: " + actuacionCentral);	
	    	datos.setCodigoActuacionAbonado(datosVenta.getCodigoActuacionDefecto()); //release II
	    }
	    datos = datosGeneralesBO.getActuacionCentral(datos);
	    actuacionCentral = datos.getCodigoActuacionCentral();
	    logger.debug("actuacionCentral: " + actuacionCentral);
	    
	    datos = new DatosGeneralesDTO();
	    datos.setCodigoProducto(global.getValor("codigo.producto"));
	    datos.setCodigoTecnologia(datosVenta.getCodTecnologia());
	    datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.servsupl"));
	    datos = datosGeneralesBO.getActuacionCentral(datos);
	    actuacionCentralSS = datos.getCodigoActuacionCentral();
	    logger.debug("actuacionCentralSS: " + actuacionCentralSS);
	    
	    //-- OBTIENE SERVICIOS SUPLEMENTARIOS PARA ENVIAR A CENTRALES 
        //-----------------------------------------------------------
	    ServicioSuplementarioDTO entradaServSupl = new ServicioSuplementarioDTO();
		entradaServSupl.setNumeroAbonado(String.valueOf(datosVenta.getAbonado().getNumAbonado()));
		entradaServSupl.setIndicadorEstado(Integer.parseInt(global.getValor("codigo.estado.alta_bd")));
		
		entradaServSupl.setCodigoProducto(global.getValor("codigo.producto"));
		entradaServSupl.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		entradaServSupl.setCodigoSistema(Integer.parseInt(global.getValor("codigo.sistema")));
		entradaServSupl.setCodigoActuacion(actuacionCentral);
		entradaServSupl.setTipoTerminal(datosVenta.getAbonado().getTipTerminal());
		
		ServicioSuplementarioDTO[] listaServiciosSuplemantarios = servicioSuplementarioBO.getSSAbonadoParaCentrales(entradaServSupl);
		cadenaSS ="";
		for(int j=0;j<listaServiciosSuplemantarios.length;j++)
		{
			if ((listaServiciosSuplemantarios[j].getCodigoServSupl().equals("46")) && (Integer.parseInt(valorAuntentificacion) > 0)){
				//-- no se incluye, porque no fue seleccionado por el usuario, es por default. 
			}
			else{
				String s1 = completarString(listaServiciosSuplemantarios[j].getCodigoServSupl(),2,"0","I");
				String s2 = completarString(listaServiciosSuplemantarios[j].getCodigoNivel(),4,"0","I");
                cadenaSS = cadenaSS + s1 + s2;
			}
		}
		
		//Se asignan estos datos independiente si hay o no ss asociados
		intCentralDTO.setNumeroAbonado(datosVenta.getAbonado().getNumAbonado());
		intCentralDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		intCentralDTO.setCodigoUsuario(datosVenta.getCodigoUsuario());
		intCentralDTO.setFechaIngreso(new java.sql.Timestamp( System.currentTimeMillis()));
		intCentralDTO.setTipoTerminal(datosVenta.getParametroCodigoSimcardGSM());
		intCentralDTO.setNumeroCelular(datosVenta.getAbonado().getNumCelular());
		intCentralDTO.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());			
		intCentralDTO.setNumMin(datosVenta.getAbonado().getNumMin());
		intCentralDTO.setNumFax(datosVenta.getAbonado().getNumFax());
		
		CentralDTO central = new CentralDTO();
		central.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		central.setCodigoCentral(String.valueOf(datosVenta.getAbonado().getCodCentral()));
		central = centralBO.getCentral(central);
		intCentralDTO.setTipoTecnologia(central.getCodigoTecnologia());
		
		simcard.setNumeroSerie(datosVenta.getAbonado().getNumSerieSimcard());
		simcard.setCodigoImsi(global.getValor("codigo.imsi"));
		simcard = simcardBO.getImsiSimcard(simcard);
		intCentralDTO.setImsi(simcard.getValorImsi());
		intCentralDTO.setImei(datosVenta.getAbonado().getNumSerieTerminal());
		intCentralDTO.setIcc(datosVenta.getAbonado().getNumSerieSimcard());
		
		intCentralDTO.setCodigoCentral(datosVenta.getAbonado().getCodCentral());
		intCentralDTO.setCodigoServicio(cadenaSS);
		
		
		//Se saca la condicion de la tecnologia ya que para movil tampoco debe insertar cuando no hay cadenaSS
		if (cadenaSS.equals("") )
		//if (datosVenta.getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.FIJO")) && cadenaSS.equals("") )
		{
			logger.debug("enviaMovtoSSCentrales: NO Inserta SS Tecnologia FIJA y no hay SS Adicionales ...");
		}else	{
			logger.debug("enviaMovtoSSCentrales: Insertando movimiento..." + datosVenta.getServSuplAdicionales());		   	
		   	//-- SERVICIOS SUPLEMENTARIOS ADICIONALES /wjrc - inicio		   	
		   	ServicioSuplementarioDTO servSuplAdicionales = new ServicioSuplementarioDTO();
		   	if (datosVenta.getServSuplAdicionales() == null || datosVenta.getServSuplAdicionales().trim().equals("") )
				logger.debug("enviaMovtoSSCentrales: No hay servicios suplementarios adicionales...");
		   	else{		   				   		
		   		servSuplAdicionales.setNumeroAbonado(String.valueOf(datosVenta.getAbonado().getNumAbonado()));		   		
		   		servSuplAdicionales.setCadenaCodServs(datosVenta.getServSuplAdicionales());		   			   		
		   		servSuplAdicionales.setNumeroTerminal(String.valueOf(datosVenta.getAbonado().getNumCelular()));
		   		servSuplAdicionales.setNomUsuario(datosVenta.getCodigoUsuario());
		   		servSuplAdicionales = servicioSuplementarioBO.insSSAdicionales(servSuplAdicionales);
		   		
		   		//-- AGREGAMOS SERV. SUPL. ADICIONALES
		   		if (servSuplAdicionales!=null && servSuplAdicionales.getCadenaServNivel()!=null ){
		   			cadenaSS = cadenaSS + servSuplAdicionales.getCadenaServNivel();
		   		}
		   		logger.debug("enviaMovtoSSCentrales: Se agregan servicios suplementarios adicionales...");
		   	}
		   	
		   	//-- SERVICIOS SUPLEMENTARIOS ADICIONALES /wjrc - fin
		   	
			//-- INSERTA MOVIMIENTO PARA CENTRALES
	        //------------------------------------
		   	//Inicio P-CSR-11002 JLGN 22-06-2011
		   	
		   	//Las llamadas pueden salir preactivadas por lo que es necesario insertar un nuevo movimiento en centrales
			//Este movimiento no debe ser insertado cuando corresponde a grupo prestacion SMS broadcast / Cobro Revertido
			//ZP --> pospagos
			//ZH --> hibridos
			
			if(!datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.SMS")) &&
			   !datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.CREVERTIDO")) && 
			   !datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.WIMAX")) )
			{
			
				if (!datosVenta.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")) 
						&& (datosVenta.getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM")) ||  
						datosVenta.getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.CDMA"))))
				{
					datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
					datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
					intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());		
					intCentralDTO.setCodActabo(preactivacion);
					intCentralDTO.setNumFax(0);
					intCentralDTO.setNumeroMovtoAnterior("");
					//intCentralDTO.setCodigoServicio("");	P-CSR-11002 JLGN 21-07-2011
					intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("indicador.en.espera.centrales")));
					
					datos = new DatosGeneralesDTO();
				    datos.setCodigoProducto(global.getValor("codigo.producto"));
				    datos.setCodigoTecnologia(datosVenta.getCodTecnologia());		    
				    if(preactivacion.trim().equals(global.getValor("codigo.actuacion.preactivacion.hibrido"))) 
				    {
				    	datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.preactivacion.hibrido"));
				    	intCentralDTO.setPlan(datosVenta.getPlan());	 
				    	intCentralDTO.setValorPlan(datosVenta.getValorPlan());
				    	intCentralDTO.setCarga(datosVenta.getCarga());
				    }else {
				    	datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.preactivacion"));
				    }
				    datos = datosGeneralesBO.getActuacionCentral(datos);
				    String actuacionCentralZP = datos.getCodigoActuacionCentral();
				    logger.debug("actuacionCentralZP: " + actuacionCentralZP);
				    intCentralDTO.setCodigoActuacion(actuacionCentralZP);			 
					interfazCentralBO.provisionaLinea(intCentralDTO);
				}		
			}
			//Fin P-CSR-11002 JLGN 22-06-2011		   	
		   	
			/*Obtiene secuencia movimiento a centrales */
			datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
			datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
	
			intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());
			intCentralDTO.setNumeroMovtoAnterior(datosVenta.getNumeroMovtoAnterior());			
			intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("indicador.en.espera.centrales")));
			intCentralDTO.setCodActabo(actuacionServSupl);			
			intCentralDTO.setCodigoActuacion(actuacionCentralSS);
			
					
			interfazCentralBO.provisionaLinea(intCentralDTO);	    
	
			//-- Actualiza clase servicio del abonado 
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumAbonado(datosVenta.getAbonado().getNumAbonado());		
					
			//Completa la cadena de clase servicio con los SS no enviados a centrales
			ServicioSuplementarioDTO[] servicioSuplementarioDTOs = servicioSuplementarioBO.getSSAbonadoNoCentrales(entradaServSupl);
			for(int j=0;j<servicioSuplementarioDTOs.length;j++)
				
			{   
				// Antes de unir las cadenas verificar si hay dos repetidos en las dos listas 
				// se debe de eliminar uno de acuerdo a una logica por determinar
				cadenaSS = cadenaSS + servicioSuplementarioDTOs[j].getCadSSNivel();
			}
			if (  servSuplAdicionales!=null && 
				  servSuplAdicionales.getCadenaServNivel()!=null && 
				  !servSuplAdicionales.getCadenaServNivel().trim().equals("")){
				  cadenaSS = reemplazoGrupoSSIgual(cadenaSS,servSuplAdicionales.getCadenaServNivel());
			}		
		
			abonado.setClaseServicio(cadenaSS);
			abonadoBO.updAbonadoClaseServ(abonado);
		}
		/* P-CSR-11002 JLGN  22-06-2011
		//Las llamadas pueden salir preactivadas por lo que es necesario insertar un nuevo movimiento en centrales
		//Este movimiento no debe ser insertado cuando corresponde a grupo prestacion SMS broadcast / Cobro Revertido
		//ZP --> pospagos
		//ZH --> hibridos
		
		if(!datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.SMS")) &&
		   !datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.CREVERTIDO")) && 
		   !datosVenta.getAbonado().getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.WIMAX")) )
		{
		
			if (!datosVenta.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")) 
					&& (datosVenta.getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM")) ||  
					datosVenta.getCodTecnologia().trim().equals(global.getValor("codigo.tecnologia.CDMA"))))
			{
				datosGrales.setCodigoSecuencia(global.getValor("secuencia.movimiento.central"));
				datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
				intCentralDTO.setNumeroMovimiento(datosGrales.getSecuencia());		
				intCentralDTO.setCodActabo(preactivacion);
				intCentralDTO.setNumFax(0);
				intCentralDTO.setNumeroMovtoAnterior("");
				intCentralDTO.setCodigoServicio("");	
				intCentralDTO.setCodigoEstado(Integer.parseInt(global.getValor("indicador.en.espera.centrales")));
				
				datos = new DatosGeneralesDTO();
			    datos.setCodigoProducto(global.getValor("codigo.producto"));
			    datos.setCodigoTecnologia(datosVenta.getCodTecnologia());		    
			    if(preactivacion.trim().equals(global.getValor("codigo.actuacion.preactivacion.hibrido"))) 
			    {
			    	datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.preactivacion.hibrido"));
			    	intCentralDTO.setPlan(datosVenta.getPlan());	 
			    	intCentralDTO.setValorPlan(datosVenta.getValorPlan());
			    	intCentralDTO.setCarga(datosVenta.getCarga());
			    }else {
			    	datos.setCodigoActuacionAbonado(global.getValor("codigo.actuacion.preactivacion"));
			    }
			    datos = datosGeneralesBO.getActuacionCentral(datos);
			    String actuacionCentralZP = datos.getCodigoActuacionCentral();
			    logger.debug("actuacionCentralZP: " + actuacionCentralZP);
			    intCentralDTO.setCodigoActuacion(actuacionCentralZP);			 
				interfazCentralBO.provisionaLinea(intCentralDTO);
			}		
		}*/
		
		logger.debug("Fin:enviaMovtoSSCentrales()");
	}//fin enviaMovtoSSCentrales 
	
    // El que viene por teclado (cadenaIn) prevalece si es que hay un elemento igual en la union
	public String reemplazoGrupoSSIgual(String cadenaUnion,String cadenaIn) {
		List listaUnion = new ArrayList();
		for (int m=0; m < cadenaUnion.length(); m=m+6 )	listaUnion.add( cadenaUnion.substring(m,m+6));

		for (int m=0; m < cadenaIn.length(); m=m+6 ){
			String elemIn =  cadenaIn.substring(m,m+6);
			for (Iterator it = listaUnion.iterator(); it.hasNext(); ) {
				String elem = (String) it.next();
				if (elem.substring(0,3).equals(elemIn.substring(0,3)) ) it.remove();
			}
			listaUnion.add(elemIn);
        }  

		String cadRetorno = listaUnion.toString().substring(1,listaUnion.toString().length()-1).replaceAll(",","").replaceAll("\\s","");
		return cadRetorno;
	}
	
	/**
	 * Metodo que completa un string con un caracter especifico.
	 * @param stringEntrada: string inicial
	 *        largoMaximoString : largo final del string de salida
	 *        caracter : caracter que sera de relleno
	 *        direccion : I (completar a la izquierda) D (completar a la derecha)
	 * @return String
	 * @throws CustomerDomainException, ProductDomainException
	 */	
	private String completarString(String stringEntrada,int largoMaximoString,String caracter,String direccion)
	{
		String stringFinal = null;
		int diferencia;
		
		stringFinal = stringEntrada;
		diferencia = largoMaximoString - stringEntrada.length();
		
		if (direccion.equals("I")){
		// completar a la izquierda
			for (int i=1;i<=diferencia;i++)
				stringFinal = caracter + stringFinal;
		}
		else{
		// completar a la derecha
			for (int d=1;d<=diferencia;d++)
				stringFinal = stringFinal + caracter;
		}
		return stringFinal;
	}//fin completarString

	
	private ConfiguradorTareaPreliquidacionDTO parametrosPreliquidacion(ParametrosRegistroCargosDTO parametrosCargos) 
	{
		ConfiguradorTareaPreliquidacionDTO configuradorTareas = new ConfiguradorTareaPreliquidacionDTO();
		configuradorTareas.setNumeroVenta(parametrosCargos.getNumeroVenta());
		configuradorTareas.setCodigoCliente(parametrosCargos.getCodigoCliente());
		configuradorTareas.setModalidadVenta(parametrosCargos.getModalidadVenta());
		configuradorTareas.setCodigoVendedor(parametrosCargos.getCodigoVendedor());
		configuradorTareas.setCodigoVendedorRaiz(parametrosCargos.getCodigoVendedorRaiz());
		configuradorTareas.setArrayCargos(parametrosCargos.getCargos());
		configuradorTareas.setDatosPrograma(parametrosCargos.getDatosPrograma());
		return configuradorTareas;
	}
	
	/**
	 * Obtiene nuevo numero de contrato
	 * @param 
	 * @return contrato
	 * @throws CustomerDomainException
	 */	
	
	public ContratoDTO obtenerContratoNuevo() 
		throws CustomerDomainException
	{	
		logger.debug("Inicio:obtenerContratoNuevo");
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoSecuencia(global.getValor("secuencia.contrato"));
		datosGenerales  = datosGeneralesBO.getSecuencia(datosGenerales);		
		String numeroContrato = Formatting.number(datosGenerales.getSecuencia(),global.getValor("formato.numero.contrato"));		
		ContratoDTO contrato = new ContratoDTO();
		Calendar hoy = Calendar.getInstance();
		String ano = Formatting.dateTime(hoy,"yy");		
		numeroContrato = global.getValor("prefijo.numero.contrato") + "-" + numeroContrato + "-" + ano +  "-" +  global.getValor("sufijo.numero.contrato");		
		contrato.setNumeroContrato(numeroContrato);
		logger.debug("Numero de contrato: " + numeroContrato);
		logger.debug("Fin:obtenerContratoNuevo");
		return contrato;		
	}
	
	/**
	 * Implementa caso de uso procesosPreCierre
	 * @param parametros
	 * @return contrato
	 * @throws CustomerDomainException
	 */	
	
	public GaVentasDTO procesosPreCierre(GaVentasDTO parametros) 
		throws CustomerDomainException,ProductDomainException
	{
		logger.debug("Inicio:procesosPreCierre");
		RegistroVentaDTO regVenta = new RegistroVentaDTO();
		regVenta.setNumeroVenta(parametros.getNumVenta().longValue());
		RegistroEvaluacionRiesgoDTO registroEval = new RegistroEvaluacionRiesgoDTO();
		ClienteDTO cliente = new ClienteDTO();
		cliente.setNumeroIdentificacion(parametros.getNumIdentCliente());
		cliente.setCodigoTipoIdentificacion(parametros.getTipIdentCliente());
		cliente.setTipoCliente(parametros.getTipoCliente());
		registroEval.setCliente(cliente);
		registroEval.setTipoSolicitud(global.getValor("tipo.solicitud"));
		registroEval.setIndicadorEvento(global.getValor("indicador.evento"));
		registroEval.setEstadosVigentes(global.getValor("estado.vigente.evaluacionriesgo"));
		AbonadoDTO[] listaAbonados = getListaAbonadosVenta(regVenta);
		ContratoDTO contrato = new ContratoDTO();
		cliente.setCodigoCliente(String.valueOf(parametros.getCodCliente()));
		cliente = clienteBO.getCliente(cliente);
		contrato.setCodigoCuenta(cliente.getCodigoCuenta());
		contrato.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));
		contrato.setCodigoTipoContrato(parametros.getCodTipContrato());
		contrato.setIndComodato(parametros.getIndComodato());
		contrato.setNumeroContrato(parametros.getNumContrato());
		contrato.setNumeroMeses(parametros.getNumeroMesesContrato());
		contrato.setNumeroVenta(parametros.getNumVenta().longValue());		
		int iNumAnexo;
		if (parametros.getIndicadorContratoNuevo() == 1)
			iNumAnexo=1;
		     
		else{
			contrato = contratoBO.getMaxAnexoContrato(contrato);
			iNumAnexo = Integer.parseInt(contrato.getNumeroAnexo())+1;
		}	
		for(int i=0;i<listaAbonados.length;i++)
		{
			listaAbonados[i].setMontoGarantia(registroEval.getMontoGarantia());
			listaAbonados[i].setNumVenta(parametros.getNumVenta().longValue());
			/*----(1) Almacena la garantia asociada a cada uno de los abonados de la venta----*/
			
			try{
				if (registroEval.getMontoGarantia()>0)
					abonadoBO.insertaGarantiaAbonado(listaAbonados[i]);
			}catch(CustomerDomainException e){
				logger.debug("Ocurrio un error al registrar la garantia");
			}
			
			
			/*----(2) realiza alta de contrato----*/
			if(!cliente.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
			{
				contrato.setNumeroAbonados(1);			
				String iNumeroAnexo = Formatting.number(iNumAnexo,global.getValor("formato.numero.anexo"));			
				contrato.setNumeroAnexo(contrato.getNumeroContrato().substring(0,16) + iNumeroAnexo);
				logger.debug("VentasSrv.procesosPreCierre:antes");			
				contratoBO.altaContrato(contrato);
				logger.debug("VentasSrv.procesosPreCierre:despues");
				iNumAnexo++;
			}
			//-- SALIDA DE SIMCARD Y EQUIPOS
			/* Esto se hace en la formalizacion de la venta **/
		}
		
		logger.debug("Fin:procesosPreCierre");
		return parametros;
	}//fin procesosPreCierre
	
	public void creaVenta(GaVentasDTO gaVentasDTO) 
		throws CustomerDomainException,ProductDomainException 
	{
		logger.debug("creaVenta():start");
		MatrizEstadosDTO matrizEstadosDTO=new MatrizEstadosDTO();
		ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();
		
		gaVentasDTO.setCodProducto(new Long (global.getValor("codigo.producto")));
		
		//relsease II
		gaVentasDTO.setIndOfiter(gaVentasDTO.getIndOfiter());
		gaVentasDTO.setIndChkDicom(global.getValor("indicador.ind_chkdicom"));
		gaVentasDTO.setIndVenta(global.getValor("venta.indicador.venta"));
		gaVentasDTO.setNumConsulta(null);
		gaVentasDTO.setTipFoliacion(global.getValor("parametro.tip_foliacion"));					
    	gaVentasDTO.setNumUnidades(new Long(registroVentaBO.getNumUnidades(gaVentasDTO.getNumVenta().toString())));
    	
    	gaVentasDTO.setFecVenta(new java.sql.Timestamp(System.currentTimeMillis()));  
    	
    	matrizEstadosDTO.setCodPrograma(gaVentasDTO.getDatosPrograma().getCodigoPrograma());//evaluar de donde obtener el parametro
    	
    	//release II
    	matrizEstadosDTO.setIndOfiter(gaVentasDTO.getIndOfiter());
    	matrizEstadosDTO.setFecVenta(new java.sql.Date(System.currentTimeMillis()));
    	matrizEstadosDTO.setCodProceso(registroVentaBO.getCodProcesoVenta(matrizEstadosDTO));
    	matrizEstadosDTO.setCodEstadoDestino(registroVentaBO.getCodEstadoFinalVenta(matrizEstadosDTO));
    	gaVentasDTO.setIndPasoCob(new Long (global.getValor("indicador.paso.cobro")));
    	
    	if(gaVentasDTO.getCodTipoSolicitud().trim().equals(global.getValor("codigo.solicitud.fisica")) || 
    	   gaVentasDTO.getCodTipoSolicitud().trim().equals(global.getValor("codigo.solicitud.online")) ||
    	   gaVentasDTO.getCodTipoSolicitud().trim().equals(global.getValor("codigo.solicitud.scoring")) )
		{
			gaVentasDTO.setIndEstVenta(global.getValor("indicador.ind_estadoventa.nuevo"));
		}else {
			gaVentasDTO.setIndEstVenta(global.getValor("indicador.ind_estadoventa.evaluacion"));
		}	
		
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametros.cod_Moneda"));
		parametrosGeneralesDTO=parametrosGeneralesBO.getParametroFacturacion(parametrosGeneralesDTO);
		gaVentasDTO.setCodMoneda(parametrosGeneralesDTO.getValorparametro());
		//determinar codPlaza
		if (gaVentasDTO.isAciclo()){
			gaVentasDTO.setCodPlaza(registroVentaBO.getCodPlazaCliente(gaVentasDTO.getCodCliente()).toString());
		}
		else{
			gaVentasDTO.setCodPlaza(registroVentaBO.getCodPlazaOficina(gaVentasDTO.getCodOficina()));
		}		
		registroVentaBO.insertVenta(gaVentasDTO);			
		logger.debug("creaVenta():end");
	}
	
	/**
	 * Registra una solicitud de aprobación de descuento en SCL
	 * @param registroSolicitudesDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	
	public RegistroSolicitudesDTO solicitarAprobaciones(RegistroSolicitudesDTO[] registroSolicitudesDTO) 
		throws CustomerDomainException 
	{
		logger.debug("solicitarAprobaciones():start");
		RegistroSolicitudesDTO resultado = new RegistroSolicitudesDTO();
		String sEstadoSolicitud = global.getValor("estado.solicitud.pendiente");
		long lNumeroAutorizacion;
		String sCodigoMonedaSolicitud  = global.getValor("codigo.moneda.solicitud");
		long lNumAbonado = 0;
		int iIndicadorModificacion = Integer.parseInt(global.getValor("indicador.modificacion.descuento"));
		String sCodigoOrigen = global.getValor("codigo.origen");
		DatosGeneralesDTO datosGrales = new DatosGeneralesDTO();
		datosGrales.setCodigoSecuencia(global.getValor("secuencia.solicitud.autorizacion"));
		datosGrales = datosGeneralesBO.getSecuencia(datosGrales);
		lNumeroAutorizacion = datosGrales.getSecuencia();
		RegistroSolicitudes registroSolicitudesBO = new RegistroSolicitudes();
		for (int i=0; i<registroSolicitudesDTO.length;i++){
			registroSolicitudesDTO[i].setLinAutoriza(i+1);
			registroSolicitudesDTO[i].setCodigoEstado(sEstadoSolicitud);
			registroSolicitudesDTO[i].setNumeroAutorizacion(lNumeroAutorizacion);
			registroSolicitudesDTO[i].setCodigoMoneda(sCodigoMonedaSolicitud);
			registroSolicitudesDTO[i].setNumeroAbonado(lNumAbonado);
			registroSolicitudesDTO[i].setIndicadorModificacion(iIndicadorModificacion);
			registroSolicitudesDTO[i].setCodigoOrigen(sCodigoOrigen);
			registroSolicitudesBO.crearSolicitud(registroSolicitudesDTO[i]);
			
		}
		resultado.setNumeroAutorizacion(lNumeroAutorizacion);
		resultado.setCodigoEstado(sEstadoSolicitud);
		logger.debug("solicitarAprobaciones():end");
		return resultado;
	}
	
	public RegistroSolicitudesDTO consultaEstadoSolicitud(RegistroSolicitudesDTO registroSolicitudesDTO) 
		throws CustomerDomainException 
	{
		RegistroSolicitudes registroSolicitudesBO = new RegistroSolicitudes();
		logger.debug("consultaEstadoSolicitud():start");
		registroSolicitudesDTO = registroSolicitudesBO.consultaEstadoSolicitud(registroSolicitudesDTO);
		if (registroSolicitudesDTO.getCodigoEstado().equals(global.getValor("estado.solicitud.pendiente")))
			registroSolicitudesDTO.setDescripcionEstado(global.getValor("desc.estado.solicitud.PD"));
		else if (registroSolicitudesDTO.getCodigoEstado().equals(global.getValor("estado.solicitud.autorizada")))
			registroSolicitudesDTO.setDescripcionEstado(global.getValor("desc.estado.solicitud.AU"));
		else if (registroSolicitudesDTO.getCodigoEstado().equals(global.getValor("estado.solicitud.cancelada")))
			registroSolicitudesDTO.setDescripcionEstado(global.getValor("desc.estado.solicitud.CA"));
		logger.debug("consultaEstadoSolicitud():end");
		return registroSolicitudesDTO;
	}
	
	public InformePresupuestoDTO obtenerInformePresupuesto(InformePresupuestoDTO objetoEntradaDTO)
		throws CustomerDomainException,ProductDomainException 
	{
		logger.debug("obtenerInformePresupuesto():start");
		RegistroFacturacion registroFacturacionBO = new RegistroFacturacion();
		InformePresupuestoDTO informePresupuestoDTO = new InformePresupuestoDTO();
		
		/*Obtiene datos de la modalidad de pago*/
		ModalidadPagoDTO modalidadPagoDTO = new ModalidadPagoDTO();
		modalidadPagoDTO.setCodigoModalidadPago(objetoEntradaDTO.getCodigoModalidadVenta());
		modalidadPagoDTO = getModalidadPago(modalidadPagoDTO);
		informePresupuestoDTO.setDescripcionModalidadVenta(modalidadPagoDTO.getDescripcionModalidadPago());
		
		/*Obtiene datos del tipo de contrato*/
		ContratoDTO contratoDTO = new ContratoDTO();
		contratoDTO.setCodigoTipoContrato(objetoEntradaDTO.getCodigoTipoContrato());
		contratoDTO = getTipoContrato(contratoDTO);
		informePresupuestoDTO.setDescripcionTipoContrato(contratoDTO.getDescripcionTipoContrato());
		
		/*Obtiene datos del documento de cobro*/
		DatosComercialesDTO datosComercialesDTO = new DatosComercialesDTO();
		datosComercialesDTO.setCodigoCliente(objetoEntradaDTO.getCodigoCliente());
		DocumentoDTO documentoDTO = getListadoTipoDocumento(datosComercialesDTO);
		informePresupuestoDTO.setDescripcionTipoDocumento(documentoDTO.getDescripcion());
		
		/*Obtiene detalle de cargos */ 
		DetalleInformePresupuestoDTO[] detalle = registroFacturacionBO.obtenerDetallePresupuesto(new Long(objetoEntradaDTO.getNumeroVenta()));
		informePresupuestoDTO.setDetalle(detalle);
		
		logger.debug("obtenerInformePresupuesto():end");
		return informePresupuestoDTO;
		
	}
	
	public IdentificadorCivilDTO[] getListadoIdentificadorCivil() 
		throws CustomerDomainException 
	{
		logger.debug("getListadoIdentificadorCivil():start");
		IdentificadorCivilDTO[] arrayIdentCivil = null;
		IdentificadorCivil identificadorCivilBO = new IdentificadorCivil(); 
		arrayIdentCivil = identificadorCivilBO.getListTiposIdentif();
		logger.debug("getListadoIdentificadorCivil():fin");
		return arrayIdentCivil;
	}
	
	public CuentaDTO[] getListadoCuentas(CuentaDTO criterioBusquedaCuenta) 
		throws CustomerDomainException 
	{
		logger.debug("getListadoCuentas():start");
		CuentaDTO[] arrayCuentas = null;
		Cuenta cuentaBO = new Cuenta(); 
		arrayCuentas = cuentaBO.getListadoCuenta(criterioBusquedaCuenta);
		logger.debug("getListadoCuentas():fin");
		return arrayCuentas;
	}
	
	/**
	 * Valida si el cliente es agente comercial, si es asi no se puede realizar la venta de linea
	 * @param registroSolicitudesDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */	
	
	public ResultadoValidacionVentaDTO clienteAgenteComercial(ParametrosValidacionVentasDTO parametrosValidacionVentasDTO)
		throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultadoValidacionVentaDTO = null;
		logger.debug("Inicio:clienteAgenteComercial()");
		
		// ( 17 ) Verifica si cliente es agente comercial					
		resultadoValidacionVentaDTO = clienteBO.clienteAgenteComercial(parametrosValidacionVentasDTO);
		if (resultadoValidacionVentaDTO.isResultado()){
			resultadoValidacionVentaDTO.setEstado("NOK");
			resultadoValidacionVentaDTO.setDetalleEstado("Cliente es agente comercial");
			return resultadoValidacionVentaDTO;
		}
		logger.debug("Fin:clienteAgenteComercial()");
		return resultadoValidacionVentaDTO;
	}
	
	/**
	 * Busca si existe excepción asociada al cliente.
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO getExcepcion(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getExcepcion()");
		RegistroEvaluacionRiesgoDTO resultado = null;
		resultado = registroEvaluacionRiesgoBO.existeExcepcion(registroEvaluacionRiesgoDTO);
		logger.debug("Fin:getExcepcion()");
		return resultado;
	}
	
	/**
	 * Busca evaluación de riesgo vigente del cliente.
	 * 
	 * @author Héctor Hermosilla
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getEvaluacionRiesgoVigenteCliente()");
		RegistroEvaluacionRiesgoDTO resultado = null;
		registroEvaluacionRiesgoDTO.setTipoSolicitud(global.getValor("tipo.solicitud"));
		resultado = registroEvaluacionRiesgoBO.getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO);
		logger.debug("Fin:getEvaluacionRiesgoVigenteCliente()");
		return resultado;
	}
	
	/**
	 * Obtiene campaña vigente
	 * @param entrada
	 * @return 
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("getCampanaVigente():start");
		CampanaVigenteDTO resultado = null;
		campanaBO.getCampanaVigente(entrada);
		logger.debug("getCampanaVigente():end");
		return resultado;		
	}//fin getCampanaVigente

	/**
	 * Registra campaña vigente
	 * @param entrada
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("registraCampanaVigente():start");
	    campanaBO.registraCampanaVigente(entrada);
		logger.debug("registraCampanaVigente():end");
	}//fin registraCampanaVigente
	 	
	//Inicio COL-07011 IGO
	/**
	 * Listado de articulos
	 * @param 
	 * @return ArticuloOutDTO 
	 * @throws CustomerDomainException
	 */
	public ArticuloOutDTO[] getListadoArticulos(ArticuloInDTO articulo) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getListadoArticulo()");
		ArticuloOutDTO[] resultado;
		Articulo articuloBO = new Articulo();
		resultado = articuloBO.getListadoArticulos(articulo); 
		logger.debug("Fin:getListadoArticulo()");
		return resultado;
	}	
	/**
	 * Obtiene listado de servicios suplementarios
	 * @param ServicioSuplementarioDTO
	 * @return ServicioSuplementarioDTO[]
	 * @throws CustomerDomainException
	 */
	public ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getListadoSS()");
		ListadoSSOutDTO[] resultado;
		resultado = servicioSuplementarioBO.getListadoSS(entrada); 
		logger.debug("Fin:getListadoSS()");
		return resultado;
	}
//	Fin COL-07011 IGO
	
	/**
	 * Obtiene campaña Vigente por defecto
	 * @param CampanaVigenteDTO
	 * @return CampanaVigenteDTO
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigenteDefault(CampanaVigenteCOLDTO entrada)
		throws CustomerDomainException
	{
		CampanaVigenteDTO resultado = new CampanaVigenteDTO();						
		logger.debug("Inicio:getCampanaVigenteDefault()");			
		resultado = campanaVigenteBO.getCampanaVigenteDefault(entrada); 
		logger.debug("Fin:getCampanaVigenteDefault()");
		return resultado;
	}	
	
	/**
	 * Obtiene GrupoCobroServicio por defecto
	 * @param CampanaVigenteDTO
	 * @return CampanaVigenteDTO
	 * @throws CustomerDomainException
	 */
	public GrupoCobroServicioDTO getGrupoCobroServicioDefault(Long entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getGrupoCobroServicioDefault()");
		GrupoCobroServicioDTO resultado = new GrupoCobroServicioDTO();
		resultado = grupoCobroBO.getGrupoCobroServicioDefault(entrada); 
		logger.debug("Fin:getGrupoCobroServicioDefault()");
		return resultado;
	}
	
	/** Servicios Activaciones WEB - Colombia
	 * Obtine planes tarifarios
	 * @param PlanTarifarioDTO (entrada)
	 * @return PlanTarifarioDTO (entrada)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */		
	public PlanTarifarioDTO[] getListPlanTarif(PlanTarifarioDTO entrada) 
	throws ProductDomainException 
	{
		logger.debug("getListPlanTarif():start");
		PlanTarifarioDTO[] resultado = planTarifarioBO.getListPlanTarif(entrada);
		logger.debug("getListPlanTarif():end");
		return resultado;
	}//fin getListPlanTarif	

	public LstPTaPlanTarifarioListOutDTO lstPlanTarif(LstPTaPlanTarifarioInDTO entrada)
	throws ProductDomainException{
		logger.debug("lstPlanTarif():start");
		LstPTaPlanTarifarioListOutDTO resultado = planTarifarioBO.lstPlanTarif(entrada);
		logger.debug("Error" +resultado.getCodError());
		logger.debug("lstPlanTarif():end");
		return resultado;
	}
	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarifPosventa(LstPTaPlanTarifarioInDTO entrada)
	throws ProductDomainException{
		logger.debug("lstPlanTarifPosventa():start");
		LstPTaPlanTarifarioListOutDTO resultado = planTarifarioBO.lstPlanTarifPosventa(entrada);
		logger.debug("lstPlanTarifPosventa():end");
		return resultado;
	}

	
	
	public ClienteDTO[] getDatosCliente(BusquedaClienteDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("getDatosCliente():start");
		ClienteDTO resultado[] = clienteBO.getDatosCliente(entrada);
		logger.debug("getDatosCliente():end");
		return resultado;
	}//fin getDatosCliente	

	/** Servicios Activaciones WEB - Colombia
	 * Obtine datos del cliente
	 * @param RegistroVentaDTO (entrada)
	 * @return RegistroVentaDTO (resultado)
	 * @throws CustomerDomainException
     * wjrc - Agosto 2007 */		
	public LstVtaRegistroResultadoDTO getListVentas(RegistroVentaDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("getListVentas():start");
		LstVtaRegistroResultadoDTO resultado = registroVentaBO.getListVentas(entrada);
		logger.debug("getListVentas():end");
		return resultado;
	}//fin getListVentas
	
	public ConceptoVenta ValidarModalidadVenta(DependenciasModalidadDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("INICIO ValidarModalidadVenta VentasSrv");
		logger.debug("ValidarModalidadVenta():start");
		ConceptoVenta resultado = modalidadVentaBO.recalcularModalidadVenta(entrada);
		return resultado; 
	}
	
	public HomeLineaDTO obtieneHomeLinea(HomeLineaDTO entrada) 
		throws ProductDomainException 
	{			
		logger.debug("INICIO obtieneHomeLinea VentasSrv");
		
		HomeLineaDTO resultado = new HomeLineaDTO();
		
		SimcardDTO simcard = new SimcardDTO();
		simcard.setNumeroSerie(entrada.getNum_icc());
		simcard = simcardBO.getSimcard(simcard);		
		
		logger.debug("INICIO obtieneHomeLinea VentasSrv simcard.getIndicadorProgramado() : " + simcard.getIndicadorProgramado());
		logger.debug("INICIO obtieneHomeLinea VentasSrv simcard.getNumeroCelular() : " + simcard.getNumeroCelular());
		
		//Obtiene numero celular			
		if(!simcard.getIndicadorProgramado().equals(global.getValor("indicativo.telefono.no.programado"))
			&& simcard.getNumeroCelular()!=null && !simcard.getNumeroCelular().equals("0"))
		{
			logger.debug("INICIO obtieneHomeLinea VentasSrv simcard NUMERADA vendedor : " + entrada.getCod_vendedor());
			// simcard programada			
			resultado = homeLineaBO.getHomeLineaCelNumerado(entrada);
			resultado.setNum_celular(Long.valueOf(simcard.getNumeroCelular()));
		}
		else
		{// simcard no numerada
			
			entrada.setCod_uso(simcard.getCodigoUso());
			
			//			-- BUSCAR CODIGO ACTUACION
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			planTarifario.setCodigoPlanTarifario(entrada.getCod_planTarif());
			planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
			planTarifario.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
			planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
			if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido")))
			{
				entrada.setCod_actabo(global.getValor("codigo.actuacion.hibrido"));
				entrada.setCod_uso(10);
			}/*else{ release II
				entrada.setCod_actabo(global.getValor("codigo.actuacion.venta"));
			}	*/		
			
			logger.debug("INICIO obtieneHomeLinea VentasSrv simcar NO NUMERADA");
			resultado = homeLineaBO.getHomeLineaCelNoNumerado(entrada);
			resultado.setCod_uso(simcard.getCodigoUso());
			
		}
		logger.debug("ValidarModalidadVenta():start");		
		return resultado; 
	}
	
	public ContratoDTO getNroMesesContrato(ContratoDTO entrada) 
		throws CustomerDomainException 
	{	
		logger.debug("getNroMesesContrato():start");
		ContratoDTO resultado = contratoBO.getNroMesesContrato(entrada);
		return resultado; 
	}
	
	
	public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO)
		throws ProductDomainException , CustomerDomainException		
	{	
		logger.debug("consultaUsuarioVendedor():start");
		DatosGenerDTO datosGenerDTO=new DatosGenerDTO();
		datosGenerDTO =parametrosGeneralesBO.getParametros();
		gaDocVentasDTO.setCod_TipDocumento(datosGenerDTO.getCod_DocAnex());
		gaDocVentasDTO = registroVentaBO.insertGaDocVentas(gaDocVentasDTO);		
		logger.debug("consultaUsuarioVendedor():end");
		return gaDocVentasDTO;
	}
	
	/**
	 * Obtiene secuencia de Peticion de la tabla al_petiguias_abo
	 * 
	 * @param
	 * @return secuenciaNumeroPeticion
	 * @throws IntegracionSIGAException
	 */
	public AlPetiGuiasAboDTO getSecuenciaNumeroPeticion()
		throws CustomerDomainException
	{
		logger.debug("Inicio:getSecuenciaNumeroPeticion()");
		AlPetiGuiasAboDTO alPetiGuiasAboDTO = new AlPetiGuiasAboDTO();
		Long numSecuencia=null;
		numSecuencia= registroVentaBO.getSecuenciaGenerica((global.getValor("secuencia.numero.peticion")));
		alPetiGuiasAboDTO.setNum_peticion(numSecuencia);
		logger.debug("Fin:getSecuenciaNumeroPeticion()");
		return alPetiGuiasAboDTO;
	}
	
	/**
	 * Obtiene secuencia de Peticion de la tabla al_petiguias_abo
	 * 
	 * @param
	 * @return secuenciaNumeroPeticion
	 * @throws IntegracionSIGAException
	 */
	public void liberarSeries(SimcardDTO simcardDTO, TerminalDTO terminalDTO, VendedorDTO vendedor)
		throws ProductDomainException, CustomerDomainException
	{	
		// LIBERA SERIE SIMCARD	
		SimcardDTO simcard = new SimcardDTO();
		simcard = simcardBO.getSimcard(simcardDTO);
		if(simcard!=null) 
		{
			simcard.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
			simcard.setNumeroVenta(simcardDTO.getNumeroVenta());
			simcard.setIndicadorTelefono("1");
			simcard.setEstado("1");
			simcard = simcardBO.actualizaStockSimcard(simcard);
		}
		
		
		// LIBERA SERIE TERMINAL
		if(terminalDTO.getProcedenciaInterna() != null && terminalDTO.getProcedenciaInterna().trim().equals("I"))
		{
			TerminalDTO terminal = new TerminalDTO();			
			terminal = terminalBO.getTerminal(terminalDTO);
			if(terminal!=null)
			{
				terminal.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
				terminal.setNumeroVenta(terminalDTO.getNumeroVenta());
				terminal.setIndicadorTelefono("1");
				terminal.setEstado("1");
				terminal = terminalBO.actualizaStockTerminal(terminal);
			}
		}
		
		//DESBLOQUEA VENDEDOR		
		vendedor.setCodigoAccionBloqueo(global.getValor("indicador.desbloqueo"));
		bloqueaDesbloqueaVendedor(vendedor);
		
	}
	
	
	
	public TipoContratoDTO[] ListaTipoContrato() throws CustomerDomainException {
		logger.debug("getListadoNumeroCuotas():start");
		TipoContratoDTO[] resultado = contratoBO.getTipoContrato(); 
		logger.debug("getListadoNumeroCuotas():end");
		return resultado;
	}
	
	
	
	public ResultadoValidacionVentaDTO validacionSimcard(SimcardInDTO entrada)
		throws ProductDomainException, CustomerDomainException
	{
		ParametrosValidacionVentasDTO parametros = new ParametrosValidacionVentasDTO();
		parametros.setNumeroSerie(entrada.getNro_icc());
		
		ResultadoValidacionVentaDTO ret = new ResultadoValidacionVentaDTO();
		ret.setCodigoError("0");
		ret.setDetalleEstado("");
		ret.setEstado("OK");
		
		//Busca largo serie simcard
	    ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
	    parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
	    parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.AL"));
	    parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.largoSerieSimcard"));
	    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
	    long largoSerie = Long.parseLong(parametrosGeneralesDTO.getValorparametro());	
		
		SimcardDTO simcard = new SimcardDTO();
		///////////////////////
		//Valida el largo de la serie Simcard
	/*	if(largoSerie == entrada.getNro_icc().length())
		{
			simcard.setNumeroSerie(entrada.getNro_icc());
			simcard = simcardBO.getSimcard(simcard);			
			
			//Verifica que la serie exista
			if(simcard!=null)
			{				
				//Validaciones asociadas al tipo de producto
				//Tipo producto = 0(pospago)				
				if( entrada.getTipo_producto().trim().equals("0")){
				{
					if(!simcard.getCodigoUso().trim().equals("2"))
					{
						ret.setEstado("NOK");
						ret.setCodigoError("1");
						ret.setDetalleEstado("Simcard no corresponde a tipo de producto pospago");
						return ret;
					} else{
						ret.setEstado("OK");
						ret.setDetalleEstado("");						
					}
				}else if( entrada.getTipo_producto().trim().equals("2")){ //Tipo producto = 2(hibrido)
					if(!simcard.getCodigoUso().trim().equals("10"))
					{
						ret.setEstado("NOK");
						ret.setCodigoError("1");
						ret.setDetalleEstado("Simcard no corresponde a tipo de producto hibrido");
						return ret;
					}else{
						ret.setEstado("OK");						
						ret.setDetalleEstado("");
					}
				}else {
					ret.setEstado("OK");						
					ret.setDetalleEstado("");
				}
			} else {
				ret.setEstado("NOK");						
				ret.setCodigoError("1");
				ret.setDetalleEstado("Serie simcard no se encuentra");
				return ret;
			}
		}else {
			ret.setEstado("NOK");						
			ret.setCodigoError("1");
			ret.setDetalleEstado("Largo serie Simcard no corresponde");
			return ret;
		}*/
		
//		Valida el largo de la serie Simcard
		
		/*Obtiene datos de la modalidad de pago*/

        ModalidadPagoDTO modalidadPagoDTO = new ModalidadPagoDTO();
        modalidadPagoDTO.setCodigoModalidadPago(entrada.getForma_pago());
        modalidadPagoDTO = getModalidadPago(modalidadPagoDTO);

		
		
		if(largoSerie == entrada.getNro_icc().length())
		{
			simcard.setNumeroSerie(entrada.getNro_icc());
			simcard = simcardBO.getSimcard(simcard);			
			
			//Busca estado nuevo Simcard
		    parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.estadoNuevo"));
		    parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		    String nuevoEstadoSimcard = parametrosGeneralesDTO.getValorparametro();
		    //Fin busqueda estado nuevo simcard
			
			//Verifica que la serie exista
			if(simcard!=null)
			{				
				if(simcard.getNumeroCelular().trim().equals("0"))
				{
					if( ret.getEstado().trim().equals("OK"))
					{
						//Verifica que la serie a vender sea nueva
						logger.debug("parametrosEntrada.getEstadoNuevoSimcard(): " + nuevoEstadoSimcard);
						logger.debug("simcard.getEstado(): " + simcard.getEstado());
						if(simcard.getEstado().trim().equals(nuevoEstadoSimcard))
						{
			            //*-- MAYORISTA /inicio
								
							String sValidarUso = global.getValor("valor.verdadero");
						
							//-- OBTIENE PARAMETRO : APLICA MAYORISTA
							String sAplicaMayorista = global.getValor("valor.falso");						
							parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
							parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
							parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.aplica.mayorista"));
							parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
							sAplicaMayorista = parametrosGeneralesDTO.getValorparametro();
							logger.debug("sAplicaMayorista: " + sAplicaMayorista);							
							if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
							{
								logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoCanal() : " + 
										entrada.getCod_canal());
								logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoModalidadVenta() : " + 
										entrada.getForma_pago());
								logger.debug("INICIO validaciones serieSimcard 2.6 sAplicaMayorista : " + 
										sAplicaMayorista );
								
								//*-- omite validacion uso?
								String sOmiteUsoVenta = global.getValor("valor.falso");
								if (entrada.getCod_canal().trim().toUpperCase().equals(global.getValor("codigo.canal.indirecto")))
									//if (parametrosEntrada.getCodigoModalidadVenta().equals(global.getValor("modalidad.venta.credito")))
										if (simcard.getTipoStock().trim().equals("4"))
											if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
											{
												//-- OBTIENE PARAMETRO : OMITE USO VENTA
												parametrosGeneralesDTO = new ParametrosGeneralesDTO();
												parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
												parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
												parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.omite_uso_venta"));
												parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
												sOmiteUsoVenta = parametrosGeneralesDTO.getValorparametro();		
													
												logger.debug("sOmiteUsoVenta: " + sOmiteUsoVenta);
											
												//*-- serie numerada?
												String sSerieNumerada = global.getValor("valor.falso");
												if (simcard.getNumeroCelular() != null && simcard.getEstado().equals(global.getValor("estado.serie.ok")))
													sSerieNumerada = global.getValor("valor.verdadero");
												logger.debug("sSerieNumerada: " + sSerieNumerada);
							
												//*-- venta mayorista?
												String sVentaMayorista = global.getValor("valor.falso");
												ArticuloDTO articuloDTO = new ArticuloDTO();
												articuloDTO.setNumeroSerie(simcard.getNumeroSerie());
												articuloDTO = articuloBO.getVentaMayorista(articuloDTO);
												if (articuloDTO.getDescripcion() != null)
													sVentaMayorista = global.getValor("valor.verdadero");
												logger.debug("sVentaMayorista: " + sVentaMayorista);
							
												//-- validar uso?
												if (sVentaMayorista.equals(global.getValor("valor.verdadero")))
													if (sOmiteUsoVenta.equals(global.getValor("valor.verdadero")))
														if (sSerieNumerada.equals(global.getValor("valor.verdadero")))
														{
															sValidarUso = global.getValor("valor.falso");
															//resultado.setEsMayoristaSimcard(true);
														}//else resultado.setEsMayoristaSimcard(false);									
												logger.debug("sValidarUso: " + sValidarUso);
										}
							}//fin if (sAplicaMayorista.equals(global.getValor("valor.verdadero")...
								
							logger.debug("INICIO validaciones serieSimcard 2.7 ");
							if (sValidarUso.equals(global.getValor("valor.verdadero")))
							{
								//Busca uso venta postpago
							    parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.usoVentaPostpago"));
							    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
							    String codUsoPostPago = parametrosGeneralesDTO.getValorparametro();
							    //Fin busqueda uso venta postpago		    
							    //Busca uso venta hibrido
							    parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.usoVentaHibrido"));
							    parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
							    String codUsoHibrido = parametrosGeneralesDTO.getValorparametro();
							    //Fin busqueda uso venta hibrido
								//*-- MAYORISTA /fin
								logger.debug("INICIO validaciones serieSimcard 2.8 simcard.getCodigoUso() :  " + simcard.getCodigoUso());
								logger.debug("INICIO validaciones serieSimcard 2.8 parametrosEntrada.getUsoVentaPostpago() :  " + codUsoPostPago);
								logger.debug("INICIO validaciones serieSimcard 2.8 parametrosEntrada.getUsoVentaHibrido() :  " + codUsoHibrido);
								//Verifica que el uso de la serie corresponda a venta pospago
								if(Integer.valueOf(codUsoPostPago).intValue() == simcard.getCodigoUso() 
										|| Integer.valueOf(codUsoHibrido).intValue() == simcard.getCodigoUso())
								{
									logger.debug("INICIO validaciones serieSimcard 2.9 ");
									TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
									datosStockSerie.setTipoStockaValidar(Integer.parseInt(simcard.getTipoStock()));
									datosStockSerie.setModalidadVenta(Integer.parseInt(entrada.getForma_pago()));
									datosStockSerie.setCodigoProducto(Integer.parseInt(global.getValor("codigo.producto")));								
									if(entrada.getCod_canal().trim().toUpperCase().equals("D")) 
									{
										datosStockSerie.setCodigoCanal("0");
									}else datosStockSerie.setCodigoCanal("1");
									
									logger.debug("TIPO STOCK codigoCanal: " +  datosStockSerie.getCodigoCanal());
									logger.debug("TIPO STOCK codigoProducto: " +  datosStockSerie.getCodigoProducto());
									logger.debug("TIPO STOCK modalidadVenta: " +  datosStockSerie.getModalidadVenta());
									logger.debug("TIPO STOCK tipoStock: " +  datosStockSerie.getTipoStockaValidar());
									
									ResultadoValidacionLogisticaDTO retLoj=tipoStockSerieBO.validaTipoStockSerie(datosStockSerie);
									logger.debug("INICIO validaciones serieSimcard 2.10 ");
									if (retLoj.isResultado())
									{
										logger.debug("Simcard OK");	
										logger.debug("INICIO validaciones serieSimcard 3 NOK");
										ret.setEstado("OK");
										ret.setDetalleEstado("-");
									/*} else {
										ret.setEstado("NOK");
										ret.setCodigoError("-2219");
										logger.debug("INICIO validaciones serieSimcard 4 NOK");
										ret.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");
										return ret;
									}*/
									} else {
						                ret.setEstado("NOK");
						                ret.setCodigoError("-2219");
						                logger.debug("INICIO validaciones serieSimcard 4 NOK");
						                if(simcard.getTipoStock().equalsIgnoreCase("4") & datosStockSerie.getCodigoCanal().equalsIgnoreCase("0")){
						                               ret.setDetalleEstado("El vendedor directo no tiene acceso a la mercaderia dealer");
						                }else{     
						                               ret.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");   
						                }                                                                                                                                                                                                                                                                                                                        
						                return ret;
									}
	
								} else {
									ret.setEstado("NOK");
									ret.setCodigoError("-2220");
									logger.debug("INICIO validaciones serieSimcard 5 NOK");
									ret.setDetalleEstado("El uso de la Serie Simcard no Corresponde a venta Pospago");
									return ret;
								}
								
									//Validaciones asociadas al tipo de producto
									//Tipo producto = 0(pospago)				
									if( entrada.getTipo_producto().trim().equals("0"))
									{
										//Incidencia 65043 se modifica validación de uso JC- NRCA [12-05-2008, desarrollo P-COL-08009] 
										if(simcard.getCodigoUso() != 2 && simcard.getCodigoUso() != 10)
										{
											ret.setEstado("NOK");
											ret.setCodigoError("-1");
											ret.setDetalleEstado("Uso de Simcard no valido para venta postpago");
											return ret;
										} else{
											ret.setEstado("OK");
											ret.setDetalleEstado("-");						
										}
									//Tipo producto = 2(hibrido)	
									}else if( entrada.getTipo_producto().trim().equals("2")){ 
										// Incidencia 65043 se modifica validación de uso JC- NRCA [12-05-2008, desarrollo P-COL-08009] 
										if(simcard.getCodigoUso() != 2  && simcard.getCodigoUso() != 10)
										{
											ret.setEstado("NOK");
											ret.setCodigoError("-1");
											ret.setDetalleEstado("Uso de simcard no valido para venta hibrido");
											return ret;
										}else{
											ret.setEstado("OK");						
											ret.setDetalleEstado("-");
										}
									}else {
										ret.setEstado("OK");						
										ret.setDetalleEstado("-");
									}
							} else {							
								if(simcard.getTipoStock().trim().equals("4")) ret.setResultado(true);
								if (ret.isResultado())
								{
									logger.debug("Simcard OK");	
									ret.setEstado("OK");
									ret.setDetalleEstado("-");
								} else {
									logger.debug("INICIO validaciones serieSimcard 6 NOK");
									ret.setEstado("NOK");
									ret.setCodigoError("-2219");
									ret.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");
									return ret;
								}
							}
						} else {
							logger.debug("INICIO validaciones serieSimcard 7 NOK");
							ret.setEstado("NOK");
							ret.setCodigoError("-2221");
							ret.setDetalleEstado("Serie Simcard No es Nueva");
							return ret;
						}
					}
				} else {
					logger.debug("INICIO validaciones serieSimcard 7.1 NOK");
					ret.setEstado("NOK");			
					ret.setCodigoError("-2223");
					ret.setDetalleEstado("Serie Simcard se encuentra numerada");
					return ret;
				}		
			} else {
				logger.debug("INICIO validaciones serieSimcard 8 NOK");
				ret.setEstado("NOK");			
				ret.setCodigoError("-2222");
				ret.setDetalleEstado("Serie Simcard No Existe");
				return ret;
			}
		} else {			
			logger.debug("INICIO validaciones serieSimcard 9 NOK");
			ret.setEstado("NOK");
			ret.setCodigoError("-2223");
			ret.setDetalleEstado("Largo Serie Simcard Incorrecto");
			return ret;
		}
		
		logger.debug("Fin:validacionesSerieSimcard()");
		
		//Verifica si serie simcard existe en abonado					
		ResultadoValidacionVentaDTO resultadoValidacion = abonadoBO.existeSerieSimcardEnAbonado(parametros);
		if (resultadoValidacion.isResultado()){
			logger.debug("INICIO validacionLinea VentasSrv 1 NOK ");
			ret.setCodigoError("1");
			ret.setEstado("NOK");
			ret.setDetalleEstado("Serie simcard existe en abonado");
			return ret;
		}
		
		//Valida que el vendedor tenga acceso a bodega de la simcard
		simcard.setNumeroSerie(entrada.getNro_icc());
		simcard = simcardBO.getSimcard(simcard);
		parametros.setCodigoBodega(simcard.getCodigoBodega());
		parametros.setCodigoVendedor(entrada.getCod_vendedor());
		resultadoValidacion = vendedorBO.vendedorExisteEnBodegaSimcard(parametros);		
		if (!resultadoValidacion.isResultado())
		{
			ret.setEstado("NOK");
			ret.setCodigoError("1");
			ret.setDetalleEstado("Vendedor no tiene acceso a la bodega de la simcard");
			return ret;
		}
		
		return ret;
	}
	
	
	public RegistroEvaluacionRiesgoDTO validaExistenciaEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:validaExistenciaEvRiesgo()");
		RegistroEvaluacionRiesgoDTO respuesta = new RegistroEvaluacionRiesgoDTO();
		respuesta = registroEvaluacionRiesgoBO.validaExistenciaEvRiesgo(registroEvaluacionRiesgo);
		logger.debug("Fin:validaExistenciaEvRiesgo()");
		return respuesta;		
	}
	
	public void validaPlanTarifarioEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:validaPlanTarifarioEvRiesgo()");
		registroEvaluacionRiesgoBO.validaPlanTarifarioEvRiesgo(registroEvaluacionRiesgo); 
		logger.debug("Fin:validaPlanTarifarioEvRiesgo()");
	}
	
	public void bloqueaSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:bloqueaSolicitudEvRiesgo()");		
		registroEvaluacionRiesgoBO.bloqueaSolicitudEvRiesgo(registroEvaluacionRiesgo); 
		logger.debug("Fin:bloqueaSolicitudEvRiesgo()");		
	}
	
	public void desBloqueaEstadoSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:desBloqueaEstadoSolicitudEvRiesgo()");
		registroEvaluacionRiesgoBO.desBloqueaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo); 
		logger.debug("Fin:desBloqueaEstadoSolicitudEvRiesgo()");
		
	}	
	
	public void udp_EvRiesgo_registroPlanes(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:udp_EvRiesgo_registroPlanes()");
		registroEvaluacionRiesgoBO.udp_EvRiesgo_registroPlanes(registroEvaluacionRiesgo); 
		logger.debug("Fin:udp_EvRiesgo_registroPlanes()");					
	}	
	
	public void validaDireccion (DireccionNegocioDTO direccionNegocioDTO) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio:validaDireccion()");
		Direccion direccionBO= new Direccion();
		direccionBO.validaDireccion(direccionNegocioDTO);
		logger.debug("Fin:validaDireccion()");
	}
	
	
	public void reversaVenta(GaVentasDTO gaVentasDTO) 
		throws CustomerDomainException
	{
        logger.debug("reversaVenta():Inicio");
        registroVentaBO.reversaVenta(gaVentasDTO);
        logger.debug("reversaVenta():Fin");
    }
	
	
	/***************************** Metodos para pantalla datos de venta GUATEMALA _ EL SALVADOR *****************************/	
	
	public VendedorDTO[] getListTiposComisionistas()
		throws CustomerDomainException 
	{
		VendedorDTO[] arrayVendedor = null;
		logger.debug("getListTiposComisionistas():start");
		Vendedor vendedorBO = new Vendedor();
		arrayVendedor= vendedorBO.getListTiposComisionistas();
		logger.debug("getListTiposComisionistas():end");
		return arrayVendedor;
	}//fin getListTiposComisionistas
		
	public VendedorDTO[] getListadoVendedores(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = vendedorBO.getListadoVendedores(vendedor);
		logger.debug("Fin:getListadoVendedores()");
		return resultado;		
	}//fin getListadoVendedores
	
	
	public VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getListadoVendedoresDealer()");
		VendedorDTO[] resultado = vendedorBO.getListadoVendedoresDealer(vendedor);
		logger.debug("Fin:getListadoVendedoresDealer()");
		return resultado;		
	}//fin getListadoVendedoresDealer
	
	
	public BodegaDTO[] getBodegasXVendedor(BodegaDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getBodegasXVendedor()");
		BodegaDTO[] resultado = bodegaBO.getBodegas(entrada);
		logger.debug("Fin:getBodegasXVendedor()");
		return resultado;		
	}//fin getListadoVendedores
	
	public ArticuloInDTO[] getArticulos(ArticuloInDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getArticulos()");
		ArticuloInDTO[] resultado = articuloBO.getArticulos(entrada);
		logger.debug("Fin:getArticulos()");
		return resultado;		
	}//fin getListadoVendedores
	
	public GrupoPrestacionDTO[] getGruposPrestacion() 
		throws ProductDomainException
	{
		logger.debug("Inicio:getGruposPrestacion()");
		GrupoPrestacionDTO[] resultado = prestacionBO.getGruposPrestacion();
		logger.debug("Fin:getGruposPrestacion()");
		return resultado;		
	}//fin getGruposPrestacion		
	
	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getTiposPrestacion()");
		TipoPrestacionDTO[] resultado = prestacionBO.getTipoPrestacion(codGrupoPrestacion, tipoCliente);
		logger.debug("Fin:getTiposPrestacion()");
		return resultado;		
	}//fin getTiposPrestacion
	
	public TipoPrestacionDTO getDatosPrestacion(String codPrestacion) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getDatosPrestacion()");
		TipoPrestacionDTO resultado = prestacionBO.getDatosPrestacion(codPrestacion);
		logger.debug("Fin:getDatosPrestacion()");
		return resultado;		
	}//fin getTiposPrestacion
	
	public UsoDTO[] getUsos(UsoDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getUsos()");
		UsoDTO[] resultado = prestacionBO.getUsos(entrada);
		logger.debug("Fin:getUsos()");
		return resultado;		
	}//fin getListadoVendedores
	
	public SeguroDTO[] getSeguros() 
		throws ProductDomainException
	{
		logger.debug("Inicio:getSeguros()");
		SeguroDTO[] resultado = prestacionBO.getSeguros();
		logger.debug("Fin:getSeguros()");
		return resultado;		
	}//fin getListadoVendedores
	
	public Long getIndSeguro(Long entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:getIndSeguro()");
		Long resultado = prestacionBO.getIndSeguro(entrada);
		logger.debug("Fin:getIndSeguro()");
		return resultado;		
	}//fin getIndSeguro
	
	public CentralDTO[] getDatosCentral(CentralDTO entrada)
		throws ResourceDomainException
	{
		logger.debug("Inicio:getDatosCentral()");
		CentralDTO[] resultado = centralBO.getDatosCentral(entrada);
		logger.debug("Fin:getDatosCentral()");
		return resultado;		
	}//fin getDatosCentral
	
	public SerieDTO[] buscarSerie(SerieDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:buscarSerie()");
		SerieDTO[] resultado = simcardBO.buscarSerie(entrada);
		logger.debug("Fin:buscarSerie()");
		return resultado;		
	}//fin getDatosCentral
	
	public SerieDTO[] listarSerie(SerieDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:listarSerie()");
		SerieDTO[] resultado = simcardBO.listarSerie(entrada);
		logger.debug("Fin:listarSerie()");
		return resultado;		
	}//fin getDatosCentral
	
	public void generarDatosIP(IpDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:generarDatosIP()");
		prestacionBO.generarDatosIP(entrada);
		logger.debug("Fin:generarDatosIP()");				
	}//fin generarDatosIP
	
	public void insertaSeguroAbonado(SeguroDTO entrada)  
		throws ProductDomainException
	{
		logger.debug("Inicio:insertaSeguroAbonado()");
		prestacionBO.insertaSeguroAbonado(entrada);
		logger.debug("Fin:insertaSeguroAbonado()");				
	}//fin generarDatosIP
	
	public SeguroDTO obtieneDatosSeguro(SeguroDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("Inicio:obtieneDatosSeguro()");
		SeguroDTO resultado = prestacionBO.obtieneDatosSeguro(entrada);
		logger.debug("Fin:obtieneDatosSeguro()");
		return resultado;
	}//fin generarDatosIP
	
	public TipoTerminalDTO[] listarTiposTerminal(String codTecnologia) 
		throws ProductDomainException
	{
		logger.debug("Inicio:listarTiposTerminal()");
		TipoTerminalDTO[] resultado = prestacionBO.listarTiposTerminal(codTecnologia);
		logger.debug("Fin:listarTiposTerminal()");
		return resultado;
	}//fin generarDatosIP
	
	
	public MonedaDTO[] listarMonedas() 
		throws ProductDomainException
	{
		logger.debug("Inicio:listarMonedas()");
		MonedaDTO[] resultado = prestacionBO.listarMonedas();
		logger.debug("Fin:listarMonedas()");
		return resultado;
	}//fin listarMonedas
	
	
	//Para Numeracion Reutilizable
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		logger.debug("Inicio:obtieneNumeracionReutilizable()");
		SeleccionNumeroCelularDTO[] resultado = numeracionBO.obtieneNumeracionReutilizable(datosNumeracionVO);
		logger.debug("Fin:obtieneNumeracionReutilizable()");
		return resultado;
	}//fin obtieneNumeracionReutilizable
	
	//Para Numeracion Reservada 	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReservada(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.debug("Inicio:obtieneNumeracionReservada()");
		SeleccionNumeroCelularDTO[] resultado = numeracionBO.obtieneNumeracionReservada(datosNumeracionVO);
		logger.debug("Fin:obtieneNumeracionReservada()");
		return resultado;
	}//fin obtieneNumeracionReservada
	
	//Para Numeracion Nueva   	
	public SeleccionNumeroCelularRangoDTO[] obtieneNumeracionRango(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.debug("Inicio:obtieneNumeracionRango()");
		SeleccionNumeroCelularRangoDTO[] resultado = numeracionBO.obtieneNumeracionRango(datosNumeracionVO);
		logger.debug("Fin:obtieneNumeracionRango()");
		return resultado;
	}//fin obtieneNumeracionReservada
	
	//Para obtener categoria
	public String obtieneCategoria(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.debug("Inicio:obtieneCategoria()");
		
		String[] arregloCategorias = numeracionBO.obtieneCategoria(datosNumeracionVO);		
		String arrCat = "";
	    if(arregloCategorias.length > 0)
	    	arrCat += arregloCategorias[0];
	    for (int j = 1; j < arregloCategorias.length; j++) {
			arrCat += "," + arregloCategorias[j];
		}	    
		logger.debug("Fin:obtieneCategoria()");
		return arrCat;
	}//fin obtieneCategoria
	
	//	Para numeracion automatica
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.info("obtieneNumeracionAutomatica():start");
		DatosNumeracionDTO resultado = numeracionBO.obtieneNumeracionAutomatica(datosNumeracionVO);   
		logger.info("obtieneNumeracionAutomatica():end");
		return resultado;
	}//fin obtieneNumeracionAutomatica	
	
	//	Para reservar numero celular
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException
	{
		logger.info("reservaNumeroCelular():start");
		numeracionBO.reservaNumeroCelular(numeracionCelularVO);   
		logger.info("reservaNumeroCelular():end");		
	}//fin reservaNumeroCelular	
	
	//Insertar numero de celular reservado
	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException
	{
		logger.info("insertarNumeroCelularReservado():start");
		numeracionCelularVO.setCodProducto(new Long(global.getValor("codigo.producto")));
		numeracionBO.insertarNumeroCelularReservado(numeracionCelularVO);   
		logger.info("insertarNumeroCelularReservado():end");		
	}//fin insertarNumeroCelularReservado
	
	//Reponer numeracion
	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException
	{
		logger.info("reponerNumeracion():start");
		numeracionBO.reponerNumeracion(numeracionCelularVO);   
		logger.info("reponerNumeracion():end");		
	}//fin reponerNumeracion
	
	//Des-reservar numero de celular
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException
	{
		logger.info("desReservaNumeroCelular():start");
		numeracionBO.desReservaNumeroCelular(numeracionCelularVO);   
		logger.info("desReservaNumeroCelular():end");	
	}//fin desReservaNumeroCelular
	
	//Validar numero internet
	public void validaNumeroInternet(NumeroInternetDTO entrada)
		throws ProductDomainException
	{
		logger.info("validaNumeroInternet():start");
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();										    
    	parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
    	parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
    	parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.numNacOperador"));
    	parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);	
    	
    	entrada.setCodOperadorMin(parametrosGeneralesDTO.getValorparametro());		
		numeracionBO.validaNumeroInternet(entrada);
		logger.info("validaNumeroInternet():end");	
	}//Validar numero internet	
		
	
	public DatosGeneralesVentaDTO creacionLineasWeb(DatosGeneralesVentaDTO datosGeneralesVenta,UsuarioWebDTO usuario)
		throws CustomerDomainException,ProductDomainException
	{	
			logger.debug("Inicio:creacionLineasWeb()");
			DatosGeneralesVentaDTO resultado = datosGeneralesVenta;
	    	resultado.setEstadoError("OK");
	    	resultado.setDetalleError("-");
			
			String sNumeroMovtoSerieSimcard = null;
			String sNumeroMovtoSerieTerminal = null;
			
			Date fecha = new Date();
			AbonadoDTO abonadoAux = new AbonadoDTO();
			ServicioSuplementarioDTO servicioSuplementario = new ServicioSuplementarioDTO();			
			ClienteDTO cliente = new ClienteDTO();
			AbonadoDTO abonado = new AbonadoDTO();
			CuentaDTO subCuenta = new CuentaDTO();
			SimcardDTO simcard = new SimcardDTO();
			TerminalDTO terminal = new TerminalDTO();
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			VendedorDTO vendedor = new VendedorDTO();
			
			//Obtengo configuracion tipo prestacion			
			TipoPrestacionDTO datosPrestacion = getDatosPrestacion(datosGeneralesVenta.getCodTipPrestacion());
						
			//-- BUSCAR SERIE			
			simcard.setNumeroSerie(datosGeneralesVenta.getNumeroSerieSimcard());
			simcard = simcardBO.getSimcard(simcard);			
	
			//-- BUSCAR TERMINAL
			terminal.setNumeroSerie(datosGeneralesVenta.getNumeroSerieTerminal());
			terminal = terminalBO.getTerminal(terminal);
																				
			//-- BUSCA CLIENTE
			cliente.setCodigoCliente(datosGeneralesVenta.getCodigoCliente());									
			cliente = clienteBO.getCliente(cliente);								
			
			//-- BUSCA OFICINA PRINCIPAL VENDEDOR
			vendedor.setCodigoVendedor(datosGeneralesVenta.getCodigoVendedor());
			vendedor.setCodigoVendedorDealer(Long.valueOf(datosGeneralesVenta.getCodigoVendedorDealer()).longValue());
			vendedor = getVendedor(vendedor);
			abonadoAux = getOficinaPrincipal(vendedor);									
			
			//-- BUSCA SUBCUENTA
			subCuenta.setCodigoCuenta(cliente.getCodigoCuenta());
			subCuenta = getSubCuenta(subCuenta);
			cliente.setCodigoSubCuenta(subCuenta.getCodigoSubCuenta());
			
			//-- BUSCAR PLAN TARIFARIO
			planTarifario.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
			planTarifario.setCodigoProducto(global.getValor("codigo.producto"));									
			planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
			String sEstadoError = "OK";
			String sDetalleError = "-";
			
			try{
				
				//-- OBTIENE SECUENCIA-NUMERO ABONADO
				sEstadoError = "NOK";
				sDetalleError = "Ocurrio un error al crear el Abonado";
			    abonado = getSecuenciaAbonado();
			    
			    logger.debug("CODIGO GRUPO PRESTACION : " + datosGeneralesVenta.getCodGrupoPrestacion());
				
			    
				if(datosGeneralesVenta.getCodGrupoPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.CARRIER")))
				{
					abonado.setTipoPrimariaCarrier(datosGeneralesVenta.getTipoPrimariaCarrier());
				}
				
			    
				abonado.setFecAlta(datosGeneralesVenta.getFechaActual());
				if(datosGeneralesVenta.getNumeroCelular() != null && !datosGeneralesVenta.getNumeroCelular().trim().equals(""))
				{
					abonado.setNumCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
				}else abonado.setNumCelular(0);
				
				if(datosGeneralesVenta.getCodGrupoPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.TVCABLE")))
				{
					
					ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
					parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
					parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.nrotvcable"));
					parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
					String nroTelefono = parametrosGeneralesDTO.getValorparametro();
					logger.debug("NroTelefono TVCABLE:: " + nroTelefono);
					abonado.setNumCelular(Long.valueOf(nroTelefono).longValue());
				}
				
				abonado.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));										
				abonado.setCodCliente(Long.parseLong(cliente.getCodigoCliente()));										
				abonado.setCodCuenta(Long.parseLong(cliente.getCodigoCuenta()));										
				abonado.setCodSubCuenta(cliente.getCodigoSubCuenta());
				abonado.setCodRegion(datosGeneralesVenta.getCodigoRegion());						
				abonado.setCodProvincia(datosGeneralesVenta.getCodigoProvincia());							
				abonado.setCodCiudad(datosGeneralesVenta.getCodigoCiudad());
				logger.debug("CODIGO TECNOLOGIA: " + datosGeneralesVenta.getCodigoTecnologia());
				abonado.setTipTerminal(datosGeneralesVenta.getTipoTerminal());
				
				if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM")))
				{
					if(datosGeneralesVenta.getCodGrupoPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.SMS")))
					{
						//En caso de SMS a pesar de corresponder a tecnologia GSM para El Salvador no lleva SIMCARD (esto segun definicion)
						abonado.setNumSerieSimcard("");
						abonado.setNumImei("");
						abonado.setCodBodegaSimcard("");
					    abonado.setCapcodeSimcard("");
					    abonado.setTipoStockSimcard(0);
					    abonado.setCodigoArticuloSimcard("");
					    abonado.setDesArticuloSimcard("");
					    abonado.setCodEstadoSimcard("");
					    abonado.setCodUsoSimcard(0);
					    abonado.setCodPassword("");
					}else {
						abonado.setNumSerieSimcard(simcard.getNumeroSerie());
						abonado.setNumImei(terminal.getNumeroSerie());
						abonado.setCodBodegaSimcard(simcard.getCodigoBodega());
					    abonado.setCapcodeSimcard(simcard.getCapCode());
					    abonado.setTipoStockSimcard(Long.parseLong(simcard.getTipoStock()));
					    abonado.setCodigoArticuloSimcard(simcard.getCodigoArticulo());
					    abonado.setDesArticuloSimcard(simcard.getDescripcionArticulo());
					    abonado.setCodEstadoSimcard(global.getValor("estado.articulo"));
					    abonado.setCodUsoSimcard(simcard.getCodigoUso());
					    abonado.setCodPassword(simcard.getNumeroSerie().substring(simcard.getNumeroSerie().length()-4,simcard.getNumeroSerie().length()));
					}
				    
				    ParametroDTO parametroEntrada = new ParametroDTO();					    
					parametroEntrada.setCodigoParametro(global.getValor("parametro.codigo.simcardgsm"));
					parametroEntrada.setCodigoProducto(global.getValor("codigo.producto"));
					parametroEntrada.setCodigoModulo(global.getValor("codigo.modulo.AL"));
					parametroEntrada = getValorParametro(parametroEntrada);						
				    abonado.setTipTerminal(parametroEntrada.getValorParametro());
				    
				    
				}else {											
					abonado.setNumSerieSimcard(datosGeneralesVenta.getNumeroSerieTerminal());
					abonado.setNumImei("");
				}									
			    									    
				abonado.setCodUso(datosGeneralesVenta.getCodUso());
			    abonado.setNumSerieTerminal(terminal.getNumeroSerie());
			    abonado.setCodBodegaTerminal(terminal.getCodigoBodega());
			    abonado.setCapcodeTerminal(terminal.getCapCode());
			    if (terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
			    {									    	
			    	abonado.setTipoStockTerminal(Long.parseLong(terminal.getTipoStock()));
			    	abonado.setCodigoArticuloTerminal(terminal.getCodigoArticulo());
				    abonado.setDesArticuloTerminal(terminal.getDescripcionArticulo());
				    abonado.setCodUsoTerminal(terminal.getCodigoUso());
				    abonado.setCodEstadoTerminal(global.getValor("estado.articulo"));
			    } else {								    	
			    	//Tipo stock terminal cuando es externa la procedencia
			    	ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
				    parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			    	parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			    	parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.tipoStockExterno"));
			    	parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);		
				    abonado.setTipoStockTerminal(Long.valueOf(parametrosGeneralesDTO.getValorparametro()).longValue());
				    abonado.setCodUsoTerminal(datosGeneralesVenta.getCodUso());
				    abonado.setCodigoArticuloTerminal(datosGeneralesVenta.getCodigoArticuloTerminal());
				    abonado.setDesArticuloTerminal(datosGeneralesVenta.getDesArticuloTerminal());
			    }
			    abonado.setNumImei(terminal.getNumeroSerie());
				abonado.setIndProcEqTerminal(terminal.getIndProcEq());
				abonado.setTipPlantarif(planTarifario.getTipoPlanTarifario());
				abonado.setCodCargoBasico(planTarifario.getCodigoCargoBasico());
				abonado.setCodPlanServ(datosGeneralesVenta.getCodPlanServ());
				abonado.setCodLimConsumo(datosGeneralesVenta.getCodLimiteConsumo());
				abonado.setCodCelda(datosGeneralesVenta.getCodigoCelda());  
				abonado.setCodCentral(Integer.parseInt(datosGeneralesVenta.getCodigoCentral()));
				abonado.setCodSituacion(global.getValor("codigo.situacion"));
				abonado.setIndProcAlta(String.valueOf(vendedor.getIndicadorTipoVenta()));
				abonado.setIndProcEqSimcard(global.getValor("indicador.procedencia.equipo.simcard"));
				abonado.setCodVendedor(Long.parseLong(datosGeneralesVenta.getCodigoVendedor()));
				abonado.setCodVendedorAgente(Long.parseLong(datosGeneralesVenta.getCodigoVendedorRaiz()));
				
				//Se obtiene de GED_PARAMETROS cod_producto=1 cod_modulo=AL nom_parametro=COD_SIMCARD_GSM
				//Para la tabla ga_abocer se utiliza este valor para la de equipo se utiliza el parametro asociado al terminal
				abonado.setCodPlanTarif(datosGeneralesVenta.getCodigoPlanTarifario());
				abonado.setNumSerieHex(global.getValor("numero.serie.hexadecimal"));
				abonado.setNomUsuarOra(datosGeneralesVenta.getNombreUsuarioOracle());
				abonado.setNumPerContrato(Integer.parseInt(datosGeneralesVenta.getNumeroPerContrato()));
				abonado.setCodigoEstado(datosGeneralesVenta.getCodigoEstado());
				abonado.setNumSerieMec(null);										
				if (datosGeneralesVenta.getIdentificadorEmpresa().equals(global.getValor("identificador.empresa")))
					abonado.setCodEmpresa(cliente.getCodigoEmpresa());
			    abonado.setCodGrpSrv(datosGeneralesVenta.getCodigoGrupoServicio());
			    abonado.setIndSuperTel(Integer.parseInt(global.getValor("indicador.supertelefono")));
				abonado.setNumTeleFija(null);
				abonado.setIndPrepago(Integer.parseInt(global.getValor("indicador.prepago")));
				abonado.setIndPlexSys(Integer.parseInt(global.getValor("indicador.plexsys")));
				abonado.setNumVenta(Long.parseLong(datosGeneralesVenta.getNumeroVenta()));
				abonado.setCodModVenta(Long.parseLong(datosGeneralesVenta.getCodigoModalidadVenta()));
				abonado.setCodTipContrato(datosGeneralesVenta.getCodigoTipoContrato());
				abonado.setNumContrato(datosGeneralesVenta.getNumeroContrato());
				abonado.setNumAnexo(datosGeneralesVenta.getNumAnexo());
				Calendar cal = new GregorianCalendar(); 
			    cal.setTimeInMillis(fecha.getTime()); 
			    cal.add(Calendar.MONTH, datosGeneralesVenta.getNumMesesContrato().intValue() ); 
			    Date fechaFinContrato = new Date(cal.getTimeInMillis()); 
			    String fechaFinContratoFormateada = Formatting.dateTime(fechaFinContrato,"dd/MM/yyyy HH:mm:ss");
			    cal = new GregorianCalendar(); 
			    cal.setTimeInMillis(fecha.getTime()); 
			    cal.add(Calendar.DATE,planTarifario.getNumDias()); 
			    Date fechaFecCumpPlan = new Date(cal.getTimeInMillis()); 
			    String fechaFecCumpPlanFormateada = Formatting.dateTime(fechaFecCumpPlan,"dd/MM/yyyy HH:mm:ss");
			    abonado.setFecCumPlan(fechaFecCumpPlanFormateada);
			    abonado.setCodCredMor(datosGeneralesVenta.getCodigoCreditoMorosidad());
			    abonado.setCodCredCon(datosGeneralesVenta.getCodigoCreditoConsumo());
			    abonado.setCodCiclo(cliente.getCodigoCiclo());									    
			    abonado.setCodFactur(Integer.parseInt(datosGeneralesVenta.getIndicadorFacturable()));
			    abonado.setIndSuspen(Integer.parseInt(global.getValor("indicador.ind_suspen")));
			    abonado.setIndReHabi(Integer.parseInt(global.getValor("indicador.ind_rehabi")));
			    abonado.setInsGuias(Integer.parseInt(global.getValor("indicador.ind_insguias")));
			    abonado.setFecFinContra(fechaFinContratoFormateada);
			    abonado.setFecRecDocu(null);	//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecCumplimen(null);	//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecAcepVenta(null);	//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecActCen(null);		//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecBaja(null);		//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecBajaCen(null);	//Valor por defecto null.... Se asigna fecha actual
			    abonado.setFecUltMod(datosGeneralesVenta.getFechaActual());
			    abonado.setCodCausaBaja(null);//Valor por defecto null no utilizada en VB
			    abonado.setNumPersonal(null); //Valor por defecto null no utilizada en VB
			    abonado.setIndSeguro(Integer.parseInt(global.getValor("indicador.ind_seguro")));
			    abonado.setClaseServicio(null);//Valor por defecto null no utilizada en VB
			    abonado.setPerfilAbonado(null);
			    
			    if(datosGeneralesVenta.getNumeroCelular() != null && !datosGeneralesVenta.getNumeroCelular().trim().equals(""))
				{
				    /*Obtiene prefijo min y min mdn*/
				    RegistroVentaDTO registroVenta = new RegistroVentaDTO();
				    registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
				    registroVenta = getPrefijoMin(registroVenta);
				    if (registroVenta != null)
				    	abonado.setNumMin(registroVenta.getPrefijoMin());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)
				    if (registroVenta == null){
				    	registroVenta = new RegistroVentaDTO();
				    	registroVenta.setNumeroCelular(Long.parseLong(datosGeneralesVenta.getNumeroCelular()));
				    }									    
				    registroVenta = registroVentaBO.getMinMDN(registroVenta);									    
				    abonado.setNumMinMdn(registroVenta.getMinMDN());// Se Obtiene de procedimineto AL_FN_PREFIJO_NUMERO(celular parametro)
				}
			    
			    
			    if( datosGeneralesVenta.getCodigoVendedorDealer() !=null && 
			    		!datosGeneralesVenta.getCodigoVendedorDealer().trim().equals(""))
			    {
			    	abonado.setCodVendealer(Long.parseLong(datosGeneralesVenta.getCodigoVendedorDealer()));
			    }									    
			    abonado.setIndPassword(null);	//nulo por defecto
			    abonado.setCodAfinidad(datosGeneralesVenta.getCodigoGrupoAfinidad());
			    abonado.setFecProrroga(null);									    
			    abonado.setIndEqPrestadoTerminal(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));
			    abonado.setFlgContDigi(null);	//Valor por defecto null, no es llenado en VB
			    abonado.setFecAltanTras(null); 	//Valor por defecto null, no es llenado en VB
		    	abonado.setCodIndemnizacion(Integer.parseInt(datosGeneralesVenta.getCodigoPlanIndemnizacion()));			    										    
			    abonado.setNumImei(datosGeneralesVenta.getNumeroSerieTerminal());									    
			    abonado.setCodTecnologia(datosGeneralesVenta.getCodigoTecnologia());
			    abonado.setFecActivacion(null);	//Valor por defecto null, no es llenado en VB
			    abonado.setCodOficinaPrincipal(abonadoAux.getCodOficinaPrincipal());
				logger.debug("sCausalDescuento : " + datosGeneralesVenta.getCodigoCausaDescuento());									    
			    abonado.setCodCausaVenta(datosGeneralesVenta.getCodigoCausaDescuento());

			    /* Datos nuevos GUATEMALA - EL SALVADOR */
			    abonado.setCodTipoPrestacion(datosGeneralesVenta.getCodTipPrestacion());
			    abonado.setMontoPreautorizado(datosGeneralesVenta.getMontoPreautorizado());
			    abonado.setCodMoneda(datosGeneralesVenta.getCodMoneda());
			    abonado.setValorRefXMinuto(datosGeneralesVenta.getValorRefXMinuto());
			    abonado.setObsInstancia(datosGeneralesVenta.getObsInstancia());
			    abonado.setImpCargo(datosGeneralesVenta.getImporteEquipo());
			    
			    //-- CREA ABONADO
			    sEstadoError = "NOK";
				sDetalleError = "Ocurrio un error al crear los SS";			
				abonado.setIndTelefono(Integer.valueOf(global.getValor("indicador.telefono")).intValue());
				
				//El tipo de terminal se inserta dependiendo de la tecnologia
			    String tipTerminalEquipo= "";
			    if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM"))) tipTerminalEquipo = "T";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.CDMA"))) tipTerminalEquipo = "D";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.TDMA"))) tipTerminalEquipo = "A";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.FIJO"))) tipTerminalEquipo = "F";
			    
			    //El tipo de terminal se inserta dependiendo de la tecnologia
			    String tipTerminalSimcard= "";
			    if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM"))) tipTerminalSimcard = "G";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.CDMA"))) tipTerminalSimcard = "D";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.TDMA"))) tipTerminalSimcard = "A";
			    else if(datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.FIJO"))) tipTerminalSimcard = "F";
			    
			    abonado.setTipTerminalEquipo(tipTerminalEquipo);
			    abonado.setTipTerminalSimcard(tipTerminalSimcard);
			    
			    abonado.setImpLimiteConsumo(datosGeneralesVenta.getImpLimiteConsumo());
			    
				if(!datosGeneralesVenta.getCodTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
				{
					
					//Creacion de usuario
					UsuarioDTO usuarioSec = usuarioBO.getSecuenciaUsuario();
					usuario.setCodigoUsuario(usuarioSec.getCodigoUsuario());						
					usuario.setCodigoCuenta(cliente.getCodigoCuenta());
					usuario.setCodigoSubCuenta(cliente.getCodigoSubCuenta());
					usuario.setCodEstrato(cliente.getCodigoEstrato());
					usuario.setNumAbonado(abonado.getNumAbonado());
					usuario.setCodTipoCliente(datosGeneralesVenta.getCodTipoCliente());					
					usuario = creacionUsuarioWeb(usuario);
					abonado.setCodUsuario(Long.parseLong(usuario.getCodigoUsuario()));
					
					if (!usuario.isExitoCreacionUsuario())
					{											
						sEstadoError = "NOK";
						sDetalleError = "Ocurrio un error al crear el Usuario";
						throw new CustomerDomainException("156", 0,
								"Ocurrio un error al crear el Usuario");
					}
					
				    String sCodOperacion = global.getValor("codigo.operacion.pospago");
				    abonado.setCodOperacion(sCodOperacion);
				    
					creaAbonado(abonado);
				}else {
					//TODO:Pasar a properties
					if(datosGeneralesVenta.getFlgSerieKit().trim().equals("1")) 
					{
						EquipoKitDTO kit = new EquipoKitDTO();
						kit.setNumKit(simcard.getNumeroSerie());
						kit.setCodTecnologia(datosGeneralesVenta.getCodigoTecnologia());
						kit =  getSerieEquipoKit(kit);
						abonado.setCodigoArticulo(String.valueOf(kit.getCodArticuloSimcard()));
						abonado.setNumSerieSimcard(kit.getNumSerieSimcard());
						abonado.setCodBodegaSimcard(String.valueOf(kit.getCodBodegaSimcard()));
						abonado.setTipoStockSimcard(kit.getTipoStockSimcard());
						
						abonado.setCodigoArticuloTerminal(String.valueOf(kit.getCodArticuloEquipo()));
						abonado.setNumSerieTerminal(kit.getNumSerieEquipo());
						abonado.setCodBodegaTerminal(String.valueOf(kit.getCodBodegaEquipo()));
						abonado.setTipoStockTerminal(kit.getTipoStockEquipo());							
					}
					
					UsuarioDTO usuarioSec = usuarioBO.getSecuenciaUsuario();
					abonado.setCodUsuario(Long.valueOf(usuarioSec.getCodigoUsuario()).longValue());
					
					
				    String sCodOperacion = global.getValor("codigo.operacion.prepago");
				    abonado.setCodOperacion(sCodOperacion);	
					creaAbonadoPrepago(abonado);
					
					usuario.setCodigoUsuario(usuarioSec.getCodigoUsuario());						
					usuario.setCodigoCuenta(cliente.getCodigoCuenta());
					usuario.setCodigoSubCuenta(cliente.getCodigoSubCuenta());
					usuario.setCodEstrato(cliente.getCodigoEstrato());
					usuario.setNumAbonado(abonado.getNumAbonado());
					usuario.setCodTipoCliente(datosGeneralesVenta.getCodTipoCliente());					
					usuario = creacionUsuarioWeb(usuario);
					abonado.setCodUsuario(Long.parseLong(usuario.getCodigoUsuario()));
					
					if (!usuario.isExitoCreacionUsuario())
					{											
						sEstadoError = "NOK";
						sDetalleError = "Ocurrio un error al crear el Usuario";
						throw new CustomerDomainException("156", 0,
								"Ocurrio un error al crear el Usuario");
					}
				}
	
			    //Ejecuta creación Abonados Red Celular ga_abocel (Simcard y Terminal).
			    abonado.setIndComodato(String.valueOf(datosGeneralesVenta.getIndicadorComodato()));				    
			    
			    if(datosGeneralesVenta.getIndicadorCuotas() != null){
			    	if(!datosGeneralesVenta.getIndicadorCuotas().equals("0"))
			    	   abonado.setIndPropiedad(global.getValor("indicador.propiedad.externo"));
			    	else
			    	   abonado.setIndPropiedad(global.getValor("indicador.propiedad.cuotas"));
			    }
			    else
			    	abonado.setIndPropiedad(global.getValor("indicador.propiedad.externo"));
			    
				abonado.setIndEqAcc(global.getValor("indicador.equiacc"));	
				if(datosGeneralesVenta.getCodCuota() != null)
				{
					abonado.setCodCuota(datosGeneralesVenta.getCodCuota().intValue());
				}
                //-- INSERTA EN ga_servsuplabo ( SERVICIOS SUPLEMENTARIOS )
				servicioSuplementario.setNumeroAbonado(String.valueOf(abonado.getNumAbonado()));
			    servicioSuplementario.setCodigoPlan(abonado.getCodPlanTarif());
			    servicioSuplementario.setNumeroTerminal(String.valueOf(abonado.getNumCelular()));
			    servicioSuplementario.setNomUsuario(datosGeneralesVenta.getNombreUsuarioOracle());
			    servicioSuplementario.setCodTecnologia(datosGeneralesVenta.getCodigoTecnologia());
			    servicioSuplementario.setTipoTerminal(abonado.getTipTerminal());
			    logger.debug("VentasSrv.creacionLineasWeb.creaSSAbonado:antes");
			    creaSSAbonado(servicioSuplementario); //Por defecto
			    logger.debug("VentasSrv.creacionLineasWeb.creaSSAbonado:antes");
			    //aqui deberia generar los SS opcionales
			    servicioSuplementario.setCadenaCodServs(datosGeneralesVenta.getServSuplAdicionales());
			    if (servicioSuplementario.getCadenaCodServs()!= null && !servicioSuplementario.getCadenaCodServs().trim().equals("")  )
			    { 
			    	creaSSOpAbonado(servicioSuplementario);
			    }				    
			    
			    //-- INSERTA EN ga_equipaboser
			    sEstadoError = "NOK";
				sDetalleError = "Ocurrio un error al asociar la simcard con el abonado";
			    abonado.setNumeroMovimiento(sNumeroMovtoSerieSimcard);				    
			    
			    //0: Inactivo
			    //1: Activo				    
			    if(datosPrestacion.getIndInventario() == 1 &&
			    		datosGeneralesVenta.getCodigoTecnologia().trim().equals(global.getValor("codigo.tecnologia.GSM")))
			    {
			    	logger.debug("VentasSrv.creacionLineasWeb.creaSimcardAboser:antes");
			    	creaSimcardAboser(abonado);
			    	logger.debug("VentasSrv.creacionLineasWeb.creaSimcardAboser:despues");
			    }
		    	

                //-- INSERTA EN ga_equipaboser
		    	sEstadoError = "NOK";
				sDetalleError = "Ocurrio un error al asociar el terminal con el Abonado";
			    abonado.setNumeroMovimiento(sNumeroMovtoSerieTerminal);
			    
			    //0: Inactivo
			    //1: Activo				    
			    if(datosPrestacion.getIndInventario() == 1)
			    {
			    		creaTerminalAboser(abonado);
			    }
			    
			    //-- INSERTA SEGURO EN ga_seguroabonado_to
				if(datosGeneralesVenta.getCodigoSeguro() != null && !datosGeneralesVenta.getCodigoSeguro().equals(""))
				{
					//-- INSERTAR SEGURO
					SeguroDTO seguro = new SeguroDTO();
					seguro.setCodSeguro(datosGeneralesVenta.getCodigoSeguro());
					seguro.setNumAbonado(abonado.getNumAbonado());
					seguro.setImporteEquipo(datosGeneralesVenta.getImporteEquipo());
					seguro.setNumEventos(0);
					seguro.setFechaFinContrato(datosGeneralesVenta.getFechaVigenciaSeguro());
					seguro.setNomUsuarora(datosGeneralesVenta.getNombreUsuarioOracle());
					insertaSeguroAbonado(seguro);	
					
					java.sql.Date fechaBaja = null;
					
					try{
						SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy");
						fechaBaja = new java.sql.Date(formatJava.parse(datosGeneralesVenta.getFechaVigenciaSeguro()).getTime());
					}catch(ParseException pe){
													
					}
					
					//--GENERA CARGO RECURRENTE ASOCIADO AL SEGURO
					SeguroDTO seguroDTO2 = new SeguroDTO();
					seguro.setPeriodo(datosGeneralesVenta.getNumMesesContrato().intValue());
					seguroDTO2=prestacionBO.obtieneDatosSeguro(seguro);
					seguro.setCodCargo(seguroDTO2.getCodCargo());
					seguro.setCodCliente(Long.valueOf(datosGeneralesVenta.getCodigoCliente()).longValue());
					seguro.setFechaAlta(new java.sql.Date(System.currentTimeMillis()));
					seguro.setFechaBaja(fechaBaja);
					seguro.setCodPlanServ(datosGeneralesVenta.getCodPlanServ());
					seguro.setCodConcepto(seguroDTO2.getCodConcepto());
					prestacionBO.insertaCargoRecurrenteSeguro(seguro);
				}	
				
				if (datosGeneralesVenta.getNumeroSolicitud()!=0){
			    	sEstadoError = "NOK";
					sDetalleError = "Ocurrio un error al actualizar los terminales vendidos en la Ev. de Riesgo";
			    	RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO = new RegistroEvaluacionRiesgoDTO();
			    	registroEvaluacionRiesgoDTO.setNumeroSolicitud(datosGeneralesVenta.getNumeroSolicitud());
			    	registroEvaluacionRiesgoDTO.setCantidadTerminales(1);
			    	registroEvaluacionRiesgoDTO.setCodigoPlanTarifario(datosGeneralesVenta.getCodigoPlanTarifario());
			    	registroEvaluacionRiesgoBO.actualizaTerminalesVendidos(registroEvaluacionRiesgoDTO);
			    }				    
			    
				//-- (+)EV 17/12/09, INSERTA niveles de prestacion a abonado
				if (datosGeneralesVenta.getCodNivel1()!=null && !datosGeneralesVenta.getCodNivel1().equals("")){
					NivelAbonadoDTO nivelAbonadoDTO = new NivelAbonadoDTO();
					nivelAbonadoDTO.setNumAbonado((new Long(abonado.getNumAbonado())).longValue());
					nivelAbonadoDTO.setCodNivel1(datosGeneralesVenta.getCodNivel1());
					nivelAbonadoDTO.setCodNivel2(datosGeneralesVenta.getCodNivel2());
					nivelAbonadoDTO.setCodNivel3(datosGeneralesVenta.getCodNivel3());
					abonadoBO.insertaNivelesAbonado(nivelAbonadoDTO);
				}
				//-- (-)EV 17/12/09, INSERTA niveles de prestacion a abonado
				
				//-- (+)EV 13/01/10, INSERTA datos adicionales del abonado
				RenovacionAbonadoDTO renovacionAbonadoDTO = new RenovacionAbonadoDTO();
				renovacionAbonadoDTO.setNumAbonado((new Long(abonado.getNumAbonado())).longValue());
				renovacionAbonadoDTO.setIndRenovacion(datosGeneralesVenta.getIndRenovacion());
				renovacionAbonadoDTO.setNumFax(datosGeneralesVenta.getNumFax());
				renovacionAbonadoDTO.setCodCalificacion(datosGeneralesVenta.getCodigoCalificacion());
				abonadoBO.insertaDatosAdicAbonado(renovacionAbonadoDTO);
				//-- (-)EV 13/01/10, INSERTA datos adicionales del abonado
				
			    resultado.setNum_abonado(new Long(abonado.getNumAbonado()));
			    resultado.setCod_ciclo(abonado.getCodCiclo());
			    resultado.setNumeroCelular(datosGeneralesVenta.getNumeroCelular());
			    resultado.setCodigoCalificacion(cliente.getCodCalificacion());
			    resultado.setCodigoRegion(datosGeneralesVenta.getCodigoRegion());
			    resultado.setCodigoProvincia(datosGeneralesVenta.getCodigoProvincia());
			    resultado.setCodigoCiudad(datosGeneralesVenta.getCodigoCiudad());
			    resultado.setCodigoCalificacion(cliente.getCodCalificacion());
		}catch(CustomerDomainException e){
			logger.debug("INICIO creacionLineas SRV 37.1 ");										
			resultado.setEstadoError(sEstadoError);
	    	resultado.setDetalleError(sDetalleError);
	    	throw e;
		}catch(ProductDomainException e){
			logger.debug("INICIO creacionLineas SRV 37.2 ");										
			resultado.setEstadoError(sEstadoError);
	    	resultado.setDetalleError(sDetalleError);
	    	throw e;
		}
		
		logger.debug("Fin:creacionLineas()");			
		//-- Registra campaña a nivel de abonado
		logger.debug("codigo campana vigente: " + datosGeneralesVenta.getAplicaCampanaA());			
		if(!resultado.getEstadoError().equals("NOK")){ //-- no hubo error
			logger.debug("INICIO creacionLineas SRV 37.5 ");
			if (datosGeneralesVenta.getAplicaCampanaA() !=null && 
					datosGeneralesVenta.getAplicaCampanaA().equals(global.getValor("aplica.campana.a.abonado")))
			{
				logger.debug("INICIO creacionLineas SRV 37.6 ");
				logger.debug("aplica campaña a abonado..." + abonado.getNumAbonado());
				CampanaVigenteDTO campanaVigenteDTO = new CampanaVigenteDTO();
				campanaVigenteDTO.setCodigoCampanasVigentes(datosGeneralesVenta.getCodigoCampana());
				campanaVigenteDTO.setCodigoCliente(Long.parseLong(datosGeneralesVenta.getCodigoCliente()));
				campanaVigenteDTO.setNumeroAbonado(abonado.getNumAbonado());
				registraCampanaVigente(campanaVigenteDTO);
			}
		}
		
		logger.debug("FIN creacionLineas SRV");
		return resultado;
	}//fin creacionLineas	
	
	public UsuarioWebDTO creacionUsuarioWeb(UsuarioWebDTO usuario)
		throws CustomerDomainException
	{		
		logger.debug("Inicio:creacionUsuario()");
		if(!usuario.getCodTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
		{
			//--Usuario CONTRATO
			usuario = usuarioBO.creaNuevoUsuarioWeb(usuario);
			
			for(int i=0; i<usuario.getDirecciones().length;i++)
			{
				DireccionNegocioWebDTO dirNeg = usuario.getDirecciones()[i];
				creaDireccion(dirNeg);
			}
			
			// Creacion direccion - usuario
			usuarioBO.insDireccionUsuarioWeb(usuario);	
			
		}else {
			//--Usuario PREPAGO
			usuario = usuarioBO.creaNuevoUsuarioWebPrepago(usuario);
			
			//--Segun negocio no se inserta la direccion de usuario cuando es un prepago
		}
		
		logger.debug("Fin:creacionUsuario()");
		return usuario;
	}	
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getParametroGeneral()");
		ParametrosGeneralesDTO resultado = parametrosGeneralesBO.getParametroGeneral(entrada);				
		logger.debug("Fin:getParametroGeneral()");
		return resultado;			
	}
	
	public OficinaDTO getDireccionOficina(String codOficina)
		throws CustomerDomainException
	{
		logger.debug("Inicio:getDireccionOficina()");
		OficinaDTO resultado = oficinaBO.getDireccionOficina(codOficina);				
		logger.debug("Fin:getDireccionOficina()");
		return resultado;			
	}
	
	public void validarPlanCompartido(Long codCliente, String codPlanTarif)
		throws CustomerDomainException
	{
		logger.debug("Inicio:validarPlanCompartido()");
		abonadoBO.validarPlanCompartido(codCliente, codPlanTarif);				
		logger.debug("Fin:validarPlanCompartido()");			
	}

	public UsuarioSCLDTO validarUsuarioSinPerfil(UsuarioSCLDTO entrada)
		throws CustomerDomainException
	{
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		logger.debug("Inicio:validarUsuarioSinPerfil()");
		respuesta=usuarioSCLBO.validaUsuarioSinPerfil(entrada);				
		logger.debug("Fin:validarUsuarioSinPerfil()");
		return respuesta;			
	}	
	
	/**
	 * Realiza validación de Ventas a nueva linea.
	 * @param entrada
	 * @return resultadoValidacion
	 * @throws CustomerDomainException
	 */	
	public ResultadoValidacionVentaDTO validacionLineaWeb(ParametrosValidacionVentasDTO entrada)
		throws CustomerDomainException,ProductDomainException,ResourceDomainException
	{
		ResultadoValidacionVentaDTO resultadoValidacion = new ResultadoValidacionVentaDTO();
	    double impCargo = 0;
		logger.debug("Inicio:validacionLinea()");
		
		 //-- OBTIENE PARAMETRO : PRECIO LISTA
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
		String sPrecioLista = parametrosGeneralesDTO.getValorparametro();
		
		PrecioCargoDTO[] precioCargoDTOs = null;
		
		if(!entrada.getCodigoTecnologia().trim().equals("CDMA"))
		{
		
			// ( 43 ) Verifica si serie simcard existe en abonado					
			resultadoValidacion = abonadoBO.existeSerieSimcardEnAbonado(entrada);
			if (resultadoValidacion.isResultado()){
				logger.debug("INICIO validacionLinea VentasSrv 1 NOK ");
				resultadoValidacion.setCodigoError("-1");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Serie simcard existe en abonado");
				return resultadoValidacion;
			}
			
			//Valida existencia de codigo de actuacion para la tecnologia
			try{
				CentralDTO central = new CentralDTO();
				central.setCodActabo(entrada.getCodigoActuacion());
				central.setCodigoTecnologia(entrada.getCodigoTecnologia());
				centralBO.validarActuacion(central);
			}catch(ResourceDomainException e){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setCodigoError("-2126");
				resultadoValidacion.setDetalleEstado("No se encuentra el codigo de actuacion asociado a la central");
				return resultadoValidacion;
			}		
			
			//Valida que el vendedor tenga acceso a bodega de la simcard	
			SimcardDTO simcard = new SimcardDTO();
			simcard.setNumeroSerie(entrada.getNumeroSerie());
			simcard = simcardBO.getSimcard(simcard);
			
			//Valida que el articulo asociado a la simcard tenga configurado precio
			ParametrosCargoSimcardDTO parametrosCargoSimcardDTO = new ParametrosCargoSimcardDTO();
			parametrosCargoSimcardDTO.setCodigoArticulo(simcard.getCodigoArticulo());				
			parametrosCargoSimcardDTO.setCodigoUso(entrada.getCodigoUsoLinea());				
			parametrosCargoSimcardDTO.setEstado(global.getValor("estado.articulo"));		
			parametrosCargoSimcardDTO.setModalidadVenta(String.valueOf(entrada.getModalidadVenta()));		
			parametrosCargoSimcardDTO.setTipoContrato(entrada.getCodigoTipoContrato());		
			parametrosCargoSimcardDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());		
			parametrosCargoSimcardDTO.setCodigoUsoPrepago(global.getValor("codigo.uso.prepago"));		
			parametrosCargoSimcardDTO.setTipoStock(simcard.getTipoStock());		
			parametrosCargoSimcardDTO.setCodigoCategoria(simcard.getCodigoCategoria());
			
			if(entrada.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago"))){
				parametrosCargoSimcardDTO.setCodigoCategoria(global.getValor("codigo.categoria"));
				parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.prepago"));
			}else parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.pospago"));
			
			parametrosCargoSimcardDTO.setIndicadorEquipo(global.getValor("indicador.equiacc"));
			parametrosCargoSimcardDTO.setCodigoCalificacion(entrada.getCodigoCalificacion());			
			parametrosCargoSimcardDTO.setIndRenovacion(entrada.getIndRenovacion());
			
			
			try{
				if (sPrecioLista.equals(global.getValor("indicador.precio.lista"))){
					//parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.preciolista"));
					precioCargoDTOs = simcardBO.getPrecioCargoSimcard_PrecioLista(parametrosCargoSimcardDTO);				
				}else{
					//parametrosCargoSimcardDTO.setIndiceRecambio(global.getValor("indice.recambio.nolista"));
					precioCargoDTOs = simcardBO.getPrecioCargoSimcard_NoPrecioLista(parametrosCargoSimcardDTO);
				}
				if (precioCargoDTOs == null)
				{				
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setCodigoError("-2126");				
					resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
					return resultadoValidacion;
				}
			}catch(ProductDomainException e){
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setCodigoError("-2126");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado a la Simcard");
				return resultadoValidacion;
			}
		}//fin tecnologia distinta a CDMA
		
		// Verifica si el vendedor tiene acceso a la bodega del teminal
		TerminalDTO terminal = new TerminalDTO();
		terminal.setNumeroSerie(entrada.getNumeroSerieTerminal());
		terminal = terminalBO.getTerminal(terminal);
		
		//Verifica que el Articulo asociado al terminal tenga precio.
		if (terminal.getIndProcEq() != null && terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
		{	
			
			ParametrosCargoTerminalDTO parametrosCargoTerminalDTO = new ParametrosCargoTerminalDTO();
			parametrosCargoTerminalDTO.setCodigoArticulo(terminal.getCodigoArticulo());
			parametrosCargoTerminalDTO.setCodigoUso(entrada.getCodigoUsoLinea());
			parametrosCargoTerminalDTO.setEstado(global.getValor("estado.articulo"));
			parametrosCargoTerminalDTO.setModalidadVenta(String.valueOf(entrada.getModalidadVenta()));
			parametrosCargoTerminalDTO.setTipoContrato(entrada.getCodigoTipoContrato());
			parametrosCargoTerminalDTO.setPlanTarifario(entrada.getCodigoPlanTarifario());
			parametrosCargoTerminalDTO.setCodigoUsoPrepago(global.getValor("codigo.uso.prepago"));								
			parametrosCargoTerminalDTO.setTipoStock(terminal.getTipoStock());			
			parametrosCargoTerminalDTO.setCodigoCategoria(terminal.getCodigoCategoria());
			if(entrada.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago"))){
				parametrosCargoTerminalDTO.setCodigoCategoria(global.getValor("codigo.categoria"));
				parametrosCargoTerminalDTO.setIndiceRecambio(global.getValor("indice.recambio.prepago"));
			}else parametrosCargoTerminalDTO.setIndiceRecambio(global.getValor("indice.recambio.pospago"));
			
			parametrosCargoTerminalDTO.setIndicadorEquipo(global.getValor("indicador.equiacc"));	
			parametrosCargoTerminalDTO.setCodigoCalificacion(entrada.getCodigoCalificacion());
			parametrosCargoTerminalDTO.setIndRenovacion(entrada.getIndRenovacion());
			try{				
				if (sPrecioLista.equals(global.getValor("indicador.precio.lista")))
				{
					precioCargoDTOs = terminalBO.getPrecioCargoTerminal_PrecioLista(parametrosCargoTerminalDTO);					
				}
				else{										
					precioCargoDTOs = terminalBO.getPrecioCargoTerminal_NoPrecioLista(parametrosCargoTerminalDTO);					
				}
				if (precioCargoDTOs == null){
					resultadoValidacion.setEstado("NOK");
					resultadoValidacion.setCodigoError("-2127");
					resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
					return resultadoValidacion;
				}else {
					impCargo = precioCargoDTOs[0].getMonto();
				}				
			}catch(ProductDomainException e){				
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setCodigoError("-2127");
				resultadoValidacion.setDetalleEstado("No se encuentra precio para el Articulo asociado al Terminal");
				return resultadoValidacion;
			}			


			// ( 55 ) Verifica si serie terminal existe en abonado					
			resultadoValidacion = abonadoBO.existeSerieTerminalEnAbonado(entrada);
			if (resultadoValidacion.isResultado()){	
				logger.debug("INICIO validacionLinea VentasSrv 20 NOK");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Serie terminal existe en abonado");
				resultadoValidacion.setCodigoError("-1");
				return resultadoValidacion;
			}		
		}
		
		// Verifica si la modalidad de venta es credito, el terminal no sea externo
		if (!terminal.getIndProcEq().equals(global.getValor("indicador.procedencia.interna")))
		{		
			ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
			parametrosGral.setNombreparametro(global.getValor("parametro.modalidad.venta.credito"));
			parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);

			if (parametrosGral.getValorparametro().equals(entrada.getCodigoModalidadVenta())){
				logger.debug("INICIO validacionLinea VentasSrv 25 NOK");
				resultadoValidacion.setEstado("NOK");
				resultadoValidacion.setDetalleEstado("Para venta a credito terminal no puede ser externo");
				resultadoValidacion.setCodigoError("-1");
				return resultadoValidacion;
			}
		}
		resultadoValidacion.setEstado("OK");
		resultadoValidacion.setDetalleEstado("-");
		resultadoValidacion.setPrecioEquipo(impCargo);
		logger.debug("Fin:validacionLinea()");		
		return resultadoValidacion;
	}//fin validacionLinea
	
	public void insReservaArticulo(ArticuloDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getDireccionOficina()");
		articuloBO.insReservaArticulo(entrada);				
		logger.debug("Fin:getDireccionOficina()");				
	}
	
	public ArticuloDTO ActualizaStock(ArticuloDTO entrada)
		throws ProductDomainException
	{
		ArticuloDTO resultado = new ArticuloDTO();
		logger.debug("Inicio:getDireccionOficina()");
		resultado = articuloBO.ActualizaStock(entrada);				
		logger.debug("Fin:getDireccionOficina()");			
		return resultado;
	}
	
	public void creaAbonadoPrepago(AbonadoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("Inicio:creaAbonadoPrepago()");
		abonadoBO.creaAbonadoPrepago(entrada);
		logger.debug("Fin:creaAbonadoPrepago()");		
	}
	
	public SimcardDTO getSimcard(SimcardDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getSimcard()");
		SimcardDTO resultado = simcardBO.getSimcard(entrada); 
		logger.debug("Inicio:getSimcard()");
		return resultado;
	}//fin getSimcard
	
	public TerminalDTO getTerminal(TerminalDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getTerminal()");
		TerminalDTO resultado = terminalBO.getTerminal(entrada); 
		logger.debug("Inicio:getTerminal()");
		return resultado;
	}//fin getSimcard
	
	public FolioDTO getFolio(FolioDTO entrada)
		throws CustomerDomainException
	{
		FolioDTO resultado = new FolioDTO();
	
	     logger.debug("Inicio:getFolio()");
		 resultado= facturaBO.getFolio(entrada); 
		logger.debug("Inicio:getFolio()");
		return resultado;
	}//fin getFolio
	
	public EquipoKitDTO getSerieEquipoKit(EquipoKitDTO entrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:getSerieEquipoKit()");
		EquipoKitDTO resultado = simcardBO.getSerieEquipoKit(entrada); 
		logger.debug("Inicio:getSerieEquipoKit()");
		return resultado;
	}//fin getSerieEquipoKit	
		
	public void validarActuacion(CentralDTO central) 
		throws ResourceDomainException
	{
		logger.debug("Inicio:validarActuacion()");
		centralBO.validarActuacion(central);
		logger.debug("Fin:validarActuacion()");
	}//fin validarActuacion	
	
	
	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada)
		throws CustomerDomainException 
	{
		logger.debug("VentasSrv:getVentasXVendedor():start");
		ListadoVentasDTO[] resultado = registroVentaBO.getVentasXVendedor(entrada);
		logger.debug("VentasSrv:getVentasXVendedor():end");
		return resultado;
	}//fin getVentasXVendedor
	
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getListadoVendedoresXOficina()");
		VendedorDTO[] resultado = vendedorBO.getListadoVendedoresXOficina(vendedor);
		logger.debug("Fin:getListadoVendedoresXOficina()");
		return resultado;		
	}//fin getListadoVendedoresXOficina
	
	public AbonadoDTO[] getListadoAbonadosVenta(AbonadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:getListadoAbonadosVenta()");
		AbonadoDTO[] resultado = abonadoBO.getListadoAbonadosVenta(entrada);
		logger.debug("Fin:getListadoAbonadosVenta()");
		return resultado;		
	}//fin getListadoAbonadosVenta	
	
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) 
		throws CustomerDomainException
	{
		logger.debug("getRangoDescuento():start");
		VendedorDTO resultado = vendedorBO.getRangoDescuento(vendedor);
		logger.debug("getRangoDescuento():end");
		return resultado;
	}//fin getRangoDescuento
	
	public void eliminaAbonado(AbonadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("eliminaAbonado():start");
		abonadoBO.eliminaAbonado(entrada);
		logger.debug("eliminaAbonado():end");		
	}//fin eliminaAbonado
	
	public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada) 
		throws CustomerDomainException,ProductDomainException , FrameworkCargosException, GeneralException
	{
		logger.debug("getCargosVta():start");	
		CargoSolicitudDTO[] resultado = registroVentaBO.getCargosVta(entrada);
		logger.debug("getCargosVta():end");
		return resultado;
	}//fin getCargosVta
	
	public ImpuestosDTO actualizarDsctosManuales(ListadoCargoSolicitudDTO entrada) 
		throws CustomerDomainException, GeneralException
	{
		logger.debug("actualizarDsctosManuales():start");		
		double montoDescuentoManual = 0;
		double montoDescuentoAutomatico = 0;
		double montoDescuentoAutomaticoConImpuesto = 0;
		double montoDescuentoTotalLinea = 0;
		double cargoSinDesctoManual = 0;
		
		//Se obtiene la operadora
		String operadora = datosGeneralesBO.getCodigoOperadora();
		logger.debug("operadora:" + operadora);		
		
		for (int k=0; k< entrada.getCargos().length;k++)
		{
			CargoSolicitudDTO cargo = entrada.getCargos()[k];
			montoDescuentoAutomatico=0;
			montoDescuentoAutomaticoConImpuesto=0;
			//Calcula descuento automatico
		    if (cargo.getValDctoSinImpuesto() != 0)
		    {		    	
		    	if (cargo.getTipDcto() == TipoDescuentos.Porcentaje)
		    	{		    		
		    		//Se resta el descuento manual del importe en caso que sea porcentaje		    				    		
		    		montoDescuentoAutomatico = ( (cargo.getValDctoSinImpuesto()/100) * cargo.getImpCargo() * cargo.getCantidadManual() );
		    		montoDescuentoAutomaticoConImpuesto = ( (cargo.getValDcto()/100) * cargo.getImpCargo() * cargo.getCantidadManual() );
		    	   
		    	}else{
			    	montoDescuentoAutomatico = cargo.getValDctoSinImpuesto() * cargo.getCantidad();
			    	montoDescuentoAutomaticoConImpuesto = cargo.getValDcto() * cargo.getCantidad();
		    	}
		    }	
			
			//Calcula descuento manual
		    if (cargo.getValDctoManual() != 0)
		    {		    	
		    	if (cargo.getTipDctoManual() == TipoDescuentos.Porcentaje)
		    	{
		    		
		    		cargoSinDesctoManual = cargo.getImpCargo() - montoDescuentoAutomaticoConImpuesto;
		    		montoDescuentoManual = ( (cargo.getValDctoManual()/100) * cargoSinDesctoManual * cargo.getCantidadManual() );
		    	}   else
			    	montoDescuentoManual = cargo.getValDctoManual() * cargo.getCantidadManual();
		    }
		    
		    
		    //Se obtiene codigo concepto descuento manual
		    ParametrosDescuentoDTO paramDescto = new ParametrosDescuentoDTO();
			paramDescto.setCodigoConcepto(String.valueOf(cargo.getCodConcepto()));
			paramDescto.setTipoConcepto("2");
			DescuentoDTO descuento = simcardBO.getCodigoDescuentoManual(paramDescto);
		    
		    //Comento hasta que se defina bien el tema del impuesto		    
		    if(operadora.trim().equals(global.getValor("operadora.guatemala")) && montoDescuentoManual > 0)
			{
				//Para GUATEMALA al descuento manual hay que descontarle el impuesto
				ImpuestosDTO impuestos = new ImpuestosDTO();
				impuestos.setCodigoCliente(entrada.getCodCliente());
				impuestos.setCodOficina(cargo.getCodOficina());
				impuestos.setMontoDsctoManual(montoDescuentoManual);
				if(descuento.getCodigoConcepto() != null && !descuento.getCodigoConcepto().trim().equals(""))
				{
					impuestos.setCodigoConcepto(Long.valueOf(descuento.getCodigoConcepto()).longValue());
				} else impuestos.setCodigoConcepto(0);
				ImpuestosDTO resultado = registroFacturacionBO.getImpuestoDesctoManual(impuestos);
				
				double porcentajeResult = (resultado.getMontoDsctoManual() * 100) / montoDescuentoManual;
				logger.debug("porcentajeResult:" + porcentajeResult);
				double descManualAntesImpuesto = (montoDescuentoManual * 100) / porcentajeResult ;
				logger.debug("descManualAntesImpuesto:" + descManualAntesImpuesto);
				montoDescuentoManual = descManualAntesImpuesto;
						
			}		
		    
		    montoDescuentoTotalLinea = montoDescuentoManual + montoDescuentoAutomatico;		    
		    
			if(montoDescuentoTotalLinea != 0)
			{  		
				cargo.setMontoTotalDescuento(new Float(montoDescuentoTotalLinea).floatValue());
				if(descuento.getCodigoConcepto() != null )
				{
					cargo.setCodConceptoDctoManual(Long.valueOf(descuento.getCodigoConcepto()).longValue());
				}
				descuentoBO.actualizarDsctosManuales(cargo);
			}
			
			montoDescuentoManual = 0;
			montoDescuentoAutomatico = 0;
			montoDescuentoTotalLinea = 0;
		}
		
		//Se actualizan todos los cargos (incluidos los de planes adicionales) a 1
		registroFacturacionBO.atualizaIndFacturCargos(new Long(entrada.getNumVenta()));
		
		//Obtiene categoria tributaria del cliente
		ClienteDTO cliente = new ClienteDTO();
 		cliente.setCodigoCliente(String.valueOf(entrada.getCodCliente()));
 		cliente =  clienteBO.getCategoriaTributariaCliente(cliente);
		
		//Llama a prebilling		
		ImpuestosDTO impuesto = new ImpuestosDTO();
		impuesto.setEsVentaRegalo("N");
		Long cantidadCargos = registroCargosBO.getCantidadCargosXVenta(new Long(entrada.getNumVenta()));		
		if(cantidadCargos.longValue() >0)
		{	
			RegistroFacturacionDTO registroFact = new RegistroFacturacionDTO();
			
			RegistroVentaDTO registroVenta = new RegistroVentaDTO();
			registroVenta.setCodigoSecuencia(global.getValor("secuencia.transacabo"));
			registroVenta = registroVentaBO.getSecuenciaTransacabo(registroVenta);
			
			registroFact.setCodigoSecuencia(global.getValor("secuencia.num.proceso.fac"));
			registroFact = registroFacturacionBO.getSecuenciaProcesoFacturacion(registroFact);
			
			registroFact.setSecuenciaTransacabo(String.valueOf(registroVenta.getNumeroTransaccionVenta()));
			registroFact.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
			registroFact.setCodigoCliente(String.valueOf(entrada.getCodCliente()));		
			registroFact.setActuacionPrebilling(global.getValor("codigo.actuacion.prebilling"));
			registroFact.setProductoGeneral(global.getValor("codigo.producto.general"));
			//El Numero de Transaccion es unico por venta.
			registroFact.setNumeroTransaccionVenta(new Long (entrada.getNumTransaccionVta()).toString());
			registroFact.setCodigoOficina(entrada.getCodOficina());
			registroFact.setCodigoTipoDocumento(entrada.getCodTipoDocumento());
			registroFact.setModalidadVenta(entrada.getCodModVenta());
			registroFact.setCategoriaTributaria(cliente.getCategoriaTributaria().substring(0,1));
			
			//Obtiene Parametros Factura Global
			String sValorDocumentoGuia;
			String sValorFacturaGlobal;
			String sValorFlagCentroFact;		
			
			DatosGeneralesDTO datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(global.getValor("parametro.factura.global"));
			datosGral.setCodigoProducto(global.getValor("codigo.producto"));
			datosGral.setCodigoModulo(global.getValor("codigo.modulo.GA"));
			datosGral = datosGeneralesBO.getValorParametro(datosGral);		
			
			sValorFacturaGlobal = datosGral.getValorParametro();
			
			//Obtiene Parametros Documento Guia
			datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(global.getValor("parametro.documento.guia"));
			datosGral.setCodigoProducto(global.getValor("codigo.producto"));
			datosGral.setCodigoModulo(global.getValor("codigo.modulo.GA"));
			datosGral = datosGeneralesBO.getValorParametro(datosGral);		
			
			sValorDocumentoGuia = datosGral.getValorParametro();
			 
			//Obtiene Parametros Flag Centro Facturación
			datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(global.getValor("parametro.flag.centro.emision.fact"));
			datosGral.setCodigoProducto(global.getValor("codigo.producto"));
			datosGral.setCodigoModulo(global.getValor("codigo.modulo.GA"));
			datosGral = datosGeneralesBO.getValorParametro(datosGral);		
			
			sValorFlagCentroFact = datosGral.getValorParametro();	
			
			registroFact.setValorParametroFlagCentroFact(sValorFlagCentroFact);		
			registroFact.setValorParametroFacturaGlobal(sValorFacturaGlobal);
			registroFact.setValorParametroDocumentoGuia(sValorDocumentoGuia);
			registroFact.setCodigoTipoMovimiento(global.getValor("codigo.tipo.movimiento"));
			registroFact.setCodigoTipoFoliacion(global.getValor("parametro.tip_foliacion"));
			
			registroFact = registroFacturacionBO.getModoGeneracion(registroFact);
			
			
			//Verifica si es venta regalo
			Long importeVta = verificaVentaCero_Regalo(Long.valueOf(registroFact.getNumeroVenta()));
			if(importeVta.longValue() == 0)
			{
				
				//Se obtiene modalidad de pago venta Regalo
				ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
				parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
				parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
				parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.modalida.venta.regalo"));
				parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
				String codModVentaRegalo = parametrosGeneralesDTO.getValorparametro();		
				
				//Se cambia modalidad de pago
				updateModalidaVenta(Long.valueOf(registroFact.getNumeroVenta()), Long.valueOf(codModVentaRegalo) );
				impuesto.setEsVentaRegalo("S");
			}
			
					
			registroFacturacionBO.ejecutaPrebilling(registroFact);
		
			impuesto.setNumeroProceso(registroFact.getNumeroProcesoFacturacion());
			impuesto = registroFacturacionBO.getDatosPresupuesto(impuesto);	
			impuesto.setCategoriaTributaria(cliente.getCategoriaTributaria());
			
			//Verifica si al ejecura el prebilling hubo un error
			datosGral = new DatosGeneralesDTO();
			datosGral.setNumTransaccion(registroFact.getSecuenciaTransacabo());
			datosGral = datosGeneralesBO.getResultadoTransaccion(datosGral);		
			//try{
				if (datosGral.getCodError()!=0){
					logger.debug("No se ejecuto correctamente el Prebilling");
					ProcesoDTO proceso = new ProcesoDTO();
					proceso.setIdentificadorProceso(IdentificadorProceso.EjecutaPrebilling);
					proceso.setEstadoEjecucion(false);
					proceso.setCodigoError(datosGral.getCodError());
					//componerBitacora(proceso);
					int numevento = 1;
					throw new CustomerDomainException(String.valueOf(datosGral.getCodError()),
							numevento, "No se ejecuto correctamente la prefacturacion");							
				}
			/*}catch (GeneralException e) {
				logger.debug("GeneralException");
				logger.debug("Error: al ejecutar Prebilling");
				logger.debug("datosGral.getCodError() ["+datosGral.getCodError()+"]");
				logger.debug("datosGral.getCodError() ["+datosGral.getMnsError()+"]");
				logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
				logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
				logger.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
				throw e;			
			}*/
				
			//Obtiene ind_cuota de la modalidad de venta
			ModalidadPagoDTO modalidadPagoDTO = new ModalidadPagoDTO();
			modalidadPagoDTO.setCodigoModalidadPago(registroFact.getModalidadVenta().trim());
			modalidadPagoDTO = getModalidadPago(modalidadPagoDTO);
			if(modalidadPagoDTO.getIndicadorCuotas().trim().equals("1"))
			{				
				impuesto.setTotalCargos(0);
				impuesto.setTotalDescuentos(0);
				impuesto.setTotalImpuestos(0);
			}
				
		}else {
			impuesto.setCategoriaTributaria(cliente.getCategoriaTributaria());
			impuesto.setTotalCargos(0);
			impuesto.setTotalDescuentos(0);
			impuesto.setTotalImpuestos(0);
		}
		
		
		
		logger.debug("actualizarDsctosManuales():end");
		return impuesto;
	}//fin actualizarDsctosManuales
	
	public void insertaCobroAdelantado(CobroAdelantadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("insertaCobroAdelantado():start");
		facturaBO.insertaCobroAdelantado(entrada);
		logger.debug("insertaCobroAdelantado():end");		
	}//fin insertaCobroAdelantado
	
	public ResultadoValidacionVentaDTO validaSerieExterna(ParametrosValidacionVentasDTO entrada) 
		throws CustomerDomainException
    {
    	ResultadoValidacionVentaDTO resultadoValidacion= new ResultadoValidacionVentaDTO();
    	resultadoValidacion = abonadoBO.validaSerieTermialEnListaNegra(entrada);
		if (resultadoValidacion.isResultado())
		{
			logger.debug("INICIO validacionLinea VentasSrv 22 NOK");
			resultadoValidacion.setEstado("NOK");
	    }else
	    {
	    	resultadoValidacion.setEstado("OK");
	    }
	
		return resultadoValidacion;
    }	
	
	public void aceptarPresupuesto(GaVentasDTO entrada)
		throws CustomerDomainException, ProductDomainException, FrameworkCargosException
	{	
			
		   	//Se actualiza el estado de la venta
		    //Se verifica si en la venta hay al menos un abonado carrier
		    
			DatosGenerDTO cantidades = prestacionBO.getCantidadCarrier(entrada.getNumVenta());
			
			if(cantidades.getCantAbonadosCarrier() > 0 && cantidades.getCantAbonadosCarrier() == cantidades.getCantAbonados() )
			{
				//Cambia estado cuando es carrier
				entrada.setIndEstVenta(global.getValor("indicador.ind_estadoventa.PA"));
				
				//Actualiza la icc_movimiento a 1 del carrier				
				GaVentasDTO gaVenta = new GaVentasDTO();		
				gaVenta.setNumVenta(entrada.getNumVenta());
				gaVenta.setNomUsuarora(entrada.getNomUsuarora());
				
				AbonadoDTO[] listaAbonados = abonadoBO.getListaAbonadosCarrier(entrada.getNumVenta());				
				
				logger.debug("INICIO obtenercargos listaAbonados Carrier: " + listaAbonados.length);				
				for(int i=0;i<listaAbonados.length;i++)
				{				
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(listaAbonados[i].getNumAbonado());
					gaVenta.setAbonado(abonadoDTO);
					
					registroVentaBO.updateVentaDesbloqueo(gaVenta);				
				}
				
			}else if(cantidades.getCantAbonadosCarrier() >0 && (cantidades.getCantAbonadosCarrier() != cantidades.getCantAbonados())) 
			{
				//Actualiza la icc_movimiento a 1 del carrier				
				GaVentasDTO gaVenta = new GaVentasDTO();		
				gaVenta.setNumVenta(entrada.getNumVenta());
				gaVenta.setNomUsuarora(entrada.getNomUsuarora());
				
				AbonadoDTO[] listaAbonados = abonadoBO.getListaAbonadosCarrier(entrada.getNumVenta());				
				
				logger.debug("INICIO obtenercargos listaAbonados Carrier: " + listaAbonados.length);				
				for(int i=0;i<listaAbonados.length;i++)
				{				
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumAbonado(listaAbonados[i].getNumAbonado());
					gaVenta.setAbonado(abonadoDTO);
					
					registroVentaBO.updateVentaDesbloqueo(gaVenta);				
				}
				
				entrada.setIndEstVenta(global.getValor("indicador.ind_estadoventa.aceptada"));
				
			}else {
				entrada.setIndEstVenta(global.getValor("indicador.ind_estadoventa.aceptada"));
				
			}
			
			String mascara =new String();  
			String TotalFormateado= new String();
			
			ParametrosGeneralesDTO parametrosGeneralesDTO=new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.decimal.despliegue"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			parametrosGeneralesDTO.setValorparametro(parametrosGeneralesDTO.getValorparametro()==null?"":parametrosGeneralesDTO.getValorparametro());
			for (int i=0;i<Integer.parseInt(parametrosGeneralesDTO.getValorparametro());i++){
				mascara= mascara + "0";
				}
			
			if (mascara.equals("")){
				mascara="##0";
			}else{
				mascara="##0." + mascara;
			} 
				
			TotalFormateado= (Formatting.number(entrada.getImpVenta().floatValue(), mascara));
			
			entrada.setImpVentaS(TotalFormateado);
			
			registroVentaBO.updateSituacionVenta(entrada);
			
			//Se actualiza código situación de los abonados
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			abonadoDTO.setNumVenta(entrada.getNumVenta().longValue());
			
			//Si es prepago siempre debe quedar en AOP
			if(entrada.getTipoCliente() != null && entrada.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago")))
			{
				abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalO"));				
			}else{
				
				if (entrada.getIndOfiter().equals("O")){
					abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalO"));
				}else if (entrada.getIndOfiter().equals("T")){
					abonadoDTO.setCodSituacion(global.getValor("codigo.situacion.finalT"));						
				}
			}
			abonadoBO.updCodigoSituacion(abonadoDTO);
			
			logger.debug("aceptarPresupuesto():start");		
			ParametrosEjecucionFacturacionDTO parametros = new ParametrosEjecucionFacturacionDTO();
			parametros.setNumeroProcesoFacturacion(String.valueOf(entrada.getNumProceso()));
			parametros.setNumeroVenta(String.valueOf(entrada.getNumVenta()));				
			ejecutarFacturacion(parametros);		
			logger.debug("aceptarPresupuesto():end");	
			
			//Se llama al procedimiento del desbloqueo para todas las lineas moviles asociadas a la venta
	    	RegistroVentaDTO regVenta = new RegistroVentaDTO();		
			regVenta.setNumeroVenta(entrada.getNumVenta().longValue());				
			AbonadoDTO[] listaAbonados = abonadoBO.getListaAbonadosVenta(regVenta);			
			
			// INICIO INC 187717 26/09/2012
			int codErrorTerminal;
			
			for(int i=0;i<listaAbonados.length;i++)
			{
				AbonadoDTO abonado_aux = new AbonadoDTO();
				abonado_aux.setNumAbonado(listaAbonados[i].getNumAbonado());
				abonado_aux.setIndProcEqTerminal(global.getValor("indicador.procedencia.interna"));
				AbonadoDTO[] equiposSeriados =  abonadoBO.getEquiposSeriados(abonado_aux);
				logger.debug("Inicio recorre equipaboser para el abonado...");
				
				logger.debug("187717 Desreserva INICIO");
				
				for(int j=0;j<equiposSeriados.length;j++)
				{
					AbonadoDTO abonadoDTO_aux = new AbonadoDTO();
					abonadoDTO_aux .setNumAbonado(listaAbonados[i].getNumAbonado());
					abonadoDTO_aux .setTipoStock(equiposSeriados[j].getTipoStock());
					abonadoDTO_aux .setCodigoBodegaActual(equiposSeriados[j].getCodigoBodega());
					abonadoDTO_aux .setTipoStockOriginal(equiposSeriados[j].getTipoStock());
					abonadoDTO_aux .setCodigoBodega(equiposSeriados[j].getCodigoBodega());
					abonadoDTO_aux .setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
					abonadoDTO_aux .setCodUso(equiposSeriados[j].getCodUso());
					abonadoDTO_aux .setCodigoEstado(equiposSeriados[j].getCodigoEstado());
					abonadoDTO_aux .setNumeroSerie(equiposSeriados[j].getNumeroSerie());
					
					logger.debug("187717 equiposSeriados[j].getNumeroSerie() :"+equiposSeriados[j].getNumeroSerie());
					logger.debug("187717 equiposSeriados[j].getTipTerminal() :"+equiposSeriados[j].getTipTerminal());
					
					if (equiposSeriados[j].getTipTerminal().equals(global.getValor("tipo.terminal.simcard")))
					{
						logger.debug("187717 ENTRO if (equiposSeriados[j].getTipTerminal().equals(global.getValor(tipo.terminal.simcard)");
						
						SimcardDTO simcardDTO = new SimcardDTO();
						simcardDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
						simcardDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
						simcardDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
						simcardDTO.setCodigoUso(equiposSeriados[j].getCodUso());
						simcardDTO.setEstado(equiposSeriados[j].getCodigoEstado());
						simcardDTO.setNumeroVenta(String.valueOf(listaAbonados[i].getNumVenta()));
						simcardDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
						simcardDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));    			
						//-- ACTUALIZA STOCK SIMCARD						
						
						logger.debug("187717 ACTUALIZA STOCK SIMCARD :"+simcardDTO.getNumeroSerie());
						simcardDTO.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva
						
						simcardDTO = simcardBO.actualizaStockSimcard(simcardDTO);	
						
					}else{
						
						logger.debug("187717 ENTRO ELSE (equiposSeriados[j].getTipTerminal().equals(global.getValor(tipo.terminal.simcard)");
						codErrorTerminal = 0;
						            			
						TerminalDTO terminalDTO = new TerminalDTO();
						terminalDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
						terminalDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
						terminalDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
						terminalDTO.setCodigoUso(equiposSeriados[j].getCodUso());
						terminalDTO.setEstado(equiposSeriados[j].getCodigoEstado());
						terminalDTO.setNumeroVenta(String.valueOf(listaAbonados[i].getNumVenta()));
						terminalDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
						terminalDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));
						
						logger.debug("187717 Se obtiene indicador comodato");
						
						logger.debug("187717 listaAbonados[i].getCodTipContrato() :"+listaAbonados[i].getCodTipContrato());
						//Se obtiene indicador comodato
						ContratoDTO contrato = new ContratoDTO();
						contrato.setCodigoTipoContrato(listaAbonados[i].getCodTipContrato());
						contrato = getTipoContrato(contrato);    			
						
						logger.debug("187717 Se obtiene modalidad de venta (indicador de cuotas)");
						logger.debug("187717 listaAbonados[i].getCodModVenta() :"+listaAbonados[i].getCodTipContrato());
						//Se obtiene modalidad de venta (indicador de cuotas)
						ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
						modalidad.setCodigoModalidadPago(String.valueOf(listaAbonados[i].getCodModVenta()));
						modalidad = getModalidadPago(modalidad);
						
						logger.debug("desbloqueoLinea() contrato.getIndComodato() : " + contrato.getIndComodato() );
						logger.debug("desbloqueoLinea() modalidad.getIndicadorCuotas(): " + modalidad.getIndicadorCuotas() );
						logger.debug("desbloqueoLinea() equiposSeriados[j].getIndicadorEquiAcc(): " + equiposSeriados[j].getIndicadorEquiAcc());
			
						logger.debug("187717 //-- ACTUALIZA STOCK TERMINAL antes" );
						
						logger.debug("187717 contrato.getIndComodato() : "+contrato.getIndComodato() );
												
						logger.debug("187717  modalidad.getIndicadorCuotas(): "+modalidad.getIndicadorCuotas());
						
						logger.debug(contrato.getIndComodato()+""+global.getValor("indicador.comodato"));
						logger.debug(modalidad.getIndicadorCuotas()+"equals(2)");
						logger.debug(modalidad.getIndicadorCuotas()+"equals(-1)");
						logger.debug(equiposSeriados[j].getIndicadorEquiAcc()+".equals("+global.getValor("indicador.equipo"));
						
						
						//-- ACTUALIZA STOCK TERMINAL
					   if ((String.valueOf(contrato.getIndComodato()) == global.getValor("indicador.comodato") ||
							   modalidad.getIndicadorCuotas().equals("2") ||  
							   modalidad.getIndicadorCuotas().equals("-1")) 
							   && equiposSeriados[j].getIndicadorEquiAcc().equals(global.getValor("indicador.equipo")))
					   {
						     logger.debug("187717 //-- ACTUALIZA STOCK TERMINAL antes ENTRO EL IF" );
						     
							terminalDTO.setTipoMovimiento(global.getValor("tipo.movto.saltmp.arriendo")); // salida temporal por arriendo
			    			terminalDTO.setTipoStock(global.getValor("tipo.stock.activo.fijo"));
			    			
			    			logger.debug("187717 //-- ACTUALIZA STOCK TERMINAL STAR" );
			    			
			    			terminalDTO = terminalBO.actualizaStockTerminal(terminalDTO);			    			
			    			
			    			abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());
			    			codErrorTerminal = terminalDTO.getCodigoError();        			
			
			    			if (codErrorTerminal == 0)
			    				//-- si es comodato cambio a bodega desde parámetro
			    				if (String.valueOf(contrato.getIndComodato()) == global.getValor("indicador.comodato")){
			    					TerminalDTO terminalDTO2 = new TerminalDTO();
			    					terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
			    					terminalDTO2 = terminalBO.getEstadoAnterior(terminalDTO2);
			    					
			            			terminalDTO2.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
			            			terminalDTO2.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
			            			terminalDTO2.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
			            			terminalDTO2.setCodigoUso(equiposSeriados[j].getCodUso());
			            			terminalDTO2.setEstado(terminalDTO2.getEstadoAnterior());
			            			terminalDTO2.setNumeroVenta(String.valueOf(listaAbonados[i].getNumVenta()));
			            			terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
			            			terminalDTO2.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));                			
			            			
			  					    ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
			    					parametrosGral.setNombreparametro(global.getValor("parametro.bodega.comodato"));
			    					parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
			    					parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.AL"));
			    					parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
			    					terminalDTO2.setCodigoBodega(parametrosGral.getValorparametro());  					
			
			            			terminalDTO2.setTipoMovimiento(global.getValor("tipo.movto.retsaltmp.arriendo")); // retroceso salida temporal por arriendo
			            			terminalDTO2.setTipoStock(global.getValor("tipo.stock.activo.fijo"));
			            			
			            			logger.debug("desbloqueoLinea.actualizaStockTerminal:antes");
			            			terminalDTO2 = terminalBO.actualizaStockTerminal(terminalDTO2);
			            			logger.debug("desbloqueoLinea.actualizaStockTerminal:despues");
			            			
			            			abonadoDTO.setNumeroMovimiento(terminalDTO2.getNumeroMovimiento());
			        				codErrorTerminal = terminalDTO2.getCodigoError();            				
			
			    				}else{
			    					terminalDTO.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva			    	
					    	
							    	terminalDTO = terminalBO.actualizaStockTerminal(terminalDTO);
							    }
					   }else{
					    	terminalDTO.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva			    	
			    			terminalDTO = terminalBO.actualizaStockTerminal(terminalDTO);        			
			    			//abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());	        			
			    			codErrorTerminal = terminalDTO.getCodigoError();        			
			    			
					    }	
					}
				}
				
			logger.debug("INICIO CAMBIO GDO 11-02-2013 192326");
			SimcardDTO simcardDTO2 = new SimcardDTO();
			
			simcardDTO2 = simcardBO.getKitAboPrepago(listaAbonados[i].getNumAbonado());
			//-- ACTUALIZA STOCK SIMCARD						
			
			logger.debug("192326 ACTUALIZA STOCK SIMCARD :"+simcardDTO2.getNumeroSerie());
			simcardDTO2.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva
			simcardDTO2.setNumeroVenta(String.valueOf(listaAbonados[i].getNumVenta()));
			
			simcardDTO2 = simcardBO.actualizaStockSimcard(simcardDTO2);	
				
			}
			logger.debug("192326 Desreserva Final");
			// FIN INC 187717 26/09/2012
			logger.debug("FIN CAMBIO GDO 11-02-2013 192326");
			
			
			//PREACTIVACION CONTRATO - DESBLOQUEO DIRECTO EN LOS PREPAGOS
			//Se agrega codigo relacionado a la preactivacion /tambien se realiza el desbloqueo directo cuando es un prepago
		    if( (entrada.getPreactivacion() != null && entrada.getPreactivacion().trim().equals("S")) 
		    		|| (entrada.getTipoCliente() != null && entrada.getTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.prepago"))) )
		    {		
				for(int i=0;i<listaAbonados.length;i++)
				{
					if(listaAbonados[i].getCodGrpPrestacion().trim().equals("TM"))
					{
						listaAbonados[i].setNumVenta(entrada.getNumVenta().longValue());
						desbloqueoLinea(listaAbonados[i]);
					}
				}
		    } else {		    	
		    	//Preactiva solo los actabos ZP y ZH 
		    	for(int i=0;i<listaAbonados.length;i++)
				{
					if(listaAbonados[i].getCodGrpPrestacion().trim().equals("TM"))
					{
						listaAbonados[i].setNumVenta(entrada.getNumVenta().longValue());
						registroVentaBO.updateAbonadoPreactivo(new Long(listaAbonados[i].getNumAbonado()));
					}else if(listaAbonados[i].getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.SMS")) ||
							 listaAbonados[i].getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.CREVERTIDO")) ||
							 listaAbonados[i].getCodGrpPrestacion().trim().equals(global.getValor("codigo.grupo.prestacion.WIMAX")) )
					{
						listaAbonados[i].setNumVenta(entrada.getNumVenta().longValue());
						desbloqueoLinea(listaAbonados[i]);
					}
				}		    	
		    }
		    
			/**
			 * @description se invoca PL de envío de mails
			 */	
			try{	
				this.sendToMailPL(entrada.getNumVenta().longValue());
			}
			catch (GeneralException e){
				logger.error(e.fillInStackTrace());
			}			
	}
	
	public NumeroCuotasDTO[] Lista_Cuotas() 
		throws CustomerDomainException 
	{
		logger.debug("getListadoNumeroCuotas():start");
		NumeroCuotasDTO[] resultado = modalidadPagoBO.getListadoNumeroCuotas(); 
		logger.debug("getListadoNumeroCuotas():end");
		return resultado;
	}
	
	public void desbloqueoLinea(AbonadoDTO entrada)
		throws CustomerDomainException, ProductDomainException
	{
		logger.debug("desbloqueoLinea():start");
		int codErrorTerminal;
		//Se saca serie / equipo de bodega , actualiza stock y num_movimiento en ga_equipaboser
		
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(entrada.getNumAbonado());
		abonado.setIndProcEqTerminal(global.getValor("indicador.procedencia.interna"));
		AbonadoDTO[] equiposSeriados =  abonadoBO.getEquiposSeriados(abonado);
		logger.debug("Inicio recorre equipaboser para el abonado... ");
		for(int j=0;j<equiposSeriados.length;j++)
		{
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			abonadoDTO.setNumAbonado(entrada.getNumAbonado());
			abonadoDTO.setTipoStock(equiposSeriados[j].getTipoStock());
			abonadoDTO.setCodigoBodegaActual(equiposSeriados[j].getCodigoBodega());
			abonadoDTO.setTipoStockOriginal(equiposSeriados[j].getTipoStock());
			abonadoDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
			abonadoDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
			abonadoDTO.setCodUso(equiposSeriados[j].getCodUso());
			abonadoDTO.setCodigoEstado(equiposSeriados[j].getCodigoEstado());
			abonadoDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());			
	
			if (equiposSeriados[j].getTipTerminal().equals(global.getValor("tipo.terminal.simcard")))
			{
				SimcardDTO simcardDTO = new SimcardDTO();
				simcardDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
				simcardDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
				simcardDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
				simcardDTO.setCodigoUso(equiposSeriados[j].getCodUso());
				simcardDTO.setEstado(equiposSeriados[j].getCodigoEstado());
				simcardDTO.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
				simcardDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
				simcardDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));    			
				//-- ACTUALIZA STOCK SIMCARD
				
				simcardDTO.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva
				
				//INICIO INC 187717 26/09/2012
				//simcardDTO = simcardBO.actualizaStockSimcard(simcardDTO);
				logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO INICIO");
				SimcardDTO simcardDTO_aux = new SimcardDTO();
				simcardDTO_aux =simcardBO.getNumMovimmiento(simcardDTO);
				logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO FIN");
				logger.debug("NUMERO DE MOV : "+ simcardDTO_aux.getNumeroMovimiento());
				logger.debug("CODIGO ERROR : "+ simcardDTO_aux.getCodigoError());
				
				if (simcardDTO_aux.getNumeroMovimiento() !="0" & simcardDTO_aux.getCodigoError()==0 ){
						abonadoDTO.setNumeroMovimiento(simcardDTO.getNumeroMovimiento());
						simcardDTO.setCodigoError(0);
				}else{
					simcardDTO.setCodigoError(0);
				}
				//FIN INC 187717 26/09/2012		
				
				
				
				
				if (simcardDTO.getCodigoError() == 0)
	    			//-- ACTUALIZA EQUIPABOSER
					logger.debug("desbloqueoLinea.actualizaEquipAboSer:antes");
					abonadoBO.actualizaEquipAboSer(abonadoDTO);
					logger.debug("desbloqueoLinea.actualizaEquipAboSer:despues");
			}
			else
		
			{
				codErrorTerminal = 0;
				            			
				TerminalDTO terminalDTO = new TerminalDTO();
				terminalDTO.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
				terminalDTO.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
				terminalDTO.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
				terminalDTO.setCodigoUso(equiposSeriados[j].getCodUso());
				terminalDTO.setEstado(equiposSeriados[j].getCodigoEstado());
				terminalDTO.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
				terminalDTO.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
				terminalDTO.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));
				
				//Se obtiene indicador comodato
				ContratoDTO contrato = new ContratoDTO();
				contrato.setCodigoTipoContrato(entrada.getCodTipContrato());
				contrato = getTipoContrato(contrato);    			
				
				//Se obtiene modalidad de venta (indicador de cuotas)
				ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
				modalidad.setCodigoModalidadPago(String.valueOf(entrada.getCodModVenta()));
				modalidad = getModalidadPago(modalidad);
				
				logger.debug("desbloqueoLinea() contrato.getIndComodato() : " + contrato.getIndComodato() );
				logger.debug("desbloqueoLinea() modalidad.getIndicadorCuotas(): " + modalidad.getIndicadorCuotas() );
				logger.debug("desbloqueoLinea() equiposSeriados[j].getIndicadorEquiAcc(): " + equiposSeriados[j].getIndicadorEquiAcc());
	
				
				//-- ACTUALIZA STOCK TERMINAL
			   if ((String.valueOf(contrato.getIndComodato()) == global.getValor("indicador.comodato") ||
					   modalidad.getIndicadorCuotas().equals("2") ||  
					   modalidad.getIndicadorCuotas().equals("-1")) 
					   && equiposSeriados[j].getIndicadorEquiAcc().equals(global.getValor("indicador.equipo")))
			   {
				
					terminalDTO.setTipoMovimiento(global.getValor("tipo.movto.saltmp.arriendo")); // salida temporal por arriendo
	    			terminalDTO.setTipoStock(global.getValor("tipo.stock.activo.fijo"));
	    			
	    			//INICIO INC 187717 26/09/2012
	    			//terminalDTO = terminalBO.actualizaStockTerminal(terminalDTO);
	    			logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO INICIO");
	    			TerminalDTO terminalDTO_aux = new TerminalDTO();
	    			terminalDTO_aux =terminalBO.getNumMovimmiento(terminalDTO);
	    			logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO FIN");
					logger.debug("NUMERO DE MOV : "+ terminalDTO_aux.getNumeroMovimiento());
					logger.debug("CODIGO ERROR : "+ terminalDTO_aux.getCodigoError());
					
					if (terminalDTO_aux.getNumeroMovimiento() !="0" & terminalDTO_aux.getCodigoError()==0 ){
							abonadoDTO.setNumeroMovimiento(terminalDTO_aux.getNumeroMovimiento());
							terminalDTO.setCodigoError(0);
					}else{
						terminalDTO.setCodigoError(0);
					}
	    			//FIN INC 187717 26/09/2012
	    			
	    			//terminalDTO.setCodigoError(0);
	    			
	    			//abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());
	    			codErrorTerminal = terminalDTO.getCodigoError();        			
	
	    			if (codErrorTerminal == 0)
	    				//-- si es comodato cambio a bodega desde parámetro
	    				if (String.valueOf(contrato.getIndComodato()) == global.getValor("indicador.comodato"))
	    				{
	    					TerminalDTO terminalDTO2 = new TerminalDTO();
	    					terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
	    					terminalDTO2 = terminalBO.getEstadoAnterior(terminalDTO2);
	    					
	            			terminalDTO2.setTipoStock(String.valueOf(equiposSeriados[j].getTipoStock()));
	            			terminalDTO2.setCodigoBodega(equiposSeriados[j].getCodigoBodega());
	            			terminalDTO2.setCodigoArticulo(equiposSeriados[j].getCodigoArticulo());
	            			terminalDTO2.setCodigoUso(equiposSeriados[j].getCodUso());
	            			terminalDTO2.setEstado(terminalDTO2.getEstadoAnterior());
	            			terminalDTO2.setNumeroVenta(String.valueOf(entrada.getNumVenta()));
	            			terminalDTO2.setNumeroSerie(equiposSeriados[j].getNumeroSerie());
	            			terminalDTO2.setIndicadorTelefono(String.valueOf(equiposSeriados[j].getIndTelefono()));                			
	            			
	  					    ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
	    					parametrosGral.setNombreparametro(global.getValor("parametro.bodega.comodato"));
	    					parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
	    					parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.AL"));
	    					parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
	    					terminalDTO2.setCodigoBodega(parametrosGral.getValorparametro());  					
	
	            			terminalDTO2.setTipoMovimiento(global.getValor("tipo.movto.retsaltmp.arriendo")); // retroceso salida temporal por arriendo
	            			terminalDTO2.setTipoStock(global.getValor("tipo.stock.activo.fijo"));
	            			
	            			//INICIO INC 187717 26/09/2012
	            			//logger.debug("desbloqueoLinea.actualizaStockTerminal:antes");
	            			//terminalDTO2 = terminalBO.actualizaStockTerminal(terminalDTO2);
	            			//logger.debug("desbloqueoLinea.actualizaStockTerminal:despues");
	            			logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO INICIO");
	            			
	            			TerminalDTO terminalDTO_aux1 = new TerminalDTO();
	    	    			terminalDTO_aux1 =terminalBO.getNumMovimmiento(terminalDTO);
	    	    			
	    	    			logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO FIN");
	    					logger.debug("NUMERO DE MOV : "+ terminalDTO_aux1.getNumeroMovimiento());
	    					logger.debug("CODIGO ERROR : "+ terminalDTO_aux1.getCodigoError());
	    					
	    					if (terminalDTO_aux1.getNumeroMovimiento() !="0" & terminalDTO_aux1.getCodigoError()==0 ){
	    							abonadoDTO.setNumeroMovimiento(terminalDTO_aux1.getNumeroMovimiento());
	    							terminalDTO2.setCodigoError(0);
	    					}else{
	    						terminalDTO2.setCodigoError(0);
	    					}
	            			
	            			//FIN INC 187717 26/09/2012
	            			
	            			
	            			abonadoDTO.setNumeroMovimiento(terminalDTO2.getNumeroMovimiento());
	        				codErrorTerminal = terminalDTO2.getCodigoError();            				
	
	    				}
	   				
	    			if (codErrorTerminal == 0)
	        			//-- ACTUALIZA EQUIPABOSER
	    				logger.debug("desbloqueoLinea.actualizaEquipAboSer:antes");
	    				abonadoBO.actualizaEquipAboSer(abonadoDTO);
	    				logger.debug("desbloqueoLinea.actualizaEquipAboSer:despues");
				    }
			    else{
			    	terminalDTO.setTipoMovimiento(global.getValor("tipo.movto.saldefinitiva")); // salida definitiva			    	
			    	
			    	//INICIO INC 187717 26/09/2012
			    	//terminalDTO = terminalBO.actualizaStockTerminal(terminalDTO);
			    	logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO INICIO");
	    			TerminalDTO terminalDTO_aux = new TerminalDTO();
	    			terminalDTO_aux =terminalBO.getNumMovimmiento(terminalDTO);
			    	logger.debug("OBTENEMOS EL ULTIMO NUMERO DEL MOVIMIENTO FIN");
					logger.debug("NUMERO DE MOV : "+ terminalDTO_aux.getNumeroMovimiento());
					logger.debug("CODIGO ERROR : "+ terminalDTO_aux.getCodigoError());
					
					if (terminalDTO_aux.getNumeroMovimiento() !="0" & terminalDTO_aux.getCodigoError()==0 ){
						abonadoDTO.setNumeroMovimiento(terminalDTO_aux.getNumeroMovimiento());
						terminalDTO.setCodigoError(0);
					}else{
						terminalDTO.setCodigoError(0);
					}
			    	//FIN INC 187717 26/09/2012
			    	
	    			abonadoDTO.setNumeroMovimiento(terminalDTO.getNumeroMovimiento());	        			
	    			codErrorTerminal = terminalDTO.getCodigoError();        			
	    			if (codErrorTerminal == 0)
	        			//-- ACTUALIZA EQUIPABOSER
	    				logger.debug("desbloqueoLinea.actualizaEquipAboSer:antes");
	    				abonadoBO.actualizaEquipAboSer(abonadoDTO);
	    				logger.debug("desbloqueoLinea.actualizaEquipAboSer:despues");
			    }
			}			
		}
		
		//Actualizar estado icc_movimiento a 1
		GaVentasDTO gaVenta = new GaVentasDTO();
		gaVenta.setNumVenta(new Long(entrada.getNumVenta()));
		gaVenta.setNomUsuarora(entrada.getNomUsuarOra());
		
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		abonadoDTO.setNumAbonado(entrada.getNumAbonado());		
		gaVenta.setAbonado(abonadoDTO);		
		registroVentaBO.updateVentaDesbloqueo(gaVenta);
		
		logger.debug("desbloqueoLinea():end");		
	}

		
	private void sendToMailPL(long ventaId)
		throws GeneralException
	{
		logger.debug("sendToMailPL():start");
		try{
			usuarioBO.sendToMailPL(ventaId);
		}
		catch(GeneralException e){
			logger.equals("GeneralException : start");
			logger.error(e.fillInStackTrace());
			logger.equals("GeneralException : end ");
		}
		logger.debug("sendToMailPL():end");
	}
	
	public UsuarioSCLDTO getMenuUsuario(UsuarioSCLDTO usuariodto) 
		throws CustomerDomainException 
	{
		logger.debug("getMenuUsuario():start");
		UsuarioSCLDTO resultado = usuarioSCLBO.getMenuUsuario(usuariodto); 
		logger.debug("getMenuUsuario():end");
		return resultado;
	}

	public void setRegistrarCargosInstalacion(RegistroCargosDTO cargosInstalacionDTO)
		throws GeneralException
	{
		logger.debug("setRegistrar Cargos de Instalacion ::Inicio");
		try{
			
			RegistroCargosDTO cargosInstalacionDTO2 = new RegistroCargosDTO();
			cargosInstalacionDTO2=cargosInstalacionDTO;
			cargosInstalacionDTO2.setCodigoSecuencia(global.getValor("secuencia.cargos"));
			
			cargosInstalacionDTO2=registroCargosBO.getSecuenciaCargo(cargosInstalacionDTO);
			
			cargosInstalacionDTO.setNumeroCargo(cargosInstalacionDTO2.getNumeroCargo());
			cargosInstalacionDTO.getCodigoCliente();
			cargosInstalacionDTO.setCodigoProducto(1);
			cargosInstalacionDTO.getCodigoConceptoPrecio();
			cargosInstalacionDTO.getImporteCargo();
			cargosInstalacionDTO.getCodigoMoneda();
			cargosInstalacionDTO.setNumeroUnidades(1);
			cargosInstalacionDTO.setIndiceFacturacion(1);
			cargosInstalacionDTO.setNumeroTransaccion(0);
			cargosInstalacionDTO.getNum_abonado();
			
			//Se obtiene la operadora
			String operadora = datosGeneralesBO.getCodigoOperadora();
			logger.debug("operadora:" + operadora);
			
			//Enc aso de ser Guatemala se debe restar el impuesto
			 if(operadora.trim().equals(global.getValor("operadora.guatemala")))
			{
				//Para GUATEMALA al descuento manual hay que descontarle el impuesto
				ImpuestosDTO impuestos = new ImpuestosDTO();
				impuestos.setCodigoCliente(Long.valueOf(cargosInstalacionDTO.getCodigoCliente()).longValue());
				impuestos.setCodOficina(cargosInstalacionDTO.getCodOficina());
				impuestos.setMontoDsctoManual(cargosInstalacionDTO.getImporteCargo());
				impuestos.setCodigoConcepto(Integer.valueOf(cargosInstalacionDTO.getCodigoConceptoPrecio()).intValue());
				ImpuestosDTO resultado = registroFacturacionBO.getImpuestoDesctoManual(impuestos);
				double impuesto =   resultado.getMontoDsctoManual() - cargosInstalacionDTO.getImporteCargo();
				logger.debug("impuesto:" + impuesto);
				cargosInstalacionDTO.setImporteCargo(new Float(cargosInstalacionDTO.getImporteCargo() - impuesto).floatValue());
			}		
			
			
			cargosInstalacionDTO.setMesGarantia(0);
			cargosInstalacionDTO.setNumeroFactura(0);
			cargosInstalacionDTO.setIndiceCuota("0");
			cargosInstalacionDTO.setIndiceSuperTelefono(0);
			RegistroVentaDTO regVenta=new RegistroVentaDTO();
			regVenta.setNumeroVenta(cargosInstalacionDTO.getNumeroVenta());
			AbonadoDTO[] abonados= abonadoBO.getListaAbonadosVenta(regVenta);
			
			for (int i=0;i<abonados.length;i++){
				if (abonados[i].getNumAbonado()==cargosInstalacionDTO.getNum_abonado().longValue()){
					cargosInstalacionDTO.setCodigoTecnologia(abonados[i].getCodTecnologia());
					cargosInstalacionDTO.setNum_terminal(new Long (abonados[i].getNumCelular()));
					break;
				}
			}
			ClienteDTO clienteDTO=new ClienteDTO();
			clienteDTO.setCodigoCliente(cargosInstalacionDTO.getCodigoCliente());
			clienteDTO=this.getCliente(clienteDTO);
			RegistroFacturacionDTO registroFactDTO =registroFacturacionBO.getCodigoCicloFacturacion(clienteDTO);
			FaConceptoDTO faConceptoDTO =new FaConceptoDTO();
			faConceptoDTO.setCodConcepto(cargosInstalacionDTO.getCodigoConceptoPrecio());
			faConceptoDTO=registroFacturacionBO.getFaConcepto(faConceptoDTO);
			cargosInstalacionDTO.setCodigoMoneda(faConceptoDTO.getCodMoneda());
			cargosInstalacionDTO.setCodigoPlanComercial(clienteDTO.getPlanComercial());
			
			cargosInstalacionDTO.setCodigoCicloFacturacion(registroFactDTO.getCodigoCicloFacturacion());
			GaVentasDTO gaVenta = new GaVentasDTO();		
			gaVenta.setNumVenta(new Long(cargosInstalacionDTO.getNumeroVenta()));
			cargosInstalacionDTO.setNumeroVenta(0);
			if (cargosInstalacionDTO.getImporteCargo()!=0){
			    registroCargosBO.registraCargo(cargosInstalacionDTO);
			}
			//Actualizar estado icc_movimiento a 1
			gaVenta.setNomUsuarora(cargosInstalacionDTO.getNombreUsuario());
			
			AbonadoDTO abonadoDTO = new AbonadoDTO();
			abonadoDTO.setNumAbonado(cargosInstalacionDTO.getNum_abonado().longValue());		
			gaVenta.setAbonado(abonadoDTO);
			registroVentaBO.updateVentaDesbloqueo(gaVenta);
		}
		catch(GeneralException e){
			logger.equals("GeneralException : start");
			logger.error(e.fillInStackTrace());
			logger.equals("GeneralException : end ");
		}
		logger.debug("setRegistrar Cargos de Instalacion :: Fin");
	}
	
	public void reversaCargosFormalizacion(Long numVenta) 
		throws CustomerDomainException
	{
	    logger.debug("reversaCargosFormalizacion():Inicio");
	    registroVentaBO.reversaCargosFormalizacion(numVenta);
	    logger.debug("reversaCargosFormalizacion():Fin");
	}
	
	public FaConceptoDTO getFaConcepto(FaConceptoDTO faConceptoDTO)
		throws GeneralException
	{
		try{
			faConceptoDTO=registroFacturacionBO.getFaConcepto(faConceptoDTO);
		}
		catch(GeneralException e){
			throw(e);
		}
		return faConceptoDTO;
	}
	
	public VendedorDTO busquedaVendedor(VendedorDTO vendedor)
		throws CustomerDomainException
	{
		logger.debug("busquedaVendedor():Inicio");		
		vendedor=vendedorBO.buscarVendedor(vendedor);		
		logger.debug("busquedaVendedor():Fin");
		return vendedor;
	}
	
	public Long verificaVentaCero_Regalo(Long numVenta)
		throws CustomerDomainException
	{
		logger.debug("verificaVentaCero_Regalo():Inicio");		
		Long importe= registroVentaBO.verificaVentaCero_Regalo(numVenta);		
		logger.debug("verificaVentaCero_Regalo():Fin");
		return importe;
	}
	
	public void updateModalidaVenta(Long numVenta, Long codModVenta)
		throws CustomerDomainException
	{
		logger.debug("updateModalidaVenta():Inicio");		
		modalidadVentaBO.updateModalidaVenta(numVenta, codModVenta);		
		logger.debug("updateModalidaVenta():Fin");		
	}
	
	public String obtenerEstadoContratacionPA(Long numVenta)
		throws CustomerDomainException
	{
		logger.debug("obtenerEstadoContratacionPA():Inicio");		
		String resultado= registroVentaBO.obtenerEstadoContratacionPA(numVenta);		
		logger.debug("obtenerEstadoContratacionPA():Fin");
		return resultado;
	}
	
	
	/** Metodos para generar los documentos **/	
	
	public PagareDTO obtenerDatosPagare(Long numVenta)
		throws CustomerDomainException
	{
		logger.debug("obtenerDatosPagare():Inicio");		
		PagareDTO resultado= registroVentaBO.obtenerDatosPagare(numVenta);		
		logger.debug("obtenerDatosPagare():Fin");
		return resultado;
	}
	
	public FichaClienteDTO obtenerDatosFichaCliente(Long numAbonado)
		throws CustomerDomainException
	{
		logger.debug("obtenerDatosFichaCliente():Inicio");		
		FichaClienteDTO resultado= registroVentaBO.obtenerDatosFichaCliente(numAbonado);		
		logger.debug("obtenerDatosFichaCliente():Fin");
		return resultado;
	}
	
	public FichaSalidaBodegaDTO obtenerDatosSalidaBodega(Long numVenta)
		throws CustomerDomainException
	{
		logger.debug("obtenerDatosSalidaBodega():Inicio");		
		FichaSalidaBodegaDTO resultado= registroVentaBO.obtenerDatosSalidaBodega(numVenta);		
		logger.debug("obtenerDatosSalidaBodega():Fin");
		return resultado;
	}
	
	public FichaContratoPrestacionDTO obtenerDatosContratoPrestacion(Long numVenta)
		throws CustomerDomainException
	{
		logger.debug("obtenerDatosContratoPrestacion():Inicio");		
		FichaContratoPrestacionDTO resultado= registroVentaBO.obtenerDatosContratoPrestacion(numVenta);		
		logger.debug("obtenerDatosContratoPrestacion():Fin");
		return resultado;
	}	
	
	/** 
	 * Metodos relacionados a la distribuicion de bolsas
	 */
	
	public DistribucionBolsaDTO obtenerDatosBolsa( String codPlanTarif )
		throws ProductDomainException
	{
		logger.debug("obtenerDatosBolsa():Inicio");		
		DistribucionBolsaDTO resultado= distribucionBolsaBO.obtenerDatosBolsa(codPlanTarif);		
		logger.debug("obtenerDatosBolsa():Fin");
		return resultado;
	}	
	
	public Long obtenerVentasAnteriores( Long numVenta, Long codCliente )
		throws CustomerDomainException
	{
		logger.debug("obtenerVentasAnteriores():Inicio");		
		Long resultado= registroVentaBO.obtenerVentasAnteriores(numVenta, codCliente);		
		logger.debug("obtenerVentasAnteriores():Fin");
		return resultado;
	}	
	
	public Long obtenerVentasAnterioresPorPlan( Long numVenta, Long codCliente, String codPlanTarif )
	throws CustomerDomainException
	{
		logger.debug("obtenerVentasAnterioresPorPlan():Inicio");		
		Long resultado= registroVentaBO.obtenerVentasAnterioresPorPlan(numVenta, codCliente, codPlanTarif);		
		logger.debug("obtenerVentasAnterioresPorPlan():Fin");
		return resultado;
	}
	public TipoPrestacionDTO validarPlanDist(Long codCliente)
		throws ProductDomainException
	{
		logger.debug("validarPlanDist():Inicio");		
		TipoPrestacionDTO resultado= distribucionBolsaBO.validarPlanDist(codCliente);		
		logger.debug("validarPlanDist():Fin");
		return resultado;
	}
			
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long numVenta) 
		throws ProductDomainException
	{
		logger.debug("obtenerPlanesDistribuidos():Inicio");		
		PlanTarifarioDTO[] resultado = distribucionBolsaBO.obtenerPlanesDistribuidos(numVenta);		
		logger.debug("obtenerPlanesDistribuidos():Fin");	
		return resultado;
	}	
	
	public PlanTarifarioDTO[] obtenerPlanesDistribuidosAutomaticos(Long numVenta) 
		throws ProductDomainException
	{
		logger.debug("obtenerPlanesDistribuidosAutomaticos():Inicio");		
		PlanTarifarioDTO[] resultado = distribucionBolsaBO.obtenerPlanesDistribuidosAutomaticos(numVenta);		
		logger.debug("obtenerPlanesDistribuidosAutomaticos():Fin");	
		return resultado;
	}	
	
	public AbonadoDTO[] obtenerAbonadosDistribuidos(AbonadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("obtenerAbonadosDistribuidos():Inicio");		
		AbonadoDTO[] resultado =abonadoBO.obtenerAbonadosDistribuidos(entrada);		
		logger.debug("obtenerAbonadosDistribuidos():Fin");	
		return resultado;
	}	
	
	public BolsaAbonadoDTO[] obtenerDistribucionBolsa(CustomerAccountDTO dto)
		throws TOLException
	{
		logger.debug("obtenerDistribucionBolsa():Inicio");		
		BolsaAbonadoDTO[] resultado= distribucionBolsaBO.getFreeUnitStock(dto);		
		logger.debug("obtenerDistribucionBolsa():Fin");
		return resultado;
	}
	
	public void guardarDistribucionBolsa(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		logger.debug("guardarDistribucionBolsa():Inicio");		
		distribucionBolsaBO.createStorageAndFreeUnitStock(dto);		
		logger.debug("guardarDistribucionBolsa():Fin");		
	}
	
	
	/**
	 * Metodos relacionados a los tipos de solicitud
	 */
	
	public void guardarSolicitudVenta(SolicitudVentaDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("guardarSolicitudVenta():Inicio");		
		prestacionBO.guardarSolicitudVenta(entrada);		
		logger.debug("guardarSolicitudVenta():Fin");		
	}
	
	public TipoSolicitudDTO[] obtenerTiposSolicitudes()	
		throws CustomerDomainException
	{
		logger.debug("obtenerTiposSolicitudes():Inicio");		
		TipoSolicitudDTO[] resultado=registroVentaBO.obtenerTiposSolicitudes();		
		logger.debug("obtenerTiposSolicitudes():Fin");	
		return resultado;
	}	
	
	/**
	 * Actualiza los estados de la solicitud de venta en la formalizacion
	 * @param numVenta
	 * @throws ProductDomainException
	 */
	public void actualizaSolVentaForm(Long numVenta)	
		throws ProductDomainException
	{
		logger.debug("actualizaSolVenta():Inicio");		
		prestacionBO.actualizaSolVentaForm(numVenta);		
		logger.debug("actualizaSolVenta():Fin");			
	}	
	
	/**
	 * Actualiza los estados de la solicitud de venta en la evaluacion
	 * @param numVenta
	 * @throws ProductDomainException
	 */
	public void actualizaSolVentaEval(SolicitudVentaDTO entrada)	
		throws ProductDomainException
	{
		logger.debug("actualizaSolVentaEval():Inicio");		
		prestacionBO.actualizaSolVentaEval(entrada);		
		logger.debug("actualizaSolVentaEval():Fin");
	}	
	
	public EstadoSolicitudDTO[] listarEstadosSolicitud(SolicitudVentaDTO entrada)	
		throws ProductDomainException
	{
		logger.debug("listarEstadosSolicitud():Inicio");		
		EstadoSolicitudDTO[] resultado= prestacionBO.listarEstadosSolicitud(entrada);		
		logger.debug("listarEstadosSolicitud():Fin");
		return resultado;
	}	
	
	public DetalleInformePresupuestoDTO[] obtenerDetallePresupuesto(Long numVenta) 
		throws CustomerDomainException
	{
		logger.debug("obtenerDetallePresupuesto():Inicio");
		DetalleInformePresupuestoDTO[] resultado = registroFacturacionBO.obtenerDetallePresupuesto(numVenta);
		logger.debug("obtenerDetallePresupuesto():fin");
		return resultado;
	}
	
	public DetallePrecioSolicitudDTO[] obtenerPrecioSSAbo(ServicioSuplementarioDTO entrada) 
		throws ProductDomainException
	{
		logger.debug("obtenerPrecioSSAbo():inicio");
		DetallePrecioSolicitudDTO[] listaPreciosSS = new DetallePrecioSolicitudDTO[0];		
		ServicioSuplementarioDTO[] listaSS= null;
		DetallePrecioSolicitudDTO precio = null;
		try{
			listaSS =  servicioSuplementarioBO.getSSAbonadoEV(entrada);
		}catch(Exception e){
			logger.debug("No se pudo obtener ss por abonados");
		}
		
		if (listaSS!=null)
		{
			ArrayList arrayPrecios = new ArrayList();
			for(int i=0;i<listaSS.length;i++)
			{
				listaSS[i].setCodigoProducto(entrada.getCodigoProducto());
				listaSS[i].setCodigoPlanServicio(entrada.getCodigoPlanServicio());
				listaSS[i].setCodigoActuacion(entrada.getCodigoActuacion());
				PrecioCargoDTO[] listaPreciosAux = servicioSuplementarioBO.getCargoServSupl(listaSS[i]);
				if (listaPreciosAux!=null && listaPreciosAux.length>0 && listaPreciosAux[0].getMonto()>0){
					precio = new DetallePrecioSolicitudDTO();
					precio.setCodConcepto(listaPreciosAux[0].getCodigoConcepto());
					precio.setDesConcepto(listaPreciosAux[0].getDescripcionConcepto());					
					precio.setPrecio(listaPreciosAux[0].getMonto());
					precio.setCodMoneda(listaPreciosAux[0].getCodigoMoneda());
					precio.setDesMoneda(listaPreciosAux[0].getDescripcionMoneda());					
					precio.setCodigoServicio(listaSS[i].getCodigoServicio());
					precio.setTipoCobro(listaPreciosAux[0].getTipoCobro());
					arrayPrecios.add(precio);
				}
			}//fin for					
			listaPreciosSS =(DetallePrecioSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					arrayPrecios.toArray(), DetallePrecioSolicitudDTO.class);
		}
		logger.debug("obtenerPrecioSSAbo():fin");		
		return listaPreciosSS;
	}
	
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("aplicaImpuestoImporte():Inicio");
		RegistroFacturacionDTO resultado = registroFacturacionBO.aplicaImpuestoImporte(entrada);
		logger.debug("aplicaImpuestoImporte():fin");		
		return resultado;
	}
	
	public void updCodigoSituacionAbo(AbonadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("updCodigoSituacionAbo():Inicio");
		abonadoBO.updCodigoSituacionAbo(entrada);
		logger.debug("updCodigoSituacionAbo():fin");		
	}
	
	public String getDatosInstalacion(Long entrada) 
		throws CustomerDomainException
	{
		logger.debug("getDatosInstalacion():Inicio");
		String resultado = abonadoBO.getDatosInstalacion(entrada);
		logger.debug("getDatosInstalacion():fin");	
		return resultado;
	}
	
	/**
	 * Metodos relacionados a los rangos de numeracion para los E1
	 */
	
	
	public RangoDTO[] obtieneRangosDisponibles(Integer codCentral)
		throws ProductDomainException
	{
		logger.debug("obtieneRangosDisponibles():Inicio");
		RangoDTO[] resultado = rangoNumeroBO.obtieneRangosDisponibles(codCentral);
		logger.debug("obtieneRangosDisponibles():fin");	
		return resultado;
	}
	
	public void insertaRangoAsociadoNroPiloto(NumeroPilotoDTO entrada)
		throws ProductDomainException
	{
		logger.debug("insertaRangoAsociadoNroPiloto():Inicio");
		rangoNumeroBO.insertaRangoAsociadoNroPiloto(entrada);
		logger.debug("insertaRangoAsociadoNroPiloto():fin");
	}
	
	public void eliminarRangos(Long entrada)
		throws ProductDomainException
	{
		logger.debug("eliminarRangos():Inicio");
		rangoNumeroBO.eliminarRangos(entrada);
		logger.debug("eliminarRangos():fin");
	}
	
	public NivelPrestacionDTO[] obtieneNivelesPrestacion(NivelPrestacionDTO entrada)
		throws ProductDomainException
	{
		logger.debug("obtieneNivelesPrestacion():Inicio");
		NivelPrestacionDTO[] resultado = prestacionBO.obtieneNivelesPrestacion(entrada);
		logger.debug("obtieneNivelesPrestacion():fin");	
		return resultado;
	}
	
	public Integer consultaVentasCliente(Long codCliente) 
		throws CustomerDomainException
	{
		logger.debug("consultaVentasCliente():Inicio");
		Integer resultado = clienteBO.consultaVentasCliente(codCliente);
		logger.debug("consultaVentasCliente():fin");	
		return resultado;	
	}
	
	public void updWimaxMacAddress(AbonadoDTO entrada) 
		throws CustomerDomainException
	{
		logger.debug("Inicio:updWimaxMacAddress()");
		abonadoBO.updWimaxMacAddress(entrada);
		logger.debug("Inicio:updWimaxMacAddress()");		
	}	
	
	
	public Long insertarDocDigitalizado(DocDigitalizadoDTO docDigitalizadoDTO) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio");
		Long r = docDigitalizadoBO.insertarDocDigitalizado(docDigitalizadoDTO);
		logger.debug("Fin");
		return r;
	}

	public void eliminarDocDigitalizado(long numCorrelativo) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio");
		docDigitalizadoBO.eliminarDocDigitalizado(numCorrelativo);
		logger.debug("Fin");
	}

	public DocDigitalizadoDTO obtenerDocDigitalizado(long numCorrelativo) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio");
		DocDigitalizadoDTO r = docDigitalizadoBO.obtenerDocDigitalizado( numCorrelativo);
		logger.debug("Fin");
		return r;
	}

	public DocDigitalizadoDTO[] obtenerDocDigitalizados(long numVenta) 
		throws CustomerDomainException 
	{
		logger.debug("Inicio");
		DocDigitalizadoDTO[] r = docDigitalizadoBO.obtenerDocDigitalizados(numVenta);
		logger.debug("Fin");
		return r;
	}
	
	public TipoDocDigitalizadoDTO[] obtenerTiposDocDigitalizado() 
		throws CustomerDomainException 
	{
		logger.debug("Inicio");
		TipoDocDigitalizadoDTO[] r = docDigitalizadoBO.obtenerTiposDocDigitalizado();
		logger.debug("Fin");
		return r;
	}	
	
	public SeguridadPerfilesDTO validaFiltroImpresion(SeguridadPerfilesDTO seguridadPerfilesDTO) 
		throws CustomerDomainException 
	{
		logger.debug("validaFiltroImpresion:Inicio");
		usuarioSCLBO.validaFiltroImpresion(seguridadPerfilesDTO);
		logger.debug("validaFiltroImpresion:Fin");
		return seguridadPerfilesDTO;
	}
	
	public CargoSolicitudDTO[] getCargosPARecSolicitud(CargoSolicitudDTO entrada) 
		throws CustomerDomainException 
	{
		logger.debug("getCargosPARecSolicitud:Inicio");
		CargoSolicitudDTO[] resultado = registroVentaBO.getCargosPARecSolicitud(entrada);
		logger.debug("getCargosPARecSolicitud:Fin");
		return resultado;
	}
	
	public void insertaNumerosSMS(FormularioNumerosSMSDTO entrada) 
		throws ProductDomainException 
	{
		logger.debug("insertaNumerosSMS:Inicio");
		prestacionBO.insertaNumerosSMS(entrada);
		logger.debug("insertaNumerosSMS:Fin");
	}
	
	
	public void existeNumeroSMS(Long entrada) 
		throws ProductDomainException 
	{
		logger.debug("existeNumerosSMS:Inicio");
		prestacionBO.existeNumeroSMS(entrada);
		logger.debug("existeNumerosSMS:Fin");
	}
	
	/**
	 * @author mwn40031
	 * @param codVendedor
	 * @return
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.bo.Vendedor#validaVendedorLN(java.lang.String)
	 */
	public Boolean validaVendedorLN(String codVendedor) 
		throws CustomerDomainException 
	{
		logger.info("Inicio");
		Boolean r = vendedorBO.validaVendedorLN(codVendedor);
		logger.info("Fin");
		return r;
	}

	/**
	 * @author mwn40031
	 * @param codVendedorDealer
	 * @return
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.bo.Vendedor#validaVendedorDealerLN(java.lang.String)
	 */
	public Boolean validaVendedorDealerLN(String codVendedorDealer) 
		throws CustomerDomainException 
	{
		logger.info("Inicio");
		Boolean r = vendedorBO.validaVendedorDealerLN(codVendedorDealer);
		logger.info("Fin");
		return r;
	}


	/**
	 * @author mwn40031
	 * @param numSerie
	 * @return
	 * @throws ProductDomainException
	 * @see com.tmmas.cl.scl.productdomain.businessobject.bo.Simcard#validaSerieLN(java.lang.String)
	 */
	public Boolean validaSerieLN(String numSerie) 
		throws ProductDomainException 
	{
		logger.info("Inicio");
		Boolean r = terminalBO.validaSerieLN(numSerie);
		logger.info("Fin");
		return r;
	}


	/**
	 * @author mwn40031
	 * @param codCliente
	 * @return
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente#validaClienteLN(java.lang.String)
	 */
	public Boolean validaClienteLN(String codCliente) 
		throws CustomerDomainException 
	{
		logger.info("Inicio");
		Boolean r = clienteBO.validaClienteLN(codCliente);
		logger.info("Fin");
		return r;
	}
	
	/**
	 * Valida que el cliente especificado no se encuentre en Listas Negras.
	 * @author mwn40031
	 * @param numIdent
	 * @param codTipIdent
	 * @return Si no se encuentra, retorna Boolean.TRUE  
	 * @throws CustomerDomainException
	 * @see com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente#validaClienteLN(java.lang.String, java.lang.String)
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) 
		throws CustomerDomainException 
	{
		logger.info("Inicio");
		Boolean r = clienteBO.validaClienteLN(numIdent, codTipIdent);
		logger.info("Fin");
		return r;
	}
	
	public void insertaCargosOverride(DetalleLineaSolicitudDTO[] lineas) throws CustomerDomainException,
			ProductDomainException {
		logger.info("insertaCargosOverride, inicio");
		final String codProducto = global.getValor("codigo.producto");
		final String codTecnologia = global.getValor("codigo.tecnologia.GSM");
		for (int i = 0; i < lineas.length; i++) {
			final DetalleLineaSolicitudDTO linea = lineas[i];
			logger.debug("linea.toString() [" + linea.toString() + "]");
			for (int j = 0; j < linea.getCargosRecurrentes().length; j++) {
				DetalleCargosSolicitudDTO cargo = linea.getCargosRecurrentes()[j];
				logger.debug("cargo.toString() [" + cargo.toString() + "]");
				if (cargo.getImporteOverride() != null) {
					logger.debug("Hay cargo override. Se guarda en BD");
					if (cargo.getCodPlantarif() != null && !cargo.getCodPlantarif().trim().equals("")) {
						PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
						planTarifario.setCodigoPlanTarifario(cargo.getCodPlantarif());
						planTarifario.setCodigoProducto(codProducto);
						planTarifario.setCodigoTecnologia(codTecnologia);
						planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
						cargo.setCodCargoBasico(planTarifario.getCodigoCargoBasico());
					}
					registroCargosBO.insertaCargosOverride(cargo);
				}
				else {
					logger.debug("No hay cargo override.");
				}
			}
		}
		logger.info("insertaCargosOverride, fin");
	}

	/**
	 * @author JIB
	 * @param numVenta
	 * @return
	 * @throws CustomerDomainException
	 */
	public DetalleCargosSolicitudDTO[] recuperaCargosOverride(Long numVenta, String codOrigenTransaccion)
		throws CustomerDomainException 
	{
		logger.info("Inicio");
		DetalleCargosSolicitudDTO[] r = registroCargosBO.recuperaCargosOverride(numVenta, codOrigenTransaccion);
		logger.info("Fin");
		return r;
	}
	
	public ProrrateoDTO getProrrateo(ProrrateoDTO entrada)
		throws CustomerDomainException
	{
		logger.debug("getProrrateo:Inicio");
		ProrrateoDTO resultado  = facturaBO.getProrrateo(entrada);
		logger.debug("getProrrateo:Fin");
		return resultado;
	}
	
	
	public Long creaDireccion(DireccionNegocioWebDTO entrada)
		throws CustomerDomainException 
	{
		logger.debug("creaDireccion:Inicio");
		
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();		
		datosGenerales.setCodigoSecuencia(global.getValor("secuencia.direccion"));
		datosGenerales  = datosGeneralesBO.getSecuencia(datosGenerales);
		
		String secDireccion = String.valueOf(datosGenerales.getSecuencia()); 
		entrada.setCodigo(secDireccion);		
		direccionBO.setDireccion(entrada);
		
		logger.debug("creaDireccion:Fin");
		return new Long(datosGenerales.getSecuencia());		
	}
	
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente)
		throws CustomerDomainException
	{
		logger.debug("getCodigoCicloFacturacion:Inicio");
		RegistroFacturacionDTO resultado  = registroFacturacionBO.getCodigoCicloFacturacion(cliente);
		logger.debug("getCodigoCicloFacturacion:Fin");
		return resultado;
	}
	
	/**
	 * @author JIB
	 * @param telefono
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean validarTelefonoLDI(String telefono) throws CustomerDomainException  {
		boolean resultado;
		logger.info("validarTelefonoLDI, Inicio");
		logger.debug("telefono: " + telefono);
		try {
			resultado = clienteBO.validarTelefonoLDI(telefono);
		}
		catch (CustomerDomainException e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("CustomerDomainException: " + log);
			throw e;
		}
		catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("Exception: " + log);
			throw new CustomerDomainException (e);
		}
		logger.info("validarTelefonoLDI, Fin");
		return resultado;
	}
	
	public void liberarSeriesYTelefono(Long numVenta) 
		throws CustomerDomainException
	{
	    logger.debug("liberarSeriesYTelefono():Inicio");
	    //Obtiene abonados asociados a la vta
	    RegistroVentaDTO regVenta = new RegistroVentaDTO();		
		regVenta.setNumeroVenta(numVenta.longValue());		
		AbonadoDTO[] listaAbonados = abonadoBO.getListaAbonadosVenta(regVenta);		
		for(int i=0;i<listaAbonados.length;i++)
		{	    
			registroVentaBO.liberarSeriesYTelefono(new Long(listaAbonados[i].getNumAbonado()));
		}
	    logger.debug("liberarSeriesYTelefono():Fin");
	}
	
	/******************************** METODOS SCORING ****************************/
	
	public ScoreClienteDTO[] getSolicitudesScoring(BusquedaSolScoringDTO entrada)
		throws CustomerDomainException 
	{
		logger.debug("VentasSrv:getSolicitudesScoring():start");
		ScoreClienteDTO[] resultado = scoringBO.getSolicitudesScoring(entrada);
		logger.debug("VentasSrv:getSolicitudesScoring():end");
		return resultado;
	}//fin getSolicitudesScoring
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public long insertarSolicitudScoring(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("insertarSolicitudScoring, inicio");
		final long grabaScoringPendienteEnviar = scoringBO.insertarSolicitudScoring(dto);
		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(String.valueOf(dto.getCodCliente()));
		cliente.setIngresosMensuales(new Double(dto.getIngresosMensuales()));		
		updIngresosMensualesCliente(cliente);
		logger.info("insertarSolicitudScoring, fin");
		return grabaScoringPendienteEnviar;
	}//insertarSolicitudScoring
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void grabarDatosGeneralesScoring(DatosGeneralesScoringDTO dto) throws CustomerDomainException {
		logger.info("grabaScoringPendienteEnviar, inicio");
		scoringBO.grabarDatosGeneralesScoring(dto);
		logger.info("grabaScoringPendienteEnviar, fin");
	}
	
	public void insertaEstadoScoring(EstadoScoringDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("insertaEstadoScoring, inicio");
		scoringBO.insertaEstadoScoring(entrada);
		logger.info("insertaEstadoScoring, fin");
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public ScoreClienteDTO getSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getSolicitudScoring, inicio");
		ScoreClienteDTO r = scoringBO.getSolicitudScoring(numSolicitud);
		logger.info("getSolicitudScoring, fin");
		return r;
	}//getSolicitudScoring
	
	/**
	 * @author pv
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public ReporteScoringDTO getReporteSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getReporteSolicitudScoring, inicio");
		ReporteScoringDTO r = scoringBO.getReporteSolicitudScoring(numSolicitud);
		logger.info("getReporteSolicitudScoring, fin");
		return r;
	}//getReporteSolicitudScoring

	/**
	 * @author pv
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] getEstadosSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getEstadosSolicitudScoring, inicio");
		EstadoScoringDTO[] r = scoringBO.getEstadosSolicitudScoring(numSolicitud);
		logger.info("getEstadosSolicitudScoring, fin");
		return r;
	}//getEstadosSolicitudScoring	
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void actualizaScoreCliente(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("actualizaScoreCliente, inicio");
		scoringBO.actualizaScoreCliente(dto);
		logger.info("actualizaScoreCliente, fin");
	}

	public LineaSolicitudScoringDTO[] getlineasSolScoring(Long entrada)
		throws CustomerDomainException 
	{
		logger.debug("VentasSrv:getlineasSolScoring():start");
		LineaSolicitudScoringDTO[] resultado = scoringBO.getlineasSolScoring(entrada);
		logger.debug("VentasSrv:getlineasSolScoring():end");
		return resultado;
	}//fin getlineasSolScoring
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public long insertarLineaScoring(LineaSolicitudScoringDTO dto, Long codCliente) throws CustomerDomainException, ProductDomainException {
		logger.info("insertarLineaScoring, inicio");
		
		// Obtiene valor del cargo basico
		PlanTarifarioDTO planTarifarioDTOIN = new PlanTarifarioDTO();
		planTarifarioDTOIN.setCodigoPlanTarifario(dto.getCodPlantarif());
		String codigoProducto = global.getValor("codigo.producto");
		
		planTarifarioDTOIN.setCodigoProducto(codigoProducto);
		logger.debug("planTarifarioDTOIN.getCodigoProducto() [" + planTarifarioDTOIN.getCodigoProducto() + "]");
		planTarifarioDTOIN.setCodigoTecnologia(dto.getCodTecnologia());
		PlanTarifarioDTO planTarifarioDTOOUT = planTarifarioBO.getPlanTarifario(planTarifarioDTOIN);
		
		planTarifarioDTOOUT.setCodigoProducto(codigoProducto);
		logger.debug("planTarifarioDTOOUT.getCodigoProducto() [" + planTarifarioDTOOUT.getCodigoProducto() + "]");

		//KFL: se debe aplicar conversión monetaria en caso que corresponda		
		ParametrosGeneralesDTO parametrosGeneralesDTO = getMonedaLocal();
		String codMonedaLocal = parametrosGeneralesDTO.getValorparametro();
		
		String fechaActual = obtieneFechaActual();
		
		//Cargo asociado al plan tarifario (cargo basico)
		PrecioCargoDTO[] precioCargoBasico = planTarifarioBO.getCargoBasico(planTarifarioDTOOUT);
		
		if (precioCargoBasico != null && precioCargoBasico.length > 0) {
			dto.setImporteCargoBasico(new Double(precioCargoBasico[0].getMonto()));
			dto.setCodMonedaCargoBasico(precioCargoBasico[0].getCodigoMoneda());
			
			if(!codMonedaLocal.trim().equals(dto.getCodMonedaCargoBasico().trim()))
			{
				Float montoConvertido = convertirMonto(codCliente.longValue(), dto.getImporteCargoBasico().floatValue(),fechaActual);
				dto.setCodMonedaCargoBasico(codMonedaLocal.trim());
				dto.setImporteCargoBasico(new Double(montoConvertido.doubleValue()));
			}
		}
		
		//Obtiene Solcitud scoring
		ScoreClienteDTO scoreCliente = getSolicitudScoring(new Long(dto.getNumSolScoring()));
		
		//Obtiene cargo asociado al seguro
		if(dto.getCodSeguro() != null && !dto.getCodSeguro().trim().equals(""))
		{	
			SeguroDTO seguro = new SeguroDTO();	
			seguro.setCodSeguro(dto.getCodSeguro());
			seguro.setPeriodo(scoreCliente.getDatosGeneralesScoringDTO().getCodPeriodo().intValue());
			seguro = obtieneDatosSeguro(seguro);
			
			PrecioDTO precio = obtenerMontoImporteCargoRec(new Long(seguro.getCodCargo()));
			dto.setImporteSeguro(new Double(precio.getMonto()));
			dto.setCodMonedaSeguro(precio.getUnidad().getCodigo());
			
			if(!codMonedaLocal.trim().equals(dto.getCodMonedaSeguro().trim()))
			{
				Float montoConvertido = convertirMonto(codCliente.longValue(), dto.getImporteSeguro().floatValue(),fechaActual);
				dto.setCodMonedaSeguro(codMonedaLocal.trim());
				dto.setImporteSeguro(new Double(montoConvertido.doubleValue()));
			}
		}
		logger.debug(dto.toString());
		long r = scoringBO.insertarLineaScoring(dto);
		logger.info("insertarLineaScoring, fin");
		return r;
	}


	private String obtieneFechaActual() 
	{
		Date fecha = new Date();
		String fechaActual;
		fechaActual = Formatting.dateTime(fecha,"yyyyMMdd HHmmss");
		return fechaActual;
	}


	private Float convertirMonto(long codCliente, float monto, String fechaActual) 
		throws CustomerDomainException 
	{
		ConversionMonetariaDTO conversion = new ConversionMonetariaDTO();
		conversion.setCodCliente(codCliente);
		conversion.setTotalCargosOrigen(monto);					
		conversion.setFechaOrigen(fechaActual);
							
		Float montoConvertido = registroCargosBO.convertirMontoMonedaLocal(conversion);
		return montoConvertido;
	}
	
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void insertarResultadoScoreCliente(ResultadoScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("insertarResultadoScoreCliente, inicio");
		scoringBO.insertarResultadoScoreCliente(dto);
		logger.info("insertarResultadoScoreCliente, fin");
	}

	/**
	 * @author JIB
	 * @param docDigitalizadoScoringDTO
	 * @return
	 * @throws CustomerDomainException
	 */
	public Long insertarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
			throws CustomerDomainException {
		logger.info("insertarDocDigitalizadoScoring, Inicio");
		Long r = docDigitalizadoBO.insertarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
		logger.info("insertarDocDigitalizadoScoring, Fin");
		return r;
	}// insertarDocDigitalizadoScoring
	
	public LineaSolicitudScoringDTO getDetalleLineaScoring(Long numLineaScoring) 
		throws CustomerDomainException 
	{
		logger.info("getDetalleLineaScoring, inicio");
		LineaSolicitudScoringDTO resultado = scoringBO.getDetalleLineaScoring(numLineaScoring);
		logger.info("getDetalleLineaScoring, fin");
		return resultado;
	}//getDetalleLineaScoring
	
	public void updLineaScoringReplicada(Long numLineaScoring, Long numAbonado) 
		throws CustomerDomainException 
	{
		logger.info("updLineaScoringReplicada, inicio");
		scoringBO.updLineaScoringReplicada(numLineaScoring, numAbonado);
		logger.info("updLineaScoringReplicada, fin");		
	}//updLineaScoringReplicada;
	
	public void insertaSolScoringVenta(SolScoringVentaDTO entrada, EstadoScoringDTO estadoScoring) 
		throws CustomerDomainException 
	{
		logger.info("insertaSolScoringVenta, inicio");
		scoringBO.insertaSolScoringVenta(entrada);		
		scoringBO.insertaEstadoScoring(estadoScoring);
		logger.info("insertaSolScoringVenta, fin");		
	}//insertaSolScoringVenta;
	
	
	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoScoringDTO[] obtenerDocDigitalizadosScoring(Long numSolScoring)
			throws CustomerDomainException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO[] r = docDigitalizadoBO.obtenerDocDigitalizadosScoring(numSolScoring);
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	} //obtenerDocDigitalizadosScoring
	
	
	/**
	 * @author JIB
	 * @param numCorrelativo
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoScoringDTO obtenerDocDigitalizadoScoring(Long numCorrelativo, Long numSolScoring)
			throws CustomerDomainException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO r = docDigitalizadoBO.obtenerDocDigitalizadoScoring(numCorrelativo, numSolScoring);
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	} //obtenerDocDigitalizadosScoring
	
	/**
	 * @author JIB
	 * @param docDigitalizadoScoringDTO
	 * @return
	 * @throws CustomerDomainException
	 */
	public void actualizarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
			throws CustomerDomainException {
		logger.info("actualizarDocDigitalizadoScoring, Inicio");
		docDigitalizadoBO.actualizarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
		logger.info("actualizarDocDigitalizadoScoring, Fin");
	}
	
	
	public Double calcularCapacidadPago(Long numSolScoring)
		throws CustomerDomainException 
	{
		logger.info("calcularCapacidadPago, Inicio");
		Double resultado = scoringBO.calcularCapacidadPago(numSolScoring);
		logger.info("calcularCapacidadPago, Fin");
		return resultado;		
	}
	
	public EstadoDTO[] obtenerEstadosDestino(String codPrograma, String codEstadoOrigen, String nomTabla)
		throws CustomerDomainException 
	{
		logger.info("obtenerEstadosDestino, inicio");
		EstadoDTO[] r = scoringBO.obtenerEstadosDestino(codPrograma, codEstadoOrigen, nomTabla);
		logger.info("obtenerEstadosDestino, fin");
		return r;
	}
	
	public void insertarServSupScoring(ListadoSSOutDTO dto, long numSolScoring, long numLineaScoring)
		throws CustomerDomainException , ProductDomainException
	{
		logger.info("insertarServicioSumplementario, inicio");
		//Obtiene Solciitud scoring
		ScoreClienteDTO scoreCliente = getSolicitudScoring(new Long(numSolScoring));
		String actuacion = scoreCliente.getDatosGeneralesScoringDTO().getIndVtaExterna().trim().equals("0")?"VO":"VT";
		//Cargos asociados al ss
		LineaSolicitudScoringDTO lineaScoring = getDetalleLineaScoring(new Long(numLineaScoring)); 
		
		ServicioSuplementarioDTO ss = new ServicioSuplementarioDTO();
		ss.setCodigoProducto(global.getValor("codigo.producto"));
		ss.setCodigoServicio(dto.getCodigoServicio());
		ss.setCodigoPlanServicio(lineaScoring.getCodPlanServ());
		ss.setCodigoActuacion(actuacion); 
		PrecioCargoDTO[] listaPreciosAux = servicioSuplementarioBO.getCargoServSupl(ss);
		if (listaPreciosAux!=null && listaPreciosAux.length>0)
		{			
			dto.setMonedaMensual(listaPreciosAux[0].getCodigoMoneda());
			dto.setTarifaMensual(String.valueOf(listaPreciosAux[0].getMonto()));	

			//KFL: se debe aplicar conversión monetaria en caso que corresponda		
			ParametrosGeneralesDTO parametrosGeneralesDTO = getMonedaLocal();
			String codMonedaLocal = parametrosGeneralesDTO.getValorparametro();

			if(!codMonedaLocal.trim().equals(listaPreciosAux[0].getCodigoMoneda()))
			{				
				String fechaActual = obtieneFechaActual();
				Float montoConvertido = convertirMonto(scoreCliente.getCodCliente(), 
						Float.valueOf(dto.getTarifaMensual()).floatValue(),fechaActual);
				dto.setMonedaMensual(codMonedaLocal.trim());
				dto.setTarifaMensual(String.valueOf(montoConvertido));
			}						
		}				
		scoringBO.insertarServSupScoring(dto, numSolScoring, numLineaScoring);
		logger.info("insertarServicioSumplementario, fin");
	}
	
	public Long obtenerNroventaSolScoring(Long numSolScoring)
		throws CustomerDomainException 
	{
		logger.info("obtenerNroventaSolScoring, inicio");
		Long resultado = scoringBO.obtenerNroventaSolScoring(numSolScoring);
		logger.info("obtenerNroventaSolScoring, fin");
		return resultado;
	}
	
	public Long obtenerNroSolScoring(Long numVenta)
		throws CustomerDomainException 
	{
		logger.info("obtenerNroSolScoring, inicio");
		Long resultado = scoringBO.obtenerNroSolScoring(numVenta);
		logger.info("obtenerNroSolScoring, fin");
		return resultado;
	}
	
	
	/**
	 * @author JIB
	 * @param codCliente
	 * @param codPrestacion
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean verificaPrestacionCliente(Long codCliente, String codPrestacion) throws CustomerDomainException {
		boolean r = false;
		logger.info("verificaPrestacionCliente, Inicio");
		r = clienteBO.verificaPrestacionCliente(codCliente, codPrestacion);
		logger.info("verificaPrestacionCliente, Fin");
		return r;
	}
	
	public ReglaSSDTO[] getReglasdeValidacionSS(ReglaSSDTO entrada)
		throws ProductDomainException 
	{
		logger.info("getReglasdeValidacionSS, inicio");
		ReglaSSDTO[] resultado = servicioSuplementarioBO.getReglasdeValidacionSS(entrada);
		logger.info("getReglasdeValidacionSS, fin");
		return resultado;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] obtenerEstadosSolicitudScoringXNumTarjeta(String codTipTarjetaSCL, String numTarjeta) throws CustomerDomainException {
		logger.info("obtenerEstadosSolicitudScoringXNumTarjeta, inicio");
		EstadoScoringDTO[] r = scoringBO.obtenerEstadosSolicitudScoringXNumTarjeta(codTipTarjetaSCL, numTarjeta);
		logger.info("obtenerEstadosSolicitudScoringXNumTarjeta, fin");
		return r;
	}
	
	
	public void updIngresosMensualesCliente(ClienteDTO cliente)
		throws CustomerDomainException 
	{
		logger.info("updIngresosMensualesCliente, inicio");
	    clienteBO.updIngresosMensualesCliente(cliente);
		logger.info("updIngresosMensualesCliente, fin");
	
	}
	
	public PrecioDTO obtenerMontoImporteCargoRec(Long codCargo)
		throws CustomerDomainException 
	{
		logger.info("obtenerMontoImporteCargoRec, inicio");
	    PrecioDTO resultado = facturaBO.obtenerMontoImporteCargoRec(codCargo);
		logger.info("obtenerMontoImporteCargoRec, fin");
		return resultado;
	}

	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws CustomerDomainException
	 */
	public ResultadoScoreClienteDTO getResultadoScoring(Long numSolScoring) throws CustomerDomainException {
		logger.info("getSolicitudScoring, inicio");
		ResultadoScoreClienteDTO r = scoringBO.getResultadoScoring(numSolScoring);
		logger.info("getSolicitudScoring, fin");
		return r;
	}//getResultadoScoring
	
	public void updEstadoMovProductoSolicitud(Long numVenta)
		throws CustomerDomainException 
	{
		logger.info("updEstadoMovProductoSolicitud, inicio");
		abonadoBO.updEstadoMovProductoSolicitud( numVenta );
		logger.info("updEstadoMovProductoSolicitud, fin");	
	}
	
	/***************** Metodos plan adicional SCORING ******************/
	
	public TipoComportamientoDTO[] obtenerTiposComportamiento() 
		throws CustomerDomainException 
	{
		logger.info("obtenerTiposComportamiento, inicio");
		TipoComportamientoDTO[] resultado = scoringBO.obtenerTiposComportamiento();
		logger.info("obtenerTiposComportamiento, fin");
		return resultado;
	}
	
	
	public void insertarPAScoring(ProductoOfertadoDTO dto, long numSolScoring, long numLineaScoring)
		throws CustomerDomainException , ProductDomainException
	{
		logger.info("insertarServSupScoring, inicio");
		scoringBO.insertarPAScoring(dto, numSolScoring,numLineaScoring);
		logger.info("insertarServSupScoring, fin");		
	}
	
	public ProductoOfertadoDTO[] obtenerProductosOfertadosXFiltros(final String codPlanTarif, final String codCanal,
			final String nivel, final String codPrestacion, final String[] codigosTipoComportamiento)
			throws CustomerDomainException {
		logger.info("obtenerProductosOfertadosXFiltros, inicio");
		final ProductoOfertadoDTO[] r = scoringBO.obtenerProductosOfertadosXFiltros(codPlanTarif, codCanal, nivel, codPrestacion, codigosTipoComportamiento);
		logger.info("obtenerProductosOfertadosXFiltros, fin");
		return r;
	}
	
	/**
	 * @author Jacqueline Mendez Ortega 16-11-2010 INC-155400
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @return ProductoOfertadoDTO[]
	 * @throws CustomerDomainException
	 * 
	 * Obtiene los planes opcionales obligatorios configurados para el Plan Tarifario
	 */
	public ProductoOfertadoDTO[] obtenerProductosObligatoriosPT (final String codPlanTarif, 
																 final String codCanal,
															     final String nivel, 
																 final String codPrestacion)
		   throws CustomerDomainException {
		logger.info("obtenerProductosObligatoriosPT, inicio");
		final ProductoOfertadoDTO[] r = scoringBO.obtenerProductosObligatoriosPT(codPlanTarif, codCanal, nivel, codPrestacion);
		logger.info("obtenerProductosObligatoriosPT, fin");
		return r;
	}
	
	
	public String consultaExistenPlanes(Long numSolScoring)
	throws CustomerDomainException 
	{
		logger.info("consultaExistenPlanes, inicio");
		String resultado = scoringBO.consultaExistenPlanes(numSolScoring);
		logger.info("consultaExistenPlanes, fin");
		return resultado;
	}
	

	/**
	 * @author JIB
	 * @param numSerie
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXSimcard(Long numSerie)
			throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXSimcard";
		logger.info(nombreMetodo + ", inicio");
		boolean r = abonadoBO.existeAbonadoXSimcard(numSerie);
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param numImei
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXImei(Long numImei) throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXImei";
		logger.info(nombreMetodo + ", inicio");
		boolean r = abonadoBO.existeAbonadoXImei(numImei);
		logger.debug("resultado [" + r + "]");
		logger.info(nombreMetodo + ", fin");
		return r;
	}
	
	/**
	 * @param codTiplan
	 * @return
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodTiplan(String codTiplan) throws CustomerDomainException {
		logger.info("getListadoCampaniasVigentesXCodTiplan, inicio");
		logger.debug("codTiplan [" + codTiplan + "]");
		CampanaVigenteDTO[] r = campanaVigenteBO.getListadoCampaniasVigentesXCodTiplan(codTiplan);
		logger.info("getListadoCampaniasVigentesXCodTiplan, fin");
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 21-04-2011
	public boolean insertaPANormal(AltaLineaWebDTO alta, Long numAbonado, long numMovimiento) throws CustomerDomainException {
		logger.info("Inicio insertaPANormal");
		boolean r = scoringBO.insertaPANormal(alta,numAbonado,numMovimiento);
		logger.info("Fin insertaPANormal");
		return r;
	}
	//Fin P-CSR-11002 JLGN 21-04-2011
	
	//Inicio P-CSR-11002 JLGN 27-04-2011
	public void actualizaUsoTerminal(ArticuloDTO entrada, String codUsoNuevo) throws ProductDomainException{
		logger.info("Inicio actualizaUsoTerminal");
		articuloBO.actualizaUsoTerminal(entrada, codUsoNuevo);
		logger.info("Fin actualizaUsoTerminal");
	}
	//Fin P-CSR-11002 JLGN 27-04-2011
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	public ClienteDTO getDatosCliente(String codCliente) throws CustomerDomainException{
		logger.info("Inicio getDatosCliente");
		ClienteDTO clienteDTO = new ClienteDTO();
		
		clienteDTO.setCodigoCliente(codCliente);
		clienteDTO = clienteBO.getCliente(clienteDTO);
		
		logger.debug("Numero Identificacion: "+ clienteDTO.getNumeroIdentificacion());
		logger.debug("Tipo Identificacion: "+ clienteDTO.getCodigoTipoIdentificacion());	
		logger.info("Fin getDatosCliente");
		return clienteDTO;
	}	
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//	Inicio P-CSR-11002 JLGN 12-05-2011
	public boolean validaPassClasificacion(String passCalificacion) throws CustomerDomainException{
		logger.info("Inicio validaPassClasificacion");
		boolean flagCalificacion = true;
		flagCalificacion = clienteBO.validaPassClasificacion(passCalificacion);	
		logger.info("Fin validaPassClasificacion");
		return flagCalificacion;
	}	
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//	Inicio P-CSR-11002 JLGN 12-05-2011
	public void insExcepcioCalificacion(String codCliente, String codPlanTarif, String nomUserOra, String codPass, String limiteCredito) throws CustomerDomainException{
		logger.info("Inicio insExcepcioCalificacion");
		clienteBO.insExcepcioCalificacion(codCliente, codPlanTarif, nomUserOra, codPass, limiteCredito);	
		logger.info("Fin insExcepcioCalificacion");
	}	
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 26-05-2011
	public DatosContrato obtenerDatosContrato(String numVenta)
		throws CustomerDomainException 
	{
		logger.debug("obtenerDatosContrato():start");
		/*Obtiene Datos de Venta*/
		DatosContrato resultado = new DatosContrato();
		resultado = registroVentaBO.datosVenta(numVenta);
			
		/*Contrato se Debe Marcar como Alta Contrato*/
		resultado.setAltaContrato("X");
		resultado.setMigracion("");
		resultado.setCambioTitular("");
		resultado.setSolicPortabilidad("");
		/*Obtiene Datos Cliente*/
		resultado = clienteBO.datosCliente(resultado);
		/*Obtiene Datos de la Lineas*/
		resultado = clienteBO.datosLinea(resultado);		
		/*P-CSR-11002 JLGN 20-10-2011 Obtiene limite de Consumo de Todas las Lineas obtenidas*/
		resultado = clienteBO.limiteConsumoXLinea(resultado);
		/*Obtiene Datos de Todas las lineas asociadas a la venta*/
		resultado = datosGeneralesBO.datoslinea(resultado);
		/*Obtiene Precio Terminal*/
		resultado = datosGeneralesBO.precioTerminal(resultado);
		/*Obtiene PA Asociados a la Linea*/
		resultado = datosGeneralesBO.datosPAporLinea(resultado);
		/*Obtiene SS Asociados a la Linea*/
		resultado = datosGeneralesBO.datosSSporLinea(resultado);		
		
		logger.debug("obtenerDatosContrato():end");
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 26-05-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011
	public String obtenerDirecPerCli(String codCliente)
		throws CustomerDomainException  
	{
		String resultado;
		logger.debug("Inicio:obtenerDirecPerCli()");
		resultado = direccionBO.obtenerDirecPerCli(codCliente);
		logger.debug("Fin:obtenerDirecPerCli()");
	    return resultado;
	}
	//Fin P-CSR-11002 JLGN 14-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	public long getCargoPlanTarif(String codPlanTarif)
		throws CustomerDomainException, ProductDomainException  
	{
		long resultado;
		logger.debug("Inicio:getCargoPlanTarif()");
		resultado = planTarifarioBO.getCargoPlanTarif(codPlanTarif);
		logger.debug("Fin:getCargoPlanTarif()");
	    return resultado;
	}
	//Fin P-CSR-11002 JLGN 14-06-2011
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public String obtenerNombreFactura(long numVenta) throws CustomerDomainException{
		logger.debug("obtenerNombreFactura():start");
		String resultado = registroFacturacionBO.obtenerNombreFactura(numVenta);
		logger.debug("obtenerNombreFactura():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 29-10-2011
	//Inicio P-CSR-11002 JLGN 10-11-2011
	public void insertRutaContrato(String numVenta, String rutaContrato) throws CustomerDomainException {
		logger.debug("Inicio:insertRutaContrato()");
		datosGeneralesBO.insertRutaContrato(numVenta, rutaContrato);
		logger.debug("fin:insertRutaContrato()");
	}

	//Inicio P-CSR-11002 JLGN 11-11-2011
	public String obtenerRutaContrato(long numVenta) throws CustomerDomainException{
		logger.debug("obtenerRutaContrato():start");
		String resultado = datosGeneralesBO.obtenerRutaContrato(numVenta);
		logger.debug("obtenerRutaContrato():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 11-11-2011
	
	//	Inicio P-CSR-11002 JLGN 14-11-2011
	public void validaDisponibilidadNumero(String numCelular)throws ProductDomainException 
	{
		logger.debug("validaDisponibilidadNumero:start");
		numeracionBO.validaDisponibilidadNumero(numCelular);
		logger.debug("validaDisponibilidadNumero:end");
	}	
	//Fin P-CSR-11002 JLGN 14-11-2011

}//fin class VentasSrv
