package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * Clase que retorna los datos de segmentacion desde el WS.
 */
public class WSSegmentacionMLCDTO implements Serializable {

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
     * @param strCodColor the pStrCodColor to set
     */
    public void setStrCodColor(String pStrCodColor) {
        this.strCodColor = pStrCodColor;
    }
    /**
     * @return the strDescColor
     */
    public String getStrDescColor() {
        return strDescColor;
    }
    /**
     * @param strDescColor the pStrDescColor to set
     */
    public void setStrDescColor(String pStrDescColor) {
        this.strDescColor = pStrDescColor;
    }
    /**
     * @return the strCodSegmento
     */
    public String getStrCodSegmento() {
        return strCodSegmento;
    }
    /**
     * @param strCodSegmento the pStrCodSegmento to set
     */
    public void setStrCodSegmento(String pStrCodSegmento) {
        this.strCodSegmento = pStrCodSegmento;
    }
    /**
     * @return the strDescSegmento
     */
    public String getStrDescSegmento() {
        return strDescSegmento;
    }
    /**
     * @param strDescSegmento the pStrDescSegmento to set
     */
    public void setStrDescSegmento(String pStrDescSegmento) {
        this.strDescSegmento = pStrDescSegmento;
    }

}
