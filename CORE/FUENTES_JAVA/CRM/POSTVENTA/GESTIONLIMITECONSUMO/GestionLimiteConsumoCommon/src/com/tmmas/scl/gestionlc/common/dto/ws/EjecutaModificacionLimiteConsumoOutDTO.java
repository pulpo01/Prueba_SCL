package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class EjecutaModificacionLimiteConsumoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String strNumOOSS;

    /**
     * @return the strNumOOSS
     */
    public String getStrNumOOSS() {
        return strNumOOSS;
    }

    /**
     * @param strNumOOSS
     *            the strNumOOSS to set
     */
    public void setStrNumOOSS(String strNumOOSS) {
        this.strNumOOSS = strNumOOSS;
    }

}
