package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class IndicadorAbonoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer intCodModVenta;

    /**
     * @return the intCodModVenta
     */
    public Integer getIntCodModVenta() {
        return intCodModVenta;
    }

    /**
     * @param intCodModVenta
     *            the intCodModVenta to set
     */
    public void setIntCodModVenta(Integer intCodModVenta) {
        this.intCodModVenta = intCodModVenta;
    }

}
