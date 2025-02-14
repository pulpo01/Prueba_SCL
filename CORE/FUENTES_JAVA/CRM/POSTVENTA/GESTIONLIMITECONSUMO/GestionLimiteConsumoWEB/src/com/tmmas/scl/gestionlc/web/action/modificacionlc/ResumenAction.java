package com.tmmas.scl.gestionlc.web.action.modificacionlc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.modificacionlc.ResumenForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class ResumenAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private ModificacionLimiteConsumo beanLocal;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {

        loggerDebug("Inicio ResumenAction:");

        ResumenForm resumenForm = (ResumenForm) form;

        EjecutaModificacionLimiteConsumoInDTO ejecutaModificacionLimiteConsumoInDTO = new EjecutaModificacionLimiteConsumoInDTO();
        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getModificacionLimiteConsumoFacade();

        HttpSession session = request.getSession(true);
        String usuario = (String) session.getAttribute("UserName");
        loggerDebug("UserName: " + usuario);
        String monto = (String) session.getAttribute("DetalleMonto");
        loggerDebug("DetalleMonto: " + monto);
        String continuar = (String) session.getAttribute("RespContinuar");
        loggerDebug("RespContinuar: " + continuar);
        String observacion = resumenForm.getStrComentario();
        loggerDebug("Observacion: " + observacion);
        // Long monto = (Long) session.getAttribute("DetalleMonto");
        // Boolean continuar = (Boolean) session.getAttribute("RespContinuar");

        CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO = (CargaModificacionLimiteConsumoOutDTO) session
                .getAttribute("CargaModificacionLimiteConsumoOutDTO");
        AbonadoDTO abonadoDTO = new AbonadoDTO();
        abonadoDTO = cargaModificacionLimiteConsumoOutDTO.getAbonado();

        loggerDebug("-----------Parametros de entrada para la ejecucion-------------------");

        ejecutaModificacionLimiteConsumoInDTO.setLonCodCliente(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonCodCliente());
        loggerDebug("Codigo Cliente: " + ejecutaModificacionLimiteConsumoInDTO.getLonCodCliente());
        ejecutaModificacionLimiteConsumoInDTO.setLonNumAbonado(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());
        loggerDebug("Numero Abonado: " + ejecutaModificacionLimiteConsumoInDTO.getLonNumAbonado());
        ejecutaModificacionLimiteConsumoInDTO.setDouDetalleMonto(new Double(monto));
        loggerDebug("Detalle Monto: " + ejecutaModificacionLimiteConsumoInDTO.getDouDetalleMonto());
        ejecutaModificacionLimiteConsumoInDTO.setStrRespContinuar(continuar);
        loggerDebug("Respuesta Continuar: " + ejecutaModificacionLimiteConsumoInDTO.getStrRespContinuar());
        ejecutaModificacionLimiteConsumoInDTO.setStrCodPlanTarif(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrCodPlanTarif());
        loggerDebug("Codigo Tipo Plan Tarifario: " + ejecutaModificacionLimiteConsumoInDTO.getStrCodPlanTarif());
        ejecutaModificacionLimiteConsumoInDTO.setStrCodLimConsumo(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrCodLimCons());
        loggerDebug("Codigo Limite Consumo: " + ejecutaModificacionLimiteConsumoInDTO.getStrCodLimConsumo());
        ejecutaModificacionLimiteConsumoInDTO.setStrUsuarioBd(usuario);
        loggerDebug("Usuario Base de Datos: " + ejecutaModificacionLimiteConsumoInDTO.getStrUsuarioBd());
        ejecutaModificacionLimiteConsumoInDTO.setStrComentario(observacion);
        loggerDebug("Comentario: " + ejecutaModificacionLimiteConsumoInDTO.getStrComentario());

        ejecutaModificacionLimiteConsumoInDTO.setLonCodInter(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());
        loggerDebug("CodInter: " + ejecutaModificacionLimiteConsumoInDTO.getLonCodInter());

        loggerDebug("-----------Parametros de entrada para la ejecucion-------------------");

        EjecutaModificacionLimiteConsumoOutDTO result = beanLocal.ejecutaModificacionLimiteConsumo(ejecutaModificacionLimiteConsumoInDTO);

        request.setAttribute("numOOSS", result.getStrNumOOSS());

        validaResult(result.getIEvento(), result.getStrCodError(), result.getStrDesError());

        // locator = new GestionLimiteConsumoLocator();
        // beanLocal = locator.getFooFacade();
        //
        // String p_in = "Prueba";
        //
        // FooOutDTO result = beanLocal.foo(p_in);
        //
        // result.getIEvento();
        // result.getStrCodError();
        // result.getStrDesError();
        //
        // validaResult(result.getIEvento(), result.getStrCodError(),
        // result.getStrDesError());
        //
        // p_request.setAttribute("numOOSS", result);

        loggerDebug("Fin ResumenAction:");
        return mapping.findForward("success");
    }

}
