package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class MontoMaximoLimiteConsumoInDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private Long lonCodCliente;
    private Long lonNunAbonado;

    /**
     * @return the lonCodCliente
     */
    public Long getLonCodCliente() {
        return lonCodCliente;
    }

    /**
     * @param lonCodCliente
     *            the lonCodCliente to set
     */
    public void setLonCodCliente(Long lonCodCliente) {
        this.lonCodCliente = lonCodCliente;
    }

    /**
     * @return the lonNunAbonado
     */
    public Long getLonNunAbonado() {
        return lonNunAbonado;
    }

    /**
     * @param lonNunAbonado
     *            the lonNunAbonado to set
     */
    public void setLonNunAbonado(Long lonNunAbonado) {
        this.lonNunAbonado = lonNunAbonado;
    }

}
