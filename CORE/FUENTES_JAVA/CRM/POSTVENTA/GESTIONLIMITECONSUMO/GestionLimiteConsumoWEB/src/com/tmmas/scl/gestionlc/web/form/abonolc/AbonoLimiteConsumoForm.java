package com.tmmas.scl.gestionlc.web.form.abonolc;

import org.apache.struts.action.ActionForm;

public class AbonoLimiteConsumoForm extends ActionForm {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String abono;

    public String getAbono() {
        return abono;
    }

    public void setAbono(String pAbono) {
        this.abono = pAbono;
    }

}
