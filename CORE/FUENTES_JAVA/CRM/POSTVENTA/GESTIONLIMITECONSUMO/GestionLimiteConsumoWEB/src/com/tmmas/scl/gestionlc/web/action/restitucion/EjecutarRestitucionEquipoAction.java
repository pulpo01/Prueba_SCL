package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.SeguimientoSiniestroForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class EjecutarRestitucionEquipoAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        loggerDebug("inicio(Action): EjecutarRestitucionEquipoAction");

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();
        HttpSession session = request.getSession(true);

        SeguimientoSiniestroForm seguimientoSiniestroForm = (SeguimientoSiniestroForm) form;
        ServiceContextDTO context = (ServiceContextDTO) session.getAttribute("login");
        Integer intCantidad = (Integer) request.getSession().getAttribute("intCantSiniestros");
        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        CargaRestitucionEquipoInDTO inDTO = new CargaRestitucionEquipoInDTO();

        inDTO.setLonNumConstancia(seguimientoSiniestroForm.getLonConstPolicial());
        inDTO.setLonNumSiniestro(seguimientoSiniestroForm.getLonIdSiniestro());
        inDTO.setStrFecRestitucion(seguimientoSiniestroForm.getStrFecRestitucion());
        inDTO.setStrObservaciones(seguimientoSiniestroForm.getStrObservacion());
        inDTO.setShoCantSiniestros(Short.valueOf(intCantidad.toString()));
        inDTO.setStrNomUsuario(context.getUsername());
        inDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));

        loggerInfo("Numero de Constancia [" + inDTO.getLonNumConstancia() + "]");
        loggerInfo("Numero de Siniestro  [" + inDTO.getLonNumSiniestro() + "]");
        loggerInfo("Fecha de Restitucion [" + inDTO.getStrFecRestitucion() + "]");
        loggerInfo("Observaciones [" + inDTO.getStrObservaciones() + "]");
        loggerInfo("Cantidad Siniestros [" + inDTO.getShoCantSiniestros() + "]");
        loggerInfo("Nombre de Usuario [" + inDTO.getStrNomUsuario() + "]");

        CargaRestitucionEquipoOutDTO outDTO = new CargaRestitucionEquipoOutDTO();
        // outDTO = beanLocal.ejecutarRestitucionEquipo(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        request.getSession().setAttribute("EjecucionRestitucionEquipoOutDTO", outDTO);

        loggerDebug("fin(Action):");
        return mapping.findForward("success");

    }

}
