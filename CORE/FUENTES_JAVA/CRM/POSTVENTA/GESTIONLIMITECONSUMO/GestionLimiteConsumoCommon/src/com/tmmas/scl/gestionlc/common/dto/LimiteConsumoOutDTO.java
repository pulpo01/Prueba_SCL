package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

/**
 * Clase que rescata los parametros de salida del LimiteConsumoDAO
 */
public class LimiteConsumoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strCodLimCons;
    private String strDescripcion;
    private Double douMontLimCons;
    private String strUnidadMedida;
    private String strDescMontMinMax;
    private String strIndDefault;
    private String strFechaDesde;
    private String strFechaHasta;
    private Double douMontoMinimo;
    private Double douMontoMaximo;
    private Integer intFlagCorte;
    private Double douMontoLimite;

    /**
     * @return the strCodLimCons
     */
    public String getStrCodLimCons() {
        return strCodLimCons;
    }

    /**
     * @param strCodLimCons
     *            the strCodLimCons to set
     */
    public void setStrCodLimCons(String strCodLimCons) {
        this.strCodLimCons = strCodLimCons;
    }

    /**
     * @return the strDescripcion
     */
    public String getStrDescripcion() {
        return strDescripcion;
    }

    /**
     * @param strDescripcion
     *            the strDescripcion to set
     */
    public void setStrDescripcion(String strDescripcion) {
        this.strDescripcion = strDescripcion;
    }

    /**
     * @return the douMontLimCons
     */
    public Double getDouMontLimCons() {
        return douMontLimCons;
    }

    /**
     * @param douMontLimCons
     *            the douMontLimCons to set
     */
    public void setDouMontLimCons(Double douMontLimCons) {
        this.douMontLimCons = douMontLimCons;
    }

    /**
     * @return the strUnidadMedida
     */
    public String getStrUnidadMedida() {
        return strUnidadMedida;
    }

    /**
     * @param strUnidadMedida
     *            the strUnidadMedida to set
     */
    public void setStrUnidadMedida(String strUnidadMedida) {
        this.strUnidadMedida = strUnidadMedida;
    }

    /**
     * @return the strDescMontMinMax
     */
    public String getStrDescMontMinMax() {
        return strDescMontMinMax;
    }

    /**
     * @param strDescMontMinMax
     *            the strDescMontMinMax to set
     */
    public void setStrDescMontMinMax(String strDescMontMinMax) {
        this.strDescMontMinMax = strDescMontMinMax;
    }

    /**
     * @return the strIndDefault
     */
    public String getStrIndDefault() {
        return strIndDefault;
    }

    /**
     * @param strIndDefault
     *            the strIndDefault to set
     */
    public void setStrIndDefault(String strIndDefault) {
        this.strIndDefault = strIndDefault;
    }

    /**
     * @return the strFechaDesde
     */
    public String getStrFechaDesde() {
        return strFechaDesde;
    }

    /**
     * @param strFechaDesde
     *            the strFechaDesde to set
     */
    public void setStrFechaDesde(String strFechaDesde) {
        this.strFechaDesde = strFechaDesde;
    }

    /**
     * @return the strFechaHasta
     */
    public String getStrFechaHasta() {
        return strFechaHasta;
    }

    /**
     * @param strFechaHasta
     *            the strFechaHasta to set
     */
    public void setStrFechaHasta(String strFechaHasta) {
        this.strFechaHasta = strFechaHasta;
    }

    /**
     * @return the douMontoMinimo
     */
    public Double getDouMontoMinimo() {
        return douMontoMinimo;
    }

    /**
     * @param douMontoMinimo
     *            the douMontoMinimo to set
     */
    public void setDouMontoMinimo(Double douMontoMinimo) {
        this.douMontoMinimo = douMontoMinimo;
    }

    /**
     * @return the douMontoMaximo
     */
    public Double getDouMontoMaximo() {
        return douMontoMaximo;
    }

    /**
     * @param douMontoMaximo
     *            the douMontoMaximo to set
     */
    public void setDouMontoMaximo(Double douMontoMaximo) {
        this.douMontoMaximo = douMontoMaximo;
    }

    /**
     * @return the intFlagCorte
     */
    public Integer getIntFlagCorte() {
        return intFlagCorte;
    }

    /**
     * @param intFlagCorte
     *            the intFlagCorte to set
     */
    public void setIntFlagCorte(Integer intFlagCorte) {
        this.intFlagCorte = intFlagCorte;
    }

    /**
     * @return the douMontoLimite
     */
    public Double getDouMontoLimite() {
        return douMontoLimite;
    }

    /**
     * @param douMontoLimite
     *            the douMontoLimite to set
     */
    public void setDouMontoLimite(Double douMontoLimite) {
        this.douMontoLimite = douMontoLimite;
    }

}
