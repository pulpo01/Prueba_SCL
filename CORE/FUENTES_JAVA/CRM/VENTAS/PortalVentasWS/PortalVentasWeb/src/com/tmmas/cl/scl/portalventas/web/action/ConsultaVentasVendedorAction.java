package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.TipoDocumentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.ConsultaVentasVendedorForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;

public class ConsultaVentasVendedorAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(ConsultaVentasVendedorAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ConsultaVentasVendedorAction() {
		logger.debug("ConsultaVentasVendedorAction():Begin");
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
		logger.debug("ConsultaVentasVendedorAction():End");
	}

	// ---------- (+) inicioPreVenta ---------------------//
	public ActionForward inicioPreVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioPreVenta, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.consultapreventa"));
		consultaVentasVendedorForm.setCodEstadoVenta(global.getValor("estado.venta.pendiente.formalizacion"));
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.formalizacion"));
		consultaVentasVendedorForm.setGlsModulo("FORMALIZACION");
		// filtrar combo de estados
		DatosGeneralesDTO[] listaEstados = (DatosGeneralesDTO[]) consultaVentasVendedorForm.getArrayEstadosVenta();
		DatosGeneralesDTO[] listaEstadosPreVenta = new DatosGeneralesDTO[1];
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		datosGeneralesDTO.setCodigoValor(global.getValor("estado.venta.pendiente.formalizacion"));
		if (listaEstados != null) {
			for (int i = 0; i < listaEstados.length; i++) {
				if (listaEstados[i].getCodigoValor().equals(global.getValor("estado.venta.pendiente.formalizacion"))) {
					datosGeneralesDTO.setDescripcionValor(listaEstados[i].getDescripcionValor());
					break;
				}
			}
		}
		listaEstadosPreVenta[0] = datosGeneralesDTO;
		consultaVentasVendedorForm.setArrayEstadosVenta(listaEstadosPreVenta);

		logger.info("inicioPreVenta, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioPreVenta ---------------------//

	// ---------- (+) inicioVenta ---------------------//
	public ActionForward inicioVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioVenta, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.consultaventa"));
		consultaVentasVendedorForm.setCodEstadoVenta("");
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.ventas"));
		consultaVentasVendedorForm.setGlsModulo("CONSULTA");

		logger.info("inicioVenta, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioVenta ---------------------//

	// ---------- (+) inicioDesbloqueo ---------------------//
	public ActionForward inicioDesbloqueo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioDesbloqueo, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.desbloqueo"));
		consultaVentasVendedorForm.setCodEstadoVenta(global.getValor("estado.venta.aprobado"));
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.desbloqueo"));
		consultaVentasVendedorForm.setGlsModulo("DESBLOQUEO");

		// filtrar combo de estados
		DatosGeneralesDTO[] listaEstados = (DatosGeneralesDTO[]) consultaVentasVendedorForm.getArrayEstadosVenta();
		DatosGeneralesDTO[] listaEstadosPreVenta = new DatosGeneralesDTO[1];
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		datosGeneralesDTO.setCodigoValor(global.getValor("estado.venta.aprobado"));
		if (listaEstados != null) {
			for (int i = 0; i < listaEstados.length; i++) {
				if (listaEstados[i].getCodigoValor().equals(global.getValor("estado.venta.aprobado"))) {
					datosGeneralesDTO.setDescripcionValor(listaEstados[i].getDescripcionValor());
					break;
				}
			}
		}
		listaEstadosPreVenta[0] = datosGeneralesDTO;
		consultaVentasVendedorForm.setArrayEstadosVenta(listaEstadosPreVenta);

		logger.info("inicioDesbloqueo, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioDesbloqueo ---------------------//

	// ---------- (+) inicioCargosInst ---------------------//
	public ActionForward inicioCargosInst(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioCargosInst, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.cargosInst"));
		consultaVentasVendedorForm.setCodEstadoVenta(global.getValor("estado.venta.aprobado"));
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.cargos"));
		consultaVentasVendedorForm.setGlsModulo("CARGO ADICIONAL DE INSTALACION");

		// filtrar combo de estados
		DatosGeneralesDTO[] listaEstados = (DatosGeneralesDTO[]) consultaVentasVendedorForm.getArrayEstadosVenta();
		DatosGeneralesDTO[] listaEstadosPreVenta = new DatosGeneralesDTO[1];
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		datosGeneralesDTO.setCodigoValor(global.getValor("estado.venta.aprobado"));
		if (listaEstados != null) {
			for (int i = 0; i < listaEstados.length; i++) {
				if (listaEstados[i].getCodigoValor().equals(global.getValor("estado.venta.aprobado"))) {
					datosGeneralesDTO.setDescripcionValor(listaEstados[i].getDescripcionValor());
					break;
				}
			}
		}
		listaEstadosPreVenta[0] = datosGeneralesDTO;
		consultaVentasVendedorForm.setArrayEstadosVenta(listaEstadosPreVenta);

		logger.info("inicioCargosInst, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioCargosInst ---------------------//

	// ---------- (+) inicioMisPendientesInst ---------------------//
	public ActionForward inicioMisPendientesInst(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioMisPendientesInst, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.mispendientesinst"));
		consultaVentasVendedorForm.setCodEstadoVenta(global.getValor("estado.venta.aprobado"));
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.pendientesinst"));
		consultaVentasVendedorForm.setGlsModulo("MIS PENDIENTES");

		// filtrar combo de estados
		DatosGeneralesDTO[] listaEstados = (DatosGeneralesDTO[]) consultaVentasVendedorForm.getArrayEstadosVenta();
		DatosGeneralesDTO[] listaEstadosPreVenta = new DatosGeneralesDTO[1];
		DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
		datosGeneralesDTO.setCodigoValor(global.getValor("estado.venta.aprobado"));
		if (listaEstados != null) {
			for (int i = 0; i < listaEstados.length; i++) {
				if (listaEstados[i].getCodigoValor().equals(global.getValor("estado.venta.aprobado"))) {
					datosGeneralesDTO.setDescripcionValor(listaEstados[i].getDescripcionValor());
					break;
				}
			}
		}
		listaEstadosPreVenta[0] = datosGeneralesDTO;
		consultaVentasVendedorForm.setArrayEstadosVenta(listaEstadosPreVenta);

		logger.info("inicioMisPendientesInst, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioMisPendientesInst ---------------------//

	// ---------- (+) inicioDocumentos ---------------------//
	public ActionForward inicioDocumentos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioDocumentos, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);
		HttpSession session = request.getSession(false);
		SeguridadPerfilesDTO seguridadPerfilesDTO = new SeguridadPerfilesDTO();
		UsuarioSCLDTO usuarioSCL = new UsuarioSCLDTO();
		String user = ((ParametrosGlobalesDTO) session.getAttribute("paramGlobal")).getCodUsuario();

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.documentos"));
		consultaVentasVendedorForm.setCodEstadoVenta("");
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.documentos"));
		consultaVentasVendedorForm.setGlsModulo("DOCUMENTOS");
		
		
		//Inicio P-CSR-11002 JLGN 11-11-2011
		HttpSession sesion = request.getSession(false);	
		String numVenta = (String)sesion.getAttribute("numVentaDocumento");
		if(numVenta != null){
			consultaVentasVendedorForm.setNumVenta(numVenta);
			sesion.removeAttribute("numVentaDocumento");
		}
		//Fin P-CSR-11002 JLGN 11-11-2011

		usuarioSCL.setUsuario(user);
		usuarioSCL = delegate.validaUsuarioSinPerfil(usuarioSCL);
		String tieneVendedor = global.getValor("codigo.vendedor.uno");
		if (usuarioSCL.getCodigoVendedor() == (Long.valueOf(global.getValor("codigo.vendedor.cero")).longValue())) {
			tieneVendedor = global.getValor("codigo.vendedor.cero");
		}

		// SE VALIDA EL FILTRO PARA ACCEDER A LA IMPRESION DE DOCUMENTOS
		seguridadPerfilesDTO.setCodPrograma(global.getValor("filtro.impresion.programa"));
		seguridadPerfilesDTO.setCodVersion(global.getValor("filtro.impresion.version"));
		seguridadPerfilesDTO.setNomProceso(global.getValor("filtro.impresion.proceso"));
		seguridadPerfilesDTO.setNomUsuario(user);
		seguridadPerfilesDTO = delegate.validaFiltroImpresion(seguridadPerfilesDTO);

		String indGrpImpresion = (seguridadPerfilesDTO.isGrupoImpresion() == true ? global
				.getValor("filtro.impresion.uno") : global.getValor("filtro.impresion.cero"));
		logger.info("tieneVendedor: " + tieneVendedor);
		logger.info("indGrpImpresion " + indGrpImpresion);
		if (tieneVendedor.equals(global.getValor("codigo.vendedor.uno"))
				&& indGrpImpresion.equals(global.getValor("filtro.impresion.uno"))) {
			logger.info("inicioDocumentos primer if");
			request.setAttribute("disableComponente", "false");
			request.setAttribute("disableDatVent", "false");
			request.setAttribute("disableTipDoc", "false");
			request.setAttribute("disableBuscar", "false");
		}
		else if (tieneVendedor.equals(global.getValor("codigo.vendedor.cero"))
				&& indGrpImpresion.equals(global.getValor("filtro.impresion.cero"))) {
			logger.info("inicioDocumentos segundo if");
			request.setAttribute("disableComponente", "true");
			request.setAttribute("disableDatVent", "true");
			request.setAttribute("disableTipDoc", "true");
			request.setAttribute("disableBuscar", "true");
		}
		else if (tieneVendedor.equals(global.getValor("codigo.vendedor.cero"))
				&& indGrpImpresion.equals(global.getValor("filtro.impresion.uno"))) {
			logger.info("inicioDocumentos tercero if");
			request.setAttribute("disableComponente", "false");
			request.setAttribute("disableDatVent", "false");
			request.setAttribute("disableTipDoc", "false");
			request.setAttribute("disableBuscar", "false");
		}
		else if (tieneVendedor.equals(global.getValor("codigo.vendedor.uno"))
				&& indGrpImpresion.equals(global.getValor("filtro.impresion.cero"))) {
			logger.info("inicioDocumentos cuarto if");
			request.setAttribute("disableDatVent", "false");
			request.setAttribute("disableTipDoc", "false");
			request.setAttribute("disableComponente", "true");
			request.setAttribute("disableBuscar", "false");
		}

		logger.info("inicioDocumentos, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioDocumentos ---------------------//

	// ---------- (+) inicioEvaluacionSolicitud ---------------------//
	public ActionForward inicioEvaluacionSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioEvaluacionSolicitud, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.evaluacion"));
		consultaVentasVendedorForm.setCodEstadoVenta("");
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.evaluacion"));
		consultaVentasVendedorForm.setGlsModulo("EVALUACION SOLICITUD");

		logger.info("inicioEvaluacionSolicitud, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioEvaluacionSolicitud ---------------------//

	// ---------- (+) inicioMisPendientesEval ---------------------//
	public ActionForward inicioMisPendientesEval(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("inicioMisPendientesEval, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);

		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.mispendienteseval"));
		consultaVentasVendedorForm.setCodEstadoVenta("");
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.evaluacion"));
		consultaVentasVendedorForm.setGlsModulo("MIS PENDIENTES");

		logger.info("inicioMisPendientesEval, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) inicioMisPendientesEval ---------------------//

	// ---------- (+) buscar cliente ---------------------//
	public ActionForward buscarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("buscarCliente, inicio");
		logger.info("buscarCliente, fin");

		return mapping.findForward("buscarCliente");
	}

	// ---------- (-) buscar cliente ---------------------//

	public ActionForward cargarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("cargarCliente, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		HttpSession sesion = request.getSession(false);

		if (sesion.getAttribute("clienteSel") != null) {
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO) sesion.getAttribute("clienteSel");
			consultaVentasVendedorForm.setCodTipoCliente(clienteSel.getTipoCliente());
			consultaVentasVendedorForm.setGlsTipoCliente(clienteSel.getGlsTipoCliente());
			consultaVentasVendedorForm.setCodCliente(clienteSel.getCodigoCliente());

		}

		logger.info("cargarCliente, fin");

		return mapping.findForward("inicio");
	}

	public ActionForward cancelarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("cancelarCliente, inicio");
		logger.info("cancelarCliente, fin");

		return mapping.findForward("inicio");
	}

	// ---------- (-) buscar cliente ---------------------//

	// ---------- (+) continuarEvaluacion ---------------------//
	public ActionForward continuarEvaluacion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("continuarEvaluacion, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		HttpSession sesion = request.getSession(false);

		VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
		VentaAjaxDTO ventaAjaxDTO = new VentaAjaxDTO();
		ventaAjaxDTO.setNroVenta(consultaVentasVendedorForm.getNumVentaSel());

		if (listaPreVenta != null) {
			// buscar venta seleccionada
			for (int i = 0; i < listaPreVenta.length; i++) {
				if (listaPreVenta[i].getNroVenta().equals(consultaVentasVendedorForm.getNumVentaSel())) {
					ventaAjaxDTO = (VentaAjaxDTO) listaPreVenta[i];
					break;
				}
			}
		}
		sesion.setAttribute("ventaSel", ventaAjaxDTO);

		logger.info("continuarEvaluacion, fin");

		return mapping.findForward("evaluarSolicitud");
	}

	public ActionForward aceptarEvaluacion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("aceptarEvaluacion, inicio");
		logger.info("aceptarEvaluacion, fin");

		return mapping.findForward("inicio");
	}

	public ActionForward cancelarEvaluacion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("cancelarEvaluacion, inicio");
		logger.info("cancelarEvaluacion, fin");

		return mapping.findForward("inicio");
	}

	// ---------- (+) continuarEvaluacion ---------------------//

	public ActionForward buscarVentas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarVentas, inicio");
		logger.info("buscarVentas, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward listarLineas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("listarLineas, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;

		HttpSession sesion = request.getSession(false);
		
		String codOperadora = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodOperadora();

		VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
		VentaAjaxDTO ventaAjaxDTO = new VentaAjaxDTO();
		ventaAjaxDTO.setNroVenta(consultaVentasVendedorForm.getNumVentaSel());

		if (listaPreVenta != null) {
			// buscar venta seleccionada
			for (int i = 0; i < listaPreVenta.length; i++) {
				if (listaPreVenta[i].getNroVenta().equals(consultaVentasVendedorForm.getNumVentaSel())) {
					ventaAjaxDTO = (VentaAjaxDTO) listaPreVenta[i].clone();
					break;
				}
			}
		}
		sesion.setAttribute("ventaSel", ventaAjaxDTO);

		// obtener lineas de la venta
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumVenta(Long.parseLong(consultaVentasVendedorForm.getNumVentaSel()));
		abonado.setOrigen(consultaVentasVendedorForm.getIndOrigenConsultaVTA());
		AbonadoDTO[] listaLineas = delegate.getListadoAbonadosVenta(abonado);
		// TODO: SE AGREGA PARA ASIGNAR INDICADOR DE MAC ADDRES - WIMAX - SANTIAGO VENTURA
		for (int i = 0; i < listaLineas.length; i++) {
			if (listaLineas[i].getCodGrpPrestacionWM().equalsIgnoreCase(global.getValor("grupo.prestacion.wimax"))) {
				listaLineas[i].setIndMacAddress(Integer.parseInt(global
						.getValor("indicador.macaddress.prestacion.wimax")));
			}
		}
		// Cambia glosa para pantallas que muestran telefonia fija
		if (!consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.desbloqueo"))) {
			if (listaLineas != null && listaLineas.length > 0) {
				for (int i = 0; i < listaLineas.length; i++) {
					if (listaLineas[i].getCodSituacion().equals(global.getValor("estado.abonado.altaactivaabonado"))
							|| listaLineas[i].getCodSituacion().equals(
									global.getValor("estado.abonado.altaoficinapendiente"))
							|| listaLineas[i].getCodSituacion().equals(
									global.getValor("estado.abonado.altaterrenopendiente"))) {
						listaLineas[i].setDesSituacion("INSTALADO");
					}
				}
			}
		}
		sesion.setAttribute("listaLineas", listaLineas);
		
		boolean activarOverrideFormalizacion = false;
		final String tipoClientePrepago = global.getValor("tipo.cliente.prepago").trim();
		boolean esClientePrepago = false;
		if (!Utilidades.emptyOrNull(ventaAjaxDTO.getCodTipoCliente())) {
			esClientePrepago = ventaAjaxDTO.getCodTipoCliente().trim().equals(tipoClientePrepago);
		}
		logger.debug("esClientePrepago [" + esClientePrepago + "]");
	
		if (!esClientePrepago) {
			// Verifica override para usuario
			final String codigoPrograma = global.getValor("programa.codigo").trim();
			final String numVersion = global.getValor("programa.version.externa").trim();
			final String formularioOverride = global.getValor("valor.formulario.override").trim();
			String nombreUsuario = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
			boolean habilitarOverrideUsuario = delegate.habilitarFormularioUsuario(codigoPrograma, Long
					.parseLong(numVersion), nombreUsuario, formularioOverride);
			logger.debug("habilitarOverrideUsuario [" + habilitarOverrideUsuario + "]");

			if (habilitarOverrideUsuario) {
				// GUATEMALA
				if (codOperadora.trim().equals(global.getValor("codigo.operadora.guatemala"))) {
					activarOverrideFormalizacion = true;
				}
				// EL SALVADOR
				else if (codOperadora.trim().equals(global.getValor("codigo.operadora.salvador"))) {
					final String codTipoSolicitudNormal = global.getValor("codigo.tipo.solicitud.normal").trim();
					boolean esSolicitudNormal = false;
					if (!Utilidades.emptyOrNull(ventaAjaxDTO.getCodTipoSolicitud())) {
						String codTipoSolicitudVenta = ventaAjaxDTO.getCodTipoSolicitud().trim();
						esSolicitudNormal = codTipoSolicitudVenta.equals(codTipoSolicitudNormal);
					}
					logger.debug("esSolicitudNormal [" + esSolicitudNormal + "]");
					if (!esSolicitudNormal) {
						activarOverrideFormalizacion = true;
					}
				}
			}
		}
		logger.debug("activarOverrideFormalizacion [" + activarOverrideFormalizacion + "]");
		consultaVentasVendedorForm.setActivarOverrideFormalizacion(activarOverrideFormalizacion);
		logger.info("listarLineas, fin");
		
		//Inicio P-CSR-11002 JLGN 12-05-2011		
		ParametrosGeneralesDTO parametrosCargoInst = new ParametrosGeneralesDTO();
		parametrosCargoInst.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosCargoInst.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosCargoInst.setNombreparametro(global.getValor("cod.defecto.override"));
		logger.debug("Obtiene Override por Default");
		parametrosCargoInst = delegate.getParametroGeneral(parametrosCargoInst);	
		logger.debug("Valor de Override: "+parametrosCargoInst.getValorparametro());
		consultaVentasVendedorForm.setDefOverride(parametrosCargoInst.getValorparametro().toUpperCase());
		//Fin P-CSR-11002 JLGN 12-05-2011		
		return mapping.findForward("listarLineas");
	}

	// ---------- (+) continua flujo de visualizacion del documento -------------//
	public ActionForward continuarDocumentos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("continuarDocumentos, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;

		String forward = "visualizarDocumento";
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
		VentaAjaxDTO ventaAjaxDTO = new VentaAjaxDTO();
		ventaAjaxDTO.setNroVenta(consultaVentasVendedorForm.getNumVentaSel());

		if (listaPreVenta != null) {
			// buscar venta seleccionada
			for (int i = 0; i < listaPreVenta.length; i++) {
				if (listaPreVenta[i].getNroVenta().equals(consultaVentasVendedorForm.getNumVentaSel())) {
					ventaAjaxDTO = (VentaAjaxDTO) listaPreVenta[i].clone();
					break;
				}
			}
		}

		// (+) validacion prepago
		if (consultaVentasVendedorForm.getCodTipoDocumento().equals(global.getValor("codigo.documento.fichausuario"))
				&& !ventaAjaxDTO.getCodTipoCliente().equals(global.getValor("tipo.cliente.prepago"))) {

			String mensajePrepago = "Documento disponible sólo para ventas prepago.";
			request.setAttribute("mensajeError", mensajePrepago);
			logger.info("ERROR: Documento disponible solo para ventas prepago");
			logger.info("continuarDocumentos, fin");
			return mapping.findForward("inicio");

		}
		// (-)

		TipoDocumentoDTO tipoDocumentoDTO = new TipoDocumentoDTO();
		tipoDocumentoDTO.setCodTipoDocumento(consultaVentasVendedorForm.getCodTipoDocumento());

		if (consultaVentasVendedorForm.getCodTipoDocumento().equals(
				global.getValor("codigo.documento.solicitudterminales"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("SOLICITUD DE TERMINALES");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirSolTerminales");
		}
		else if (consultaVentasVendedorForm.getCodTipoDocumento().equals(
				global.getValor("codigo.documento.prestacionservicios"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("CONTRATO DE PRESTACION DE SERVICIOS");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirContratoPrestServicios");
		}
		else if (consultaVentasVendedorForm.getCodTipoDocumento().equals(
				global.getValor("codigo.documento.fichausuario"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("FICHA DE REGISTRO DE USUARIOS");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirFichaUsuario");
			// obtener lineas de la venta
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumVenta(Long.parseLong(consultaVentasVendedorForm.getNumVentaSel()));
			abonado.setOrigen(global.getValor("ind.consulta.ficha"));
			AbonadoDTO[] listaLineas = delegate.getListadoAbonadosVenta(abonado);
			sesion.setAttribute("listaLineas", listaLineas);
			// limpia abonado seleccionado anterior
			consultaVentasVendedorForm.setNumAbonadoSel("");
			forward = "listarLineas";
		}
		else if (consultaVentasVendedorForm.getCodTipoDocumento().equals(global.getValor("codigo.documento.pagare"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("PAGARE");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirPagare");
		}
		//Inicio P-CSR-11002 JLGN 29-10-2011
		else if (consultaVentasVendedorForm.getCodTipoDocumento().equals(global.getValor("codigo.documento.factura"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("FACTURA");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirFactura");
			sesion.setAttribute("ventaSelFact", consultaVentasVendedorForm.getNumVentaSel());
		}
		//Fin P-CSR-11002 JLGN 29-10-2011
		//Inicio P-CSR-11002 JLGN 11-11-2011
		else if (consultaVentasVendedorForm.getCodTipoDocumento().equals(global.getValor("codigo.documento.contrato"))) {
			tipoDocumentoDTO.setGlsTipoDocumento("CONTRATO");
			tipoDocumentoDTO.setAccionAsocImpresion("imprimirContrato");
			sesion.setAttribute("ventaSelCont", consultaVentasVendedorForm.getNumVentaSel());
		}
		//Fin P-CSR-11002 JLGN 11-11-2011

		sesion.setAttribute("ventaSel", ventaAjaxDTO);
		sesion.setAttribute("documentoSel", tipoDocumentoDTO);

		logger.info("continuarDocumentos, fin");

		return mapping.findForward(forward);
	}

	public ActionForward continuarDocumentosAbonado(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("continuarDocumentosAbonado, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		HttpSession sesion = request.getSession(false);
		sesion.setAttribute("numAbonadoSel", consultaVentasVendedorForm.getNumAbonadoSel());

		logger.info("continuarDocumentosAbonado, fin");
		return mapping.findForward("visualizarDocumento");
	}

	// ---------- (-) continua flujo de visualizacion del documento -------------//

	// ---------- (+) continua flujo de mis pendientes instalacion -------------//
	public ActionForward continuarMisPendientesInst(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("continuarMisPendientesInst, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;

		String datosInstalacion = delegate.getDatosInstalacion(new Long(consultaVentasVendedorForm.getNumAbonadoSel()));
		consultaVentasVendedorForm.setDetalleInstalacionAbonado(datosInstalacion);
		logger.info("continuarMisPendientesInst, fin");
		return mapping.findForward("visualizarDatosInstalacion");
	}

	public ActionForward anteriorDatosInstalacion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("anteriorDatosInstalacion, inicio");
		logger.info("anteriorDatosInstalacion, fin");
		return mapping.findForward("listarLineas");
	}

	// ---------- (-) continua flujo de mis pendientes instalacion -------------//

	public ActionForward eliminarAbonado(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("eliminarAbonado, inicio");
		HttpSession sesion = request.getSession(false);
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		AbonadoDTO abonado = new AbonadoDTO();
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		abonado.setNumAbonado(Long.valueOf(consultaVentasVendedorForm.getNumAbonadoSel()).longValue());
		abonado.setCodVendedor(Long.valueOf(ventaSel.getCodVendedor()).longValue());
		// TODO
		String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
		abonado.setNomUsuarOra(user);
		abonado.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());

		// Elimina abonado de la BD
		delegate.eliminaAbonado(abonado);

		// Elimina abonado de la lista
		AbonadoDTO[] listaLineas = (AbonadoDTO[]) sesion.getAttribute("listaLineas");
		ArrayList lista = new ArrayList();
		if (listaLineas != null) {
			// buscar abonado seleccionado
			for (int i = 0; i < listaLineas.length; i++) {
				if (listaLineas[i].getNumAbonado() != Long.valueOf(consultaVentasVendedorForm.getNumAbonadoSel())
						.longValue()) {
					lista.add(listaLineas[i]);
				}
			}
		}

		AbonadoDTO[] listaLineasNuevas = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
				AbonadoDTO.class);

		logger.info("eliminarAbonado, fin");
		if (listaLineas.length > 1) {
			sesion.setAttribute("listaLineas", listaLineasNuevas);
			return mapping.findForward("listarLineas");
		}
		else {
			// Si es el ultimo abonado de la venta se elimina la venta de la lista
			VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
			ArrayList listaVentas = new ArrayList();
			if (listaPreVenta != null) {
				// buscar venta seleccionado
				for (int i = 0; i < listaPreVenta.length; i++) {
					if (Long.valueOf(listaPreVenta[i].getNroVenta()).longValue() != Long
							.valueOf(ventaSel.getNroVenta()).longValue()) {
						listaVentas.add(listaPreVenta[i]);
					}
				}
			}

			VentaAjaxDTO[] listaVentasNuevas = (VentaAjaxDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaVentas
					.toArray(), VentaAjaxDTO.class);

			sesion.setAttribute("listaPreVenta", listaVentasNuevas);
			return mapping.findForward("inicio");
		}
	}

	// ---------- (-) elimina abonado (solicitud) ---------------------//

	// ---------- (+) desbloquear abonado ---------------------//
	public ActionForward desbloquearAbonado(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("desbloquearAbonado, inicio");

		HttpSession sesion = request.getSession(false);
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		AbonadoDTO abonado = new AbonadoDTO();
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		abonado.setNumAbonado(Long.valueOf(consultaVentasVendedorForm.getNumAbonadoSel()).longValue());
		abonado.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
		abonado.setCodTipContrato(ventaSel.getCodTipoContrato());
		abonado.setCodModVenta(Long.parseLong(ventaSel.getCodModVenta()));
		String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
		abonado.setNomUsuarOra(user);

		// Desbloquea abonado
		delegate.desbloqueoLinea(abonado);

		// Elimina abonado de la lista
		AbonadoDTO[] listaLineas = (AbonadoDTO[]) sesion.getAttribute("listaLineas");
		ArrayList lista = new ArrayList();
		if (listaLineas != null) {
			// buscar abonado seleccionado
			for (int i = 0; i < listaLineas.length; i++) {
				if (listaLineas[i].getNumAbonado() != Long.valueOf(consultaVentasVendedorForm.getNumAbonadoSel())
						.longValue()) {
					lista.add(listaLineas[i]);
				}
			}
		}

		AbonadoDTO[] listaLineasNuevas = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
				AbonadoDTO.class);

		if (listaLineas.length > 1) {
			sesion.setAttribute("listaLineas", listaLineasNuevas);
			logger.info("desbloquearAbonado, fin");
			return mapping.findForward("listarLineas");
		}
		else {
			// Si es el ultimo abonado de la venta se elimina la venta de la lista
			VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
			ArrayList listaVentas = new ArrayList();
			if (listaPreVenta != null) {
				// buscar venta seleccionado
				for (int i = 0; i < listaPreVenta.length; i++) {
					if (Long.valueOf(listaPreVenta[i].getNroVenta()).longValue() != Long
							.valueOf(ventaSel.getNroVenta()).longValue()) {
						listaVentas.add(listaPreVenta[i]);
					}
				}
			}

			VentaAjaxDTO[] listaVentasNuevas = (VentaAjaxDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaVentas
					.toArray(), VentaAjaxDTO.class);

			sesion.setAttribute("listaPreVenta", listaVentasNuevas);
			logger.info("desbloquearAbonado, fin");
			return mapping.findForward("inicio");
		}

	}

	// ---------- (-) desbloquear abonado ---------------------//

	// ---------- (+) formaliza solicitud ---------------------//
	public ActionForward formalizarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("formalizarSolicitud, inicio");
		logger.info("formalizarSolicitud, fin");
		final String nombreForward = "irACargos";
		return mapping.findForward(nombreForward);
	}

	// ---------- (-) formaliza solicitud ---------------------//

	// ---------- (+) recarga pagina de busquedas de ventas ---------------------//
	public ActionForward anteriorMostrarLineas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("anteriorMostrarLineas, inicio");
		logger.info("anteriorMostrarLineas, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward anteriorVisualizarDocumento(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("anteriorVisualizarDocumento, inicio");
		String forward = "inicio";
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		if (consultaVentasVendedorForm.getCodTipoDocumento().equals(global.getValor("codigo.documento.fichausuario"))) {
			forward = "listarLineas";
		}

		logger.info("anteriorVisualizarDocumento, fin");
		return mapping.findForward(forward);
	}

	// ---------- (-) recarga pagina de busquedas de ventas ---------------------//

	// ---------- (+) limpia los datos ---------------------//
	public ActionForward limpiarConsulta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("limpiarConsulta, inicio");

		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;

		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.consultapreventa"))) {
			return inicioPreVenta(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.consultaventa"))) {
			return inicioVenta(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.desbloqueo"))) {
			return inicioDesbloqueo(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.cargosInst"))) {
			return inicioCargosInst(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.mispendientesinst"))) {
			return inicioMisPendientesInst(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.documentos"))) {
			return inicioDocumentos(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.evaluacion"))) {
			return inicioEvaluacionSolicitud(mapping, form, request, response);
		}
		if (consultaVentasVendedorForm.getModuloOrigenVenta().equals(global.getValor("modulo.web.mispendienteseval"))) {
			return inicioMisPendientesEval(mapping, form, request, response);
		}

		logger.info("limpiarConsulta, fin");
		return inicioVenta(mapping, form, request, response);
	}

	// ---------- (-) limpia los datos ---------------------//

	private void inicializar(HttpServletRequest request, ConsultaVentasVendedorForm consultaVentasVendedorForm)
			throws AltaClienteException, RemoteException {

		// Estados venta
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		datosGenerales.setTabla(global.getValor("tabla.ventas"));
		datosGenerales.setColumna(global.getValor("columna.estado.venta"));
		DatosGeneralesDTO[] arrayEstadosVenta = delegate.getListCodigo(datosGenerales);
		consultaVentasVendedorForm.setArrayEstadosVenta(arrayEstadosVenta);

		// Oficinas
		OficinaComDTO oficinaComDTO = new OficinaComDTO();
		 //P-CSR-11002 JLGN 04-11-2011
		HttpSession sesion1 = request.getSession(false);
	    String usuario = (String)sesion1.getAttribute("nombreUsuarioSCL");
	    logger.debug("Nombre de Usuario SCL: "+usuario);
	    oficinaComDTO.setNombreUsuario(usuario);
		OficinaComDTO[] arrayOficina = delegate.getOficinas(oficinaComDTO);
		consultaVentasVendedorForm.setArrayOficina(arrayOficina);

		consultaVentasVendedorForm.setCodModuloConsultaPreVenta(global.getValor("modulo.web.consultapreventa"));
		consultaVentasVendedorForm.setCodModuloConsultaVenta(global.getValor("modulo.web.consultaventa"));
		consultaVentasVendedorForm.setCodModuloConsultaDesbloqueo(global.getValor("modulo.web.desbloqueo"));
		consultaVentasVendedorForm.setCodModuloConsultaCargosInst(global.getValor("modulo.web.cargosInst"));
		consultaVentasVendedorForm.setCodModuloMisPendientesInst(global.getValor("modulo.web.mispendientesinst"));
		consultaVentasVendedorForm.setCodModuloConsultaDocumentos(global.getValor("modulo.web.documentos"));
		consultaVentasVendedorForm.setCodModuloEvaluacion(global.getValor("modulo.web.evaluacion"));
		consultaVentasVendedorForm.setCodModuloMisPendientesEval(global.getValor("modulo.web.mispendienteseval"));
		consultaVentasVendedorForm
				.setCodModuloAsociacionDocumentos(global.getValor("modulo.web.asociacion.documentos"));
		consultaVentasVendedorForm
				.setCodModuloOverrideSolicitud(global.getValor("modulo.web.override.solicitud.venta"));

		consultaVentasVendedorForm.setNumVenta("");
		consultaVentasVendedorForm.setCodOficina("");
		consultaVentasVendedorForm.setCodVendedor("");
		consultaVentasVendedorForm.setCodCliente("");
		consultaVentasVendedorForm.setCodTipoCliente("");
		consultaVentasVendedorForm.setGlsTipoCliente("");
		consultaVentasVendedorForm.setFechaDesde("");
		consultaVentasVendedorForm.setFechaHasta("");
		consultaVentasVendedorForm.setCodVendedorSeleccionado("");
		consultaVentasVendedorForm.setNumVentaSel("");
		consultaVentasVendedorForm.setNumAbonadoSel("");
		consultaVentasVendedorForm.setCodTipoDocumento("");

		ParametrosGeneralesDTO parametrosCargoInst = new ParametrosGeneralesDTO();
		parametrosCargoInst.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosCargoInst.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosCargoInst.setNombreparametro(global.getValor("cargo.instalacion"));
		try {
			parametrosCargoInst = delegate.getParametroGeneral(parametrosCargoInst);
			FaConceptoDTO faConceptoDTO = new FaConceptoDTO();
			faConceptoDTO.setCodConcepto(parametrosCargoInst.getValorparametro());
			faConceptoDTO = delegate.getFaConcepto(faConceptoDTO);
			consultaVentasVendedorForm.setConcepFactCargIns(parametrosCargoInst.getValorparametro());
			consultaVentasVendedorForm.setDesConcepCargoIns(faConceptoDTO.getDesConcep());
			MonedaDTO[] arrayMonedas = delegate.listarMonedas();
			for (int w = 0; w < arrayMonedas.length; w++) {
				if (arrayMonedas[w].getCodigo().equals(faConceptoDTO.getCodMoneda())) {
					consultaVentasVendedorForm.setCodMoneda(arrayMonedas[w].getDescripcion());
					break;
				}
			}
		}
		catch (Exception e) {
		}

		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("CargosForm");
		sesion.removeAttribute("listaPreVenta");
		sesion.removeAttribute("BuscaClienteForm");
		sesion.removeAttribute("clienteSel");
		sesion.removeAttribute("ventaSel");
		sesion.removeAttribute("documentoSel");
		sesion.removeAttribute("numAbonadoSel");
		sesion.removeAttribute("cabeceraDTO");
		sesion.removeAttribute("Cargos");
		sesion.removeAttribute("listaLineas");

	}

	public ActionForward inicioAsociacionDocumentos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioAsociacionDocumentos, inicio");
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		inicializar(request, consultaVentasVendedorForm);
		String moduloOrigen = global.getValor("modulo.web.asociacion.documentos");
		logger.debug("moduloOrigen: " + moduloOrigen);
		consultaVentasVendedorForm.setModuloOrigenVenta(moduloOrigen);
		consultaVentasVendedorForm.setCodEstadoVenta("");
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.ventas"));
		String glsModulo = global.getValor("modulo.web.asociacion.documentos.nombre");
		logger.debug("glsModulo: " + glsModulo);
		consultaVentasVendedorForm.setGlsModulo(glsModulo);
		logger.info("inicioAsociacionDocumentos, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward inicioOverrideSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		ConsultaVentasVendedorForm f = (ConsultaVentasVendedorForm) form;

		inicializar(request, f);
		String moduloOrigen = global.getValor("modulo.web.override.solicitud.venta");
		logger.debug("moduloOrigen: " + moduloOrigen);
		f.setModuloOrigenVenta(moduloOrigen);

		f.setIndOrigenConsultaVTA(global.getValor("ind.consulta.evaluacion"));
		String glsModulo = global.getValor("modulo.web.override.solicitud.venta.nombre");
		logger.debug("glsModulo: " + glsModulo);
		f.setGlsModulo(glsModulo);

		String codEstado = global.getValor("estado.venta.pendiente.revision");
		if (f.getArrayEstadosVenta() != null) {
			DatosGeneralesDTO[] nuevo = new DatosGeneralesDTO[1];
			for (int i = 0; i < f.getArrayEstadosVenta().length; i++) {
				if (codEstado.equals(f.getArrayEstadosVenta()[i].getCodigoValor())) {
					nuevo[0] = f.getArrayEstadosVenta()[i];
					f.setArrayEstadosVenta(nuevo);
					break;
				}
			}
		}
		f.setCodEstadoVenta(codEstado);

		logger.info("Fin");
		return mapping.findForward("inicio");
	}

	public ActionForward cancelarOverrideSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarOverrideSolicitud, inicio");
		logger.info("cancelarOverrideSolicitud, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward continuarOverrideSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		ConsultaVentasVendedorForm f = (ConsultaVentasVendedorForm) form;
		HttpSession sesion = request.getSession(false);

		VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
		VentaAjaxDTO ventaAjaxDTO = new VentaAjaxDTO();
		ventaAjaxDTO.setNroVenta(f.getNumVentaSel());

		if (listaPreVenta != null) {
			// buscar venta seleccionada
			for (int i = 0; i < listaPreVenta.length; i++) {
				if (listaPreVenta[i].getNroVenta().equals(f.getNumVentaSel())) {
					ventaAjaxDTO = (VentaAjaxDTO) listaPreVenta[i];
					break;
				}
			}
		}

		logger.debug("ventaAjaxDTO.getNroVenta(): " + ventaAjaxDTO.getNroVenta());
		logger.debug("ventaAjaxDTO.getCodCliente(): " + ventaAjaxDTO.getCodCliente());

		sesion.setAttribute("ventaSel", ventaAjaxDTO);

		logger.info("Fin");
		return mapping.findForward("continuarOverrideSolicitud");
	}

	public ActionForward continuarAOverrideFormalizacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("continuarAOverrideFormalizacion, inicio");
		logger.info("continuarAOverrideFormalizacion, fin");
		final String nombreForward = "continuarAOverrideFormalizacion";
		return mapping.findForward(nombreForward);
	}
	
	//Inicio P-CSR-11002 JLGN 10-10-2011
	public ActionForward formalizaSolicitud(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("formalizaSolicitud, inicio");
		ResultadoSolicitudVentaDTO resultadoSolVenta = (ResultadoSolicitudVentaDTO) request.getSession().getAttribute("resultadoSolVenta");
		
		ConsultaVentasVendedorForm consultaVentasVendedorForm = (ConsultaVentasVendedorForm) form;
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO[] listaPreVenta = (VentaAjaxDTO[]) sesion.getAttribute("listaPreVenta");
		inicializar(request, consultaVentasVendedorForm);		
		consultaVentasVendedorForm.setNumVentaSel(resultadoSolVenta.getNumeroVenta());
		consultaVentasVendedorForm.setIndOrigenConsultaVTA(global.getValor("ind.consulta.formalizacion"));
		consultaVentasVendedorForm.setModuloOrigenVenta(global.getValor("modulo.web.consultapreventa"));
		sesion.setAttribute("listaPreVenta", listaPreVenta);
		logger.info("formalizaSolicitud, fin");
		return mapping.findForward("formalizaSolicitud");
	}
	//Fin P-CSR-11002 JLGN 10-10-2011
}
