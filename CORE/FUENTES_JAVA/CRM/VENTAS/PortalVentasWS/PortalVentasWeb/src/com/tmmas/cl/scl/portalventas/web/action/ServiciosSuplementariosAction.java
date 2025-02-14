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

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.ServiciosSuplementariosForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class ServiciosSuplementariosAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(ServiciosSuplementariosAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ServiciosSuplementariosAction() {
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
	}

	/**
	 * @author JIB
	 * @param request
	 * @return
	 */
	private DatosLineaScoringForm getDatosLineaScoringFormEnSession(HttpServletRequest request) {
		return (DatosLineaScoringForm) request.getSession().getAttribute("DatosLineaScoringForm");
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		ServiciosSuplementariosForm f = (ServiciosSuplementariosForm) form;
		f.setModuloWebOrigen(global.getValor("modulo.web.solicitudventa"));
		HttpSession sesion = request.getSession(false);
		ArrayList arrayServiciosDef = new ArrayList();
		ArrayList arrayServiciosAct = new ArrayList();
		ArrayList arrayServiciosDisp = new ArrayList();
		arrayServiciosAct = (ArrayList) sesion.getAttribute("listaServiciosAct");
		if ((arrayServiciosAct == null) || (arrayServiciosAct.size() == 0)) {
			// carga listas
			String indVentaExterna = "";
			String codTipoCliente = "";
			String codPlanTarif = "";
			String codTecnologia = "";
			String tipoRed = "";
			String codUso = "";
			String codActAbo = "";			
			String tipoTerminal = "";
			String codCentral = "";			
			String indCompatible = global.getValor("indicador.compatible");

			// (+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente = datosVentaForm.getCodTipoCliente();
			}
			// (-)

			DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
			if (datosLineaForm != null) {
				codPlanTarif = datosLineaForm.getCodPlanTarif();
				codTecnologia = datosLineaForm.getCodTecnologia();
				tipoRed = datosLineaForm.getTipoRed();
				codUso = datosLineaForm.getCodUsoLinea();
				tipoTerminal = datosLineaForm.getCodTipoTerminal();
				codCentral = datosLineaForm.getCodCentral();
			}

			if (!(codTipoCliente.equals(global.getValor("tipo.cliente.prepago")))) {
				if (codUso.equals(global.getValor("codigo.uso.hibrido"))) {
					codActAbo = global.getValor("codigo.actuacion.hibrido");
				}
				else {
					if (indVentaExterna.equals("1")) {
						codActAbo = global.getValor("codigo.actuacion.movil.externa");
					}
					else {
						codActAbo = global.getValor("codigo.actuacion.movil.interna");
					}
				}
			}
			else {
				codActAbo = global.getValor("codigo.actuacion.prepago");
			}
			logger.debug("codActAbo=" + codActAbo);
			// obtiene SS por defecto y opcionales
			ListadoSSInDTO paramSS = new ListadoSSInDTO();
			paramSS.setIndCompatible(indCompatible);
			paramSS.setCodigoPlan(codPlanTarif);
			paramSS.setCodTecnologica(codTecnologia);
			paramSS.setCodActAbo(codActAbo);

			ListadoSSOutDTO[] listadoSS = delegate.getListadoSS(paramSS);

			String ssOpcional = global.getValor("servicio.suplementario.opcional");
			String ssDefecto = global.getValor("servicio.suplementario.defecto");
			if (listadoSS != null) {
				for (int i = 0; i < listadoSS.length; i++) {
					ListadoSSOutDTO ssLista = listadoSS[i];

					if (ssLista.getIndIP() == null || ssLista.getIndIP().equals("0")) {
						ssLista.setIndIP("N/A");
					}
					else if (ssLista.getIndIP().equals("1")) {
						ssLista.setIndIP("Fija");
					}
					else if (ssLista.getIndIP().equals("2")) {
						ssLista.setIndIP("Dinámica");
					}
					if (ssLista.getIndSS().equals(ssOpcional)) {
						if (ssLista.getTipoRed().equals(tipoRed)) {// filtra por tipo de red
							arrayServiciosDisp.add(ssLista);
						}
					}
					else {
						if (ssLista.getTipoRed().equals(tipoRed)) {// filtra por tipo de red
							arrayServiciosDef.add(ssLista);
						}
					}
				}// fin for
			}// fin if (listadoSS!=null)
			
			
			// Obtengo las reglas de validacion (Para revisar la incompatibilidad de ss)
			ReglaSSDTO busquedaReglas = new ReglaSSDTO();
			busquedaReglas.setCodTecnologia(codTecnologia);
			busquedaReglas.setTipTerminal(tipoTerminal);
			busquedaReglas.setCodCentral(codCentral);
		    ReglaSSDTO reglasValidacion[]=null;
		    reglasValidacion = delegate.getReglasdeValidacionSS(busquedaReglas); 

		    request.setAttribute("reglasValidacion", reglasValidacion);
			sesion.setAttribute("listaServiciosDef", arrayServiciosDef);
			sesion.setAttribute("listaServiciosDisp", arrayServiciosDisp);
		}
		inicializar(sesion, f);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar, inicio");
		logger.info("aceptar, fin");
		return mapping.findForward("aceptar");
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		// reestablece listas originales
		ArrayList listaServiciosDefOrig = (ArrayList) sesion.getAttribute("listaServiciosDefOrig");
		ArrayList listaServiciosActOrig = (ArrayList) sesion.getAttribute("listaServiciosActOrig");
		ArrayList listaServiciosDispOrig = (ArrayList) sesion.getAttribute("listaServiciosDispOrig");
		sesion.setAttribute("listaServiciosDef", listaServiciosDefOrig.clone());
		sesion.setAttribute("listaServiciosAct", listaServiciosActOrig.clone());
		sesion.setAttribute("listaServiciosDisp", listaServiciosDispOrig.clone());
		sesion.removeAttribute("listaServiciosDefOrig");
		sesion.removeAttribute("listaServiciosActOrig");
		sesion.removeAttribute("listaServiciosDispOrig");
		logger.info("cancelar, fin");
		return mapping.findForward("aceptar");
	}

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		return mapping.findForward("irAMenu");
	}

	// ---------- (+) buscar numero ---------------------//
	public ActionForward buscarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("buscarNumero, inicio");
		ServiciosSuplementariosForm serviciosSuplementariosForm = (ServiciosSuplementariosForm) form;
		if (serviciosSuplementariosForm.getNumFax() != null && !serviciosSuplementariosForm.getNumFax().equals("")) {
			HttpSession sesion = request.getSession(false);
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(serviciosSuplementariosForm.getNumFax());
			numeroSel.setTablaNumeracion(serviciosSuplementariosForm.getTablaNumeracion());
			numeroSel.setCategoria(serviciosSuplementariosForm.getCategoriaNumeracion());
			sesion.setAttribute("numeroSel", numeroSel);
		}
		logger.debug("buscarNumero, fin");
		return mapping.findForward("buscarNumero");
	}

	public ActionForward cargarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("cargarNumero, inicio");
		ServiciosSuplementariosForm ssForm = (ServiciosSuplementariosForm) form;
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("numeroSel") != null) {
			NumeroAjaxDTO numeroSel = (NumeroAjaxDTO) sesion.getAttribute("numeroSel");
			ssForm.setNumFax(numeroSel.getNumCelular());
			ssForm.setTablaNumeracion(numeroSel.getTablaNumeracion());
			ssForm.setCategoriaNumeracion(numeroSel.getCategoria());
			sesion.removeAttribute("numeroSel");
			// (+) variables usadas en caso de anular la reserva
			/*
			 * ssForm.setCodSubAlmNumeracion(datosLineaForm.getCodSubAlm());
			 * ssForm.setCodCentralNumeracion(datosLineaForm.getCodCentral());
			 * ssForm.setCodUsoNumeracion(datosLineaForm.getCodUsoLinea());
			 */
			// (-)
		}
		logger.debug("cargarNumero, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) buscar numero ---------------------//

	// ---------- (+) cancelar busqueda de numero ----------//
	public ActionForward cancelarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("cancelarNumero, inicio");
		logger.debug("cancelarNumero, fin");
		return mapping.findForward("inicio");
	}

	// ---------- (-) cancelar busqueda de serie ----------//

	private void inicializar(HttpSession sesion, ServiciosSuplementariosForm f) throws VentasException, RemoteException {
		// guarda listas originales, para usarlas en accion Cancelar
		f.setModuloWebScoring(global.getValor("modulo.web.scoring"));
		f.setModuloWebSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
		ArrayList listaServiciosDefOrig = (ArrayList) sesion.getAttribute("listaServiciosDef");
		ArrayList listaServiciosActOrig = (ArrayList) sesion.getAttribute("listaServiciosAct");
		ArrayList listaServiciosDispOrig = (ArrayList) sesion.getAttribute("listaServiciosDisp");
		if (listaServiciosDefOrig == null)
			listaServiciosDefOrig = new ArrayList();
		if (listaServiciosActOrig == null)
			listaServiciosActOrig = new ArrayList();
		if (listaServiciosDispOrig == null)
			listaServiciosDispOrig = new ArrayList();
		// Obtiene valores de los grupos especiales 911 - FAX - CORREO MOVISTAR
		sesion.setAttribute("listaServiciosDefOrig", listaServiciosDefOrig.clone());
		sesion.setAttribute("listaServiciosActOrig", listaServiciosActOrig.clone());
		sesion.setAttribute("listaServiciosDispOrig", listaServiciosDispOrig.clone());
		ParametrosGeneralesDTO parametro911 = new ParametrosGeneralesDTO();
		parametro911.setCodigoproducto(global.getValor("codigo.producto"));
		parametro911.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametro911.setNombreparametro(global.getValor("parametro.911"));
		parametro911 = delegate.getParametroGeneral(parametro911);
		sesion.setAttribute("icgServicioAsistencia911", parametro911.getValorparametro());
		ParametrosGeneralesDTO maxContactos = new ParametrosGeneralesDTO();
		maxContactos.setCodigoproducto(global.getValor("codigo.producto"));
		maxContactos.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		maxContactos.setNombreparametro(global.getValor("parametro.max.contactos"));
		maxContactos = delegate.getParametroGeneral(maxContactos);
		sesion.setAttribute("maxContactos911", maxContactos.getValorparametro());
		ParametrosGeneralesDTO parametroCMovistar = new ParametrosGeneralesDTO();
		parametroCMovistar.setCodigoproducto(global.getValor("codigo.producto"));
		parametroCMovistar.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametroCMovistar.setNombreparametro(global.getValor("parametro.correo.movistar"));
		parametroCMovistar = delegate.getParametroGeneral(parametroCMovistar);
		sesion.setAttribute("icgServicioCorreoMovistar", parametroCMovistar.getValorparametro());
		ParametrosGeneralesDTO parametroFAX = new ParametrosGeneralesDTO();
		parametroFAX.setCodigoproducto(global.getValor("codigo.producto"));
		parametroFAX.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametroFAX.setNombreparametro(global.getValor("parametro.fax"));
		parametroFAX = delegate.getParametroGeneral(parametroFAX);
		sesion.setAttribute("icgServicioFax", parametroFAX.getValorparametro());
		sesion.setAttribute("url.componente.ss911", global.getValorExterno("url.componente.ss911"));
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
	public ActionForward inicioScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioScoring, inicio");
		ServiciosSuplementariosForm f = (ServiciosSuplementariosForm) form;
		f.setModuloWebOrigen(global.getValor("modulo.web.scoring"));
		HttpSession sesion = request.getSession(false);
		ArrayList arrayServiciosDef = new ArrayList();
		ArrayList arrayServiciosAct = new ArrayList();
		ArrayList arrayServiciosDisp = new ArrayList();
		arrayServiciosAct = (ArrayList) sesion.getAttribute("listaServiciosAct");
		if ((arrayServiciosAct == null) || (arrayServiciosAct.size() == 0)) {
			String codPlanTarif = "";
			String codTecnologia = "";
			String tipoRed = "";
			String codUso = "";
			String codActAbo = "";
			String indCompatible = global.getValor("indicador.compatible");
			DatosLineaScoringForm scoringForm = getDatosLineaScoringFormEnSession(request);
			String indVentaExterna = scoringForm.getIndVtaExterna(); 
			logger.debug("indVentaExterna [" + indVentaExterna + "]");
			codPlanTarif = scoringForm.getCodPlanTarif();
			logger.debug("codPlanTarif [" + codPlanTarif + "]");
			codTecnologia = scoringForm.getCodTecnologia();
			logger.debug("codTecnologia [" + codTecnologia + "]");
			tipoRed = scoringForm.getTipoRed();
			logger.debug("tipoRed [" + tipoRed + "]");
			codUso = scoringForm.getCodUsoLinea();
			logger.debug("codUso [" + codUso + "]");
			if (codUso.equals(global.getValor("codigo.uso.hibrido"))) {
				codActAbo = global.getValor("codigo.actuacion.hibrido");
			}
			else {
				if (indVentaExterna.equals("1")) {
					codActAbo = global.getValor("codigo.actuacion.movil.externa");
				}
				else {
					codActAbo = global.getValor("codigo.actuacion.movil.interna");
				}
			}
			logger.debug("codActAbo [" + codActAbo + "]");
			ListadoSSInDTO paramSS = new ListadoSSInDTO();
			paramSS.setIndCompatible(indCompatible);
			paramSS.setCodigoPlan(codPlanTarif);
			paramSS.setCodTecnologica(codTecnologia);
			paramSS.setCodActAbo(codActAbo);
			ListadoSSOutDTO[] listadoSS = delegate.getListadoSS(paramSS);
			String ssOpcional = global.getValor("servicio.suplementario.opcional");
			if (listadoSS != null) {
				for (int i = 0; i < listadoSS.length; i++) {
					ListadoSSOutDTO ssDTO = listadoSS[i];
					if (ssDTO.getIndIP() == null || ssDTO.getIndIP().equals("0")) {
						ssDTO.setIndIP("N/A");
					}
					else if (ssDTO.getIndIP().equals("1")) {
						ssDTO.setIndIP("Fija");
					}
					else if (ssDTO.getIndIP().equals("2")) {
						ssDTO.setIndIP("Dinámica");
					}
					if (ssDTO.getIndSS().equals(ssOpcional)) {
						if (ssDTO.getTipoRed().equals(tipoRed)) {// filtra por tipo de red
							arrayServiciosDisp.add(ssDTO);
						}
					}
					else {
						if (ssDTO.getTipoRed().equals(tipoRed)) {// filtra por tipo de red
							arrayServiciosDef.add(ssDTO);
						}
					}
				}
			}
			sesion.setAttribute("listaServiciosDef", arrayServiciosDef);
			sesion.setAttribute("listaServiciosDisp", arrayServiciosDisp);
		}
		inicializar(sesion, f);
		logger.info("inicioScoring, fin");
		return mapping.findForward("inicio");
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
	public ActionForward aceptarScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarScoring, inicio");
		logger.info("aceptarScoring, fin");
		return mapping.findForward("aceptarScoring");
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
	public ActionForward cancelarScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarScoring, inicio");
		cancelar(mapping, form, request, response);
		logger.info("cancelarScoring, fin");
		return mapping.findForward("aceptarScoring");
	}
}
