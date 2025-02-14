/**
 * 
 */
package com.tmmas.cl.scl.spnsclorq.negocio.ejb.session;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsListTipoPrestacionOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.service.servicios.GestionDeAbonadosSrv;
import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.SSuplementarioOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WSEstadoCivilOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsActivacionLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsActividadesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaClienteOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsAntecedentesVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsApoderadoInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCategoriaImpostivaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsClasificacionCuentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsClienteInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCuentaInNDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDatosPlanTerifarioInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsEstadoOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsHomeLineaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsLineaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsOcupacionesOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsReglaSSOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsResponsableInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsSimcardInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsSucursalBancoInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsSucursalesBancoOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsTarjetaCreditoInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsTerminalInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsUsuarioInDTO;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProgramaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ValidacionServicioSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsParamDescuentoDTO;
import com.tmmas.cl.scl.gestiondecliente.negocio.ejb.session.GestionDeCliente;
import com.tmmas.cl.scl.gestiondecliente.negocio.ejb.session.GestionDeClienteHome;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AceptacionVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AnulacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AnulacionVentaRetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ArticuloResDesInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CargosDescuentosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CargosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CierreVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DescuentosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensProcesoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GeModVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PagosUltimosMesesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosFactVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosLineasFactVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RechazoVentaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RepresentanteLegalComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WSValidarTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloResDesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloVendedorOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClasificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsContratoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCrediticiaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsHomeLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriasClienteOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCiudadesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoComunasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoProvinciasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoRegionesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoTiposIdentificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsOficinaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsRespuestaValidacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsValTarjetaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsVendedorStockInDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.WsDatosDireccionOutDTO;
import com.tmmas.cl.scl.gestiondedirecciones.negocio.ejb.session.GestionDeDirecciones;
import com.tmmas.cl.scl.gestiondedirecciones.negocio.ejb.session.GestionDeDireccionesHome;
import com.tmmas.cl.scl.gestiondeventaaccesorios.service.servicios.GestionDeVentaAccesoriosSRV;
import com.tmmas.cl.scl.inventarioportabilidad.ejb.session.InventarioPortabilidad;
import com.tmmas.cl.scl.inventarioportabilidad.ejb.session.InventarioPortabilidadHome;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoAsincDTO;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation.ComprobacionDatosObligatorios;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation.Validaciones;
import com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation.ValidacionesAltaLinea;
import com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoInDTO;
import com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoOutDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.CierreVentaImasDDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.WsArticuloResDesImasDDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.WsRespuestaImasDDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsAceptacionVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsCierreVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsRechazoVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsCreaStructuraComercialInDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialInternoDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DetalleFacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.FacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.InfoFacturaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.PagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosOutDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCodDescDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistrarCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionPrepagoPostpagoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ResultadoValidacionDatosMigracionDTO;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SpnSclORQ"	
 *           description="An EJB named SpnSclORQ"
 *           display-name="SpnSclORQ"
 *           jndi-name="SpnSclORQ"
 *           type="Stateless" 
 *           transaction-type="Container"
 *                                         
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class SpnSclORQBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private SessionContext context = null;

	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(SpnSclORQBean.class);
	private ProgramaDTO datosPrograma = new ProgramaDTO();

	transient private AbonadoDTO[] listAbonados;	


	private GaVentasDTO ventaGlobalDTO = new GaVentasDTO();
	private Validaciones valida = new Validaciones();
	private AbonadoDTO[] listaAbonadosCierre;
	private String  ModalidadRegaloFac = "0";
	private GestionDeAbonadosSrv srv = new GestionDeAbonadosSrv();
	private GestionDeVentaAccesoriosSRV gestionDeVentaAccesoriosSRV = new GestionDeVentaAccesoriosSRV(); 

	/**
	 * 
	 */
	public SpnSclORQBean() {
		System.out.println("SpnSclOrqBean(): Start");
		config = UtilProperty.getConfiguration("SpnSclORQ.properties","com/tmmas/cl/scl/spnsclorq/negocio/ejb/properties/SpnSclORQBean.properties");
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("SpnSclOrqBean():End");
	}			


	private GestionDeCliente getGestionDeCliente()
	throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("getGestionDeCliente():start");
		GestionDeClienteHome GestionDeClienteHome = null;
		String jndi = config.getString("GestionDeCliente.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("GestionDeCliente.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			GestionDeClienteHome = (GestionDeClienteHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, GestionDeClienteHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de GestionDeCliente...");
		GestionDeCliente GestionDeCliente = null;

		try {
			GestionDeCliente = GestionDeClienteHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getGestionDeCliente()():end");
		return GestionDeCliente;
	}		

	private GestionDeDirecciones getGestionDeDirecciones()
	throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("getGestionDeDirecciones():start");
		GestionDeDireccionesHome GestionDeDireccionesHome = null;
		String jndi = config.getString("GestionDeDirecciones.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("GestionDeDirecciones.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			GestionDeDireccionesHome = (GestionDeDireccionesHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, GestionDeDireccionesHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de GestionDeCliente...");
		GestionDeDirecciones GestionDeDirecciones = null;

		try {
			GestionDeDirecciones = GestionDeDireccionesHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getGestionDeCliente()():end");
		return GestionDeDirecciones;
	}


	private InventarioPortabilidad getInventarioPortabilidad() throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("getInventarioPortabilidad():start");
		InventarioPortabilidadHome inventarioPortabilidadHome = null;
		String jndi = config.getString("InventarioPortabilidad.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("InventarioPortabilidad.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			inventarioPortabilidadHome = (InventarioPortabilidadHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, InventarioPortabilidadHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de GestionDeCliente...");
		InventarioPortabilidad inventarioPortabilidad = null;

		try {
			inventarioPortabilidad = inventarioPortabilidadHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getInventarioPortabilidad()():end");
		return inventarioPortabilidad;
	}		

	private FrmkCargosFacade getFrmkCargosFacade()throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("getFrmkCargosFacade():start");
		FrmkCargosFacadeHome frmkCargosFacadeHome = null;
		String jndi = config.getString("FrmkCargosFacade.jndi");
		logger.debug("Buscando servicio[" + jndi + "]");
		String url = config.getString("FrmkCargosFacade.url.provider");
		logger.debug("Url provider[" + url + "]");

		try {
			frmkCargosFacadeHome = (FrmkCargosFacadeHome) ServiceLocator.getInstance().getRemoteHome(url, jndi, FrmkCargosFacadeHome.class);
		} catch (ServiceLocatorException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("ServiceLocatorException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Recuperada interfaz home de FrmkCargosFacade...");
		FrmkCargosFacade frmkCargosFacade = null;

		try {
			frmkCargosFacade = frmkCargosFacadeHome.create();
		} catch (CreateException e) {
			//TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("CreateException[" + log + "]");
			throw new GeneralException(e);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("RemoteException[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("getGestionDeCliente()():end");
		return frmkCargosFacade;
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws RemoteException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String pruebaGestionDeCliente() throws RemoteException, GeneralException
	{
		return getGestionDeCliente().pruebaGestionDeCliente();
	}		


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws RemoteException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String pruebaJMS(String Prueba) throws RemoteException, GeneralException
	{

		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Antes del rollbak");
		context.setRollbackOnly();
		logger.debug("despues del rollbak");
		throw new GeneralException("A",12,"asa");							
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
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String foo(String param) {
		return null;
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

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
	RemoteException {
		// TODO Auto-generated method stub
		this.context=arg0;

	}


	/********************************************************************/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO getVendedor(VendedorDTO vendedorDTO) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getVendedor:start");
			vendedorDTO=getGestionDeCliente().getVendedor(vendedorDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getVendedor:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);	
			throw new GeneralException(e);
		}
		return vendedorDTO;
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
	public VendedorDTO[] getTipoComisionista()throws GeneralException{
		VendedorDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getTipoComisionista:start");
			retValue=getGestionDeCliente().getTipoComisionista();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getTipoComisionista:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public OficinaDTO[] getOficina()throws GeneralException{
		OficinaDTO[] retValue =null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getOficina:start");
			retValue=getGestionDeCliente().getOficina();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getOficina:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public VendedorDTO[] getVendedoresPorOficina(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getVendedoresPorOficina:start");
			retValue=getGestionDeCliente().getVendedoresPorOficina(vendedorDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getVendedoresPorOficina:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsArticuloVendedorOutDTO[] getArticulosPorVendedor(WsVendedorStockInDTO vendedorStockDTO) throws GeneralException{
		WsArticuloVendedorOutDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getArticulosPorVendedor:start");
			retValue=getGestionDeCliente().getArticulosPorVendedor(vendedorStockDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getArticulosPorVendedor:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsArticuloImeiOutDTO getArticuloPorImei(WsArticuloImeiInDTO inWSLstNumSerieDTO) throws GeneralException{
		WsArticuloImeiOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getArticuloPorImei:start");
			retValue=getGestionDeCliente().getArticuloPorImei(inWSLstNumSerieDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getArticuloPorImei:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public OficinaDTO[] getOficinasPorVendedor(VendedorDTO vendedorDTO)throws GeneralException{ 
		OficinaDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getOficinaPorVendedor:start");
			retValue=getGestionDeCliente().getOficinasPorVendedor(vendedorDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getOficinaPorVendedor:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public VendedorDTO[] getListadoVendedoresXOficinaEIndicador(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getListadoVendedoresXOficinaEIndicador:start");
			retValue=getGestionDeCliente().getListadoVendedoresXOficinaEIndicador(vendedorDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getListadoVendedoresXOficinaEIndicador:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public VendedorDTO[] getListadoVendedoresXTipo(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getListadoVendedoresXTipo:start");
			retValue=getGestionDeCliente().getListadoVendedoresXTipo(vendedorDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getListadoVendedoresXTipo:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListadoCausalesVentasOutDTO getListadoMotivosDescuentosManuales(String CodigoUso) throws GeneralException{
		WsListadoCausalesVentasOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoMotivosDescuentosManuales:start");
			retValue=getGestionDeCliente().getListadoMotivosDescuentosManuales(CodigoUso);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoMotivosDescuentosManuales:end");
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public CuentaDTO[] getSubCuentaPorCodCliente(ClienteDTO clienteDTO) throws GeneralException{
		CuentaDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getSubCuentaPorCodCliente:start");
			retValue=getGestionDeCliente().getSubCuentaPorCodCliente(clienteDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: getSubCuentaPorCodCliente:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsContratoOutDTO[] getListVigenciasContratos() throws GeneralException{
		WsContratoOutDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("SpnSclOrqBean: getListVigenciasContratos:start");
			retValue=getGestionDeCliente().getListVigenciasContratos();

			logger.debug("SpnSclOrqBean: getListVigenciasContratos:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public GeModVentaDTO[] getListModalidadVenta() throws GeneralException{
		GeModVentaDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("SpnSclOrqBean: getListModalidadVenta:start");
			retValue=getGestionDeCliente().getListModalidadVenta();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("SpnSclOrqBean: getListModalidadVenta:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListTarjetaOutDTO getListadoTarjetas() throws GeneralException{
		WsListTarjetaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTarjetas:start");
			retValue=getGestionDeCliente().getListadoTarjetas();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTarjetas:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			retValue.setResultadoTransaccion("1");
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			retValue.setResultadoTransaccion("1");
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListModalidadPagoOutDTO getListadoModalidadPago() throws GeneralException{
		WsListModalidadPagoOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoModalidadPago:start");
			retValue=getGestionDeCliente().getListadoModalidadPago();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoModalidadPago:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListBancoOutDTO getListadoBancosPAC() throws GeneralException{
		WsListBancoOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoBancosPAC:start");
			WsBancoInDTO wsBancoInDTO2= new WsBancoInDTO();
			wsBancoInDTO2.setIndPAC(1);
			logger.debug("wsBancoInDTO.getIndPAC ["+wsBancoInDTO2.getIndPAC()+"]");
			retValue=getGestionDeCliente().getListadoBancosPAC(wsBancoInDTO2);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoBancosPAC:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			retValue.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListCuotaOutDTO getListadoCuotas() throws GeneralException{
		WsListCuotaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoCuotas:start");
			retValue=getGestionDeCliente().getListadoCuotas();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoCuotas:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListCicloFactOutDTO getListadoCiclosPostPago(WsCicloFactInDTO cicloFactDTO) throws GeneralException{
		WsListCicloFactOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoCiclosPostPago:start");
			retValue=getGestionDeCliente().getListadoCiclosPostPago(cicloFactDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoCiclosPostPago:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO)throws GeneralException{
		WsListPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanesTarifarios:start");
			retValue=getGestionDeCliente().getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanesTarifarios:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			retValue.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListTipoPlanTarifarioOutDTO getListadoTiposPlanesTarifarios()throws GeneralException{
		WsListTipoPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTiposPlanesTarifarios:start");
			retValue=getGestionDeCliente().getListadoTiposPlanesTarifarios();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTiposPlanesTarifarios:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente)throws GeneralException{
		WsListClienteIdentOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoClientesXIdentificacion:start");
			retValue=getGestionDeCliente().getListadoClientesXIdentificacion(cliente);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoClientesXIdentificacion:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListTipoComisionistaOutDTO getListadoComisionistasXOficina(WsOficinaInDTO wsOficinaInDTO) throws GeneralException{
		WsListTipoComisionistaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoComisionistasXOficina:start");
			retValue=getGestionDeCliente().getListadoComisionistasXOficina(wsOficinaInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoComisionistasXOficina:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public void reservaDesreserva(ArticuloResDesInDTO articuloDTO) throws GeneralException{
		WsArticuloResDesOutDTO retValue=null;
		WsArticuloResDesImasDDTO retornoImasD = new WsArticuloResDesImasDDTO();
		try{			
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: reservaDesreserva:start");


			retornoImasD.setSpnID(articuloDTO.getSpnID());

			retValue=getGestionDeCliente().reservaDesreserva(articuloDTO);

			retornoImasD.setCodigoError("");
			retornoImasD.setDescripcionErro("");


			getGestionDeCliente().reservaDesreserva(articuloDTO);


			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: reservaDesreserva:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			retornoImasD.setCodigoError(e.getCodigo());
			retornoImasD.setDescripcionErro(e.getDescripcionEvento());
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			retornoImasD.setCodigoError("1");
			retornoImasD.setDescripcionErro(e.getMessage());
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPlanesDTO sumaPlanesDTO) throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getCantidadStockSerie():start"); 
		SumaPrecioPlanesDTO sumaPrecioPlanesDTO = new SumaPrecioPlanesDTO();
		try{
			sumaPrecioPlanesDTO.setCodCliente(sumaPlanesDTO.getCodCliente());
			sumaPrecioPlanesDTO.setMeses(sumaPlanesDTO.getMeses());			
			sumaPrecioPlanesDTO = getGestionDeCliente().getSumaPrecioPlanesXAntiguedad(sumaPrecioPlanesDTO);

		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			sumaPrecioPlanesDTO.setCodError(e.getCodigo());
			sumaPrecioPlanesDTO.setDesEvento(e.getDescripcionEvento());
			context.setRollbackOnly();

			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			sumaPrecioPlanesDTO.setCodError("1");
			sumaPrecioPlanesDTO.setDesEvento("No fue posible rescatar la suma de los planes contratados");
			sumaPrecioPlanesDTO.setResultadoTransaccion("1");
			context.setRollbackOnly();

			throw new GeneralException(e);
		}
		logger.debug("getCantidadStockSerie():end");
		return sumaPrecioPlanesDTO; 
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
	public AbonadoActivoDTO[]  getAbonadosActivosCliente(Long codCliente) throws GeneralException{
		//RSIS -015
		AbonadoActivoDTO[]  retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: listAbonadosActivosCliente:start");
			retValue= getGestionDeCliente().getAbonadosActivosCliente(codCliente);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("SpnSclORQBean: listAbonadosActivosCliente:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: setDesMarcaAbonadoPortado:start");
			retValue= getGestionDeCliente().setDesMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: setDesMarcaAbonadoPortado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion("1");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			retValue.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		return retValue;
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
	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: setMarcaAbonadoPortado:start");
			retValue= getGestionDeCliente().setMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: setMarcaAbonadoPortado:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			retValue.setResultadoTransaccion("1");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			context.setRollbackOnly();
			retValue.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		return retValue;
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
	public  RetornoDTO getInformacionPrecio(ArticuloDTO articuloDTO,WsParamDescuentoDTO calculoDescuentos) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		//RSIS - 028
		RetornoDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: getInformacionPrecio:start");
			retValue= getGestionDeCliente().getInformacionPrecio(articuloDTO,calculoDescuentos);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getInformacionPrecio:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsNumeroSerieOutDTO getInformacionBodegaArticuloSerie(WsNumeroSerieInDTO ssNumeroSerieInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		//RSis-030 
		WsNumeroSerieOutDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: getDatosNumeroSerie:start");
			retValue= getGestionDeCliente().getInformacionBodegaArticuloSerie(ssNumeroSerieInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getDatosNumeroSerie:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsLinkDocumentoOutDTO getLinkFactura(WsLinkDocumentoInDTO wsLinkDocumentoInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		//RSIS 032
		WsLinkDocumentoOutDTO retValue=null;
		try{
			logger.debug("SpnSclORQBean: getLinkFactura:start");
			retValue= getGestionDeCliente().getLinkFactura(wsLinkDocumentoInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getLinkFactura:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsInfoComercialClienteOutDTO getInformacionCrediticiaCliente(WsInfoComercialClienteInDTO wsInfoComercialClienteInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		//1.20	RSis-036 
		WsInfoComercialClienteOutDTO retValue = new WsInfoComercialClienteOutDTO();
		ArrayList listaComercial = new ArrayList();
		try{
			logger.debug("SpnSclORQBean: getInformacionCrediticiaCliente:start");
			ClienteDTO clienteDTO=new ClienteDTO();
			clienteDTO.setNumeroIdentificacion(wsInfoComercialClienteInDTO.getNumIdent());
			clienteDTO.setCodigoTipoIdentificacion(wsInfoComercialClienteInDTO.getTipIdent());
			clienteDTO.setNumMesesCobro(Long.parseLong(config.getString("numero.meses.cobro")));
			WsInfoComercialClienteDTO[] wsInfoComercialClienteDTO=getGestionDeCliente().getDatosCredCliente(clienteDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			if (wsInfoComercialClienteDTO!=null&&wsInfoComercialClienteDTO.length>0){
				for (int i=0;i<wsInfoComercialClienteDTO.length;i++){
					clienteDTO.setCodigoCliente(String.valueOf(wsInfoComercialClienteDTO[i].getCodCliente()));
					PagosUltimosMesesDTO[] pagosUltimosMesesDTO=getGestionDeCliente().getRecPagosClie(clienteDTO);
					wsInfoComercialClienteDTO[i].setPagosUltimosMesesDTO(pagosUltimosMesesDTO);
				}
				retValue.setWsInfoComercialClienteDTO(wsInfoComercialClienteDTO);
			}
			else{
				retValue.setCodError("1");
				retValue.setResultadoTransaccion("No se encontró informacion con los datos ingresados");
			}

			logger.debug("SpnSclORQBean: getInformacionCrediticiaCliente:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			retValue.setResultadoTransaccion(e.getDescripcionEvento());
			retValue.setCodError(e.getCodigo());
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;	
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
	public RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(RoamingDTO rommingDTO)throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		RoamingOUTDTO retValue= null;  
		try{
			RoamingInDTO rommingInDTO = new RoamingInDTO();
			rommingInDTO.setNumCelular(rommingDTO.getNumCelular());
			rommingInDTO.setDias(90);
			logger.debug("SpnSclORQBean: getDetalleUltimaLlamadasRomingTOL:start");
			retValue=getInventarioPortabilidad().getDetalleUltimaLlamadasRomingTOL(rommingInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getDetalleUltimaLlamadasRomingTOL:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsInformacionLineaOutDTO getInformacionLinea(WsInformacionLineaInDTO wsInformacionLineaInDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		WsInformacionLineaOutDTO retValue=new WsInformacionLineaOutDTO();
		try{
			logger.debug("SpnSclORQBean: getInformacionLinea:start");
			retValue=getGestionDeCliente().getInformacionLinea(wsInformacionLineaInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getInformacionLinea:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return retValue;
	}



	public void creaVenta(DatosGeneralesVentaDTO DatosGeneralesVenta,CuentaComDTO cuenta) 
	throws GeneralException, RemoteException, Exception{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("registrarCargos():start");

		GaVentasDTO gaVentasDTO = new GaVentasDTO();

		java.sql.Date fechaA = new java.sql.Date(System.currentTimeMillis());

		/*Setea los datos necesarios para crear registro en tabla GA_VENTA*/
		VendedorDTO vendedor = new VendedorDTO();


		gaVentasDTO.setFecVenta(fechaA);
		gaVentasDTO.setFecRecDocum(fechaA);
		gaVentasDTO.setFecAcePrec(null);
		gaVentasDTO.setFecCumplimenta(fechaA);
		vendedor.setCodigoVendedor(DatosGeneralesVenta.getCodigoVendedor());
		vendedor.setCodigoVendedorDealer( new Long(DatosGeneralesVenta.getCodigoVendedorDealer()).longValue());
		vendedor = getVendedor(vendedor);
		if (DatosGeneralesVenta.getCodigoVendedorDealer() == null || DatosGeneralesVenta.getCodigoVendedorDealer().equals("0") ){
			gaVentasDTO.setCodigoActuacionDefecto("VT");
		}else{
			gaVentasDTO.setCodigoActuacionDefecto("VO");
		}

		gaVentasDTO.setNumVenta(new Long(DatosGeneralesVenta.getNumeroVenta()));
		gaVentasDTO.setCodOficina(vendedor.getCodigoOficina());
		gaVentasDTO.setCodTipcomis(vendedor.getCodTipComisionista());
		gaVentasDTO.setCodVendedor(new Long (DatosGeneralesVenta.getCodigoVendedor()));
		gaVentasDTO.setCodVendedorAgente(new Long (vendedor.getCodigoVendedorRaiz()));
		gaVentasDTO.setCodRegion(DatosGeneralesVenta.getCodigoRegion());
		gaVentasDTO.setCodProvincia(DatosGeneralesVenta.getCodigoProvincia());
		gaVentasDTO.setCodCiudad(DatosGeneralesVenta.getCodigoCiudad());
		gaVentasDTO.setNumTransaccion(new Long (DatosGeneralesVenta.getNumeroTransaccionVenta()));
		gaVentasDTO.setCodCliente(new Long(DatosGeneralesVenta.getCodigoCliente())); 
		gaVentasDTO.setCodModVenta(new Long(DatosGeneralesVenta.getCodigoModalidadVenta()));
		gaVentasDTO.setCodCuota(DatosGeneralesVenta.getCodigoCuotas());
		gaVentasDTO.setNumContrato(DatosGeneralesVenta.getNumeroContrato());
		gaVentasDTO.setCodTipContrato(DatosGeneralesVenta.getCodigoTipoContrato());
		gaVentasDTO.setNomUsuarVta(DatosGeneralesVenta.getNombreUsuarioOracle());
		gaVentasDTO.setCodVenDealer(new Long(DatosGeneralesVenta.getCodigoVendedorDealer()));
		gaVentasDTO.setTipFoliacion( "A");
		logger.debug("tipo foliacion: " + "");
		gaVentasDTO.setCodTipDocumento("");
		logger.debug("tipo documento: " + "");
		gaVentasDTO.setAciclo(false);
		//gaVentasDTO.setTipValor(new Long(listadoCargos.getObjetoSesion().getParametros().getModalidadPagoDTO().getCodigoModalidadPago()));
		//gaVentasDTO.setIndPasoCob(new Long(0));//valor por defecto obtenido de la BD ya q 




		gaVentasDTO.setCodModPago("");
		gaVentasDTO.setFormPago("");
		gaVentasDTO.setCodProducto(new Long (1));
		gaVentasDTO.setIndTipVenta(new Long (0));
		datosPrograma.setCodigoPrograma("VEW");
		datosPrograma.setNumeroVersion(2);
		datosPrograma.setNumeroSubVersion(1);
		gaVentasDTO.setNumUnidades(new Long(1));
		gaVentasDTO.setDatosPrograma(datosPrograma);
		gaVentasDTO.setIndPasoCob(new Long(1));
		gaVentasDTO.setIndEstVenta("IV");
		gaVentasDTO.setIndVenta("V");

		/*
		SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy");

		gaVentasDTO.setCodBanco(cuenta.getClienteComDTO().getCodigoBanco());
		gaVentasDTO.setCodSucursal(cuenta.getClienteComDTO().getCodigoSucursal());
		gaVentasDTO.setNumTarjeta(cuenta.getClienteComDTO().getNumeroTarjeta());
		gaVentasDTO.setCodTipTarjeta(cuenta.getClienteComDTO().getCodigoTipoTarjeta());
		gaVentasDTO.setFecVenciTarj(formatoDelTexto.parse(cuenta.getClienteComDTO().getFechaVencimientoTarjeta()));
		gaVentasDTO.setCodBancoTarj(cuenta.getClienteComDTO().getCodigoBanco());
		gaVentasDTO.setNumCTACORR(cuenta.getClienteComDTO().getNumeroCuentaCorriente());
		gaVentasDTO.setCodCuota(DatosGeneralesVenta.getCodigoCuotas());
		 */



		long candma;
		long cangsm;

		if (cuenta.getClienteComDTO().getLineaCDMA() != null ){
			candma = cuenta.getClienteComDTO().getLineaCDMA().length;
		}else{
			candma = 0;
		}

		if (cuenta.getClienteComDTO().getLineaGSM() != null ){
			cangsm = cuenta.getClienteComDTO().getLineaGSM().length;
		}else{
			cangsm = 0;
		}

		gaVentasDTO.setNumUnidades( new Long( candma   +  cangsm));

		gaVentasDTO.setNomUsuarAcerec(DatosGeneralesVenta.getNombreUsuarioOracle());
		gaVentasDTO.setNomUsuarRecDoc(DatosGeneralesVenta.getNombreUsuarioOracle());
		gaVentasDTO.setNomUsuarCumpl(DatosGeneralesVenta.getNombreUsuarioOracle());
		gaVentasDTO.setIndOfiter("O");
		gaVentasDTO.setCodMoneda("001");
		gaVentasDTO.setCodPlaza("1");		
		gaVentasDTO.setIndPasoCob(new Long(0));
		gaVentasDTO.setIndChkDicom("0");
		gaVentasDTO.setTipValor("1");
		gaVentasDTO.setIndTipVenta(new Long(1));
		gaVentasDTO.setCodTipDocumento("1");




		if (DatosGeneralesVenta.getCodigoOperador() == null || DatosGeneralesVenta.getCodigoOperador().equals("")){
			gaVentasDTO.setIndPortado("0");
		}else{
			gaVentasDTO.setIndPortado("1");
		}


		/*--Realiza el cierre de la venta--*/
		getGestionDeCliente().creaVenta(gaVentasDTO);	
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

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

	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("getCategoriaTributariaCliente():start");
			clienteDTO = getGestionDeCliente().getCategoriaTributariaCliente(clienteDTO);
			logger.debug("getCategoriaTributariaCliente():end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getCategoriaTributariaCliente()");

			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return clienteDTO;
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

	public ClienteDTO getPlanComercial(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("getPlanComercial():start");
			clienteDTO = getGestionDeCliente().getPlanComercial(clienteDTO);
			logger.debug("getPlanComercial():end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getPlanComercial()");

			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return clienteDTO;
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

	public RegistroVentaDTO getSecuencia(RegistroVentaDTO registroVentaDTO) throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("getSecuenciaTransacabo():start");
			registroVentaDTO = getGestionDeCliente().getSecuencia(registroVentaDTO);
			logger.debug("getSecuenciaTransacabo():end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getSecuenciaTransacabo()");

			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return registroVentaDTO;
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

	public ArticuloDTO setReservaSerie(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("Inicio: setReservaSerie:start");
			getGestionDeCliente().setReservaSerie(articuloDTO);
			logger.debug("Fin: setReservaSerie:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return articuloDTO;
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

	public ArticuloDTO setActualizaStock(ArticuloDTO articuloDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: setActualizaStock:start");
			articuloDTO  = getGestionDeCliente().setActualizaStock(articuloDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: setActualizaStock:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return articuloDTO;
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
	public RetornoDTO setUpdateAbonadoNumImei(AbonadoDTO abonadoDTO)throws GeneralException{
		RetornoDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: setUpdateAbonadoNumImei:start");
			retValue=getGestionDeCliente().setUpdateAbonadoNumImei(abonadoDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: setUpdateAbonadoNumImei:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		return retValue;
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
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("getListadoNumeroMesesContrato():start");
			contrato = getGestionDeCliente().getTipcontrato(contrato);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("getListadoNumeroMesesContrato():end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getListadoNumeroMesesContrato()");

			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return contrato;
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
	public TerminalSNPNDTO getTerminal(TerminalSNPNDTO terminalDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: getTerminal:start");
			terminalDTO=getGestionDeCliente().getTerminal(terminalDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: getTerminal:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return terminalDTO;
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
	public SimcardSNPNDTO getTerminal(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: getTerminal:start");
			simcardSNPNDTO=getGestionDeCliente().getSimcard(simcardSNPNDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: getTerminal:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return simcardSNPNDTO;
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
	public AbonadoDTO getAbonadoPorNumCelular(AbonadoDTO abonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		AbonadoDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: getAbonadoPorNumCelular:start");
			retValue=getGestionDeCliente().getAbonadoPorNumCelular(abonadoDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: getAbonadoPorNumCelular:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		logger.debug("Fin:getAbonadoPorNumCelular()");
		return retValue;
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
	public ResultadoRegCargosDTO registrarCargos(ParametrosRegistrarCargosDTO parametrosRegistrarCargosDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		ResultadoRegCargosDTO retValue=null;
		try{
			logger.debug("Inicio: registrarCargos:start");			
			logger.debug("parametrosRegistrarCargosDTO.getCodCiclo() ["+parametrosRegistrarCargosDTO.getCodCiclo()+"]");

			retValue=getFrmkCargosFacade().registrarCargos(parametrosRegistrarCargosDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: registrarCargos:end");
		}
		catch(GeneralException e){
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		logger.debug("Fin:getObtencionCargos()");
		return retValue;
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
	public void grabaEstadoAsinc(EstadoAsincDTO EstadoAsinc)
	throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: grabaEstadoAsinc:start");
			getGestionDeCliente().grabaEstadoAsinc(EstadoAsinc);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: grabaEstadoAsinc:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("crearCliente():end");
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
	public void grabaEstadoAsincSinSPNID(EstadoAsincDTO EstadoAsinc)
	throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Inicio: grabaEstadoAsincSinSPNID:start");
			getGestionDeCliente().grabaEstadoAsincSinSPNID(EstadoAsinc);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: grabaEstadoAsincSinSPNID:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new GeneralException(e);
		}
		logger.debug("grabaEstadoAsincSinSPNID():end");
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
	public void setAnulacionVenta(AnulacionVentaDTO anulacionVentaDTO)throws GeneralException{
		AnulacionVentaRetornoDTO retValue= new AnulacionVentaRetornoDTO();
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{

			retValue.setCodCausaBaja(anulacionVentaDTO.getCodCausaBaja()); 
			retValue.setIdentificadorTransaccion(anulacionVentaDTO.getIdentificadorTransaccion());   
			retValue.setNumCelular(anulacionVentaDTO.getNumCelular());  
			retValue.setUsuario(anulacionVentaDTO.getUsuario());  

			logger.debug("Inicio: setAnulacionVenta:start");
			
			//INI-01 (AL) - Comentado - Portabilidad
			//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
			//EstadoAsinc.setSpnPortId(retValue.getIdentificadorTransaccion() );
			//EstadoAsinc.setNumCel((int) retValue.getNumCelular());
			//EstadoAsinc.setCodEstado("38");
			//grabaEstadoAsincSinSPNID(EstadoAsinc);	
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			retValue=getGestionDeCliente().setAnulacionVenta(retValue);

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Fin: setAnulacionVenta:end");
			
			//INI-01 (AL) - Comentado - Portabilidad
			//EstadoAsinc.setSpnPortId(anulacionVentaDTO.getIdentificadorTransaccion() );
			//EstadoAsinc.setNumCel((int) anulacionVentaDTO.getNumCelular());
			//EstadoAsinc.setCodEstado("39");
			//grabaEstadoAsincSinSPNID(EstadoAsinc);	
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("GeneralException[", e);
			//INI-01 (AL) - Comentado - Portabilidad
			//try{				
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(retValue.getIdentificadorTransaccion() );
				//EstadoAsinc.setNumCel((int) retValue.getNumCelular());
				//EstadoAsinc.setCodEstado("40");
				//grabaEstadoAsincSinSPNID(EstadoAsinc);
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
			//}
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception[", e);
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(retValue.getIdentificadorTransaccion() );
				//EstadoAsinc.setNumCel((int) retValue.getNumCelular());
				//EstadoAsinc.setCodEstado("40");
				//grabaEstadoAsincSinSPNID(EstadoAsinc);
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("Fin:getObtencionCargos()");		
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
	public CierreVentaOutDTO cierreVenta(WsCierreVentaInDTO cierreVenta, int rollback)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("CierreVenta():start");
		CierreVentaOutDTO cierreVentaOut = new CierreVentaOutDTO();
		CierreVentaImasDDTO CierreVentaImasD = new CierreVentaImasDDTO();
		ArrayList listadeErrores = new ArrayList();
		//AbonadoDTO[] listaAbonados = new AbonadoDTO[1];
		ArrayList errores = new ArrayList();
		String setTipProceso = "1";
		int situacionVenta = 0;

		CierreVentaImasD.setIdentificadorTransaccion(cierreVenta.getIdentificadorTransaccion());
		CierreVentaImasD.setUsuario(cierreVenta.getUsuario());
		CierreVentaImasD.setVenta(cierreVenta.getVenta());

		try {

			long numeroventa= new Long(cierreVenta.getVenta()).longValue();
			GaVentasDTO Ventas = new GaVentasDTO(); 
			Ventas.setNumVenta(Long.valueOf(cierreVenta.getVenta()));
			logger.debug("++++++++++++++++++++++++++++++++++ Antes getVenta ++++++++++++++++++++++++++++++++++++++++++++");
			Ventas = getGestionDeCliente().getVenta(Ventas);
			logger.debug("gaVentasDTO.getIndEstVenta() ["+Ventas.getIndEstVenta()+"]");
			logger.debug("++++++++++++++++++++++++++++++++++ Despues getVenta ++++++++++++++++++++++++++++++++++++++++++++");



			ValidacionesAltaLinea.ValidaUsuarioSCL(cierreVenta.getUsuario());
			errores = valida.ValidarCierreVenta(cierreVenta);
			if (errores.toArray().length > 0 ) {
				cierreVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				cierreVentaOut.setResultadoTransaccion("1");
			}else{		
				//INI-01 (AL) - Comentado - Portabilidad
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cierreVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("1");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cierreVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

				recuperaVenta(cierreVenta);

				logger.debug("recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				logger.debug("situacionVenta: ["+situacionVenta+"]");
				if (validaEstadoVenta(listadeErrores, situacionVenta)) {
					if (recuperaAbonadosVenta(listadeErrores)){
						ventaGlobalDTO.setNomUsuarAcerec(cierreVenta.getUsuario());
						ventaGlobalDTO.setCodigoActuacionDefecto("VO");
						ventaGlobalDTO.setCodigoUsuario(cierreVenta.getUsuario());
						ventaGlobalDTO.setParametroCodigoSimcardGSM("G");					
						ventaGlobalDTO.setTipoPlanHibrido("3");
						ventaGlobalDTO.setTipoPlanPostpago("2");
						ventaGlobalDTO.setTipoPlanPrepago("1");
						ventaGlobalDTO.setMtoGarantia(cierreVenta.getMtoGarantia());
						ventaGlobalDTO.setCodCliente( new Long(listaAbonadosCierre[0].getCodCliente()));



						if (provisionandoLinea(listadeErrores)){
							if(procesosPreCierre(listadeErrores)){
								if (cierreVenta(listadeErrores)){	
									//INI-01 (AL) - Comentado - Portabilidad
									//EstadoAsinc.setCodEstado("2");
									//EstadoAsinc.setTipProceso(setTipProceso);
									//EstadoAsinc.setNumProceso(cierreVenta.getVenta());
									//grabaEstadoAsinc(EstadoAsinc);	
								}else{
									CierreVentaImasD.setListaErrores(listadeErrores);						
								}
							}else{
								CierreVentaImasD.setListaErrores(listadeErrores);	
							}
						}else{
							CierreVentaImasD.setListaErrores(listadeErrores);
						}	
					}else{
						CierreVentaImasD.setListaErrores(listadeErrores);						
					}	
				}else{
					throw new GeneralException("12479",0,"Error: No es posible ejecutar el cierre antes del proceso de facturacion ["+ventaGlobalDTO.getNumVenta()+"]");
				}
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
			if (CierreVentaImasD.getListaErrores() != null){
				if (CierreVentaImasD.getListaErrores().size() > 0){
					throw new GeneralException("error cierre de venta");
				}
			}	

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cierreVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("3");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cierreVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);			
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}


			RetornoDTO error = new RetornoDTO();	
			cierreVentaOut = new CierreVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			cierreVentaOut.setResultadoTransaccion("1");
			cierreVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return cierreVentaOut;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cierreVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("3");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cierreVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}

			RetornoDTO error = new RetornoDTO();	
			cierreVentaOut = new CierreVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			cierreVentaOut.setResultadoTransaccion("1");
			cierreVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return cierreVentaOut;
		}
		logger.debug("cierreVenta():end");
		return cierreVentaOut;

	}



	/***********************NUEVO********************************/

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AceptacionVentaOutDTO aceptacionVenta(WsAceptacionVentaInDTO aceptacionVenta, int rollback)
	throws GeneralException{
		AceptacionVentaOutDTO aceptacionVentaOut = new AceptacionVentaOutDTO();
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("aceptacionVenta():start");
		CierreVentaImasDDTO CierreVentaImasD = new CierreVentaImasDDTO();
		ArrayList errores = new ArrayList();
		RetornoDTO respuesta = new RetornoDTO();
		ArrayList error = new ArrayList();
		String setTipProceso = "1";
		int situacionVenta = 1;

		try {
			ValidacionesAltaLinea.ValidaUsuarioSCL(aceptacionVenta.getUsuario() );
			errores = valida.ValidarAceptacionVenta(aceptacionVenta);
			if (errores.toArray().length > 0 ) {
				aceptacionVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				aceptacionVentaOut.setResultadoTransaccion("1");
			}else{
				//INI-01 (AL) - Comentado - Portabilidad
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(aceptacionVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("4");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(aceptacionVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

				if (!recuperaVentaAceptacion(aceptacionVenta, error)){
					CierreVentaImasD.setListaErrores(error);
					throw new GeneralException("Error al recuperar datos de la Venta");
				}

				logger.debug("recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				logger.debug("situacionVenta: ["+situacionVenta+"]");
				if (validaEstadoVenta(error,situacionVenta)) {
					if (recuperaAbonadosVenta(error)){

						ventaGlobalDTO.setNomUsuarAcerec(aceptacionVenta.getUsuario());
						ventaGlobalDTO.setCodigoUsuario(aceptacionVenta.getUsuario());
						ventaGlobalDTO.setIndEstVenta("AC");
						logger.debug("Inicio UpdateVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");

						getGestionDeCliente().setAceptacionVenta(ventaGlobalDTO);

						logger.debug("Fin UpdateVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");	
						respuesta.setCodError("0");						
						logger.debug("Resultado transaccion 0");
						
						//INI-01 (AL) - Comentado - Portabilidad
						//EstadoAsinc.setCodEstado("5");
						//EstadoAsinc.setTipProceso(setTipProceso);
						//EstadoAsinc.setNumProceso(aceptacionVenta.getVenta());
						//grabaEstadoAsinc(EstadoAsinc);	
					}
				}
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(aceptacionVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("6");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(aceptacionVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);	
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}

			RetornoDTO error1 = new RetornoDTO();	
			aceptacionVentaOut = new AceptacionVentaOutDTO();
			error1.setCodError(e.getCodigo());
			error1.setMensajseError(e.getDescripcionEvento());
			errores.add(error1);
			aceptacionVentaOut.setResultadoTransaccion("1");
			aceptacionVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return aceptacionVentaOut;		

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(aceptacionVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("6");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(aceptacionVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}

			RetornoDTO error1 = new RetornoDTO();	
			aceptacionVentaOut = new AceptacionVentaOutDTO();
			error1.setCodError("1");
			error1.setMensajseError(e.getMessage());
			errores.add(error1);
			aceptacionVentaOut.setResultadoTransaccion("1");
			aceptacionVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return aceptacionVentaOut;			
		}
		logger.debug("aceptacionVenta():end");
		return aceptacionVentaOut;

	}

	/*****************************fin nuevo*******************/

	// ************************************* Rechazo Venta ********************************

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RechazoVentaOutDTO rechazoVenta(WsRechazoVentaInDTO rechazoVenta, int rollback)
	throws GeneralException{
		RechazoVentaOutDTO rechazoVentaOut = new RechazoVentaOutDTO();
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("rechazoVenta():start");
		ArrayList errores = new ArrayList();
		RetornoDTO respuesta = new RetornoDTO();
		ArrayList error = new ArrayList();
		String setTipProceso = "1";
		int situacionVenta = 2;

		try {
			errores = valida.ValidarRechazoVenta(rechazoVenta);
			if (errores.toArray().length > 0 ) {
				rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				rechazoVentaOut.setResultadoTransaccion("1");
			}else{

				//INI-01 (AL) - Comentado - Portabilidad
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(rechazoVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("18");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(rechazoVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

				if (!recuperaVentaRechazo(rechazoVenta, error)){

					throw new GeneralException ("12486",0,"Error al recuperar datos de la Venta");
				}

				logger.debug("recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				logger.debug("situacionVenta: ["+situacionVenta+"]");
				if (validaEstadoVenta(error,situacionVenta)) {

					getGestionDeCliente().ActualizaSituacionAbonado(ventaGlobalDTO, config.getString("BajaAbonado"));	

					ventaGlobalDTO.setNomUsuarAcerec(rechazoVenta.getUsuario());
					ventaGlobalDTO.setCodigoUsuario(rechazoVenta.getUsuario());
					ventaGlobalDTO.setIndEstVenta("RE");
					logger.debug("Inicio UpdateVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");				
					getGestionDeCliente().updateVentas(ventaGlobalDTO);	
					logger.debug("Fin UpdateVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");	
					respuesta.setCodError("0");						
					logger.debug("Resultado transaccion 0");

					//INI-01 (AL) - Comentado - Portabilidad
					//EstadoAsinc.setCodEstado("19");
					//EstadoAsinc.setTipProceso(setTipProceso);
					//EstadoAsinc.setNumProceso(rechazoVenta.getVenta());
					//grabaEstadoAsinc(EstadoAsinc);	

				}
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(rechazoVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("20");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(rechazoVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);			
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}

			RetornoDTO error1 = new RetornoDTO();	
			rechazoVentaOut = new RechazoVentaOutDTO();
			error1.setCodError(e.getCodigo());
			error1.setMensajseError(e.getDescripcionEvento());
			errores.add(error1);
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return rechazoVentaOut;		

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(rechazoVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("20");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(rechazoVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}				

			RetornoDTO error1 = new RetornoDTO();	
			rechazoVentaOut = new RechazoVentaOutDTO();
			error1.setCodError("1");
			error1.setMensajseError(e.getMessage());
			errores.add(error1);
			rechazoVentaOut.setResultadoTransaccion("1");
			rechazoVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return rechazoVentaOut;			
		}
		logger.debug("aceptacionVenta():end");
		return rechazoVentaOut;

	}


	// ************************************* Fin Rechazo Venta ****************************


//	validarTarjeta
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSValidarTarjetaOutDTO validarTarjeta(WsValTarjetaInDTO wsValTarjetaInDTO) throws GeneralException{
		WSValidarTarjetaOutDTO retValue=null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: validarTarjeta:start");
			retValue=getGestionDeCliente().validarTarjeta(wsValTarjetaInDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: validarTarjeta:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public void  updateEquipoAboser (AbonadoDTO  abonadoDTO)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("Inicio:validarTarjeta");
		try {
			getGestionDeCliente().updateEquipoAboser(abonadoDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:validarTarjeta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:validarTarjeta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("Fin:validarTarjeta");
		//return resultado;
	}





	/**
	 * @param ParametrosFactVentaDTO
	 * @description realiza validaciones de parametros y logica de negocio con respecto a los datos enviados.
	 * @return boolean
	 */
	private AbonadoDTO[] getListAbonados(ParametrosFactVentaDTO parametrosFactVentaDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ArrayList listaAbonados=new ArrayList();
		GaVentasDTO gaVentasDTO= new GaVentasDTO();
		long numeroVenta=0;
		try{
			ParametrosLineasFactVentaDTO[] parametrosLineas =parametrosFactVentaDTO.getParametrosLineasFactVentaDTO();
			for(int i=0;i<parametrosLineas.length;i++){
				AbonadoDTO abonadoDTO= new AbonadoDTO();
				abonadoDTO.setNumCelular(parametrosLineas[i].getNumCelular());
				abonadoDTO=this.getAbonadoPorNumCelular(abonadoDTO);
				numeroVenta=abonadoDTO.getNumVenta();
				listaAbonados.add(abonadoDTO);
			}

			gaVentasDTO.setNumVenta(new Long(numeroVenta));
			gaVentasDTO = getGestionDeCliente().getVenta(gaVentasDTO);
		}
		catch(GeneralException e){
			logger.debug("GeneralException ");
			logger.error(e);

			throw e;
		} catch (Exception e) {
			logger.debug("RemoteException ");
			logger.error(e);

			throw new GeneralException(e);
		}
		if (!config.getString("parametro.estado.venta.IV").equals(gaVentasDTO.getIndEstVenta())){
			logger.error("Venta en estado ["+gaVentasDTO.getIndEstVenta()+"] distinto de [IV]" );
			throw new GeneralException("12317",0,"Venta en estado ["+gaVentasDTO.getIndEstVenta()+"] distinto de [IV]");
		}else{
			listAbonados =((AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaAbonados.toArray(), AbonadoDTO.class));
		}
		listaAbonados.clear();
		return listAbonados;
	}




	private boolean isAbonadosVenta(AbonadoDTO[] abonados)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		boolean retValue=true;
		try{
			for(int i=1;i<abonados.length;i++){
				if (abonados[0].getNumVenta()!=abonados[i].getNumVenta()){
					logger.debug("abonados[0].getNumVenta() ["+abonados[0].getNumVenta()+"]");
					logger.debug("abonados["+i+"].getNumVenta() ["+abonados[i].getNumVenta()+"]");
					logger.debug("abonados[i].getNumVenta() ["+abonados[i].getNumCelular()+"]");
					retValue=false;
					break;
				}
			}
		}catch(Exception e){
			retValue=false;
		}
		return retValue;
	}


	private ArticuloDTO getObtenerSerieTerminalxCodArticulo(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Start : getObtenerSerieTerminalxCodArticulo");
		ArticuloDTO[] retValue=null;
		try{
			retValue=getGestionDeCliente().getListArticuloPorCodigo(articuloDTO);
			if (retValue!=null&&retValue.length>0){
				for (int i=0;0<retValue.length;i++){
					if ("T".equals(retValue[i].getTipTerminal())){
						articuloDTO=retValue[i];
						break;
					}
				}
			}
			else{
				String glosaError="No se encontraron articulos disponibles para el código ["+articuloDTO.getCodigo()+"]";
				logger.debug(glosaError);
				articuloDTO=null;
				throw new GeneralException("12318",0,glosaError);

			}
		}
		catch(GeneralException e){
			logger.debug("GeneralException");
			logger.error(e);
			throw e;
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new GeneralException(e);
		}
		logger.debug("end : getObtenerSerieTerminalxCodArticulo");
		return articuloDTO;
	}







	private ParametrosRegistrarCargosDTO llenarDTORegistrarCargos(CargosDTO[] cargosDTO, AbonadoDTO[] listAbonadosFac, WsFacturacionVentaInDTO WsFacturacionVentaIn)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ParametrosRegistrarCargosDTO retValue=new ParametrosRegistrarCargosDTO();
		try{
			retValue.setCargos(cargosDTO);
			long codCliente=listAbonadosFac[0].getCodCliente();
			long numVenta=listAbonadosFac[0].getNumVenta();
			long numTransaccionVenta=0;//Esto Consultar si se ejecuta un nueva llamada a Transacabo

			RegistroVentaDTO registroVentaDTO= new RegistroVentaDTO();
			registroVentaDTO.setCodigoSecuencia(config.getString("codigo.secuencia.transacabo"));
			registroVentaDTO=this.getSecuencia(registroVentaDTO);
			numTransaccionVenta=registroVentaDTO.getNumeroTransaccionVenta();


			String codVendedor=String.valueOf(listAbonadosFac[0].getCodVendedor());
			//Realizamos consulta para obtener el plan comercial del cliente
			ClienteDTO clienteDTO=new ClienteDTO();
			clienteDTO.setCodigoCliente(String.valueOf(listAbonadosFac[0].getCodCliente()));
			clienteDTO =this.getPlanComercial(clienteDTO);
			String planComercialCliente=clienteDTO.getPlanComercial();
			clienteDTO=this.getCategoriaTributariaCliente(clienteDTO);
			String categTributaria="FACTURA".equals(clienteDTO.getCategoriaTributaria())?"F":"B";
			VendedorDTO vendedorDTO= new VendedorDTO();
			vendedorDTO.setCodigoVendedor(codVendedor);
			vendedorDTO.setCodigoVendedorDealer(listAbonadosFac[0].getCodVendealer());
			vendedorDTO=this.getVendedor(vendedorDTO);
			String codOficinaVendedor=vendedorDTO.getCodigoOficina();
			long codVendedorRaiz=vendedorDTO.getCodigoVendedorRaiz();
			int codCiclo=listAbonadosFac[0].getCodCiclo();
			long codModalidadPago=listAbonadosFac[0].getCodModVenta();


			//String codDocumento=01;

			retValue.setCodCliente(codCliente);
			retValue.setNumVenta(numVenta);
			retValue.setNumTransaccionVenta(numTransaccionVenta);
			retValue.setPlanComercialCliente(planComercialCliente);//GA_CLIENTE_PCOM
			retValue.setCodOficinaVendedor(codOficinaVendedor);
			retValue.setCategTributaria(categTributaria);
			retValue.setCodDocumento(1);
			retValue.setTipoFoliacion("A");
			retValue.setCodModalidadPago(String.valueOf(codModalidadPago));
			retValue.setFacturaACiclo(WsFacturacionVentaIn.isFacturaACiclo());  // false para factura inmediata, True para factura aciclo
			retValue.setCodVendedor(Long.parseLong(codVendedor));
			retValue.setCodVendedorRaiz(codVendedorRaiz);
			retValue.setCodCiclo(codCiclo);

			//retValue.setPlanComercialCliente("");
		}
		catch(GeneralException e){
			logger.debug("GeneralException");
			throw(e);
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new GeneralException(e);		
		}

		return retValue;
	}

	private ParametrosCodDescDTO[] llenarDTOCodCausaDesc(ParametrosFactVentaDTO parametrosFactVentaDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ParametrosCodDescDTO[] listParametrosCodDescDTO=null;
		try{
			ArrayList list=new ArrayList();
			for(int i=0;i<parametrosFactVentaDTO.getParametrosLineasFactVentaDTO().length;i++){
				parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[i].getNumCelular();
				ParametrosCodDescDTO parametrosCodDescDTO=new ParametrosCodDescDTO();
				parametrosCodDescDTO.setCodigoCausaDescuento(parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[i].getCodigoCausalDescuento());
				for (int j=0;j<listAbonados.length;j++){
					if (listAbonados[j].getNumCelular()==parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[i].getNumCelular()){
						parametrosCodDescDTO.setNumAbonado(String.valueOf(listAbonados[j].getNumAbonado()));
					}
					break;
				}

				list.add(parametrosCodDescDTO);
			}
			listParametrosCodDescDTO=(ParametrosCodDescDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), ParametrosCodDescDTO.class);
		}
		catch(Exception e){
			logger.error(e);
			throw new GeneralException(e);	
		}
		return listParametrosCodDescDTO;
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
	public ArrayList validaIdentificador(CuentaComDTO cuentaCom, ArrayList listaerrores)throws GeneralException{    	
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			logger.debug("validaIdentificador:start");
			listaerrores = getGestionDeCliente().validaIdentificador(cuentaCom, listaerrores);		
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("validaIdentificador:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("getListArticuloPorCodigo:end");	
		return listaerrores;
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
	public long getSecuenciaVenta()throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		long resultado;
		logger.debug("Inicio:getSecuenciaVenta()");
		try{
			resultado = getGestionDeCliente().getSecuenciaVenta();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getSecuenciaVenta()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:creacionLineas()");
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
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		PlanTarifarioDTO resultado = null;
		logger.debug("Inicio:getPlanTarifario()");
		try{
			resultado = getGestionDeCliente().getPlanTarifario(entrada);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:getPlanTarifario()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw new GeneralException(e);
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

	public ContratoDTO obtenerContratoNuevo() throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ContratoDTO Contrato=null;
		try{
			logger.debug("Inicio: obtenerContratoNuevo:start");
			Contrato=getGestionDeCliente().obtenerContratoNuevo();
			logger.debug("Fin: obtenerContratoNuevo:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Fin:obtenerContratoNuevo()");

			throw e;
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return Contrato;
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
	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO entrada)
	throws GeneralException{
		SimcardSNPNDTO resultado=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Inicio:getSimcard()");
			resultado = getGestionDeCliente().getSimcard(entrada); 
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getSimcard()");
		return resultado;
	}//fin getSimcard



	private ArrayList ValidaTermianlVentaCredito(ParametrosFactVentaDTO parametrosFactVentaDTO, GaVentasDTO Venta ,ArrayList listaerrores)throws GeneralException, RemoteException{						
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("ValidaTermianlVentaCredito Start");

		for(int j=0;j<parametrosFactVentaDTO.getParametrosLineasFactVentaDTO().length;j++){
			logger.debug("Venta.getCodModVenta() ["+Venta.getCodModVenta()+"]");
			logger.debug("parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[j].getTipTerminal() ["+parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[j].getTipTerminal()+"]");
			if (Venta.getCodModVenta().equals("7") && parametrosFactVentaDTO.getParametrosLineasFactVentaDTO()[j].getTipTerminal().equals("E") ){
				logger.debug("Para venta a credito terminal no puede ser externo");
				WsRespuestaValidacionCuentaDTO retorno = new WsRespuestaValidacionCuentaDTO();
				retorno.setNumLinea(""+(j+1));
				retorno.setCodigoRespuesta("12334");
				retorno.setDescripcion("Para venta a credito terminal no puede ser externo");						
				listaerrores.add(retorno);					
			}
		}
		logger.debug("ValidaTermianlVentaCredito End");
		return listaerrores;
	}	


	private boolean recuperaVenta(WsCierreVentaInDTO  venta) throws GeneralException{
		WsRespuestaImasDDTO error;
		GaVentasDTO ventaDTO2 = new GaVentasDTO();
		ArrayList listadeErrores = new ArrayList();
		try{
			ventaGlobalDTO.setNumVenta(new Long(venta.getVenta()));					
			ventaGlobalDTO = getGestionDeCliente().getVenta(ventaGlobalDTO);

			logger.debug(" recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");						
		}catch (GeneralException e) {
			e.setCodigo("12272");
			e.setDescripcionEvento("Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			logger.debug("Error 12272 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw e;
		}catch (Exception e) {
			logger.debug("Error 12273 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw new GeneralException ("12273",0,"Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]"); 			
		}
		return true;
	}

	private boolean recuperaVentaAceptacion(WsAceptacionVentaInDTO  venta, ArrayList listadeErrores) throws GeneralException{
		WsRespuestaImasDDTO error;
		GaVentasDTO ventaDTO2 = new GaVentasDTO();
		try{
			ventaGlobalDTO.setNumVenta(new Long(venta.getVenta()));					
			ventaGlobalDTO = getGestionDeCliente().getVenta(ventaGlobalDTO);
			logger.debug(" recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");						
		}catch (GeneralException e) {
			logger.debug("Error 12290 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			e.setCodigo("12290");
			e.setDescripcionEvento("Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw e;		
		}catch (Exception e) {
			logger.debug("Error 12291 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw new GeneralException ("12291",0,"Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");		
		}
		return true;
	}

	//***********************************************************************

	private boolean recuperaVentaRechazo(WsRechazoVentaInDTO  venta, ArrayList listadeErrores) throws GeneralException{
		WsRespuestaImasDDTO error;
		GaVentasDTO ventaDTO2 = new GaVentasDTO();
		try{
			ventaGlobalDTO.setNumVenta(new Long(venta.getVenta()));					
			ventaGlobalDTO = getGestionDeCliente().getVenta(ventaGlobalDTO);
			logger.debug(" recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");						
		}catch (GeneralException e) {
			logger.debug("Error 12290 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			e.setCodigo("12290");
			e.setDescripcionEvento("Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw e;		
		}catch (Exception e) {
			logger.debug("Error 12291 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw new GeneralException ("12291",0,"Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");		
		}
		return true;
	}

	private boolean recuperaVentaFacturacion(WsFacturacionVentaInDTO venta) throws GeneralException{
		WsRespuestaImasDDTO error;
		GaVentasDTO ventaDTO2 = new GaVentasDTO();
		try{
			ventaGlobalDTO.setNumVenta(new Long(venta.getNumVenta()));					
			ventaGlobalDTO = getGestionDeCliente().getVenta(ventaGlobalDTO);
			logger.debug(" recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");						
		}catch (GeneralException e) {
			logger.debug("Error 12290 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			e.setCodigo("12290");
			e.setDescripcionEvento("Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw e;		
		}catch (Exception e) {
			logger.debug("Error 12291 - Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");
			throw new GeneralException ("12291",0,"Error al recuperar venta ["+ventaGlobalDTO.getNumVenta()+"]");		
		}
		return true;
	}

	//***********************************************************************


	//int situacionVenta : 0 es Cierre Venta, 1 es Aceptacion Venta, 2 es Rechazo Venta y 3 Proceso de Facturacion
	private boolean validaEstadoVenta( ArrayList listadeErrores , int situacionVenta ){		
		WsRespuestaImasDDTO error;
		if(situacionVenta == 0){
			if(!ventaGlobalDTO.getIndEstVenta().equals("VF")){
				error = new WsRespuestaImasDDTO();
				logger.debug("Error 12274 - Error: Debe ejecutar Proceso de Facturacion de venta ["+ventaGlobalDTO.getNumVenta()+"] estado venta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				error.setCodigoError("12274");
				error.setDescripcionErro("Error: Debe ejecutar Proceso de Facturacion de venta ["+ventaGlobalDTO.getNumVenta()+"] estado venta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				listadeErrores.add(error);
				return false;
			}
		}
		else if(situacionVenta == 2){
			if(!ventaGlobalDTO.getIndEstVenta().equals("IV")){
				error = new WsRespuestaImasDDTO();
				logger.debug("Error 12479 - Error: Es posible ejecutarlo antes del proceso de facturacion ["+ventaGlobalDTO.getNumVenta()+"]");
				error.setCodigoError("12479");
				error.setDescripcionErro("Error: Es posible ejecutarlo antes del proceso de facturacion ["+ventaGlobalDTO.getNumVenta()+"]");
				listadeErrores.add(error);
				return false;
			}			
		}
		else if (situacionVenta == 3){
			if(!ventaGlobalDTO.getIndEstVenta().equalsIgnoreCase("IV")){
				/*error = new WsRespuestaImasDDTO();
				logger.debug("Error 12479 - Error: Es posible ejecutarlo antes del proceso de facturacion ["+ventaGlobalDTO.getNumVenta()+"]");
				error.setCodigoError("12479");
				error.setDescripcionErro("Error: Es posible ejecutarlo antes del proceso de facturacion ["+ventaGlobalDTO.getNumVenta()+"]");
				listadeErrores.add(error);*/
				return false;
			}
		}
//		Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
		else if (situacionVenta == 4){
			//if( ("VF").equals(ventaGlobalDTO.getIndEstVenta())||("IV").equals(ventaGlobalDTO.getIndEstVenta())||("AC").equals(ventaGlobalDTO.getIndEstVenta())||("PA").equals(ventaGlobalDTO.getIndEstVenta())||("PD").equals(ventaGlobalDTO.getIndEstVenta())||("PC").equals(ventaGlobalDTO.getIndEstVenta())){
			logger.debug("INCIDENCIA 143860 -- Se agrega estado IV a cancelacion de venta");
			if( ("VF").equals(ventaGlobalDTO.getIndEstVenta())||("AC").equals(ventaGlobalDTO.getIndEstVenta())||("PA").equals(ventaGlobalDTO.getIndEstVenta())||("PD").equals(ventaGlobalDTO.getIndEstVenta())||("PC").equals(ventaGlobalDTO.getIndEstVenta())){	
				error = new WsRespuestaImasDDTO();
				logger.debug("Error 12488 - Error: No es posible reversar la venta ["+ventaGlobalDTO.getNumVenta()+"]");
				error.setCodigoError("12488");
				error.setDescripcionErro("Error: No es posible reversar la venta ["+ventaGlobalDTO.getNumVenta()+"]");
				listadeErrores.add(error);
				return false;
			}
		}
//		Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
		return true;			
	}	


	private boolean recuperaAbonadosVenta(ArrayList listadeErrores){				
		RegistroVentaDTO regventa = new RegistroVentaDTO();
		WsRespuestaImasDDTO error;
		try{			
			regventa.setNumeroVenta(ventaGlobalDTO.getNumVenta().longValue());				
			listaAbonadosCierre = getGestionDeCliente().getListaAbonadosVenta(regventa);	
		}catch (GeneralException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12275 - Error al recuperar Lista de Abonados Venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError("12275");
			error.setDescripcionErro("Error al recuperar Lista de Abonados Venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}catch (RemoteException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12276 - Error al recuperar Lista de Abonados Venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError("12276");
			error.setDescripcionErro("Error al recuperar Lista de Abonados Venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}
		return true;
	}






	private boolean provisionandoLinea(ArrayList listadeErrores){						
		WsRespuestaImasDDTO error;
		try{					
			for(int i=0;i<listaAbonadosCierre.length;i++)
			{

				ventaGlobalDTO.setAbonado(listaAbonadosCierre[i]);     							
				getGestionDeCliente().provisionandoLinea(ventaGlobalDTO);				
			}	

		}catch (GeneralException e) {
			e.printStackTrace();
			logger.error(e);
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12281 - Error: en provisionandoLinea Abonado ["+ventaGlobalDTO.getAbonado()+"]");
			error.setCodigoError("12281");
			error.setDescripcionErro("Error: en provisionandoLinea Abonado ["+ventaGlobalDTO.getAbonado()+"]");
			listadeErrores.add(error);
			return false;
		}catch (RemoteException e) {
			e.printStackTrace();
			logger.error(e);
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12282 - Error: en provisionandoLinea Abonado ["+ventaGlobalDTO.getAbonado()+"]");
			error.setCodigoError("12282");
			error.setDescripcionErro("Error: en provisionandoLinea Abonado ["+ventaGlobalDTO.getAbonado()+"]");
			listadeErrores.add(error);
			return false;
		}
		return true;
	}

	private boolean procesosPreCierre(ArrayList listadeErrores){				
		WsRespuestaImasDDTO error;
		try{					  							
			ventaGlobalDTO = getGestionDeCliente().procesosPreCierre(ventaGlobalDTO);					

		}catch (GeneralException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug(e.getDescripcionEvento() + "- numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError(e.getCodigo());
			error.setDescripcionErro(e.getDescripcionEvento() + "- numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}catch (RemoteException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12338 - Error: en procesosPreCierre numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError("12338");
			error.setDescripcionErro("Error: en procesosPreCierre numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}
		return true;
	}	


	private boolean cierreVenta( ArrayList listadeErrores){				
		WsRespuestaImasDDTO error;
		try{					  							
			getGestionDeCliente().cierreVenta(ventaGlobalDTO);								
		}catch (GeneralException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12288 - Error: en cierreVenta numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError("12288");
			error.setDescripcionErro("Error: en cierreVenta numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}catch (RemoteException e) {
			error = new WsRespuestaImasDDTO();
			logger.debug("Error 12289 - Error: en cierreVenta numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			error.setCodigoError("12289");
			error.setDescripcionErro("Error: en cierreVenta numero de venta ["+ventaGlobalDTO.getNumVenta()+"]");
			listadeErrores.add(error);
			return false;
		}
		return true;
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
	public RegionDTO[] getListadoRegiones() throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		RegionDTO[] regiones = null;
		try{
			regiones=getGestionDeDirecciones().getListadoRegiones();
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return regiones;
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
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		ProvinciaDTO[] provincias = null;
		try{			                                       
			provincias=getGestionDeDirecciones().getListadoProvincias(region);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return provincias;
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
	public CiudadDTO[] getListadoCiudaddes(ProvinciaDTO provincia) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		CiudadDTO[] ciudades = null;
		try{
			ciudades=getGestionDeDirecciones().getListadoCiudaddes(provincia);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudades;
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
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		ComunaSPNDTO[] comunas = null;
		try{
			comunas=getGestionDeDirecciones().getListadoComunas(ciudad);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return comunas;
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
	public CentralDTO[] getListadoCentrales(CeldaInDTO entrada) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getListadoCentrales()");
		CentralDTO[] resultado = null;
		CeldaDTO entrada2 = new CeldaDTO();

		try{
			logger.debug("entrada CeldaInDTO codigoCelda [" + entrada.getCodigoCelda() + "]");
			entrada2.setCodigoCelda(entrada.getCodigoCelda());
			logger.debug("entrada2 CeldaDTO codigoCelda [" + entrada2.getCodigoCelda() + "]");
			resultado = getGestionDeCliente().getListadoCentrales(entrada2);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getListadoCentrales()");
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
	public WsMotivosDeDescuentoManualInDTO[] getListMotivosDeDescuentoManual(CausalDescuentoDTO causalDescuentoDTO) 
	throws GeneralException{  
		WsMotivosDeDescuentoManualInDTO[] retValue=null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: validarTarjeta:start");
			retValue=getGestionDeCliente().getListMotivosDeDescuentoManual(causalDescuentoDTO);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: validarTarjeta:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
		}
		return retValue;
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
	public void insDocumentoMotivo(CausalDescuentoDTO entrada)
	throws GeneralException{  
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: insDocumentoMotivo:start");
			getGestionDeCliente().insDocumentoMotivo(entrada);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: insDocumentoMotivo:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
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
	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) throws GeneralException{
		BodegaDTO[] resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getBodegasPorVendedor:start");
			resultado = getGestionDeCliente().getBodegasPorVendedor(codigoVendedor);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getBodegasPorVendedor:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			context.setRollbackOnly();	
			throw new GeneralException(e);
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
	public SSuplementariosDTO[] getSSincluidosEnPlan(String codigoPlanTarifario) 
	throws GeneralException{
		SSuplementariosDTO[] resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getSSincluidosEnPlan:start");
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			resultado = getGestionDeCliente().getSSincluidosEnPlan(codigoPlanTarifario);
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getSSincluidosEnPlan:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
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
	public SSuplementariosDTO[] getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral)	
	throws GeneralException{
		SSuplementariosDTO[] resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: getSSOpcionalesAlPlan:start");
			resultado = getGestionDeCliente().getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getSSOpcionalesAlPlan:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
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
	public ValidacionServicioSDTO getValidacionAgregaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal)	
	throws GeneralException{
		ValidacionServicioSDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: getValidacionAgregaServicio:start");
			resultado = getGestionDeCliente().getValidacionAgregaServicio(sSuplementariosCont, sSuplementariosVal);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getValidacionAgregaServicio:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
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
	public ValidacionServicioSDTO getValidacionEliminaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal)	
	throws GeneralException{
		ValidacionServicioSDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: getValidacionEliminaServicio:start");
			resultado = getGestionDeCliente().getValidacionEliminaServicio(sSuplementariosCont, sSuplementariosVal);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getValidacionEliminaServicio:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);

			throw new GeneralException(e);
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
	public SSuplementarioOutDTO setAgregaEliminaSS(WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar, Long NumeroCelular, String NomUsuario, int rollback)	
	throws GeneralException{
		//ValidacionServicioSDTO resultado = null;
		SSuplementarioOutDTO res = new SSuplementarioOutDTO();
		ArrayList errores = new ArrayList();
		ArrayList errores2 = new ArrayList();
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		ArrayList error = new ArrayList();
		RetornoDTO respuesta = new RetornoDTO();
		RetornoDTO respuesta2 = new RetornoDTO();

		try{
			logger.debug("SpnSclORQBean: setAgregaEliminaSS:start");

			ValidacionesAltaLinea.ValidaUsuarioSCL(NomUsuario);

			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelular(NumeroCelular.longValue());
			abonado = this.getAbonadoPorNumCelular(abonado);
			abonado.setNomUsuarOra(NomUsuario);
			//validaEliminarSS(sSuplemenAgregar, sSuplemenEliminar);
			validaGrupoSS(sSuplemenAgregar);
			validaExisteSSAbondo(sSuplemenAgregar, sSuplemenEliminar, abonado.getNumAbonado());

			if (sSuplemenEliminar != null ){//&& sSuplemenEliminar.length > 0){				
				errores = valida.ValidarAgregaEliminaSS(sSuplemenEliminar, NumeroCelular, NomUsuario);
				if (errores.toArray().length > 0 ) {
					res.setResultadoTransaccion("1");
					for (int i=0;i<errores.size();i++){
						error.add(errores.get(i));						
					}					
				}else{		
					getGestionDeCliente().setEliminarSS(abonado, sSuplemenEliminar);
					respuesta.setCodError("0");										
				}					
			}
			if (sSuplemenAgregar != null){
				errores2 = valida.ValidarAgregaEliminaSS(sSuplemenAgregar, NumeroCelular, NomUsuario);
				if (errores2.toArray().length > 0 ) {
					res.setResultadoTransaccion("1");
					for (int i=0;i<errores2.size();i++){
						error.add(errores2.get(i));						
					}
				}else{	
					getGestionDeCliente().setAgregaSS(abonado, sSuplemenAgregar);
					respuesta2.setCodError("0");				
				}	
			}
			if (error.size() > 0 ){//!= null){
				res.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));
			}else{
				if (respuesta != null){
					error.add(respuesta);
				}
				if (respuesta2 != null){
					error.add(respuesta2);
				}
				if (respuesta != null || respuesta2 != null){
					res.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));
				}
			}
			if (rollback == 0){
				logger.debug("rollback == 0 Rollback ["+rollback+"]");
				context.setRollbackOnly();
				logger.debug("context [TRUE]");
			}
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: setAgregaEliminaSS:end");

		}catch(GeneralException e){
			res = new SSuplementarioOutDTO();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			respuesta.setCodError(e.getCodigo());
			respuesta.setMensajseError(e.getDescripcionEvento());
			error.add(respuesta);
			res.setResultadoTransaccion("1");
			res.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));			
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();	
			return res;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			res = new SSuplementarioOutDTO();
			respuesta.setCodError("1");
			respuesta.setMensajseError(e.getMessage());
			error.add(respuesta);
			res.setResultadoTransaccion("1");
			res.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(error.toArray(), RetornoDTO.class));			
			logger.debug("Exception[", e);
			context.setRollbackOnly();	
			return res;
		}	

		return res;
	}			


	private void validaEliminarSS(WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar) 
	throws GeneralException{
		boolean estado = false;

		if (sSuplemenEliminar != null){
			for (int i=0; i<sSuplemenEliminar.length; i++){
				estado = false;
				for(int j=0; j<sSuplemenAgregar.length;j++){
					if (sSuplemenEliminar[i].getCodigoServSupl().equals(sSuplemenAgregar[j].getCodigoServSupl())){
						estado = true;
						break;
					}
				}
				if (!estado){
					logger.debug("12341 - Error - Al eliminar un servicio debe agregar uno del mismo gupo ["+sSuplemenEliminar[i].getCodigoServSupl()+"]");
					throw new GeneralException("12341",new Long(0).longValue(),"Al eliminar un servicio debe agregar uno del mismo gupo ["+sSuplemenEliminar[i].getCodigoServSupl()+"]");
				}
			}
		}
	}


	private void validaGrupoSS (WsAgregaEliminaSSInDTO[] sSuplemenAgregar) throws GeneralException{
		boolean estado = true;
		if (sSuplemenAgregar != null){
			for (int i=0; i<sSuplemenAgregar.length-1; i++){
				String codigoServSuplComp = sSuplemenAgregar[i].getCodigoServSupl();
				for(int j=i+1; j<sSuplemenAgregar.length; j++){
					if (codigoServSuplComp.equalsIgnoreCase(sSuplemenAgregar[j].getCodigoServSupl())){
						estado = false;
						break;
					}
				}
				if (!estado){
					logger.debug("12342 - Error - Al agregar mas de un servicio, estos no deben ser del mismo grupo: "+codigoServSuplComp);
					throw new GeneralException("12342",new Long(0).longValue(),"Al agregar mas de un servicio, estos no deben ser del mismo grupo: "+codigoServSuplComp);
				}	
			}
		}
	}

	private void validaExisteSSAbondo (WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar, long numAbonado) 
	throws GeneralException{
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: validaExisteSSAbondo:start");
			getGestionDeCliente().validaExisteSSAbondo(sSuplemenAgregar, sSuplemenEliminar, numAbonado);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclOrqBean: validaExisteSSAbondo:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
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
	public SerieDTO reservaSerie(SerieDTO serie)
	throws GeneralException{

		SerieDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: reservaSerie:start");
			resultado = getGestionDeCliente().reservaSerie(serie);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: reservaSerie:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			context.setRollbackOnly();	
			throw new GeneralException(e);
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
	public SerieDTO desReservaSerie(SerieDTO serie)
	throws GeneralException{

		SerieDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: desReservaSerie:start");
			resultado = getGestionDeCliente().desReservaSerie(serie);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: desReservaSerie:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			context.setRollbackOnly();	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			context.setRollbackOnly();	
			throw new GeneralException(e);
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
	public WsCuentaIdentOutDTO validaCuentaNumeroIdentificacion(WsCuentaIdentInDTO cuenta) 
	throws GeneralException{

		WsCuentaIdentOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		try{
			logger.debug("SpnSclORQBean: validaCuentaNumeroIdentificacion:start");
			resultado = getGestionDeCliente().validaCuentaNumeroIdentificacion(cuenta);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: validaCuentaNumeroIdentificacion:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);			
			throw new GeneralException(e);
		}
		return resultado;		
	}			

//	------------------------------------- NUEVO ------------------------------------------------	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public WsDireccionesOutDTO agregarDirecciones(WsDireccionInDTO[] WsDireccionesIn, int rollback) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("setDireccion():start");
		DireccionNegocioDTO direcciones = null;
		DireccionNegocioDTO[] direcciones2 = null;
		WsDireccionesOutDTO   wsDireccionesOut = new WsDireccionesOutDTO();
		ArrayList lista = new ArrayList();
		ArrayList errores = new ArrayList();
		String[] codigoDireccion = new String[WsDireccionesIn.length]; 

		try{	
			errores = valida.ValidarAgregarDirecciones(WsDireccionesIn);

			if (errores.toArray().length > 0 ) {
				wsDireccionesOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				wsDireccionesOut.setResultadoTransaccion("1");
			}else{
				for(int i=0;i<WsDireccionesIn.length;i++){			
					direcciones = new DireccionNegocioDTO();

					direcciones.setProvincia(WsDireccionesIn[i].getCodigoProvincia());
					direcciones.setRegion(WsDireccionesIn[i].getCodigoRegion());
					direcciones.setCiudad(WsDireccionesIn[i].getCodigoCiudad());
					direcciones.setComuna(WsDireccionesIn[i].getCodigoComuna());
					direcciones.setCalle(WsDireccionesIn[i].getNombreCalle());
					direcciones.setNumero(WsDireccionesIn[i].getNumeroCalle());
					direcciones.setPiso(WsDireccionesIn[i].getNumeroPiso());
					direcciones.setCasilla(WsDireccionesIn[i].getNumeroCasilla());
					direcciones.setPueblo(WsDireccionesIn[i].getCodigoPueblo());
					direcciones.setObservacionDescripcion(WsDireccionesIn[i].getObservacionDireccion());
					direcciones.setDescripcionDireccion1(WsDireccionesIn[i].getDescripcionDireccion1());
					direcciones.setDescripcionDireccion2(WsDireccionesIn[i].getDescripcionDireccion2());
					direcciones.setZip(WsDireccionesIn[i].getZIP());
					direcciones.setEstado(WsDireccionesIn[i].getCodigoEstado());
					direcciones.setTipoDireccion(0);
					lista.add(direcciones);
				}

				direcciones2 =(DireccionNegocioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), DireccionNegocioDTO.class);

				direcciones2 = getGestionDeDirecciones().setDireccion(direcciones2);

				for(int j=0;j<direcciones2.length;j++){				
					codigoDireccion[j] = direcciones2[j].getCodigo();																								
				}			
				wsDireccionesOut.setCodigosDirecciones(codigoDireccion);
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		} catch (GeneralException e) {			
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			wsDireccionesOut = new WsDireccionesOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionesOut.setResultadoTransaccion("1");
			wsDireccionesOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return wsDireccionesOut;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			wsDireccionesOut = new WsDireccionesOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionesOut.setResultadoTransaccion("1");
			wsDireccionesOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return wsDireccionesOut;

		}
		logger.debug("setDireccion():end");
		return wsDireccionesOut;

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
	public WsDireccionOutDTO agregarDireccion(WsDireccionInDTO WsDireccionesIn, int rollback) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("setDireccion():start");
		DireccionNegocioDTO direccion = new DireccionNegocioDTO();
		WsDireccionOutDTO   wsDireccionOut  = new WsDireccionOutDTO();  
		ArrayList errores = new ArrayList();
		try{
			errores = valida.ValidarAgregarDireccion(WsDireccionesIn);

			if (errores.toArray().length > 0 ) {
				wsDireccionOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				wsDireccionOut.setResultadoTransaccion("1");
			}else{

				direccion.setProvincia(WsDireccionesIn.getCodigoProvincia());
				direccion.setRegion(WsDireccionesIn.getCodigoRegion());
				direccion.setCiudad(WsDireccionesIn.getCodigoCiudad());
				direccion.setComuna(WsDireccionesIn.getCodigoComuna());
				direccion.setCalle(WsDireccionesIn.getNombreCalle());
				direccion.setNumero(WsDireccionesIn.getNumeroCalle());
				direccion.setPiso(WsDireccionesIn.getNumeroPiso());
				direccion.setCasilla(WsDireccionesIn.getNumeroCasilla());
				direccion.setPueblo(WsDireccionesIn.getCodigoPueblo());
				direccion.setObservacionDescripcion(WsDireccionesIn.getObservacionDireccion());
				direccion.setDescripcionDireccion1(WsDireccionesIn.getDescripcionDireccion1());
				direccion.setDescripcionDireccion2(WsDireccionesIn.getDescripcionDireccion2());
				direccion.setZip(WsDireccionesIn.getZIP());
				direccion.setEstado(WsDireccionesIn.getCodigoEstado());
				direccion.setTipoCalle(WsDireccionesIn.getTipoCalle());
				direccion.setTipoDireccion(0);


				direccion = getGestionDeDirecciones().setDireccion(direccion);

				wsDireccionOut.setCodigoDireccion(direccion.getCodigo());
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			wsDireccionOut = new WsDireccionOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionOut.setResultadoTransaccion("1");
			wsDireccionOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return wsDireccionOut;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			wsDireccionOut = new WsDireccionOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			wsDireccionOut.setResultadoTransaccion("1");
			wsDireccionOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return wsDireccionOut;

		}
		logger.debug("setDireccion():end");
		return wsDireccionOut;

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
	public WsAltaCuentaSubCuentaOutDTO AltaCuentaSubCuenta(WsAltaCuentaSubCuentaInDTO cuentaIn, int rollback)
	throws GeneralException{	
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("crearCliente():start");  		
		ArrayList errores = new ArrayList();
		WsAltaCuentaSubCuentaOutDTO cuentaSubCuentaOut = new WsAltaCuentaSubCuentaOutDTO(); 
		try{

			errores = valida.ValidarAltaCuentaSubCuentaInDTO(cuentaIn);

			if (errores.toArray().length > 0 ) {
				cuentaSubCuentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				cuentaSubCuentaOut.setResultadoTransaccion("1");
			}else{


				CuentaComDTO cuentaCom = new CuentaComDTO();
				DireccionNegocioDTO DireccionCta = new DireccionNegocioDTO();

				DireccionCta.setCodigo(cuentaIn.getCodigoDireccion());
				cuentaCom.setCodigoCuenta("0");	
				cuentaCom.setDescripcionCuenta(cuentaIn.getDescripcionCuenta());
				cuentaCom.setTipoCuenta(cuentaIn.getTipoDeCuenta());
				cuentaCom.setResponsable(cuentaIn.getNombreResponsable());
				cuentaCom.setNumeroIdentificacion(cuentaIn.getNumeroIdentificacion());
				cuentaCom.setCodigoTipIdentif(cuentaIn.getTipoDeIdentificacion());
				cuentaCom.setCodigoCategTributaria(cuentaIn.getCategoriaTributaria());
				cuentaCom.setTipoComisionista(cuentaIn.getCodigoComisionista1raVenta());
				cuentaCom.setCodigoCategoria(cuentaIn.getCodigoCategoria());

				DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

				try			        
				{ 
					if (! cuentaIn.getFechaNacimiento().equals("") ){        
						Date today = df.parse(cuentaIn.getFechaNacimiento());  
						cuentaCom.setFechaNacimiento( Formatting.dateTime(today, "dd/MM/yyyy"));
					}else{
						cuentaCom.setFechaNacimiento("");
					}					            										       
				} catch (ParseException e){ 					            
					throw new GeneralException("234098",3,"Error al procesar fecha de Nacimiento");					        
				}

				cuentaCom.setClaseCuenta(cuentaIn.getCodigoClasificacion());
				cuentaCom.setTelefonoContacto(cuentaIn.getTelefonoContacto());
				cuentaCom.setDireccion(DireccionCta);

				cuentaCom = getGestionDeCliente().AltaCuentaSubCuenta(cuentaCom);

				cuentaSubCuentaOut.setCodigoCuenta(cuentaCom.getCodigoCuenta());
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			RetornoDTO error = new RetornoDTO();
			cuentaSubCuentaOut = new WsAltaCuentaSubCuentaOutDTO();

			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			cuentaSubCuentaOut.setResultadoTransaccion("1");
			cuentaSubCuentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return cuentaSubCuentaOut;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			RetornoDTO error = new RetornoDTO();
			cuentaSubCuentaOut = new WsAltaCuentaSubCuentaOutDTO();

			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			cuentaSubCuentaOut.setResultadoTransaccion("1");
			cuentaSubCuentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return cuentaSubCuentaOut;
		}
		logger.debug("crearCliente():end");
		return cuentaSubCuentaOut;

	}




	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsAltaClienteOutDTO AltaCliente(WsCuentaInNDTO cuenta, int rollback) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("AltaCliente():start");  	
		WsAltaClienteOutDTO altaClienteOut = new  WsAltaClienteOutDTO();
		ArrayList errores = new ArrayList();
		try{

			errores = valida.ValidarAltaCliente(cuenta);

			ValidacionesAltaLinea.ValidaUsuarioSCL(cuenta.getNomUsuarioOra());

			if (errores.toArray().length > 0 ) {
				altaClienteOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				altaClienteOut.setResultadoTransaccion("1");

				context.setRollbackOnly();

			}else{

				CuentaComDTO  cuentaCom   = new CuentaComDTO();
				ClienteComDTO clienteCom  = new ClienteComDTO();

				cuentaCom.setCodigoCuenta(cuenta.getCodigoCuenta());
				if (cuenta.getClienteDTO() != null ) {

					if (cuenta.getClienteDTO().getCodigoPais().length() > 0){
						clienteCom.setCodigoPais(cuenta.getClienteDTO().getCodigoPais());
					}else{
						clienteCom.setCodigoPais(config.getString("COD_PAIS"));
					}

					clienteCom.setCategoriaTributaria(config.getString("CAT_TRIB_DEFAULT"));
					clienteCom.setNumeroTelefono1(cuenta.getClienteDTO().getTelefonoContac1());
					clienteCom.setNumeroTelefono2(cuenta.getClienteDTO().getTelefonoContac2());
					clienteCom.setIndicativoFacturable(1);
					clienteCom.setCodigoCategImpos(cuenta.getClienteDTO().getCodigoCategImpos());


					DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd"); 

					try			        
					{ 
						if (! cuenta.getClienteDTO().getFechaNacimiento().equals("") ){        
							Date today = df2.parse(cuenta.getClienteDTO().getFechaNacimiento());  
							clienteCom.setFechaNacimiento( Formatting.dateTime(today, "dd/MM/yyyy"));
						}else{
							clienteCom.setFechaNacimiento("");
						}					            										       
					} catch (ParseException e){ 					            
						throw new GeneralException("234098",3,"Error al procesar fecha de vencimiento de Nacimiento");					        
					}






					clienteCom.setIndicadorEstadoCivil(cuenta.getClienteDTO().getIndicadorEstadoCivil());
					clienteCom.setIndicadorSexo(cuenta.getClienteDTO().getIndicadorSexo());
					clienteCom.setNumeroFax(cuenta.getClienteDTO().getNumeroFax());
					clienteCom.setNumeroIntGrupoFam(cuenta.getClienteDTO().getNumeroIntGrupoFam());
					clienteCom.setCodigoTipIdent2(cuenta.getClienteDTO().getCodigoTipIdent2());
					clienteCom.setNumIdent2(cuenta.getClienteDTO().getNumIdent2());
					clienteCom.setCodigoTipoIdentificacionTributaria(cuenta.getClienteDTO().getCodigoTipoIdent());
					clienteCom.setNumeroIdentificacionTributaria(cuenta.getClienteDTO().getNumeroIdent());

					clienteCom.setCodigoProducto(1);
					clienteCom.setCodigoCliente("0");	

					// -------------- Apoderado  ---------------------/// 
					clienteCom.setCodigoTipoIdentificacionApoderado(cuenta.getClienteDTO().getApoderado().getCodigoTipident());
					clienteCom.setNumeroIdentificacionApoderado(cuenta.getClienteDTO().getApoderado().getNumeroIdent());
					clienteCom.setNombreApoderado(cuenta.getClienteDTO().getApoderado().getNomApoderado());
					// -------------- Apoderado  ---------------------///		

					//-------------- RepresentanteLegal  ---------------------///
					RepresentanteLegalComDTO representante = new RepresentanteLegalComDTO();
					ArrayList lista = new ArrayList();		
					representante.setCodigoTipoIdentificacion(cuenta.getClienteDTO().getResponsable().getCodigoTipident());
					representante.setNombre(cuenta.getClienteDTO().getResponsable().getNombreResponsable());
					representante.setNumeroOrdenRepresentanteLegal(1);
					representante.setNumeroTipoIdentificacion(cuenta.getClienteDTO().getResponsable().getNumeroIdent());
					lista.add(representante);		
					clienteCom.setRepresentanteLegalComDTO((RepresentanteLegalComDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), RepresentanteLegalComDTO.class));
					//-------------- RepresentanteLegal  ---------------------///				

					// -------------- Informacion de Cliente ----------------------------------//
					clienteCom.setNombreCliente(cuenta.getClienteDTO().getNombreCliente());
					clienteCom.setNombreApellido1(cuenta.getClienteDTO().getNombreApeclien1());
					clienteCom.setNombreApellido2(cuenta.getClienteDTO().getNombreApeclien2());
					clienteCom.setCodigoCicloFacturacion(String.valueOf(cuenta.getClienteDTO().getCodigoCiclo()));
					clienteCom.setDireccionEMail(cuenta.getClienteDTO().getNombreEmail());
					clienteCom.setCodigoOficina(cuenta.getClienteDTO().getCodigoOficina());
					clienteCom.setCodigo123(config.getString("123"));
					clienteCom.setCodigoABC(config.getString("ABC"));			
					clienteCom.setCodigoIdioma(config.getString("COD_IDIOMA_DEFAULT"));

					clienteCom.setIndicadorDebito(cuenta.getClienteDTO().getPagoAtumaticoManual());
					clienteCom.setCodigoSistemaPago(cuenta.getClienteDTO().getCodSistemaPago());					
					clienteCom.setCodigoUso(cuenta.getClienteDTO().getCodigoUso());
					clienteCom.setCodigoTipoIdentificacion(cuenta.getClienteDTO().getCodigoTipoIdent());
					clienteCom.setNumeroIdentificacion(cuenta.getClienteDTO().getNumeroIdent());

					clienteCom.setCodigoCategoria(cuenta.getClienteDTO().getCodigoCategoria());					

					if( clienteCom.getCodigoUso().equals("3")){
						clienteCom.setIndicadorAlta("M");


						if(!(cuenta.getClienteDTO().getCodigoCiclo() == 25)){
							logger.debug("12250 - Error el ciclo prepago debe ser 25");
							throw new GeneralException("12250",0,"Error el ciclo prepago debe ser 25");
						}			

					}else{
						clienteCom.setIndicadorAlta("V");


						if((cuenta.getClienteDTO().getCodigoCiclo() == 25)){
							logger.debug("12251 - Error el ciclo debe ser distintos a prepago 25");
							throw new GeneralException("12251",0,"Error el ciclo debe ser distintos a prepago 25");
						}					
					}

					ModalidadCancelacionComDTO modalidadCancelacionCom = new ModalidadCancelacionComDTO(); 
					modalidadCancelacionCom.setCodigo(cuenta.getClienteDTO().getPagoAtumaticoManual());
					clienteCom.setModalidadCancelacionComDTO(modalidadCancelacionCom);				
					// -------------- Informacion de Cliente ----------------------------------//									

					//-------------- Antecedentes Bancarios---------------------///

					if (!cuenta.getClienteDTO().getBanco().getNumeroCtacorr().equals("")){
						clienteCom.setCodigoBanco(cuenta.getClienteDTO().getBanco().getCodBanco());
						clienteCom.setCodigoSucursal(cuenta.getClienteDTO().getBanco().getSucursal().getCodigoSucursal());				
						clienteCom.setIndicadorTipoCuenta(  cuenta.getClienteDTO().getBanco().getIndicadorTipcuenta());	
						clienteCom.setNumeroCuentaCorriente(cuenta.getClienteDTO().getBanco().getNumeroCtacorr());						
					}


					if (!cuenta.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta().equals("")){					
						clienteCom.setCodigoTipoTarjeta(  cuenta.getClienteDTO().getBanco().getTarjeta().getTipoTarjeta());
						clienteCom.setNumeroTarjeta(  cuenta.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta());
						clienteCom.setCodigoBancoTarjeta(  cuenta.getClienteDTO().getBanco().getCodBanco());

						DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

						try			        
						{ 
							if (! cuenta.getClienteDTO().getBanco().getTarjeta().getFechaDeVencimiento().equals("") ){        
								Date today = df.parse(cuenta.getClienteDTO().getBanco().getTarjeta().getFechaDeVencimiento());  
								clienteCom.setFechaVencimientoTarjeta( Formatting.dateTime(today, "dd/MM/yyyy"));
							}else{
								clienteCom.setFechaVencimientoTarjeta("");
							}					            										       
						} catch (ParseException e){ 					            
							throw new GeneralException("234097",3,"Error al procesar fecha de vencimiento de Tarjeta de Credito");					        
						}
					}





					//-------------- Antecedentes Bancarios---------------------///				

					clienteCom.setNombreUsuarOra(cuenta.getNomUsuarioOra());

					clienteCom.setTipoCliente("I");
					clienteCom.setCodigoCategoriaEmpresa("I");

					if (clienteCom.getCodigoTipoIdentificacion().equals("01")){
						clienteCom.setIndicadirTipPersona("J");
					}else{
						clienteCom.setIndicadirTipPersona("F");
					}

					logger.debug("Antes de plantarifario");	
					if (cuenta.getClienteDTO().getCodigoPlanTarifario().length()>0){
						logger.debug("Plan distinto de vacio");
						PlanTarifarioDTO plantarifario = new PlanTarifarioDTO();
						plantarifario.setCodigoPlanTarifario(cuenta.getClienteDTO().getCodigoPlanTarifario());
						plantarifario.setCodigoProducto("1");
						plantarifario.setCodigoTecnologia("GSM");

						getGestionDeCliente().getPlanTarifarioClienteEMP(plantarifario);

						clienteCom.setTipoPlanTarifario("E");
						clienteCom.setCodigoPlanTarifario(cuenta.getClienteDTO().getCodigoPlanTarifario());

						if (cuenta.getClienteDTO().getCodigoUso().equals("3")){
							clienteCom.setCodigoTipoPlan("1");
						}else if (cuenta.getClienteDTO().getCodigoUso().equals("2")){
							clienteCom.setCodigoTipoPlan("2");
						}else if (cuenta.getClienteDTO().getCodigoUso().equals("10")){
							clienteCom.setCodigoTipoPlan("3");
						}else{
							throw new GeneralException("1245693",1,"Error de uso informado ["+cuenta.getClienteDTO().getCodigoUso()+"] - debe ser 2,3 o 10");
						}


						clienteCom.setTipoCliente("E");
						clienteCom.setCodigoCategoriaEmpresa("E");					
						clienteCom.setDescripcionEmpresa(cuenta.getClienteDTO().getNombreCliente());

					}else{
						logger.debug("Definicion de uso de entrada");						
						if (cuenta.getClienteDTO().getCodigoUso().equals("3")){
							clienteCom.setCodigoTipoPlan("1");
						}else{
							clienteCom.setCodigoTipoPlan("2");
						}

					}


				}

				/* Se Agregan direccion de cliente */

				DireccionNegocioDTO DireccionCorr = new DireccionNegocioDTO();
				DireccionNegocioDTO DireccionFact = new DireccionNegocioDTO();
				DireccionNegocioDTO DireccionPers = new DireccionNegocioDTO();

				DireccionFact.setCodigo(cuenta.getClienteDTO().getCodDireccionFacturacion());
				DireccionFact.setTipoDireccion(1);
				DireccionPers.setCodigo(cuenta.getClienteDTO().getCodDireccionPersonal());
				DireccionPers.setTipoDireccion(2);
				DireccionCorr.setCodigo(cuenta.getClienteDTO().getCodDireccionCorrespondencia());
				DireccionCorr.setTipoDireccion(3);

				ArrayList list = new ArrayList();

				list.add(DireccionCorr);
				list.add(DireccionFact);
				list.add(DireccionPers);

				DireccionNegocioDTO[] dirclie =(DireccionNegocioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), DireccionNegocioDTO.class);			
				clienteCom.setDirecciones(dirclie);

				//INICIO CSR-11002
				clienteCom.setCodCrediticia(cuenta.getClienteDTO().getCodCrediticia());
				//FIN CSR-11002
				
				/* Fin Direcciones de cliente */

				cuentaCom.setClienteComDTO(clienteCom);			

				cuentaCom = getGestionDeCliente().AltaCliente(cuentaCom);


				altaClienteOut.setCodigoCliente(cuentaCom.getClienteComDTO().getCodigoCliente());

				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		} catch (GeneralException e) {
			RetornoDTO error = new RetornoDTO();
			altaClienteOut = new WsAltaClienteOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			altaClienteOut.setResultadoTransaccion("1");
			altaClienteOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));		
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			return altaClienteOut;

		} catch (Exception e) {
			RetornoDTO error = new RetornoDTO();
			altaClienteOut = new WsAltaClienteOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			altaClienteOut.setResultadoTransaccion("1");
			altaClienteOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			return altaClienteOut;
		}

		logger.debug("crearCliente():end");
		return altaClienteOut; 
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadSerieDTO cantidadSerieDTO) throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getCantidadStockSerie():start");  
		CantidadStockSerieDTO cantidadStockSerieDTO = new CantidadStockSerieDTO();
		try{
			cantidadStockSerieDTO.setCodBodega(cantidadSerieDTO.getCodBodega());
			cantidadStockSerieDTO.setCodArticulo(cantidadSerieDTO.getCodArticulo());
			cantidadStockSerieDTO.setCodUso(cantidadSerieDTO.getCodUso());

			cantidadStockSerieDTO = getGestionDeCliente().getCantidadStockSerie(cantidadStockSerieDTO);

			logger.debug("cantidad stock: " + cantidadStockSerieDTO.getCantidadStock());
			cantidadStockSerieDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			cantidadStockSerieDTO = new CantidadStockSerieDTO();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			cantidadStockSerieDTO.setCodBodega(cantidadSerieDTO.getCodBodega());
			cantidadStockSerieDTO.setCodArticulo(cantidadSerieDTO.getCodArticulo());
			cantidadStockSerieDTO.setCodUso(cantidadSerieDTO.getCodUso());
			cantidadStockSerieDTO.setCodError(e.getCodigo());
			cantidadStockSerieDTO.setDesEvento(e.getDescripcionEvento());
			cantidadStockSerieDTO.setResultadoTransaccion("1");			
			return cantidadStockSerieDTO; 

		} catch (Exception e) {

			cantidadStockSerieDTO = new CantidadStockSerieDTO();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			cantidadStockSerieDTO.setCodBodega(cantidadSerieDTO.getCodBodega());
			cantidadStockSerieDTO.setCodArticulo(cantidadSerieDTO.getCodArticulo());
			cantidadStockSerieDTO.setCodUso(cantidadSerieDTO.getCodUso());
			cantidadStockSerieDTO.setCodError("1");
			cantidadStockSerieDTO.setDesEvento("No fue posible rescatar el stock de serie");
			cantidadStockSerieDTO.setResultadoTransaccion("1");
			return cantidadStockSerieDTO; 
		}
		logger.debug("getCantidadStockSerie():end");
		return cantidadStockSerieDTO; 
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsFacturacionVentaOutDTO ProcesoDeFacturacion(WsFacturacionVentaInDTO WsFacturacionVentaIn, CargosDescuentosManualesDTO[] carDesManuales,int rollback) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("++++++++++++++++++++++++++++++++++ Start : ProcesoDeFacturacion ++++++++++++++++++++++++++++++++++++++++++++"); 
		logger.debug("context ["+context.getRollbackOnly() +"]");
		RegistroVentaDTO RegistoVenta = new RegistroVentaDTO();
		AbonadoDTO[] listAbonadosFac;
		ParametrosObtencionCargosDTO ParametrosObtencionCargos = new ParametrosObtencionCargosDTO();;
		ResultadoRegCargosDTO resultadoRegCargosDTO = new ResultadoRegCargosDTO();
		ArrayList errores = new ArrayList();	
		WsFacturacionVentaOutDTO facturacionVentaOutDTO = new WsFacturacionVentaOutDTO(); 
		String setTipProceso = "1";
		int situacionVenta = 3;

		try{
			//INI-01 (AL) - Comentado - Portabilidad
			//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
			//EstadoAsinc.setSpnPortId(WsFacturacionVentaIn.getIdentificadorTransaccion());
			//EstadoAsinc.setCodEstado("10");
			//EstadoAsinc.setTipProceso(setTipProceso);
			//EstadoAsinc.setNumProceso(WsFacturacionVentaIn.getNumVenta());
			//grabaEstadoAsinc(EstadoAsinc);


			ValidacionesAltaLinea.ValidaUsuarioSCL(WsFacturacionVentaIn.getNomUsuario());

			GaVentasDTO venta = new GaVentasDTO();
			venta.setNumVenta(Long.valueOf(WsFacturacionVentaIn.getNumVenta()));
			venta = getGestionDeCliente().getVenta(venta);


			if (!venta.getIndEstVenta().equals("IV")){
				logger.debug("Error 12479 - Error: Solo es posible ejecutar el servicio despues del alta de linea ["+venta.getNumVenta()+"]");
				throw new GeneralException("12479",0,"Error: Solo es posible ejecutar el servicio despues del alta de linea");
			}

			errores = valida.ValidarProcesoDeFacturacion(WsFacturacionVentaIn);

			logger.debug("Despues de val");

			if (errores.toArray().length > 0 ) {
				facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				facturacionVentaOutDTO.setResultadoTransaccion("1");
				
			}else{
				recuperaVentaFacturacion(WsFacturacionVentaIn);


				logger.debug("Antes listAbonadosFac");	
				RegistoVenta.setNumeroVenta(new Long(WsFacturacionVentaIn.getNumVenta()).longValue());		
				listAbonadosFac = getGestionDeCliente().getListaAbonadosVenta(RegistoVenta);
				logger.debug("Despues listAbonadosFac");


				for (int cont = 0 ; cont < listAbonadosFac.length ; cont++){										
					if (WsFacturacionVentaIn.getFacturacionLinea()[cont].getNumCelular() != listAbonadosFac[cont].getNumCelular()){
						throw new GeneralException("1903452",0,"Error en linea informada Celular Informado ["+WsFacturacionVentaIn.getFacturacionLinea()[cont].getNumCelular()+"] celular registrado["+listAbonadosFac[cont].getNumCelular()+"]");
					}
				}

				logger.debug("getCodCliente   aboando 0 ["+listAbonadosFac[0].getCodCliente()+"]");
				logger.debug("getNumVenta     aboando 0 ["+listAbonadosFac[0].getNumVenta()+"]");
				logger.debug("getCodVendedor  aboando 0 ["+listAbonadosFac[0].getCodVendedor()+"]");
				logger.debug("getCodVendealer aboando 0 ["+listAbonadosFac[0].getCodVendealer()+"]");
				logger.debug("getCodCiclo     aboando 0 ["+listAbonadosFac[0].getCodCiclo()+"]");
				logger.debug("getCodModVenta  aboando 0 ["+listAbonadosFac[0].getCodModVenta()+"]");

				VendedorDTO vendedor = new VendedorDTO();						 			
				vendedor.setCodigoVendedor(String.valueOf(listAbonadosFac[0].getCodVendedor()));
				vendedor.setCodigoVendedorDealer(listAbonadosFac[0].getCodVendealer());


				try{			
					vendedor=getVendedor(vendedor);				
				}catch (GeneralException e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					throw e;
				}catch (Exception e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					throw new GeneralException(e);
				}

				ContratoDTO contratoDTO =new ContratoDTO();
				contratoDTO.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto"))); 
				contratoDTO.setCodigoTipoContrato(listAbonadosFac[0].getCodTipContrato());
				try{
					contratoDTO=this.getListadoNumeroMesesContrato(contratoDTO);
				}catch (GeneralException e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					throw e;
				}

				ParametrosObtencionCargos.setCodigoVendedor(String.valueOf(listAbonadosFac[0].getCodVendedor()));
				ParametrosObtencionCargos.setNumeroVenta(WsFacturacionVentaIn.getNumVenta());
				ParametrosObtencionCargos.setTipoContrato(listAbonadosFac[0].getCodTipContrato());
				ParametrosObtencionCargos.setCodigoModalidadVenta(String.valueOf(listAbonadosFac[0].getCodModVenta()));											
				ParametrosObtencionCargos.setNumeroMesesContrato(contratoDTO.getNumeroMeses());
				ParametrosObtencionCargos.setIndicadorTipoVenta(vendedor.getIndicadorTipoVenta());
				ParametrosObtencionCargos.setCodigoCausalDescuento("");
				ParametrosObtencionCargos.setTipoPlanPostPago(config.getString("parametro.usoVentaPostpago"));
				ParametrosObtencionCargos.setTipoPlanHibrido(config.getString("parametro.usoVentaHibrido"));

				if (listAbonadosFac[0].getCodUso().equals("2") || listAbonadosFac[0].getCodUso().equals("10")){
					ParametrosObtencionCargos.setAplicaPrepago(false);
				}else{
					ParametrosObtencionCargos.setAplicaPrepago(true);
				}
				/*Llena Causal de descuentos */						
				ParametrosCodDescDTO[] listParametrosCodDescDTO=null;

				ArrayList list=new ArrayList();
				for(int i=0;i<WsFacturacionVentaIn.getFacturacionLinea().length;i++){
					ParametrosCodDescDTO parametrosCodDescDTO=new ParametrosCodDescDTO();
					parametrosCodDescDTO.setCodigoCausaDescuento("");
					parametrosCodDescDTO.setNumAbonado(String.valueOf(listAbonadosFac[i].getNumAbonado()));															
					list.add(parametrosCodDescDTO);
				}
				listParametrosCodDescDTO=(ParametrosCodDescDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), ParametrosCodDescDTO.class);						
				/*Fin Causal de descuentos */

				/* Recuepra Cargos */
				ObtencionCargosDTO obtencionCargos=null;
				UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
				logger.debug("Inicio: getObtencionCargos:start");

				obtencionCargos = getFrmkCargosFacade().getObtencionCargos(ParametrosObtencionCargos,listParametrosCodDescDTO);

				obtencionCargos = getObtencionCargos(obtencionCargos,carDesManuales);

				UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
				/* Recuepra Cargos */																										
				
				logger.debug("++++++++++++++++++++++DESPUES DE OBTENCION DE CARGOS INICIO +++++++++++++++++++++++++++++++++++++");
				for (int i= 0 ; i<obtencionCargos.getCargos().length;i++ ){
					for (int k= 0 ; k<obtencionCargos.getCargos()[i].getDescuento().length;k++ ){
						//obtencionCargos.getCargos()[i].getDescuento()[k].getDescripcionConcepto();
						logger.debug("NUEVO obtencionCargos.getCargos()["+i+"].getDescuento()["+k+"].getDescripcionConcepto() ["+obtencionCargos.getCargos()[i].getDescuento()[k].getDescripcionConcepto() +"]");
						logger.debug("NUEVO obtencionCargos.getCargos()["+i+"].getDescuento()["+k+"].getMonto() ["+obtencionCargos.getCargos()[i].getDescuento()[k].getMonto() +"]");
						logger.debug("NUEVO obtencionCargos.getCargos()["+i+"].getDescuento()["+k+"].getTipoAplicacion() ["+obtencionCargos.getCargos()[i].getDescuento()[k].getTipoAplicacion() +"]");
					}
				}
				logger.debug("++++++++++++++++++++++DESPUES DE OBTENCION DE CARGOS FIN +++++++++++++++++++++++++++++++++++++");
				
				if (obtencionCargos.getCargos()!=null){
					//TODO : Se procede a llenar la DTO de Registro de Cargos.
					ParametrosRegistrarCargosDTO parametrosRegistrarCargosDTO=this.llenarDTORegistrarCargos(obtencionCargos.getCargos(),listAbonadosFac, WsFacturacionVentaIn);
					if (parametrosRegistrarCargosDTO.getCargos().length==0){
						parametrosRegistrarCargosDTO.setFacturaACiclo(true);
					}						
					parametrosRegistrarCargosDTO.setUsuario(WsFacturacionVentaIn.getNomUsuario());
					
					//Cambio
					logger.debug("++++++++++++++++++++++DESPUES DE REGISTRAR DE CARGOS INICIO +++++++++++++++++++++++++++++++++++++");
					
					if(parametrosRegistrarCargosDTO.getCargos() != null){
						logger.debug("++++ parametrosRegistrarCargosDTO.getCargos().length: " + parametrosRegistrarCargosDTO.getCargos().length);
					}
					
					for (int k = 0; k<parametrosRegistrarCargosDTO.getCargos().length; k++){
						if (parametrosRegistrarCargosDTO.getCargos()[k].getDescuento() != null){
							logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getPrecio() ["+parametrosRegistrarCargosDTO.getCargos()[k].getPrecio().getMonto() +"]");  
							for(int i =0 ; i<parametrosRegistrarCargosDTO.getCargos()[k].getDescuento().length; i++){
								if (parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i] != null && parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getMonto() > 0){
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getTipoAplicacion() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getTipoAplicacion()+"]");
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getMonto() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getMonto()+"]");
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getDescripcionConcepto() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getDescripcionConcepto()+"]");
								}
							}
						}
					}
					logger.debug("++++++++++++++++++++++DESPUES DE REGISTRAR DE CARGOS FIN +++++++++++++++++++++++++++++++++++++");
					//hasta aca
					
					if (obtencionCargos!=null && obtencionCargos.getCargos()!=null && obtencionCargos.getCargos().length>0){
						obtencionCargos.setCargos(this.calcularDescuentos(obtencionCargos.getCargos(), WsFacturacionVentaIn.getFacturacionLinea() , listAbonadosFac[0].getNumVenta() , String.valueOf(listAbonadosFac[0].getCodVendedor())  ));
					}

					RegistroVentaDTO registroVentaDTO= new RegistroVentaDTO();
					registroVentaDTO.setCodigoSecuencia(config.getString("codigo.secuencia.famensajes"));
					registroVentaDTO=this.getSecuencia(registroVentaDTO);

					for (int k = 0; k<parametrosRegistrarCargosDTO.getCargos().length; k++){
						if (parametrosRegistrarCargosDTO.getCargos()[k].getDescuento() != null){
							logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getPrecio() ["+parametrosRegistrarCargosDTO.getCargos()[k].getPrecio().getMonto() +"]");  
							for(int i =0 ; i<parametrosRegistrarCargosDTO.getCargos()[k].getDescuento().length; i++){
								if (parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i] != null && parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getMonto() > 0){
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getTipoAplicacion() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getTipoAplicacion()+"]");
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getMonto() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getMonto()+"]");
									logger.debug("parametrosRegistrarCargosDTO.getCargos()["+k+"].getDescuento()["+i+"].getDescripcionConcepto() ["+parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getDescripcionConcepto()+"]");
								}
							}
						}
					}

					resultadoRegCargosDTO=this.registrarCargos(parametrosRegistrarCargosDTO);
					//TODO: se Actualiza la ga_equipaboser
					//TODO: se Actualiza en la GA_VENTAS
					GaVentasDTO gaVentasDTO= new GaVentasDTO();

					long numeroventa= new Long(WsFacturacionVentaIn.getNumVenta()).longValue();

					numeroventa=numeroventa==0?listAbonadosFac[0].getNumVenta():numeroventa;
					gaVentasDTO.setNumVenta(new Long((numeroventa)));
					gaVentasDTO = getGestionDeCliente().getVenta(gaVentasDTO);

					gaVentasDTO.setImpVenta(Float.valueOf(String.valueOf(resultadoRegCargosDTO.getTotalCargos()+resultadoRegCargosDTO.getTotalImpuestos()+resultadoRegCargosDTO.getTotalDescuentos())));
					gaVentasDTO.setTipValor("1");


					logger.debug("++++++++++++++++++++++++++++++++++ Antes Estado VF a la venta ++++++++++++++++++++++++++++++++++++++++++++");
					gaVentasDTO.setIndEstVenta("VF");
					logger.debug("gaVentasDTO.getIndEstVenta() ["+gaVentasDTO.getIndEstVenta()+"]");
					logger.debug("++++++++++++++++++++++++++++++++++ Despues Estado VF a la venta ++++++++++++++++++++++++++++++++++++++++++++");
					if (ModalidadRegaloFac.equals("5")){
						gaVentasDTO.setCodModVenta(new Long(ModalidadRegaloFac));
					}															
					logger.debug("++++++++++++++++++++++++++++++++++ Antes getUpdateGaVentaEscB ++++++++++++++++++++++++++++++++++++++++++++");
					logger.debug("gaVentasDTO ["+gaVentasDTO.getNumVenta()+"]");
					getGestionDeCliente().getUpdateGaVentaEscB(gaVentasDTO);
					logger.debug("++++++++++++++++++++++++++++++++++ Despues getUpdateGaVentaEscB ++++++++++++++++++++++++++++++++++++++++++++");

					logger.debug("++++++++++++++++++++++++++++++++++ Antes getVenta ++++++++++++++++++++++++++++++++++++++++++++");
					logger.debug("gaVentasDTO ["+gaVentasDTO.getNumVenta()+"]");
					gaVentasDTO = getGestionDeCliente().getVenta(gaVentasDTO);
					logger.debug("gaVentasDTO.getIndEstVenta() ["+gaVentasDTO.getIndEstVenta()+"]");
					logger.debug("++++++++++++++++++++++++++++++++++ Despues getVenta ++++++++++++++++++++++++++++++++++++++++++++");

					String numProceso=resultadoRegCargosDTO.getNumeroProceso();
					numProceso=numProceso==null||"".equals(numProceso)?"0":numProceso;

					String numCorrMensaje=String.valueOf(registroVentaDTO.getNumeroTransaccionVenta());

					FaMensProcesoDTO faMensProcesoDTO=new FaMensProcesoDTO();
					faMensProcesoDTO.setNumProceso(Long.parseLong(numProceso));
					faMensProcesoDTO.setCodOrigen("FA");
					faMensProcesoDTO.setIndFacturado("I");
					faMensProcesoDTO.setFecIngreso(new Timestamp(System.currentTimeMillis()));
					faMensProcesoDTO.setDescMensaje(WsFacturacionVentaIn.getObsFactVenta());
					faMensProcesoDTO.setNumLineas(1);
					faMensProcesoDTO.setNomUsuario(WsFacturacionVentaIn.getNomUsuario());
					faMensProcesoDTO.setCodBloque(1);
					faMensProcesoDTO.setCodFormulario(1);
					faMensProcesoDTO.setCorrMensaje(Long.parseLong(numCorrMensaje));

					RetornoDTO retValue = getGestionDeCliente().setObservacionFactura(faMensProcesoDTO);

					facturacionVentaOutDTO.setProceso(numProceso);
				}
			}

			logger.debug("++++++++++++++++++++++++++++++++++ udpInterfazDeFacturación ++++++++++++++++++++++++++++++++++++++++++++");
			GaVentasDTO gaVentas = new GaVentasDTO();
			gaVentas.setNumVenta(Long.valueOf(WsFacturacionVentaIn.getNumVenta()));
			getGestionDeCliente().udpInterfazDeFacturación(gaVentas);
			logger.debug("++++++++++++++++++++++++++++++++++ udpInterfazDeFacturación ++++++++++++++++++++++++++++++++++++++++++++");

			//INI-01 (AL) - Comentado - Portabilidad
			//EstadoAsinc.setCodEstado("11");
			//EstadoAsinc.setTipProceso(setTipProceso);
			//EstadoAsinc.setNumProceso(WsFacturacionVentaIn.getNumVenta());
			//grabaEstadoAsinc(EstadoAsinc);

			logger.debug("Rollback: ["+rollback+"]");
			if (rollback == 0){
				logger.debug("rollback == 0 Rollback ["+rollback+"]");
				context.setRollbackOnly();
				logger.debug("context [TRUE]");
			}


			GaVentasDTO Ventas = new GaVentasDTO(); 
			Ventas.setNumVenta(Long.valueOf(WsFacturacionVentaIn.getNumVenta()));
			logger.debug("gaVentasDTO ["+Ventas.getNumVenta()+"]");
			logger.debug("++++++++++++++++++++++++++++++++++ Antes getVenta ++++++++++++++++++++++++++++++++++++++++++++");
			Ventas = getGestionDeCliente().getVenta(Ventas);
			logger.debug("gaVentasDTO.getIndEstVenta() ["+Ventas.getIndEstVenta()+"]");
			logger.debug("++++++++++++++++++++++++++++++++++ Despues getVenta ++++++++++++++++++++++++++++++++++++++++++++");			

		} catch (GeneralException e) {

			logger.debug("context ["+context.getRollbackOnly() +"]");
			logger.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");

			RetornoDTO error = new RetornoDTO();	
			facturacionVentaOutDTO = new WsFacturacionVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);

			error = new RetornoDTO();
			error.setCodError("1036");
			error.setMensajseError("Error al registrar cargos para facturar");
			errores.add(error);
			facturacionVentaOutDTO.setResultadoTransaccion("1");
			facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(WsFacturacionVentaIn.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("12");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(WsFacturacionVentaIn.getNumVenta());
				//grabaEstadoAsinc(EstadoAsinc);
			//}catch(GeneralException g){
				//logger.debug("error al registrar auditoria");				
			//}catch(Exception g){
				//logger.debug("error al registrar auditoria");				
			//}
			context.setRollbackOnly();
			return facturacionVentaOutDTO; 

		} catch (Exception e) {
			RetornoDTO error = new RetornoDTO();	
			facturacionVentaOutDTO = new WsFacturacionVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);

			error = new RetornoDTO();
			error.setCodError("1036");
			error.setMensajseError("Error al registrar cargos para facturar");
			errores.add(error);

			facturacionVentaOutDTO.setResultadoTransaccion("1");
			facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(WsFacturacionVentaIn.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("12");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(WsFacturacionVentaIn.getNumVenta());
				//grabaEstadoAsinc(EstadoAsinc);
			//}catch(GeneralException g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch(Exception g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}
			context.setRollbackOnly();
			return facturacionVentaOutDTO; 
		}

		logger.debug("++++++++++++++++++++++++++++++++++ End : ProcesoDeFacturacion ++++++++++++++++++++++++++++++++++++++++++++");
		return facturacionVentaOutDTO; 
	}	


	/**
	 * @param CargosDTO
	 * @description setea los cambios y realiza operaciones que corresponden al calculo de los descuentos
	 * @return CargosDTO 
	 */

	private CargosDTO[] calcularDescuentos(CargosDTO[] cargosDTO,WsFacturacionLineaDTO[] parametrosLineasFactVentaDTO, long num_venta, String Vendedor )throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		try{
			int valorSimcard= config.getInt("regla.simcard.atributo.simcard.valor");
			int valorTerminal =	config.getInt("regla.terminal.atributo.terminal.valor");
			for (int j=0;j<parametrosLineasFactVentaDTO.length;j++){
				ModalidadRegaloFac = "0";
				//long codArticuloLinea=0;
				long numCelularLinea=0;
				String numCelularCargos=null;
				String tipoDescuento=null;
				String tipoDescuentoManual=null;
				//String codArticuloCargo=null;
				float mntoDto=0;
				float mntoDtoAcumulado=0;
				float mntoCargoAcumulado=0;
				float mntoDscSimcard=0;
				float mntoDscTerminal=0;
				float mntoDscPorCargo=0;
				Date fechaa = new Date();
				DescuentoDTO descuento[] = null;
				ArrayList listdescu = new ArrayList();

				//codArticuloLinea=parametrosLineasFactVentaDTO[j].getCodArticulo();
				numCelularLinea=parametrosLineasFactVentaDTO[j].getNumCelular();
				logger.debug("numCelularLinea ["+numCelularLinea+"]");
				mntoDscSimcard=parametrosLineasFactVentaDTO[j].getMntoDscSimcard();
				mntoDscSimcard=parametrosLineasFactVentaDTO[j].getMntoDscSimcard();
				logger.debug("mntoDscSimcard ["+mntoDscSimcard+"]");
				mntoDscTerminal=parametrosLineasFactVentaDTO[j].getMntoDscTerminal();
				logger.debug("mntoDscTerminal ["+mntoDscTerminal+"]");
				logger.debug("cargosDTO.length: "+cargosDTO.length);
				for (int k=0;k<cargosDTO.length;k++){
					mntoDscPorCargo = 0;
					numCelularCargos=cargosDTO[k].getAtributo().getNumTerminal();
					logger.debug("numCelularCargos ["+numCelularCargos+"]");

					mntoCargoAcumulado = mntoCargoAcumulado + cargosDTO[k].getPrecio().getMonto();
					logger.debug("mntoCargoAcumulado: "+mntoCargoAcumulado);

					logger.debug("numCelularCargos.equals(String.valueOf(numCelularLinea) ["+numCelularCargos+"] ["+numCelularLinea+"]");
					if (numCelularCargos.equals(String.valueOf(numCelularLinea))){
						logger.debug("cargosDTO[k].getDescuento()!=null ["+(cargosDTO[k].getDescuento()!=null)+"]");
						if (cargosDTO[k].getDescuento()!=null&&cargosDTO[k].getDescuento().length>0){	
							logger.debug("cargosDTO[k].getDescuento().length ["+cargosDTO[k].getDescuento().length+"]");
							CausalDescuentoDTO entrada = null;
							for (int i=0;i<cargosDTO[k].getDescuento().length;i++){
								tipoDescuento=cargosDTO[k].getDescuento()[i].getTipo();
								logger.debug("tipoDescuento ["+tipoDescuento+"]");
								tipoDescuentoManual=config.getString("tipo.descuento.manual");
								logger.debug("tipoDescuentoManual ["+tipoDescuentoManual+"]");
								tipoDescuentoManual="".equals(tipoDescuentoManual)?"0":tipoDescuentoManual;
								logger.debug("tipoDescuentoManual ["+tipoDescuentoManual+"]");

								logger.debug("if (tipoDescuento.equals(tipoDescuentoManual)){ ["+tipoDescuento+"] ["+tipoDescuentoManual+"]");
								if (tipoDescuento.equals(tipoDescuentoManual)){

									if (valorSimcard==cargosDTO[k].getAtributo().getTipoProducto()){


										logger.debug("1----cargosDTO[k].getDescuento()[i].getMonto() ["+cargosDTO[k].getDescuento()[i].getMonto()+"]");
										logger.debug("1-----mntoDscSimcard ["+mntoDscSimcard+"]");
										mntoDscPorCargo = cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscSimcard;
										logger.debug("1-----cargosDTO[k].getPrecio().getMonto() ["+cargosDTO[k].getPrecio().getMonto()+"]");

										if (mntoDscPorCargo > cargosDTO[k].getPrecio().getMonto()){
											throw new GeneralException("998023",0,"El Descuento supera el precio de la simcard Precio ["+cargosDTO[k].getPrecio().getMonto()+"] Descuento [" +(cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscSimcard) +"]" );
										}

										mntoDto=cargosDTO[k].getDescuento()[i].getMonto();
										mntoDto=mntoDto+mntoDscSimcard;

									}
									if (valorTerminal==cargosDTO[k].getAtributo().getTipoProducto()){

										logger.debug("2----cargosDTO[k].getDescuento()[i].getMonto() ["+cargosDTO[k].getDescuento()[i].getMonto()+"]");
										logger.debug("2-----mntoDscSimcard ["+mntoDscSimcard+"]");
										mntoDscPorCargo = cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscTerminal;
										logger.debug("2-----cargosDTO[k].getPrecio().getMonto() ["+cargosDTO[k].getPrecio().getMonto()+"]");

										if (mntoDscPorCargo > cargosDTO[k].getPrecio().getMonto()){
											throw new GeneralException("998024",0,"El Descuento supera el precio del Equipo Precio ["+cargosDTO[k].getPrecio().getMonto()+"] Descuento [" +(cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscTerminal) +"]" );
										}

										mntoDto=cargosDTO[k].getDescuento()[i].getMonto();
										mntoDto=mntoDto+mntoDscTerminal;																																																															
									}

									if (mntoDto >0){
										//this.insDocumentoMotivo(entrada);
									}
									cargosDTO[k].getDescuento()[i].setMonto(mntoDto);
								}
								//TODO se suman los descuentos Automaticos con el nuevo descuento manual
								if (cargosDTO[k].getDescuento()[i].getTipoAplicacion().equals("0")){
									mntoDtoAcumulado=mntoDtoAcumulado+cargosDTO[k].getDescuento()[i].getMonto();
									logger.debug("mntoDtoAcumulado ["+mntoDtoAcumulado+"]");
								}else{
									mntoDtoAcumulado=mntoDtoAcumulado+  (cargosDTO[k].getPrecio().getMonto() *   (cargosDTO[k].getDescuento()[i].getMonto()/100)  );
									logger.debug("mntoDtoAcumulado ["+mntoDtoAcumulado+"]");
								}
							}
						}else{
							descuento = new DescuentoDTO[1];
							cargosDTO[k].setDescuento(descuento);
							logger.debug("cargosDTO[k].getDescuento().length ["+cargosDTO[k].getDescuento().length+"]");
							CausalDescuentoDTO entrada = null;

							for (int i=0;i<cargosDTO[k].getDescuento().length;i++){
								if (cargosDTO[k].getDescuento()[i] != null && cargosDTO[k].getDescuento()[i].getMonto() > 0){
									tipoDescuento=cargosDTO[k].getDescuento()[i].getTipo();
									logger.debug("tipoDescuento ["+tipoDescuento+"]");
									tipoDescuentoManual=config.getString("tipo.descuento.manual");
									logger.debug("tipoDescuentoManual ["+tipoDescuentoManual+"]");
									tipoDescuentoManual="".equals(tipoDescuentoManual)?"0":tipoDescuentoManual;
									logger.debug("tipoDescuentoManual ["+tipoDescuentoManual+"]");

									logger.debug("if (tipoDescuento.equals(tipoDescuentoManual)){ ["+tipoDescuento+"] ["+tipoDescuentoManual+"]");
									if (tipoDescuento.equals(tipoDescuentoManual)){

										if (valorSimcard==cargosDTO[k].getAtributo().getTipoProducto()){
											mntoDto=cargosDTO[k].getDescuento()[i].getMonto();
											mntoDto=mntoDto+mntoDscSimcard;

											logger.debug("3----cargosDTO[k].getDescuento()[i].getMonto() ["+cargosDTO[k].getDescuento()[i].getMonto()+"]");
											logger.debug("3-----mntoDscSimcard ["+mntoDscSimcard+"]");
											mntoDscPorCargo = cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscSimcard;

											if (mntoDscPorCargo > cargosDTO[k].getPrecio().getMonto()){
												logger.debug("3-----Valor Mayor");
											}
										}
										if (valorTerminal==cargosDTO[k].getAtributo().getTipoProducto()){
											mntoDto=cargosDTO[k].getDescuento()[i].getMonto();
											mntoDto=mntoDto+mntoDscTerminal;

											logger.debug("1----cargosDTO[k].getDescuento()[i].getMonto() ["+cargosDTO[k].getDescuento()[i].getMonto()+"]");
											logger.debug("1-----mntoDscSimcard ["+mntoDscSimcard+"]");
											mntoDscPorCargo = cargosDTO[k].getDescuento()[i].getMonto() +  mntoDscSimcard;

											if (mntoDscPorCargo > cargosDTO[k].getPrecio().getMonto()){
												logger.debug("1-----Valor Mayor");
											}																																																								
										}

										if (mntoDto >0){
											this.insDocumentoMotivo(entrada);
										}
										cargosDTO[k].getDescuento()[i].setMonto(mntoDto);
										logger.debug("Monto descuento : ["+mntoDto+"]");
									}
									//TODO se suman los descuentos Automaticos con el nuevo descuento manual
									if (cargosDTO[k].getDescuento()[i].getTipoAplicacion().equals("0")){
										mntoDtoAcumulado=mntoDtoAcumulado+cargosDTO[k].getDescuento()[i].getMonto();
										logger.debug("mntoDtoAcumulado ["+mntoDtoAcumulado+"]");
									}else{
										mntoDtoAcumulado=mntoDtoAcumulado+  (cargosDTO[k].getPrecio().getMonto() *   (cargosDTO[k].getDescuento()[i].getMonto()/100)  );
										logger.debug("mntoDtoAcumulado ["+mntoDtoAcumulado+"]");
									}
								}

							}





						}
						//TODO: Se valida que el descueto total (Manual y Automático no supere el precio del concepto del cargo)
						logger.debug("if (mntoDtoAcumulado>cargosDTO[k].getPrecio().getMonto()) ["+mntoDtoAcumulado+"] ["+mntoCargoAcumulado+"]");
						/*if (mntoDtoAcumulado > mntoCargoAcumulado){*/
						DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
						simbolos.setDecimalSeparator('.');
						DecimalFormat df = null;
						double mntoDtoAcumuladoFormateado;
						double mntoCargoAcumuladoFormateado;
						df = new DecimalFormat("################.##",simbolos);
						mntoDtoAcumuladoFormateado = new Double(df.format(mntoDtoAcumulado)).doubleValue();
						mntoCargoAcumuladoFormateado = new Double(df.format(mntoCargoAcumulado)).doubleValue();
						if ( mntoDtoAcumuladoFormateado > mntoCargoAcumuladoFormateado ){	
							cargosDTO=null;
							break;
						}else if ( mntoDtoAcumuladoFormateado == mntoCargoAcumuladoFormateado ){
							ModalidadRegaloFac = "5";
						}																								
					}
				}
			}

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}	

		return cargosDTO;
	}





	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsReglaSSOutDTO getReglasCompatibilidadSS() throws GeneralException 
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getReglasCompatibilidadSS():start");  
		WsReglaSSOutDTO wsReglaSSOutDTO = new WsReglaSSOutDTO();
		try{
			wsReglaSSOutDTO.setReglaCompatibilidadSSDTOs(getGestionDeCliente().getReglasCompatibilidadSS());
			wsReglaSSOutDTO.setCodigoError(new Long(0));
			wsReglaSSOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsReglaSSOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsReglaSSOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsReglaSSOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsReglaSSOutDTO.setCodigoError(new Long(1));
			wsReglaSSOutDTO.setDescripcionError("No fue posible rescatar las reglas de compatibilidad para los servicios complementarios");
			wsReglaSSOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getReglasCompatibilidadSS():end");
		return wsReglaSSOutDTO; 
	}




	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsCategoriaImpostivaOutDTO getListCategImpositivas() throws GeneralException 
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getReglasCompatibilidadSS():start");  
		WsCategoriaImpostivaOutDTO wsCategoriaImpostivaOutDTO = new WsCategoriaImpostivaOutDTO();
		try{
			wsCategoriaImpostivaOutDTO.setClienteDTOs(getGestionDeCliente().getListCategImpositivas());
			wsCategoriaImpostivaOutDTO.setCodigoError(new Long(0));
			wsCategoriaImpostivaOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsCategoriaImpostivaOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsCategoriaImpostivaOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsCategoriaImpostivaOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsCategoriaImpostivaOutDTO.setCodigoError(new Long(1));
			wsCategoriaImpostivaOutDTO.setDescripcionError("No fue posible rescatar las categorias impositivas");
			wsCategoriaImpostivaOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getListCategImpositivas():end");
		return wsCategoriaImpostivaOutDTO; 
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsActividadesOutDTO getListActividades() throws GeneralException  
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getListActividades():start");  
		WsActividadesOutDTO wsActividadesOutDTO = new WsActividadesOutDTO();
		try{
			wsActividadesOutDTO.setDatosGeneralesDTOs(getGestionDeCliente().getListActividades());
			wsActividadesOutDTO.setCodigoError(new Long(0));
			wsActividadesOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsActividadesOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsActividadesOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsActividadesOutDTO.setResultadoTransaccion("1");		
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsActividadesOutDTO.setCodigoError(new Long(1));
			wsActividadesOutDTO.setDescripcionError("No fue posible rescatar las actividades");
			wsActividadesOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getListActividades():end");
		return wsActividadesOutDTO; 
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsOcupacionesOutDTO getListaOcupaciones() throws GeneralException  
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getListaOcupaciones():start");  
		WsOcupacionesOutDTO wsOcupacionesOutDTO = new WsOcupacionesOutDTO();
		try{
			wsOcupacionesOutDTO.setOcupacionDTOs(getGestionDeCliente().getListaOcupaciones());
			wsOcupacionesOutDTO.setCodigoError(new Long(0));
			wsOcupacionesOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsOcupacionesOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsOcupacionesOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsOcupacionesOutDTO.setResultadoTransaccion("1");

			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsOcupacionesOutDTO.setCodigoError(new Long(1));
			wsOcupacionesOutDTO.setDescripcionError("No fue posible rescatar las ocupaciones");
			wsOcupacionesOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getListaOcupaciones():end");
		return wsOcupacionesOutDTO; 
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsSucursalesBancoOutDTO getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO) throws GeneralException 
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getListaOcupaciones():start");  
		WsSucursalesBancoOutDTO wsSucursalesBancoOutDTO = new WsSucursalesBancoOutDTO();
		try{
			wsSucursalesBancoOutDTO.setSucursalBancoDTOs(getGestionDeCliente().getSucursalesBanco(sucursalBancoDTO));
			wsSucursalesBancoOutDTO.setCodigoError(new Long(0));
			wsSucursalesBancoOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsSucursalesBancoOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsSucursalesBancoOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsSucursalesBancoOutDTO.setResultadoTransaccion("1");

			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsSucursalesBancoOutDTO.setCodigoError(new Long(1));
			wsSucursalesBancoOutDTO.setDescripcionError("No fue posible rescatar las sucursales del banco");
			wsSucursalesBancoOutDTO.setResultadoTransaccion("1");

			throw new GeneralException(e);
		}
		logger.debug("getListaOcupaciones():end");
		return wsSucursalesBancoOutDTO; 
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsClasificacionCuentaOutDTO getClasificacionCuenta() throws GeneralException  
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getClasificacionCuenta():start");  
		WsClasificacionCuentaOutDTO wsClasificacionCuentaOutDTO = new WsClasificacionCuentaOutDTO();
		ClasificacionCuentaDTO[]  clasificacionCuentaDTOs = null;
		try{
			clasificacionCuentaDTOs = getGestionDeCliente().getClasificacionCuenta();
			logger.debug("codigo clase cuenta"+ clasificacionCuentaDTOs[1].getCodClasCuenta());
			logger.debug("descripcion clase cuenta"+ clasificacionCuentaDTOs[1].getDesClasCuenta());			
			wsClasificacionCuentaOutDTO.setClasificacionCuentaDTOs(clasificacionCuentaDTOs);			
			wsClasificacionCuentaOutDTO.setCodigoError(new Long(0));
			wsClasificacionCuentaOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsClasificacionCuentaOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsClasificacionCuentaOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsClasificacionCuentaOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsClasificacionCuentaOutDTO.setCodigoError(new Long(1));
			wsClasificacionCuentaOutDTO.setDescripcionError("No fue posible rescatar las clasificaciones de cuenta");
			wsClasificacionCuentaOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getClasificacionCuenta():end");
		return wsClasificacionCuentaOutDTO; 
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsHomeLineaOutDTO getHomeLinea(DireccionCentralDTO direccionCentralDTO) throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getHomeLinea():start");  
		WsHomeLineaOutDTO wsHomeLineaOutDTO = new WsHomeLineaOutDTO();
		try{
			wsHomeLineaOutDTO.setHomeLineaDTOs(getGestionDeCliente().getHomeLinea(direccionCentralDTO));
			wsHomeLineaOutDTO.setCodigoError(new Long(0));
			wsHomeLineaOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsHomeLineaOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsHomeLineaOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsHomeLineaOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsHomeLineaOutDTO.setCodigoError(new Long(1));
			wsHomeLineaOutDTO.setDescripcionError("No fue posible rescatar los Home de linea");
			wsHomeLineaOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getHomeLinea():end");
		return wsHomeLineaOutDTO; 
	}




	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback){		

		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("solicitaBajaAbonado():start"); 
		ArrayList errores = new ArrayList();	
		RetornoDTO error = new RetornoDTO();
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			ValidacionesAltaLinea.ValidaUsuarioSCL(solicitudBajaAbonadoDTO.getIdUsuario());
			errores = valida.ValidarSolicitaBajaAbonado(solicitudBajaAbonadoDTO);

			if (errores.toArray().length > 0 ) {
				solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			}else{

				solicitaBajaAbonadoOut = getGestionDeCliente().solicitaBajaAbonado(solicitudBajaAbonadoDTO);
				error.setCodError("0");
				errores.add(error);
				solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				solicitaBajaAbonadoOut.setResultadoTransaccion("0");
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		}catch (GeneralException e) {
			error = new RetornoDTO();
			errores = new ArrayList();
			//solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());			
			errores.add(error);
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");

			context.setRollbackOnly();

			return solicitaBajaAbonadoOut;

		} catch (Exception e) {
			error = new RetornoDTO();
			errores = new ArrayList();
			//solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			error.setCodError("1");
			error.setMensajseError("No fue solicitar la baja del abonado");			
			errores.add(error);
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");

			context.setRollbackOnly();

			return solicitaBajaAbonadoOut;						
		}
		logger.debug("solicitaBajaAbonado():end");
		return solicitaBajaAbonadoOut;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSEstadoCivilOutDTO getListaEstadoCivil() throws GeneralException  
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getListaEstadoCivil():start");  
		WSEstadoCivilOutDTO wsEstadoCivilOutDTO = new WSEstadoCivilOutDTO();
		try{
			wsEstadoCivilOutDTO.setEstadoCivilDTOs(getGestionDeCliente().getListaEstadoCivil());
			wsEstadoCivilOutDTO.setCodigoError(new Long(0));
			wsEstadoCivilOutDTO.setResultadoTransaccion("0");
		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsEstadoCivilOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsEstadoCivilOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsEstadoCivilOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsEstadoCivilOutDTO.setCodigoError(new Long(1));
			wsEstadoCivilOutDTO.setDescripcionError("No fue posible rescatar Estados Civiles");
			wsEstadoCivilOutDTO.setResultadoTransaccion("1");		
			throw new GeneralException(e);
		}
		logger.debug("getListaEstadoCivil():end");
		return wsEstadoCivilOutDTO; 
	}




	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsEstadoOutDTO getListaEstados() throws GeneralException  
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getListaEstados():start");  
		WsEstadoOutDTO wsEstadoOutDTO = new WsEstadoOutDTO();
		try{
			wsEstadoOutDTO.setEstadoDTOs(getGestionDeCliente().getListaEstados());
			wsEstadoOutDTO.setCodigoError(new Long(0));
			wsEstadoOutDTO.setResultadoTransaccion("0");

			logger.debug("variable retorno estado: "+ wsEstadoOutDTO.getEstadoDTOs()[1].getCodigoEstado());
			logger.debug("variable retorno descripcion estado: "+ wsEstadoOutDTO.getEstadoDTOs()[1].getDescripcionEstado());


		}catch (GeneralException e) {

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			wsEstadoOutDTO.setCodigoError(new Long(e.getCodigo()));
			wsEstadoOutDTO.setDescripcionError(e.getDescripcionEvento());
			wsEstadoOutDTO.setResultadoTransaccion("1");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		

			wsEstadoOutDTO.setCodigoError(new Long(1));
			wsEstadoOutDTO.setDescripcionError("No fue posible rescatar Estados");
			wsEstadoOutDTO.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		logger.debug("getListaEstados():end");
		return wsEstadoOutDTO; 
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
	public PuebloDTO[] getListadoPueblos(EstadoDTO estado) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getPueblos()");
		PuebloDTO[] Pueblos = null;
		try{			                                       
			Pueblos = getGestionDeDirecciones().getListadoPueblos(estado);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw new GeneralException(e);
		}
		logger.debug("Fin:getPueblos()");
		return Pueblos;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback){		

		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("solicitaBajaAbonado():start");  
		ArrayList errores = new ArrayList();	
		RetornoDTO error = new RetornoDTO();
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{

			ValidacionesAltaLinea.ValidaUsuarioSCL(solicitudBajaAbonadoDTO.getIdUsuario());
			errores = valida.ValidarSolicitaBajaAbonado(solicitudBajaAbonadoDTO);

			if (errores.toArray().length > 0 ) {
				solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				solicitaBajaAbonadoOut.setResultadoTransaccion("1");
			}else{
				solicitaBajaAbonadoOut = getGestionDeCliente().solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO);
				error.setCodError("0");
				errores.add(error);
				solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				solicitaBajaAbonadoOut.setResultadoTransaccion("0");
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		}catch (GeneralException e) {
			error = new RetornoDTO();
			errores = new ArrayList();
			solicitudBajaAbonadoDTO = new WSSolicitudBajaAbonadoDTO();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());			
			errores.add(error);
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");

			context.setRollbackOnly();

			return solicitaBajaAbonadoOut;
		} catch (Exception e) {
			error = new RetornoDTO();
			errores = new ArrayList();

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			error.setCodError("1");
			error.setMensajseError("No fue solicitar la baja del abonado");			
			errores.add(error);
			solicitaBajaAbonadoOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			solicitaBajaAbonadoOut.setResultadoTransaccion("1");

			context.setRollbackOnly();

			return solicitaBajaAbonadoOut;	
		}
		logger.debug("solicitaBajaAbonado():end");
		return solicitaBajaAbonadoOut;
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
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)throws GeneralException{
		WsListConsultaPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanesTarifarios:start");
			retValue=getGestionDeCliente().getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanesTarifarios:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			retValue.setResultadoTransaccion("1");
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			retValue.setResultadoTransaccion("1");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReservaOutDTO reservaDesreserva(ReservaDTO solicitaReservaDTO, String tipoSolicitud, int rollback)throws GeneralException{	
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ArrayList errores = new ArrayList();
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{

			ValidacionesAltaLinea.ValidaUsuarioSCL(solicitaReservaDTO.getNomUsuario());
			if (tipoSolicitud.equals("R") || tipoSolicitud.equals("r")){

				errores = valida.ValidarSolicitaReserva(solicitaReservaDTO);

				if (errores.toArray().length > 0 ) {
					solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
					solicitaReservaOutDTO.setResultadoTransaccion("1");
				}else{

					logger.debug("SpnSclOrqBean: solicitaReserva:start");
					solicitaReservaOutDTO = getGestionDeCliente().solicitaReserva(solicitaReservaDTO);
					solicitaReservaOutDTO.setResultadoTransaccion("0");
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
					logger.debug("SpnSclOrqBean: solicitaReserva:end");
				}
			}
			else if (tipoSolicitud.equals("D") || tipoSolicitud.equals("d")) 				
			{
				errores = valida.ValidarSolicitaDesreserva(solicitaReservaDTO);

				if (errores.toArray().length > 0 ) {
					solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				}else{

					logger.debug("SpnSclOrqBean: solicitaDesreserva:start");
					solicitaReservaOutDTO = getGestionDeCliente().solicitaDesreserva(solicitaReservaDTO);
					solicitaReservaOutDTO.setResultadoTransaccion("0");
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
					logger.debug("SpnSclOrqBean: solicitaDesreserva:end");
				}
			}else{
				throw new GeneralException("12410",0,"Tipo de solicitud Invalido");
			}
			logger.debug("Rollback: ["+rollback+"]");
			if (rollback == 0){
				logger.debug("rollback == 0 Rollback ["+rollback+"]");
				context.setRollbackOnly();
				logger.debug("context [TRUE]");
			}
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			solicitaReservaOutDTO = new ReservaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaReservaOutDTO.setResultadoTransaccion("1");
			solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return solicitaReservaOutDTO; 
		}catch (Exception e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			RetornoDTO error = new RetornoDTO();
			solicitaReservaOutDTO = new ReservaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			solicitaReservaOutDTO.setResultadoTransaccion("1");
			solicitaReservaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			context.setRollbackOnly();
			return solicitaReservaOutDTO; 
		}
		return solicitaReservaOutDTO;
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsConsCargosVentaOutDTO getCargosFacturacion(WsConsCargosVentaInDTO WsFacturacionVentaIn) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getCargosFacturacion():start"); 
		RegistroVentaDTO RegistoVenta = new RegistroVentaDTO();
		AbonadoDTO[] listAbonadosFac;
		ParametrosObtencionCargosDTO ParametrosObtencionCargos = new ParametrosObtencionCargosDTO();;
		ArrayList errores = new ArrayList();	
		WsConsCargosVentaOutDTO facturacionVentaOutDTO = new WsConsCargosVentaOutDTO(); 

		try{
			//errores = valida.ValidarProcesoDeFacturacion(WsFacturacionVentaIn);

			if (errores.toArray().length > 0 ) {
				facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				facturacionVentaOutDTO.setResultadoTransaccion("1");
			}else{

				RegistoVenta.setNumeroVenta(new Long(WsFacturacionVentaIn.getNumVenta()).longValue());						
				listAbonadosFac = getGestionDeCliente().getListaAbonadosVenta(RegistoVenta);

				logger.debug("getCodCliente aboando 0 ["+listAbonadosFac[0].getCodCliente()+"]");
				logger.debug("getNumVenta aboando 0 ["+listAbonadosFac[0].getNumVenta()+"]");
				logger.debug("getCodVendedor aboando 0 ["+listAbonadosFac[0].getCodVendedor()+"]");
				logger.debug("getCodVendealer aboando 0 ["+listAbonadosFac[0].getCodVendealer()+"]");
				logger.debug("getCodCiclo aboando 0 ["+listAbonadosFac[0].getCodCiclo()+"]");
				logger.debug("getCodModVenta aboando 0 ["+listAbonadosFac[0].getCodModVenta()+"]");

				VendedorDTO vendedor = new VendedorDTO();						 			
				vendedor.setCodigoVendedor(String.valueOf(listAbonadosFac[0].getCodVendedor()));
				vendedor.setCodigoVendedorDealer(listAbonadosFac[0].getCodVendealer());

				RegistoVenta.setNumeroVenta(new Long(WsFacturacionVentaIn.getNumVenta()).longValue());						
				listAbonadosFac = getGestionDeCliente().getListaAbonadosVenta(RegistoVenta);

				try{			
					vendedor=getVendedor(vendedor);				
				}catch (GeneralException e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					context.setRollbackOnly();
					throw e;
				}catch (Exception e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					context.setRollbackOnly();
					throw new GeneralException(e);
				}

				ContratoDTO contratoDTO =new ContratoDTO();
				contratoDTO.setCodigoProducto(Integer.parseInt(config.getString("codigo.producto"))); 
				contratoDTO.setCodigoTipoContrato(listAbonadosFac[0].getCodTipContrato());
				try{
					contratoDTO=this.getListadoNumeroMesesContrato(contratoDTO);
				}catch (GeneralException e) {
					UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
					logger.debug("GeneralException");
					String log = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + log + "]");
					context.setRollbackOnly();
					throw e;
				}

				ParametrosObtencionCargos.setCodigoVendedor(String.valueOf(listAbonadosFac[0].getCodVendedor()));
				ParametrosObtencionCargos.setNumeroVenta(WsFacturacionVentaIn.getNumVenta());
				ParametrosObtencionCargos.setTipoContrato(listAbonadosFac[0].getCodTipContrato());
				ParametrosObtencionCargos.setCodigoModalidadVenta(String.valueOf(listAbonadosFac[0].getCodModVenta()));											
				ParametrosObtencionCargos.setNumeroMesesContrato(contratoDTO.getNumeroMeses());
				ParametrosObtencionCargos.setIndicadorTipoVenta(vendedor.getIndicadorTipoVenta());
				ParametrosObtencionCargos.setCodigoCausalDescuento("");


				if (listAbonadosFac[0].getCodUso().equals("2") || listAbonadosFac[0].getCodUso().equals("10")){
					ParametrosObtencionCargos.setAplicaPrepago(false);
				}else{
					ParametrosObtencionCargos.setAplicaPrepago(true);
				}
				/*Llena Causal de descuentos */						
				ParametrosCodDescDTO[] listParametrosCodDescDTO=null;

				ArrayList list=new ArrayList();
				for(int i=0;i<listAbonadosFac.length;i++){
					ParametrosCodDescDTO parametrosCodDescDTO=new ParametrosCodDescDTO();
					parametrosCodDescDTO.setCodigoCausaDescuento("");
					parametrosCodDescDTO.setNumAbonado(String.valueOf(listAbonadosFac[i].getNumAbonado()));															
					list.add(parametrosCodDescDTO);
				}
				listParametrosCodDescDTO=(ParametrosCodDescDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), ParametrosCodDescDTO.class);						
				/*Fin Causal de descuentos */

				/* Recuepra Cargos */
				ObtencionCargosDTO obtencionCargos=null;
				UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
				logger.debug("Inicio: getObtencionCargos:start");

				obtencionCargos = getFrmkCargosFacade().getObtencionCargos(ParametrosObtencionCargos,listParametrosCodDescDTO);
				facturacionVentaOutDTO.setCargos(obtencionCargos);
				facturacionVentaOutDTO.setResultadoTransaccion("0");

			}

		} catch (GeneralException e) {
			RetornoDTO error = new RetornoDTO();	
			facturacionVentaOutDTO = new WsConsCargosVentaOutDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			errores.add(error);
			facturacionVentaOutDTO.setResultadoTransaccion("1");
			facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			return facturacionVentaOutDTO; 

		} catch (Exception e) {
			RetornoDTO error = new RetornoDTO();	
			facturacionVentaOutDTO = new WsConsCargosVentaOutDTO();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores.add(error);
			facturacionVentaOutDTO.setResultadoTransaccion("1");
			facturacionVentaOutDTO.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			return facturacionVentaOutDTO; 
		}

		logger.debug("crearCliente():end");
		return facturacionVentaOutDTO; 
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CentralDTO getCentralTecnologia(CentralDTO central) 
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getCentralTecnologia():start");  
		try{
			central = getGestionDeCliente().getCentralTecnologia(central);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");					
			throw new GeneralException(e);
		}
		logger.debug("getHomeLinea():end");
		return central; 
	}	



	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsCunetaAltaDeLineaOutDTO AltaDeLinea(WsCunetaAltaDeLineaDTO CunetaAltaDeLinea, int rollback) 
	throws GeneralException{	
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("AltaDeLinea():start");


		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();

		DatosGeneralesVentaDTO datosVenta    = null;
		RetornoLineaDTO        retorno       = null; 
		ArrayList              listaerrores  = new ArrayList();
		Date                   fechaActual   = new Date(); 
		RegistroVentaDTO       regventa      = new RegistroVentaDTO(); 
		CentralDTO             central       = new CentralDTO();
		ArrayList              linealisCDMA  = new ArrayList();
		ArrayList              linealisGSM     = new ArrayList();
		String setTipProceso = "1";

		long numeroVenta = 0;

		try{

			numeroVenta = getSecuenciaVenta();

			//INI-01 (AL) - Comentado - Portabilidad
			//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
			//EstadoAsinc.setSpnPortId(CunetaAltaDeLinea.getIdentificadorTransaccion());
			//EstadoAsinc.setCodEstado("7");
			//EstadoAsinc.setTipProceso(setTipProceso);
			//EstadoAsinc.setNumProceso(String.valueOf(numeroVenta));
			//grabaEstadoAsinc(EstadoAsinc);
			//FIN-01 (AL) - Comentado - Portabilidad

			ContratoDTO contrato   = obtenerContratoNuevo();	
			ValidacionesAltaLinea.ValidaUsuarioSCL(CunetaAltaDeLinea.getNomUsuarioOra());
			CuentaComDTO cuentaCom = ValidacionesAltaLinea.obtieneCliente(CunetaAltaDeLinea);
			VendedorDTO vendedor   = ValidacionesAltaLinea.obtieneVendedor(CunetaAltaDeLinea);

			/* CSR-11002
			 * String IndVenPortado   = ValidacionesAltaLinea.obtieneIndPortado(CunetaAltaDeLinea.getLinea().getLineas()[0]);*/


			regventa.setCodigoSecuencia("GA_SEQ_TRANSACABO");
			regventa = getSecuencia(regventa);
			cuentaCom.getClienteComDTO().setNombreUsuarOra(CunetaAltaDeLinea.getNomUsuarioOra());



			if (cuentaCom.getClienteComDTO().getTipoCliente().equals("E")){
				if ((cuentaCom.getClienteComDTO().getNumeroAbonados() + CunetaAltaDeLinea.getLinea().getLineas().length) > new Integer(cuentaCom.getClienteComDTO().getNumeroAbonadosPorPlan()).intValue() ){
					retorno = new RetornoLineaDTO(); 
					retorno.setCodError("122667");
					retorno.setMensajseError("Error la cantidad de abonados supera la cantidad de abonado por plan empresa");	    				
					listaerrores.add(retorno);
				}else{

					cuentaCom.getClienteComDTO().setNumeroAbonados(cuentaCom.getClienteComDTO().getNumeroAbonados()+CunetaAltaDeLinea.getLinea().getLineas().length );
					getGestionDeCliente().udpEmpresa(cuentaCom);
				}
			}


			ReservaDTO solicitaReserva = null;
			ReservaOutDTO  solicitaDesreservaout = null;

			logger.debug("CunetaAltaDeLinea.getLinea().getLineas().length ["+CunetaAltaDeLinea.getLinea().getLineas().length+"]");

			if (CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoReserva().length() > 0 ){

				solicitaReserva = new ReservaDTO();
				solicitaDesreservaout = new ReservaOutDTO();

				solicitaReserva.setNumeroSolicitud(new Long(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoReserva()).longValue() );
				solicitaReserva.setNomUsuario(CunetaAltaDeLinea.getNomUsuarioOra());
				solicitaReserva.setCodVendedor(new Long(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoVendedor()).longValue());

				logger.debug("Antes de desreserva sim");
				solicitaDesreservaout = getGestionDeCliente().solicitaDesreserva(solicitaReserva);							
			}

			if (listaerrores.toArray().length < 1){

				listaerrores = valida.ValidarAltaDeLinea(CunetaAltaDeLinea);
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			}

			for (int lineas=0 ; lineas< CunetaAltaDeLinea.getLinea().getLineas().length;lineas++ ){

				central = ValidacionesAltaLinea.getCentralTecnologia(CunetaAltaDeLinea, lineas);

				PlanTarifarioDTO plantarifario2 = new PlanTarifarioDTO();
				plantarifario2.setCodigoPlanTarifario(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getDatosPlanTerifario().getPlanTarifario());
				plantarifario2.setCodigoProducto("1");
				plantarifario2.setCodigoTecnologia(central.getCodigoTecnologia());
				plantarifario2 = getPlanTarifario(plantarifario2);																	

				listaerrores = ValidacionesAltaLinea.validaIndicadorAltaCliente(cuentaCom,listaerrores,  plantarifario2);

				datosVenta = new DatosGeneralesVentaDTO();

				/*CSR-11002
				 * datosVenta.setIndicadorPortado(ValidacionesAltaLinea.obtieneIndPortado(CunetaAltaDeLinea.getLinea().getLineas()[lineas]));
				 */

				datosVenta.setCodigoOperador(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getCodigoOperador());

				SerieKitDTO serieKit = new SerieKitDTO();
				serieKit.setNumSerieSimcard(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getSimcard().getNumeroSerie());
				serieKit.setNumSerieTerminal(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getNumImei());

				serieKit = getInventarioPortabilidad().validaSerieKit(serieKit);

				/* CSR-11002
				 * if (datosVenta.getIndicadorPortado().equals("1")){

					if (central.getCodGrupoTecnologico().equals("GSM")){
						SimcardSNPNDTO simcard = new SimcardSNPNDTO();
						simcard.setNumeroSerie(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getSimcard().getNumeroSerie());
						simcard.setNumeroCelular(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getMin());
						simcard.setCodigoCentral(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCodigCentral());
						simcard.setCodigoSubAlm(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCelda());
						simcard.setIndProcEq("I");
						setNumeracionSimPortada(simcard);
					}else{
						TerminalSNPNDTO terminal = new TerminalSNPNDTO();
						terminal.setNumeroSerie(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getNumImei());

						terminal = getTerminal(terminal);						
						terminal.setNumeroCelular(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getMin());
						terminal.setCodigoCentral(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCodigCentral());
						terminal.setCodigoSubAlm(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCelda());
						setNumeracionTerminalPortada(terminal);
					}
				}*/
				/*CSR-11002
				 * listaerrores = ValidacionesAltaLinea.validaIndPortado(IndVenPortado,datosVenta,listaerrores, lineas);
				 */			

				listaerrores = ValidacionesAltaLinea.validaClienteEmpresa(cuentaCom, CunetaAltaDeLinea, listaerrores,lineas );

				datosVenta.setNumeroSerieTerminal(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getNumImei());
				datosVenta.setNumeroSerieSimcard(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getSimcard().getNumeroSerie());
				datosVenta.setNumeroSerieKit(serieKit.getNumSerieKit());
				datosVenta.setCodigoPlanTarifario(String.valueOf(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getDatosPlanTerifario().getPlanTarifario()));

				datosVenta.setCodigoCentral(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCodigCentral());
				datosVenta.setCodigoCelda(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getHomeLinea().getCelda());
				datosVenta.setCodigoTecnologia(central.getCodigoTecnologia());
				datosVenta.setCodigoGrupoTecnologico(central.getCodGrupoTecnologico());


				datosVenta.setNumeroVenta(String.valueOf(numeroVenta));
				datosVenta.setFechaActual(Formatting.dateTime(fechaActual, "dd/MM/yyyy HH:mm:ss"));
				datosVenta.setCodigoCliente(String.valueOf(CunetaAltaDeLinea.getCodigoDeCliente()));
				datosVenta.setCodigoVendedorRaiz(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer());
				datosVenta.setCodigoVendedor(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoVendedor());
				datosVenta.setNumeroTransaccionVenta(String.valueOf(regventa.getNumeroTransaccionVenta()));
				datosVenta.setNombreUsuarioOracle(CunetaAltaDeLinea.getNomUsuarioOra());
				datosVenta.setIdentificadorEmpresa(cuentaCom.getClienteComDTO().getTipoCliente());				
				datosVenta.setCodigoModalidadVenta(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoModalidadVenta());
				datosVenta.setCodigoTipoContrato(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoTipoContrato());
				datosVenta.setNumeroContrato(contrato.getNumeroContrato());
				datosVenta.setCodigoVendedorDealer(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCodigoDealer());			
				datosVenta.setCodigoCuotas(CunetaAltaDeLinea.getLinea().getAntecedentesVenta().getCuotas());							 
				datosVenta.setCodigoRegion(vendedor.getDireccion().getRegion());
				datosVenta.setCodigoProvincia(vendedor.getDireccion().getProvincia() );
				datosVenta.setCodigoCiudad(vendedor.getDireccion().getCiudad());

				datosVenta.setUsuarioLinea(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getUsuarioLinea());


				datosVenta.setCodigoSimcardGSM("G");
				datosVenta.setEstadoSerieSimcard("1");
				datosVenta.setEstadoSerieTerminal("1");
				datosVenta.setIndicadorFacturable("1");
				datosVenta.setTipoPlanPostpago("2");
				datosVenta.setTipoPlanHibrido("3");	
				datosVenta.setIndicadorComodato("1");				 
				datosVenta.setCodigoTerminalGSM("T");
				datosVenta.setTipoTerminal("G");
				datosVenta.setNumeroPerContrato("1");
				datosVenta.setCodigoGrupoServicio(config.getString("codgrpserv"));
				datosVenta.setCodigoPlanIndemnizacion(config.getString("codigo.planIndemnizacion"));
				datosVenta.setCodigoEstado(config.getString("parametro.codigo.estadocobro"));								
				datosVenta.setIndicadorSexo("");
				
				/*CSR-11002*/
				datosVenta.setCodPrestacion(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getCodPrestacion());
				logger.debug("Set cod Prestacion en datosVenta: "+CunetaAltaDeLinea.getLinea().getLineas()[lineas].getCodPrestacion());
				/*fin CSR-11002*/


				if (CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getMin() != null && !CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getMin().equals("") ){
					logger.debug("Celular no automatico");
					datosVenta.setNumeroCelular(CunetaAltaDeLinea.getLinea().getLineas()[lineas].getTerminal().getMin());
				}else{
					logger.debug("Celular automatico");
					datosVenta.setNumeroCelular("0");
				}

				if(central.getCodGrupoTecnologico().equals("CDMA")){
					linealisCDMA.add(datosVenta);				
				}else if (central.getCodGrupoTecnologico().equals("GSM")){
					linealisGSM.add(datosVenta);					
				}

			}	




			DatosGeneralesVentaDTO[] LineasGSM = null;
			DatosGeneralesVentaDTO[] LineasCDMA = null;

			cuentaCom.getClienteComDTO().setLineaGSM((DatosGeneralesVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(linealisGSM.toArray(), DatosGeneralesVentaDTO.class));
			cuentaCom.getClienteComDTO().setLineaCDMA((DatosGeneralesVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(linealisCDMA.toArray(), DatosGeneralesVentaDTO.class));

			if (cuentaCom.getClienteComDTO().getLineaGSM() != null){
				if (cuentaCom.getClienteComDTO().getLineaGSM().length > 0){
					cuentaCom = getGestionDeCliente().validacionLineaGrupoGSM(cuentaCom);
				}
			}

			if (cuentaCom.getClienteComDTO().getLineaCDMA() != null){
				if (cuentaCom.getClienteComDTO().getLineaCDMA().length > 0 ){
					cuentaCom = getGestionDeCliente().validacionLineaGrupoCDMA(cuentaCom);
				}
			}

			if (cuentaCom.getClienteComDTO().getLineaGSM() != null){
				if (cuentaCom.getClienteComDTO().getLineaGSM().length > 0){
					LineasGSM  =  getGestionDeCliente().creacionLineas(cuentaCom.getClienteComDTO().getLineaGSM());
				}
			}

			if (cuentaCom.getClienteComDTO().getLineaCDMA() != null){
				if (cuentaCom.getClienteComDTO().getLineaCDMA().length > 0 ){
					LineasCDMA =  getGestionDeCliente().creacionLineasCDMA(cuentaCom.getClienteComDTO().getLineaCDMA());
				}
			}

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Crea linea Linea Antes():Fin");


			if (cuentaCom.getClienteComDTO().getLineaGSM() != null && cuentaCom.getClienteComDTO().getLineaGSM().length > 0){
				logger.debug("Crea Ventaa():Antes");
				creaVenta(cuentaCom.getClienteComDTO().getLineaGSM()[0],cuentaCom);
			}else if (cuentaCom.getClienteComDTO().getLineaCDMA() != null && cuentaCom.getClienteComDTO().getLineaCDMA().length > 0){
				creaVenta(cuentaCom.getClienteComDTO().getLineaCDMA()[0],cuentaCom);
			}else{
				throw new GeneralException("1",1,"Error no existen lineas para procesar");
			}



			int candma;
			int cangsm;

			if (LineasCDMA != null ){
				candma = LineasCDMA.length;
			}else{
				candma = 0;
			}

			if (LineasGSM != null ){
				cangsm = LineasGSM.length;
			}else{
				cangsm = 0;
			}

			WsLineaOutDTO lineaOut = null; 
			WsLineaOutDTO arrayLineaAut[] = new WsLineaOutDTO[candma + cangsm];

			int i=0;
			int j=0;

			for (i=0; i< cangsm;i++){
				lineaOut = new WsLineaOutDTO();

				lineaOut.setNumCelular(LineasGSM[i].getNumeroCelular());				
				logger.debug("dados[i].getNumeroCelular() ["+LineasGSM[i].getNumeroCelular()+"]");

				lineaOut.setNumImei(LineasGSM[i].getNumeroSerieTerminal());				
				logger.debug("dados[i].getNumeroSerieTerminal() ["+LineasGSM[i].getNumeroSerieTerminal()+"]");

				lineaOut.setNumSerie(LineasGSM[i].getNumeroSerieSimcard());
				logger.debug("dados[i].getNumeroSerieSimcard() ["+LineasGSM[i].getNumeroSerieSimcard()+"]");

				lineaOut.setNumAboando(LineasGSM[i].getNumeroAbonado());
				logger.debug("dados[i].getNumeroAbonado() ["+LineasGSM[i].getNumeroAbonado()+"]");

				arrayLineaAut[i] = lineaOut; 
			}




			for (j=0; j< candma;j++){
				lineaOut = new WsLineaOutDTO();

				lineaOut.setNumCelular(LineasCDMA[j].getNumeroCelular());				
				logger.debug("dados[i].getNumeroCelular() ["+LineasCDMA[j].getNumeroCelular()+"]");

				lineaOut.setNumImei(LineasCDMA[j].getNumeroSerieTerminal());				
				logger.debug("dados[i].getNumeroSerieTerminal() ["+LineasCDMA[j].getNumeroSerieTerminal()+"]");

				lineaOut.setNumSerie(LineasCDMA[j].getNumeroSerieSimcard());
				logger.debug("dados[i].getNumeroSerieSimcard() ["+LineasCDMA[j].getNumeroSerieSimcard()+"]");

				lineaOut.setNumAboando(LineasCDMA[j].getNumeroAbonado());
				logger.debug("dados[i].getNumeroAbonado() ["+LineasCDMA[j].getNumeroAbonado()+"]");

				arrayLineaAut[j+i] = lineaOut; 
			}




			if (listaerrores != null && listaerrores.toArray().length > 0){
				logger.debug("Crea Lineas errores");
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");		
				CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaerrores.toArray(), RetornoLineaDTO.class));				
			}else{
				logger.debug("Crea Lineas");
				CunetaAltaDeLineaOut.setResultadoTransaccion("0");		
				CunetaAltaDeLineaOut.setLineaOut(arrayLineaAut);			
				CunetaAltaDeLineaOut.setNumVenta( String.valueOf(numeroVenta));
			}								


			//INI-02 (AL) - Comentado - Portabilidad
//			if (listaerrores.toArray().length > 0 || (CunetaAltaDeLineaOut.getErrores() != null && CunetaAltaDeLineaOut.getErrores().length > 0 ) ){
//				EstadoAsinc.setSpnPortId(CunetaAltaDeLinea.getIdentificadorTransaccion());
//				EstadoAsinc.setCodEstado("9");
//				EstadoAsinc.setTipProceso(setTipProceso);
//				EstadoAsinc.setNumProceso(String.valueOf(numeroVenta));
//				grabaEstadoAsinc(EstadoAsinc);
//				logger.debug("context.setRollbackOnly()");
//				context.setRollbackOnly();
//			}else{
//				EstadoAsinc.setCodEstado("8");
//				EstadoAsinc.setTipProceso(setTipProceso);
//				EstadoAsinc.setNumProceso(String.valueOf(numeroVenta));
//				grabaEstadoAsinc(EstadoAsinc);	
//			}
			//FIN-02 (AL) - Comentado - Portabilidad

			logger.debug("Rollback: ["+rollback+"]");
			if (rollback == 0){
				logger.debug("rollback == 0 Rollback ["+rollback+"]");
				context.setRollbackOnly();
				logger.debug("context [TRUE]");
			}			




		} catch (GeneralException e) {
			logger.debug("GeneralException ORQ");			
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");

			RetornoLineaDTO error = new RetornoLineaDTO();	
			if (listaerrores != null && listaerrores.toArray().length > 0){
				error.setCodError(e.getCodigo());
				error.setMensajseError(e.getDescripcionEvento());
				listaerrores.add(error);
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");				
				CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaerrores.toArray(), RetornoLineaDTO.class));				
			}else{
				CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
				ArrayList errores1 = new ArrayList();
				error.setCodError(e.getCodigo());
				error.setMensajseError(e.getDescripcionEvento());
				errores1.add(error);
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");
				CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores1.toArray(), RetornoLineaDTO.class));
			}

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(CunetaAltaDeLinea.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("9");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(String.valueOf(numeroVenta));
				//grabaEstadoAsinc(EstadoAsinc);
			//}catch(GeneralException g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch(Exception g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}
			logger.debug("context.setRollbackOnly()");
			context.setRollbackOnly();


			logger.debug("context.setRollbackOnly() ["+context.getRollbackOnly()+"]");
			return CunetaAltaDeLineaOut;

		} catch (Exception e) {
			RetornoLineaDTO error = new RetornoLineaDTO();	
			CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
			ArrayList errores1 = new ArrayList();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores1.add(error);
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores1.toArray(), RetornoLineaDTO.class));			
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(CunetaAltaDeLinea.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("9");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(String.valueOf(numeroVenta));
				//grabaEstadoAsinc(EstadoAsinc);
			//}catch(GeneralException g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch(Exception g){
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}
			logger.debug("context.setRollbackOnly()");
			context.setRollbackOnly();
			return CunetaAltaDeLineaOut;

		}

		logger.debug("AltaDeLinea():end");
		return CunetaAltaDeLineaOut; 
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setNumeracionSimPortada(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("setNumeracionSimPortada():start");  
		try{
			getGestionDeCliente().setNumeracionSimPortada(simcardSNPNDTO);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");					
			throw new GeneralException(e);
		}
		logger.debug("setNumeracionSimPortada():end");
	}


	public void setNumeracionTerminalPortada(TerminalSNPNDTO terminal) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("setNumeracionTerminalPortada():start");  
		try{
			getGestionDeCliente().setNumeracionTerminalPortada(terminal);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");					
			throw new GeneralException(e);
		}
		logger.debug("setNumeracionTerminalPortada():end");
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(MigracionDTO migracionDTO) throws GeneralException{

		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		ComprobacionDatosObligatorios datosobligatorios = new ComprobacionDatosObligatorios();
		MigracionPrepagoPostpagoDTO ejecucion = new MigracionPrepagoPostpagoDTO();

		try
		{
			if(migracionDTO.getCodCliente() == null && migracionDTO.getCodOficina().equals("") && migracionDTO.getCodPlanTarif().equals("") &&
					migracionDTO.getIndProcEqTerminal().equals("") && migracionDTO.getNomUsuarioVendedor().equals("") &&
					migracionDTO.getNumCelular() == null){

				ejecucion.setCodError("ERR.0994");
				ejecucion.setDesError(config.getString("ERR.0994"));

				throw new GeneralException("ERR.0994",994,config.getString("ERR.0994"));

			} else {	
				datosobligatorios.validar(migracionDTO);
			}

			resultado =  getGestionDeCliente().validaDatos(migracionDTO);
			ejecucion.setCodError(resultado.getCodigoError());
			ejecucion.setDesError(resultado.getMensajeError());
			if (!"0".equalsIgnoreCase(resultado.getCodigoError())){
				return ejecucion;
			}

			ejecucion = getGestionDeCliente().migraPrepagoAPostpago(migracionDTO);	


		}catch(GeneralException e)
		{
			ejecucion.setCodError(String.valueOf(e.getCodigo()));
			ejecucion.setDesError(e.getDescripcionEvento());
		} catch (Exception e) {
			e.printStackTrace();
			ejecucion.setCodError("-1");
			ejecucion.setDesError(e.getMessage());
		}
		logger.info("WSMigracionClientePrepagoAPostpago: fin");
		return ejecucion;
	}





	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void registraAltaAsincrono(WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut, String id_transaccion) 
	throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("registraAltaAsincrono():start");  
		try{
			getGestionDeCliente().registraAltaAsincrono(cunetaAltaDeLineaOut, id_transaccion);

			if (cunetaAltaDeLineaOut.getResultadoTransaccion().equals("1") ){
				context.setRollbackOnly();
			}

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");					
			throw new GeneralException(e);
		}
		logger.debug("registraAltaAsincrono():end");
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(String id_transaccion) 
	throws GeneralException
	{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("recuperarAltaAsincrono():start");  
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();		
		try{
			CunetaAltaDeLineaOut = getGestionDeCliente().recuperarAltaAsincrono(id_transaccion);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	

			RetornoLineaDTO error = new RetornoLineaDTO();	
			CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
			ArrayList errores1 = new ArrayList();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores1.add(error);
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores1.toArray(), RetornoLineaDTO.class));			
			return CunetaAltaDeLineaOut;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			RetornoLineaDTO error = new RetornoLineaDTO();	
			CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
			ArrayList errores1 = new ArrayList();
			error.setCodError("1");
			error.setMensajseError(e.getMessage());
			errores1.add(error);
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			CunetaAltaDeLineaOut.setErrores((RetornoLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores1.toArray(), RetornoLineaDTO.class));
			return CunetaAltaDeLineaOut;					
		}
		logger.debug("recuperarAltaAsincrono():end");
		return CunetaAltaDeLineaOut;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("recCampanaBeneficio():start"); 
		WsBeneficioPromocionOutDTO[] retorno = null;
		try{
			retorno = getGestionDeCliente().recCampanaBeneficio(beneficioPromocion);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");				
		}
		logger.debug("recuperarAltaAsincrono():end");
		return retorno;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("registraCampanaBeneficio():start"); 		
		try{
			getGestionDeCliente().registraCampanaBeneficio(registraCampanaByPIn);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");				
		}
		logger.debug("registraCampanaBeneficio():end");		
	}			


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws RemoteException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsStructuraComercialOutDTO AltaDeStructuraComercial(WsCreaStructuraComercialInDTO WsCreaStructuraComercial) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ Start : AltaDeStructuraComercial ++++++++++++++++++++++++++++++++++++++++++++");


		WsStructuraComercialOutDTO CunetaAltaDeLineaOut = null;

		logger.debug("WsCreaStructuraComercial.getCuenta().getCodigoCuenta() ["+WsCreaStructuraComercial.getCuenta().getCodigoCuenta()+"]");		
		if (WsCreaStructuraComercial.getCuenta().getCodigoCuenta() == null || WsCreaStructuraComercial.getCuenta().getCodigoCuenta().equals("") || WsCreaStructuraComercial.getCuenta().getCodigoCuenta().equals("0")){
			CunetaAltaDeLineaOut = CreaStructuraConCliente(WsCreaStructuraComercial);			
		}else if(WsCreaStructuraComercial.getCuenta().getCodigoCuenta() != null && !WsCreaStructuraComercial.getCuenta().getCodigoCuenta().equals("") && WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas() != null && WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas().length > 0) {
			CunetaAltaDeLineaOut = CreaStructuraSinCliente(WsCreaStructuraComercial);
		}else if(WsCreaStructuraComercial.getCuenta().getCodigoCuenta() != null && !WsCreaStructuraComercial.getCuenta().getCodigoCuenta().equals("") && WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas() == null && WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios() != null){
			CunetaAltaDeLineaOut = CreaStructuraSoloAccesorios(WsCreaStructuraComercial);			
		}
		logger.debug("++++++++++++++++++++++++++++++++++ Start : AltaDeStructuraComercial ++++++++++++++++++++++++++++++++++++++++++++");
		return CunetaAltaDeLineaOut;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsTiendasOutDTO getTiendas() 
	throws GeneralException
	{		
		WsTiendasOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getTiendas():start"); 		
		try{
			resultado = getInventarioPortabilidad().getTiendas();
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("getTiendas():end");	
		return resultado;
	}			


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda)throws GeneralException
	{
		WsTiendaVendedorOutDTO retValue=null ;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("getTiendaVendedor():start"); 		
		try{
			retValue = getInventarioPortabilidad().getTiendaVendedor(codTienda);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("getTiendaVendedor():end");	
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipificacionDTO[] recuperaDatoTipificacion (String datoTipificacion, String codVendedor)throws GeneralException{
		TipificacionDTO[] resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("recuperaDatoTipificacion():start"); 		
		try{
			resultado = getInventarioPortabilidad().recuperaDatoTipificacion(datoTipificacion,codVendedor);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("recuperaDatoTipificacion():end");	
		return resultado;
	}



	private WsStructuraComercialInternoDTO CreaDireccionQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{

		WsDireccionOutDTO WsDireccionesOut = null;			
		WsDireccionInDTO WsDireccionesIn = new WsDireccionInDTO();

		try{
			WsDireccionesIn.setCodigoRegion(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoRegion());
			WsDireccionesIn.setCodigoProvincia(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoProvincia());
			WsDireccionesIn.setCodigoComuna(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoComuna());
			WsDireccionesIn.setCodigoCiudad(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoCiudad());
			WsDireccionesIn.setZIP(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getZIP());
			WsDireccionesIn.setNombreCalle(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getNombreCalle());
			WsDireccionesIn.setNumeroCalle(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getNumeroCalle());											
			//INICIO CSR-11002
			WsDireccionesIn.setNumeroPiso(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getPiso());
			WsDireccionesIn.setObservacionDireccion(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getObservacionDescripcion());			
			WsDireccionesIn.setCodigoPueblo(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getPueblo());						
			WsDireccionesIn.setDescripcionDireccion1(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getDescripcionDireccion1());
			WsDireccionesIn.setDescripcionDireccion2(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getDescripcionDireccion2());			
			WsDireccionesIn.setCodigoEstado(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getEstado());			
			WsDireccionesIn.setNumeroCasilla(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCasilla());
			WsDireccionesIn.setTipoCalle(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getTipoCalle());

			logger.debug("Antes Agregar Direccion");
			WsDireccionesOut = agregarDireccion(WsDireccionesIn, 1);

			structuraComercialInterno.setCodigoDireccion(WsDireccionesOut.getCodigoDireccion());
			structuraComercialInterno.setResultadoTransaccion(WsDireccionesOut.getResultadoTransaccion());
			structuraComercialInterno.setErrores(WsDireccionesOut.getErrores());

			logger.debug("Despues Agregar Direccion");			    

			logger.debug("WsDireccionesOut.getResultadoTransaccion() ["+WsDireccionesOut.getResultadoTransaccion()+"]");

			if (WsDireccionesOut.getErrores() != null && WsDireccionesOut.getErrores().length > 0){
				for (int i= 0; i<WsDireccionesOut.getErrores().length; i++){
					logger.debug("WsDireccionesOut ["+WsDireccionesOut.getErrores()[i].getMensajseError());
				} 
			}
		}catch (GeneralException e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}catch (Exception e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}

		return structuraComercialInterno;

	}


	private WsStructuraComercialInternoDTO CreaCuentaSubCuentaQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{

		WsAltaCuentaSubCuentaOutDTO retornoCuenta   = null;
		WsAltaCuentaSubCuentaInDTO  cuentaSubcuenta = new WsAltaCuentaSubCuentaInDTO();		
		VendedorDTO vendedor = new VendedorDTO();


		try{

			vendedor.setCodigoVendedor(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor());
			vendedor.setCodigoVendedorDealer(0);	
			vendedor = getVendedor(vendedor);


			logger.debug("Antes Datos cuenta");
			cuentaSubcuenta.setCategoriaTributaria(config.getString("CAT_TRIB_DEFAULT"));
			cuentaSubcuenta.setCodigoCategoria(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCategoria());
			cuentaSubcuenta.setCodigoClasificacion(config.getString("COD_CLAS_CTA"));
			cuentaSubcuenta.setCodigoComisionista1raVenta(vendedor.getCodTipComisionista());
			cuentaSubcuenta.setCodigoDireccion(structuraComercialInterno.getCodigoDireccion());
			cuentaSubcuenta.setDescripcionCuenta(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente());
			cuentaSubcuenta.setFechaNacimiento("");
			cuentaSubcuenta.setNombreResponsable(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente());
			cuentaSubcuenta.setNumeroIdentificacion(WsCreaStructuraComercial.getCuenta().getCliente().getNumeroIdent());
			cuentaSubcuenta.setTelefonoContacto("");
			cuentaSubcuenta.setTipoDeCuenta(config.getString("TIP_CUENTA"));
			cuentaSubcuenta.setTipoDeIdentificacion(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoTipoIdent());

			logger.debug("Despues Datos cuenta");

			logger.debug("Antes Crea cuenta");
			retornoCuenta = AltaCuentaSubCuenta(cuentaSubcuenta, 1);
			logger.debug("Despues Crea cuenta");

			structuraComercialInterno.setCdogioCuenta(retornoCuenta.getCodigoCuenta());						
			structuraComercialInterno.setResultadoTransaccion(retornoCuenta.getResultadoTransaccion());
			structuraComercialInterno.setErrores(retornoCuenta.getErrores());



			logger.debug("retornoCuenta.getResultadoTransaccion() ["+retornoCuenta.getResultadoTransaccion()+"]");

			if (retornoCuenta.getErrores() != null && retornoCuenta.getErrores().length > 0){
				for (int i= 0; i<retornoCuenta.getErrores().length; i++){
					logger.debug("retornoCuenta.getMensajseError ["+retornoCuenta.getErrores()[i].getMensajseError());
				} 
			}

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
			return structuraComercialInterno;

		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
			return structuraComercialInterno;
		}

		return structuraComercialInterno;

	}	


	private WsStructuraComercialInternoDTO CreaClienteQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{

		WsCuentaInNDTO wsCuentaInN = new WsCuentaInNDTO();
		WsAltaClienteOutDTO wsAltaClienteOut        = null;

		try{

			wsCuentaInN.setCodigoCuenta(structuraComercialInterno.getCdogioCuenta());
			WsClienteInDTO cliente = new WsClienteInDTO();

			// Responsable de Cliente 
			WsResponsableInDTO Responsable = new WsResponsableInDTO();
			Responsable.setCodigoTipident(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoTipoIdent());
			Responsable.setNumeroIdent(WsCreaStructuraComercial.getCuenta().getCliente().getNumeroIdent());
			Responsable.setNombreResponsable(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente());				


			// Apoderado de Cliente
			WsApoderadoInDTO Apoderado = new WsApoderadoInDTO();
			Apoderado.setCodigoTipident(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoTipoIdent());
			Apoderado.setNumeroIdent(WsCreaStructuraComercial.getCuenta().getCliente().getNumeroIdent());
			Apoderado.setNomApoderado(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente());


			// Banco de Cliente
			com.tmmas.cl.scl.commonapp.dto.WsBancoInDTO banco = new com.tmmas.cl.scl.commonapp.dto.WsBancoInDTO();
			banco.setCodBanco("");
			banco.setIndicadorTipcuenta("");
			banco.setNumeroCtacorr("");
			//Tarjeta de Banco 
			WsTarjetaCreditoInDTO tarjeta = new WsTarjetaCreditoInDTO();
			tarjeta.setFechaDeVencimiento("");
			tarjeta.setNumeroTarjeta("");
			tarjeta.setTipoTarjeta("");									
			//Sucursal de Banco
			WsSucursalBancoInDTO sucursal = new WsSucursalBancoInDTO();
			sucursal.setCodigoSucursal("");																
			banco.setSucursal(sucursal);
			banco.setTarjeta(tarjeta);

			cliente.setResponsable(Responsable);
			cliente.setApoderado(Apoderado);
			cliente.setBanco(banco);

			cliente.setCodDireccionCorrespondencia(structuraComercialInterno.getCodigoDireccion());
			cliente.setCodDireccionFacturacion(structuraComercialInterno.getCodigoDireccion());
			cliente.setCodDireccionPersonal(structuraComercialInterno.getCodigoDireccion());
			cliente.setCodigoCategImpos(config.getString("COD_CATIMPOS"));
			cliente.setCodigoCategoria(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCategoria());
			cliente.setCodigoCiclo(new Long(config.getString("CICLO_PREPAGO")).longValue());
			cliente.setCodigoOficina(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoOficina());
			cliente.setCodigoPais(config.getString("COD_PAIS"));
			cliente.setCodigoPlanTarifario("");
			cliente.setCodigoTipIdent2("");
			cliente.setCodigoTipoIdent(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoTipoIdent());
			cliente.setCodigoUso(config.getString("USO_PREPAGO"));
			cliente.setCodSistemaPago(config.getString("COD_SISPAGO"));
			cliente.setFechaNacimiento("");
			cliente.setIndicadorEstadoCivil("");
			cliente.setIndicadorSexo("");
			cliente.setNombreApeclien1(WsCreaStructuraComercial.getCuenta().getCliente().getNombreApeclien1());
			cliente.setNombreApeclien2(WsCreaStructuraComercial.getCuenta().getCliente().getNombreApeclien2());
			cliente.setNombreCliente(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente());
			cliente.setNombreEmail("");
			cliente.setNumeroFax("");
			cliente.setNumeroIdent(WsCreaStructuraComercial.getCuenta().getCliente().getNumeroIdent());
			cliente.setNumeroIntGrupoFam("");
			cliente.setNumIdent2("");
			cliente.setPagoAtumaticoManual(config.getString("PAGO_MANUAL"));
			cliente.setTelefonoContac1("");
			cliente.setTelefonoContac2("");		
			
			//INICIO CSR-11002
			cliente.setCodCrediticia(WsCreaStructuraComercial.getCuenta().getCliente().getCodCrediticia());
			//FIN CSR-11002
			
			wsCuentaInN.setNomUsuarioOra(WsCreaStructuraComercial.getUsuarioOracle());
			wsCuentaInN.setClienteDTO(cliente);			

			wsAltaClienteOut = AltaCliente(wsCuentaInN, 1);

			structuraComercialInterno.setCodigoCliente(wsAltaClienteOut.getCodigoCliente());												
			structuraComercialInterno.setResultadoTransaccion(wsAltaClienteOut.getResultadoTransaccion());
			structuraComercialInterno.setErrores(wsAltaClienteOut.getErrores());

			if (wsAltaClienteOut.getErrores() != null && wsAltaClienteOut.getErrores().length > 0){
				for (int i= 0; i<wsAltaClienteOut.getErrores().length; i++){
					logger.debug("wsAltaClienteOut ["+wsAltaClienteOut.getErrores()[i].getMensajseError());
				} 
			}

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
			return structuraComercialInterno; 
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
			return structuraComercialInterno;
		}

		return structuraComercialInterno;

	}




	private WsStructuraComercialInternoDTO CreaAltaDeLineaQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{


		try{

			WsCunetaAltaDeLineaDTO AltaDeLinea = new WsCunetaAltaDeLineaDTO();

			AltaDeLinea.setCodigoDeCliente(structuraComercialInterno.getCodigoCliente());
			AltaDeLinea.setCodigoDeCuenta(structuraComercialInterno.getCdogioCuenta());
			AltaDeLinea.setNomUsuarioOra(WsCreaStructuraComercial.getUsuarioOracle());			
			AltaDeLinea.setIdentificadorTransaccion("1");

			WsActivacionLineaDTO linea = new WsActivacionLineaDTO();
			WsAntecedentesVentaInDTO antecedentesVenta = new WsAntecedentesVentaInDTO();

			antecedentesVenta.setCodigoDealer("0");
			antecedentesVenta.setCodigoModalidadVenta(config.getString("COD_MODVENTA")); 
			antecedentesVenta.setCodigoReserva("");
			antecedentesVenta.setCodigoTipoContrato(config.getString("COD_TIPCONTRATO")); 
			antecedentesVenta.setCodigoVendedor(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor());
			antecedentesVenta.setCuotas("");			
			linea.setAntecedentesVenta(antecedentesVenta);

			WsHomeLineaInDTO homeLinea = null;
			WsSimcardInDTO simcard = null;
			WsTerminalInDTO terminal = null;
			WsDatosPlanTerifarioInDTO datosPlanTerifario = null;	
			WsUsuarioInDTO usuarioLinea = null;


			WsLineaInDTO lineas = null;
			ArrayList listLineas = new ArrayList();
			WsLineaInDTO[] Areglolineas = null;
			
			logger.debug("CANTIDAD_LINEAS: " + WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas().length);
			
			for(int i=0; i < WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas().length ; i++ ){				
				homeLinea = new WsHomeLineaInDTO();
				simcard = new WsSimcardInDTO();
				terminal = new WsTerminalInDTO();
				datosPlanTerifario = new WsDatosPlanTerifarioInDTO();
				usuarioLinea = new WsUsuarioInDTO();
				lineas = new WsLineaInDTO();

				homeLinea.setCelda(config.getString("celda.quiosco"));
				homeLinea.setCodigCentral(config.getString("central.quiosco"));

				simcard.setNumeroSerie(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getSimcard().getNumeroSerie());
				terminal.setMin(new String(""));

				if (WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getTerminal().getNumImei().equals("")){
					terminal.setNumImei(config.getString("IMEI-DUMY"));
				}else{					
					terminal.setNumImei(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getTerminal().getNumImei());
				}

				//JLGN	
				//datosPlanTerifario.setPlanTarifario(config.getString("planTarifario.prepago.quiosco"));
				logger.debug("JLGN Plan Tarifario");
				logger.debug("WsCreaStructuraComercial.getCodPlanTarif(): "+ WsCreaStructuraComercial.getCodPlanTarif());
				datosPlanTerifario.setPlanTarifario(WsCreaStructuraComercial.getCodPlanTarif());

				usuarioLinea.setCodDireccion(structuraComercialInterno.getCodigoDireccion());
				usuarioLinea.setIngresosBrutosAnuales("0");
				usuarioLinea.setNombre(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getUsuarioLinea().getNombre());
				usuarioLinea.setNomEmpresa("");
				usuarioLinea.setNumeroIdentificacion(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getUsuarioLinea().getNumeroIdentificacion());
				usuarioLinea.setOcupacion("");
				usuarioLinea.setPrimerApellido(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getUsuarioLinea().getPrimerApellido());
				usuarioLinea.setSegundoApellido(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getUsuarioLinea().getSegundoApellido());
				usuarioLinea.setTipIdentificacion(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getLineas()[i].getUsuarioLinea().getTipIdentificacion());

				lineas.setCodigoOperador("");
				lineas.setDatosPlanTerifario(datosPlanTerifario);
				lineas.setHomeLinea(homeLinea);
				lineas.setSimcard(simcard);
				lineas.setTerminal(terminal);				
				lineas.setUsuarioLinea(usuarioLinea);
				lineas.setCodPrestacion(WsCreaStructuraComercial.getCodPrestacion()); //CSR-11002

				listLineas.add(lineas);
			}

			Areglolineas =(WsLineaInDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listLineas.toArray(), WsLineaInDTO.class);
			linea.setLineas(Areglolineas);
			AltaDeLinea.setLinea(linea);				

			logger.debug("Antes de alta de linea");
			WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = AltaDeLinea(AltaDeLinea, 1);
			logger.debug("Despues de alta de linea");

			structuraComercialInterno.setLineaOut(CunetaAltaDeLineaOut.getLineaOut());
			structuraComercialInterno.setNumVenta(CunetaAltaDeLineaOut.getNumVenta());
			structuraComercialInterno.setResultadoTransaccion(CunetaAltaDeLineaOut.getResultadoTransaccion());

			logger.debug("WsCunetaAltaDeLineaOutDTO.getResultadoTransaccion() ["+CunetaAltaDeLineaOut.getResultadoTransaccion()+"]");
			ArrayList errores = new ArrayList();

			if (CunetaAltaDeLineaOut.getErrores() != null && CunetaAltaDeLineaOut.getErrores().length > 0){
				for (int i= 0; i<CunetaAltaDeLineaOut.getErrores().length; i++){
					logger.debug("retornoLinea.getMensajseError ["+CunetaAltaDeLineaOut.getErrores()[i].getMensajseError());					
					RetornoDTO error = new RetornoDTO();	
					error.setCodError(CunetaAltaDeLineaOut.getErrores()[i].getCodError());
					error.setMensajseError(CunetaAltaDeLineaOut.getErrores()[i].getMensajseError());
					errores.add(error);					
				} 			
				structuraComercialInterno.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
			}						

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}

		return structuraComercialInterno;
	}

	private WsStructuraComercialInternoDTO ProcesoFacturacionQuiosco(WsCreaStructuraComercialInDTO wsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno, CargosDescuentosManualesDTO[] carDesManuales) 
	throws GeneralException, RemoteException{

		logger.debug("ProcesoFacturacionQuiosco getResultadoTransaccion()");

		WsFacturacionVentaOutDTO facturacionVentaOut = new WsFacturacionVentaOutDTO();
		WsFacturacionVentaInDTO  facturacionVentaIn  = new WsFacturacionVentaInDTO();
		WsFacturacionLineaDTO    facturacionLinea    = new WsFacturacionLineaDTO();     

		try{			
			facturacionVentaIn.setFacturaACiclo(false);
			facturacionVentaIn.setIdentificadorTransaccion("1");
			facturacionVentaIn.setNomUsuario(wsCreaStructuraComercial.getUsuarioOracle());
			facturacionVentaIn.setNumVenta(structuraComercialInterno.getNumVenta());
			facturacionVentaIn.setObsFactVenta("");



			ArrayList lineasFacturacion = new ArrayList();
			for (int i=0; i < structuraComercialInterno.getLineaOut().length ; i++){
				facturacionLinea = new WsFacturacionLineaDTO();

				facturacionLinea.setMntoDscSimcard(0);
				facturacionLinea.setMntoDscTerminal(0);
				facturacionLinea.setNumCelular(new Long(structuraComercialInterno.getLineaOut()[i].getNumCelular()).longValue());				
				lineasFacturacion.add(facturacionLinea);				
			}			
			facturacionVentaIn.setFacturacionLinea((WsFacturacionLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lineasFacturacion.toArray(), WsFacturacionLineaDTO.class));			
			facturacionVentaOut = ProcesoDeFacturacion( facturacionVentaIn, carDesManuales, 1);

			logger.debug("facturacionVentaOut.getResultadoTransaccion() ["+facturacionVentaOut.getResultadoTransaccion()+"]");

			if (facturacionVentaOut.getErrores() != null && facturacionVentaOut.getErrores().length > 0){
				for (int i= 0; i<facturacionVentaOut.getErrores().length; i++){
					logger.debug("wsAltaClienteOut ["+facturacionVentaOut.getErrores()[i].getMensajseError());
				} 
			}

			structuraComercialInterno.setProcesoFacturacion(facturacionVentaOut.getProceso());
			structuraComercialInterno.setResultadoTransaccion(facturacionVentaOut.getResultadoTransaccion());
			structuraComercialInterno.setErrores(facturacionVentaOut.getErrores());

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}

		return structuraComercialInterno;

	}




	private WsStructuraComercialInternoDTO CierreVentaQuioscoSoloAccesorios(WsCreaStructuraComercialInDTO wsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{

		WsCierreVentaInDTO cierreVenta = new WsCierreVentaInDTO();

		try{			
			cierreVenta.setIdentificadorTransaccion("1");
			cierreVenta.setMtoGarantia(new Float("0"));
			cierreVenta.setUsuario(wsCreaStructuraComercial.getUsuarioOracle());
			cierreVenta.setVenta(structuraComercialInterno.getNumVenta());
			logger.debug("TRAZADOR 144242 wsCreaStructuraComercial.getUsuarioOracle() ["+wsCreaStructuraComercial.getUsuarioOracle()+"]");
			logger.debug("TRAZADOR 144242 wsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length ["+wsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length+"]");
			logger.debug("TRAZADOR 144242 structuraComercialInterno.getNumVenta() ["+structuraComercialInterno.getNumVenta()+"]");
			logger.debug("TRAZADOR 144242 wsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor() ["+wsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor()+"]");
			
			getGestionDeCliente().setSalidaDefAccesorios(wsCreaStructuraComercial.getCuenta().getCliente().getAccesorios(), 
					wsCreaStructuraComercial.getUsuarioOracle(), 
					structuraComercialInterno.getNumVenta(),
					wsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor());

			GaVentasDTO gaVentas = new GaVentasDTO();
			gaVentas.setNumVenta(Long.valueOf(structuraComercialInterno.getNumVenta()));
			getGestionDeCliente().udpInterfazDeFacturación(gaVentas);


			structuraComercialInterno.setResultadoTransaccion("0");


		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}	
		return structuraComercialInterno;
	}

	private WsStructuraComercialInternoDTO CierreVentaQuiosco(WsCreaStructuraComercialInDTO wsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{

		CierreVentaOutDTO CierreVentaOut = null; 
		WsCierreVentaInDTO cierreVenta = new WsCierreVentaInDTO();

		try{			

			cierreVenta.setIdentificadorTransaccion("1");
			cierreVenta.setMtoGarantia(new Float("0"));
			cierreVenta.setUsuario(wsCreaStructuraComercial.getUsuarioOracle());
			cierreVenta.setVenta(structuraComercialInterno.getNumVenta());

			CierreVentaOut = cierreVenta(cierreVenta, 1);

			getGestionDeCliente().setSalidaDefAccesorios(wsCreaStructuraComercial.getCuenta().getCliente().getAccesorios(), 
					wsCreaStructuraComercial.getUsuarioOracle(), 
					structuraComercialInterno.getNumVenta(),
					wsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor());

			structuraComercialInterno.setResultadoTransaccion(CierreVentaOut.getResultadoTransaccion());
			structuraComercialInterno.setErrores(CierreVentaOut.getErrores());

		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			structuraComercialInterno.setResultadoTransaccion("1");
			context.setRollbackOnly();
		}

		return structuraComercialInterno;

	}	

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{
		DatosClienteDTO datosClienteDTO;  
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		logger.debug("clientePorNumeroCelular():start"); 		
		try{
			datosClienteDTO = getInventarioPortabilidad().clientePorNumeroCelular(numeroCelular);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			logger.debug("codigo de Error: "+ e.getCodigo());
			logger.debug("Mensaje de Error: "+ e.getDescripcionEvento());
			logger.debug("Numero de Evento: "+ e.getCodigoEvento());
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("clientePorNumeroCelular():end");
		return datosClienteDTO;	


	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListadoCategoriasClienteOutDTO getListCategorias() throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		WsListadoCategoriasClienteOutDTO resultado = new WsListadoCategoriasClienteOutDTO();
		try{
			resultado.setClienteDTOs(getInventarioPortabilidad().getListCategorias());
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		return resultado;
	}


	private ObtencionCargosDTO getObtencionCargos(ObtencionCargosDTO CargosLinea, CargosDescuentosManualesDTO[] carDesManuales)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

		CargosDTO CargoManual = null;
		CargosDTO[] resultado = null;
		DescuentoDTO descuento = null;
		AtributosCargoDTO AtributosCargo1 = null; 
		PrecioDTO PrecioCargo1 = null;
		AtributosMigracionDTO AtributosMigracion1 = null; 
		MonedaDTO monedaCargo1 = null;

		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO  artiAcce = null;

		ArrayList list = new ArrayList();
		ArrayList desc = new ArrayList();


		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	

			for (int i=0; i < CargosLinea.getCargos().length ;i++){
				list.add(CargosLinea.getCargos()[i]);						
			}

			if (carDesManuales != null){
				logger.debug("----------------------------------- Antes de Agregar Cargos y Descuentos de Accesorios--------------------------------" +carDesManuales.length );
				logger.debug("carDesManuales.length: ["+carDesManuales.length+"]");
				for(int j=0; j<carDesManuales.length; j++ ){
					descuento = new DescuentoDTO();
					CargoManual = new CargosDTO();
					AtributosCargo1 = new AtributosCargoDTO(); 
					PrecioCargo1 = new PrecioDTO();
					AtributosMigracion1 = new AtributosMigracionDTO(); 
					monedaCargo1 = new MonedaDTO();

					AtributosCargo1.setClaseProducto(1); // 1 bien 2 servicio

					AtributosCargo1.setNumAbonado(carDesManuales[j].getCargos().getNumAbonado());
					AtributosCargo1.setNumSerie(carDesManuales[j].getCargos().getNumSerie());
					AtributosCargo1.setNumTerminal(carDesManuales[j].getCargos().getNumTerminal());
					AtributosCargo1.setTipoProducto(Integer.parseInt(carDesManuales[j].getCargos().getTipoProducto()));

					PrecioCargo1.setCodigoConcepto(carDesManuales[j].getCargos().getCodigoConcepto());
					logger.debug("carDesManuales["+j+"].getCargos().getCodigoConcepto() ["+carDesManuales[j].getCargos().getCodigoConcepto()+"]");
					PrecioCargo1.setMonto(Float.parseFloat(carDesManuales[j].getCargos().getMonto() ));
					logger.debug("carDesManuales["+j+"].getCargos().getMonto() ["+carDesManuales[j].getCargos().getMonto()+"]");

					AtributosMigracion1.setCicloFacturacion(Integer.parseInt(carDesManuales[j].getCargos().getCicloFacturacion()));
					AtributosMigracion1.setClaseProducto(Integer.parseInt(carDesManuales[j].getCargos().getClaseProducto()));
					AtributosMigracion1.setCuotas(Integer.parseInt(carDesManuales[j].getCargos().getCuotas()));
					AtributosMigracion1.setInd_equipo(carDesManuales[j].getCargos().getInd_equipo());
					AtributosMigracion1.setInd_paquete(carDesManuales[j].getCargos().getInd_paquete());
					AtributosMigracion1.setTipoProducto(Integer.parseInt(carDesManuales[j].getCargos().getTipoProducto()));

					CargoManual.setCantidad(Integer.parseInt(carDesManuales[j].getCargos().getCantidad()));

					monedaCargo1.setCodigo(carDesManuales[j].getCargos().getCodigoMoneda());                                  

					PrecioCargo1.setDatosAnexos(AtributosMigracion1);
					PrecioCargo1.setUnidad(monedaCargo1);
					CargoManual.setAtributo(AtributosCargo1);
					CargoManual.setPrecio(PrecioCargo1);

					descuento.setCodigoConcepto(carDesManuales[j].getDescuento().getCodigoConceptoDescuento());
					descuento.setCodigoConceptoCargo(carDesManuales[j].getDescuento().getCodigoConceptoCargo());
					descuento.setCodigoMoneda(carDesManuales[j].getDescuento().getCodigoMoneda());
					descuento.setDescripcionConcepto(carDesManuales[j].getDescuento().getDescripcionConcepto());
					logger.debug("carDesManuales["+j+"].getDescuento().getDescripcionConcepto() ["+carDesManuales[j].getDescuento().getDescripcionConcepto()+"]");
					descuento.setMaxDescuento(0);
					descuento.setMinDescuento(0);
					descuento.setMonto(Float.parseFloat(carDesManuales[j].getDescuento().getMonto()));
					logger.debug("carDesManuales["+j+"].getDescuento().getMonto() ["+carDesManuales[j].getDescuento().getMonto()+"]");
					descuento.setMontoCalculado(0);
					descuento.setNumTransaccion(carDesManuales[j].getDescuento().getNumTransaccion());
					descuento.setTipo(carDesManuales[j].getDescuento().getTipo());
					descuento.setTipoAplicacion(carDesManuales[j].getDescuento().getTipoAplicacion());

					desc.add(descuento);
					CargoManual.setDescuento((DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(desc.toArray(), DescuentoDTO.class));

					list.add(CargoManual);										
				}	
				logger.debug("----------------------------------- Despues de Agregar Cargos y Descuentos de Accesorios--------------------------------");
			}

			resultado =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), CargosDTO.class);
			
			CargosLinea.setCargos(resultado);


			logger.debug("Fin: getObtencionCargos:end");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.debug("Fin:getObtencionCargos()");
		return CargosLinea;
	}	



	private WsStructuraComercialOutDTO CreaStructuraConCliente(WsCreaStructuraComercialInDTO WsCreaStructuraComercial) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

		logger.debug("++++++++++++++++++++++++++++++++++ start : CreaStructuraConCliente ++++++++++++++++++++++++++++++++++++++++++++");
		
		WsStructuraComercialInternoDTO structuraComercialInterno = new WsStructuraComercialInternoDTO();
		WsStructuraComercialOutDTO      CunetaAltaDeLineaOut      = new WsStructuraComercialOutDTO(); 				

		logger.debug("++++++++++++++++++++++++++++++++++ CreaDireccionQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
		structuraComercialInterno = CreaDireccionQuiosco(WsCreaStructuraComercial, structuraComercialInterno);			
		if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

			logger.debug("++++++++++++++++++++++++++++++++++ CreaCuentaSubCuentaQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
			structuraComercialInterno = CreaCuentaSubCuentaQuiosco(WsCreaStructuraComercial, structuraComercialInterno);
			if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

				logger.debug("++++++++++++++++++++++++++++++++++ CreaClienteQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
				structuraComercialInterno = CreaClienteQuiosco(WsCreaStructuraComercial, structuraComercialInterno);
				if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

					WsCreaStructuraComercial.getCuenta().getCliente().setCodigoCliente(structuraComercialInterno.getCodigoCliente());
					CunetaAltaDeLineaOut.setCodigoCliente(structuraComercialInterno.getCodigoCliente());

					logger.debug("++++++++++++++++++++++++++++++++++ CreaAltaDeLineaQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
					structuraComercialInterno = CreaAltaDeLineaQuiosco(WsCreaStructuraComercial,structuraComercialInterno);
					if (structuraComercialInterno.getResultadoTransaccion().equals("0")){							

						logger.debug("++++++++++++++++++++++++++++++++++ ObtenerCargosAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
						structuraComercialInterno = ObtenerCargosAccesorios(WsCreaStructuraComercial,structuraComercialInterno); 
						if (structuraComercialInterno.getResultadoTransaccion().equals("0")){
							
							logger.debug("----------------------------------------------------------- Despues de obtener los Cargos ------------------------------------------------------------------"); 
							for (int k=0; k<structuraComercialInterno.getCarDesManualesArray().length; k++  ){	
								logger.debug("getCargos().getCodigoArticulo() [" +structuraComercialInterno.getCarDesManualesArray()[k].getCargos().getCodigoArticulo()+"]");
								logger.debug("getCargos().getMonto() [" +structuraComercialInterno.getCarDesManualesArray()[k].getCargos().getMonto()+"]");
								logger.debug("getCargos().getCantidad [" +structuraComercialInterno.getCarDesManualesArray()[k].getCargos().getCantidad()+"]");
								logger.debug("getCargos().getCantidad [" +structuraComercialInterno.getCarDesManualesArray()[k].getDescuento().getMonto()+"]");																																			
							};
							
							logger.debug("----------------------------------------------------------- Antes de Prcesar Cargos de obtener los Cargos ------------------------------------------------------------------");

							structuraComercialInterno = ProcesoFacturacionQuiosco(WsCreaStructuraComercial,structuraComercialInterno, structuraComercialInterno.getCarDesManualesArray());
							if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

								structuraComercialInterno = CierreVentaQuiosco(WsCreaStructuraComercial,structuraComercialInterno);
								if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

									GaVentasDTO ventas = new GaVentasDTO();								
									
									ventas.setCodCliente(Long.valueOf(structuraComercialInterno.getCodigoCliente()));			
									ventas.setNumVenta(Long.valueOf(structuraComercialInterno.getNumVenta()));			
									ventas.setNomUsuarVta(WsCreaStructuraComercial.getUsuarioAD());
									logger.debug("++++++++++++++++++++++++++++++++++ Antes : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
									getInventarioPortabilidad().insertQuioscoVenta(ventas);
									logger.debug("++++++++++++++++++++++++++++++++++ Despues : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
									
									CunetaAltaDeLineaOut.setLineaOut(structuraComercialInterno.getLineaOut());
									CunetaAltaDeLineaOut.setNumVenta(structuraComercialInterno.getNumVenta());
									CunetaAltaDeLineaOut.setProcesoFacturacion(structuraComercialInterno.getProcesoFacturacion());
									
									//P-CSR-11002 - INI-01
									if(!"0".equals(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCategoriaCambio())){
									CategoriaCambioClienteDTO categCambioCliente =  new CategoriaCambioClienteDTO();
									categCambioCliente.setCodCategoriaCambio(Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCategoriaCambio()));
									categCambioCliente.setCodCliente(Long.parseLong(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente()));
									categCambioCliente.setNomUsuario(WsCreaStructuraComercial.getUsuarioOracle());
									getGestionDeCliente().insCategoriaCambioCliente(categCambioCliente);
									}
									//P-CSR-11002 - FIN-01
									
								}else{
									CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
									CunetaAltaDeLineaOut.setResultadoTransaccion("1");									
								}

							}else{
								CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
								CunetaAltaDeLineaOut.setResultadoTransaccion("1");
							}
						}else{
							CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
							CunetaAltaDeLineaOut.setResultadoTransaccion("1");
						}
					}else{
						CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
						CunetaAltaDeLineaOut.setResultadoTransaccion("1");														
					}
				}else{
					CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
					CunetaAltaDeLineaOut.setResultadoTransaccion("1");
				}
			}else{
				CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			}
		}else{
			CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
		}		

		logger.debug("++++++++++++++++++++++++++++++++++ end : CreaStructuraConCliente ++++++++++++++++++++++++++++++++++++++++++++");
		
		return CunetaAltaDeLineaOut;
	}	


	private WsStructuraComercialOutDTO CreaStructuraSinCliente(WsCreaStructuraComercialInDTO WsCreaStructuraComercial) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ start : CreaStructuraSinCliente ++++++++++++++++++++++++++++++++++++++++++++");

		WsStructuraComercialInternoDTO structuraComercialInterno = new WsStructuraComercialInternoDTO();
		WsStructuraComercialOutDTO      CunetaAltaDeLineaOut      = new WsStructuraComercialOutDTO(); 		
		CargosDescuentosManualesDTO[] carDesManuales = null;

		structuraComercialInterno.setCdogioCuenta(WsCreaStructuraComercial.getCuenta().getCodigoCuenta());
		structuraComercialInterno.setCodigoCliente(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente());
		structuraComercialInterno.setCodigoDireccion(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoDireccion());
		CunetaAltaDeLineaOut.setCodigoCliente(structuraComercialInterno.getCodigoCliente());

		logger.debug("++++++++++++++++++++++++++++++++++ CreaAltaDeLineaQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
		structuraComercialInterno = CreaAltaDeLineaQuiosco(WsCreaStructuraComercial,structuraComercialInterno);
		if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

			logger.debug("++++++++++++++++++++++++++++++++++ ObtenerCargosAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
			structuraComercialInterno = ObtenerCargosAccesorios(WsCreaStructuraComercial,structuraComercialInterno); 
			if (structuraComercialInterno.getResultadoTransaccion().equals("0")){			

				logger.debug("++++++++++++++++++++++++++++++++++ ProcesoFacturacionQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
				structuraComercialInterno = ProcesoFacturacionQuiosco(WsCreaStructuraComercial,structuraComercialInterno, structuraComercialInterno.getCarDesManualesArray());
				if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

					structuraComercialInterno = CierreVentaQuiosco(WsCreaStructuraComercial,structuraComercialInterno);
					if (structuraComercialInterno.getResultadoTransaccion().equals("0")){	

						GaVentasDTO ventas = new GaVentasDTO();								
											
						ventas.setCodCliente(Long.valueOf(structuraComercialInterno.getCodigoCliente()));			
						ventas.setNumVenta(Long.valueOf(structuraComercialInterno.getNumVenta()));			
						ventas.setNomUsuarVta(WsCreaStructuraComercial.getUsuarioAD());
						logger.debug("++++++++++++++++++++++++++++++++++ Antes : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
						getInventarioPortabilidad().insertQuioscoVenta(ventas);
						logger.debug("++++++++++++++++++++++++++++++++++ Despues : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");

						CunetaAltaDeLineaOut.setLineaOut(structuraComercialInterno.getLineaOut());
						CunetaAltaDeLineaOut.setNumVenta(structuraComercialInterno.getNumVenta());
						CunetaAltaDeLineaOut.setProcesoFacturacion(structuraComercialInterno.getProcesoFacturacion());
					}else{
						CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
						CunetaAltaDeLineaOut.setResultadoTransaccion("1");
					}
				}else{							
					CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
					CunetaAltaDeLineaOut.setResultadoTransaccion("1");
				}
			}else{							
				CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			}

		}else{
			CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");														
		}		
		logger.debug("++++++++++++++++++++++++++++++++++ End : CreaStructuraSinCliente ++++++++++++++++++++++++++++++++++++++++++++");
		return CunetaAltaDeLineaOut;
	}	

	private WsStructuraComercialOutDTO CreaStructuraSoloAccesorios(WsCreaStructuraComercialInDTO WsCreaStructuraComercial) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ start : CreaStructuraSoloAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
		WsStructuraComercialInternoDTO structuraComercialInterno = new WsStructuraComercialInternoDTO();
		WsStructuraComercialOutDTO      CunetaAltaDeLineaOut      = new WsStructuraComercialOutDTO(); 		
		CargosDescuentosManualesDTO[] carDesManuales = null;

		structuraComercialInterno.setCdogioCuenta(WsCreaStructuraComercial.getCuenta().getCodigoCuenta());
		structuraComercialInterno.setCodigoCliente(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente());
		structuraComercialInterno.setCodigoDireccion(WsCreaStructuraComercial.getCuenta().getCliente().getDireccion().getCodigoDireccion());

		try{
			logger.debug("paso 1 TRAZADOR 144242 ++++++++++++++++++++++++++++++++++ start : CreaAccesoriosQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
			structuraComercialInterno = CreaAccesoriosQuiosco(WsCreaStructuraComercial,structuraComercialInterno);
			if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

				logger.debug("paso 2 TRAZADOR 144242 ++++++++++++++++++++++++++++++++++ start : ObtenerCargosAccesorios ++++++++++++++++++++++++++++++++++++++++++++" + Long.valueOf(structuraComercialInterno.getNumVenta()));
				structuraComercialInterno = ObtenerCargosAccesorios(WsCreaStructuraComercial,structuraComercialInterno); 
				if (structuraComercialInterno.getResultadoTransaccion().equals("0")){			

					logger.debug("paso 3 TRAZADOR 144242 ++++++++++++++++++++++++++++++++++ start : registraCargoSoloAccesorios ++++++++++++++++++++++++++++++++++++++++++++" + Long.valueOf(structuraComercialInterno.getNumVenta()));				
					structuraComercialInterno = registraCargoSoloAccesorios(WsCreaStructuraComercial,structuraComercialInterno, structuraComercialInterno.getCarDesManualesArray());			
					if (structuraComercialInterno.getResultadoTransaccion().equals("0")){

						logger.debug("paso 4 TRAZADOR 144242 ++++++++++++++++++++++++++++++++++ start : CierreVentaQuiosco ++++++++++++++++++++++++++++++++++++++++++++" + Long.valueOf(structuraComercialInterno.getNumVenta()));
						structuraComercialInterno = CierreVentaQuioscoSoloAccesorios(WsCreaStructuraComercial,structuraComercialInterno);
						if (structuraComercialInterno.getResultadoTransaccion().equals("0"))
						{		

							GaVentasDTO ventas = new GaVentasDTO();

							ventas.setCodCliente(Long.valueOf(structuraComercialInterno.getCodigoCliente()));			
							ventas.setNumVenta(Long.valueOf(structuraComercialInterno.getNumVenta()));			
							ventas.setNomUsuarVta(WsCreaStructuraComercial.getUsuarioAD());
							logger.debug("TRAZADOR 144242 Long.valueOf(structuraComercialInterno.getNumVenta()) :" + Long.valueOf(structuraComercialInterno.getNumVenta()));
							logger.debug("++++++++++++++++++++++++++++++++++ Antes : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++" + Long.valueOf(structuraComercialInterno.getNumVenta()));
							getInventarioPortabilidad().insertQuioscoVenta(ventas);
							logger.debug("++++++++++++++++++++++++++++++++++ Despues : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++" + Long.valueOf(structuraComercialInterno.getNumVenta()));
							logger.debug("TRAZADOR 144242 structuraComercialInterno.getProcesoFacturacion() :" + structuraComercialInterno.getProcesoFacturacion());
							logger.debug("TRAZADOR 144242 structuraComercialInterno.getLineaOut() :" + structuraComercialInterno.getLineaOut());
							CunetaAltaDeLineaOut.setLineaOut(structuraComercialInterno.getLineaOut());
							CunetaAltaDeLineaOut.setNumVenta(structuraComercialInterno.getNumVenta());
							CunetaAltaDeLineaOut.setProcesoFacturacion(structuraComercialInterno.getProcesoFacturacion());

						}else{
							CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
							CunetaAltaDeLineaOut.setResultadoTransaccion("1");					   
						}
					}else{
						CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
						CunetaAltaDeLineaOut.setResultadoTransaccion("1");
					}
				}else{
					CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
					CunetaAltaDeLineaOut.setResultadoTransaccion("1");
				}
			}else{
				CunetaAltaDeLineaOut.setErrores(structuraComercialInterno.getErrores());
				CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			}

		}catch (GeneralException e) {
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

		}catch (Exception e) {
			CunetaAltaDeLineaOut.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
		}

		logger.debug("++++++++++++++++++++++++++++++++++ END : CreaStructuraSoloAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
		return CunetaAltaDeLineaOut;
	}	


	private WsStructuraComercialInternoDTO CreaAccesoriosQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ start : CreaAccesoriosQuiosco ++++++++++++++++++++++++++++++++++++++++++++");

		WsVentaAccesoriosDTO    ventaAccesorios    = new WsVentaAccesoriosDTO();
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO articulo = null;
		WsVentaAccesoriosOutDTO ventaAccesoriosOut = null;
		ArrayList list = new ArrayList();
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO[] Articulos = null;
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ClienteDTO cliente = new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ClienteDTO();

		try{
			ventaAccesorios.setCodModVenta(Integer.parseInt(config.getString("COD_MODVENTA")));
			ventaAccesorios.setCodVendedor(Long.parseLong(WsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor()));
			ventaAccesorios.setImpVenta(0);
			ventaAccesorios.setNombreUsuario(WsCreaStructuraComercial.getUsuarioOracle());

			logger.debug("WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length ["+WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length+"]");

			for (int i=0; i<WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length; i++){
				articulo = new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO();

				articulo.setCodArticulo(Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCodigoArticulo()));
				articulo.setCodbodega(Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCodBodega()));
				articulo.setCodUso(3);				
				articulo.setNumSerie(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getNumeroSerie());
				articulo.setNumUnidades(Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad()));
				list.add(articulo);
			}

			logger.debug("list accesorios ["+list.size()+"]");

			Articulos = (com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO.class);
			logger.debug("Articulos ["+Articulos+"]");
			ventaAccesorios.setArticulo(Articulos);

			logger.debug("ventaAccesoriosDTO.getArticulo().length ["+ventaAccesorios.getArticulo().length+"]");


			cliente.setCodCliente(Long.parseLong(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente()));			
			ventaAccesorios.setCliente(cliente);


			ventaAccesoriosOut = getInventarioPortabilidad().preVentaAccesorios(ventaAccesorios);

			structuraComercialInterno.setNumVenta( ventaAccesoriosOut.getVenta().getNumVenta());
			
			//TRAZADOR 144242 
			logger.debug("TRAZADOR 144242 ventaAccesoriosOut.getVenta().getNumVenta() ["+ventaAccesoriosOut.getVenta().getNumVenta()+"]");
			//TRAZADOR 144242 
		}catch (GeneralException e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}catch (Exception e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : CreaAccesoriosQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
		return structuraComercialInterno;

	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsStructuraComercialOutDTO AplicaPagoQuiosco(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialOutDTO WsStructuraComercialOut) 
	throws GeneralException, RemoteException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ Start : AplicaPagoQuiosco ++++++++++++++++++++++++++++++++++++++++++++");

		logger.debug("AplicaPagoQuiosco - Start");

		InfoFacturaDTO          infoFactura        = null;
		PagoDTO pago = new PagoDTO();
		Date fechaActual = new Date();
		FacturaVO factura = new FacturaVO();
		DetalleFacturaVO detalleFactura = null;
		DetalleFacturaVO[] detallesFactura = null;
		ArrayList lstDetalleFactura = new ArrayList();
		byte[] pdfAsBytes = null;
		String numeroCelular = null;

		try{

			CuentaComDTO cuenta = new CuentaComDTO();
			ClienteComDTO cliente = new ClienteComDTO();
			if(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente() != null && !WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente().equals("") && !WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente().equals("0")){
				cliente.setCodigoCliente(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente());
			}else{
				cliente.setCodigoCliente(WsStructuraComercialOut.getCodigoCliente());
			}

			cuenta.setClienteComDTO(cliente);
			cuenta = getGestionDeCliente().getcliente(cuenta);

			WsCreaStructuraComercial.getCuenta().getCliente().setNombreApeclien1(cuenta.getClienteComDTO().getNombreApellido1());
			WsCreaStructuraComercial.getCuenta().getCliente().setNombreApeclien2(cuenta.getClienteComDTO().getNombreApellido2());
			WsCreaStructuraComercial.getCuenta().getCliente().setNombreCliente(cuenta.getClienteComDTO().getNombreCliente());
			WsCreaStructuraComercial.getCuenta().getCliente().setNumeroIdent(cuenta.getClienteComDTO().getNumeroIdentificacion());
			WsCreaStructuraComercial.getCuenta().getCliente().setCodigoTipoIdent(cuenta.getClienteComDTO().getCodigoTipoIdentificacion());

			logger.debug("getInforCargos - Antes");
			infoFactura = getInventarioPortabilidad().getInforCargos(WsStructuraComercialOut.getNumVenta(), WsStructuraComercialOut.getProcesoFacturacion());
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("getInforCargos - despues");






			pago.setEmpRecaudadora(config.getString("EmpRecaudadora"));
			pago.setCodCajaRecauda(WsCreaStructuraComercial.getPago().getCodCajaQuiosco());//Pantalla
			pago.setServSolicitado(config.getString("ServSolicitado"));
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd HHmmss");
			pago.setFecEfectividad(dateFormat.format(fechaActual));//YYYYMMDD HH24MISS
			pago.setNumTransaccion(WsStructuraComercialOut.getNumVenta());
			pago.setNomUsuarOra(WsCreaStructuraComercial.getUsuarioOracle());
			pago.setTipTransaccion(config.getString("TipTransaccion")); //K
			pago.setSubTipoTransaccion(config.getString("SubTipTransaccion"));//O
			pago.setCodServicio(config.getString("CodServicio"));//2
			DateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd");
			pago.setNumEjercicio(dateFormat2.format(fechaActual));//Fecha contable YYYYMMDD
			pago.setCodCliente(cliente.getCodigoCliente());
			pago.setNumCelular("");		
			logger.debug("config.getString(SepDecimal) ["+config.getString("SepDecimal")+"]");
			logger.debug("infoFactura.getTotalAPagar() ["+infoFactura.getTotalAPagar().replace(".", config.getString("SepDecimal"))+"]");
			pago.setImportePago(infoFactura.getTotalAPagar().replace(".", config.getString("SepDecimal")));//Externo
			pago.setNumFolioCtc("");
			pago.setNumIdentificacion(WsCreaStructuraComercial.getCuenta().getCliente().getNumeroIdent());
			pago.setTipValor(WsCreaStructuraComercial.getPago().getSistemaPago().trim());//Sistema de PAgo
			//pago.setNumDocumento(WsCreaStructuraComercial.getPago().getNumCuentaCorriente().trim());//Numero de Factura
			if(WsCreaStructuraComercial.getPago().getNumDocumento() != null &&
			   WsCreaStructuraComercial.getPago().getNumDocumento().trim().length() >0){
				pago.setNumDocumento(WsCreaStructuraComercial.getPago().getNumDocumento().trim());
			}else{
				pago.setNumDocumento("");
			}

			pago.setCodBanco(WsCreaStructuraComercial.getPago().getCodBanco().trim());//Pantalla

			if (WsCreaStructuraComercial.getPago().getSistemaPago().trim().equals("3") ||  WsCreaStructuraComercial.getPago().getSistemaPago().trim().equals("12") ) {
				pago.setCodBanco(config.getString("BancoPorDefecto"));
			}

			//CSR-11002 INC-173004
			//si la forma de pago o sistema de pago es efectivo 1, se deja el banco en nulo
			if("1".equals(WsCreaStructuraComercial.getPago().getSistemaPago().trim()) ||
			   "4".equals(WsCreaStructuraComercial.getPago().getSistemaPago().trim())){
				pago.setCodBanco("");
			}
			//FIN CSR-11002 INC-173004
			
			//pago.setCtaCorriente("");//Pantalla
			if(WsCreaStructuraComercial.getPago().getNumCuentaCorriente() != null &&
			   WsCreaStructuraComercial.getPago().getNumCuentaCorriente().trim().length() > 0){
				pago.setCtaCorriente(WsCreaStructuraComercial.getPago().getNumCuentaCorriente());
			}else{
				pago.setCtaCorriente("");
			}
			
			if (WsCreaStructuraComercial.getUsuarioAD().length() > 10){
				pago.setCodAutoriza(WsCreaStructuraComercial.getUsuarioAD().substring(1, 10));
			}else{
				pago.setCodAutoriza(WsCreaStructuraComercial.getUsuarioAD());
			}

			pago.setNumTarjeta(WsCreaStructuraComercial.getPago().getNumTarjetaCredito().trim());//Pantalla
			pago.setCodOperacion(config.getString("CodOperacion"));//Garantía, Límite de consumo, etc
			pago.setNumVenta(WsStructuraComercialOut.getNumVenta());
			pago.setNumFolio(infoFactura.getNumFolio());//Folio Factura
			pago.setCodPlanSrv("");//NULL

			//INICIO CSR-11002
			pago.setDesAgencia(config.getString("DesAgencia"));
			pago.setCodTipTarjeta(WsCreaStructuraComercial.getPago().getCodTipTarjeta());
			//FIN CSR-11002
			
			if(WsCreaStructuraComercial.getPago().getAplicapago().booleanValue()){
				UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
				logger.debug("AplicaPago - Antes");
				pago =  getInventarioPortabilidad().AplicaPago(pago);
				UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
				logger.debug("AplicaPago - Despue");
			}

			
			logger.debug("infoFactura.getNumFolio() ["+infoFactura.getNumFolio()+"]");

			if (!infoFactura.getNumFolio().equals("0")){   
				factura.setCliente(WsCreaStructuraComercial.getCuenta().getCliente().getNombreCliente() + " " + WsCreaStructuraComercial.getCuenta().getCliente().getNombreApeclien1());
				logger.debug("factura.getCliente() ["+factura.getCliente()+"]");		
				
				if(WsStructuraComercialOut.getLineaOut() != null &&
					WsStructuraComercialOut.getLineaOut()[0] != null &&
					WsStructuraComercialOut.getLineaOut()[0].getNumCelular() != null){
					
					factura.setSoloAccesorios(new Boolean(false));
				
//					obtengo el numero de celular del primer abonado
					String numCelular = WsStructuraComercialOut.getLineaOut()[0].getNumCelular();
					
					//obtengo los datos del cliente asociado al numero de celular
					DatosClienteDTO datosClienteDTO = gestionDeVentaAccesoriosSRV.clientePorNumeroCelular(new Long(numCelular).longValue());
					
					factura.setTipoIdentificacion(datosClienteDTO.getDescipcionTipIdentif());
					logger.debug("factura.getTipoIdentificacion() ["+factura.getTipoIdentificacion()+"]");
					
					factura.setIdentificacion(datosClienteDTO.getNumIdent());
					logger.debug("factura.getIdentificacion() ["+factura.getIdentificacion()+"]");
				
					if(datosClienteDTO.getDireccionDTO().getNombreCalle() != null &&
					   datosClienteDTO.getDireccionDTO().getNumeroCalle() != null){
					
						factura.setDireccion(datosClienteDTO.getDireccionDTO().getNombreCalle() + ", " +
					             datosClienteDTO.getDireccionDTO().getNumeroCalle());
					}else{
						factura.setDireccion("");
					}
					logger.debug("factura.getDireccion() ["+factura.getDireccion()+"]");
				
					factura.setComuna(datosClienteDTO.getDireccionDTO().getDescripcionComuna());
					logger.debug("factura.getComuna() ["+factura.getComuna()+"]");
					
					factura.setCiudad(datosClienteDTO.getDireccionDTO().getDescripcionCiudad());
					logger.debug("factura.getCiudad() ["+factura.getCiudad()+"]");
					
					factura.setRegion(datosClienteDTO.getDireccionDTO().getDescripcionRegion());
					logger.debug("factura.getRegion() ["+factura.getRegion()+"]");
					
					//Inicio Inc. 177348 - 06/11/2011 -  FADL
					//factura.setCodCliente(WsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente());
					factura.setCodCliente(cliente.getCodigoCliente());
					logger.debug("factura.getCodCliente() ["+factura.getCodCliente()+"]");
					//Fin Inc. 177348 - 06/11/2011 -  FADL
					
				}else{
					
					factura.setSoloAccesorios(new Boolean(true));
				}
				
				
				factura.setNumFactura(infoFactura.getPrefPlaza()+" - "+infoFactura.getNumFolio());
				logger.debug("factura.getNumFactura() ["+factura.getNumFactura()+"]");
				
				factura.setNumPago(1);			
				logger.debug("factura.getNumPago() ["+factura.getNumPago()+"]");
				
				factura.setCajero("");			
				logger.debug("factura.getCajero() ["+factura.getCajero()+"]");
				
				factura.setCaja("");			
				logger.debug("factura.getCaja() ["+factura.getCaja()+"]");
				
				factura.setSubTotal(Float.valueOf(infoFactura.getTotalCargos()));
				logger.debug("factura.getSubTotal() ["+factura.getSubTotal()+"]");
				
				factura.setIva(Float.valueOf(infoFactura.getIva()));
				logger.debug("factura.getIva() ["+factura.getIva()+"]");
				
				factura.setOtrosCargos(Float.valueOf("0"));
				logger.debug("factura.getOtrosCargos ["+factura.getOtrosCargos()+"]");
				
				//factura.setCruzRoja(Float.valueOf(WsCreaStructuraComercial.getPago().getCodCajaQuiosco()));
				//logger.debug("factura.getCruzRoja() ["+factura.getCruzRoja()+"]");
				
				factura.setTotal(Float.valueOf(infoFactura.getTotalAPagar()));
				logger.debug("factura.getTotal() ["+factura.getTotal()+"]");	

				//Inicio Inc. 177348 - 06/11/2011 -  FADL
				factura.setCruzRoja(Float.valueOf(infoFactura.getImpCruzRoja().replace(",", config.getString("SepDecimal"))));
				logger.debug("factura.setCruzRoja ["+factura.getCruzRoja()+"]");
				
				factura.setNumero911(Float.valueOf(infoFactura.getImpNum911().replace(",", config.getString("SepDecimal"))));
				logger.debug("factura.setNumero911 ["+factura.getNumero911()+"]");
				
				factura.setImpuestoVenta(Float.valueOf(infoFactura.getImpVenta().replace(",", config.getString("SepDecimal"))));
				logger.debug("factura.setImpuestoVenta ["+factura.getImpuestoVenta()+"]");
				
				factura.setDescuento(Float.valueOf(infoFactura.getDescuentoTotal().replace(",", config.getString("SepDecimal"))));
				logger.debug("factura.setDescuento ["+factura.getDescuento()+"]");
				
				factura.setSerie(Integer.valueOf(infoFactura.getNumSerie()).intValue());
				logger.debug("factura.setSerie ["+factura.getSerie()+"]");
				//Fin Inc. 177348 - 06/11/2011 -  FADL 
				
				
				for(int i=0; i<infoFactura.getLisdetalleFactura().length; i++){
					detalleFactura = new DetalleFacturaVO();
					logger.debug("getSerieArticulo [" + infoFactura.getLisdetalleFactura()[i].getSerieArticulo() + "]");
					logger.debug("getNumVenta      [" + WsStructuraComercialOut.getNumVenta() + "]");
					numeroCelular = getInventarioPortabilidad().getNumCelularSeriePrepago(infoFactura.getLisdetalleFactura()[i].getSerieArticulo(), WsStructuraComercialOut.getNumVenta());

					detalleFactura.setDescripArticulo(infoFactura.getLisdetalleFactura()[i].getDescripArticulo());
					detalleFactura.setNumCantidad(infoFactura.getLisdetalleFactura()[i].getNumCantidad());
					
					if(numeroCelular != null){
						detalleFactura.setNumCelular(numeroCelular);
					}else{
						detalleFactura.setNumCelular("");
					}
					BigDecimal precioUnitario = null;
					
					if(infoFactura.getLisdetalleFactura()[i].getPrecioUnitario() != null){
						precioUnitario = new BigDecimal(infoFactura.getLisdetalleFactura()[i].getPrecioUnitario().toString());
					}else{
						precioUnitario = new BigDecimal("0");
					}
						 
					BigDecimal numCantidad = null;
					
					if(infoFactura.getLisdetalleFactura()[i].getNumCantidad() != null &&
							infoFactura.getLisdetalleFactura()[i].getNumCantidad().trim().length() >0){
						
						numCantidad = new BigDecimal(infoFactura.getLisdetalleFactura()[i].getNumCantidad());
						
					}else{
						numCantidad = new BigDecimal("0");
					}
					BigDecimal precioUnitarioFinal = precioUnitario.multiply(numCantidad);
					
					detalleFactura.setPrecioUnitario(Float.valueOf(precioUnitarioFinal.floatValue()));
					detalleFactura.setSerieArticulo(infoFactura.getLisdetalleFactura()[i].getSerieArticulo());
					detalleFactura.setDescuentoPrecio(infoFactura.getLisdetalleFactura()[i].getDescuentoPrecio());

					lstDetalleFactura.add(detalleFactura);
				}

				detallesFactura =(DetalleFacturaVO[]) ArrayUtl.copiaArregloTipoEspecifico(lstDetalleFactura.toArray(), DetalleFacturaVO.class);

				factura.setDetalleFacturaVO(detallesFactura);
				logger.debug("getFormFactura - Antes");
				pdfAsBytes = getInventarioPortabilidad().getFormFactura(factura);
				logger.debug("getFormFactura - despues");
				WsStructuraComercialOut.setPdfAsBytes(pdfAsBytes);

			}else{

				ArrayList lsitaerrores = new ArrayList();
				RetornoDTO error = new RetornoDTO();


				logger.debug("Error [98345873]");
				error.setCodError("98345873");
				if (WsCreaStructuraComercial.getPago().getAplicapago().booleanValue()){
					logger.debug("Problemas al generar la factura, se realizo el pago de $"+ factura.getTotal()+" Numero de venta ["+WsStructuraComercialOut.getNumVenta()+"]");
					error.setMensajseError("Problemas al generar la factura, se realizo el pago de $"+ factura.getTotal() +" Numero de venta ["+WsStructuraComercialOut.getNumVenta()+"]");	
				}else{
					logger.debug("Problemas al generar la factura, no se realizo el pago de $"+ factura.getTotal()+" Numero de venta ["+WsStructuraComercialOut.getNumVenta()+"]");
					error.setMensajseError("Problemas al generar la factura, no se realizo el pago de $"+ factura.getTotal()+" Numero de venta ["
							+WsStructuraComercialOut.getNumVenta()+"] \n" +"" );
				}
				
				lsitaerrores.add(error);
				RetornoDTO[] errores = (RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lsitaerrores.toArray(), RetornoDTO.class);											
				WsStructuraComercialOut.setErrores(errores);
				WsStructuraComercialOut.setResultadoTransaccion("1");
			}

		}catch (GeneralException e) {
			logger.error(e);
			e.printStackTrace();
			WsStructuraComercialOut.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
			WsStructuraComercialOut.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : AplicaPagoQuiosco ++++++++++++++++++++++++++++++++++++++++++++");
		return WsStructuraComercialOut;

	}	


	private WsStructuraComercialInternoDTO ObtenerCargosAccesorios(WsCreaStructuraComercialInDTO WsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno) 
	throws GeneralException, RemoteException{
		logger.debug("++++++++++++++++++++++++++++++++++ Start : ObtenerCargosAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
		PrecioCargoDTO[] cargoAccesorio = null;
		com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO[]   descuentosArt     = null;
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO ArticuloCargo = new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO();
		ArrayList Listacargos = new ArrayList();
		CargosDescuentosManualesDTO carDesManuales;
		CargosManualesDTO cargos;
		DescuentosManualesDTO descuento;
		CargosDescuentosManualesDTO[] carDesManualesArray;
		float totalCargoPorArticulo = 0;
		float totalDescuentoPorArticulo = 0;

		try{
			//TRAZADOR 144242 
			//logger.debug("TRAZADOR 144242 WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length ["+WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length+"]");
			//TRAZADOR 144242 
			if (WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios() != null && WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length > 0){
				logger.debug("TRAZADOR 144242 WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length ["+WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length+"]");
				for(int i=0; i<WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios().length; i++ ){

					ArticuloCargo = new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO();
					ArticuloCargo.setCodArticulo(Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCodigoArticulo()));
					cargoAccesorio = getInventarioPortabilidad().getPrecioCargoAccesorio(ArticuloCargo);
					descuentosArt     = getInventarioPortabilidad().getDescuentoAccesorio(ArticuloCargo);					
					if(cargoAccesorio != null && cargoAccesorio.length > 0){
						for(int j=0 ; j<cargoAccesorio.length ; j++){
							carDesManuales = new CargosDescuentosManualesDTO();
							cargos = new CargosManualesDTO();
							descuento = new DescuentosManualesDTO();


							cargos.setCantidad(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad());
							cargos.setCicloFacturacion(config.getString("CICLO_PREPAGO")); 
							cargos.setClaseProducto("1");
							cargos.setCodigoArticulo(cargoAccesorio[j].getCodigoArticulo());
							cargos.setCodigoConcepto(cargoAccesorio[j].getCodigoConcepto());
							cargos.setCodigoMoneda(cargoAccesorio[j].getCodigoMoneda());
							cargos.setCuotas("0");
							cargos.setInd_equipo(cargoAccesorio[j].getIndicadorEquipo());
							cargos.setInd_paquete(cargoAccesorio[j].getIndicadorPaquete());


							logger.debug("cargoAccesorio[j].getMonto() ["+cargoAccesorio[j].getMonto()+"]  ObtenerCargosAccesorios");
							logger.debug("WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad() ["+WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad()+"]  ObtenerCargosAccesorios");
							totalCargoPorArticulo = cargoAccesorio[j].getMonto() * Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad()) ;
							logger.debug("totalPorArticulo ["+totalCargoPorArticulo+"]");

							cargos.setMonto(String.valueOf(totalCargoPorArticulo));
							logger.debug("cargos.getMonto() ["+cargos.getMonto()+"]  ObtenerCargosAccesorios");


							cargos.setNumAbonado("");
							cargos.setNumSerie(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getNumeroSerie());
							cargos.setNumTerminal("");
							cargos.setTipoProducto("1");

							descuento.setCodigoConceptoCargo(cargoAccesorio[j].getCodigoConcepto());
							descuento.setCodigoConceptoDescuento(descuentosArt[j].getCodigoConcepto());
							descuento.setCodigoMoneda(cargoAccesorio[j].getCodigoMoneda());
							descuento.setDescripcionConcepto(descuentosArt[j].getDescripcionConcepto());

							logger.debug("descuentosArt[j].getMonto() ["+descuentosArt[j].getMonto()+"]   ObtenerCargosAccesorios");
							logger.debug("WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad() ["+WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad()+"]  ObtenerCargosAccesorios");

							totalDescuentoPorArticulo = descuentosArt[j].getMonto() * Integer.parseInt(WsCreaStructuraComercial.getCuenta().getCliente().getAccesorios()[i].getCantidad());
							logger.debug("totalDescuentoPorArticulo ["+totalDescuentoPorArticulo+"]  ObtenerCargosAccesorios");

							descuento.setMonto(String.valueOf(totalDescuentoPorArticulo));
							logger.debug("descuento.getMonto() ["+descuento.getMonto()+"]  ObtenerCargosAccesorios");


							descuento.setNumTransaccion("");
							descuento.setTipo(descuentosArt[j].getTipo());
							descuento.setTipoAplicacion(descuentosArt[j].getTipoAplicacion());

							carDesManuales.setCargos(cargos);
							carDesManuales.setDescuento(descuento);

							Listacargos.add(carDesManuales);
						}
					}
				}							
			}


			carDesManualesArray = (CargosDescuentosManualesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(Listacargos.toArray(), CargosDescuentosManualesDTO.class);			
			structuraComercialInterno.setCarDesManualesArray(carDesManualesArray);


		}catch (GeneralException e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}catch (Exception e) {
			structuraComercialInterno.setResultadoTransaccion("1");
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : ObtenerCargosAccesorios ++++++++++++++++++++++++++++++++++++++++++++");
		return structuraComercialInterno;

	}	

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListadoTiposIdentificacionOutDTO getTiposIdentificacion()throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
		logger.debug("++++++++++++++++++++++++++++++++++ Start : getTiposIdentificacion ++++++++++++++++++++++++++++++++++++++++++++");
		WsListadoTiposIdentificacionOutDTO resultado = new WsListadoTiposIdentificacionOutDTO() ;
		try{
			resultado.setIdentificadorCivilDTOs(getInventarioPortabilidad().getTiposIdentificacion());
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : getTiposIdentificacion ++++++++++++++++++++++++++++++++++++++++++++");
		return resultado;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public TipificaClientizaDTO[] recuperaArrayTipificacion() throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ Start : recuperaArrayTipificacion ++++++++++++++++++++++++++++++++++++++++++++");
		TipificaClientizaDTO[] tipificaClientizaDTO = null;

		try{
			tipificaClientizaDTO = getInventarioPortabilidad().recuperaArrayTipificacion();
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : recuperaArrayTipificacion ++++++++++++++++++++++++++++++++++++++++++++");
		return tipificaClientizaDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void updateTipificacion(TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("++++++++++++++++++++++++++++++++++ Start : updateTipificacion ++++++++++++++++++++++++++++++++++++++++++++");
		try{
			getInventarioPortabilidad().updateTipificacion(tipificaClientizaDTO);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("++++++++++++++++++++++++++++++++++ End : updateTipificacion ++++++++++++++++++++++++++++++++++++++++++++");

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void insertTipificacion(TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException{

		try{
			getInventarioPortabilidad().insertTipificacion(tipificaClientizaDTO);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void deleteTipificacion(Long codArticulo) throws GeneralException{

		try{
			getInventarioPortabilidad().deleteTipificacion(codArticulo);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendaDTO) throws GeneralException{

		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;

		try{
			wsInsertTiendaOutDTO = getInventarioPortabilidad().insertTienda(tiendaDTO);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

		return wsInsertTiendaOutDTO;

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public TiendaDTO[] obtieneListaTienda() throws GeneralException{

		TiendaDTO[] tiendaDTO = null;

		try{
			tiendaDTO = getInventarioPortabilidad().obtieneListaTienda();
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

		return tiendaDTO;

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public WsUpdateTiendaOutDTO updateTienda(TiendaDTO tiendaModDTO) throws GeneralException{
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;
		try{
			wsUpdateTiendaOutDTO = getInventarioPortabilidad().updateTienda(tiendaModDTO);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

		return wsUpdateTiendaOutDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws GeneralException 
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void deleteTienda(Long codTienda) throws GeneralException{

		try{
			getInventarioPortabilidad().deleteTienda(codTienda);
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));				
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw new GeneralException(e);
		}

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
	public WsListadoRegionesOutDTO getListadoRegionesQuiosco() throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		WsListadoRegionesOutDTO regiones = new WsListadoRegionesOutDTO();;
		try{
			regiones.setRegionDTOs(getGestionDeDirecciones().getListadoRegiones());
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return regiones;
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
	public WsListadoProvinciasOutDTO getListadoProvinciasQuiosco(RegionDTO region) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		WsListadoProvinciasOutDTO provincias = new WsListadoProvinciasOutDTO();
		try{			                                       
			provincias.setProvinciaDTOs(getGestionDeDirecciones().getListadoProvincias(region));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return provincias;
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
	public WsListadoCiudadesOutDTO getListadoCiudaddesQuiosco(ProvinciaDTO provincia) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		WsListadoCiudadesOutDTO ciudades = new WsListadoCiudadesOutDTO();
		try{
			ciudades.setCiudadDTOs(getGestionDeDirecciones().getListadoCiudaddes(provincia));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudades;
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
	public WsListadoComunasOutDTO getListadoComunasQuiosco(CiudadDTO ciudad) throws GeneralException{		 
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCiudad()");
		WsListadoComunasOutDTO comunas = new WsListadoComunasOutDTO();
		try{
			comunas.setComunaSPNDTOs(getGestionDeDirecciones().getListadoComunas(ciudad));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return comunas;
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
	public float getImpuesto(String codigoVendedor)throws GeneralException {
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		float impuesto = 0;
		try{
			logger.debug("SpnSclORQBean: getImpuesto:start");
			impuesto=getInventarioPortabilidad().getImpuesto(codigoVendedor);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getImpuesto:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return impuesto;
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
	public String getZip(DireccionDTO direccion)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		String zip = null;
		try{
			logger.debug("SpnSclORQBean: getZip:start");
			zip=getInventarioPortabilidad().getZip(direccion);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getZip:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return zip;
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
	public WsCajaOutDTO getListaCaja(String codOficina)throws GeneralException{		
		WsCajaOutDTO cajaOutDTO = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		try{
			logger.debug("SpnSclORQBean: getListaCaja:start");
			cajaOutDTO=getInventarioPortabilidad().getListaCaja(codOficina);
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListaCaja:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return cajaOutDTO;
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
	public WSCentralQuioscoOutDTO getCentralesQuiosco()
	throws GeneralException{
		WSCentralQuioscoOutDTO resultado = null;
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("Inicio:getCentralesQuiosco()");	
		try{
			resultado =   getInventarioPortabilidad().getCentralesQuiosco();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}

		logger.debug("Fin:getCentralesQuiosco()");
		return resultado;
	}


	private WsStructuraComercialInternoDTO registraCargoSoloAccesorios(WsCreaStructuraComercialInDTO wsCreaStructuraComercial, WsStructuraComercialInternoDTO structuraComercialInterno, CargosDescuentosManualesDTO[] carDesManuales)
	throws GeneralException{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));		
		WsFacturacionVentaInDTO  facturacionVentaIn  = new WsFacturacionVentaInDTO();     
		ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
		ParametrosRegistrarCargosDTO registroCargos = new ParametrosRegistrarCargosDTO();
		ResultadoRegCargosDTO        resultadoRegistroCargos = new ResultadoRegCargosDTO();
		try{
			logger.debug("SpnSclORQBean: getListaCaja:start");

			obtencionCargos = getObCargoSoloAccesorios(carDesManuales);			
			registroCargos = llenarRegCargosSoloAccesorio(wsCreaStructuraComercial, obtencionCargos.getCargos(),structuraComercialInterno);

			registroCargos.setUsuario(wsCreaStructuraComercial.getUsuarioOracle());
			logger.debug("registroCargos.getCargos() ["+registroCargos.getCargos().length+"]-------------");

			//registroCargos.setCargos(registroCargos.getCargos());

			RegistroVentaDTO registroVentaDTO= new RegistroVentaDTO();
			registroVentaDTO.setCodigoSecuencia(config.getString("codigo.secuencia.famensajes"));
			registroVentaDTO=this.getSecuencia(registroVentaDTO);

			for (int k = 0; k<registroCargos.getCargos().length; k++){
				if (registroCargos.getCargos()[k].getDescuento() != null){
					logger.debug("parametrosRegistrarCargosDTO.getCargos()[k].getPrecio() ["+registroCargos.getCargos()[k].getPrecio().getMonto() +"]");  
					for(int i =0 ; i<registroCargos.getCargos()[k].getDescuento().length; i++){
						if (registroCargos.getCargos()[k].getDescuento()[i] != null && registroCargos.getCargos()[k].getDescuento()[i].getMonto() > 0){
							logger.debug("parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getTipoAplicacion() ["+registroCargos.getCargos()[k].getDescuento()[i].getTipoAplicacion()+"]");
							logger.debug("parametrosRegistrarCargosDTO.getCargos()[k].getDescuento()[i].getMonto() ["+registroCargos.getCargos()[k].getDescuento()[i].getMonto()+"]");
						}
					}
				}
			}

			resultadoRegistroCargos=this.registrarCargos(registroCargos);


			//TODO: se Actualiza la ga_equipaboser
			//TODO: se Actualiza en la GA_VENTAS
			GaVentasDTO gaVentasDTO= new GaVentasDTO();
			long numeroventa=new Long(structuraComercialInterno.getNumVenta()).longValue();
			numeroventa= Long.parseLong(structuraComercialInterno.getNumVenta());
			gaVentasDTO.setNumVenta(new Long((numeroventa)));
			gaVentasDTO = getGestionDeCliente().getVenta(gaVentasDTO);

			gaVentasDTO.setImpVenta(Float.valueOf(String.valueOf(resultadoRegistroCargos.getTotalCargos()+resultadoRegistroCargos.getTotalImpuestos()+resultadoRegistroCargos.getTotalDescuentos())));
			gaVentasDTO.setTipValor("1");
			gaVentasDTO.setIndEstVenta("VF");
			if (ModalidadRegaloFac.equals("5")){
				gaVentasDTO.setCodModVenta(new Long(ModalidadRegaloFac));
			}															
			getGestionDeCliente().getUpdateGaVentaEscB(gaVentasDTO);
			String numProceso=resultadoRegistroCargos.getNumeroProceso();
			numProceso=numProceso==null||"".equals(numProceso)?"0":numProceso;

			structuraComercialInterno.setProcesoFacturacion(numProceso);

			String numCorrMensaje=String.valueOf(registroVentaDTO.getNumeroTransaccionVenta());

			FaMensProcesoDTO faMensProcesoDTO=new FaMensProcesoDTO();
			faMensProcesoDTO.setNumProceso(Long.parseLong(numProceso));
			faMensProcesoDTO.setCodOrigen("FA");
			faMensProcesoDTO.setIndFacturado("I");
			faMensProcesoDTO.setFecIngreso(new Timestamp(System.currentTimeMillis()));
			faMensProcesoDTO.setDescMensaje("");
			faMensProcesoDTO.setNumLineas(1);
			faMensProcesoDTO.setNomUsuario(wsCreaStructuraComercial.getUsuarioOracle());
			faMensProcesoDTO.setCodBloque(1);
			faMensProcesoDTO.setCodFormulario(1);
			faMensProcesoDTO.setCorrMensaje(Long.parseLong(numCorrMensaje));

			RetornoDTO retValue = getGestionDeCliente().setObservacionFactura(faMensProcesoDTO);

			GaVentasDTO gaVentas = new GaVentasDTO();
			gaVentas.setNumVenta(Long.valueOf(numeroventa));
			getGestionDeCliente().udpInterfazDeFacturación(gaVentas);

			structuraComercialInterno.setProcesoFacturacion(numProceso);

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListaCaja:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return structuraComercialInterno;
	}

	private ObtencionCargosDTO getObCargoSoloAccesorios(CargosDescuentosManualesDTO[] carDesManuales)throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		logger.debug("---------------------------------------------Start : getObCargoSoloAccesorios-----------------------------------------------");
		CargosDTO CargoManual = null;
		CargosDTO[] resultado = null;
		DescuentoDTO descuento = null;
		AtributosCargoDTO AtributosCargo1 = null; 
		PrecioDTO PrecioCargo1 = null;
		AtributosMigracionDTO AtributosMigracion1 = null; 
		MonedaDTO monedaCargo1 = null;
		ObtencionCargosDTO CargosLinea = new ObtencionCargosDTO(); 
		com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO  artiAcce = null;

		ArrayList list = new ArrayList();;
		ArrayList desc = null;


		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	


			if (carDesManuales != null){
				logger.debug("carDesManuales.length ["+carDesManuales.length+"]");
				for(int j=0; j<carDesManuales.length; j++ ){

					desc = new ArrayList();					
					CargoManual = new CargosDTO();
					AtributosCargo1 = new AtributosCargoDTO(); 
					PrecioCargo1 = new PrecioDTO();
					AtributosMigracion1 = new AtributosMigracionDTO(); 
					monedaCargo1 = new MonedaDTO();
					descuento = new DescuentoDTO();

					AtributosCargo1.setClaseProducto(1); // 1 bien 2 servicio

					AtributosCargo1.setNumAbonado(carDesManuales[j].getCargos().getNumAbonado());
					logger.debug("carDesManuales[j].getCargos().getNumAbonado() ["+carDesManuales[j].getCargos().getNumAbonado()+"]");
					AtributosCargo1.setNumSerie(carDesManuales[j].getCargos().getNumSerie());
					logger.debug("carDesManuales[j].getCargos().getNumSerie() ["+carDesManuales[j].getCargos().getNumSerie()+"]");
					AtributosCargo1.setNumTerminal(carDesManuales[j].getCargos().getNumTerminal());
					logger.debug("carDesManuales[j].getCargos().getNumTerminal() ["+carDesManuales[j].getCargos().getNumTerminal()+"]");
					AtributosCargo1.setTipoProducto(Integer.parseInt(carDesManuales[j].getCargos().getTipoProducto()));

					PrecioCargo1.setCodigoConcepto(carDesManuales[j].getCargos().getCodigoConcepto());

					logger.debug("carDesManuales[j].getCargos().getMonto() ["+carDesManuales[j].getCargos().getMonto() +"]");
					PrecioCargo1.setMonto(Float.parseFloat(carDesManuales[j].getCargos().getMonto() ));
					logger.debug("PrecioCargo1.getMonto() ["+PrecioCargo1.getMonto() +"]");


					AtributosMigracion1.setCicloFacturacion(Integer.parseInt(carDesManuales[j].getCargos().getCicloFacturacion()));
					logger.debug("AtributosMigracion1.getCicloFacturacion() ["+AtributosMigracion1.getCicloFacturacion()+"]");

					AtributosMigracion1.setClaseProducto(Integer.parseInt(carDesManuales[j].getCargos().getClaseProducto()));
					AtributosMigracion1.setCuotas(Integer.parseInt(carDesManuales[j].getCargos().getCuotas()));
					AtributosMigracion1.setInd_equipo(carDesManuales[j].getCargos().getInd_equipo());
					AtributosMigracion1.setInd_paquete(carDesManuales[j].getCargos().getInd_paquete());
					AtributosMigracion1.setTipoProducto(Integer.parseInt(carDesManuales[j].getCargos().getTipoProducto()));

					CargoManual.setCantidad(Integer.parseInt(carDesManuales[j].getCargos().getCantidad()));

					monedaCargo1.setCodigo(carDesManuales[j].getCargos().getCodigoMoneda());                                  

					PrecioCargo1.setDatosAnexos(AtributosMigracion1);
					PrecioCargo1.setUnidad(monedaCargo1);
					CargoManual.setAtributo(AtributosCargo1);
					CargoManual.setPrecio(PrecioCargo1);

					descuento.setCodigoConcepto(carDesManuales[j].getDescuento().getCodigoConceptoDescuento());
					logger.debug("descuento.getCodigoConcepto() ["+descuento.getCodigoConcepto()+"]");
					descuento.setCodigoConceptoCargo(carDesManuales[j].getDescuento().getCodigoConceptoCargo());
					logger.debug("descuento.getCodigoConceptoCargo() ["+descuento.getCodigoConceptoCargo()+"]");
					descuento.setCodigoMoneda(carDesManuales[j].getDescuento().getCodigoMoneda());
					logger.debug("descuento.getCodigoMoneda() ["+descuento.getCodigoMoneda()+"]");
					descuento.setDescripcionConcepto(carDesManuales[j].getDescuento().getDescripcionConcepto());
					logger.debug("descuento.getDescripcionConcepto() ["+descuento.getDescripcionConcepto()+"]");
					descuento.setMaxDescuento(0);
					descuento.setMinDescuento(0);
					descuento.setMonto(Float.parseFloat(carDesManuales[j].getDescuento().getMonto()));
					logger.debug("descuento.getMonto() ["+descuento.getMonto()+"]");
					descuento.setMontoCalculado(0);
					descuento.setNumTransaccion(carDesManuales[j].getDescuento().getNumTransaccion());
					logger.debug("descuento.getNumTransaccion() ["+descuento.getNumTransaccion()+"]");
					descuento.setTipo(carDesManuales[j].getDescuento().getTipo());
					logger.debug("descuento.getTipo() ["+descuento.getTipo()+"]");
					descuento.setTipoAplicacion(carDesManuales[j].getDescuento().getTipoAplicacion());
					logger.debug("descuento.getTipoAplicacion() ["+descuento.getTipoAplicacion()+"]");
					desc.add(descuento);

					CargoManual.setDescuento((DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(desc.toArray(), DescuentoDTO.class));

					list.add(CargoManual);										
				}				
			}

			resultado =(CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), CargosDTO.class);

			logger.debug("Cargos Encontrados -------["+resultado.length+"]------------------");

			CargosLinea.setCargos(resultado);


			if (resultado != null){
				for (int i=0; i<resultado.length;i++){
					logger.debug("resultado[i].getPrecio().getMonto() ["+resultado[i].getPrecio().getMonto()+"]");
					if (resultado[i].getDescuento() != null){
						for (int j=0; j<resultado[i].getDescuento().length;j++){							
							logger.debug("resultado[i].getDescuento()[j].getMonto() ["+resultado[i].getDescuento()[j].getMonto()+"]");
						}
					}
				}							
			}


			logger.debug("Fin: getObtencionCargos:end");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.debug("Fin:getObtencionCargos()");
		logger.debug("---------------------------------------------Start : getObCargoSoloAccesorios-----------------------------------------------");		
		return CargosLinea;		
	}	

	private ParametrosRegistrarCargosDTO llenarRegCargosSoloAccesorio(WsCreaStructuraComercialInDTO wsCreaStructuraComercial, CargosDTO[] cargosDTO,  WsStructuraComercialInternoDTO structuraComercialInterno)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		ParametrosRegistrarCargosDTO retValue=new ParametrosRegistrarCargosDTO();
		try{
			retValue.setCargos(cargosDTO);			
			long numTransaccionVenta=0;//Esto Consultar si se ejecuta un nueva llamada a Transacabo

			long numVenta = new Long(structuraComercialInterno.getNumVenta()).longValue();

			logger.debug("llenarRegCargosSoloAccesorio numVenta ["+numVenta+"]");

			RegistroVentaDTO registroVentaDTO= new RegistroVentaDTO();
			registroVentaDTO.setCodigoSecuencia(config.getString("codigo.secuencia.transacabo"));
			registroVentaDTO=this.getSecuencia(registroVentaDTO);
			numTransaccionVenta=registroVentaDTO.getNumeroTransaccionVenta();


			String codVendedor=String.valueOf(wsCreaStructuraComercial.getCuenta().getCliente().getActivacion().getAntecedentesVenta().getCodigoVendedor());
			//Realizamos consulta para obtener el plan comercial del cliente
			ClienteDTO clienteDTO=new ClienteDTO();
			clienteDTO.setCodigoCliente(String.valueOf(wsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente()));
			clienteDTO =this.getPlanComercial(clienteDTO);
			String planComercialCliente=clienteDTO.getPlanComercial();
			clienteDTO=this.getCategoriaTributariaCliente(clienteDTO);
			String categTributaria="FACTURA".equals(clienteDTO.getCategoriaTributaria())?"F":"B";
			VendedorDTO vendedorDTO= new VendedorDTO();
			vendedorDTO.setCodigoVendedor(codVendedor);
			vendedorDTO.setCodigoVendedorDealer(0);
			vendedorDTO=this.getVendedor(vendedorDTO);
			String codOficinaVendedor=vendedorDTO.getCodigoOficina();
			long codVendedorRaiz=vendedorDTO.getCodigoVendedorRaiz();
			int codCiclo=25;
			long codModalidadPago=1;


			//String codDocumento=01;

			retValue.setCodCliente(Long.parseLong(wsCreaStructuraComercial.getCuenta().getCliente().getCodigoCliente()));
			retValue.setNumVenta(numVenta);
			retValue.setNumTransaccionVenta(numTransaccionVenta);
			retValue.setPlanComercialCliente(planComercialCliente);//GA_CLIENTE_PCOM
			retValue.setCodOficinaVendedor(codOficinaVendedor);
			retValue.setCategTributaria(categTributaria);
			retValue.setCodDocumento(1);
			retValue.setTipoFoliacion("A");
			retValue.setCodModalidadPago(String.valueOf(codModalidadPago));
			retValue.setFacturaACiclo(false);  // false para factura inmediata, True para factura aciclo
			retValue.setCodVendedor(Long.parseLong(codVendedor));
			retValue.setCodVendedorRaiz(codVendedorRaiz);
			retValue.setCodCiclo(codCiclo);

			//retValue.setPlanComercialCliente("");
		}
		catch(GeneralException e){
			logger.debug("GeneralException");
			throw(e);
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new GeneralException(e);		
		}

		return retValue;
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
	public  AltaDeLineaBusitoOutDTO AltaDeLineaBusito(AltaDeLineaBusitoInDTO altaDeLineaBusitoIn)
	throws GeneralException{
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
		WsCunetaAltaDeLineaDTO cunetaAltaDeLinea = new WsCunetaAltaDeLineaDTO();
		WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
		AltaDeLineaBusitoOutDTO altaDeLineaBusitoOut = new AltaDeLineaBusitoOutDTO();
		RetornoDTO[] errores = null;
		RetornoDTO error = null;
		ArrayList listErrores = new ArrayList();
		try{

			CuentaComDTO cuenta = new CuentaComDTO();
			ClienteComDTO cliente = new ClienteComDTO();

			cliente.setCodigoCliente(altaDeLineaBusitoIn.getCodigoCliente());
			cuenta.setClienteComDTO(cliente);


			cuenta = getGestionDeCliente().getcliente(cuenta);

			cunetaAltaDeLinea.setCodigoDeCliente(cuenta.getClienteComDTO().getCodigoCliente());
			cunetaAltaDeLinea.setCodigoDeCuenta(cuenta.getCodigoCuenta());
			cunetaAltaDeLinea.setIdentificadorTransaccion("1");
			cunetaAltaDeLinea.setNomUsuarioOra(altaDeLineaBusitoIn.getNomUsuario());

			WsActivacionLineaDTO activacionLinea = new WsActivacionLineaDTO();
			WsAntecedentesVentaInDTO antecedentesVentaIn = new WsAntecedentesVentaInDTO();
			
			/*logger.debug("****************INICIO INCIDENCIA 150560 GDO 22-11-2010****************");*/
			antecedentesVentaIn.setCodigoDealer("-1");
			logger.debug("********************** GDO Codigo VenDealer ["+antecedentesVentaIn.getCodigoDealer()+"]");
			/*logger.debug("****************FIN INCIDENCIA 150560 GDO 22-11-2010****************");*/
			antecedentesVentaIn.setCodigoVendedor(altaDeLineaBusitoIn.getCodigoVendedor());
			antecedentesVentaIn.setCodigoModalidadVenta(config.getString("cod.modventa.busito"));
			antecedentesVentaIn.setCodigoReserva("");
			antecedentesVentaIn.setCodigoTipoContrato(config.getString("cod.tip.contrato.busito"));
			antecedentesVentaIn.setCuotas("");			
			activacionLinea.setAntecedentesVenta(antecedentesVentaIn);

			WsLineaInDTO[] lineas = null;
			WsLineaInDTO   linea = new WsLineaInDTO();

			linea.setCodigoOperador("");

			WsDatosPlanTerifarioInDTO datosPlanTerifario = new WsDatosPlanTerifarioInDTO(); 
			datosPlanTerifario.setPlanTarifario(config.getString("planTarifario.prepago.busito"));		    
			linea.setDatosPlanTerifario(datosPlanTerifario);

			WsHomeLineaInDTO homeLineaIn = new WsHomeLineaInDTO();
			homeLineaIn.setCelda(config.getString("celda.busito"));
			homeLineaIn.setCodigCentral(config.getString("central.busito"));
			linea.setHomeLinea(homeLineaIn);


			TipificacionDTO[] tipificacion = null; 
			tipificacion = recuperaDatoTipificacion(altaDeLineaBusitoIn.getNumeroSerieKit(), altaDeLineaBusitoIn.getCodigoVendedor());						

			WsSimcardInDTO simcard = new WsSimcardInDTO();
			WsTerminalInDTO terminal = new WsTerminalInDTO();
			
			
//			INCIDENCIA 144720 GDO
			logger.debug("tipificacion.length ["+tipificacion.length+"]");
			for (int i=0;i<tipificacion.length;i++){
				logger.debug("tipificacion["+i+"].getCodArticulo() ["+tipificacion[i].getCodArticulo()+"]");
				logger.debug("tipificacion["+i+"].getDescripArticulo() ["+tipificacion[i].getDescripArticulo()+"]");
				logger.debug("tipificacion["+i+"].getNumCelular() ["+tipificacion[i].getNumCelular()+"]");
				logger.debug("tipificacion["+i+"].getNumSerie() ["+tipificacion[i].getNumSerie()+"]");
				logger.debug("tipificacion["+i+"].getTipTerminal()() ["+tipificacion[i].getTipTerminal()+"]");				
			}
//			INCIDENCIA 144720 GDO

			if ("3".equals(String.valueOf(tipificacion.length))){
				logger.debug("+++++++++++++++++++++++++++++++ES KIT+++++++++++++++++++++++++++++++");
				for (int i=1;i<tipificacion.length;i++){
					logger.debug("tipificacion[i].getTipTerminal() ["+tipificacion[i].getTipTerminal()+"]");
					if (tipificacion[i].getTipTerminal().equals("G")){
						simcard.setNumeroSerie(tipificacion[i].getNumSerie());
						terminal.setMin(tipificacion[i].getNumCelular());
					}else if(tipificacion[i].getTipTerminal().equals("T")){
						terminal.setNumImei(tipificacion[i].getNumSerie());
					}		    			    
				}
			}
			else if ("1".equals(String.valueOf(tipificacion.length))){
				logger.debug("+++++++++++++++++++++++++++++++ES SIMCARD+++++++++++++++++++++++++++++++");
				for (int i=0;i<tipificacion.length;i++){ 
					if (tipificacion[i].getTipTerminal().equals("G")){ 
						logger.debug("tipificacion[i].getTipTerminal() = SIMCARD ["+tipificacion[i].getTipTerminal()+"]");
						simcard.setNumeroSerie(tipificacion[i].getNumSerie());
						terminal.setMin(tipificacion[i].getNumCelular());
						terminal.setNumImei(config.getString("IMEI-DUMY"));
					}
					else if(tipificacion[i].getTipTerminal().equals("T")){ 
						logger.debug("tipificacion[i].getTipTerminal() = TERMINAL ["+tipificacion[i].getTipTerminal()+"]");
					} 
				}
			}
			else{ 
				throw new GeneralException("9825332",0,"Error, la serie no corresponde a un kit o a una Simcard");
			}

			linea.setSimcard(simcard);
			linea.setTerminal(terminal);

			WsUsuarioInDTO usuarioIn = new WsUsuarioInDTO();
			usuarioIn.setCodDireccion(config.getString("cod.direccion.busito"));
			usuarioIn.setIngresosBrutosAnuales(config.getString("ingresos.brutos.anuales"));
			usuarioIn.setNomEmpresa("");
			usuarioIn.setNumeroIdentificacion(cuenta.getClienteComDTO().getNumeroIdentificacion());
			usuarioIn.setOcupacion(config.getString("ocupacion.busito"));
			usuarioIn.setNombre(cuenta.getClienteComDTO().getNombreCliente());
			//usuarioIn.setPrimerApellido(cuenta.getClienteComDTO().getNombreApellido1());
			logger.debug("Inc. 148780 cuenta.getClienteComDTO().getNombreApellido1() ["+cuenta.getClienteComDTO().getNombreApellido1()+"]");
			if ("".equals(cuenta.getClienteComDTO().getNombreApellido1()) || cuenta.getClienteComDTO().getNombreApellido1()==null){
				usuarioIn.setPrimerApellido("Busito");
			}
			else{
				usuarioIn.setPrimerApellido(cuenta.getClienteComDTO().getNombreApellido1());
			}
			logger.debug("Inc. 148780 usuarioIn.getPrimerApellido() ["+usuarioIn.getPrimerApellido()+"]");
			
			usuarioIn.setSegundoApellido(cuenta.getClienteComDTO().getNombreApellido2());
			usuarioIn.setTipIdentificacion(cuenta.getClienteComDTO().getCodigoTipoIdentificacion());		    		    
			linea.setUsuarioLinea(usuarioIn);

			//INICIO CSR-11002
			//se setea un codigo de prestacion por defecto
			String codPrestacion = config.getString("cod.prestacion.movilprepago");
			linea.setCodPrestacion(codPrestacion);
			//FIN CSR-11002
			
			ArrayList list = new ArrayList();
			list.add(linea);
			lineas =(WsLineaInDTO[]) ArrayUtl.copiaArregloTipoEspecifico(list.toArray(), WsLineaInDTO.class);

			activacionLinea.setLineas(lineas);					
			cunetaAltaDeLinea.setLinea(activacionLinea);

			cunetaAltaDeLineaOut = AltaDeLinea(cunetaAltaDeLinea, 1);
			if (cunetaAltaDeLineaOut.getResultadoTransaccion().equals("1")){				
				for(int k=0;k< cunetaAltaDeLineaOut.getErrores().length;k++){
					error = new RetornoDTO();
					error.setCodError(cunetaAltaDeLineaOut.getErrores()[k].getCodError());
					error.setMensajseError(cunetaAltaDeLineaOut.getErrores()[k].getMensajseError());
					listErrores.add(error);
				}
				throw new GeneralException("9845631",0,"Error en el alta de linea");				
			}

			WsFacturacionVentaInDTO WsFacturacionVentaIn = new WsFacturacionVentaInDTO();
			WsFacturacionVentaOutDTO FacturacionVentaOutDTO = new WsFacturacionVentaOutDTO();

			WsFacturacionVentaIn.setFacturaACiclo(false);
			WsFacturacionVentaIn.setIdentificadorTransaccion("1");
			WsFacturacionVentaIn.setNomUsuario(altaDeLineaBusitoIn.getNomUsuario());
			WsFacturacionVentaIn.setNumVenta(cunetaAltaDeLineaOut.getNumVenta());
			WsFacturacionVentaIn.setObsFactVenta("");

			WsFacturacionLineaDTO facturacionLinea = new WsFacturacionLineaDTO();
			WsFacturacionLineaDTO[] facturacionLineas = null;

			facturacionLinea.setMntoDscSimcard(0);
			facturacionLinea.setMntoDscTerminal(0);
			facturacionLinea.setNumCelular(new Long(cunetaAltaDeLineaOut.getLineaOut()[0].getNumCelular()).longValue());

			ArrayList listFact = new ArrayList();
			listFact.add(facturacionLinea);

			facturacionLineas =(WsFacturacionLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listFact.toArray(), WsFacturacionLineaDTO.class);
			WsFacturacionVentaIn.setFacturacionLinea(facturacionLineas);

			


			FacturacionVentaOutDTO = ProcesoDeFacturacion(WsFacturacionVentaIn, null,1);
			if (FacturacionVentaOutDTO.getResultadoTransaccion().equals("1")){
				for(int j=0;j< FacturacionVentaOutDTO.getErrores().length;j++){
					error = new RetornoDTO();
					error.setCodError(FacturacionVentaOutDTO.getErrores()[j].getCodError());
					error.setMensajseError(FacturacionVentaOutDTO.getErrores()[j].getMensajseError());
					listErrores.add(error);
				}				
				throw new GeneralException("9845631",0,"Error en el Facturacion");
			}

			CierreVentaOutDTO cierre = null;
			WsCierreVentaInDTO cierreVenta = new WsCierreVentaInDTO();

			cierreVenta.setVenta(cunetaAltaDeLineaOut.getNumVenta());
			cierreVenta.setMtoGarantia(new Float(0));
			cierreVenta.setUsuario(altaDeLineaBusitoIn.getNomUsuario());
			cierreVenta.setIdentificadorTransaccion("1");



			cierre = cierreVenta(cierreVenta, 1);
			if (cierre.getResultadoTransaccion().equals("1")){
				for(int l=0;l<cierre.getErrores().length;l++){
					error = new RetornoDTO();
					error.setCodError(cierre.getErrores()[l].getCodError());
					error.setMensajseError(cierre.getErrores()[l].getMensajseError());
					listErrores.add(error);
				}								
				throw new GeneralException("9845631",0,"Error en el cierre de venta");
			}
			
			updateAboVendealer(cunetaAltaDeLineaOut.getLineaOut()[0].getNumAboando());
			
			altaDeLineaBusitoOut.setErrores(null);
			altaDeLineaBusitoOut.setLineaOut(cunetaAltaDeLineaOut.getLineaOut());
			altaDeLineaBusitoOut.setNumVenta(cunetaAltaDeLineaOut.getNumVenta());
			altaDeLineaBusitoOut.setResultadoTransaccion(cunetaAltaDeLineaOut.getResultadoTransaccion());
		}
		catch(GeneralException e){		
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			logger.debug("Antes de error");
			error = new RetornoDTO();
			error.setCodError(e.getCodigo());
			error.setMensajseError(e.getDescripcionEvento());
			listErrores.add(error);
			logger.debug("despues de error");
			logger.debug("Antes de error array");
			errores =(RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listErrores.toArray(), RetornoDTO.class);
			logger.debug("despues de error array");
			logger.debug("antes de set error");
			altaDeLineaBusitoOut.setErrores(errores);
			logger.debug("despues de set error");
			altaDeLineaBusitoOut.setResultadoTransaccion("1");
			logger.debug("setResultadoTransaccion");
			logger.debug("Antes del return");
			return altaDeLineaBusitoOut;
		}catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			logger.debug("Antes de error");
			error = new RetornoDTO();
			error.setCodError("1023985");
			error.setMensajseError(e.getMessage());
			listErrores.add(error);
			logger.debug("Despues de erro");
			logger.debug("Antes de error array");
			errores =(RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listErrores.toArray(), RetornoDTO.class);
			logger.debug("despues de erro array");
			altaDeLineaBusitoOut.setErrores(errores);
			altaDeLineaBusitoOut.setResultadoTransaccion("1");
			logger.debug("retorno de erro");
			return altaDeLineaBusitoOut;
		}
		logger.debug("return end");
		return altaDeLineaBusitoOut;
	}	
	
	private void updateAboVendealer(String numAbonado) throws GeneralException{		
		try{
			logger.debug(" updateAboVendealer:start");
			getGestionDeCliente().updateAboVendealer(numAbonado);
			logger.debug(" updateAboVendealer:end");						
		}catch (GeneralException e) {
			logger.debug("Error 12295 - Error al update GA_ABOAMIST");
			e.setCodigo("12295");
			e.setDescripcionEvento("Error al update GA_ABOAMIST");
			throw e;		
		}catch (Exception e) {
			logger.debug("Error 12295 - Error al update GA_ABOAMIST");
			throw new GeneralException ("12295",0,"Error al update GA_ABOAMIST");		
		}
	}	
	
	
	
//	Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RechazoVentaOutDTO cancelaVenta(WsRechazoVentaInDTO cancelaVenta, int rollback)
	throws GeneralException{
		RechazoVentaOutDTO cancelaVentaOut = new RechazoVentaOutDTO();
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("cancelaVenta():start");
		ArrayList errores = new ArrayList();
		RetornoDTO respuesta = new RetornoDTO();
		ArrayList error = new ArrayList();
		String setTipProceso = "1";
		int situacionVenta = 4;

		try {
			errores = valida.ValidarRechazoVenta(cancelaVenta);
			if (errores.toArray().length > 0 ) {
				cancelaVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));
				cancelaVentaOut.setResultadoTransaccion("1");
			}else{

				//INI-01 (AL) - Comentado - Portabilidad
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cancelaVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("18");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cancelaVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

				if (!recuperaVentaRechazo(cancelaVenta, error)){

					throw new GeneralException ("12486",0,"Error al recuperar datos de la Venta");
				}

				logger.debug("recuperaVenta  ventaDTO.getIndEstVenta ["+ventaGlobalDTO.getIndEstVenta()+"]");
				logger.debug("situacionVenta: ["+situacionVenta+"]");
				if (validaEstadoVenta(error,situacionVenta)) {
					
					ventaGlobalDTO.setCodigoUsuario(cancelaVenta.getUsuario());
					
					getGestionDeCliente().cancelaVenta(ventaGlobalDTO);	
					
					cancelaVentaOut.setResultadoTransaccion("0");					
					
					//INI-01 (AL) - Comentado - Portabilidad
					//EstadoAsinc.setCodEstado("19");
					//EstadoAsinc.setTipProceso(setTipProceso);
					//EstadoAsinc.setNumProceso(cancelaVenta.getVenta());
					//grabaEstadoAsinc(EstadoAsinc);	

				}
				else{
					throw new GeneralException ("12488",0,"Error: No es posible reversar la venta número ["+ventaGlobalDTO.getNumVenta()+"]");				
				}
				logger.debug("Rollback: ["+rollback+"]");
				if (rollback == 0){
					logger.debug("rollback == 0 Rollback ["+rollback+"]");
					context.setRollbackOnly();
					logger.debug("context [TRUE]");
				}
			}
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cancelaVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("20");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cancelaVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);			
			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}

			RetornoDTO error1 = new RetornoDTO();	
			cancelaVentaOut = new RechazoVentaOutDTO();
			error1.setCodError(e.getCodigo());
			error1.setMensajseError(e.getDescripcionEvento());
			errores.add(error1);
			cancelaVentaOut.setResultadoTransaccion("1");
			cancelaVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return cancelaVentaOut;		

		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));			
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");

			//INI-01 (AL) - Comentado - Portabilidad
			//try{
				//EstadoAsincDTO EstadoAsinc = new EstadoAsincDTO();
				//EstadoAsinc.setSpnPortId(cancelaVenta.getIdentificadorTransaccion());
				//EstadoAsinc.setCodEstado("20");
				//EstadoAsinc.setTipProceso(setTipProceso);
				//EstadoAsinc.setNumProceso(cancelaVenta.getVenta());
				//grabaEstadoAsinc(EstadoAsinc);

			//}catch (GeneralException g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}catch (Exception g) {
				//logger.debug("error al registrar auditoria");
				//context.setRollbackOnly();
			//}				

			RetornoDTO error1 = new RetornoDTO();	
			cancelaVentaOut = new RechazoVentaOutDTO();
			error1.setCodError("1");
			error1.setMensajseError(e.getMessage());
			errores.add(error1);
			cancelaVentaOut.setResultadoTransaccion("1");
			cancelaVentaOut.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(errores.toArray(), RetornoDTO.class));			
			context.setRollbackOnly();
			return cancelaVentaOut;			
		}
		logger.debug("aceptacionVenta():end");
		return cancelaVentaOut;

	}	
//	Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]

// INICIO CSR-11002
	/*CSR-11002 Se incorpora método getTiposPrestacion*/
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTipoPrestacionOutDTO getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
	/*throws VentasException, RemoteException*/
	throws GeneralException
{
	WsListTipoPrestacionOutDTO tipoPrestacionDTO = new WsListTipoPrestacionOutDTO();
	logger.debug("getTiposPrestacion:start");
	TipoPrestacionDTO[] ret; 
	try {
		ret = srv.getTiposPrestacion(codGrupoPrestacion, tipoCliente);
	    tipoPrestacionDTO.setTipoPrestacionDTO(ret);
	
}catch(GeneralException e){
	UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
	tipoPrestacionDTO.setCodError(e.getCodigo());
	tipoPrestacionDTO.setMensajseError(e.getDescripcionEvento());
	logger.debug("GeneralException[", e);
	throw e;
} catch (Exception e) {
	UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
	tipoPrestacionDTO.setCodError("1");
	tipoPrestacionDTO.setMensajseError(e.getMessage());
	/*logger.debug("Exception[", e);
	/*throw new GeneralException(e);*/	
    }
	logger.debug("getTiposPrestacion:end");
	return tipoPrestacionDTO;
}//fin getTiposPrestacion

	//CSR-11002
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsDatosDireccionOutDTO getDatosDireccion(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO direccionDTO) throws GeneralException{
		WsDatosDireccionOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getDatosDireccion:start");

			retValue = new WsDatosDireccionOutDTO();

			com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO direccionResultDTO = null;
			direccionResultDTO = getGestionDeDirecciones().getDatosDireccion(direccionDTO);

			retValue.setDireccionDTO(direccionResultDTO);

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getDatosDireccion:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsListadoCategoriaCambioDTO getCategoriasCambio() throws GeneralException
	{
		logger.debug("getCategoriasCambio():start");
		WsListadoCategoriaCambioDTO segmentosDTO = new WsListadoCategoriaCambioDTO();
		try
		{
			segmentosDTO.setCategoriaCambioDTO(getGestionDeCliente().getCategoriasCambio());
			
		} catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getCategoriasCambio():end");
		return segmentosDTO;
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
	public WsCrediticiaOutDTO getCrediticia() throws GeneralException{
		
		WsCrediticiaOutDTO retValue=null;
		
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getCrediticia:start");

			retValue = new WsCrediticiaOutDTO();

			ValorClasificacionDTO[] crediticias = null;
			crediticias = getGestionDeCliente().getCrediticia();

			retValue.setCrediticias(crediticias);

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getCrediticia:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public WsClasificacionOutDTO getClasificaciones() throws GeneralException{
		
		WsClasificacionOutDTO retValue=null;
		
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getClasificaciones:start");

			retValue = new WsClasificacionOutDTO();

			ClasificacionDTO[] clasificaciones = null;
			clasificaciones = getGestionDeCliente().getClasificaciones();

			retValue.setClasificaciones(clasificaciones);

			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getClasificaciones:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
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
	public  WsListTipoPagoOutDTO getListadoTipoPago() throws GeneralException{
		WsListTipoPagoOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTipoPago:start");
			retValue=getGestionDeCliente().getListadoTipoPago();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoTipoPago:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	
	//FIN CSR-11002
	
	//JLGN PT
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws GeneralException{
		WsListPlanTarifarioOutDTO retValue = null;
		try{
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanTarifario:start");
			retValue = getGestionDeCliente().getListadoPlanTarifario();
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("SpnSclORQBean: getListadoPlanTarifario:end");

		}catch(GeneralException e){
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("SpnSclOrqBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
}


