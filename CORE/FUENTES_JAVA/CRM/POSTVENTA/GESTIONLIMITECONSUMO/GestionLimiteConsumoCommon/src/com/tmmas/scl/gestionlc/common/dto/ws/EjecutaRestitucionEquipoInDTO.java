package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class EjecutaRestitucionEquipoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumSiniestro;
    private String strNomUsuario;
    private Long lonNumAbonado;
    private String strNumSerie;
    private Integer intCodArticulo;
    private Integer intCodBodega;
    private Short shoCodUso;
    private Short shoCodEstado;
    private String strCodModVenta;
    private String strCodCatTribut;
    private String strCodTipContrato;

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
     * @return the intCodArticulo
     */
    public Integer getIntCodArticulo() {
        return intCodArticulo;
    }

    /**
     * @param intCodArticulo
     *            the intCodArticulo to set
     */
    public void setIntCodArticulo(Integer intCodArticulo) {
        this.intCodArticulo = intCodArticulo;
    }

    /**
     * @return the intCodBodega
     */
    public Integer getIntCodBodega() {
        return intCodBodega;
    }

    /**
     * @param intCodBodega
     *            the intCodBodega to set
     */
    public void setIntCodBodega(Integer intCodBodega) {
        this.intCodBodega = intCodBodega;
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
     * @return the shoCodEstado
     */
    public Short getShoCodEstado() {
        return shoCodEstado;
    }

    /**
     * @param shoCodEstado
     *            the shoCodEstado to set
     */
    public void setShoCodEstado(Short shoCodEstado) {
        this.shoCodEstado = shoCodEstado;
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
     * @return the strCodCatTribut
     */
    public String getStrCodCatTribut() {
        return strCodCatTribut;
    }

    /**
     * @param strCodCatTribut
     *            the strCodCatTribut to set
     */
    public void setStrCodCatTribut(String strCodCatTribut) {
        this.strCodCatTribut = strCodCatTribut;
    }

}
