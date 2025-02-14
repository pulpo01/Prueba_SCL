package com.tmmas.scl.gestionlc.ws.modificacionlc;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumo;
import com.tmmas.scl.gestionlc.ws.helper.GestionLimiteConsumoLocator;

@WebService
public class ModificacionLimiteConsumoWS {

    private GlobalProperties global = GlobalProperties.getInstance();
    private GestionLimiteConsumoLocator locator;
    private ModificacionLimiteConsumo beanLocal;
    private final LoggerHelper logger = LoggerHelper.getInstance();

    @WebMethod
    public WSCargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumo(WSCargaModificacionLimiteConsumoInDTO pIn) {

        WSCargaModificacionLimiteConsumoOutDTO result = null;

        logger.debug("Inicio(WS): cargaModificacionLimiteConsumo", this.getClass().getName());

        try {

            locator = new GestionLimiteConsumoLocator();
            beanLocal = locator.getModificacionLimiteConsumoFacade();

            result = beanLocal.cargarModificacionLimiteConsumoWS(pIn);

        } catch (GestionLimiteConsumoException e) {

            result = new WSCargaModificacionLimiteConsumoOutDTO();
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());
            result.setIEvento(e.getCodigoEvento());

        } catch (Exception e) {

            logger.error(e.getMessage(), this.getClass().getName());
            e.printStackTrace();
            result = new WSCargaModificacionLimiteConsumoOutDTO();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));
            result.setIEvento(0);
        }

        logger.debug("Fin(WS): cargaModificacionLimiteConsumo", this.getClass().getName());

        return result;

    }

    @WebMethod
    public WSEjecutaModificacionLimiteConsumoOutDTO ejecutaModificacionLimiteConsumo(WSEjecutaModificacionLimiteConsumoInDTO pIn) {

        WSEjecutaModificacionLimiteConsumoOutDTO result = null;

        logger.debug("inicio(): ejecutaModificacionLimiteConsumo", this.getClass().getName());

        try {

            locator = new GestionLimiteConsumoLocator();
            beanLocal = locator.getModificacionLimiteConsumoFacade();

            result = beanLocal.ejecutaModificacionLimiteConsumoWS(pIn);

        } catch (GestionLimiteConsumoException e) {

            result = new WSEjecutaModificacionLimiteConsumoOutDTO();
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());
            result.setIEvento(e.getCodigoEvento());

        } catch (Exception e) {

            logger.error(e.getMessage(), this.getClass().getName());
            e.printStackTrace();
            result = new WSEjecutaModificacionLimiteConsumoOutDTO();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));
            result.setIEvento(0);
        }

        return result;

    }

}
