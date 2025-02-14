package com.tmmas.cl.scl.portalventas.web.action;

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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.AsocDocDigitalizadoVentaForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class AsocDocDigitalizadoVentaAction extends DispatchAction {

	//private String directorioRepositorio = null;

	//private static final String DIRECTORIO_EJECUCION_DOMINIO = System.getProperty("user.dir");

	private static final String NOMBRE_LOCALE_SESION = "Locale-PortalVentas";

	Logger logger = Logger.getLogger(this.getClass());

	Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.SHORT);

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		AsocDocDigitalizadoVentaForm f = (AsocDocDigitalizadoVentaForm) form;
		/*
		 try {
		 directorioRepositorio = global.getValorExterno("modulo.web.asociacion.documentos.directorio");
		 }
		 catch (Exception ex) {
		 f.setMensajeAccion("Ocurrió un problema en el repositorio de documentos.");
		 logger.error("No se ha configurado la ruta del sistema de archivos del repositorio.");
		 }
		 */
		final long numVenta = new Long(request.getParameter("numVentaSel")).longValue();
		f.setNumVenta(numVenta);
		f.setExtensionesValidas(global.obtenerExtensionesDocDigitalizadoValidas());

		TipoDocDigitalizadoDTO[] tipos = delegate.obtenerTiposDocDigitalizado();
		f.setArrayTipoDocDigitalizado(tipos);
		DocDigitalizadoDTO[] docs = delegate.obtenerDocDigitalizados(new Long(f.getNumVenta()));
		f.setArrayDocDigitalizado(docs);
		f.reset(mapping, request);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward eliminar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("eliminar, inicio");
		AsocDocDigitalizadoVentaForm f = (AsocDocDigitalizadoVentaForm) form;
		final Long numCorrelativo = new Long(request.getParameter("numCorrelativo"));
		logger.debug("numCorrelativo: " + numCorrelativo);
		DocDigitalizadoDTO[] documentosActuales = f.getArrayDocDigitalizado();
		DocDigitalizadoDTO[] documentosNuevos = new DocDigitalizadoDTO[documentosActuales.length - 1];
		int i, j = 0;
		for (i = 0; i < documentosActuales.length; i++) {
			DocDigitalizadoDTO item = documentosActuales[i];
			if (item.getNumCorrelativo() != numCorrelativo.longValue()) {
				documentosNuevos[j] = item;
				j++;
			}
		}
		f.setArrayDocDigitalizado(documentosNuevos);
		logger.debug("Borrando de BD...");
		delegate.eliminarDocDigitalizado(numCorrelativo);
		logger.debug("Borrando de BD: OK");
		String mensaje = "Documento eliminado correctamente.";
		f.setMensajeAccion(mensaje);
		f.reset(mapping, request);
		logger.info("eliminar, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward adjuntar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("adjuntar, inicio");
		AsocDocDigitalizadoVentaForm f = (AsocDocDigitalizadoVentaForm) form;
		DocDigitalizadoDTO dto = new DocDigitalizadoDTO();
		final String nomUsuarioOra = ((ParametrosGlobalesDTO) request.getSession(false).getAttribute("paramGlobal"))
				.getCodUsuario();
		dto.setNombreUsuarioOra(nomUsuarioOra);
		dto.setNumVenta(f.getNumVenta());
		dto.setObservacion(f.getObservacion());
		String codTipoDocDigitalizado = f.getCodTipoDocDigitalizado();
		dto.setCodTipoDocDigitalizado(new Long(codTipoDocDigitalizado).longValue());
		String desTipoDocDigitalizado = obtenerDesTipoDocDigitalizado(f.getArrayTipoDocDigitalizado(),
				codTipoDocDigitalizado);
		dto.setDesTipoDocDigitalizado(desTipoDocDigitalizado);
		FormFile formFile = f.getArchivoFormFile();
		final int maxTamanoBytes = global.obtenerMaximoTamanoBytesDocDigitalizado();
		logger.debug("Tamaño máximo (desde properties externo): " + maxTamanoBytes + " bytes");
		if (f.getMaximoTamanoBytes() == 0) {
			f.setMaximoTamanoBytes(maxTamanoBytes);
		}
		final int tamArchivo = formFile.getFileSize();
		logger.debug("Tamaño archivo: " + tamArchivo + " bytes");
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
			final Locale locale = (Locale) request.getSession().getAttribute(NOMBRE_LOCALE_SESION);
			logger.debug("locale.getDisplayCountry() [" + locale.getDisplayCountry() + "]");
			dateFormat = DateFormat.getDateInstance(DateFormat.SHORT, locale);
		}

		dto.setFechaCreacion(dateFormat.format(new Date()));

		/*try {
		 directorioRepositorio = global.getValorExterno("modulo.web.asociacion.documentos.directorio");
		 logger.debug("directorioRepositorio [" + directorioRepositorio + "]");
		 }
		 catch (Exception ex) {
		 f.setMensajeAccion("Ocurrió un problema en el repositorio de documentos.");
		 logger.error("No se ha configurado la ruta física del sistema de archivos del repositorio.");
		 return mapping.findForward("inicio");
		 }*/

		//String nombreArchivo = directorioRepositorio;
		// Incidencia 149265. No se ven los documentos asociados a las ventas.
		dto.setNombreArchivo("NUM_VENTA[" + dto.getNumVenta() + "]-" + formFile.getFileName());
		dto.setBinArchivo(formFile.getFileData());
		logger.debug(dto.toString());

		final Long numCorrelativo = delegate.insertarDocDigitalizado(dto);
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		dto.setNumCorrelativo(numCorrelativo.longValue());

		DocDigitalizadoDTO[] documentosActuales = f.getArrayDocDigitalizado();
		DocDigitalizadoDTO[] documentosNuevos = new DocDigitalizadoDTO[documentosActuales.length + 1];
		int i = 0;
		for (i = 0; i < documentosActuales.length; i++) {
			documentosNuevos[i] = documentosActuales[i];
		}
		documentosNuevos[i] = dto;
		f.setArrayDocDigitalizado(documentosNuevos);
		f.setMensajeAccion("Documento adjuntado correctamente.");
		f.reset(mapping, request);
		logger.info("adjuntar, Fin");
		return mapping.findForward("inicio");
	}

	private String obtenerDesTipoDocDigitalizado(TipoDocDigitalizadoDTO[] tipos, String codTipoDocDigitalizado) {
		for (int i = 0; i < tipos.length; i++) {
			TipoDocDigitalizadoDTO item = tipos[i];
			if (item.getCodTipoDocDigitalizado().equals(codTipoDocDigitalizado)) {
				return item.getDesTipoDocDigitalizado();
			}
		}
		return null;
	}
}
