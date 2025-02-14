package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ModalidadDTO implements Serializable {

    private static final long serialVersionUID = 3980487018909203664L;

    private Short shoIndCuotas;
    private Short shoCodModVenta;
    private String strDesModVenta;
    private Short shoIndPagado;
    private Short shoCodCauPago;
    private Short shoIndAbono;

    /**
     * @return the shoCodCauPago
     */
    public Short getShoCodCauPago() {
        return shoCodCauPago;
    }

    /**
     * @param shoCodCauPago
     *            the shoCodCauPago to set
     */
    public void setShoCodCauPago(Short shoCodCauPago) {
        this.shoCodCauPago = shoCodCauPago;
    }

    /**
     * @return the shoIndAbono
     */
    public Short getShoIndAbono() {
        return shoIndAbono;
    }

    /**
     * @param shoIndAbono
     *            the shoIndAbono to set
     */
    public void setShoIndAbono(Short shoIndAbono) {
        this.shoIndAbono = shoIndAbono;
    }

    /**
     * @return the shoIndPagado
     */
    public Short getShoIndPagado() {
        return shoIndPagado;
    }

    /**
     * @param shoIndPagado
     *            the shoIndPagado to set
     */
    public void setShoIndPagado(Short shoIndPagado) {
        this.shoIndPagado = shoIndPagado;
    }

    /**
     * @return the shoIndCuotas
     */
    public Short getShoIndCuotas() {
        return shoIndCuotas;
    }

    /**
     * @param shoIndCuotas
     *            the shoIndCuotas to set
     */
    public void setShoIndCuotas(Short shoIndCuotas) {
        this.shoIndCuotas = shoIndCuotas;
    }

    /**
     * @return the shoCodModVenta
     */
    public Short getShoCodModVenta() {
        return shoCodModVenta;
    }

    /**
     * @param shoCodModVenta
     *            the shoCodModVenta to set
     */
    public void setShoCodModVenta(Short shoCodModVenta) {
        this.shoCodModVenta = shoCodModVenta;
    }

    /**
     * @return the strDesModVenta
     */
    public String getStrDesModVenta() {
        return strDesModVenta;
    }

    /**
     * @param strDesModVenta
     *            the strDesModVenta to set
     */
    public void setStrDesModVenta(String strDesModVenta) {
        this.strDesModVenta = strDesModVenta;
    }

}
