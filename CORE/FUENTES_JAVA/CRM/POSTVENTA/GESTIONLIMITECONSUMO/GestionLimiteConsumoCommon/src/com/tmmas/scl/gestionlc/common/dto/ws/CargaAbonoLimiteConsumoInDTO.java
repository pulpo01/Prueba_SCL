package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class CargaAbonoLimiteConsumoInDTO implements Serializable {

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
