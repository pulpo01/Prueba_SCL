package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioInDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.PlanTarifarioDAO;

public class PlanTarifarioBO extends GestionLimiteConsumoAbstractBO {

    private PlanTarifarioDAO planTarifarioDAO = new PlanTarifarioDAO();

    /**
     * permite obtener el Plan Tarifario
     *
     * @param
     * @return PlanTarifarioOutDTO
     * @throws GestionLimiteConsumoException
     */
    public PlanTarifarioOutDTO obtienePlanTarifario(PlanTarifarioInDTO pIn) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtienePlanTarifario");
        PlanTarifarioOutDTO result = planTarifarioDAO.obtienePlanTarifario(pIn);

        loggerInfo("Fin(BO):obtienePlanTarifario");
        return result;

    }

    /**
     * permite obtener el detalle del Plan Tarifario
     *
     * @param
     * @return PlanTarifarioDTO
     * @throws GestionLimiteConsumoException
     */
    public PlanTarifarioDTO getDetallePlanTarifario(PlanTarifarioDTO pPlanTarifarioDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):getDetallePlanTarifario");

        PlanTarifarioDTO planTarifarioDTO = planTarifarioDAO.getDetallePlanTarifario(pPlanTarifarioDTO);

        loggerInfo("Fin(BO):getDetallePlanTarifario");
        return planTarifarioDTO;
    }

}
