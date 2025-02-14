package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ArticuloDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intCodArticulo;

    private String strDesArticulo;

    /**
     * @return the intCodArticulo
     */
    public Integer getIntCodArticulo() {
        return intCodArticulo;
    }

    /**
     * @param intCodArticulo
     *            the intCodArticulo to set
     */
    public void setIntCodArticulo(Integer intCodArticulo) {
        this.intCodArticulo = intCodArticulo;
    }

    /**
     * @return the strDesArticulo
     */
    public String getStrDesArticulo() {
        return strDesArticulo;
    }

    /**
     * @param strDesArticulo
     *            the strDesArticulo to set
     */
    public void setStrDesArticulo(String strDesArticulo) {
        this.strDesArticulo = strDesArticulo;
    }

}
