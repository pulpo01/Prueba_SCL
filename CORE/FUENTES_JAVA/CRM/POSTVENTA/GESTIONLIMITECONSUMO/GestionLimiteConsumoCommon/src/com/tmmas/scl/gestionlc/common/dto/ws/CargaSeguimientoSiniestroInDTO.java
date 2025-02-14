package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class CargaSeguimientoSiniestroInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumAbonado;
    private String strNomUsuario;

    public String getStrNomUsuario() {
        return strNomUsuario;
    }

    public void setStrNomUsuario(String strNomUsuario) {
        this.strNomUsuario = strNomUsuario;
    }

    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
    }

}
