package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ProrrogaDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intNumMeses;

    private String strDesProrroga;

    /**
     * @return the intNumMeses
     */
    public Integer getIntNumMeses() {
        return intNumMeses;
    }

    /**
     * @param intNumMeses
     *            the intNumMeses to set
     */
    public void setIntNumMeses(Integer intNumMeses) {
        this.intNumMeses = intNumMeses;
    }

    /**
     * @return the strDesProrroga
     */
    public String getStrDesProrroga() {
        return strDesProrroga;
    }

    /**
     * @param strDesProrroga
     *            the strDesProrroga to set
     */
    public void setStrDesProrroga(String strDesProrroga) {
        this.strDesProrroga = strDesProrroga;
    }

}
