package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * 
 * Parametros de entrada del WS 
 * 
 */
public class WSCargaModificacionLimiteConsumoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String strNumAbonado;

    /**
     * @return the strNumAbonado
     */
    public String getStrNumAbonado() {
        return strNumAbonado;
    }

    /**
     * @param strNumAbonado the strNumAbonado to set
     */
    public void setStrNumAbonado(String strNumAbonado) {
        this.strNumAbonado = strNumAbonado;
    }

}
