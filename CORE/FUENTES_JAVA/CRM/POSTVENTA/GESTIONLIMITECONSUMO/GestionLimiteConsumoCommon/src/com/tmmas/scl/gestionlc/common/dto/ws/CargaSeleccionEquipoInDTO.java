package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class CargaSeleccionEquipoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String strIndProcedencia;

    private String strCodTipContrato;

    private String strCodModVenta;

    private String strNomUsuario;

    private Long lonNumAbonado;

    private Long lonNumSiniestro;

    /**
     * @return the lonNumSiniestro
     */
    public Long getLonNumSiniestro() {
        return lonNumSiniestro;
    }

    /**
     * @param lonNumSiniestro
     *            the lonNumSiniestro to set
     */
    public void setLonNumSiniestro(Long lonNumSiniestro) {
        this.lonNumSiniestro = lonNumSiniestro;
    }

    /**
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    /**
     * @param lonNumAbonado
     *            the lonNumAbonado to set
     */
    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
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

    /**
     * @return the strIndProcedencia
     */
    public String getStrIndProcedencia() {
        return strIndProcedencia;
    }

    /**
     * @param strIndProcedencia
     *            the strIndProcedencia to set
     */
    public void setStrIndProcedencia(String strIndProcedencia) {
        this.strIndProcedencia = strIndProcedencia;
    }

    /**
     * @return the strCodTipContrato
     */
    public String getStrCodTipContrato() {
        return strCodTipContrato;
    }

    /**
     * @param strCodTipContrato
     *            the strCodTipContrato to set
     */
    public void setStrCodTipContrato(String strCodTipContrato) {
        this.strCodTipContrato = strCodTipContrato;
    }

    /**
     * @return the strCodModVenta
     */
    public String getStrCodModVenta() {
        return strCodModVenta;
    }

    /**
     * @param strCodModVenta
     *            the strCodModVenta to set
     */
    public void setStrCodModVenta(String strCodModVenta) {
        this.strCodModVenta = strCodModVenta;
    }

}
