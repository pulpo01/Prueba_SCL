package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class EjecutaRestitucionEquipoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String strIndComodato;
    private String strTipStock;
    private Integer intTipPantalla;
    private Long lonNumTransacReserva;

    /**
     * @return the intTipPantalla
     */
    public Integer getIntTipPantalla() {
        return intTipPantalla;
    }

    /**
     * @param intTipPantalla
     *            the intTipPantalla to set
     */
    public void setIntTipPantalla(Integer intTipPantalla) {
        this.intTipPantalla = intTipPantalla;
    }

    /**
     * @return the strTipStock
     */
    public String getStrTipStock() {
        return strTipStock;
    }

    /**
     * @param strTipStock
     *            the strTipStock to set
     */
    public void setStrTipStock(String strTipStock) {
        this.strTipStock = strTipStock;
    }

    /**
     * @return the strIndComodato
     */
    public String getStrIndComodato() {
        return strIndComodato;
    }

    /**
     * @param strIndComodato
     *            the strIndComodato to set
     */
    public void setStrIndComodato(String strIndComodato) {
        this.strIndComodato = strIndComodato;
    }

    /**
     * @return the lonNumTransacReserva
     */
    public Long getLonNumTransacReserva() {
        return lonNumTransacReserva;
    }

    /**
     * @param lonNumTransacReserva
     *            the lonNumTransacReserva to set
     */
    public void setLonNumTransacReserva(Long lonNumTransacReserva) {
        this.lonNumTransacReserva = lonNumTransacReserva;
    }

}
