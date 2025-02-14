package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.TiposComportamientoForm;

/**
 * @author JIB
 *
 */
public class TiposComportamientoAction extends DispatchAction {

	private final Logger logger = Logger.getLogger(TiposComportamientoAction.class);

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	DatosLineaScoringForm datosLineaScoringForm;
	private DatosLineaForm		  datosLineasForm;

	DatosLineaScoringForm getDatosLineaScoringForm(HttpServletRequest request) {
		return datosLineaScoringForm == null ? (DatosLineaScoringForm) request.getSession().getAttribute(
				"DatosLineaScoringForm") : datosLineaScoringForm;
	}
	
	private DatosLineaForm getDatosLineaForm(HttpServletRequest request) {
		return datosLineasForm == null ? (DatosLineaForm) request.getSession().getAttribute("DatosLineaForm") : datosLineasForm;
	}

	PlanesAdicionalesScoringForm planesAdicionalesScoringForm;

	PlanesAdicionalesScoringForm getPlanesAdicionalesScoringForm(HttpServletRequest request) {
		return planesAdicionalesScoringForm == null ? (PlanesAdicionalesScoringForm) request.getSession().getAttribute(
				"PlanesAdicionalesScoringForm") : planesAdicionalesScoringForm;
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, tipoComportamiento");
		TiposComportamientoForm f = (TiposComportamientoForm) form;
		
		//Inicio P-CSR-11002 19-04-2011 JLGN
		String codPlanTarif= null;
		String codPrestacion = null;
		
		
		//Inicio P-CSR-11002 19-04-2011 JLGN
		if(getDatosLineaScoringForm(request) == null){
			logger.info("getDatosLineaScoringForm(request) == null");
			f.setNumSolScoring(0);
			f.setDesEstadoActual("");		
			
			codPlanTarif = (String)request.getSession().getAttribute("codPlanTarif"); //getDatosLineaForm(request).getCodPlanTarif();
			codPrestacion = (String)request.getSession().getAttribute("codPrestacion");//getDatosLineaForm(request).getCodTipoPrestacion();
	
			logger.info("codSeleccionPlanTarif  = "+codPlanTarif);
			logger.info("codSeleccionPrestacion = "+codPrestacion);	
			
			request.getSession().setAttribute("codPlanTarif", codPlanTarif);
			request.getSession().setAttribute("codPrestacion", codPrestacion);
			request.getSession().setAttribute("numeroScoring",String.valueOf(0));
			
		}else{		
			logger.info("getDatosLineaScoringForm(request) == NotNull");	
			f.setNumSolScoring(getDatosLineaScoringForm(request).getNumSolScoring());			
			f.setDesEstadoActual(getDatosLineaScoringForm(request).getDesEstadoActual());
			request.getSession().setAttribute("numeroScoring",String.valueOf(f.getNumSolScoring()));
		}
		//Fin P-CSR-11002 19-04-2011 JLGN		
		
		final TipoComportamientoDTO[] tipos = delegate.obtenerTiposComportamiento();
		logger.debug("tipos.length [" + tipos.length + "]");
		f.setTipos(tipos);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward irAPlanesAdicionalesScoring(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("irAPlanesAdicionalesScoring, inicio");
		TiposComportamientoForm f = (TiposComportamientoForm) form;
		logger.debug("f.getCsvSeleccionados() [" + f.getTiposSeleccionadosEnCSV() + "]");
		logger.info("irAPlanesAdicionalesScoring, fin");
		return mapping.findForward("irAPlanesAdicionalesScoring");
	}

	public ActionForward volverPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("volverPAScoring" + ", inicio");
		logger.info("volverPAScoring" + ", fin");
		return mapping.findForward("volverPAScoring");
	}
	
	//Inicio P-CSR-11002 JLGN 21-04.2011
	public ActionForward volverPAScoring2(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("volverPAScoring2" + ", inicio");
		logger.info("volverPAScoring2" + ", fin");
		return mapping.findForward("volverPAScoring2");
	}
	//Fin P-CSR-11002 JLGN 21-04.2011

	public ActionForward cancelarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarPAScoring, inicio");
		((TiposComportamientoForm) form).setTiposSeleccionadosEnCSV(null);
		if (getPlanesAdicionalesScoringForm(request) != null) {
			getPlanesAdicionalesScoringForm(request).setProductosSeleccionadosEnCSV(null);
		}
		logger.info("cancelarPAScoring, fin");
		return mapping.findForward("cancelarPAScoring");
	}

}
