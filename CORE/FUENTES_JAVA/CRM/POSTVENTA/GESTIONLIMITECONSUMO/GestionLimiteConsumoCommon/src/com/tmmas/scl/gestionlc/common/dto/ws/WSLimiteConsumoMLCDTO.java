package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * 
 * Clase que retorna los datos de limite de consumo desde el WS
 *
 */
public class WSLimiteConsumoMLCDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private Double douMontoMaximo;
    private Double douMontoMinimo;
    private String strCodLimConsumo;
    private String strDescripcion;
    private String strRangoLimiteConsumo;
    private String strFechaDesde;
    private String strFechaHasta;

    /**
     * @return the douMontoMaximo
     */
    public Double getDouMontoMaximo() {
        return douMontoMaximo;
    }
    /**
     * @param douMontoMaximo the pDouMontoMaximo to set
     */
    public void setDouMontoMaximo(Double pDouMontoMaximo) {
        this.douMontoMaximo = pDouMontoMaximo;
    }
    /**
     * @return the douMontoMinimo
     */
    public Double getDouMontoMinimo() {
        return douMontoMinimo;
    }
    /**
     * @param douMontoMinimo the pDouMontoMinimo to set
     */
    public void setDouMontoMinimo(Double pDouMontoMinimo) {
        this.douMontoMinimo = pDouMontoMinimo;
    }
    /**
     * @return the strCodLimConsumo
     */
    public String getStrCodLimConsumo() {
        return strCodLimConsumo;
    }
    /**
     * @param strCodLimConsumo the pStrCodLimConsumo to set
     */
    public void setStrCodLimConsumo(String pStrCodLimConsumo) {
        this.strCodLimConsumo = pStrCodLimConsumo;
    }
    /**
     * @return the strDescripcion
     */
    public String getStrDescripcion() {
        return strDescripcion;
    }
    /**
     * @param strDescripcion the pStrDescripcion to set
     */
    public void setStrDescripcion(String pStrDescripcion) {
        this.strDescripcion = pStrDescripcion;
    }
    /**
     * @return the strRangoLimiteConsumo
     */
    public String getStrRangoLimiteConsumo() {
        return strRangoLimiteConsumo;
    }
    /**
     * @param strRangoLimiteConsumo the pStrRangoLimiteConsumo to set
     */
    public void setStrRangoLimiteConsumo(String pStrRangoLimiteConsumo) {
        this.strRangoLimiteConsumo = pStrRangoLimiteConsumo;
    }
    /**
     * @return the strFechaDesde
     */
    public String getStrFechaDesde() {
        return strFechaDesde;
    }
    /**
     * @param strFechaDesde the pStrFechaDesde to set
     */
    public void setStrFechaDesde(String pStrFechaDesde) {
        this.strFechaDesde = pStrFechaDesde;
    }
    /**
     * @return the strFechaHasta
     */
    public String getStrFechaHasta() {
        return strFechaHasta;
    }
    /**
     * @param strFechaHasta the pStrFechaHasta to set
     */
    public void setStrFechaHasta(String pStrFechaHasta) {
        this.strFechaHasta = pStrFechaHasta;
    }

}
