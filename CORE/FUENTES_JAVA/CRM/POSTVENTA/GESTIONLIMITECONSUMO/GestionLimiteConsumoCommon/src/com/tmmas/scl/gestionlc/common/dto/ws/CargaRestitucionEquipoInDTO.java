package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class CargaRestitucionEquipoInDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long lonNumSiniestro;

    private String strFecRestitucion;

    private Long lonNumConstancia;

    private String strObservaciones;

    private String strNomUsuario;

    private Short shoCantSiniestros;

    private Long lonNumAbonado;

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
     * @return the strFecRestitucion
     */
    public String getStrFecRestitucion() {
        return strFecRestitucion;
    }

    /**
     * @param strFecRestitucion
     *            the strFecRestitucion to set
     */
    public void setStrFecRestitucion(String strFecRestitucion) {
        this.strFecRestitucion = strFecRestitucion;
    }

    /**
     * @return the lonNumConstancia
     */
    public Long getLonNumConstancia() {
        return lonNumConstancia;
    }

    /**
     * @param lonNumConstancia
     *            the lonNumConstancia to set
     */
    public void setLonNumConstancia(Long lonNumConstancia) {
        this.lonNumConstancia = lonNumConstancia;
    }

    /**
     * @return the strObservaciones
     */
    public String getStrObservaciones() {
        return strObservaciones;
    }

    /**
     * @param strObservaciones
     *            the strObservaciones to set
     */
    public void setStrObservaciones(String strObservaciones) {
        this.strObservaciones = strObservaciones;
    }

    /**
     * @return the shoCantSiniestros
     */
    public Short getShoCantSiniestros() {
        return shoCantSiniestros;
    }

    /**
     * @param shoCantSiniestros
     *            the shoCantSiniestros to set
     */
    public void setShoCantSiniestros(Short shoCantSiniestros) {
        this.shoCantSiniestros = shoCantSiniestros;
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

}
