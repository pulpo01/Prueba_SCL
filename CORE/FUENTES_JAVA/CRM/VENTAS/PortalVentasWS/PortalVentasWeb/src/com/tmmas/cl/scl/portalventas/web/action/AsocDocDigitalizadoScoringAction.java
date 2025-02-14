package com.tmmas.cl.scl.portalventas.web.action;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.upload.FormFile;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DominioScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.AsocDocDigitalizadoScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

/**
 * @author JIB
 */
public class AsocDocDigitalizadoScoringAction extends DispatchAction {

	//	private String directorioRepositorio = null;

	protected Logger logger = Logger.getLogger(this.getClass());

	protected Global global = Global.getInstance();

	protected PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	//private static final String DIRECTORIO_EJECUCION_DOMINIO = System.getProperty("user.dir");

	private static final String NOMBRE_LOCALE_SESION = "Locale-PortalVentas";

	DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.SHORT);

	private SolicitudScoringAjaxDTO getSolicitudScoringAjaxDTOEnSession(HttpServletRequest request) {
		return (SolicitudScoringAjaxDTO) request.getSession().getAttribute("solicitudSel");
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		AsocDocDigitalizadoScoringForm f = (AsocDocDigitalizadoScoringForm) form;
		f.setMensajeAccion(null);
		f.setObservacion(null);
		/*
		 try {
		 directorioRepositorio = global.getValorExterno("modulo.web.asociacion.documentos.directorio");
		 }
		 catch (Exception ex) {
		 f.setMensajeAccion("Ocurrió un problema en el repositorio de documentos.");
		 logger.error("No se ha configurado la ruta del sistema de archivos del repositorio.");
		 }*/

		SolicitudScoringAjaxDTO solicitudScoringAjaxDTO = getSolicitudScoringAjaxDTOEnSession(request);
		final String nroSolScoring = solicitudScoringAjaxDTO.getNroSolScoring();
		ScoreClienteDTO scoreClienteDTO = delegate.getSolicitudScoring(new Long(nroSolScoring));
		logger.debug(scoreClienteDTO.toString());
		f.setScoreClienteDTO(scoreClienteDTO);

		DocDigitalizadoScoringDTO[] docs = delegate.obtenerDocDigitalizadosScoring(new Long(f.getNumSolScoring()));
		f.setArrayDocDigitalizadoScoring(docs);

		// Tipos de documento
		DominioScoringDTO[] tipos = new DominioScoringDTO[docs.length];
		for (int i = 0; i < docs.length; i++) {
			DocDigitalizadoScoringDTO doc = docs[i];
			tipos[i] = new DominioScoringDTO();
			tipos[i].setCodigo(new Long(doc.getNumCorrelativo()).toString());
			tipos[i].setValor(doc.getDesScoring());
			logger.debug(tipos[i].toString());
		}
		f.setArrayTipoDocumento(tipos);
		f.setExtensionesValidas(global.obtenerExtensionesDocDigitalizadoValidas());
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward eliminar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("eliminar, Inicio");
		AsocDocDigitalizadoScoringForm f = (AsocDocDigitalizadoScoringForm) form;
		Long numCorrelativo = new Long(request.getParameter("numCorrelativo"));
		logger.debug("numCorrelativo: " + numCorrelativo);
		DocDigitalizadoScoringDTO[] documentos = f.getArrayDocDigitalizadoScoring();
		for (int i = 0; i < documentos.length; i++) {
			DocDigitalizadoScoringDTO dto = documentos[i];
			if (dto.getNumCorrelativo() == numCorrelativo.longValue()) {
				logger.debug("Borrando del repositorio...");
				File archivo = new File(dto.getNombreArchivo());
				archivo.delete();
				logger.debug("Borrando del repositorio... OK");
				dto.setValorContentType(null);
				dto.setFechaCreacion(null);
				dto.setNombreArchivo(null);
				dto.setObservacion(null);
				logger.debug("Grabando en BD...");
				delegate.actualizarDocDigitalizadoScoring(dto);
				logger.debug("Grabando en BD... OK");
				break;
			}
		}
		DocDigitalizadoScoringDTO[] docs = delegate.obtenerDocDigitalizadosScoring(new Long(f.getNumSolScoring()));
		f.setArrayDocDigitalizadoScoring(docs);
		String mensaje = "Documento eliminado correctamente.";
		f.setMensajeAccion(mensaje);
		logger.info("eliminar, Fin");
		return mapping.findForward("inicio");
	}

	public ActionForward adjuntar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("adjuntar, Inicio");
		AsocDocDigitalizadoScoringForm f = (AsocDocDigitalizadoScoringForm) form;
		DocDigitalizadoScoringDTO dto = new DocDigitalizadoScoringDTO();
		String nomUsuarioOra = ((ParametrosGlobalesDTO) request.getSession(false).getAttribute("paramGlobal"))
				.getCodUsuario();
		int maxTamanoBytes = global.obtenerMaximoTamanoBytesDocDigitalizado();
		logger.debug("Tamaño Máximo (desde properties externo): " + maxTamanoBytes + " bytes");
		if (f.getMaximoTamanoBytes() == 0) {
			f.setMaximoTamanoBytes(maxTamanoBytes);
		}
		FormFile formFile = f.getArchivoFormFile();
		int tamArchivo = formFile.getFileSize();
		if (tamArchivo > f.getMaximoTamanoBytes()) {
			String mensaje = "El tamaño del archivo no puede ser mayor a " + f.getMaximoTamanoBytes()
					+ " bytes. Seleccione uno de menor tamaño.";
			f.setMensajeAccion(mensaje);
			logger.error(mensaje);
			logger.info("Fin");
			return mapping.findForward("inicio");
		}
		dto.setValorContentType(formFile.getContentType());

		if (request.getSession().getAttribute(NOMBRE_LOCALE_SESION) != null) {
			Locale locale = (Locale) request.getSession().getAttribute(NOMBRE_LOCALE_SESION);
			logger.debug("locale.getDisplayCountry() [" + locale.getDisplayCountry() + "]");
			dateFormat = DateFormat.getDateInstance(DateFormat.SHORT, locale);
		}

		dto.setFechaCreacion(dateFormat.format(new Date()));
		dto.setNumCorrelativo(new Long(f.getNumCorrelativo()).longValue());
		dto.setObservacion(f.getObservacion());
		dto.setNombreUsuarioOra(nomUsuarioOra);
		dto.setNumSolScoring(f.getNumSolScoring());

		/* try {
		 directorioRepositorio = global.getValorExterno("modulo.web.asociacion.documentos.directorio");
		 }
		 catch (Exception ex) {
		 f.setMensajeAccion("Ocurrió un problema en el repositorio de documentos.");
		 logger.error("No se ha configurado la ruta física del sistema de archivos del repositorio.");
		 }
		 logger.debug("directorioRepositorio [" + directorioRepositorio + "]");
		 String nombreArchivo = directorioRepositorio;*/

		// Incidencia 149265. No se ven los documentos asociados a las ventas.
		String nombreArchivo = "NUM_SOLSCORING[" + dto.getNumSolScoring() + "]-" + formFile.getFileName();
		dto.setNombreArchivo(nombreArchivo);
		dto.setBinArchivo(formFile.getFileData());
		logger.debug(dto.toString());
		delegate.actualizarDocDigitalizadoScoring(dto);
		DocDigitalizadoScoringDTO[] docs = delegate.obtenerDocDigitalizadosScoring(new Long(f.getNumSolScoring()));
		f.setArrayDocDigitalizadoScoring(docs);
		f.setMensajeAccion("Documento adjuntado correctamente.");
		f.setObservacion(null);
		logger.info("adjuntar, Fin");
		return mapping.findForward("inicio");
	}
}
