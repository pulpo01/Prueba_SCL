package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class EjecutaCierreRestitucionInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumSiniestro;
    private String strNomUsuario;
    private Long lonNumAbonado;
    private String strNumSerie;
    private Long lonNumVenta;
    private Long lonNumCargo;
    private Short shoCodUso;
    private String strCodModVenta;
    private String strCodTipContrato;
    private Long lonNumTransacReserva;
    private String strComentario;
    private String strNumContrato;
    private String strFolioContrato;

    /**
     * @return the strFolioContrato
     */
    public String getStrFolioContrato() {
        return strFolioContrato;
    }

    /**
     * @param strFolioContrato
     *            the strFolioContrato to set
     */
    public void setStrFolioContrato(String strFolioContrato) {
        this.strFolioContrato = strFolioContrato;
    }

    /**
     * @return the lonNumSiniestro
     */
    public Long getLonNumSiniestro() {
        return lonNumSiniestro;
    }

    /**
     * @param lonNumSiniestro
     *            the lonNumSiniestro to set
     */
    public void setLonNumSiniestro(Long lonNumSiniestro) {
        this.lonNumSiniestro = lonNumSiniestro;
    }

    /**
     * @return the lonNumTransacReserva
     */
    public Long getLonNumTransacReserva() {
        return lonNumTransacReserva;
    }

    /**
     * @param lonNumTransacReserva
     *            the lonNumTransacReserva to set
     */
    public void setLonNumTransacReserva(Long lonNumTransacReserva) {
        this.lonNumTransacReserva = lonNumTransacReserva;
    }

    /**
     * @return the strNomUsuario
     */
    public String getStrNomUsuario() {
        return strNomUsuario;
    }

    /**
     * @param strNomUsuario
     *            the strNomUsuario to set
     */
    public void setStrNomUsuario(String strNomUsuario) {
        this.strNomUsuario = strNomUsuario;
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
     * @return the strNumSerie
     */
    public String getStrNumSerie() {
        return strNumSerie;
    }

    /**
     * @param strNumSerie
     *            the strNumSerie to set
     */
    public void setStrNumSerie(String strNumSerie) {
        this.strNumSerie = strNumSerie;
    }

    /**
     * @return the lonNumVenta
     */
    public Long getLonNumVenta() {
        return lonNumVenta;
    }

    /**
     * @param lonNumVenta
     *            the lonNumVenta to set
     */
    public void setLonNumVenta(Long lonNumVenta) {
        this.lonNumVenta = lonNumVenta;
    }

    /**
     * @return the shoCodUso
     */
    public Short getShoCodUso() {
        return shoCodUso;
    }

    /**
     * @param shoCodUso
     *            the shoCodUso to set
     */
    public void setShoCodUso(Short shoCodUso) {
        this.shoCodUso = shoCodUso;
    }

    /**
     * @return the strCodModVenta
     */
    public String getStrCodModVenta() {
        return strCodModVenta;
    }

    /**
     * @param strCodModVenta
     *            the strCodModVenta to set
     */
    public void setStrCodModVenta(String strCodModVenta) {
        this.strCodModVenta = strCodModVenta;
    }

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
     * @return the lonNumCargo
     */
    public Long getLonNumCargo() {
        return lonNumCargo;
    }

    /**
     * @param lonNumCargo
     *            the lonNumCargo to set
     */
    public void setLonNumCargo(Long lonNumCargo) {
        this.lonNumCargo = lonNumCargo;
    }

    /**
     * @return the strNumContrato
     */
    public String getStrNumContrato() {
        return strNumContrato;
    }

    /**
     * @param strNumContrato
     *            the strNumContrato to set
     */
    public void setStrNumContrato(String strNumContrato) {
        this.strNumContrato = strNumContrato;
    }

}
