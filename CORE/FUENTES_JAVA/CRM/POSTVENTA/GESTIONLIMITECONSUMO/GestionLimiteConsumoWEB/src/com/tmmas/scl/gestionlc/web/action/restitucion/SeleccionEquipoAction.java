package com.tmmas.scl.gestionlc.web.action.restitucion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.SeleccionEquipoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class SeleccionEquipoAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;
    private RestitucionEquipo beanLocal;

    protected ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception {
        loggerDebug("inicio(Action): SeleccionEquipoAction");

        locator = new GestionLimiteConsumoLocator();
        beanLocal = locator.getRestitucionEquipoFacade();

        HttpSession session = request.getSession();

        // se sube a session el valor maximo para el comentario
        String maxComentario = getValorInterno("parametro.numero.caracteres.comentario");
        loggerDebug("El valor maximo para el comentario es: " + maxComentario);
        session.setAttribute("MaxComentario", maxComentario);

        Long lonNumSiniestro = (Long) request.getSession().getAttribute("NumSiniestro");
        String strNumAbonado = (String) request.getSession().getAttribute("NumAbonado");
        String strCodTipContrato = (String) request.getSession().getAttribute("StrCodTipContrato");
        String strCodModPago = (String) request.getSession().getAttribute("StrCodModPago");
        String strCodCatTributaria = (String) request.getSession().getAttribute("StrCodCatTributaria");
        String strUserName = (String) request.getSession().getAttribute("UserName");

        loggerDebug("COD_MOD_PAGO: " + strCodModPago);

        SeleccionEquipoForm seleccionEquipoForm = (SeleccionEquipoForm) form;

        EjecutaRestitucionEquipoInDTO inDTO = new EjecutaRestitucionEquipoInDTO();
        inDTO.setIntCodArticulo(seleccionEquipoForm.getIntCodArticulo());
        inDTO.setIntCodBodega(seleccionEquipoForm.getIntCodBodega());
        inDTO.setShoCodEstado(Short.valueOf(seleccionEquipoForm.getIntCodEstado().shortValue()));
        inDTO.setShoCodUso(Short.valueOf(seleccionEquipoForm.getIntCodUso().shortValue()));
        inDTO.setLonNumAbonado(Long.valueOf(strNumAbonado));
        inDTO.setLonNumSiniestro(lonNumSiniestro);
        inDTO.setStrCodCatTribut(strCodCatTributaria);
        inDTO.setStrCodModVenta(strCodModPago);
        inDTO.setStrCodTipContrato(strCodTipContrato);
        inDTO.setStrNomUsuario(strUserName);
        inDTO.setStrNumSerie(seleccionEquipoForm.getStrNumSerie());

        EjecutaRestitucionEquipoOutDTO outDTO = new EjecutaRestitucionEquipoOutDTO();
        outDTO = beanLocal.ejecutarRestitucionEquipo(inDTO);

        validaResult(outDTO.getIEvento(), outDTO.getStrCodError(), outDTO.getStrDesError());
        request.getSession().setAttribute("StrIndComodato", outDTO.getStrIndComodato());
        request.getSession().setAttribute("StrTipStock", outDTO.getStrTipStock());
        request.getSession().setAttribute("IntTipPantalla", outDTO.getIntTipPantalla());
        request.getSession().setAttribute("LonNumTransacReserva", outDTO.getLonNumTransacReserva());
        loggerDebug("NUMERO_TRANSACCION_RESERVA: " + outDTO.getLonNumTransacReserva());
        request.getSession().setAttribute("StrNumSerie", seleccionEquipoForm.getStrNumSerie());
        request.getSession().setAttribute("ShoCodUso", inDTO.getShoCodUso());

        // obtener el ind_valorar de la serie para determinar si se cobra cargo
        // al terminal
        String strIndValorar = obtenerIndValorar(request, seleccionEquipoForm.getStrNumSerie());

        // obtener el tip_stock de la serie para determinar si se cobra cargo a
        // la serie
        String strTipStock = obtenerTipStock(request, seleccionEquipoForm.getStrNumSerie());

        request.getSession().setAttribute("strIndValorar", strIndValorar);

        request.getSession().setAttribute("strTipStock", strTipStock);

        loggerDebug("fin(Action): SeleccionEquipoAction");
        return mapping.findForward("success");

    }

    /**
     * permite obtener el TipStock de la serie
     * 
     * @param pRequest
     * @param strNumSerie
     * @return
     */
    private String obtenerTipStock(HttpServletRequest pRequest, String pStrNumSerie) {

        String result = null;

        if (pRequest.getSession().getAttribute("series") == null) {
            return null;
        }

        SerieDTO[] serieDTO = (SerieDTO[]) pRequest.getSession().getAttribute("series");

        for (int i = 0; i < serieDTO.length; i++) {

            SerieDTO serie = serieDTO[i];

            if (pStrNumSerie.equals(serie.getStrNumSerie())) {

                result = serie.getStrTipStock();

                break;
            }
        }

        return result;
    }

    /**
     * permite obtener el ind_valorar de una serie
     * 
     * @param pRequest
     * @param strNumSerie
     * @return
     */
    private String obtenerIndValorar(HttpServletRequest pRequest, String pStrNumSerie) {

        String result = null;

        if (pRequest.getSession().getAttribute("series") == null) {
            return null;
        }

        SerieDTO[] serieDTO = (SerieDTO[]) pRequest.getSession().getAttribute("series");

        for (int i = 0; i < serieDTO.length; i++) {

            SerieDTO serie = serieDTO[i];

            if (pStrNumSerie.equals(serie.getStrNumSerie())) {

                result = serie.getStrIndValorar();

                break;
            }
        }

        return result;
    }

}
