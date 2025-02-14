package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

/**
 * Clase que rescata los parametros de entrada para PlanTarifarioDAO
 */
public class PlanTarifarioInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String strCodPlanTarif;

    /**
     * @return the strCodPlanTarif
     */
    public String getStrCodPlanTarif() {
        return strCodPlanTarif;
    }

    /**
     * @param strCodPlanTarif
     *            the strCodPlanTarif to set
     */
    public void setStrCodPlanTarif(String strCodPlanTarif) {
        this.strCodPlanTarif = strCodPlanTarif;
    }

}
