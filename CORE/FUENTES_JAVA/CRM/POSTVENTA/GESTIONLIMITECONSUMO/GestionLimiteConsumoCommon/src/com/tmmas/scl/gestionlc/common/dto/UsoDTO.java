package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class UsoDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intCodUso;
    private String strDesUso;

    /**
     * @return the intCodUso
     */
    public Integer getIntCodUso() {
        return intCodUso;
    }

    /**
     * @param intCodUso
     *            the intCodUso to set
     */
    public void setIntCodUso(Integer intCodUso) {
        this.intCodUso = intCodUso;
    }

    /**
     * @return the strDesUso
     */
    public String getStrDesUso() {
        return strDesUso;
    }

    /**
     * @param strDesUso
     *            the strDesUso to set
     */
    public void setStrDesUso(String strDesUso) {
        this.strDesUso = strDesUso;
    }

}
