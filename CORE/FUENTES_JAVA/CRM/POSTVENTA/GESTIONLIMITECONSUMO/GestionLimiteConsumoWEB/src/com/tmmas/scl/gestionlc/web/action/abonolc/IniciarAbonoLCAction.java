package com.tmmas.scl.gestionlc.web.action.abonolc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class IniciarAbonoLCAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private AbonoLimiteConsumo abonoLimiteConsumo;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        // logger.info("SUCCESS", IniciarAbonoLCAction.class.getSimpleName());
        locator = new GestionLimiteConsumoLocator();
        abonoLimiteConsumo = locator.getAbonoLimiteConsumoFacade();

        CargaAbonoLimiteConsumoInDTO cargaAbonoLimiteConsumoInDTO = new CargaAbonoLimiteConsumoInDTO();

        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        cargaAbonoLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));

        CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO = abonoLimiteConsumo.cargaAbonoLimiteConsumo(cargaAbonoLimiteConsumoInDTO);

        validaResult(cargaAbonoLimiteConsumoOutDTO.getIEvento(), cargaAbonoLimiteConsumoOutDTO.getStrCodError(), cargaAbonoLimiteConsumoOutDTO.getStrDesError());

        request.getSession().setAttribute("cargaAbonoLimiteConsumoOutDTO", cargaAbonoLimiteConsumoOutDTO);

        return mapping.findForward("success");

    }

}
