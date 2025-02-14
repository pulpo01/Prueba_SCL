package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class LimiteConsumoUmbralDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strCodLimiteConsumo;
    private String strDescLimiteConsumo;
    private String strCodigoUmbral;
    private String strDescUmbral;

    /**
     * @return the strCodLimiteConsumo
     */
    public String getStrCodLimiteConsumo() {
        return strCodLimiteConsumo;
    }

    /**
     * @param strCodLimiteConsumo
     *            the strCodLimiteConsumo to set
     */
    public void setStrCodLimiteConsumo(String strCodLimiteConsumo) {
        this.strCodLimiteConsumo = strCodLimiteConsumo;
    }

    /**
     * @return the strDescLimiteConsumo
     */
    public String getStrDescLimiteConsumo() {
        return strDescLimiteConsumo;
    }

    /**
     * @param strDescLimiteConsumo
     *            the strDescLimiteConsumo to set
     */
    public void setStrDescLimiteConsumo(String strDescLimiteConsumo) {
        this.strDescLimiteConsumo = strDescLimiteConsumo;
    }

    /**
     * @return the strCodigoUmbral
     */
    public String getStrCodigoUmbral() {
        return strCodigoUmbral;
    }

    /**
     * @param strCodigoUmbral
     *            the strCodigoUmbral to set
     */
    public void setStrCodigoUmbral(String strCodigoUmbral) {
        this.strCodigoUmbral = strCodigoUmbral;
    }

    /**
     * @return the strDescUmbral
     */
    public String getStrDescUmbral() {
        return strDescUmbral;
    }

    /**
     * @param strDescUmbral
     *            the strDescUmbral to set
     */
    public void setStrDescUmbral(String strDescUmbral) {
        this.strDescUmbral = strDescUmbral;
    }

}
