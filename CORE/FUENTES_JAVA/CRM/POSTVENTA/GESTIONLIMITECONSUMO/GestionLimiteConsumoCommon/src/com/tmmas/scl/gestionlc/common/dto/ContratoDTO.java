package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ContratoDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private String strCodTipContrato;

    private String strDesTipContrato;

    private String strIndComodato;

    private String strMesesMinimo;

    private String strIndPrecioLista;

    private String strIndProcequi;

    /**
     * @return the strCodTipContrato
     */
    public String getStrCodTipContrato() {
        return strCodTipContrato;
    }

    /**
     * @param strCodTipContrato
     *            the strCodTipContrato to set
     */
    public void setStrCodTipContrato(String strCodTipContrato) {
        this.strCodTipContrato = strCodTipContrato;
    }

    /**
     * @return the strDesTipContrato
     */
    public String getStrDesTipContrato() {
        return strDesTipContrato;
    }

    /**
     * @param strDesTipContrato
     *            the strDesTipContrato to set
     */
    public void setStrDesTipContrato(String strDesTipContrato) {
        this.strDesTipContrato = strDesTipContrato;
    }

    /**
     * @return the strIndComodato
     */
    public String getStrIndComodato() {
        return strIndComodato;
    }

    /**
     * @param strIndComodato
     *            the strIndComodato to set
     */
    public void setStrIndComodato(String strIndComodato) {
        this.strIndComodato = strIndComodato;
    }

    /**
     * @return the strMesesMinimo
     */
    public String getStrMesesMinimo() {
        return strMesesMinimo;
    }

    /**
     * @param strMesesMinimo
     *            the strMesesMinimo to set
     */
    public void setStrMesesMinimo(String strMesesMinimo) {
        this.strMesesMinimo = strMesesMinimo;
    }

    /**
     * @return the strIndPrecioLista
     */
    public String getStrIndPrecioLista() {
        return strIndPrecioLista;
    }

    /**
     * @param strIndPrecioLista
     *            the strIndPrecioLista to set
     */
    public void setStrIndPrecioLista(String strIndPrecioLista) {
        this.strIndPrecioLista = strIndPrecioLista;
    }

    /**
     * @return the strIndProcequi
     */
    public String getStrIndProcequi() {
        return strIndProcequi;
    }

    /**
     * @param strIndProcequi
     *            the strIndProcequi to set
     */
    public void setStrIndProcequi(String strIndProcequi) {
        this.strIndProcequi = strIndProcequi;
    }

}
