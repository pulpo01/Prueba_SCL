package com.tmmas.scl.gestionlc.web.action.abonolc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.abonolc.ResumenForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class ResumenAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private AbonoLimiteConsumo abonoLimiteConsumo;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        locator = new GestionLimiteConsumoLocator();
        abonoLimiteConsumo = locator.getAbonoLimiteConsumoFacade();

        ResumenForm resumenForm = (ResumenForm) form;

        String strComentario = resumenForm.getStrComentario();

        EjecucionAbonoLimiteConsumoInDTO ejecucionDTO = (EjecucionAbonoLimiteConsumoInDTO) request.getSession().getAttribute(
                "ejecucionAbonoLimiteConsumoOutDTO");

        ejecucionDTO.setStrComentario(strComentario);

        EjecucionAbonoLimiteConsumoOutDTO result = abonoLimiteConsumo.ejecutarAbonoLimiteConsumo(ejecucionDTO);

        validaResult(result.getIEvento(), result.getStrCodError(), result.getStrDesError());

        request.setAttribute("numOOSS", result.getStrNumOOSS());

        return mapping.findForward("success");
    }

}
