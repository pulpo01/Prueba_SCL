package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.RestitucionEquipoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class RecargaModalidadAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        loggerDebug("inicio(Action): RecargaModalidadAction");
        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();
        HttpSession session = request.getSession(true);

        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) form;
        ServiceContextDTO context = (ServiceContextDTO) session.getAttribute("login");

        RecargaCboModalidadInDTO inDTO = new RecargaCboModalidadInDTO();
        inDTO.setStrCodTipContrato(restitucionEquipoForm.getStrCodTipContrato());
        inDTO.setStrNomUsuario(context.getUsername());

        loggerInfo("Codigo de Tipo de Contrato [" + inDTO.getStrCodTipContrato() + "]");
        loggerInfo("Nombre de Usuario [" + inDTO.getStrNomUsuario() + "]");

        RecargaCboModalidadOutDTO outDTO = new RecargaCboModalidadOutDTO();
        outDTO = beanLocal.recargarCboModalidad(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        request.getSession().setAttribute("RecargaCboModalidadOutDTO", outDTO);

        loggerDebug("fin(Action)RecargaModalidadAction:");
        return mapping.findForward("success");

    }

}
