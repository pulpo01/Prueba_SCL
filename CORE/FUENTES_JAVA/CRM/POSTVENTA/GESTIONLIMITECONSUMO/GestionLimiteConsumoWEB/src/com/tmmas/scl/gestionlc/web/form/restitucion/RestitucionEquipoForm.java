package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class RestitucionEquipoForm extends ActionForm {

    private static final long serialVersionUID = 1L;

    private String strProcedencia;
    private String strCodTipContrato;
    private String strCodModPago;
    private String strCodMesProrroga;
    private String strCodCatTributaria;
    private String strCodNumContrato;
    private String strCodCuota;

    /**
     * @return the strProcedencia
     */
    public String getStrProcedencia() {
        return strProcedencia;
    }

    /**
     * @param strProcedencia
     *            the strProcedencia to set
     */
    public void setStrProcedencia(String pStrProcedencia) {
        this.strProcedencia = pStrProcedencia;
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
    public void setStrCodTipContrato(String pStrCodTipContrato) {
        this.strCodTipContrato = pStrCodTipContrato;
    }

    /**
     * @return the strCodModPago
     */
    public String getStrCodModPago() {
        return strCodModPago;
    }

    /**
     * @param strCodModPago
     *            the strCodModPago to set
     */
    public void setStrCodModPago(String pStrCodModPago) {
        this.strCodModPago = pStrCodModPago;
    }

    /**
     * @return the strCodMesProrroga
     */
    public String getStrCodMesProrroga() {
        return strCodMesProrroga;
    }

    /**
     * @param strCodMesProrroga
     *            the strCodMesProrroga to set
     */
    public void setStrCodMesProrroga(String pStrCodMesProrroga) {
        this.strCodMesProrroga = pStrCodMesProrroga;
    }

    /**
     * @return the strCodCatTributaria
     */
    public String getStrCodCatTributaria() {
        return strCodCatTributaria;
    }

    /**
     * @param strCodCatTributaria
     *            the strCodCatTributaria to set
     */
    public void setStrCodCatTributaria(String pStrCodCatTributaria) {
        this.strCodCatTributaria = pStrCodCatTributaria;
    }

    /**
     * @return the strCodNumContrato
     */
    public String getStrCodNumContrato() {
        return strCodNumContrato;
    }

    /**
     * @param strCodNumContrato
     *            the strCodNumContrato to set
     */
    public void setStrCodNumContrato(String pStrCodNumContrato) {
        this.strCodNumContrato = pStrCodNumContrato;
    }

    /**
     * @return the strCodCuota
     */
    public String getStrCodCuota() {
        return strCodCuota;
    }

    /**
     * @param strCodCuota
     *            the strCodCuota to set
     */
    public void setStrCodCuota(String pStrCodCuota) {
        this.strCodCuota = pStrCodCuota;
    }

}
