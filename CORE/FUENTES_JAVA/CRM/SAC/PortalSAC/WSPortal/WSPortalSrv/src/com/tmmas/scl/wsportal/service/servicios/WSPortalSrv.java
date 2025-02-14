/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.businessobject.bo.AbonadoBO;
import com.tmmas.scl.wsportal.businessobject.bo.AjusteBO;
import com.tmmas.scl.wsportal.businessobject.bo.AtencionPackageBO;
import com.tmmas.scl.wsportal.businessobject.bo.AvisoSiniestroBO;
import com.tmmas.scl.wsportal.businessobject.bo.BeneficioBO;
import com.tmmas.scl.wsportal.businessobject.bo.ClienteBO;
import com.tmmas.scl.wsportal.businessobject.bo.ComunBO;
import com.tmmas.scl.wsportal.businessobject.bo.CuentaBO;
import com.tmmas.scl.wsportal.businessobject.bo.CuentaCorrienteBO;
import com.tmmas.scl.wsportal.businessobject.bo.DireccionBO;
import com.tmmas.scl.wsportal.businessobject.bo.FacturaBO;
import com.tmmas.scl.wsportal.businessobject.bo.GeneralBO;
import com.tmmas.scl.wsportal.businessobject.bo.LimiteConsumoBO;
import com.tmmas.scl.wsportal.businessobject.bo.OrdenServicioBO;
import com.tmmas.scl.wsportal.businessobject.bo.PagoBO;
import com.tmmas.scl.wsportal.businessobject.bo.ProductoBO;
import com.tmmas.scl.wsportal.businessobject.bo.ReporteBO;
import com.tmmas.scl.wsportal.businessobject.bo.SerieBO;
import com.tmmas.scl.wsportal.businessobject.bo.ServSuplementarioBO;
import com.tmmas.scl.wsportal.businessobject.bo.UsuarioBO;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.CampoDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.CiudadDTO;
import com.tmmas.scl.wsportal.common.dto.ComunaDTO;
import com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO;
import com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO;
import com.tmmas.scl.wsportal.common.dto.EstadoDTO;
import com.tmmas.scl.wsportal.common.dto.GedParametrosDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCambiosPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCausasSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCiudadesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoComunasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoEstadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoGruposDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoNumerosFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProvinciasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPueblosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoRegionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposCalleDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSuspensionDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoZipCodeDTO;
import com.tmmas.scl.wsportal.common.dto.MenuDTO;
import com.tmmas.scl.wsportal.common.dto.MuestraURLDTO;
import com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO;
import com.tmmas.scl.wsportal.common.dto.ProvinciaDTO;
import com.tmmas.scl.wsportal.common.dto.PuebloDTO;
import com.tmmas.scl.wsportal.common.dto.RegionDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.dto.TipoCalleDTO;
import com.tmmas.scl.wsportal.common.dto.ValorCampoDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ZipCodeDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class WSPortalSrv
{
	public static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalSrv.properties";

	public static final String PROPERTIES_EXTERNO = "WSPortalSrv.properties";

	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalSrv.archivo.config.log4j";

	private static final String INICIO_LOG = "Inicio";

	private static final String FIN_LOG = "Fin";

	private static final String REGION = "0";
	private static final String PROVINCIA = "1";
	private static final String CIUDAD = "2";
	private static final String COMUNA = "3";
	private static final String ESTADO = "12";
	private static final String PUEBLO = "11";
	private static final String TIPOCALLE = "14";
	private static final String COMBOZIP = "99";
    
	private static Logger logger = Logger.getLogger(WSPortalSrv.class);

	/** El atributo config. */
	private static CompositeConfiguration config = UtilProperty
			.getConfiguration(PROPERTIES_EXTERNO, PROPERTIES_INTERNO);

	/** La constante CONFIGURACION_LOG. */
	private static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	private AbonadoBO abonadoBO = new AbonadoBO();

	private AjusteBO ajusteBO = new AjusteBO();

	private BeneficioBO beneficioBO = new BeneficioBO();

	private CuentaCorrienteBO ccBO = new CuentaCorrienteBO();

	private ClienteBO clienteBO = new ClienteBO();

	/** El atributo cuenta bo. */
	private CuentaBO cuentaBO = new CuentaBO();

	/** El atributo direccion bo. */
	private DireccionBO direccionBO = new DireccionBO();

	/** El atributo factura bo. */
	private FacturaBO facturaBO = new FacturaBO();

	/** El atributo limite consumo bo. */
	private LimiteConsumoBO limiteConsumoBO = new LimiteConsumoBO();

	/** El atributo ooss bo. */
	private OrdenServicioBO oossBO = new OrdenServicioBO();

	/** El atributo pago bo. */
	private PagoBO pagoBO = new PagoBO();

	/** El atributo producto bo. */
	private ProductoBO productoBO = new ProductoBO();

	/** El atributo serie bo. */
	private SerieBO serieBO = new SerieBO();

	/** El atributo ss bo. */
	private ServSuplementarioBO ssBO = new ServSuplementarioBO();

	/** El atributo usuario bo. */
	private UsuarioBO usuarioBO = new UsuarioBO();

	/**
	 * 
	 */
	private AvisoSiniestroBO avisoSiniestroBO = new AvisoSiniestroBO();

	/** El atributo atencionPackageBO bo. */
	private AtencionPackageBO atencionPackageBO = new AtencionPackageBO();
	
	/** El atributo ComunBO bo. */
	private ComunBO comunBO = new ComunBO();
	
	/** El atributo ReporteDAO bo. */
	private ReporteBO reporteBO = new ReporteBO();
	
	private GeneralBO generalBO = new GeneralBO();
	
	/**
	 * Crea una nueva instancia de la clase WSPortalSrv.
	 */
	public WSPortalSrv()
	{

	}

	/**
	 * Abonados x celular.
	 * 
	 * @param numCelular el parametro numCelular
	 * 
	 * @return el resultado de listado abonados dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoAbonadosDTO abonadosXCelular(Long numCelular) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoAbonadosDTO r = abonadoBO.abonadosXCelular(numCelular);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Abonados x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado abonados dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoAbonadosDTO abonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoAbonadosDTO r = abonadoBO.abonadosXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ajustes x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param codTipDocum el parametro codTipDocum
	 * 
	 * @return el resultado de listado ajustes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoAjustesDTO ajustesXCodCliente(Long codCliente, Long codTipDocum) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoAjustesDTO r = ajusteBO.ajustesXCodCliente(codCliente, codTipDocum);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Beneficios x cliente abonado.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado beneficios dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoBeneficiosDTO beneficiosXClienteAbonado(Long codCliente, Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoBeneficiosDTO r = beneficioBO.beneficiosXClienteAbonado(codCliente, numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCambiosPlanTarifDTO r = productoBO.cambiosPlanCliente(numOS);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCambiosPlanTarifDTO r = productoBO.cambiosPlanAbonadoPospago(numOS);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCambiosPlanTarifDTO r = productoBO.cambiosPlanAbonadoPrepago(numOS);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Carga valida os usuario.
	 * 
	 * @param validacionUsuario el parametro validacionUsuario
	 * 
	 * @return el resultado de menu dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public MenuDTO cargaValidaOSUsuario(String validacionUsuario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final MenuDTO r = usuarioBO.cargaValidaOSUsuario(validacionUsuario);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Cc x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado cuentas corrientes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCuentasCorrientesDTO r = ccBO.ccXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Clientes x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado clientes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoClientesDTO clientesXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoClientesDTO r = clienteBO.clientesXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Clientes x cuenta.
	 * 
	 * @param codCuenta el parametro codCuenta
	 * 
	 * @return el resultado de listado clientes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoClientesDTO clientesXCuenta(Long codCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoClientesDTO r = clienteBO.clientesXCuenta(codCuenta);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Clientes x nombre.
	 * 
	 * @param nombre el parametro nombre
	 * 
	 * @return el resultado de listado clientes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoClientesDTO clientesXNombre(String nombre) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoClientesDTO r = clienteBO.clientesXNombre(nombre);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Consultas x cod grupo.
	 * 
	 * @param codGrupo el parametro codGrupo
	 * @param codPrograma el parametro codPrograma
	 * @param numVersion el parametro numVersion
	 * 
	 * @return el resultado de listado consultas dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoConsultasDTO consultasXCodGrupo(String codGrupo, String codPrograma, String numVersion)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoConsultasDTO r = usuarioBO.consultasXCodGrupo(codGrupo, codPrograma, numVersion);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Cuentas x codigo.
	 * 
	 * @param codCuenta el parametro codCuenta
	 * 
	 * @return el resultado de listado cuentas dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCuentasDTO r = cuentaBO.cuentasXCodigo(codCuenta);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Cuentas x nombre.
	 * 
	 * @param descCuenta el parametro descCuenta
	 * 
	 * @return el resultado de listado cuentas dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoCuentasDTO cuentasXNombre(String descCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCuentasDTO r = cuentaBO.cuentasXNombre(descCuenta);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Cuentas x num ident.
	 * 
	 * @param numIdent el parametro numIdent
	 * 
	 * @return el resultado de listado cuentas dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoCuentasDTO cuentasXNumIdent(String numIdent) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCuentasDTO r = cuentaBO.cuentasXNumIdent(numIdent);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Detalle equipo simcard x num abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de equipo simcard detalle dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public EquipoSimcardDetalleDTO detalleEquipoSimcardXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final EquipoSimcardDetalleDTO r = serieBO.detalleEquipoSimcardXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Detalle llamadas.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param numAbonado el parametro numAbonado
	 * @param codCiclo el parametro codCiclo
	 * @param tipoLlamada el parametro tipoLlamada
	 * 
	 * @return el resultado de listado detalle llamados dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente, Long numAbonado, Long codCiclo, String tipoLlamada)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDetalleLlamadosDTO r = limiteConsumoBO.detalleLlamadas(codCliente, numAbonado, codCiclo,
				tipoLlamada);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Detalle plan tarifario.
	 * 
	 * @param codPlanTarifario el parametro codPlanTarifario
	 * 
	 * @return el resultado de detalle plan tarifario dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DetallePlanTarifarioDTO r = productoBO.detallePlanTarifario(codPlanTarifario);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Direcciones x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado direcciones dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoDireccionesDTO direccionesXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDireccionesDTO r = direccionBO.direccionesXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final Boolean r = usuarioBO.esPrimerLogin(nomUsuario);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Facturas x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado facturas dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoFacturasDTO facturasXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoFacturasDTO r = facturaBO.facturasXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de detalle abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el valor de detalle abonado
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DetalleAbonadoDTO getDetalleAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DetalleAbonadoDTO r = abonadoBO.getDetalleAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de detalle cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el valor de detalle cliente
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DetalleClienteDTO getDetalleCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DetalleClienteDTO r = clienteBO.getDetalleCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de detalle cuenta.
	 * 
	 * @param codCuenta el parametro codCuenta
	 * 
	 * @return el valor de detalle cuenta
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DetalleCuentaDTO getDetalleCuenta(Long codCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DetalleCuentaDTO r = cuentaBO.getDetalleCuenta(codCuenta);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de detalle direccion.
	 * 
	 * @param codDireccion el parametro codDireccion
	 * @param codTipDireccion el parametro codTipDireccion
	 * 
	 * @return el valor de detalle direccion
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DetalleDireccionDTO getDetalleDireccion(Long codDireccion, String codTipDireccion) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DetalleDireccionDTO r = direccionBO.getDetalleDireccion(codDireccion, codTipDireccion);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * permite obtener los valores que seran mostrados como direccion para el cliente
	 * 
	 * 
	 * @return listado de valores que seran mostrados como direccion
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DireccionPorClienteDTO obtenerDatosDireccionCliente(DatosDireccionClienteINDTO pIn) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		
		String codRegion = null;
		String codProvincia = null;
		String codCiudad = null;
		String codComuna = null; 
		String estado = null;
		
		logger.debug("direccionBO.obtenerDatosDireccionCliente");
		final DireccionPorClienteDTO r = direccionBO.obtenerDatosDireccionCliente(pIn);
		
		logger.debug("r.getCodError: " + r.getCodError());
		logger.debug("r.getDesError: " + r.getDesError());
		
		if(r.getCodError() != null && !"0".equals(r.getCodError())){	
			return r;
		}
		
		ValorCampoDireccionDTO[] listaValorCampo = r.getArrayValorCampos();
		
		//obtener la lista de campos que se muestran por pantalla
		logger.debug("direccionBO.obtenerCamposDireccion");
		ListadoCamposDireccionDTO resultListaCampos = direccionBO.obtenerCamposDireccion();
		
		logger.debug("resultListaCampos.getCodError: " + resultListaCampos.getCodError());
		logger.debug("resultListaCampos.getDesError: " + resultListaCampos.getDesError());
		
		if(resultListaCampos.getCodError() != null && !"0".equals(resultListaCampos.getCodError())){
			r.setCodError(resultListaCampos.getCodError());
			r.setDesError(resultListaCampos.getDesError());
			
			return r;
		}
		
		logger.debug("CON_DESCRIPCION: " + pIn.getConDescripcion().booleanValue());
		
		CampoDireccionDTO[] listaCampos = resultListaCampos.getArrayCampos();
		logger.debug("listaValorCampo.length: " + listaValorCampo.length);
		
		//completar de la lista de valores de la direccion el tipDat y secDat
		for (int i = 0; i < listaValorCampo.length; i++) {
			
			ValorCampoDireccionDTO valorCampoDireccionDTO = listaValorCampo[i];
			
			logger.debug("listaCampos.length: " + listaCampos.length);
			for (int j = 0; j < listaCampos.length; j++) {
				
				CampoDireccionDTO campoDireccionDTO = listaCampos[j];
				
				if(valorCampoDireccionDTO.getCodParamDir().equals(campoDireccionDTO.getCodParamDir())){
					
					logger.debug("CodParamDir: " + valorCampoDireccionDTO.getCodParamDir());
					
					valorCampoDireccionDTO.setTipDat(campoDireccionDTO.getTipDat());
					valorCampoDireccionDTO.setSecDat(campoDireccionDTO.getSecDat());
					
					logger.debug("TipDat: " + valorCampoDireccionDTO.getTipDat());
					logger.debug("SecDat: " + valorCampoDireccionDTO.getSecDat());
					
					//si se requiere la descripcion
					logger.debug("campoDireccionDTO.getTipDat(): [" + campoDireccionDTO.getTipDat()+"]");
					if(pIn.getConDescripcion().booleanValue() && "CMB".equals(campoDireccionDTO.getTipDat())){
					    
						logger.debug("se requiere la descripcion del valor: " + valorCampoDireccionDTO.getCodValor());
						
						if(REGION.equals(valorCampoDireccionDTO.getCodParamDir())){
							codRegion = valorCampoDireccionDTO.getCodValor();
							
						}else if(PROVINCIA.equals(valorCampoDireccionDTO.getCodParamDir())){
                            
							codProvincia = valorCampoDireccionDTO.getCodValor();
							
						}else if(CIUDAD.equals(valorCampoDireccionDTO.getCodParamDir())){
                            
							codCiudad = valorCampoDireccionDTO.getCodValor();
							
						}else if(COMUNA.equals(valorCampoDireccionDTO.getCodParamDir())){
                            
							codComuna = valorCampoDireccionDTO.getCodValor();
							
						}else if(ESTADO.equals(valorCampoDireccionDTO.getCodParamDir())){
							
							estado = valorCampoDireccionDTO.getCodValor();

						}
						
						String desValor = null;
						try{
							
							desValor = obtenerDescripcionCombo(campoDireccionDTO.getCodParamDir(), 
                                                               valorCampoDireccionDTO.getCodValor(),
                                                               codRegion,
                                                               codProvincia,
                                                               codCiudad,
                                                               codComuna,
                                                               estado);
							
						}catch(PortalSACException psEx){
							
							logger.error(psEx);
							logger.error("psEx.getCodigo: " + psEx.getCodigo());
							logger.error("psEx.getMessage: " + psEx.getMessage());
							r.setCodError(psEx.getCodigo());
							r.setDesError(psEx.getMessage());
							
							return r;
						}
						
						valorCampoDireccionDTO.setDesValor(desValor);
						
						logger.debug("DesValor: " + valorCampoDireccionDTO.getDesValor());
						
					}else if(pIn.getConDescripcion().booleanValue() && "13".equals(campoDireccionDTO.getCodParamDir())){
						
						String desValor = null;
						try{
							
							desValor = obtenerDescripcionCombo(COMBOZIP, 
                                                               valorCampoDireccionDTO.getCodValor(),
                                                               codRegion,
                                                               codProvincia,
                                                               codCiudad,
                                                               codComuna,
                                                               estado);
							
						}catch(PortalSACException psEx){
							
							r.setCodError(psEx.getCodigo());
							r.setDesError(psEx.getMessage());
							
							return r;
						}
						
						valorCampoDireccionDTO.setDesValor(desValor);
						logger.debug("DesValor: " + valorCampoDireccionDTO.getDesValor());
					}
					
					break;
				}
			}
		}
		
		
		logger.info(FIN_LOG);
		return r;
	}
	
	private String obtenerDescripcionCombo(String pCodParamDir, 
										   String pCodValor,
										   String pCodRegion,
										   String pCodProvincia,
										   String pCodCiudad,
										   String pCodComuna,
										   String pCodEstado) throws PortalSACException
	{
		logger.debug("obtenerDescripcionCombo");
		
        String result = null;
        
        if(REGION.equals(pCodParamDir)){
        	
        	ListadoRegionesDTO resultRegion = direccionBO.obtenerRegiones();
        	
        	if(resultRegion.getCodError() != null && !"0".equals(resultRegion.getCodError())){
        		
        		throw new PortalSACException(resultRegion.getCodError(), resultRegion.getDesError());
        		
        	}
        	
        	RegionDTO[] regiones = resultRegion.getArrayRegiones();
        	
            for (int i = 0; i < regiones.length; i++) {
				RegionDTO regionDTO = regiones[i];
				
				if(regionDTO.getCodRegion().equals(pCodValor)){
					
					result = regionDTO.getDesRegion();
					
					break;
				}
			}    
            
            return result;
            
        }else if(PROVINCIA.equals(pCodParamDir)){
        	
        	ListadoProvinciasDTO resultProvincia = direccionBO.obtenerProvincias(pCodRegion);
        	
        	if(resultProvincia.getCodError() != null && !"0".equals(resultProvincia.getCodError())){
        		
        		throw new PortalSACException(resultProvincia.getCodError(), resultProvincia.getDesError());
        		
        	}
        	
        	ProvinciaDTO[] provincias = resultProvincia.getArrayProvincias();
        	
            for (int i = 0; i < provincias.length; i++) {
            	ProvinciaDTO provinciaDTO = provincias[i];
				
				if(provinciaDTO.getCodProvincia().equals(pCodValor)){
					
					result = provinciaDTO.getDesProvincia();
					
					break;
				}
			}    
            
            return result;
            
        }else if(CIUDAD.equals(pCodParamDir)){
        	
        	ListadoCiudadesDTO resultCiudad = direccionBO.obtenerCiudades(pCodRegion, pCodProvincia);
        	
        	if(resultCiudad.getCodError() != null && !"0".equals(resultCiudad.getCodError())){
        		
        		throw new PortalSACException(resultCiudad.getCodError(), resultCiudad.getDesError());
        		
        	}
        	
        	CiudadDTO[] ciudades = resultCiudad.getArrayCiudades();
        	
            for (int i = 0; i < ciudades.length; i++) {
            	CiudadDTO ciudadDTO = ciudades[i];
				
				if(ciudadDTO.getCodCiudad().equals(pCodValor)){
					
					result = ciudadDTO.getDesCiudad();
					
					break;
				}
			}    
            
            return result;
            
        }else if(COMUNA.equals(pCodParamDir)){
        	
        	ListadoComunasDTO resultComuna = direccionBO.obtenerComunas(pCodRegion, pCodProvincia, pCodCiudad);
        	
        	if(resultComuna.getCodError() != null && !"0".equals(resultComuna.getCodError())){
        		
        		throw new PortalSACException(resultComuna.getCodError(), resultComuna.getDesError());
        		
        	}
        	
        	ComunaDTO[] comunas = resultComuna.getArrayComunas();
        	
            for (int i = 0; i < comunas.length; i++) {
            	ComunaDTO comunaDTO = comunas[i];
				
				if(comunaDTO.getCodComuna().equals(pCodValor)){
					
					result = comunaDTO.getDesComuna();
					
					break;
				}
			}    
            
            return result;
        
        }else if(ESTADO.equals(pCodParamDir)){
        	
        	ListadoEstadosDTO resultEstado = direccionBO.obtenerEstados();
        	
        	if(resultEstado.getCodError() != null && !"0".equals(resultEstado.getCodError())){
        		
        		throw new PortalSACException(resultEstado.getCodError(), resultEstado.getDesError());
        		
        	}
        	
        	EstadoDTO[] estados = resultEstado.getArrayEstados();
        	
            for (int i = 0; i < estados.length; i++) {
            	EstadoDTO estadoDTO = estados[i];
				
				if(estadoDTO.getCodEstado().equals(pCodValor)){
					
					result = estadoDTO.getDesEstado();
					
					break;
				}
			}    
            
            return result;
        }else if(PUEBLO.equals(pCodParamDir)){
        	
        	ListadoPueblosDTO resultPueblo = direccionBO.obtenerPueblos(pCodEstado);
        	
        	if(resultPueblo.getCodError() != null && !"0".equals(resultPueblo.getCodError())){
        		
        		throw new PortalSACException(resultPueblo.getCodError(), resultPueblo.getDesError());
        		
        	}
        	
        	PuebloDTO[] pueblos = resultPueblo.getArrayPueblos();
        	
            for (int i = 0; i < pueblos.length; i++) {
            	PuebloDTO puebloDTO = pueblos[i];
				
				if(puebloDTO.getCodPueblo().equals(pCodValor)){
					
					result = puebloDTO.getDesPueblo();
					
					break;
				}
			}    
            
            return result;
            
        }else if(TIPOCALLE.equals(pCodParamDir)){
        	
        	ListadoTiposCalleDTO resultTipoCalle = direccionBO.obtenerTiposCalle();
        	
        	if(resultTipoCalle.getCodError() != null && !"0".equals(resultTipoCalle.getCodError())){
        		
        		throw new PortalSACException(resultTipoCalle.getCodError(), resultTipoCalle.getDesError());
        		
        	}
        	
        	TipoCalleDTO[] tiposCalle = resultTipoCalle.getArrayTiposCalle();
        	
            for (int i = 0; i < tiposCalle.length; i++) {
            	TipoCalleDTO tipoCalleDTO = tiposCalle[i];
				
				if(tipoCalleDTO.getCodTipoCalle().equals(pCodValor)){
					
					result = tipoCalleDTO.getDesTipoCalle();
					
					break;
				}
			}    
            
            return result;
        
        }else if(COMBOZIP.equals(pCodParamDir)){
        	
        	String tablaZipCode = direccionBO.obtenerParametroZipCode();
        	logger.debug("tablaZipCode : " + tablaZipCode);
        	
        	String codigoZona = null;
        	
        	if("GE_REGIONES".equals(tablaZipCode)){
        		
                codigoZona = pCodRegion;
        		
        	}else if("GE_PROVINCIAS".equals(tablaZipCode)){
        		
                codigoZona = pCodProvincia;
        		
        	}else if("GE_CIUDADES".equals(tablaZipCode)){
        		
        		codigoZona = pCodCiudad;
        		
        	}else if("GE_COMUNAS".equals(tablaZipCode)){
        		
        		codigoZona = pCodComuna;
        	}
        	
        	ListadoZipCodeDTO resultZipCode = direccionBO.obtenerZipCode(codigoZona);
        	
        	if(resultZipCode.getCodError() != null && !"0".equals(resultZipCode.getCodError())){
        		
        		throw new PortalSACException(resultZipCode.getCodError(), resultZipCode.getDesError());
        		
        	}
        	
        	ZipCodeDTO[] zipCodes = resultZipCode.getArrayZipCode();
        	
        	for (int i = 0; i < zipCodes.length; i++) {
        		ZipCodeDTO zipCodeDTO = zipCodes[i];
				
				if(zipCodeDTO.getCodZip().equals(pCodValor)){
					
					result = zipCodeDTO.getCodZip();
					
					break;
				}
			}
        	
        	return result;
        }
        
        return result;
        
	}
	
	/**
	 * Obtiene los campos que seran mostrados como direccion
	 * 
	 * 
	 * @return listado de campos que seran mostrados como direccion
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCamposDireccionDTO r = direccionBO.obtenerCamposDireccion();
		logger.info(FIN_LOG);
		return r;
	}	
	
	/**
	 * Obtiene el valor de deuda cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el valor de deuda cliente
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final DeudaClienteDTO r = clienteBO.getDeudaCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de docs ajustes cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param fecInicio el parametro fecInicio
	 * @param fecFin el parametro fecFin
	 * 
	 * @return el valor de docs ajustes cliente
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoDocCtaCteClienteDTO getDocsAjustesCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDocCtaCteClienteDTO r = clienteBO.getDocsAjustesCliente(codCliente, fecInicio, fecFin);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDocCtaCteClienteDTO r = clienteBO.getDocsCtaCteCliente(codCliente, fecInicio, fecFin);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de docs fact cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param fecInicio el parametro fecInicio
	 * @param fecFin el parametro fecFin
	 * 
	 * @return el valor de docs fact cliente
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoDocCtaCteClienteDTO getDocsFactCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDocCtaCteClienteDTO r = clienteBO.getDocsFactCliente(codCliente, fecInicio, fecFin);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Obtiene el valor de docs pagos cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param fecInicio el parametro fecInicio
	 * @param fecFin el parametro fecFin
	 * 
	 * @return el valor de docs pagos cliente
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoDocCtaCteClienteDTO getDocsPagosCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoDocCtaCteClienteDTO r = clienteBO.getDocsPagosCliente(codCliente, fecInicio, fecFin);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Grupos x nom usuario.
	 * 
	 * @param nomUsuario el parametro nomUsuario
	 * 
	 * @return el resultado de listado grupos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoGruposDTO r = usuarioBO.gruposXNomUsuario(nomUsuario);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Limite consumo x cliente abonado.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado limite consumo dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoLimiteConsumoDTO r = limiteConsumoBO.limiteConsumoXClienteAbonado(codCliente, numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Numeros frecuentes x plan.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado numeros frecuentes dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoNumerosFrecuentesDTO r = productoBO.numerosFrecuentesXPlan(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCiudadesDTO obtenerCiudades(String codRegion, String codProvincia) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCiudadesDTO r = direccionBO.obtenerCiudades(codRegion, codProvincia);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoComunasDTO obtenerComunas(String codRegion, String codProvincia, String codCiudad)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoComunasDTO r = direccionBO.obtenerComunas(codRegion, codProvincia, codCiudad);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoProvinciasDTO obtenerProvincias(String codRegion) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProvinciasDTO r = direccionBO.obtenerProvincias(codRegion);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoRegionesDTO obtenerRegiones() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoRegionesDTO r = direccionBO.obtenerRegiones();
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoEstadosDTO obtenerEstados() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoEstadosDTO r = direccionBO.obtenerEstados();
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoPueblosDTO obtenerPueblos(String codEstado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoPueblosDTO r = direccionBO.obtenerPueblos(codEstado);
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoTiposCalleDTO obtenerTiposCalle() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoTiposCalleDTO r = direccionBO.obtenerTiposCalle();
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoTiposSuspensionDTO consultaTiposSuspension() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoTiposSuspensionDTO r = avisoSiniestroBO.consultaTiposSuspension();
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoTiposSiniestroDTO consultaTiposSiniestro() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoTiposSiniestroDTO r = avisoSiniestroBO.consultaTiposSiniestro();
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCausasSiniestroDTO consultaCausasSiniestro() throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoCausasSiniestroDTO r = avisoSiniestroBO.consultaCausasSiniestro();
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ooss ejecutadas x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado ordenes servicio dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoOrdenesServicioDTO r = oossBO.oossEjecutadasXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ooss ejecutadas x cod cuenta.
	 * 
	 * @param codCuenta el parametro codCuenta
	 * 
	 * @return el resultado de listado ordenes servicio dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoOrdenesServicioDTO r = oossBO.oossEjecutadasXCodCuenta(codCuenta);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ooss ejecutadas x num abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado ordenes servicio dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoOrdenesServicioDTO r = oossBO.oossEjecutadasXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Pago limite consumo x cliente abonado.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado pagos limite consumo dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoPagosLimiteConsumoDTO r = limiteConsumoBO.pagoLimiteConsumoXClienteAbonado(codCliente, numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Pagos x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado pagos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoPagosDTO pagosXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoPagosDTO r = pagoBO.pagosXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Planes x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado productos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoProductosDTO planesXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.planesXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Planes x num abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado productos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoProductosDTO planesXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.planesXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * @param codCliente
	 * @return
	 * @throws PortalSACException
	 */
	public ListadoProductosDTO productosXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.productosXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * @param numAbonado
	 * @return
	 * @throws PortalSACException
	 */
	public ListadoProductosDTO productosXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.productosXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/*
	 public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	 {
	 ProductoDAO dao = new ProductoDAO();
	 return dao.ssXDefectoXCodCliente(codCliente);
	 }
	 
	 */

	/**
	 * Serv sumplemetarios x abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado serv suplementarios dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoServSuplementariosDTO servSumplemetariosXAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoServSuplementariosDTO r = ssBO.servSumplemetariosXAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ss x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado productos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoProductosDTO ssXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.ssXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoServSuplementariosDTO r = productoBO.ssXDefectoXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ss x defecto plan.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado serv suplementarios dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoServSuplementariosDTO r = productoBO.ssXDefectoXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Ss x num abonado.
	 * 
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado productos dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoProductosDTO ssXNumAbonado(Long numAbonado) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoProductosDTO r = productoBO.ssXNumAbonado(numAbonado);
		logger.info(FIN_LOG);
		return r;
	}

	/**
	 * Umts abonados x cod cliente.
	 * 
	 * @param codCliente el parametro codCliente
	 * 
	 * @return el resultado de listado umts abonados dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoUmtsAbonadosDTO r = clienteBO.umtsAbonadosXCodCliente(codCliente);
		logger.info(FIN_LOG);
		return r;
	}
	
	/**
	 * Ooss Agendadas x numAbonado/codCliente/codCuenta
	 * 
	 * @param numAbonado/codCliente/codCuenta el parametro numAbonado/codCliente/codCuenta
	 * 
	 * @return el resultado de listado ordenes servicio dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoOrdenesAgendadasDTO r = oossBO.obtenerOoSsAgendadas(numDato,tipoDato);
		logger.info(FIN_LOG);
		return r;
	}
	
	/*ver como llaman a los siguientes metodos*/
	
	public Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final Boolean r = oossBO.consultaOoSsProceso(nomUsuario);
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoOrdenesProcesoDTO obtenerOoSsProceso(String nomUsuario) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		final ListadoOrdenesProcesoDTO r = oossBO.obtenerOoSsProceso(nomUsuario);
		logger.info(FIN_LOG);
		return r;
	}
	
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Obtiene los datos de un abonado
	 * throws: PortalSACException
	 * 
	 */
	
	public AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{
		
		AbonadoDTO abonadoDTO = atencionPackageBO.obtenerDatosAbonado(numAbonado);
		
		return abonadoDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaAtencion
	 * Return: ListaAtencionClienteDTO
	 * Descripcion: Obtiene las atenciones de los clientes
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{
		
		ListaAtencionClienteDTO listaAtencionClienteDTO = atencionPackageBO.consultaAtencion();
		
		return listaAtencionClienteDTO;
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: IngresoAtencion
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta una gestion de atencion
	 * throws: PortalSACException
	 * 
	 */

	public ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{
		
		ResulTransaccionDTO resulTransaccionDTO = atencionPackageBO.ingresoAtencion(resgistroAtencionDTO);
		
		return resulTransaccionDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario 
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerListDatosAbonados
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los datos de de los abonados asociados a un cliente
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{
		
		ListadoAbonadosDTO listadoAbonadosDTO = atencionPackageBO.obtenerListDatosAbonados(codCliente);
		
		return listadoAbonadosDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaCuenta
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los abonados asociados a una cuenta
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{
		
		ListadoAbonadosDTO listadoAbonadosDTO = atencionPackageBO.consultaCuenta(codCuenta);
		
		return listadoAbonadosDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-029 Ver OOSS Act/Des ejecutadas por Abonados/Clientes
	 * Developer: Jorge González
	 * Fecha: 02/08/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: servSuplXOOSS
	 * Descripcion: Obtiene los SS por el numero de OOSS seleccionado
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoServSuplxOOSSDTO servSuplXOOSS(Long numOOSS) throws PortalSACException{
		
	ListadoServSuplxOOSSDTO listadoServSuplxOOSSDTO = ssBO.servSuplXOOSS(numOOSS);
		
		return listadoServSuplxOOSSDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-005 Agregar Comentario de OOSS Reversión de Cargos
	 * Requisito: RSis_003 
	 * Caso de uso: CU-006 Agregar Comentario de OOSS Ajuste por Excepción
	 * Developer: Gabriel Moraga L.
	 * Fecha: 04/08/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Inserta un comentario
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{
		
		ResulTransaccionDTO resulTransaccionDTO = comunBO.insertComentario(comentario, numOoss);
		
		return resulTransaccionDTO;
	}
	
	/*
	 * Proyecto: P-CSR-11003 Mejoras al Portal SAC y Evolución Gestor Posventa P-CSR-11003
	 * Requisito: RSis_003 
	 * Developer: Rafael Aguero Vega.
	 * Fecha: 21/03/2011
	 * Metodo: solicitaUrlDominioPuerto
	 * Return: MuestraURLDTO
	 * Descripcion: ingresa el Codigo de orden de servicio y Solicitar URL con Dominio y Puerto
	 * throws: PortalSACException
	 * 
	 */
	
	public MuestraURLDTO solicitaUrlDominioPuerto(String strCodOrdenServ) throws PortalSACException{
		
		MuestraURLDTO urldto = comunBO.solicitaUrlDominioPuertoBO(strCodOrdenServ);
		
		return urldto;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-004 Agregar Comentario de OOSS Aviso de Siniestro
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/08/2010
	 * Metodo: insertComentarioPvIorserv
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario en la tabla PV_IORSERV
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{
		
		ResulTransaccionDTO resulTransaccionDTO = comunBO.insertComentarioPvIorserv(comentario, numOoss);
		
		return resulTransaccionDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 24/08/2010
	 * Metodo: obtenerReporteCambioEquiGene
	 * Return: ListadoReporteCamEquiGenDTO
	 * Descripcion: Obtiene informacion por rango de fechas y causal de cambio de equipo
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{
		ListadoReporteCamEquiGenDTO listadoReporteCamEquiGenDTO = reporteBO.obtenerReporteCambioEquiGene(fechaDesde, fechaHasta, codCausalCam);
		return listadoReporteCamEquiGenDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-046 Generar Reporte de ingreso de equipos y status del equipo
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReporteIngrStatusEqui
	 * Return: ListadoReporteIngrStatusEquiDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{
		ListadoReporteIngrStatusEquiDTO listadoReporteIngrStatusEquiDTO = reporteBO.obtenerReporteIngrStatusEqui(fechaDesde, fechaHasta);
		return listadoReporteIngrStatusEquiDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-047 Generar Reporte de préstamos de equipos internos
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReportePresEquiInt
	 * Return: ListadoReportePresEquiIntDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{
		ListadoReportePresEquiIntDTO listadoReportePresEquiIntDTO = reporteBO.obtenerReportePresEquiInt(fechaDesde, fechaHasta);
		return listadoReportePresEquiIntDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 27/08/2010
	 * Metodo: obtenerCausalCambio
	 * Return: ListaCausalCambioDTO
	 * Descripcion: Obtiene las causales de cambio
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{
		ListaCausalCambioDTO listaCausalCambioDTO = reporteBO.obtenerCausalCambio();
		return listaCausalCambioDTO;
	}
	
	public ParametrosKioscoDTO obtenerParametroKiosco() throws PortalSACException{
		
		ParametrosKioscoDTO result = new ParametrosKioscoDTO(); 
		
		GedParametrosDTO parametroFlag = new GedParametrosDTO();
		parametroFlag.setCodModulo("GA");
		parametroFlag.setCodProducto(new Integer(1));
		parametroFlag.setNomParametro("FLAG_SAC_KIOSCO");
		
		try{
			
			String flagKiosco = generalBO.obtenerValorGedParametros(parametroFlag);
			
			result.setFlagKiosco(flagKiosco);
		
		}catch(PortalSACException ex){
			
			result.setFlagKiosco("FALSE");
			
			return result;
		}
		
		GedParametrosDTO parametroDominio = new GedParametrosDTO();
		parametroDominio.setCodModulo("GA");
		parametroDominio.setCodProducto(new Integer(1));
		parametroDominio.setNomParametro("DOMINIO_KIOSCO");
		
		String dominioKiosco = generalBO.obtenerValorGedParametros(parametroDominio);
		
		result.setDominioKiosco(dominioKiosco);
		
		return result;
		
	}
}