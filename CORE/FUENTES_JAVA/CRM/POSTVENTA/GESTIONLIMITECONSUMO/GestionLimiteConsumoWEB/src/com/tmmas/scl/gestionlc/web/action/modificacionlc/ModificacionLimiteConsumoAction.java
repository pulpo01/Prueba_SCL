package com.tmmas.scl.gestionlc.web.action.modificacionlc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.modificacionlc.ModificacionLimiteConsumoForm;

public class ModificacionLimiteConsumoAction extends AbstractAction {

    private final LoggerHelper logger = LoggerHelper.getInstance();

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {

        HttpSession session = request.getSession(true);

        ModificacionLimiteConsumoForm modificacionLimiteConsumoForm = (ModificacionLimiteConsumoForm) form;

        // se sube a session el monto ingresado
        String monto = modificacionLimiteConsumoForm.getStrLimiteConsumo();
        loggerDebug("El detalle de monto es: " + monto);
        session.setAttribute("DetalleMonto", monto);

        // se sube a session respuesta continuar
        String continuar = modificacionLimiteConsumoForm.getStrRespContinuar();
        loggerDebug("La respuesta de continuar es: " + continuar);
        session.setAttribute("RespContinuar", continuar);

        // se sube a session el valor maximo para el comentario
        String maxComentario = getValorInterno("parametro.numero.caracteres.comentario");
        loggerDebug("El valor maximo para el comentario es: " + maxComentario);
        session.setAttribute("MaxComentario", maxComentario);

        return mapping.findForward("success");

    }

}
