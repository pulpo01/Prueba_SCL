package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class ResumenForm extends ActionForm {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String strComentario;

    /**
     * @return the strComentario
     */
    public String getStrComentario() {
        return strComentario;
    }

    /**
     * @param strComentario
     *            the strComentario to set
     */
    public void setStrComentario(String pStrComentario) {
        this.strComentario = pStrComentario;
    }

}
