package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class PresupuestoForm extends ActionForm {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String accion;
    private long numProceso;
    private boolean flgIniciado;
    private Float montoAbono;
    private String rbCiclo;

    /**
     * @return the accion
     */
    public String getAccion() {
        return accion;
    }

    /**
     * @param accion
     *            the accion to set
     */
    public void setAccion(String pAccion) {
        this.accion = pAccion;
    }

    /**
     * @return the numProceso
     */
    public long getNumProceso() {
        return numProceso;
    }

    /**
     * @param numProceso
     *            the numProceso to set
     */
    public void setNumProceso(long pNumProceso) {
        this.numProceso = pNumProceso;
    }

    /**
     * @return the flgIniciado
     */
    public boolean isFlgIniciado() {
        return flgIniciado;
    }

    /**
     * @param flgIniciado
     *            the flgIniciado to set
     */
    public void setFlgIniciado(boolean pFlgIniciado) {
        this.flgIniciado = pFlgIniciado;
    }

    /**
     * @return the montoAbono
     */
    public Float getMontoAbono() {
        return montoAbono;
    }

    /**
     * @param montoAbono
     *            the montoAbono to set
     */
    public void setMontoAbono(Float pMontoAbono) {
        this.montoAbono = pMontoAbono;
    }

    /**
     * @return the rbCiclo
     */
    public String getRbCiclo() {
        return rbCiclo;
    }

    /**
     * @param rbCiclo
     *            the rbCiclo to set
     */
    public void setRbCiclo(String pRbCiclo) {
        this.rbCiclo = pRbCiclo;
    }

}
