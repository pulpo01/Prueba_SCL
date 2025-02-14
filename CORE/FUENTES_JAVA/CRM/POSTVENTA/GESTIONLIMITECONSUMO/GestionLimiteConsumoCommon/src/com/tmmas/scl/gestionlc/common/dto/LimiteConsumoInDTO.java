package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

/**
 * Clase que rescata los parametros de entrada para LimiteConsumoDAO
 */
public class LimiteConsumoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumAbonado;

    /**
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    /**
     * @param lonNumAbonado
     *            the lonNumAbonado to set
     */
    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
    }

}
