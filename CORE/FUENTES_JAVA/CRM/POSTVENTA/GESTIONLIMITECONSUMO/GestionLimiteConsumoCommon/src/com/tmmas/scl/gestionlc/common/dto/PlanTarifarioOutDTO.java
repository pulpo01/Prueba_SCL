package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

/**
 * Clase que rescata los parametros de salida del PlanTarifarioDAO
 */
public class PlanTarifarioOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strDescPlanTarifario;
    private String strTipoTerminal;
    private String strCodLimConsumo;
    private String strCodCargoBasico;
    private String strTipPlanTarif;
    private String strTipPlan;

    /**
     * @return the strDescPlanTarifario
     */
    public String getStrDescPlanTarifario() {
        return strDescPlanTarifario;
    }

    /**
     * @param strDescPlanTarifario
     *            the strDescPlanTarifario to set
     */
    public void setStrDescPlanTarifario(String strDescPlanTarifario) {
        this.strDescPlanTarifario = strDescPlanTarifario;
    }

    /**
     * @return the strTipoTerminal
     */
    public String getStrTipoTerminal() {
        return strTipoTerminal;
    }

    /**
     * @param strTipoTerminal
     *            the strTipoTerminal to set
     */
    public void setStrTipoTerminal(String strTipoTerminal) {
        this.strTipoTerminal = strTipoTerminal;
    }

    /**
     * @return the strCodLimConsumo
     */
    public String getStrCodLimConsumo() {
        return strCodLimConsumo;
    }

    /**
     * @param strCodLimConsumo
     *            the strCodLimConsumo to set
     */
    public void setStrCodLimConsumo(String strCodLimConsumo) {
        this.strCodLimConsumo = strCodLimConsumo;
    }

    /**
     * @return the strCodCargoBasico
     */
    public String getStrCodCargoBasico() {
        return strCodCargoBasico;
    }

    /**
     * @param strCodCargoBasico
     *            the strCodCargoBasico to set
     */
    public void setStrCodCargoBasico(String strCodCargoBasico) {
        this.strCodCargoBasico = strCodCargoBasico;
    }

    /**
     * @return the strTipPlanTarif
     */
    public String getStrTipPlanTarif() {
        return strTipPlanTarif;
    }

    /**
     * @param strTipPlanTarif
     *            the strTipPlanTarif to set
     */
    public void setStrTipPlanTarif(String strTipPlanTarif) {
        this.strTipPlanTarif = strTipPlanTarif;
    }

    /**
     * @return the strTipPlan
     */
    public String getStrTipPlan() {
        return strTipPlan;
    }

    /**
     * @param strTipPlan
     *            the strTipPlan to set
     */
    public void setStrTipPlan(String strTipPlan) {
        this.strTipPlan = strTipPlan;
    }

}
