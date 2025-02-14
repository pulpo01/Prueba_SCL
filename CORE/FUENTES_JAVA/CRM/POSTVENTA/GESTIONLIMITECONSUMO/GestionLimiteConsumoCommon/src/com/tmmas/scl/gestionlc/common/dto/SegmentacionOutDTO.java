package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

/**
 * Clase que rescata los parametros de salida del LimiteConsumoDAO
 */
public class SegmentacionOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String strCodColor;
    private String strDescColor;
    private String strCodSegmento;
    private String strDescSegmento;

    /**
     * @return the strCodColor
     */
    public String getStrCodColor() {
        return strCodColor;
    }

    /**
     * @param strCodColor
     *            the strCodColor to set
     */
    public void setStrCodColor(String strCodColor) {
        this.strCodColor = strCodColor;
    }

    /**
     * @return the strDescColor
     */
    public String getStrDescColor() {
        return strDescColor;
    }

    /**
     * @param strDescColor
     *            the strDescColor to set
     */
    public void setStrDescColor(String strDescColor) {
        this.strDescColor = strDescColor;
    }

    /**
     * @return the strCodSegmento
     */
    public String getStrCodSegmento() {
        return strCodSegmento;
    }

    /**
     * @param strCodSegmento
     *            the strCodSegmento to set
     */
    public void setStrCodSegmento(String strCodSegmento) {
        this.strCodSegmento = strCodSegmento;
    }

    /**
     * @return the strDescSegmento
     */
    public String getStrDescSegmento() {
        return strDescSegmento;
    }

    /**
     * @param strDescSegmento
     *            the strDescSegmento to set
     */
    public void setStrDescSegmento(String strDescSegmento) {
        this.strDescSegmento = strDescSegmento;
    }

}
