package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class BodegaDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intCodBodega;
    private String strDesBodega;

    /**
     * @return the intCodBodega
     */
    public Integer getIntCodBodega() {
        return intCodBodega;
    }

    /**
     * @param intCodBodega
     *            the intCodBodega to set
     */
    public void setIntCodBodega(Integer intCodBodega) {
        this.intCodBodega = intCodBodega;
    }

    /**
     * @return the strDesBodega
     */
    public String getStrDesBodega() {
        return strDesBodega;
    }

    /**
     * @param strDesBodega
     *            the strDesBodega to set
     */
    public void setStrDesBodega(String strDesBodega) {
        this.strDesBodega = strDesBodega;
    }

}
