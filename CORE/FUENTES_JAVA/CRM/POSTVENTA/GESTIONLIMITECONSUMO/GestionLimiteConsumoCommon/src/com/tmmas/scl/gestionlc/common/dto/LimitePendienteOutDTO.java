package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class LimitePendienteOutDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private Integer intLimPendiente;

    /**
     * @return the intLimPendiente
     */
    public Integer getIntLimPendiente() {
        return intLimPendiente;
    }

    /**
     * @param intLimPendiente
     *            the intLimPendiente to set
     */
    public void setIntLimPendiente(Integer intLimPendiente) {
        this.intLimPendiente = intLimPendiente;
    }

}
