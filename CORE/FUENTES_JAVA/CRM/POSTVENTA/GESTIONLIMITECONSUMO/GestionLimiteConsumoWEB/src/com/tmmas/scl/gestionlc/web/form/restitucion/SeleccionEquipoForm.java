package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class SeleccionEquipoForm extends ActionForm {

    private static final long serialVersionUID = 1L;

    private Integer intCodUso;
    private Integer intCodArticulo;
    private Integer intCodBodega;
    private Integer intCodEstado;
    private String strNumSerie;

    /**
     * @return the intCodUso
     */
    public Integer getIntCodUso() {
        return intCodUso;
    }

    /**
     * @param intCodUso
     *            the intCodUso to set
     */
    public void setIntCodUso(Integer pIntCodUso) {
        this.intCodUso = pIntCodUso;
    }

    /**
     * @return the intCodArticulo
     */
    public Integer getIntCodArticulo() {
        return intCodArticulo;
    }

    /**
     * @param intCodArticulo
     *            the intCodArticulo to set
     */
    public void setIntCodArticulo(Integer pIntCodArticulo) {
        this.intCodArticulo = pIntCodArticulo;
    }

    /**
     * @return the intCodBodega
     */
    public Integer getIntCodBodega() {
        return intCodBodega;
    }

    /**
     * @param intCodBodega
     *            the intCodBodega to set
     */
    public void setIntCodBodega(Integer pIntCodBodega) {
        this.intCodBodega = pIntCodBodega;
    }

    /**
     * @return the intCodEstado
     */
    public Integer getIntCodEstado() {
        return intCodEstado;
    }

    /**
     * @param intCodEstado
     *            the intCodEstado to set
     */
    public void setIntCodEstado(Integer pIntCodEstado) {
        this.intCodEstado = pIntCodEstado;
    }

    /**
     * @return the strNumSerie
     */
    public String getStrNumSerie() {
        return strNumSerie;
    }

    /**
     * @param strNumSerie
     *            the strNumSerie to set
     */
    public void setStrNumSerie(String pStrNumSerie) {
        this.strNumSerie = pStrNumSerie;
    }

}
