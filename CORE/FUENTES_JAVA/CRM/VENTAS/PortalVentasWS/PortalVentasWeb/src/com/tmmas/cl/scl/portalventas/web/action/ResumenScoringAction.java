package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.ResumenScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.ScoringHelper;

public class ResumenScoringAction extends DispatchAction {

	private final Logger logger = Logger.getLogger(ResumenScoringAction.class);

	private PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private Global global = Global.getInstance();

	private SolicitudScoringAjaxDTO getSolicitudScoringAjaxDTOEnSession(HttpServletRequest request) {
		return (SolicitudScoringAjaxDTO) request.getSession().getAttribute("solicitudSel");
	}

	private void inicializar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicializar, inicio");
		ResumenScoringForm f = (ResumenScoringForm) form;
		f.setCodModuloGestionScoring(global.getModuloWebScoring());
		SolicitudScoringAjaxDTO solicitudScoringAjaxDTO = getSolicitudScoringAjaxDTOEnSession(request);
		final Long numSolScoring = Long.valueOf(solicitudScoringAjaxDTO.getNroSolScoring());
		logger.debug("numSolScoring [" + numSolScoring + "]");
		ScoreClienteDTO scoreClienteDTO = delegate.getSolicitudScoring(numSolScoring);
		logger.debug(scoreClienteDTO.toString());
		f.setScoreClienteDTO(scoreClienteDTO);
		f.setCodEstadoScoringEvaluado(global.getEstadoScoringEvaluado());
		f.setCodEstadoScoringRechazado(global.getEstadoScoringRechazado());
		f.setCodEstadoScoringAprobado(global.getEstadoScoringAprobado());
		f.setCodEstadoScoringCancelado(global.getEstadoScoringCancelado());
		f.setCodEstadoScoringPendienteEnviar(global.getEstadoScoringPendienteEnviar());
		f.setCodEstadoScoringPendientePreactivar(global.getEstadoScoringPendientePreactivar());
		f.setCodEstadoActualizaSolicitudNormal(global.getEstadoScoringSolNormal());

		final String codEstadoOrigen = scoreClienteDTO.getEstadoActualDTO().getCodEstado();
		if (!codEstadoOrigen.trim().equals(global.getEstadoScoringPendientePreactivar())
				&& !codEstadoOrigen.trim().equals(global.getEstadoScoringPreactivo())) {

			f.setArrayEstadosDestino(delegate.obtenerEstadosDestino(global.getCodProgramaScoring(), codEstadoOrigen,
					global.getTablaEstadosScoring()));
		}
		else {
			f.setNumVenta(String.valueOf(delegate.obtenerNroventaSolScoring(numSolScoring)));
			f.setComentario("VENTA A FORMALIZAR");

		}
		final EstadoScoringDTO[] estadosScoring = delegate.getEstadosSolicitudScoring(numSolScoring);
		EstadoScoringDTO estadoScoringEvaluado = ScoringHelper.buscarEstadoEvaluado(estadosScoring);
		EstadoScoringDTO estadoScoringRechazado = ScoringHelper.buscarEstadoRechazado(estadosScoring);
		if (estadoScoringEvaluado != null || estadoScoringRechazado != null) {
			f.setResultadoScoreClienteDTO(delegate.getResultadoScoring(numSolScoring));
		}

		f.setMensajeError(null);
		f.setCodEstadoDestino(null);
		logger.info("inicializar, fin");
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		ResumenScoringForm f = (ResumenScoringForm) form;
		f.setCodModuloOrigen("");
		inicializar(mapping, form, request, response);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward inicioGestionScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioGestionScoring, inicio");
		ResumenScoringForm f = (ResumenScoringForm) form;
		f.setCodModuloOrigen(global.getModuloWebScoring());
		inicializar(mapping, form, request, response);
		logger.info("inicioGestionScoring, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aprobarScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aprobarScoring, inicio");

		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);

		ResumenScoringForm f = (ResumenScoringForm) form;
		String nombreParametro = global.getValor("parametro.aplica.validacion.documentos.scoring");
		String codProducto = global.getCodigoProducto();
		String codModulo = global.getCodigoModuloGA();
		boolean aplicaValidarDocumentosScoring = delegate.consultarParametro(codProducto, codModulo, nombreParametro);
		logger.debug("aplicaValidarDocumentosScoring [" + aplicaValidarDocumentosScoring + "]");

		if (aplicaValidarDocumentosScoring) {
			if (cumpleConDocumentosRequeridos(f)) {
				insertaEstadoScoring(usuarioSCLDTO, f);
			}
			else {
				f.setCodEstadoDestino("");
				f.setMensajeError("No se han adjuntado los documentos requeridos");
				return mapping.findForward("inicio");
			}
		}
		else {
			insertaEstadoScoring(usuarioSCLDTO, f);
		}
		logger.info("aprobarScoring, fin");
		return mapping.findForward("recargar");
	}

	public ActionForward cancelarScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarScoring, inicio");
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);
		ResumenScoringForm f = (ResumenScoringForm) form;
		insertaEstadoScoring(usuarioSCLDTO, f);
		logger.info("cancelarScoring, fin");
		return mapping.findForward("recargar");
	}

	public ActionForward adjuntarDocumentos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("adjuntarDocumentos, inicio");
		ResumenScoringForm f = (ResumenScoringForm) form;
		getSolicitudScoringAjaxDTOEnSession(request).setNroSolScoring(new Long(f.getNumSolScoring()).toString());
		logger.info("adjuntarDocumentos, fin");
		return mapping.findForward("adjuntarDocumentos");
	}

	protected boolean cumpleConDocumentosRequeridos(ResumenScoringForm f) throws VentasException {
		logger.info("cumpleConDocumentosRequeridos, inicio");
		boolean r = true;
		DocDigitalizadoScoringDTO[] docs = delegate.obtenerDocDigitalizadosScoring(new Long(f.getNumSolScoring()));
		for (int i = 0; i < docs.length; i++) {
			DocDigitalizadoScoringDTO doc = docs[i];
			logger.debug(doc);
			if (doc.isRequeridoScoring()) {
				if (doc.getNombreArchivo() == null) {
					r = false;
					break;
				}
			}
		}
		logger.info("resultado [" + r + "]");
		logger.info("cumpleConDocumentosRequeridos, fin");
		return r;
	}

	public ActionForward actualizaSolNormal(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("actualizaSolNormal, inicio");
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);
		ResumenScoringForm f = (ResumenScoringForm) form;
		insertaEstadoScoring(usuarioSCLDTO, f);
		logger.info("actualizaSolNormal, fin");
		return mapping.findForward("recargar");
	}

	private void insertaEstadoScoring(UsuarioSCLDTO usuarioSCLDTO, ResumenScoringForm f) throws VentasException {
		EstadoScoringDTO estadoCancelado = new EstadoScoringDTO();
		estadoCancelado.setCodEstado(f.getCodEstadoDestino());
		estadoCancelado.setNumSolScoring(f.getNumSolScoring());
		estadoCancelado.setCodVendedor(usuarioSCLDTO.getCodigoVendedor());
		delegate.insertaEstadoScoring(estadoCancelado);
	}

	public ActionForward anteriorGestionScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anteriorGestionScoring, inicio");
		logger.info("anteriorGestionScoring, fin");
		return mapping.findForward("anteriorGestionScoring");
	}

	/*
	 public ActionForward irAReporteScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
	 HttpServletResponse response) throws Exception {
	 logger.info("irAReporteScoring, inicio");
	 ResumenScoringForm f = (ResumenScoringForm) form;
	 final Long numSolScoring = new Long(f.getNumSolScoring());
	 logger.debug("numSolScoring [" + numSolScoring + "]");
	 request.setAttribute("numSolScoring", numSolScoring);
	 logger.info("irAReporteScoring, fin");
	 return mapping.findForward("irAReporteScoring");
	 }*/
}
