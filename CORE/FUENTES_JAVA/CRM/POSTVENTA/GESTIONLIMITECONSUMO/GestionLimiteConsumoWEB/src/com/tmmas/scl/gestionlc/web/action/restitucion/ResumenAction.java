package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.ResumenForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class ResumenAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        locator = new GestionLimiteConsumoLocator();
        loggerDebug("Inicio ResumenAction:");

        ResumenForm resumenForm = (ResumenForm) form;

        HttpSession session = request.getSession(true);
        Long lonNumSiniestro = (Long) request.getSession().getAttribute("NumSiniestro");
        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        String strCodTipContrato = (String) request.getSession().getAttribute("StrCodTipContrato");
        String strCodModPago = (String) request.getSession().getAttribute("StrCodModPago");
        String strNumSerie = (String) request.getSession().getAttribute("StrNumSerie");
        String strUserName = (String) request.getSession().getAttribute("UserName");
        Long lonNumTransacReserva = (Long) request.getSession().getAttribute("LonNumTransacReserva");
        Short shoCodUso = (Short) request.getSession().getAttribute("ShoCodUso");
        String strCodNumContrato = (String) request.getSession().getAttribute("StrCodNumContrato");
        String strFolioContrato = (String) request.getSession().getAttribute("StrFolioContrato");
        CargosForm cargosForm = (CargosForm) session.getAttribute("CargosForm");
        ClienteDTO datosCliente = (ClienteDTO) session.getAttribute("datosCliente");

        // se registran los cargos si es que no fueron guardar en el presupuesto
        RegCargosDTO retValConst = new RegCargosDTO();

        boolean seRegistroCargosInmediatos = false;
        if (session.getAttribute("seRegistroCargosInmediatos") != null && "SI".equals(session.getAttribute("seRegistroCargosInmediatos"))) {
            seRegistroCargosInmediatos = true;
        }

        loggerDebug("seRegistroCargosInmediatos[" + seRegistroCargosInmediatos + "]");

        CabeceraArchivoDTO objetoSesion = new CabeceraArchivoDTO();

        // Sino se han registrado los cargos a través del presupuesto, se
        // registran ahora
        if (!seRegistroCargosInmediatos) {
            ObtencionCargosDTO obtencionCargos = cargosForm.getCargosSeleccionados();

            // original
            loggerDebug("construirRegistroCargos:antes");
            retValConst = locator.construirRegistroCargos(obtencionCargos);
            if (retValConst != null && retValConst.getCargos() != null && retValConst.getCargos().length > 0) {
                loggerDebug("Aciclo construirRegistroCargos, numero de cargos construidos[" + retValConst.getCargos().length + "]");
            } else {
                loggerDebug("Aciclo construirRegistroCargos, no hay cargos construidos");
            }
            loggerDebug("construirRegistroCargos:despues");
        }

        if (!seRegistroCargosInmediatos) {

            int codPlanCom;
            // sessionData.getCliente().getCodPlanCom(); //Plan Comercial
            // Cliente
            ClienteDTO clienteTMP = new ClienteDTO();
            clienteTMP.setCodCliente(datosCliente.getCodCliente());
            clienteTMP = locator.obtenerPlanComercial(clienteTMP);
            codPlanCom = clienteTMP.getCodPlanCom();

            objetoSesion.setPlanComercialCliente("" + clienteTMP.getCodPlanCom());
            loggerDebug("objetoSesion.getPlanComercialCliente: " + objetoSesion.getPlanComercialCliente());

            objetoSesion.setCodigoCliente(String.valueOf(datosCliente.getCodCliente()));
            loggerDebug("objetoSesion.getCodigoCliente: " + objetoSesion.getCodigoCliente());

            objetoSesion.setFacturaCiclo(true);
            if (cargosForm != null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")) {
                objetoSesion.setFacturaCiclo(false);
            }
            loggerDebug("objetoSesion.getFacturaCiclo: " + objetoSesion.isFacturaCiclo());

            objetoSesion.setNumeroVenta(0);
            loggerDebug("objetoSesion.getNumeroVenta: " + objetoSesion.getNumeroVenta());

            objetoSesion.setNumeroTransaccionVenta(0);
            loggerDebug("objetoSesion.getNumeroTransaccionVenta: " + objetoSesion.getNumeroTransaccionVenta());

            objetoSesion.setCodigoDocumento(cargosForm.getCbTipoDocumento());
            loggerDebug("objetoSesion.getCodigoDocumento: " + objetoSesion.getCodigoDocumento());

            objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());
            loggerDebug("objetoSesion.getCodModalidadVenta: " + objetoSesion.getCodModalidadVenta());

            // TODO : Obtener vendedor
            UsuarioDTO usuario = new UsuarioDTO();
            usuario.setNombre(strUserName);
            usuario = locator.obtenerVendedor(usuario);
            objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
            objetoSesion.setNombreUsuario(strUserName);

            retValConst.setObjetoSesion(objetoSesion);

            if (retValConst != null && retValConst.getCargos() != null && retValConst.getCargos().length > 0) {
                /*
                 * loggerDebug("Saldo total: "+retValConst.getCargos()[0].getSaldoTotal
                 * ());
                 * loggerDebug("Saldo unitario: "+retValConst.getCargos()[0]
                 * .getSaldoUnitario()); if(retValConst.getCargos().length==1) {
                 * loggerDebug
                 * ("Saldo total: "+retValConst.getCargos()[0].getSaldoTotal());
                 * loggerDebug
                 * ("Saldo unitario: "+retValConst.getCargos()[0].getSaldoUnitario
                 * ()); if (retValConst.getCargos()[0].getSaldoUnitario()>0 &&
                 * retValConst.getCargos()[0].getSaldoTotal()>0) {
                 * loggerDebug("Aciclo parametrosRegistrarCargos:antes");
                 * ResultadoRegCargosDTO resultado =
                 * gestLimCon.parametrosRegistrarCargos(retValConst);
                 * loggerDebug("Aciclo parametrosRegistrarCargos:despues"); } }
                 * else if(retValConst.getCargos().length>1) {
                 * loggerDebug("Aciclo parametrosRegistrarCargos:antes");
                 * ResultadoRegCargosDTO resultado =
                 * gestLimCon.parametrosRegistrarCargos(retValConst);
                 * loggerDebug("Aciclo parametrosRegistrarCargos:despues"); }
                 */
                ResultadoRegCargosDTO resultado = locator.parametrosRegistrarCargos(retValConst);
            }
        }
        // Fin registrar cargos

        EjecutaCierreRestitucionInDTO inDTO = new EjecutaCierreRestitucionInDTO();
        loggerDebug("strNumAbonado [" + strNumAbonado + "]");
        loggerDebug("lonNumSiniestro [" + lonNumSiniestro + "]");
        loggerDebug("lonNumTransacReserva [" + lonNumTransacReserva + "]");
        loggerDebug("strCodModPago [" + strCodModPago + "]");
        loggerDebug("strCodTipContrato [" + strCodTipContrato + "]");
        loggerDebug("strUserName [" + strUserName + "]");
        loggerDebug("strNumSerie [" + strNumSerie + "]");
        loggerDebug("shoCodUso [" + shoCodUso + "]");
        loggerDebug("resumenForm.getStrComentario() [" + resumenForm.getStrComentario() + "]");
        loggerDebug("strCodNumContrato [" + strCodNumContrato + "]");
        loggerDebug("strFolioContrato [" + strFolioContrato + "]");
        loggerDebug("cargosForm.getNumVenta() [" + cargosForm.getNumVenta() + "]");

        inDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));
        inDTO.setLonNumSiniestro(lonNumSiniestro);
        inDTO.setLonNumTransacReserva(lonNumTransacReserva);
        inDTO.setStrCodModVenta(strCodModPago);
        inDTO.setStrCodTipContrato(strCodTipContrato);
        inDTO.setStrNomUsuario(strUserName);
        inDTO.setStrNumSerie(strNumSerie);
        inDTO.setShoCodUso(shoCodUso);
        inDTO.setStrComentario(resumenForm.getStrComentario());
        inDTO.setStrNumContrato(strCodNumContrato);
        inDTO.setStrFolioContrato(strFolioContrato);
        inDTO.setLonNumVenta(cargosForm.getNumVenta());

        EjecutaCierreRestitucionOutDTO outDTO = new EjecutaCierreRestitucionOutDTO();
        outDTO = locator.ejecutarCierreRestitucion(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        request.setAttribute("numOOSS", outDTO.getLonNumOOSS().toString());

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());

        loggerDebug("Fin ResumenAction:");
        return mapping.findForward("success");
    }

}
