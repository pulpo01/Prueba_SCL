package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * Parametros de salida del WS 
 */
public class WSEjecutaModificacionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private String strNumOOSS;
    private int iEvento;
    private String strCodError;
    private String strDesError;

    /**
     * @return the strNumOOSS
     */
    public String getStrNumOOSS() {
        return strNumOOSS;
    }
    /**
     * @param strNumOOSS the pStrNumOOSS to set
     */
    public void setStrNumOOSS(String pStrNumOOSS) {
        this.strNumOOSS = pStrNumOOSS;
    }
    /**
     * @return the IEvento
     */
    public int getIEvento() {
        return iEvento;
    }
    /**
     * @param iEvento the pIEvento to set
     */
    public void setIEvento(int pIEvento) {
        this.iEvento = pIEvento;
    }
    /**
     * @return the strCodError
     */
    public String getStrCodError() {
        return strCodError;
    }
    /**
     * @param strCodError the pStrCodError to set
     */
    public void setStrCodError(String pStrCodError) {
        this.strCodError = pStrCodError;
    }
    /**
     * @return the strDesError
     */
    public String getStrDesError() {
        return strDesError;
    }
    /**
     * @param strDesError the pStrDesError to set
     */
    public void setStrDesError(String pStrDesError) {
        this.strDesError = pStrDesError;
    }

}
