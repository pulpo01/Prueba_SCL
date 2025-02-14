package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteOutDTO;
import com.tmmas.scl.gestionlc.common.dto.MontoMaximoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.LimiteConsumoDAO;

public class LimiteConsumoBO extends GestionLimiteConsumoAbstractBO {

    private LimiteConsumoDAO limiteConsumoDAO = new LimiteConsumoDAO();

    /**
     * permite obtener el limite consumo y umbral
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimiteConsumoUmbralDTO obtenerLimiteConsumoUmbral(LimiteConsumoUmbralInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimiteConsumoUmbral");

        LimiteConsumoUmbralDTO result = limiteConsumoDAO.obtenerLimiteConsumoUmbral(pIn);

        loggerDebug("Fin():obtenerLimiteConsumoUmbral");

        return result;

    }

    /**
     * permite obtener el limite de consumo utilizado
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimiteConsumoUtilizadoDTO obtenerLimiteConsumoUtilizado(LimiteConsumoUtilizadoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimiteConsumoUtilizado");

        LimiteConsumoUtilizadoDTO result = limiteConsumoDAO.obtenerLimiteConsumoUtilizado(pIn);

        loggerDebug("Fin():obtenerLimiteConsumoUtilizado");

        return result;
    }

    public LimiteConsumoOutDTO obtenerLimiteConsumo(LimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        LimiteConsumoOutDTO result = limiteConsumoDAO.obtenerLimiteConsumo(pIn);

        return result;

    }

    /**
     * permite obtener el monto maximo de abono para limite de consumo
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public Double obtieneMontoMaximoAbonoLimiteConsumo(MontoMaximoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        Double result = limiteConsumoDAO.obtieneMontoMaximoAbonoLimiteConsumo(pIn);

        return result;

    }

    /**
     * permite obtener el limite consumo
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void ejecutarAbonoLimiteConsumo(EjecucionAbonoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():ejecutarAbonoLimiteConsumo");

        limiteConsumoDAO.ejecutarAbonoLimiteConsumo(pIn);

        loggerDebug("Fin():ejecutarAbonoLimiteConsumo");

    }

    public void ejecutaModificacionLimiteConsumo(EjecutaModificacionLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():ejecutaModificacionLimiteConsumo");

        limiteConsumoDAO.ejecutaModificacionLimiteConsumo(pIn);

        loggerDebug("Fin():ejecutarModificacionLimiteConsumo");

    }

    /**
     * permite obtener el limite de consumo utilizado
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public LimitePendienteOutDTO obtenerLimitePendiente(LimitePendienteInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio():obtenerLimitePendiente");

        LimitePendienteOutDTO result = limiteConsumoDAO.obtenerLimitePendiente(pIn);

        loggerDebug("Fin():obtenerLimitePendiente");

        return result;
    }

}
