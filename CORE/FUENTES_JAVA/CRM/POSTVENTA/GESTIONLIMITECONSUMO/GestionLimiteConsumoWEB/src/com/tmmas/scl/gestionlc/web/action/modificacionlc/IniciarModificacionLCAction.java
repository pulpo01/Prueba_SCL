package com.tmmas.scl.gestionlc.web.action.modificacionlc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class IniciarModificacionLCAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private ModificacionLimiteConsumo beanLocal;

    // private final LoggerHelper logger = LoggerHelper.getInstance();

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {

        loggerDebug("Inicio IniciarModificacionLCAction:");

        CargaModificacionLimiteConsumoInDTO cargaModificacionLimiteConsumoInDTO = new CargaModificacionLimiteConsumoInDTO();
        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getModificacionLimiteConsumoFacade();

        HttpSession session = request.getSession(true);
        ServiceContextDTO context = (ServiceContextDTO) session.getAttribute("login");

        // se obtiene el numero de abonado desde la ULR
        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        cargaModificacionLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));
        loggerDebug("El numero de abonado es: " + strNumAbonado);

        // se obtienen los datos de carga
        CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO = beanLocal
                .cargarModificacionLimiteConsumo(cargaModificacionLimiteConsumoInDTO);

        // validacion del resultado obtenido
        validaResult(cargaModificacionLimiteConsumoOutDTO.getIEvento(), cargaModificacionLimiteConsumoOutDTO.getStrCodError(),
                cargaModificacionLimiteConsumoOutDTO.getStrDesError());

        // se sube a session el objeto con los datos de carga
        session.setAttribute("CargaModificacionLimiteConsumoOutDTO", cargaModificacionLimiteConsumoOutDTO);

        loggerDebug("Fin IniciarModificacionLCAction:");

        return mapping.findForward("success");

    }

}
