package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;

public class LimiteConsumoUtilizadoInDTO implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private Long lonCodCliente;
    private Long lonNunAbonado;
    private String strCodUmbral;
    private Long lonCodCiclo;

    /**
     * @return the lonCodCliente
     */
    public Long getLonCodCliente() {
        return lonCodCliente;
    }

    /**
     * @param lonCodCliente
     *            the lonCodCliente to set
     */
    public void setLonCodCliente(Long lonCodCliente) {
        this.lonCodCliente = lonCodCliente;
    }

    /**
     * @return the lonNunAbonado
     */
    public Long getLonNunAbonado() {
        return lonNunAbonado;
    }

    /**
     * @param lonNunAbonado
     *            the lonNunAbonado to set
     */
    public void setLonNunAbonado(Long lonNunAbonado) {
        this.lonNunAbonado = lonNunAbonado;
    }

    /**
     * @return the strCodUmbral
     */
    public String getStrCodUmbral() {
        return strCodUmbral;
    }

    /**
     * @param strCodUmbral
     *            the strCodUmbral to set
     */
    public void setStrCodUmbral(String strCodUmbral) {
        this.strCodUmbral = strCodUmbral;
    }

    /**
     * @return the lonCodCiclo
     */
    public Long getLonCodCiclo() {
        return lonCodCiclo;
    }

    /**
     * @param lonCodCiclo
     *            the lonCodCiclo to set
     */
    public void setLonCodCiclo(Long lonCodCiclo) {
        this.lonCodCiclo = lonCodCiclo;
    }

}
