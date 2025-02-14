package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class FolioDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Integer intNumeroFolio;
    private String strPrefijoFolio;
    private String strDesEstadoFolio;
    private Integer intCodEstadoFolio;
    private Short shoIndFacturaCiclo;

    /**
     * @return the intNumeroFolio
     */
    public Integer getIntNumeroFolio() {
        return intNumeroFolio;
    }

    /**
     * @param intNumeroFolio
     *            the intNumeroFolio to set
     */
    public void setIntNumeroFolio(Integer intNumeroFolio) {
        this.intNumeroFolio = intNumeroFolio;
    }

    /**
     * @return the strPrefijoFolio
     */
    public String getStrPrefijoFolio() {
        return strPrefijoFolio;
    }

    /**
     * @param strPrefijoFolio
     *            the strPrefijoFolio to set
     */
    public void setStrPrefijoFolio(String strPrefijoFolio) {
        this.strPrefijoFolio = strPrefijoFolio;
    }

    /**
     * @return the strDesEstadoFolio
     */
    public String getStrDesEstadoFolio() {
        return strDesEstadoFolio;
    }

    /**
     * @param strDesEstadoFolio
     *            the strDesEstadoFolio to set
     */
    public void setStrDesEstadoFolio(String strDesEstadoFolio) {
        this.strDesEstadoFolio = strDesEstadoFolio;
    }

    /**
     * @return the intCodEstadoFolio
     */
    public Integer getIntCodEstadoFolio() {
        return intCodEstadoFolio;
    }

    /**
     * @param intCodEstadoFolio
     *            the intCodEstadoFolio to set
     */
    public void setIntCodEstadoFolio(Integer intCodEstadoFolio) {
        this.intCodEstadoFolio = intCodEstadoFolio;
    }

    /**
     * @return the shoIndFacturaCiclo
     */
    public Short getShoIndFacturaCiclo() {
        return shoIndFacturaCiclo;
    }

    /**
     * @param shoIndFacturaCiclo
     *            the shoIndFacturaCiclo to set
     */
    public void setShoIndFacturaCiclo(Short shoIndFacturaCiclo) {
        this.shoIndFacturaCiclo = shoIndFacturaCiclo;
    }

}
