package com.tmmas.cl.scl.portalventas.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;

/**
 * @author JIB
 */
public class DatosLineaScoringAction extends DispatchAction {

	private static final String MENSAJE_ERROR_SCORING = "Ocurrió un error al ejecutar servicio Scoring.";

	private static final String MENSAJE_ERROR_INSERTAR_ESTADO_SCORING = "Ocurrió un error al actualizar estado Scoring.";

	private static final String MENSAJE_ERROR_INSERTAR_RESULTADO_SCORING = "Ocurrió un error al guardar resultado Scoring.";

	private static final String MENSAJE_ERROR_CAPACIDAD_PAGO = "Ocurrió un error al calcular capacidad de pago.";

	private static final String MENSAJE_ERROR_VENDEDOR = "Ocurrió un error al obtener vendedor.";

	private static final String CLAVE_LINEAS_SESSION = "ArrayListLineas-Session";

	private final Logger logger = Logger.getLogger(DatosLineaScoringAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private PlanesAdicionalesScoringForm planesAdicionalesScoringForm;

	private PlanesAdicionalesScoringForm getPlanesAdicionalesScoringForm(HttpServletRequest request) {
		return planesAdicionalesScoringForm == null ? (PlanesAdicionalesScoringForm) request.getSession().getAttribute(
				"PlanesAdicionalesScoringForm") : planesAdicionalesScoringForm;
	}

	private SolicitudScoringAjaxDTO getSolicitudScoringAjaxDTOEnSession(HttpServletRequest request) {
		return (SolicitudScoringAjaxDTO) request.getSession().getAttribute("solicitudSel");
	}

	private ArrayList getLineasEnSession(HttpSession request) {
		return (ArrayList) request.getAttribute(CLAVE_LINEAS_SESSION);
	}

	private void setLineasEnSession(HttpSession session, ArrayList arrayListSS) {
		session.setAttribute(CLAVE_LINEAS_SESSION, arrayListSS);
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		SolicitudScoringAjaxDTO dto = getSolicitudScoringAjaxDTOEnSession(request);
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		ScoreClienteDTO scoreClienteDTO = delegate.getSolicitudScoring(new Long(dto.getNroSolScoring()));
		logger.debug(scoreClienteDTO.toString());
		f.setScoreClienteDTO(scoreClienteDTO);

		if (f.getArrayGrpPrestacion() == null) {
			f.setArrayGrpPrestacion(delegate.getGruposPrestacion());
		}
		if (f.getArrayRegiones() == null) {
			f.setArrayRegiones(delegate.getArrayRegiones());
		}
		if (f.getArrayTiposSeguro() == null) {
			final SeguroDTO[] seguros = delegate.getSeguros();
			f.setArrayTiposSeguro(seguros);
		}
		if (f.getArrayIdentificadorUsuario() == null) {
			f.setArrayIdentificadorUsuario(delegate.getTipoIdentificadoresCiviles());
		}
		if (f.getArrayMonedas() == null) {
			final MonedaDTO[] monedas = delegate.listarMonedas();
			f.setArrayMonedas(monedas);
		}
		/*
		if (f.getArrayCampanasVigentes() == null) {
			f.setArrayCampanasVigentes(delegate.getListadoCampanasVigentes());
		}*/
		
		setLineasEnSession(request.getSession(), new ArrayList());

		f.setIndEquipo("E");
		f.setCodOperadora(delegate.getCodigoOperadora());
		int nroLineasActivas = (delegate.consultaVentasCliente(new Long(f.getCodCliente()))).intValue();
		logger.debug("nroLineasActivas [" + nroLineasActivas + "]");
		String aplicaRenovacion = (nroLineasActivas > 0) ? "1" : "0";
		f.setAplicaRenovacion(aplicaRenovacion);

		String codModVenta = f.getScoreClienteDTO().getDatosGeneralesScoringDTO().getCodModVenta().toString();
		f.setFlgAplicaSeguro(String.valueOf(delegate.getIndSeguro(new Long(codModVenta))));

		BusquedaClienteDTO busquedaClienteDTO = new BusquedaClienteDTO();
		busquedaClienteDTO.setCodCliente(new Long(f.getCodCliente()).toString());
		ClienteDTO cliente = delegate.getDatosCliente(busquedaClienteDTO)[0];
		f.setDescripcionColor(cliente.getDescripcionColor());
		f.setDescripcionSegmento(cliente.getDescripcionSegmento());
		inicializarLinea(f, request.getSession());
		f.setFlgActivarBtnFinalizar("0");
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}

	private void inicializarLinea(DatosLineaScoringForm f, HttpSession session) throws Exception {
		logger.info("inicializarLinea, inicio");
		f.setCodCreditoConsumo(global.getValor("codigo.credito.consumo.nousado"));
		f.setCodGrupoCobroServ(global.getValor("codigo.grupo.cobroserv.cobroscelular"));
		f.setCodTelefoniaMovil(global.getValor("grupo.prestacion.movil"));
		f.setCodTelefoniaFija(global.getValor("grupo.prestacion.fija"));
		f.setCodInternet(global.getValor("grupo.prestacion.internet"));
		f.setCodCarrier(global.getValor("grupo.prestacion.carrier"));
		final String claveGruposSinLC = "cod.grupo.prestacion.limiteconsumo.noaplica";
		final String gruposSinLC = global.getValor(claveGruposSinLC);
		logger.debug("gruposSinLC [" + gruposSinLC + "]");
		f.setGrpPrestacionesSinLC(gruposSinLC);

		final String clavePlanesSinLC = "cod.tipoproducto.plantarifario.limiteconsumo.noaplica";
		final String planesSinLC = global.getValor(clavePlanesSinLC);
		logger.debug("planesSinLC [" + planesSinLC + "]");
		f.setTiposPlanTarifarioSinLC(planesSinLC);

		f.setCodGrpPrestacion(""); // Combo

		f.setCodTipoPrestacion(""); // Combo
		f.setCodTipoPrestacionSeleccionada(null);

		BusquedaClienteDTO busquedaClienteDTO = new BusquedaClienteDTO();
		busquedaClienteDTO.setCodCliente(new Long(f.getCodCliente()).toString());
		ClienteDTO cliente = delegate.getDatosCliente(busquedaClienteDTO)[0];
		String codCalificacion = cliente.getCodCalificacion();
		logger.debug("codCalificacion [" + codCalificacion + "]");
		f.setCodCalificacion(codCalificacion);

		f.setFiltroPlan("");// Combo
		f.setIndRenovacion("0");

		String codOficina = f.getScoreClienteDTO().getDatosGeneralesScoringDTO().getCodOficina();
		OficinaDTO oficinaDTO = delegate.getDireccionOficina(codOficina);
		logger.debug(oficinaDTO.toString());
		f.setCodRegion(oficinaDTO.getCodigoRegion());
		f.setCodProvinciaSeleccionada(oficinaDTO.getCodigoProvincia());
		f.setCodCiudadSeleccionada(oficinaDTO.getCodigoCiudad());

		f.setVigenciaSeguro(null);
		f.setProcedenciaNumero(null);

		f.setCodCelda(""); // Combo Ajax
		f.setCodCeldaSeleccionada(null);

		f.setCodCentral(""); // Combo
		f.setCodCentralSeleccionada(null);

		f.setCodUsoLinea(""); // Combo
		f.setCodUsoLineaSeleccionado(null);

		f.setCodTipoTerminal("");// Combo
		f.setCodTipoTerminalSeleccionado(null);

		f.setCodPlanTarif("");// Combo
		f.setCodPlanTarifSeleccionado(null);

		f.setCodLimiteConsumo("");// Combo
		f.setCodLimiteConsumoSeleccionado(null);
		
		f.setCodCampanaVigente("");// Combo
		f.setCodCampanaVigenteSeleccionada(null);

		f.setCodPlanServicio("");// Combo
		f.setCodPlanServicioSeleccionado(null);

		f.setCodSeguro("");// Combo

		f.setCodArticuloEquipo("");// Combo

		f.setCodCausaDescuento("");
		f.setCodCausaDescuentoSeleccionada(null);

		f.setCantidadLineas(getLineasEnSession(session).size());
		logger.info("inicializarLinea, fin");
	}

	public ActionForward serviciosSupl(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("serviciosSupl, inicio");
		logger.info("serviciosSupl, fin");
		return mapping.findForward("serviciosSupl");
	}

	public ActionForward agregarLinea(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("agregarLinea, inicio");
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		try {
			LineaSolicitudScoringDTO linea = f.getLinea();
			logger.debug("linea.getCodCampanaVigente() [" + linea.getCodCampanaVigente() + "]");
			logger.debug("linea.toString() [" + linea.toString() + "]");
			ArrayList arrayListSSSS = linea.getArrayListServSup();
			if (arrayListSSSS != null) {
				for (Iterator i = arrayListSSSS.iterator(); i.hasNext();) {
					ListadoSSOutDTO ss = (ListadoSSOutDTO) i.next();
					logger.debug(ss.toString());
				}
				linea.setArrayListServSup(arrayListSSSS);
			}
			else {
				logger.debug("arrayListSS tiene valor [null]");
			}

			if (this.getPlanesAdicionalesScoringForm(request) != null) {
				final String csvPA = this.getPlanesAdicionalesScoringForm(request).getProductosSeleccionadosEnCSV();
				this.getPlanesAdicionalesScoringForm(request).setProductosSeleccionadosEnCSV(null);
				logger.debug("csvPA [" + csvPA + "]");
				if (csvPA != null && !csvPA.equals("")) {
					String[] seleccionados = csvPA.split(",");
					final int cantPASeleccionados = seleccionados.length;
					logger.debug("Cant. PP.AA. Seleccionados [" + cantPASeleccionados + "]");
					ProductoOfertadoDTO[] arrayPA = new ProductoOfertadoDTO[cantPASeleccionados];
					for (int i = 0; i < cantPASeleccionados; i++) {
						final String[] splitted = seleccionados[i].split("=");
						ProductoOfertadoDTO dto = arrayPA[i] = new ProductoOfertadoDTO();
						dto.setCodProductoOfertado(Long.parseLong(splitted[0]));
						dto.setCantidad(Long.parseLong(splitted[1]));
						dto.setCodCliente(f.getCodCliente());
					}
					linea.setArrayPA(arrayPA);
					if (linea.getArrayPA() != null) {
						logger.debug("linea.getArrayPA().length [" + linea.getArrayPA().length + "]");
						for (int i = 0; i < linea.getArrayPA().length; i++) {
							logger.debug("linea.getArrayPA()[i].toString() [" + linea.getArrayPA()[i].toString() + "]");
						}
					}
					else {
						logger.debug("linea.getArrayPA() tiene valor [null]");
					}
				}
				else {
					linea.setArrayPA(null);
				}
			}
			else {
				linea.setArrayPA(null);
			}
			
			/*inicio JMO 16-11-2010 INC-155400
			 * Si no existen Planes Adicionales seleccionados, se obtienen los planes opcionales
			 * obligatorios al Plan Tarifario.
			 * */
			
			if(linea.getArrayPA() == null){
			
				final String codCanal = global.getValor("canal.pa.venta");
				final String nivel = global.getValor("nivel.pa.abonado");
				final String codPlanTarif = linea.getCodPlantarif();
				final String codPrestacion = linea.getCodPrestacion();
				
				ProductoOfertadoDTO[] productosOblig = delegate.obtenerProductosObligatoriosPT(codPlanTarif, codCanal,
									  nivel, codPrestacion);
				
				if(productosOblig != null){
					
					int cantPAObligatorios = productosOblig.length;
					
					ProductoOfertadoDTO[] arrayPA = new ProductoOfertadoDTO[cantPAObligatorios];
					for (int i = 0; i < cantPAObligatorios; i++) {
						ProductoOfertadoDTO dto = arrayPA[i] = new ProductoOfertadoDTO();
						dto.setCodProductoOfertado(productosOblig[i].getCodProductoOfertado());
						dto.setCantidad(productosOblig[i].getCantidad());
						dto.setCodCliente(f.getCodCliente());
					}
					linea.setArrayPA(arrayPA);
					
					if (linea.getArrayPA() != null) {
						logger.debug("PA_Obligatorios linea.getArrayPA().length [" + linea.getArrayPA().length + "]");
						for (int i = 0; i < linea.getArrayPA().length; i++) {
							logger.debug("PA_Obligatorios linea.getArrayPA()[i].toString() [" + linea.getArrayPA()[i].toString() + "]");
						}
					}else {
						logger.debug("PA_Obligatorios linea.getArrayPA() tiene valor [null]");
					}
				}else{
					logger.debug("No existen PA obligatorios configurados. productosOblig = null ");
				}
			}//fin JMO 16-11-2010 INC-155400
			
			ArrayList lineasEnSession = getLineasEnSession(request.getSession());
			lineasEnSession.add(linea);
			f.setLinea(new LineaSolicitudScoringDTO());
			inicializarLinea(f, request.getSession());
			f.setFlgActivarBtnFinalizar("1");
			// f.setFlgConsultaFinalizar("1");
			request.getSession().setAttribute("listaServiciosAct", new ArrayList());
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			request.setAttribute("mensajeError", "Ocurrió un error al agregar línea " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("[Exception] Ocurrió un error al agregar línea " + mensaje);
		}
		logger.info("agregarLinea, fin");
		return mapping.findForward("inicio");
	}

	private void obtieneImportes(ScoreClienteDTO dto) {
		logger.info("calculaImporteScoring, inicio");
		ArrayList lineas = dto.getLineas();
		for (Iterator i = lineas.iterator(); i.hasNext();) {
			LineaSolicitudScoringDTO linea = (LineaSolicitudScoringDTO) i.next();
			logger.info("calculaImportesLinea, inicio");
			Double importeArticulo = new Double(0);
			linea.setImporteArticulo(importeArticulo);
			Double importeSeguro = new Double(0);
			linea.setImporteSeguro(importeSeguro);
			logger.info("calculaImportesLinea, fin");
		}
		logger.info("calculaImporteScoring, fin");
	}

	/**
	 * @author JIB
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward finalizarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("finalizarSolicitud, inicio");
		ScoreClienteDTO dto = null;
		ResultadoScoreClienteDTO resultadoScoringDTO = null;
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		dto = f.getScoreClienteDTO();
		dto.setLineas(getLineasEnSession(request.getSession()));
		final String tipoProductoScoring = global.getValorExterno("scoring.tipo.producto.residencial").trim();
		logger.debug("tipoProductoScoring  [" + tipoProductoScoring + "]");
		dto.setTip_producto(tipoProductoScoring);
		obtieneImportes(dto);
		UsuarioSCLDTO usuarioSCLDTO = null;
		final String estadoRechazado = global.getValorExterno("scoring.estado.rechazado");
		final String estadoEvaluado = global.getValorExterno("scoring.estado.evaluado");
		final String scoringOK = global.getValorExterno("scoring.ok");

		ParametrosGlobalesDTO paramGlobal = null;
		try {
			logger.debug("0. Obtiene codigo de vendedor del usuario");
			paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
			usuarioSCLDTO = new UsuarioSCLDTO();
			usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
			usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);
		}
		catch (Exception e) {
			return irAPaginaError(mapping, request, e, MENSAJE_ERROR_VENDEDOR);
		}
		try {
			logger.debug("1. Actualiza Datos Scoring, líneas y calcula capacidad de pago");
			Double capacidadPago = delegate.calcularCapacidadPago(dto);
			logger.debug("capacidadPago [" + capacidadPago + "]");
			dto.setCapacidad_pago(capacidadPago.toString());
		}
		catch (Exception e) {
			return irAPaginaError(mapping, request, e, MENSAJE_ERROR_CAPACIDAD_PAGO);
		}
		try {
			logger.debug("2. Ejecuta servicio web Scoring");
			resultadoScoringDTO = delegate.getSujetoFisico(dto);
			resultadoScoringDTO.setNumSolScoring(f.getNumSolScoring());
			logger.debug(resultadoScoringDTO.toString());
		}
		catch (Exception e) {
			try {
				logger.debug("2.1. Inserta resultado por error en ejecución servicio web Scoring");
				resultadoScoringDTO = new ResultadoScoreClienteDTO();
				resultadoScoringDTO.setNumSolScoring(f.getNumSolScoring());
				resultadoScoringDTO.setMensaje("14_ERROR/SCORING - " + MENSAJE_ERROR_SCORING + e.getMessage());
				resultadoScoringDTO.setPunteo("SIN REFERENCIA");
				delegate.insertarResultadoScoreCliente(resultadoScoringDTO);
			}
			catch (Exception e1) {
				return irAPaginaError(mapping, request, e1, MENSAJE_ERROR_INSERTAR_RESULTADO_SCORING);
			}
			try {
				EstadoScoringDTO nuevoEstadoScoringDTO = new EstadoScoringDTO();
				nuevoEstadoScoringDTO.setCodVendedor(usuarioSCLDTO.getCodigoVendedor());
				nuevoEstadoScoringDTO.setNumSolScoring(f.getNumSolScoring());
				nuevoEstadoScoringDTO.setCodEstado(estadoRechazado);
				logger.debug(nuevoEstadoScoringDTO.toString());
				logger.debug("2.2. Inserta estado rechazado por error en ejecución servicio web Scoring");
				delegate.insertaEstadoScoring(nuevoEstadoScoringDTO);
			}
			catch (Exception e1) {
				return irAPaginaError(mapping, request, e1, MENSAJE_ERROR_INSERTAR_ESTADO_SCORING);
			}
			return finalizarConError(mapping, request, e, MENSAJE_ERROR_SCORING);
		}
		try {
			logger.debug("3. Guarda resultado");
			delegate.insertarResultadoScoreCliente(resultadoScoringDTO);
		}
		catch (Exception e) {
			return irAPaginaError(mapping, request, e, MENSAJE_ERROR_INSERTAR_RESULTADO_SCORING);
		}
		try {
			logger.debug("4. Inserta nuevo estado evaluado o rechazado");
			EstadoScoringDTO nuevoEstadoScoringDTO = new EstadoScoringDTO();
			nuevoEstadoScoringDTO.setCodVendedor(usuarioSCLDTO.getCodigoVendedor());
			nuevoEstadoScoringDTO.setNumSolScoring(f.getNumSolScoring());
			logger.debug("valorScoringOK [" + scoringOK + "]");
			final String mensajeResultado = resultadoScoringDTO.getMensaje();
			logger.debug("mensajeResultado [" + mensajeResultado + "]");
			nuevoEstadoScoringDTO.setCodEstado(mensajeResultado.equals(scoringOK) ? estadoEvaluado : estadoRechazado);
			logger.debug(nuevoEstadoScoringDTO.toString());
			delegate.insertaEstadoScoring(nuevoEstadoScoringDTO);
		}
		catch (Exception e) {
			return irAPaginaError(mapping, request, e, MENSAJE_ERROR_INSERTAR_ESTADO_SCORING);
		}
		setLineasEnSession(request.getSession(), null);
		logger.info("finalizarSolicitud [OK], fin");
		return mapping.findForward("finalizarSolicitud"); // Sale OK
	}

	private ActionForward finalizarConError(ActionMapping mapping, HttpServletRequest request, Exception e,
			String mensajeError) {
		logger.info("finalizarConError, inicio");
		mensajeError += " " + "[" + e.getMessage() + "]";
		logger.error(mensajeError);
		logger.error(StackTraceUtl.getStackTrace(e));
		request.setAttribute("mensajeError", mensajeError);
		setLineasEnSession(request.getSession(), null);
		logger.info("finalizarConError, fin");
		return mapping.findForward("finalizarSolicitud"); //
	}

	private ActionForward irAPaginaError(ActionMapping mapping, HttpServletRequest request, Exception e,
			String mensajeError) {
		logger.info("irAPaginaError, inicio");
		if (e.getClass().equals(VentasException.class)) {
			mensajeError += " " + "[" + ((VentasException) e).getDescripcionEvento() + "]";
		}
		logger.error(mensajeError);
		logger.error(StackTraceUtl.getStackTrace(e));
		request.setAttribute("mensajeError", mensajeError);
		setLineasEnSession(request.getSession(), null);
		logger.info("irAPaginaError, fin");
		return mapping.findForward("irAPaginaError"); // Sale con Error. No alcanza a llamar a Scoring
	}

	public ActionForward anterior(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession sesion = request.getSession(false);
		logger.info("anterior, inicio");
		logger.info("anterior, fin");
		sesion.removeAttribute("listaSolicitudes");
		return mapping.findForward("anterior");
	}

	public ActionForward cancelarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarSolicitud, inicio");
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		EstadoScoringDTO estadoCancelado = new EstadoScoringDTO();
		final String estadoDestino = global.getValorExterno("scoring.estado.cancelado");
		logger.debug("estadoDestino [" + estadoDestino + "]");
		estadoCancelado.setCodEstado(estadoDestino);
		estadoCancelado.setNumSolScoring(f.getNumSolScoring());
		estadoCancelado.setCodVendedor(usuarioSCLDTO.getCodigoVendedor());
		delegate.insertaEstadoScoring(estadoCancelado);
		logger.info("cancelarSolicitud, fin");
		return mapping.findForward("finalizarSolicitud");
	}

	public ActionForward irAPlanesAdicionales(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("irAPlanesAdicionales, inicio");
		logger.info("irAPlanesAdicionales, fin");
		return mapping.findForward("irAPlanesAdicionales");
	}

	public ActionForward cargarServiciosSupl(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cargarServiciosSupl, inicio");
		ArrayList arrayListSSSS = (ArrayList) request.getSession().getAttribute("listaServiciosAct");
		final int cantSSSeleccionados = arrayListSSSS.size();
		logger.debug("Cant. SS.SS. Seleccionados [" + cantSSSeleccionados + "]");
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		f.getLinea().setArrayListServSup(arrayListSSSS);
		logger.info("cargarServiciosSupl, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarPAScoring, inicio");
		logger.info("aceptarPAScoring, fin");		
		return mapping.findForward("inicio");
	}

	public ActionForward cancelarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarPAScoring, inicio");
		DatosLineaScoringForm f = (DatosLineaScoringForm) form;
		f.getLinea().setArrayPA(null);
		logger.info("cancelarPAScoring, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward volverPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("volverPAScoring, inicio");
		logger.info("volverPAScoring, fin");
		return mapping.findForward("inicio");
	}
}
