package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.RestitucionEquipoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class RestitucionEquipoAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        loggerDebug("inicio(Action): RestitucionEquipoAction");
        HttpSession session = request.getSession(true);

        session.setAttribute("titulo", "Selección de Equipo");

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();

        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) form;
        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        String strUserName = (String) request.getSession().getAttribute("UserName");
        Long lonNumSiniestro = (Long) request.getSession().getAttribute("NumSiniestro");

        CargaSeleccionEquipoInDTO inDTO = new CargaSeleccionEquipoInDTO();

        inDTO.setStrIndProcedencia(restitucionEquipoForm.getStrProcedencia());
        inDTO.setStrCodTipContrato(restitucionEquipoForm.getStrCodTipContrato());
        inDTO.setStrCodModVenta(restitucionEquipoForm.getStrCodModPago());
        inDTO.setStrNomUsuario(strUserName);
        inDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));
        inDTO.setLonNumSiniestro(lonNumSiniestro);

        loggerInfo("IndProcedencia [" + inDTO.getStrIndProcedencia() + "]");
        loggerInfo("CodTipContrato  [" + inDTO.getStrCodTipContrato() + "]");
        loggerInfo("CodModVenta [" + inDTO.getStrCodModVenta() + "]");
        loggerInfo("NomUsuario [" + inDTO.getStrNomUsuario() + "]");
        loggerInfo("NumAbonado [" + inDTO.getLonNumAbonado() + "]");
        loggerInfo("NumSiniestro [" + inDTO.getLonNumSiniestro() + "]");

        CargaSeleccionEquipoOutDTO outDTO = new CargaSeleccionEquipoOutDTO();
        outDTO = beanLocal.cargarSeleccionEquipo(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        session.setAttribute("CargaSeleccionEquipoOutDTO", outDTO);
        session.setAttribute("StrCodCatTributaria", restitucionEquipoForm.getStrCodCatTributaria());
        session.setAttribute("StrCodModPago", restitucionEquipoForm.getStrCodModPago());
        session.setAttribute("StrCodTipContrato", restitucionEquipoForm.getStrCodTipContrato());
        session.setAttribute("StrCodNumContrato", restitucionEquipoForm.getStrCodNumContrato());

        loggerDebug("fin(Action): RestitucionEquipoAction");

        return mapping.findForward("success");

    }

}
