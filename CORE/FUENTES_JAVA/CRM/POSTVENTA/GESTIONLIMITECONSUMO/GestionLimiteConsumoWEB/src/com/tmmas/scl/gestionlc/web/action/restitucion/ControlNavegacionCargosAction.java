package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.SolicitudAutDescuentoForm;

public class ControlNavegacionCargosAction extends AbstractAction {

    private static final String OBTENCION_CARGOS = "obtenerCargos";
    private static final String CARGOS = "cargosAction";
    private static final String SOLICITUD_DESCUENTO = "solicDescuento";
    private static final String RESUMEN = "resumenAction";
    private static final String PRESUPUESTO = "presupuesto";
    private static final String INICIO = "inicio";

    protected ActionForward doPerform(ActionMapping pMapping, ActionForm pForm, HttpServletRequest pRequest, HttpServletResponse pHttpResponse)

        throws Exception {

        loggerDebug("execute ControlNavegacionCargosAction");

        HttpSession session = pRequest.getSession(false);

        String controlUltPagina = (String) session.getAttribute("ultimaPagina");
        String recalcular = (String) session.getAttribute("recalcular");
        String solicDesc = (String) session.getAttribute("cumpleDescuento");
        String autDesc = (String) session.getAttribute("accionAutDesc");
        CargosForm cargosForm = (CargosForm) session.getAttribute("CargosForm");

        if (controlUltPagina == null || controlUltPagina.equalsIgnoreCase("") || controlUltPagina.equalsIgnoreCase("negocio")) {
            // Si viene desde un action externo a cargos
            return pMapping.findForward(CARGOS);

            // Si la última página es cargos y hay que recalcular cargos
            // -->ActionExterno
        } else if (controlUltPagina.equalsIgnoreCase("cargos") && recalcular != null && recalcular.equalsIgnoreCase("SI")) {
            loggerDebug("RECALCULAR CARGOS");
            session.setAttribute("ultimaPagina", "");
            session.setAttribute("recalcular", "NO");
            return pMapping.findForward(OBTENCION_CARGOS);

            // Si la última página visitada es cargos y no hay que
            // recalcular-->ResumenAction
        } else if (controlUltPagina.equalsIgnoreCase("cargos")) {
            session.setAttribute("ultimaPagina", "");
            if (solicDesc != null && solicDesc.equalsIgnoreCase("SI")) {
                session.setAttribute("cumpleDescuento", "NO");

                SolicitudAutDescuentoForm solDesc = (SolicitudAutDescuentoForm) session.getAttribute("SolicitudAutDescuentoForm");
                if (solDesc != null) {
                    solDesc.setFlgIniciado(false);
                }
                return pMapping.findForward(SOLICITUD_DESCUENTO);
            } else if (cargosForm.getRbCiclo().equalsIgnoreCase("NO")) {
                return pMapping.findForward(PRESUPUESTO);
            }
            return pMapping.findForward(RESUMEN);

        } else if (controlUltPagina.equalsIgnoreCase("SolicDescuento")) {
            session.setAttribute("accionAutDesc", "");
            session.setAttribute("ultimaPagina", "");
            if (autDesc != null && autDesc.equalsIgnoreCase("Atras")) {
                return pMapping.findForward(CARGOS);
            } else {
                if (cargosForm != null && cargosForm.getRbCiclo() != null && cargosForm.getRbCiclo().equalsIgnoreCase("SI")) {
                    return pMapping.findForward(RESUMEN);
                } else {

                    return pMapping.findForward(PRESUPUESTO);
                }
            }
        } else if (controlUltPagina.equalsIgnoreCase("Presupuesto")) {
            session.setAttribute("accionAutDesc", "");
            session.setAttribute("ultimaPagina", "");
            if (autDesc != null) {
                if (autDesc.equalsIgnoreCase("Anterior")) {
                    return pMapping.findForward(CARGOS);
                } else {
                    return pMapping.findForward(RESUMEN);
                }
            }
        }

        return pMapping.findForward("error");
    }

}
