package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class FooOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String salida;

    public String getSalida() {
        return salida;
    }

    public void setSalida(String salida) {
        this.salida = salida;
    }

}
