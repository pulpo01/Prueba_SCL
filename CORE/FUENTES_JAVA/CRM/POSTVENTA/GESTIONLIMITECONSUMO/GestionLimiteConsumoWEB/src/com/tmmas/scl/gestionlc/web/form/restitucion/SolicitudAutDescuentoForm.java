package com.tmmas.scl.gestionlc.web.form.restitucion;

import org.apache.struts.action.ActionForm;

public class SolicitudAutDescuentoForm extends ActionForm {

    private static final long serialVersionUID = 1L;

    private String numAutorizacion = " ";
    private String estadoSolicitud = " ";
    private String estadoSolicitudGlosa = " ";
    private String accion = " ";
    private String estadoSolicitudPendiente = " ";
    private String estadoSolicitudAutorizada = " ";
    private String estadoSolicitudCancelada = " ";
    private boolean flgIniciado;

    /**
     * @return the numAutorizacion
     */
    public String getNumAutorizacion() {
        return numAutorizacion;
    }

    /**
     * @param numAutorizacion
     *            the numAutorizacion to set
     */
    public void setNumAutorizacion(String pNumAutorizacion) {
        this.numAutorizacion = pNumAutorizacion;
    }

    /**
     * @return the estadoSolicitud
     */
    public String getEstadoSolicitud() {
        return estadoSolicitud;
    }

    /**
     * @param estadoSolicitud
     *            the estadoSolicitud to set
     */
    public void setEstadoSolicitud(String pEstadoSolicitud) {
        this.estadoSolicitud = pEstadoSolicitud;
    }

    /**
     * @return the estadoSolicitudGlosa
     */
    public String getEstadoSolicitudGlosa() {
        return estadoSolicitudGlosa;
    }

    /**
     * @param estadoSolicitudGlosa
     *            the estadoSolicitudGlosa to set
     */
    public void setEstadoSolicitudGlosa(String pEstadoSolicitudGlosa) {
        this.estadoSolicitudGlosa = pEstadoSolicitudGlosa;
    }

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
     * @return the estadoSolicitudPendiente
     */
    public String getEstadoSolicitudPendiente() {
        return estadoSolicitudPendiente;
    }

    /**
     * @param estadoSolicitudPendiente
     *            the estadoSolicitudPendiente to set
     */
    public void setEstadoSolicitudPendiente(String pEstadoSolicitudPendiente) {
        this.estadoSolicitudPendiente = pEstadoSolicitudPendiente;
    }

    /**
     * @return the estadoSolicitudAutorizada
     */
    public String getEstadoSolicitudAutorizada() {
        return estadoSolicitudAutorizada;
    }

    /**
     * @param estadoSolicitudAutorizada
     *            the estadoSolicitudAutorizada to set
     */
    public void setEstadoSolicitudAutorizada(String pEstadoSolicitudAutorizada) {
        this.estadoSolicitudAutorizada = pEstadoSolicitudAutorizada;
    }

    /**
     * @return the estadoSolicitudCancelada
     */
    public String getEstadoSolicitudCancelada() {
        return estadoSolicitudCancelada;
    }

    /**
     * @param estadoSolicitudCancelada
     *            the estadoSolicitudCancelada to set
     */
    public void setEstadoSolicitudCancelada(String pEstadoSolicitudCancelada) {
        this.estadoSolicitudCancelada = pEstadoSolicitudCancelada;
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

}
