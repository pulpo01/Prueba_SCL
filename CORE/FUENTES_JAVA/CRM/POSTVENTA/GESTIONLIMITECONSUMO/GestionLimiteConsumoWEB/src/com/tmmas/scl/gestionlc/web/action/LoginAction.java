package com.tmmas.scl.gestionlc.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;

public class LoginAction extends AbstractAction {

    private final LoggerHelper logger = LoggerHelper.getInstance();

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        // LoginForm form = (LoginForm)p_form;
        // logger.debug(form.getJ_username(),"LoginAction");
        // logger.debug(form.getJ_password(),"LoginAction");
        String userName = request.getParameter("userName");

        String numeroAbonado = request.getParameter("numeroAbonado");

        String codOrdenServicio = request.getParameter("codOrdenServicio");

        loggerDebug("userName: " + userName);
        loggerDebug("numeroAbonado: " + numeroAbonado);
        loggerDebug("codOrdenServicio: " + codOrdenServicio);

        loggerDebug("Entra a validaURL");
        validaURL(userName, numeroAbonado, codOrdenServicio);
        loggerDebug("Sale de validaURL");

        ServiceContextDTO context = new ServiceContextDTO();
        context.setUsername(userName);

        request.getSession().setAttribute("login", null);

        HttpSession session = request.getSession(true);

        logger.debug("SETEANDO EL SERVICE_CONTEXT", "LoginAction");
        session.setAttribute("login", context);

        logger.debug("MOSTRANDO APLICACION", "LoginAction");

        session.setAttribute("operadora", "COSTA RICA");

        session.setAttribute("NumAbonado", numeroAbonado);
        session.setAttribute("UserName", userName);
        session.setAttribute("CodOrdenServicio", codOrdenServicio);

        String strForward = getForward(codOrdenServicio, session);

        logger.debug("FORWARD: " + strForward, "LoginAction");

        return mapping.findForward(strForward);

    }

    protected boolean noSessionForward(HttpServletRequest request) {
        return false;
    }

    private String getForward(String codOrdenServicio, HttpSession session) {

        String result = "OOSS-" + codOrdenServicio;

        if ("10668".equals(codOrdenServicio)) {

            session.setAttribute("titulo", "Abono al Límite de Consumo");

        } else if ("10666".equals(codOrdenServicio)) {

            session.setAttribute("titulo", "Modificación de Límite de Consumo");

        } else if ("10070".equals(codOrdenServicio)) {

            session.setAttribute("titulo", "Seguimiento de Siniestro");

        }

        return result;

    }

    private void validaURL(String nombreUsuario, String numeroAbonado, String odenServicio) throws GestionLimiteConsumoException {

        if ("".equals(nombreUsuario.trim()) || null == nombreUsuario) {
            loggerDebug("nombreUsuario es vacio");
            throw new GestionLimiteConsumoException("ERR.0026", 0);

        } else if ("".equals(numeroAbonado.trim()) || null == numeroAbonado) {
            loggerDebug("numeroAbonado es vacio");
            throw new GestionLimiteConsumoException("ERR.0027", 0);

        } else if ("".equals(odenServicio.trim()) || null == odenServicio) {
            loggerDebug("odenServicio es vacio");
            throw new GestionLimiteConsumoException("ERR.0028", 0);
        }

    }

}
