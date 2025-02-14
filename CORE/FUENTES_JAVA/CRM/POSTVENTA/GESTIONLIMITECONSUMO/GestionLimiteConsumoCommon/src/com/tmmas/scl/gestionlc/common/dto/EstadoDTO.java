package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class EstadoDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intCodEstado;
    private String strDesEstado;

    /**
     * @return the intCodEstado
     */
    public Integer getIntCodEstado() {
        return intCodEstado;
    }

    /**
     * @param intCodEstado
     *            the intCodEstado to set
     */
    public void setIntCodEstado(Integer intCodEstado) {
        this.intCodEstado = intCodEstado;
    }

    /**
     * @return the strDesEstado
     */
    public String getStrDesEstado() {
        return strDesEstado;
    }

    /**
     * @param strDesEstado
     *            the strDesEstado to set
     */
    public void setStrDesEstado(String strDesEstado) {
        this.strDesEstado = strDesEstado;
    }

}
