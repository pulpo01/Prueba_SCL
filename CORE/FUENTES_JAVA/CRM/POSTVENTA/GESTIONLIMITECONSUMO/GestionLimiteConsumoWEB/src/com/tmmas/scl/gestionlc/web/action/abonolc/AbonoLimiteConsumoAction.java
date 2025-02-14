package com.tmmas.scl.gestionlc.web.action.abonolc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.abonolc.AbonoLimiteConsumoForm;

public class AbonoLimiteConsumoAction extends AbstractAction {

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        AbonoLimiteConsumoForm abonoLimiteConsumoForm = (AbonoLimiteConsumoForm) form;

        loggerDebug("Abono: " + abonoLimiteConsumoForm.getAbono());

        // armar DTO para la ejecucion
        CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO = (CargaAbonoLimiteConsumoOutDTO) request.getSession().getAttribute(
                "cargaAbonoLimiteConsumoOutDTO");

        ServiceContextDTO login = (ServiceContextDTO) request.getSession().getAttribute("login");

        EjecucionAbonoLimiteConsumoInDTO ejecucionDTO = new EjecucionAbonoLimiteConsumoInDTO();

        ejecucionDTO.setLonCodCliente(cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonCodCliente());
        ejecucionDTO.setLonNumAbonado(cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());
        ejecucionDTO.setDouAbono(new Double(abonoLimiteConsumoForm.getAbono()));
        ejecucionDTO.setStrUsuario(login.getUsername());
        ejecucionDTO.setLonCodInter(cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());

        request.getSession().setAttribute("ejecucionAbonoLimiteConsumoOutDTO", ejecucionDTO);

        // se sube a session el valor maximo para el comentario
        String maxComentario = getValorInterno("parametro.numero.caracteres.comentario");
        loggerDebug("El valor maximo para el comentario es: " + maxComentario);
        request.getSession().setAttribute("MaxComentario", maxComentario);

        return mapping.findForward("success");
    }

}
