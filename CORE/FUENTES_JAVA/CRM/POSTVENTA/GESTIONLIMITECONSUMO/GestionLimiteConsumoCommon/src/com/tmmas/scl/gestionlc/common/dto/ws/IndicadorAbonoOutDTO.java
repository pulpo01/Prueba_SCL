package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class IndicadorAbonoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer intIndicadorAbono;

    /**
     * @return the intIndicadorAbono
     */
    public Integer getIntIndicadorAbono() {
        return intIndicadorAbono;
    }

    /**
     * @param intIndicadorAbono
     *            the intIndicadorAbono to set
     */
    public void setIntIndicadorAbono(Integer intIndicadorAbono) {
        this.intIndicadorAbono = intIndicadorAbono;
    }

}
