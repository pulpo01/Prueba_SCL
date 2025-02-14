package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class IndicadorVtaExternaVendedorInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonCodVendedor;

    /**
     * @return the lonCodVendedor
     */
    public Long getLonCodVendedor() {
        return lonCodVendedor;
    }

    /**
     * @param lonCodVendedor
     *            the lonCodVendedor to set
     */
    public void setLonCodVendedor(Long lonCodVendedor) {
        this.lonCodVendedor = lonCodVendedor;
    }

}
