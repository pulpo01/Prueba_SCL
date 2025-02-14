package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

/**
 * Clase que rescata los parametros de salida del LimiteConsumoDAO
 */
public class EjecutaModificacionLimiteConsumoInDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Long lonCodCliente;
    private Long lonNumAbonado;
    private Double douDetalleMonto;
    private String strRespContinuar;
    private String strCodPlanTarif;
    private String strCodLimConsumo;
    private String strUsuarioBd;
    private String strComentario;
    private Long lonNumOOSS;
    private String strCodOOSS;
    private Integer intCodProducto;
    private Long lonCodInter;

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
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    /**
     * @param lonNumAbonado
     *            the lonNumAbonado to set
     */
    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
    }

    /**
     * @return the douDetalleMonto
     */
    public Double getDouDetalleMonto() {
        return douDetalleMonto;
    }

    /**
     * @param douDetalleMonto
     *            the douDetalleMonto to set
     */
    public void setDouDetalleMonto(Double douDetalleMonto) {
        this.douDetalleMonto = douDetalleMonto;
    }

    /**
     * @return the strRespContinuar
     */
    public String getStrRespContinuar() {
        return strRespContinuar;
    }

    /**
     * @param strRespContinuar
     *            the strRespContinuar to set
     */
    public void setStrRespContinuar(String strRespContinuar) {
        this.strRespContinuar = strRespContinuar;
    }

    /**
     * @return the strCodPlanTarif
     */
    public String getStrCodPlanTarif() {
        return strCodPlanTarif;
    }

    /**
     * @param strCodPlanTarif
     *            the strCodPlanTarif to set
     */
    public void setStrCodPlanTarif(String strCodPlanTarif) {
        this.strCodPlanTarif = strCodPlanTarif;
    }

    /**
     * @return the strCodLimConsumo
     */
    public String getStrCodLimConsumo() {
        return strCodLimConsumo;
    }

    /**
     * @param strCodLimConsumo
     *            the strCodLimConsumo to set
     */
    public void setStrCodLimConsumo(String strCodLimConsumo) {
        this.strCodLimConsumo = strCodLimConsumo;
    }

    /**
     * @return the strUsuarioBd
     */
    public String getStrUsuarioBd() {
        return strUsuarioBd;
    }

    /**
     * @param strUsuarioBd
     *            the strUsuarioBd to set
     */
    public void setStrUsuarioBd(String strUsuarioBd) {
        this.strUsuarioBd = strUsuarioBd;
    }

    /**
     * @return the strComentario
     */
    public String getStrComentario() {
        return strComentario;
    }

    /**
     * @param strComentario
     *            the strComentario to set
     */
    public void setStrComentario(String strComentario) {
        this.strComentario = strComentario;
    }

    /**
     * @return the lonNumOOSS
     */
    public Long getLonNumOOSS() {
        return lonNumOOSS;
    }

    /**
     * @param lonNumOOSS
     *            the lonNumOOSS to set
     */
    public void setLonNumOOSS(Long lonNumOOSS) {
        this.lonNumOOSS = lonNumOOSS;
    }

    /**
     * @return the strCodOOSS
     */
    public String getStrCodOOSS() {
        return strCodOOSS;
    }

    /**
     * @param strCodOOSS
     *            the strCodOOSS to set
     */
    public void setStrCodOOSS(String strCodOOSS) {
        this.strCodOOSS = strCodOOSS;
    }

    /**
     * @return the intCodProducto
     */
    public Integer getIntCodProducto() {
        return intCodProducto;
    }

    /**
     * @param intCodProducto
     *            the intCodProducto to set
     */
    public void setIntCodProducto(Integer intCodProducto) {
        this.intCodProducto = intCodProducto;
    }

    /**
     * @return the lonCodInter
     */
    public Long getLonCodInter() {
        return lonCodInter;
    }

    /**
     * @param lonCodInter
     *            the lonCodInter to set
     */
    public void setLonCodInter(Long lonCodInter) {
        this.lonCodInter = lonCodInter;
    }

}
