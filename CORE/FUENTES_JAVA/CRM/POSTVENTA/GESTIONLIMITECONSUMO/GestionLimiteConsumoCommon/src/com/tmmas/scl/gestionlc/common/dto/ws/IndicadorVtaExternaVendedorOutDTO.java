package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class IndicadorVtaExternaVendedorOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer intIndicadorVtaExterna;

    /**
     * @return the intIndicadorVtaExterna
     */
    public Integer getIntIndicadorVtaExterna() {
        return intIndicadorVtaExterna;
    }

    /**
     * @param intIndicadorVtaExterna
     *            the intIndicadorVtaExterna to set
     */
    public void setIntIndicadorVtaExterna(Integer intIndicadorVtaExterna) {
        this.intIndicadorVtaExterna = intIndicadorVtaExterna;
    }

}
