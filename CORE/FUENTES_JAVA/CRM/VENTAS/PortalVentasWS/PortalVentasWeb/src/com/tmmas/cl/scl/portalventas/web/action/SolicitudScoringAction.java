package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;
import java.text.DateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.axis.AxisFault;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DominioScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.SolicitudScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;

public class SolicitudScoringAction extends DispatchAction {

	private static final String ERROR_TARJETA_EXISTE = "El N° de Tarjeta se encuentra asociado a una solicitud scoring de otro cliente. No se puede continuar.";

	private static final String ERROR_SESION = "Sesión Terminada";

	private static final String ERROR_NIT = "El cliente no tiene registrado NIT. No se puede continuar.";

	private static final String ERROR_CLIENTE_PREPAGO = "El cliente es de tipo prepago. Scoring sólo aplica a particulares.";

	private static final String ERROR_CLIENTE_EMPRESA = "El cliente es de tipo empresa. Scoring sólo aplica a particulares.";

	private static final String ERROR_PRIMER_APELLIDO = "El cliente no tiene registrado primer apellido. No se puede continuar.";

	private static final String ERROR_FECHA_NACIMIENTO = "El cliente no tiene registrada fecha de nacimiento. No se puede continuar.";

	private static final String ERROR_SEGUNDO_APELLIDO = "El cliente no tiene registrado segundo apellido. No se puede continuar.";

	private static final String ERROR_SERVICIO_WEB_SCORING = "No se pudo acceder al servicio web Scoring.";

	protected PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private final Logger logger = Logger.getLogger(SolicitudScoringAction.class);

	private Global global = Global.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		SolicitudScoringForm f = (SolicitudScoringForm) form;
		f.setMensajeError(null);
		f.setNumSolScoringEnProceso(null);

		f.setScoreClienteDTO(new ScoreClienteDTO()); //Resetea todos los campos
		Long codVendedor = new Long(0);
		Long codVendedorDealer = new Long(0);
		try {
			validarSesion(request);
			final ClienteAjaxDTO clienteAjaxDTO = (ClienteAjaxDTO) request.getSession(false).getAttribute("clienteSel");
			final long codCliente = Long.parseLong(clienteAjaxDTO.getCodigoCliente());
			logger.debug("codCliente [" + codCliente + "]");
			final ClienteDTO clienteDTO = buscarDatosCliente(codCliente);
			final String tipoCliente = clienteDTO.getTipoCliente();
			logger.debug("tipoCliente [" + tipoCliente + "]");
			if (tipoCliente.equals(global.getValor("tipo.cliente.empresa"))
					||tipoCliente.equals(global.getValor("tipo.cliente.pyme"))) {
				throw new VentasException(ERROR_CLIENTE_EMPRESA);
			}
			if (tipoCliente.equals(global.getValor("tipo.cliente.prepago"))) {
				throw new VentasException(ERROR_CLIENTE_PREPAGO);
			}

			final DatosVentaForm datosVentaForm = (DatosVentaForm) request.getSession(false).getAttribute(
					"DatosVentaForm");
			final String codDistribuidorVForm = datosVentaForm.getCodDistribuidor();
			final String codVendedorVForm = datosVentaForm.getCodVendedor();
			logger.debug("codDestribuidor en formulario Datos Venta [" + codDistribuidorVForm + "]");
			logger.debug("codVendedor en formulario Datos Venta [" + codVendedorVForm + "]");

			codVendedor = Utilidades.notEmpty(codDistribuidorVForm) ? new Long(codDistribuidorVForm) : new Long(0);
			codVendedorDealer = Utilidades.notEmpty(codVendedorVForm) ? new Long(codVendedorVForm) : new Long(0);

			f.setArrayDominioEstadoCivil(delegate.obtenerDominioEstadoCivil());
			f.setArrayDominioNacionalidad(delegate.obtenerDominioNacionalidad());
			f.setArrayDominioNivelAcademico(delegate.obtenerDominioNivelAcademico());
			f.setArrayDominioTipoEmpresa(delegate.obtenerDominioTipoEmpresa());
			f.setArrayDominioTipoDocumento(delegate.obtenerDominioTipoDocumento());
			f.setArrayDominioTipoTarjeta(delegate.obtenerDominioTipoTarjeta());

			final String codTipIdentNIT = global.getValor("codigo.identificador.NIT").trim();
			logger.debug("codTipIdentNIT [" + codTipIdentNIT + "]");

			String nit = null;
			String codTipIdent1 = null;
			String codTipIdent2 = null;
			if (clienteAjaxDTO != null) {
				codTipIdent1 = clienteAjaxDTO.getCodigoTipoIdentificacion();
			}
			if (clienteDTO != null) {
				codTipIdent2 = clienteDTO.getCodigoTipIdent2();
			}
			if (codTipIdent1 != null && codTipIdent1.equals(codTipIdentNIT)) {
				nit = clienteAjaxDTO.getNumeroIdentificacion();
			}
			else if (codTipIdent2 != null && codTipIdent2.equals(codTipIdentNIT)) {
				nit = clienteDTO.getNumIdent2();
			}
			logger.debug("nit [" + nit + "]");
			if (!Utilidades.emptyOrNull(nit)) {
				f.setNit(nit);
			}
			else {
				throw new VentasException(ERROR_NIT);
			}
			final Date fechaNacimientoDate = clienteDTO.getFechaNacimientoDate();
			final DateFormat df = DateFormat.getDateInstance(DateFormat.LONG);

			logger.debug("df.format(fechaNacimientoDate) [" + df.format(fechaNacimientoDate) + "]");
			if (fechaNacimientoDate != null) {
				f.setFecha_nacimiento(fechaNacimientoDate);
			}
			else {
				throw new VentasException(ERROR_FECHA_NACIMIENTO);
			}
			final String primerApellido = clienteDTO.getNombreApellido1();
			logger.debug("primerApellido [" + primerApellido + "]");
			if (primerApellido != null && !primerApellido.equals("")) {
				f.setPrimer_apellido(primerApellido);
			}
			else {
				throw new VentasException(ERROR_PRIMER_APELLIDO);
			}
			final String segundoApellido = clienteDTO.getNombreApellido2();
			logger.debug("segundoApellido [" + segundoApellido + "]");
			if (segundoApellido != null && !segundoApellido.equals("")) {
				f.setSegundo_apellido(segundoApellido);
			}
			else {
				throw new VentasException(ERROR_SEGUNDO_APELLIDO);
			}

			final double ingresosMensuales = clienteDTO.getIngresosMensuales().doubleValue();
			logger.debug("ingresosMensuales [" + ingresosMensuales + "]");
			f.setIngresosMensuales(ingresosMensuales);

			f.setCodCliente(new Long(clienteAjaxDTO.getCodigoCliente()).longValue());
			logger.debug("f.getCodCliente() [" + f.getCodCliente() + "]");
			String[] nombres = clienteAjaxDTO.getNombreCliente().split(" ");
			f.setPrimer_nombre(nombres[0]);
			String segundoNombre = "";
			for (int i = 1; i < nombres.length; i++) {
				segundoNombre += i < nombres.length - 1 ? nombres[i].trim() + " " : nombres[i].trim();
			}

			f.setSegundo_nombre(segundoNombre);
			final ParametrosGlobalesDTO paramGlobal = ((ParametrosGlobalesDTO) request.getSession(false).getAttribute(
					"paramGlobal"));
			f.setNomUsuarioOra(paramGlobal.getCodUsuario());
			f.setCodOficina(datosVentaForm.getCodOficina());
			f.setCodTipComis(datosVentaForm.getCodTipoComisionista());
			f.setCodVendedorDealer(codVendedorDealer);
			f.setCodVendedor(codVendedor.longValue());
			f.setIndVtaExterna(datosVentaForm.getIndVtaExterna());
			f.setCodTipContrato(datosVentaForm.getCodTipoContrato());
			f.setCodModVenta(new Integer(datosVentaForm.getCodModalidadVenta()));
			f.setCodPeriodo(datosVentaForm.getCodPeriodo());
			f.setCodCuota(datosVentaForm.getNumCuotas());
			f.setFacturaTercero(datosVentaForm.getFacturaTercero());
			f.setMontoPreautorizado(new Double(datosVentaForm.getMontoPreAutorizado()));

			final String cedulaM = global.getValorExterno("scoring.documento.CEDULA.mandatorio");
			f.setIngresoCedulaMandatorio(Utilidades.notEmpty(cedulaM) ? cedulaM : "NO");

			final String pasaporteM = global.getValorExterno("scoring.documento.PASAPORTE.mandatorio");
			f.setIngresoPasaporteMandatorio(Utilidades.notEmpty(pasaporteM) ? pasaporteM : "NO");

			f.setBancos(delegate.getBancos());
			f.setTiposTarjetaSCL(delegate.getTiposTarjetaSCL());

			f.setRangoMeses(Utilidades.getRangoMeses());
			f.setRangoAnios(Utilidades.getRangoAnios());

		}
		catch (AxisFault ex) {
			logger.error(StackTraceUtl.getStackTrace(ex));
			f.setMensajeError(ERROR_SERVICIO_WEB_SCORING);
			return mapping.findForward("errorSolicitudScoring");
		}
		catch (VentasException ex) {
			logger.error(StackTraceUtl.getStackTrace(ex));
			f.setMensajeError(ex.getMessage());
			return mapping.findForward("errorSolicitudScoring");
		}
		catch (Exception ex) {
			logger.error(StackTraceUtl.getStackTrace(ex));
			f.setMensajeError(ex.getMessage());
			return mapping.findForward("errorSolicitudScoring");
		}
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward finalizarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws RemoteException, VentasException {
		logger.info("finalizarSolicitud, inicio");
		SolicitudScoringForm f = (SolicitudScoringForm) form;
		obtenerDescripciones(f);
		final String codTipoTarjeta = f.getCodTipoTarjeta();
		final String codTipoTarjetaSCL = f.getCodTipoTarjetaSCL();
		final String numTarjeta = f.getNumTarjeta();
		final String desTipoTarjeta = f.getDesTipoTarjeta();
		final long codCliente = f.getCodCliente();

		if (!Utilidades.emptyOrNull(codTipoTarjeta)) {
			f.setAplicaTarjeta("SI");
			ScoreClienteDTO enProceso = null;
			try {
				enProceso = buscarSolicitudEnProceso(codTipoTarjetaSCL, numTarjeta, codCliente);
				if (enProceso != null) {
					throw new VentasException(ERROR_TARJETA_EXISTE);
				}
			}
			catch (Exception e) {
				logger.error(StackTraceUtl.getStackTrace(e));
				f.setNumTarjeta(numTarjeta);
				f.setDesTipoTarjeta(desTipoTarjeta);
				f.setMensajeError(e.getMessage());
				f.setNumSolScoringEnProceso(new Long(enProceso.getNumSolScoring()));
				f.setCodClienteSolScoringEnProceso(enProceso.getCodCliente());
				return mapping.findForward("errorSolicitudScoring");
			}
		}
		else {
			f.setAplicaTarjeta("NO");
			f.setMesVencimientoTarjeta(null);
			f.setAnioVencimientoTarjeta(null);
			f.setCodBancoTarjeta(null);
			f.setCodTipoTarjeta(null);
			f.setDesTipoTarjeta(null);
			f.setNumTarjeta(null);
			f.setCodTipoTarjetaSCL(null);
		}

		ScoreClienteDTO dto = f.getScoreClienteDTO();
		logger.debug(dto.toString());

		try {
			EstadoScoringDTO estadoScoringDTO = new EstadoScoringDTO();
			estadoScoringDTO.setCodVendedor(f.getCodVendedor());
			estadoScoringDTO.setCodEstado(global.getEstadoScoringPendienteEnviar());
			final long numSolScoring = delegate.insertarSolicitudScoring(dto, estadoScoringDTO);
			logger.debug("numSolScoring [" + numSolScoring + "]");
			f.setNumSolScoring(numSolScoring);
			SolicitudScoringAjaxDTO solicitudSel = new SolicitudScoringAjaxDTO();
			solicitudSel.setNroSolScoring(new Long(numSolScoring).toString());
			request.getSession().setAttribute("solicitudSel", solicitudSel);
		}
		catch (Exception e) {
			f.setMensajeError(e.getMessage());
			return mapping.findForward("errorSolicitudScoring"); //Finaliza con error. No desbloquea Vendedor
		}
		final Long codVendedor = new Long(f.getCodVendedor());
		if (codVendedor != null && codVendedor.longValue() > 0) {
			delegate.desbloquearVendedor(codVendedor.toString());
		}

		logger.info("finalizarSolicitud, fin");
		return mapping.findForward("finalizarSolicitud"); //Finaliza OK . Vendedor desbloqueado
	}

	private void obtenerDescripciones(SolicitudScoringForm f) {
		logger.info("obtenerDescripciones, inicio");
		f.setDesEstadoCivil(DominioScoringDTO.getDescripcion(f.getArrayDominioEstadoCivil(), f.getCodEstadoCivil()));
		f.setDesNacionalidad(DominioScoringDTO.getDescripcion(f.getArrayDominioNacionalidad(), f.getCodNacionalidad()));
		f.setDesNivelAcademico(DominioScoringDTO.getDescripcion(f.getArrayDominioNivelAcademico(), f
				.getCodNivelAcademico()));
		f.setDesTipoEmpresa(DominioScoringDTO.getDescripcion(f.getArrayDominioTipoEmpresa(), f.getCodTipoEmpresa()));
		f.setDesTipoDocumento(DominioScoringDTO.getDescripcion(f.getArrayDominioTipoDocumento(), f
				.getCodTipoDocumento()));
		f.setDesTipoTarjeta(DominioScoringDTO.getDescripcion(f.getArrayDominioTipoTarjeta(), f.getCodTipoTarjeta()));
		logger.info("obtenerDescripciones, fin");
	}

	public ActionForward anterior(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anterior, inicio");
		logger.info("anterior, fin");
		return mapping.findForward("anterior");
	}

	public ActionForward actualizarIngresos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anterior, inicio");
		SolicitudScoringForm f = (SolicitudScoringForm) form;
		ClienteDTO cliente = new ClienteDTO();
		cliente.setCodigoCliente(String.valueOf(f.getCodCliente()));
		cliente.setIngresosMensuales(new Double(f.getIngresosMensuales()));
		delegate.updIngresosMensualesCliente(cliente);
		logger.info("anterior, fin");
		return mapping.findForward("inicio");
	}

	private void validarSesion(HttpServletRequest request) throws VentasException {
		logger.info("validarSesion, inicio");
		final HttpSession session = request.getSession(false);
		if (session.getAttribute("paramGlobal") == null) {
			throw new VentasException(ERROR_SESION);
		}
		if (session.getAttribute("clienteSel") == null) {
			throw new VentasException(ERROR_SESION);
		}
		if (session.getAttribute("DatosVentaForm") == null) {
			throw new VentasException(ERROR_SESION);
		}
		logger.info("validarSesion, fin");
	}

	private ScoreClienteDTO buscarSolicitudEnProceso(String codTipTarjetaSCL, String numTarjeta, long codCliente)
			throws VentasException {
		logger.info("buscarSolicitudEnProceso, inicio");
		logger.debug("codTipoTarjeta [" + codTipTarjetaSCL + "]");
		logger.debug("numTarjeta [" + numTarjeta + "]");
		logger.debug("codCliente [" + codCliente + "]");
		final EstadoScoringDTO[] estados = delegate.obtenerEstadosScoringXNumTarjeta(codTipTarjetaSCL, numTarjeta);
		ScoreClienteDTO r = null;
		for (int i = 0; i < estados.length; i++) {
			final EstadoScoringDTO estado = estados[i];
			if (estado.getFechaTermino() == null) {
				logger.debug("Se encontró una solicitud scoring en proceso para la tarjeta.");
				logger.debug("estado.toString() [" + estado.toString() + "]");
				final ScoreClienteDTO scoring = delegate.getSolicitudScoring(new Long(estado.getNumSolScoring()));
				if (scoring.getCodCliente() != codCliente) {
					logger.debug("Tarjeta corresponde a solicitud de otro cliente.");
					r = scoring;
					break;
				}
				else {
					logger.debug("Tarjeta corresponde a solicitud del mismo cliente...");
				}
			}
		}
		logger.info("buscarSolicitudEnProceso, fin");
		return r;
	}

	private ClienteDTO buscarDatosCliente(long codCliente) throws VentasException {
		logger.info("buscarDatosCliente, inicio");
		BusquedaClienteDTO busquedaClienteDTO = new BusquedaClienteDTO();
		busquedaClienteDTO.setCodCliente(new Long(codCliente).toString());
		final ClienteDTO r = delegate.getDatosCliente(busquedaClienteDTO)[0];
		logger.info("buscarDatosCliente, fin");
		return r;
	}

}
