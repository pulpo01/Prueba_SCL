package com.tmmas.cl.scl.portalventas.web.action;

import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ReporteScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.ReporteScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.ScoringHelper;

public class ReporteScoringAction extends DispatchAction {

	private static final String PARAM_MENSAJE = "mensaje";

	private static final String PARAM_PUNTEO = "punteo";

	private final Logger logger = Logger.getLogger(ReporteScoringAction.class);

	private PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private Global global = Global.getInstance();

	private static String CORRECTO = "CORRECTO";

	private static String RECHAZADO = "RECHAZADO";

	private static String HASTA_PENDIENTE_ENVIAR = "PENDIENTE ENVIAR";

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		ReporteScoringForm f = (ReporteScoringForm) form;
		inicializar(f, request);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward inicioGestionScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioGestionScoring, inicio");
		ReporteScoringForm f = (ReporteScoringForm) form;
		inicializar(f, request);
		f.setCodModuloOrigen(global.getModuloWebScoring());
		logger.info("inicioGestionScoring, fin");
		return mapping.findForward("inicio");
	}

	private void inicializar(ReporteScoringForm f, HttpServletRequest request) throws VentasException, Exception {
		logger.info("inicializar, inicio");

		f.setCodModuloOrigen(null);
		f.setFechaEvaluacion(null);
		f.setDesEstado(null);

		f.setCodModuloOrigenScoring(global.getModuloWebScoring());
		ReporteScoringDTO reporteScoring = new ReporteScoringDTO();
		final Long numSolScoring = (Long) request.getAttribute("numSolScoring");
		logger.debug("numSolScoring [" + numSolScoring + "]");
		f.setNumSolScoring(numSolScoring.longValue());

		final EstadoScoringDTO[] estadosScoring = delegate.getEstadosSolicitudScoring(numSolScoring);
		final String estados = getEstadosSolicitudScoring(estadosScoring);
		final String resultadoReporte = verificarEstados(estadosScoring);

		if (resultadoReporte.equals(CORRECTO)) {
			final DocDigitalizadoScoringDTO[] docs = delegate.obtenerDocDigitalizadosScoring(numSolScoring);
			reporteScoring.setDocsDigScoringDTO(docs);

		}
		else {
			reporteScoring.setDocsDigScoringDTO(new DocDigitalizadoScoringDTO[0]);
		}

		final ReporteScoringDTO reporteScoreCteDTO = delegate.getReporteSolicitudScoring(numSolScoring);
		ScoreClienteDTO scoreClienteDTO = reporteScoreCteDTO.getScoreClienteDTO();

		f.setDesEstado(estados);

		if (reporteScoreCteDTO != null) {
			f.setCantidadLineas(reporteScoreCteDTO.getCantidadLineas());
			f.setCantidadPlanes(reporteScoreCteDTO.getCantidadPlanes());
			f.setDesPlanes(reporteScoreCteDTO.getDesPlanes());
			f.setCantidadServSup(reporteScoreCteDTO.getCantidadServSup());
			f.setResultadoScoring(resultadoReporte);
			f.setClasificacionCliente(reporteScoreCteDTO.getClasificacionCliente());
		}
		else {
			logger.debug("reporteScoreCteDTO es null");
		}

		if (scoreClienteDTO == null) {
			scoreClienteDTO = delegate.getSolicitudScoring(numSolScoring);
		}

		f.setNit(scoreClienteDTO.getNit());
		f.setDocumento(scoreClienteDTO.getDocumento());
		f.setDesTipoDocumento(scoreClienteDTO.getDesTipoDocumento());
		f.setNombreVendedor(scoreClienteDTO.getDatosGeneralesScoringDTO().getNombreVendedor());
		f.setCodVendedor(scoreClienteDTO.getDatosGeneralesScoringDTO().getCodVendedor());
		f.setPrimerNombre(scoreClienteDTO.getPrimer_nombre());
		f.setSegundoNombre(scoreClienteDTO.getSegundo_nombre());
		f.setPrimerApellido(scoreClienteDTO.getPrimer_apellido());
		f.setSegundoApellido(scoreClienteDTO.getSegundo_apellido());
		f.setCodEstado(scoreClienteDTO.getEstadoActualDTO().getCodEstado());
		final EstadoScoringDTO estadoScoringEvaluado = ScoringHelper.buscarEstadoEvaluado(estadosScoring);
		final EstadoScoringDTO estadoScoringRechazado = ScoringHelper.buscarEstadoRechazado(estadosScoring);
		Date fechaEvaluacion = null;
		if (estadoScoringEvaluado != null) {
			fechaEvaluacion = estadoScoringEvaluado.getFechaInicio();
		}
		if (estadoScoringRechazado != null) {
			fechaEvaluacion = estadoScoringRechazado.getFechaInicio();
		}

		if (estadoScoringEvaluado != null || estadoScoringRechazado != null) {
			final DateFormat df = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.MEDIUM);
			if (fechaEvaluacion != null) {
				logger.debug("fechaEvaluacion.toString() [" + fechaEvaluacion.toString() + "]");
				f.setFechaEvaluacion(df.format(fechaEvaluacion));
			}
			final ResultadoScoreClienteDTO resultadoScoring = delegate.getResultadoScoring(numSolScoring);
			f.setPunteo(resultadoScoring.getPunteo());
			f.setClasificacion(resultadoScoring.getClasificacion());
			f.setMensaje(resultadoScoring.getMensaje());
		}
		request.getSession(false).setAttribute("reporteScoring", reporteScoring);
		request.getSession(false).setAttribute("repForm", f);
		logger.info("inicializar, fin");
	}

	public ActionForward imprimirReporteScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("imprimirReporteScoring, inicio");
		HttpSession sesion = request.getSession(false);
		Map parametros = new HashMap();
		ReporteScoringDTO reporteScoring = (ReporteScoringDTO) sesion.getAttribute("reporteScoring");
		ReporteScoringForm f = (ReporteScoringForm) sesion.getAttribute("repForm");
		String nombreCliente = f.getPrimerNombre().trim() + " " + f.getSegundoNombre().trim() + " "
				+ f.getPrimerApellido().trim() + " " + f.getSegundoApellido().trim();
		parametros.put("nombreCliente", nombreCliente);
		parametros.put("nit", f.getNit());
		parametros.put("documento", f.getDocumento());
		parametros.put("desTipoDocumento", f.getDesTipoDocumento());
		parametros.put("nombreVendedor", f.getNombreVendedor());
		parametros.put("codVendedor", f.getCodVendedor() + "");
		parametros.put("codEstado", f.getCodEstado());
		parametros.put("desEstado", f.getDesEstado());
		parametros.put("resultadoScoring", f.getResultadoScoring());
		parametros.put("cantidadLineas", f.getCantidadLineas() + "");
		parametros.put("desPlanes", f.getDesPlanes());
		parametros.put("cantidadPlanes", f.getCantidadPlanes() + "");
		parametros.put("cantidadServSup", f.getCantidadServSup() + "");
		parametros.put("numSolScoring", f.getNumSolScoring() + "");
		parametros.put("fechaEvaluacion", f.getFechaEvaluacion());
		parametros.put("clasificacionCliente", f.getClasificacionCliente());

		if (f.getPunteo() != null) {
			logger.debug("f.getPunteo() [" + f.getPunteo() + "]");
			parametros.put(PARAM_PUNTEO, f.getPunteo());
		}
		else {
			parametros.put(PARAM_PUNTEO, "");
		}
		if (f.getMensaje() != null) {
			logger.debug("f.getMensaje() [" + f.getMensaje() + "]");
			parametros.put(PARAM_MENSAJE, f.getMensaje());
		}
		else {
			parametros.put(PARAM_MENSAJE, "");
		}

		InputStream logo = getServlet().getServletConfig().getServletContext().getResourceAsStream(
				"/img/logoTelefonica.jpg");
		parametros.put("logo", logo);//

		DocDigitalizadoScoringDTO[] docsDigScoringDTO = reporteScoring.getDocsDigScoringDTO();
		List documentos = new ArrayList();
		for (int i = 0; i < docsDigScoringDTO.length; i++) {
			documentos.add(docsDigScoringDTO[i]);
		}
		//for (int j=0;j<5;j++){for (int i=0;i<docsDigScoringDTO.length;i++){documentos.add(docsDigScoringDTO[i]);}}
		logger.debug("documentos.size()=" + documentos.size());
		if (documentos.size() == 0) {
			DocDigitalizadoScoringDTO sinDocs = new DocDigitalizadoScoringDTO();
			sinDocs.setDesScoring("");
			sinDocs.setRequeridoScoringRep("");
			sinDocs.setSubido("");
			documentos.add(sinDocs);
		}

		String sRutaReporte = System.getProperty("user.dir") + global.getValorExterno("scoring.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

		try {
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(documentos);

			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, ds);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "attachment; filename=" + "ReporteScoring.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
		catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("JRException," + mensaje);
			request.setAttribute("mensajeError", mensaje);
			return mapping.findForward("mostrarPresupuesto");//TODO REVISAR ESTE FORWARD PV 240610
		}
		logger.info("imprimirReporteScoring, fin");
		return null;
	}

	private String verificarEstados(EstadoScoringDTO[] estadosScoring) throws Exception {
		String codEstadoScoringAprobado = global.getEstadoScoringAprobado();//2
		String codEstadoScoringCancelado = global.getEstadoScoringCancelado();//?
		String codEstadoScoringEvaluado = global.getEstadoScoringEvaluado();
		String codEstadoScoringRechazado = global.getEstadoScoringRechazado();//2
		String codEstadoScoringPreactivo = global.getEstadoScoringPreactivo();
		String codEstadoScoringPendienteEnviar = global.getEstadoScoringPendienteEnviar();//1
		String codEstadoScoringPendientePreactivar = global.getEstadoScoringPendientePreactivar();
		String codEstadoScoringpendienteRevision = global.getEstadoScoringPendienteRevision();//?

		if (estadosScoring.length > 0) {
			if (pasoEstado(codEstadoScoringRechazado, estadosScoring)) {
				return RECHAZADO;
			}
			if (pasoEstado(codEstadoScoringPendienteEnviar, estadosScoring) && estadosScoring.length == 1) {
				return HASTA_PENDIENTE_ENVIAR;
			}
			if (pasoEstado(codEstadoScoringAprobado, estadosScoring)
					|| pasoEstado(codEstadoScoringEvaluado, estadosScoring)
					|| pasoEstado(codEstadoScoringPreactivo, estadosScoring)
					|| pasoEstado(codEstadoScoringCancelado, estadosScoring)
					|| pasoEstado(codEstadoScoringPendienteEnviar, estadosScoring)
					|| pasoEstado(codEstadoScoringPendientePreactivar, estadosScoring)) {

				return CORRECTO;
			}
		}
		return "";
	}

	private boolean pasoEstado(String estadoProp, EstadoScoringDTO[] estadosScoring) {
		for (int i = 0; i < estadosScoring.length; i++) {
			if (estadoProp.equals(estadosScoring[i].getCodEstado()))
				return true;
		}
		return false;
	}

	private String getEstadosSolicitudScoring(EstadoScoringDTO[] estadosScoring) {
		String estados = "";
		if (estadosScoring != null && estadosScoring.length > 0) {
			for (int i = 0; i < estadosScoring.length - 1; i++) {
				estados += estadosScoring[i].getDesEstado() + " | ";
			}
			estados += estadosScoring[estadosScoring.length - 1].getDesEstado();
		}
		return estados;
	}

	private DecimalFormat getMascaraNumero() {
		DecimalFormat mascaraNumeros = new DecimalFormat();
		StringBuffer mascaraNumero = new StringBuffer();
		mascaraNumero.append(global.getValor("formato.numero.reporte"));
		int decimalesForm = Integer.parseInt(global.getValor("decimales.form"));
		if (decimalesForm > 0) {
			mascaraNumero.append(global.getValor("simbolo.decimal"));
			for (int i = 0; i < decimalesForm; i++) {
				mascaraNumero.append("0");
			}
		}
		logger.debug("formatnumero: " + mascaraNumero);
		mascaraNumeros.applyPattern(mascaraNumero.toString());
		return mascaraNumeros;
	}

	public ActionForward anterior(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anterior, inicio");
		logger.info("anterior, fin");
		return mapping.findForward("anterior");
	}

	public ActionForward anteriorGestionScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anteriorGestionScoring, inicio");
		logger.info("anteriorGestionScoring, fin");
		return mapping.findForward("anteriorGestionScoring");
	}
}
