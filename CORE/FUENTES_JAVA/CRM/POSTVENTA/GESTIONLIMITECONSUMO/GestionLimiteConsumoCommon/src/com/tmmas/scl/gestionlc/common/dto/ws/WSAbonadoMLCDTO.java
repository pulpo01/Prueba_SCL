package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * 
 * Clase que retorna los datos de abonado desde el WS
 *
 */
public class WSAbonadoMLCDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private Long lonNumAbonado;
    private Long lonNumCelular;
    private String strTipPlanTarif;
    private String strCodCargoBasico;
    private String strDescPlanTarifario;
    /**
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }
    /**
     * @param lonNumAbonado the pLonNumAbonado to set
     */
    public void setLonNumAbonado(Long pLonNumAbonado) {
        this.lonNumAbonado = pLonNumAbonado;
    }
    /**
     * @return the lonNumCelular
     */
    public Long getLonNumCelular() {
        return lonNumCelular;
    }
    /**
     * @param lonNumCelular the pLonNumCelular to set
     */
    public void setLonNumCelular(Long pLonNumCelular) {
        this.lonNumCelular = pLonNumCelular;
    }
    /**
     * @return the strTipPlanTarif
     */
    public String getStrTipPlanTarif() {
        return strTipPlanTarif;
    }
    /**
     * @param strTipPlanTarif the pStrTipPlanTarif to set
     */
    public void setStrTipPlanTarif(String pStrTipPlanTarif) {
        this.strTipPlanTarif = pStrTipPlanTarif;
    }
    /**
     * @return the strCodCargoBasico
     */
    public String getStrCodCargoBasico() {
        return strCodCargoBasico;
    }
    /**
     * @param strCodCargoBasico the pStrCodCargoBasico to set
     */
    public void setStrCodCargoBasico(String pStrCodCargoBasico) {
        this.strCodCargoBasico = pStrCodCargoBasico;
    }
    /**
     * @return the strDescPlanTarifario
     */
    public String getStrDescPlanTarifario() {
        return strDescPlanTarifario;
    }
    /**
     * @param strDescPlanTarifario the pStrDescPlanTarifario to set
     */
    public void setStrDescPlanTarifario(String pStrDescPlanTarifario) {
        this.strDescPlanTarifario = pStrDescPlanTarifario;
    }

}
