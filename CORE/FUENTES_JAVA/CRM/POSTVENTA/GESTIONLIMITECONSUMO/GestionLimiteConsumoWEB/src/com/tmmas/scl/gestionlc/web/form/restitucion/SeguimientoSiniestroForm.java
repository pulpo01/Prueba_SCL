package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class SeguimientoSiniestroForm extends ActionForm {

    private static final long serialVersionUID = 1L;

    private Long lonIdSiniestro;

    private String strFecRestitucion;

    private Long lonConstPolicial;

    private String strObservacion;

    private String strTipTerminalSel;

    /**
     * @return the lonIdSiniestro
     */
    public Long getLonIdSiniestro() {
        return lonIdSiniestro;
    }

    /**
     * @param lonIdSiniestro
     *            the lonIdSiniestro to set
     */
    public void setLonIdSiniestro(Long pLonIdSiniestro) {
        this.lonIdSiniestro = pLonIdSiniestro;
    }

    /**
     * @return the strFecRestitucion
     */
    public String getStrFecRestitucion() {
        return strFecRestitucion;
    }

    /**
     * @param strFecRestitucion
     *            the strFecRestitucion to set
     */
    public void setStrFecRestitucion(String pStrFecRestitucion) {
        this.strFecRestitucion = pStrFecRestitucion;
    }

    /**
     * @return the lonConstPolicial
     */
    public Long getLonConstPolicial() {
        return lonConstPolicial;
    }

    /**
     * @param lonConstPolicial
     *            the lonConstPolicial to set
     */
    public void setLonConstPolicial(Long pLonConstPolicial) {
        this.lonConstPolicial = pLonConstPolicial;
    }

    /**
     * @return the strObservacion
     */
    public String getStrObservacion() {
        return strObservacion;
    }

    /**
     * @param strObservacion
     *            the strObservacion to set
     */
    public void setStrObservacion(String pStrObservacion) {
        this.strObservacion = pStrObservacion;
    }

    /**
     * @return the strTipTerminalSel
     */
    public String getStrTipTerminalSel() {
        return strTipTerminalSel;
    }

    /**
     * @param strTipTerminalSel
     *            the strTipTerminalSel to set
     */
    public void setStrTipTerminalSel(String pStrTipTerminalSel) {
        this.strTipTerminalSel = pStrTipTerminalSel;
    }

}
