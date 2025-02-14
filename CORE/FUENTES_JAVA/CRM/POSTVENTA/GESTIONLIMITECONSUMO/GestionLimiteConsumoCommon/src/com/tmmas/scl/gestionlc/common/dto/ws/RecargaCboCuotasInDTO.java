package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class RecargaCboCuotasInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Short shoCodModVenta;
    private String strNomUsuario;

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

}
