package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;


/**
 * 
 * Clase que obtiene los datos de limite de consumo desde el WS 
 *
 */
public class WSLimiteConsumoALCDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private String strCodLimiteConsumo;
    private String strDescLimiteConsumo;
    private String strCodigoUmbral;
    private String strDescUmbral;
    private Double douMontoUtilizado;
    private Double douMontoMaximo;
    /**
     * @return the strCodLimiteConsumo
     */
    public String getStrCodLimiteConsumo() {
        return strCodLimiteConsumo;
    }
    /**
     * @param strCodLimiteConsumo the pStrCodLimiteConsumo to set
     */
    public void setStrCodLimiteConsumo(String pStrCodLimiteConsumo) {
        this.strCodLimiteConsumo = pStrCodLimiteConsumo;
    }
    /**
     * @return the strDescLimiteConsumo
     */
    public String getStrDescLimiteConsumo() {
        return strDescLimiteConsumo;
    }
    /**
     * @param strDescLimiteConsumo the pStrDescLimiteConsumo to set
     */
    public void setStrDescLimiteConsumo(String pStrDescLimiteConsumo) {
        this.strDescLimiteConsumo = pStrDescLimiteConsumo;
    }
    /**
     * @return the strCodigoUmbral
     */
    public String getStrCodigoUmbral() {
        return strCodigoUmbral;
    }
    /**
     * @param strCodigoUmbral the pStrCodigoUmbral to set
     */
    public void setStrCodigoUmbral(String pStrCodigoUmbral) {
        this.strCodigoUmbral = pStrCodigoUmbral;
    }
    /**
     * @return the strDescUmbral
     */
    public String getStrDescUmbral() {
        return strDescUmbral;
    }
    /**
     * @param strDescUmbral the pStrDescUmbral to set
     */
    public void setStrDescUmbral(String pStrDescUmbral) {
        this.strDescUmbral = pStrDescUmbral;
    }
    /**
     * @return the douMontoUtilizado
     */
    public Double getDouMontoUtilizado() {
        return douMontoUtilizado;
    }
    /**
     * @param douMontoUtilizado the pDouMontoUtilizado to set
     */
    public void setDouMontoUtilizado(Double pDouMontoUtilizado) {
        this.douMontoUtilizado = pDouMontoUtilizado;
    }
    /**
     * @return the douMontoMaximo
     */
    public Double getDouMontoMaximo() {
        return douMontoMaximo;
    }
    /**
     * @param douMontoMaximo the pDouMontoMaximo to set
     */
    public void setDouMontoMaximo(Double pDouMontoMaximo) {
        this.douMontoMaximo = pDouMontoMaximo;
    }

}
