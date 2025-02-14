package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class EjecutaCierreRestitucionOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumOOSS;

    /**
     * @return the lonNumOOSS
     */
    public Long getLonNumOOSS() {
        return lonNumOOSS;
    }

    /**
     * @param lonNumOOSS
     *            the lonNumOOSS to set
     */
    public void setLonNumOOSS(Long lonNumOOSS) {
        this.lonNumOOSS = lonNumOOSS;
    }

}
