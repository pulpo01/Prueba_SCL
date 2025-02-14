package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.TiposComportamientoForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

/**
 * @author JIB
 *
 */
public class PlanesAdicionalesScoringAction extends DispatchAction {

	private static final String MENSAJE_ERROR_NO_EXISTEN_PRODUCTOS = "No se encontraron productos para la prestación solicitada.";

	private final Logger logger = Logger.getLogger(PlanesAdicionalesScoringAction.class);

	private Global global = Global.getInstance();

	private PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	private TiposComportamientoForm tiposComportamientoForm;

	private DatosLineaScoringForm datosLineaScoringForm;
	private DatosLineaForm		  datosLineasForm;

	private DatosLineaScoringForm getDatosLineaScoringForm(HttpServletRequest request) {
		return datosLineaScoringForm == null ? (DatosLineaScoringForm) request.getSession().getAttribute("DatosLineaScoringForm") : datosLineaScoringForm;
	}
	private DatosLineaForm getDatosLineaForm(HttpServletRequest request) {
		return datosLineasForm == null ? (DatosLineaForm) request.getSession().getAttribute("DatosLineaForm") : datosLineasForm;
	}
	private TiposComportamientoForm getTiposComportamientoForm(HttpServletRequest request) {
		return tiposComportamientoForm == null ? (TiposComportamientoForm) request.getSession().getAttribute(
				"TiposComportamientoForm") : tiposComportamientoForm;
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, PlanesAdicionalesScoringAction");
		PlanesAdicionalesScoringForm f = (PlanesAdicionalesScoringForm) form;
		
		//Inicio P-CSR-11002 19-04-2011 JLGN
		String codPlanTarif= null;
		String codPrestacion = null;
		String tiposSeleccionadosEnCSV = null;
				
		if(getDatosLineaScoringForm(request) == null){
			logger.info("getDatosLineaScoringForm(request) = null" );
			codPlanTarif = (String)request.getSession().getAttribute("codPlanTarif");
			codPrestacion = (String)request.getSession().getAttribute("codPrestacion");
			logger.info("codPlanTarif = " + codPlanTarif );
			logger.info("codPrestacion = " + codPrestacion );
			f.setNumSolScoring(0);
			f.setDesEstadoActual("");
			tiposSeleccionadosEnCSV = getTiposComportamientoForm(request).getTiposSeleccionadosEnCSV();
		}else{	
			logger.info("getDatosLineaScoringForm(request) = NOTnull" );
			f.setNumSolScoring(getDatosLineaScoringForm(request).getNumSolScoring());
			f.setDesEstadoActual(getDatosLineaScoringForm(request).getDesEstadoActual());
			codPlanTarif = getDatosLineaScoringForm(request).getCodPlanTarif();
			logger.debug("codPlanTarif [" + codPlanTarif + "]");
			codPrestacion = getDatosLineaScoringForm(request).getCodTipoPrestacion();
			logger.debug("codPrestacion [" + codPrestacion + "]");
			tiposSeleccionadosEnCSV = getTiposComportamientoForm(request).getTiposSeleccionadosEnCSV();
			logger.debug("productosSeleccionadosEnCSV [" + tiposSeleccionadosEnCSV + "]");			
		}
		String[] codigosTipoComportamiento = tiposSeleccionadosEnCSV.split(",");
		final String codCanal = global.getValor("canal.pa.venta");
		final String nivel = global.getValor("nivel.pa.abonado");	
		//Fin P-CSR-11002 19-04-2011 JLGN
		
		final ProductoOfertadoDTO[] productos = delegate.obtenerProductosOfertadosXFiltros(codPlanTarif, codCanal,
				nivel, codPrestacion, codigosTipoComportamiento);
		f.setProductos(productos);
		if (productos == null || productos.length == 0) {
			f.setMensajeError(MENSAJE_ERROR_NO_EXISTEN_PRODUCTOS);
		}
		else {
			f.setMensajeError(null);
		}
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward irATiposComportamiento(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("irATiposComportamiento, inicio");
		logger.info("irATiposComportamiento, fin");
		return mapping.findForward("irATiposComportamiento");
	}

	public ActionForward aceptarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarPAScoring, inicio");
		logger.info("aceptarPAScoring, fin");
		
		//Inicio P-CSR-11002 02-04-2011 JLGN
		String numeroScoring = (String)request.getSession().getAttribute("numeroScoring");
		logger.info("numeroScoring: "+numeroScoring);
		if (Long.parseLong(numeroScoring)== 0){
			logger.info("aceptarPAScoring2");
			return mapping.findForward("aceptarPAScoring2");
		}else{
			logger.info("aceptarPAScoring");
			return mapping.findForward("aceptarPAScoring");
		}	
		//Fin P-CSR-11002 02-04-2011 JLGN
	}

	public ActionForward cancelarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarPAScoring, inicio");
		if (getTiposComportamientoForm(request) != null) {
			getTiposComportamientoForm(request).setTiposSeleccionadosEnCSV(null);
		}
		((PlanesAdicionalesScoringForm) form).setProductosSeleccionadosEnCSV(null);
		logger.info("cancelarPAScoring, fin");
		return mapping.findForward("cancelarPAScoring");
	}

}
