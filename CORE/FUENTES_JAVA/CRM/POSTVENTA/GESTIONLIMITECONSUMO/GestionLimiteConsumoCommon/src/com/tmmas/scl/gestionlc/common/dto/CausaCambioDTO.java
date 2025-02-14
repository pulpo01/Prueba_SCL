package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class CausaCambioDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Short shoCodProducto;

    private String strCodCausaCambio;

    private String strDesCausaCambio;

    private Short shoIndAntiguedad;

    private Short shoIndCargo;

    private Short shoIndDevAlmacen;

    private Short shoCodEstadoDev;

    /**
     * @return the shoCodProducto
     */
    public Short getShoCodProducto() {
        return shoCodProducto;
    }

    /**
     * @param shoCodProducto
     *            the shoCodProducto to set
     */
    public void setShoCodProducto(Short shoCodProducto) {
        this.shoCodProducto = shoCodProducto;
    }

    /**
     * @return the strCodCausaCambio
     */
    public String getStrCodCausaCambio() {
        return strCodCausaCambio;
    }

    /**
     * @param strCodCausaCambio
     *            the strCodCausaCambio to set
     */
    public void setStrCodCausaCambio(String strCodCausaCambio) {
        this.strCodCausaCambio = strCodCausaCambio;
    }

    /**
     * @return the strDesCausaCambio
     */
    public String getStrDesCausaCambio() {
        return strDesCausaCambio;
    }

    /**
     * @param strDesCausaCambio
     *            the strDesCausaCambio to set
     */
    public void setStrDesCausaCambio(String strDesCausaCambio) {
        this.strDesCausaCambio = strDesCausaCambio;
    }

    /**
     * @return the shoIndAntiguedad
     */
    public Short getShoIndAntiguedad() {
        return shoIndAntiguedad;
    }

    /**
     * @param shoIndAntiguedad
     *            the shoIndAntiguedad to set
     */
    public void setShoIndAntiguedad(Short shoIndAntiguedad) {
        this.shoIndAntiguedad = shoIndAntiguedad;
    }

    /**
     * @return the shoIndCargo
     */
    public Short getShoIndCargo() {
        return shoIndCargo;
    }

    /**
     * @param shoIndCargo
     *            the shoIndCargo to set
     */
    public void setShoIndCargo(Short shoIndCargo) {
        this.shoIndCargo = shoIndCargo;
    }

    /**
     * @return the shoIndDevAlmacen
     */
    public Short getShoIndDevAlmacen() {
        return shoIndDevAlmacen;
    }

    /**
     * @param shoIndDevAlmacen
     *            the shoIndDevAlmacen to set
     */
    public void setShoIndDevAlmacen(Short shoIndDevAlmacen) {
        this.shoIndDevAlmacen = shoIndDevAlmacen;
    }

    /**
     * @return the shoCodEstadoDev
     */
    public Short getShoCodEstadoDev() {
        return shoCodEstadoDev;
    }

    /**
     * @param shoCodEstadoDev
     *            the shoCodEstadoDev to set
     */
    public void setShoCodEstadoDev(Short shoCodEstadoDev) {
        this.shoCodEstadoDev = shoCodEstadoDev;
    }

}
