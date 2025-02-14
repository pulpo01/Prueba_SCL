package com.tmmas.scl.gestionlc.web.action.base;

import javax.ejb.EJBException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public abstract class AbstractAction extends Action {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();

    /**
     * Implementacion de perform de structs. Utiliza el patron Template y
     * llamando a los métodos: - noSessionForward - doPerform (abstracto) -
     * indirectForward Controla exceptions redireccionando al forward
     * "dataError".
     * 
     * @param p_mapping
     *            ActionMapping
     * @param p_form
     *            ActionForm
     * @param p_request
     *            HttpServletRequest
     * @param p_response
     *            HttpServletResponse
     * @return ActionForward
     * @throws Exception
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        ActionForward result = null;

        if (noSessionForward(request)) {
            logger.debug("SESSION EXPIRADA", "AbstractAction");
            return mapping.findForward("sessionExpirada");
        }

        try {

            result = doPerform(mapping, form, request, response);

        } catch (GestionLimiteConsumoException ccEx) {

            logger.error(ccEx, "AbstractAction");
            String strCodigoError = ccEx.getCodigo();
            String strDescripcionError = ccEx.getDescripcionEvento();
            int strNumeroEvento = ccEx.getCodigoEvento();

            request.setAttribute("strCodigoError", strCodigoError);
            request.setAttribute("strDescripcionError", strDescripcionError);
            request.setAttribute("strNumeroEvento", strNumeroEvento);

            result = mapping.findForward("globalError");

            reversas(request);
        } catch (Exception ex) {

            logger.error(ex, "AbstractAction");
            ex.printStackTrace();

            if (ex instanceof EJBException) {

                EJBException ejbEx = (EJBException) ex;

                Object obj = ejbEx.getCausedByException();

                if (obj instanceof GestionLimiteConsumoException) {

                    GestionLimiteConsumoException carpEx = (GestionLimiteConsumoException) ejbEx.getCausedByException();

                    String strCodigoError = carpEx.getCodigo();

                    String strDescripcionError = carpEx.getDescripcionEvento();

                    int strNumeroEvento = carpEx.getCodigoEvento();

                    request.setAttribute("strCodigoError", strCodigoError);
                    request.setAttribute("strDescripcionError", strDescripcionError);
                    request.setAttribute("strNumeroEvento", strNumeroEvento);

                    result = mapping.findForward("globalError");
                    // result = p_mapping.findForward("error");

                } else {

                    logger.debug("Exception en Abstract Action.  " + ex.getMessage(), "AbstractAction");

                    result = mapping.findForward("globalError");
                }

            } else {
                logger.debug("Exception en Abstract Action.  " + ex.getMessage(), "AbstractAction");

                result = mapping.findForward("globalError");
            }

            reversas(request);
        }

        return result;
    }

    /**
     * permite realizar reversas
     * 
     * @param pRequest
     */
    private void reversas(HttpServletRequest pRequest) {

        try {

            // como se produjo un error, se desreserva la serie si es que aplica
            // desreservar la serie
            loggerDebug("Desreservando la serie en el AbstracAction");
            Long lonNumTransacReserva = (Long) pRequest.getSession().getAttribute("LonNumTransacReserva");

            loggerDebug("NUMERO_TRANSACCION: " + lonNumTransacReserva);

            if (lonNumTransacReserva != null) {

                GestionLimiteConsumoLocator locator = new GestionLimiteConsumoLocator();
                RestitucionEquipo restitucionEquipo = locator.getRestitucionEquipoFacade();

                loggerDebug("DESRESERVANDO LA SERIE ");

                restitucionEquipo.rollbackReservaSerie(lonNumTransacReserva);

                loggerDebug("SERIE DESRESERVADA");

            }

        } catch (Exception ex) {
            loggerError("Error al Desreservar la serie en el AbstracAction");
            loggerError(ex);
        }

        try {

            // como se produjo un error, se desbloquea el vendedor
            loggerDebug("Desbloqueando el vendedor en el AbstracAction");
            UsuarioSistemaDTO usuarioSistemaDTO = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

            if (usuarioSistemaDTO != null && usuarioSistemaDTO.getCod_vendedor() > 0) {

                loggerDebug("CODIGO_VENDEDOR: " + usuarioSistemaDTO.getCod_vendedor());

                GestionLimiteConsumoLocator locator = new GestionLimiteConsumoLocator();
                RestitucionEquipo restitucionEquipo = locator.getRestitucionEquipoFacade();

                loggerDebug("DESBLOQUEANDO EL VENDEDOR ");

                UsuarioDTO usuarioDTO = new UsuarioDTO();

                usuarioDTO.setIntCodVendedor(Integer.valueOf((int) usuarioSistemaDTO.getCod_vendedor()));

                restitucionEquipo.desbloquearVendedor(usuarioDTO);

                loggerDebug("VENDEDOR DESBLOQUEADO");

            }

        } catch (Exception ex) {
            loggerError("Error al Desbloquear el vendedor en el AbstracAction");
            loggerError(ex);
        }

    }


    protected void validaResult(int codigoEvento, String strCodError, String descripcionEvento) throws GestionLimiteConsumoException {

        logger.debug("validaResult", "AbstractAction");

        if (!"0".equals(strCodError)) {

            logger.debug("Con errores", "AbstractAction");

            throw new GestionLimiteConsumoException(strCodError, codigoEvento, descripcionEvento);
        }

        logger.debug("Sin errores", "AbstractAction");
    }

    /**
     * valida si existe en session el DTO context que contiene los datos de
     * identificacion del usuario que se logueo
     * 
     * @param request
     * @return
     */
    protected boolean noSessionForward(HttpServletRequest request) {

        ServiceContextDTO context = (ServiceContextDTO) request.getSession().getAttribute("login");

        if (context == null) {

            logger.debug("EL CONTEXTO ES NULO", "AbstractAction");
            return true;

        } else {
            logger.debug("EL CONTEXTO NO ES NULO", "AbstractAction");
            return false;
        }

    }

    /**
     * Metodo a implementar en cada Action derivado
     * 
     * @param p_mapping
     *            ActionMapping
     * @param p_form
     *            ActionForm
     * @param p_request
     *            HttpServletRequest
     * @param p_httpResponse
     *            HttpServletResponse
     * @param p_closer
     *            EJBCloser closer para agregar elementos a cerrar.
     * @param p_context
     *            ServiceContextVO del usuario.
     * @return ActionForward
     * @throws Exception
     */
    protected abstract ActionForward doPerform(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse httpResponse)

        throws Exception; // IOException, ServletException,
    // ServiceLocatorException;

    public void loggerDebug(String mensaje) {
        logger.debug(mensaje, this.getClass().getName());
    }

    public void loggerInfo(String mensaje) {
        logger.info(mensaje, this.getClass().getName());
    }

    public void loggerError(String mensaje) {
        logger.error(mensaje, this.getClass().getName());
    }

    public void loggerError(Throwable e) {
        logger.error(e, this.getClass().getName());
    }

    public String getValorInterno(String propertie) {
        return global.getValor(propertie);
    }

    public String getValorExterno(String propertie) {
        return global.getValorExterno(propertie);
    }

}
