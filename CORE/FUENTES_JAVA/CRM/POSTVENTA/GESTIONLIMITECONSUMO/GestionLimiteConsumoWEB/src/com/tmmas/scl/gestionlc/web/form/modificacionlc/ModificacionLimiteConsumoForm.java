package com.tmmas.scl.gestionlc.web.form.modificacionlc;

import org.apache.struts.action.ActionForm;

/**
 * Form de ventana PAG_ModificacionLimiteConsumo.jsp
 */
public class ModificacionLimiteConsumoForm extends ActionForm {

    private static final long serialVersionUID = 1L;

    private String strLimiteConsumo;
    private String strRespContinuar;

    /**
     * @return the strLimiteConsumo
     */
    public String getStrLimiteConsumo() {
        return strLimiteConsumo;
    }

    /**
     * @param strLimiteConsumo
     *            the strLimiteConsumo to set
     */
    public void setStrLimiteConsumo(String pStrLimiteConsumo) {
        this.strLimiteConsumo = pStrLimiteConsumo;
    }

    /**
     * @return the strRespContinuar
     */
    public String getStrRespContinuar() {
        return strRespContinuar;
    }

    /**
     * @param strRespContinuar
     *            the strRespContinuar to set
     */
    public void setStrRespContinuar(String pStrRespContinuar) {
        this.strRespContinuar = pStrRespContinuar;
    }

}
