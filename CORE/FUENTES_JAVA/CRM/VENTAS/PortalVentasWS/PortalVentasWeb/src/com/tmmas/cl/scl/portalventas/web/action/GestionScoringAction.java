package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoCOLDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.GestionScoringForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class GestionScoringAction extends DispatchAction {

	private final Logger logger = Logger.getLogger(GestionScoringAction.class);

	private PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private Global global = Global.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws AltaClienteException, RemoteException {
		logger.info("inicio, inicio");
		inicializar(mapping, form, request, response);
		GestionScoringForm f = ((GestionScoringForm) form);
		f.setTitulo(global.getTituloGestionScoring());
		f.setCodFormularioOrigen(global.getFormularioGestionScoring());
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward inicioReportes(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws AltaClienteException, RemoteException {
		logger.info("inicioReportes, inicio");
		GestionScoringForm f = ((GestionScoringForm) form);
		f.setTitulo(global.getTituloReportesScoring());
		f.setCodFormularioOrigen(global.getFormularioReporteScoring());
		inicializar(mapping, form, request, response);
		logger.info("inicioReportes, fin");
		return mapping.findForward("inicio");
	}
	
	private void inicializar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws AltaClienteException, RemoteException {
		logger.info("inicializar, inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("listaSolicitudes");
		GestionScoringForm gestionScoringForm = (GestionScoringForm) form;
		gestionScoringForm.setCodFormularioGestionScoring(global.getFormularioGestionScoring());
		gestionScoringForm.setCodFormularioReportesScoring(global.getFormularioReporteScoring());
		// Estados scoring
		DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		datosGenerales.setTabla(global.getValor("tabla.estado.scoring"));
		datosGenerales.setColumna(global.getValor("columna.estado.scoring"));
		DatosGeneralesDTO[] arrayEstadosSol = delegate.getListCodigo(datosGenerales);
		gestionScoringForm.setArrayEstadosSol(arrayEstadosSol);
		// Oficinas
		OficinaComDTO oficinaComDTO = new OficinaComDTO();
		OficinaComDTO[] arrayOficina = delegate.getOficinas(oficinaComDTO);
		gestionScoringForm.setArrayOficina(arrayOficina);
		logger.info("inicializar, fin");
	}
	
	public ActionForward buscarSolicitudes(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarSolicitudes, inicio");
		logger.info("buscarSolicitudes, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward continuar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("continuar, inicio");
		HttpSession sesion = request.getSession(false);
		GestionScoringForm gestionScoringForm = (GestionScoringForm) form;
		String forward = "";

		SolicitudScoringAjaxDTO[] listaSolicitud = (SolicitudScoringAjaxDTO[]) sesion.getAttribute("listaSolicitudes");
		SolicitudScoringAjaxDTO solicitudScoringAjaxDTO = new SolicitudScoringAjaxDTO();
		solicitudScoringAjaxDTO.setNroSolScoring(gestionScoringForm.getNumSolScoringSel());

		if (listaSolicitud != null) {
			for (int i = 0; i < listaSolicitud.length; i++) {
				if (listaSolicitud[i].getNroSolScoring().equals(gestionScoringForm.getNumSolScoringSel())) {
					solicitudScoringAjaxDTO = (SolicitudScoringAjaxDTO) listaSolicitud[i].clone();
					break;
				}
			}
		}
		sesion.setAttribute("solicitudSel", solicitudScoringAjaxDTO);
		
		String codEstadoActual = solicitudScoringAjaxDTO.getCodEstado();
		logger.info("codEstadoActual: " + codEstadoActual);
		gestionScoringForm.setCodEstadoSol(codEstadoActual);

		if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.pendiente.enviar"))) {
			forward = "agregarLineas"; // Agregar lineas a la solicitud de scoring
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.aprobado"))
				|| codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.solnormal"))) {
			lineasScoring(request, gestionScoringForm);
			forward = "lineasScoring";// listar lineas asociadas a la solicitud de scoring
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.evaluado"))) {
			forward = "irAResumenScoring";
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.rechazado"))) {
			forward = "irAResumenScoring";
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.pendiente.revision"))) {
			forward = "";
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.cancelado"))) {
			forward = "irAResumenScoring";
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.pendiente.preactivar"))) {
			forward = "irAResumenScoring";
		}
		else if (codEstadoActual.trim().equals(global.getValorExterno("scoring.estado.preactivo"))) {
			forward = "irAResumenScoring";
		}

		logger.info("continuar, fin");
		return mapping.findForward(forward);
	}
	
	private void lineasScoring(HttpServletRequest request, GestionScoringForm gestionScoringForm)
		throws VentasException, RemoteException {	
		
		logger.info("lineasScoring, inicio");
		HttpSession sesion = request.getSession(false);
		
		Long nroSolicitudSeleccionada = Long.valueOf(gestionScoringForm.getNumSolScoringSel().trim());
		logger.debug("nroSolicitudSeleccionada:" + nroSolicitudSeleccionada);
		
		// obtener lineas de la solicitud				
		LineaSolicitudScoringDTO[] listaLineasScoring = delegate.getlineasSolScoring(nroSolicitudSeleccionada);		
		sesion.setAttribute("lineasScoring", listaLineasScoring);
		if(listaLineasScoring!=null) sesion.setAttribute("totalLineas", new Integer(listaLineasScoring.length));	
		
		//Obtiene numero de venta y numero de transaccion de venta
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		CabeceraArchivoDTO cabeceraPV = delegate.getParametrosVenta(cabecera);
		sesion.setAttribute("numVenta", new Long(cabeceraPV.getNumeroVenta()));
		sesion.setAttribute("numTransaccion", new Long(cabeceraPV.getNumeroTransaccionVenta()));
		
		logger.info("lineasScoring, fin");
	
	}
	
	public ActionForward completarLineas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
		throws Exception 
	{
		logger.info("completarLineas, inicio");
		logger.info("completarLineas, fin");
		return mapping.findForward("completarLineas");
	}
	
	public ActionForward cancelarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
		throws Exception 
	{
		logger.info("cancelarSolicitud, inicio");
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO) request.getSession().getAttribute("paramGlobal");
		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(paramGlobal.getCodUsuario());
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);		
		EstadoScoringDTO estadoCancelado = new EstadoScoringDTO();
		final String estadoDestino = global.getValorExterno("scoring.estado.cancelado");
		GestionScoringForm gestionScoringForm = (GestionScoringForm) form;
		logger.debug("estadoDestino [" + estadoDestino + "]");
		estadoCancelado.setCodEstado(estadoDestino);
		estadoCancelado.setNumSolScoring(Long.valueOf(gestionScoringForm.getNumSolScoringSel().trim()).longValue());
		estadoCancelado.setCodVendedor(usuarioSCLDTO.getCodigoVendedor());
		delegate.insertaEstadoScoring(estadoCancelado);
		logger.info("cancelarSolicitud, fin");
		return mapping.findForward("recargar");
	}
	
	public ActionForward anteriorMostrarLineas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
		throws Exception 
	{
		logger.info("anteriorMostrarLineas, inicio");
		logger.info("anteriorMostrarLineas, fin");
		return mapping.findForward("inicio");
	}
	

	public ActionForward buscarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarCliente, inicio");
		logger.info("buscarCliente, fin");
		return mapping.findForward("buscarCliente");
	}
	
	public ActionForward cargarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cargarCliente, inicio");
		GestionScoringForm f = (GestionScoringForm) form;
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("clienteSel") != null) {
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO) sesion.getAttribute("clienteSel");
			f.setCodTipoCliente(clienteSel.getTipoCliente());
			f.setGlsTipoCliente(clienteSel.getGlsTipoCliente());
			f.setCodCliente(clienteSel.getCodigoCliente());
		}
		logger.info("cargarCliente, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cancelarCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarCliente, inicio");
		GestionScoringForm f = (GestionScoringForm) form;
		f.setCodTipoCliente(null);
		f.setGlsTipoCliente(null);
		f.setCodCliente(null);
		logger.info("cancelarCliente, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward limpiarConsulta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("limpiarConsulta, inicio");
		GestionScoringForm f = (GestionScoringForm) form;
		f.setFechaDesde(null);
		f.setFechaHasta(null);
		f.setCodTipoCliente(null);
		f.setGlsTipoCliente(null);
		f.setCodCliente(null);		
		f.setNumSolScoring(null);
		f.setNumSolScoringSel(null);		
		logger.info("limpiarConsulta, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward irAReporteScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("irAReporteScoring, inicio");
		GestionScoringForm f = (GestionScoringForm) form;
		final Long numSolScoring = new Long(f.getNumSolScoringSel());
		logger.debug("numSolScoring [" + numSolScoring + "]");
		request.setAttribute("numSolScoring", numSolScoring);
		logger.info("irAReporteScoring, fin");
		return mapping.findForward("irAReporteScoring");
	}
	
	
}
