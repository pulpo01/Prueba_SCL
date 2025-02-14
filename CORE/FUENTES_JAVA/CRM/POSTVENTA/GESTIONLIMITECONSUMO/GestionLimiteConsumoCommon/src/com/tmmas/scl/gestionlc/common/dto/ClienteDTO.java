package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ClienteDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Long lonCodCliente;

    private String strCodOperadora;

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
     * @return the strCodOperadora
     */
    public String getStrCodOperadora() {
        return strCodOperadora;
    }

    /**
     * @param strCodOperadora
     *            the strCodOperadora to set
     */
    public void setStrCodOperadora(String strCodOperadora) {
        this.strCodOperadora = strCodOperadora;
    }

}
