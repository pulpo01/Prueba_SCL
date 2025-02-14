package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class EjecucionAbonoLimiteConsumoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonCodCliente;
    private Long lonNumAbonado;
    private Double douAbono;
    private String strUsuario;
    private String strCodModulo;
    private String strNumTarea;
    private Long lonNumOOSS;
    private String strCodOOSS;
    private Integer intCodProducto;
    private Long lonCodInter;
    private String strComentario;

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
     * @return the douAbono
     */
    public Double getDouAbono() {
        return douAbono;
    }

    /**
     * @param douAbono
     *            the douAbono to set
     */
    public void setDouAbono(Double douAbono) {
        this.douAbono = douAbono;
    }

    /**
     * @return the strUsuario
     */
    public String getStrUsuario() {
        return strUsuario;
    }

    /**
     * @param strUsuario
     *            the strUsuario to set
     */
    public void setStrUsuario(String strUsuario) {
        this.strUsuario = strUsuario;
    }

    /**
     * @return the strCodModulo
     */
    public String getStrCodModulo() {
        return strCodModulo;
    }

    /**
     * @param strCodModulo
     *            the strCodModulo to set
     */
    public void setStrCodModulo(String strCodModulo) {
        this.strCodModulo = strCodModulo;
    }

    /**
     * @return the strNumTarea
     */
    public String getStrNumTarea() {
        return strNumTarea;
    }

    /**
     * @param strNumTarea
     *            the strNumTarea to set
     */
    public void setStrNumTarea(String strNumTarea) {
        this.strNumTarea = strNumTarea;
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

}
