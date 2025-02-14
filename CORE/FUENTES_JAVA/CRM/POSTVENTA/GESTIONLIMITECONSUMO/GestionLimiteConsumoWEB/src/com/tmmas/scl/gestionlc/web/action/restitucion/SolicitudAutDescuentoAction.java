package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.gestionlc.common.dto.TablaCargosDTO;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.SolicitudAutDescuentoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class SolicitudAutDescuentoAction extends AbstractAction {

    private final String sSIGUIENTE = "control";
    private final String sANTERIOR = "control";

    private GestionLimiteConsumoLocator locator;

    protected ActionForward doPerform(ActionMapping pMapping, ActionForm pForm, HttpServletRequest pRequest, HttpServletResponse pHttpResponse)

        throws Exception {
        loggerDebug("execute():start");

        locator = new GestionLimiteConsumoLocator();
//        gestLimCon = locator.getGestLimConFacade();

        // ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
        HttpSession session = pRequest.getSession(false);
        // sessionData =
        // (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
        ClienteDTO datosCliente = (ClienteDTO) session.getAttribute("datosCliente");
        long lonCodcliente = datosCliente.getCodCliente(); // sessionData.getCliente().getCodCliente()
        CargosForm cargosForm = (CargosForm) session.getAttribute("CargosForm");

        SolicitudAutDescuentoForm solicitudAutDescuentoForm = (SolicitudAutDescuentoForm) pForm;

        if (!solicitudAutDescuentoForm.isFlgIniciado()) {
            solicitudAutDescuentoForm.setFlgIniciado(true);
            String estadoSolicitudPendiente = getValorInterno("estado.solicitud.pendiente");
            String estadoSolicitudAutorizada = getValorInterno("estado.solicitud.autorizada");
            String estadoSolicitudCancelada = getValorInterno("estado.solicitud.cancelada");
            solicitudAutDescuentoForm.setEstadoSolicitudPendiente(estadoSolicitudPendiente);
            solicitudAutDescuentoForm.setEstadoSolicitudAutorizada(estadoSolicitudAutorizada);
            solicitudAutDescuentoForm.setEstadoSolicitudCancelada(estadoSolicitudCancelada);
            solicitudAutDescuentoForm.setNumAutorizacion("");
            solicitudAutDescuentoForm.setEstadoSolicitud("");
            solicitudAutDescuentoForm.setEstadoSolicitudGlosa("");
        }

        if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Solicitar")) {
            solicitudAutDescuentoForm.setAccion(" ");
            RegistroSolicitudListDTO registro = new RegistroSolicitudListDTO();
            RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
            registro = (RegistroSolicitudListDTO) session.getAttribute("RegistroSolicitudListDTO");

            UsuarioDTO usuario = new UsuarioDTO();
            String userName = (String) session.getAttribute("UserName");
            usuario.setNombre(userName);
            loggerDebug("obtenerVendedor():antes");
            usuario = locator.obtenerVendedor(usuario);

            TablaCargosDTO[] tablaCargosDTO = null;
            tablaCargosDTO = cargosForm.getTablaCargos();
            RegistroSolicitudListDTO listaSol = new RegistroSolicitudListDTO();
            RegistroSolicitudDTO[] lista = new RegistroSolicitudDTO[tablaCargosDTO.length];

            for (int i = 0; i < tablaCargosDTO.length; i++) {
                lista[i] = new RegistroSolicitudDTO();
                lista[i].setNumeroVenta(cargosForm.getNumVenta());
                lista[i].setCodigoOficina(usuario.getCodOficina());
                lista[i].setCodigoVendedor(usuario.getCodigo());
                lista[i].setNumeroUnidades(Long.valueOf(tablaCargosDTO[i].getCantidad()).longValue());
                lista[i].setPrecioOrigen(Float.parseFloat(tablaCargosDTO[i].getImporteTotalOriginal()));
                lista[i].setIndicadorTipoVenta(1);
                lista[i].setCodigoCliente(lonCodcliente);
                lista[i].setCodigoModalidadVenta(Integer.parseInt(cargosForm.getCbModPago()));
                lista[i].setNombreUsuarioVenta(usuario.getNombre());
                lista[i].setCodigoConcepto(Integer.parseInt(tablaCargosDTO[i].getCodConcepto()));
                lista[i].setImporteCargo(Float.parseFloat(tablaCargosDTO[i].getImporteTotalOriginal()));

                lista[i].setNumeroSerie("");
                if (tablaCargosDTO[i].getCodConceptoDescuento() != null
                        && ((tablaCargosDTO[i].getDescuentoUnitarioMan() != null && !"".equalsIgnoreCase(tablaCargosDTO[i].getDescuentoUnitarioMan())) || (tablaCargosDTO[i]
                                .getDescuentoUnitarioAut() != null && !tablaCargosDTO[i].getDescuentoUnitarioAut().equalsIgnoreCase("")))) {
                    lista[i].setCodigoConceptoDescuento(Integer.parseInt(tablaCargosDTO[i].getCodConceptoDescuento()));
                } else {
                    lista[i].setCodigoConceptoDescuento(0);
                }
                lista[i].setValorDescuento((Float.parseFloat(tablaCargosDTO[i].getSaldo()) - Float.parseFloat(tablaCargosDTO[i].getImporteTotal())) * -1);
                lista[i].setTipoDescuento(1);
            }

            listaSol.setSolicitudes(lista);
            registro = listaSol;
            if (registro != null) {
                respuesta = locator.solicitarAprobacionDescuento(registro);
                long numAutorizacion = respuesta.getNumeroAutorizacion();
                loggerDebug("numAutorizacion:" + numAutorizacion);
                solicitudAutDescuentoForm.setNumAutorizacion(String.valueOf(numAutorizacion));
                solicitudAutDescuentoForm.setEstadoSolicitud(solicitudAutDescuentoForm.getEstadoSolicitudPendiente());
                solicitudAutDescuentoForm.setEstadoSolicitudGlosa(getValorInterno("desc.estado.solicitud.PD"));
            }
        }

        if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("ConsultarEstado")) {
            solicitudAutDescuentoForm.setAccion(" ");
            RegistroSolicitudDTO registro = new RegistroSolicitudDTO();
            registro.setNumeroAutorizacion(Long.parseLong(solicitudAutDescuentoForm.getNumAutorizacion()));
            registro = locator.consultarEstadoSolicitud(registro);

            String glosaEstado = " ";
            if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudPendiente())) {
                glosaEstado = getValorInterno("desc.estado.solicitud.PD");
            } else if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudAutorizada())) {
                glosaEstado = getValorInterno("desc.estado.solicitud.AU");
            } else if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudCancelada())) {
                glosaEstado = getValorInterno("desc.estado.solicitud.CA");
            }
            solicitudAutDescuentoForm.setEstadoSolicitud(registro.getCodigoEstado());
            solicitudAutDescuentoForm.setEstadoSolicitudGlosa(glosaEstado);
        }

        session.setAttribute("ultimaPagina", "SolicDescuento");

        if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Siguiente")) {
            solicitudAutDescuentoForm.setAccion("");
            session.setAttribute("accionAutDesc", "Siguiente");
            return pMapping.findForward(sSIGUIENTE);
        }

        if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Anterior")) {
            solicitudAutDescuentoForm.setAccion("");
            if (cargosForm.getNumVenta() != 0 && solicitudAutDescuentoForm.getNumAutorizacion() != null
                    && !solicitudAutDescuentoForm.getNumAutorizacion().equalsIgnoreCase("")) {
                RegistroSolicitudDTO registro = new RegistroSolicitudDTO();
                registro.setNumeroVenta(cargosForm.getNumVenta());
                registro.setNumeroAutorizacion(Long.valueOf(solicitudAutDescuentoForm.getNumAutorizacion()).longValue());           
                locator.eliminarSolicitud(registro);
            }

            session.setAttribute("accionAutDesc", "Atras");
            return pMapping.findForward(sANTERIOR);
        }

        loggerDebug("execute():fin");

        return pMapping.findForward("solicitudAut");

    }

}
