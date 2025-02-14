package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class ParametroDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strNombreParametro;
    private String strCodigoModulo;
    private Integer intCodigoProducto;
    private String strValorParametro;

    /**
     * @return the strNombreParametro
     */
    public String getStrNombreParametro() {
        return strNombreParametro;
    }

    /**
     * @param strNombreParametro
     *            the strNombreParametro to set
     */
    public void setStrNombreParametro(String strNombreParametro) {
        this.strNombreParametro = strNombreParametro;
    }

    /**
     * @return the strCodigoModulo
     */
    public String getStrCodigoModulo() {
        return strCodigoModulo;
    }

    /**
     * @param strCodigoModulo
     *            the strCodigoModulo to set
     */
    public void setStrCodigoModulo(String strCodigoModulo) {
        this.strCodigoModulo = strCodigoModulo;
    }

    /**
     * @return the intCodigoProducto
     */
    public Integer getIntCodigoProducto() {
        return intCodigoProducto;
    }

    /**
     * @param intCodigoProducto
     *            the intCodigoProducto to set
     */
    public void setIntCodigoProducto(Integer intCodigoProducto) {
        this.intCodigoProducto = intCodigoProducto;
    }

    /**
     * @return the strValorParametro
     */
    public String getStrValorParametro() {
        return strValorParametro;
    }

    /**
     * @param strValorParametro
     *            the strValorParametro to set
     */
    public void setStrValorParametro(String strValorParametro) {
        this.strValorParametro = strValorParametro;
    }

}
