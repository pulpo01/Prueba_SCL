package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class LimiteConsumoUtilizadoDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private Double douMonto;

    /**
     * @return the douMonto
     */
    public Double getDouMonto() {
        return douMonto;
    }

    /**
     * @param douMonto
     *            the douMonto to set
     */
    public void setDouMonto(Double douMonto) {
        this.douMonto = douMonto;
    }

}
