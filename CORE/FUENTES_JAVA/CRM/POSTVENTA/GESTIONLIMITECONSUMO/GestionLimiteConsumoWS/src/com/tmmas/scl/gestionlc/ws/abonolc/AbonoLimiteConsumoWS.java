package com.tmmas.scl.gestionlc.ws.abonolc;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumo;
import com.tmmas.scl.gestionlc.ws.helper.GestionLimiteConsumoLocator;

@WebService
public class AbonoLimiteConsumoWS {

    private GlobalProperties global = GlobalProperties.getInstance();
    private GestionLimiteConsumoLocator locator;
    private AbonoLimiteConsumo beanLocal;
    private final LoggerHelper logger = LoggerHelper.getInstance();

    @WebMethod
    public WSCargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumo(WSCargaAbonoLimiteConsumoInDTO pIn) {

        WSCargaAbonoLimiteConsumoOutDTO result = null;

        logger.debug("inicio(): cargaAbonoLimiteConsumo", this.getClass().getName());

        try {

            locator = new GestionLimiteConsumoLocator();
            beanLocal = locator.getAbonoLimiteConsumoFacade();

            result = beanLocal.cargaAbonoLimiteConsumoWS(pIn);

        } catch (GestionLimiteConsumoException e) {

            result = new WSCargaAbonoLimiteConsumoOutDTO();
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());
            result.setIEvento(e.getCodigoEvento());

        } catch (Exception e) {

            logger.error(e.getMessage(), this.getClass().getName());
            e.printStackTrace();
            result = new WSCargaAbonoLimiteConsumoOutDTO();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));
            result.setIEvento(0);
        }

        return result;

    }

    @WebMethod
    public WSEjecutaAbonoLimiteConsumoOutDTO ejecutaAbonoLimiteConsumo(WSEjecutaAbonoLimiteConsumoInDTO pIn) {

        WSEjecutaAbonoLimiteConsumoOutDTO result = null;

        logger.debug("inicio(): ejecutaAbonoLimiteConsumo", this.getClass().getName());

        try {

            locator = new GestionLimiteConsumoLocator();
            beanLocal = locator.getAbonoLimiteConsumoFacade();

            result = beanLocal.ejecutaAbonoLimiteConsumoWS(pIn);

        } catch (GestionLimiteConsumoException e) {

            result = new WSEjecutaAbonoLimiteConsumoOutDTO();
            result.setStrCodError(e.getCodigo());
            result.setStrDesError(e.getDescripcionEvento());
            result.setIEvento(e.getCodigoEvento());

        } catch (Exception e) {

            logger.error(e.getMessage(), this.getClass().getName());
            e.printStackTrace();
            result = new WSEjecutaAbonoLimiteConsumoOutDTO();
            result.setStrCodError("ERR.0001");
            result.setStrDesError(global.getValor("ERR.0001"));
            result.setIEvento(0);
        }

        return result;

    }

}
