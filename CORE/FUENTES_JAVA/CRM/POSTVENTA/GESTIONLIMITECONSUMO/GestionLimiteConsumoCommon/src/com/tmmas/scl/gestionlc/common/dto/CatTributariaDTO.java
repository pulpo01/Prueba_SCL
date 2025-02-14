package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class CatTributariaDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intCodTipDocum;

    private String strDesTipDocum;

    private String strTipFoliacion;

    private String strCodCaTribut;

    /**
     * @return the intCodTipDocum
     */
    public Integer getIntCodTipDocum() {
        return intCodTipDocum;
    }

    /**
     * @param intCodTipDocum
     *            the intCodTipDocum to set
     */
    public void setIntCodTipDocum(Integer intCodTipDocum) {
        this.intCodTipDocum = intCodTipDocum;
    }

    /**
     * @return the strDesTipDocum
     */
    public String getStrDesTipDocum() {
        return strDesTipDocum;
    }

    /**
     * @param strDesTipDocum
     *            the strDesTipDocum to set
     */
    public void setStrDesTipDocum(String strDesTipDocum) {
        this.strDesTipDocum = strDesTipDocum;
    }

    /**
     * @return the strTipFoliacion
     */
    public String getStrTipFoliacion() {
        return strTipFoliacion;
    }

    /**
     * @param strTipFoliacion
     *            the strTipFoliacion to set
     */
    public void setStrTipFoliacion(String strTipFoliacion) {
        this.strTipFoliacion = strTipFoliacion;
    }

    /**
     * @return the strCodCaTribut
     */
    public String getStrCodCaTribut() {
        return strCodCaTribut;
    }

    /**
     * @param strCodCaTribut
     *            the strCodCaTribut to set
     */
    public void setStrCodCaTribut(String strCodCaTribut) {
        this.strCodCaTribut = strCodCaTribut;
    }

}
