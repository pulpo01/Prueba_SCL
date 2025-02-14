package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class TiposDescuentoDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private String codTipoDescuento;
    private String descTipoDescuento;

    public String getCodTipoDescuento() {
        return codTipoDescuento;
    }

    public void setCodTipoDescuento(String codTipoDescuento) {
        this.codTipoDescuento = codTipoDescuento;
    }

    public String getDescTipoDescuento() {
        return descTipoDescuento;
    }

    public void setDescTipoDescuento(String descTipoDescuento) {
        this.descTipoDescuento = descTipoDescuento;
    }
}
