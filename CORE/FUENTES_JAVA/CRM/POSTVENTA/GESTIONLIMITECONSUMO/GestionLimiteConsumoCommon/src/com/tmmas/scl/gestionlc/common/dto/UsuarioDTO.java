package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class UsuarioDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strNomUsuario;

    private Integer intCodVendedor;

    private String strCodTipComis;

    private String strCodOficina;

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
     * @return the intCodVendedor
     */
    public Integer getIntCodVendedor() {
        return intCodVendedor;
    }

    /**
     * @param intCodVendedor
     *            the intCodVendedor to set
     */
    public void setIntCodVendedor(Integer intCodVendedor) {
        this.intCodVendedor = intCodVendedor;
    }

    /**
     * @return the strCodTipComis
     */
    public String getStrCodTipComis() {
        return strCodTipComis;
    }

    /**
     * @param strCodTipComis
     *            the strCodTipComis to set
     */
    public void setStrCodTipComis(String strCodTipComis) {
        this.strCodTipComis = strCodTipComis;
    }

    /**
     * @return the strCodOficina
     */
    public String getStrCodOficina() {
        return strCodOficina;
    }

    /**
     * @param strCodOficina
     *            the strCodOficina to set
     */
    public void setStrCodOficina(String strCodOficina) {
        this.strCodOficina = strCodOficina;
    }

}
