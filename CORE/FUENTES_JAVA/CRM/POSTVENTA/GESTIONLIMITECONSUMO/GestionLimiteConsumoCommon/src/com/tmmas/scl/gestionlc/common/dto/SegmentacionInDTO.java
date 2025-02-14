package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

/**
 * Clase que rescata los parametros de entrada para SegmentacionDAO
 */
public class SegmentacionInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonCodCliente;

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

}
