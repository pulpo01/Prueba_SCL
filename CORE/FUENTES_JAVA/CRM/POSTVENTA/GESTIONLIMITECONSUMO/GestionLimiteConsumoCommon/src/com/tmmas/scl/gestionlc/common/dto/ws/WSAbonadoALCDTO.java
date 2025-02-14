package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

/**
 * 
 * Clase que obtiene los datos de abonado desde el WS 
 *
 */
public class WSAbonadoALCDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private Long lonNumAbonado;
    private Long lonNumCelular;
    private String strNumSerie;
    private String strCodTecnologia;
    private String strCodSituacion;
    private String strDescGrupoTecnologico;
    private String strDescSituacion;
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
     * @return the strNumSerie
     */
    public String getStrNumSerie() {
        return strNumSerie;
    }
    /**
     * @param strNumSerie the pStrNumSerie to set
     */
    public void setStrNumSerie(String pStrNumSerie) {
        this.strNumSerie = pStrNumSerie;
    }
    /**
     * @return the strCodTecnologia
     */
    public String getStrCodTecnologia() {
        return strCodTecnologia;
    }
    /**
     * @param strCodTecnologia the pStrCodTecnologia to set
     */
    public void setStrCodTecnologia(String pStrCodTecnologia) {
        this.strCodTecnologia = pStrCodTecnologia;
    }
    /**
     * @return the strCodSituacion
     */
    public String getStrCodSituacion() {
        return strCodSituacion;
    }
    /**
     * @param strCodSituacion the pStrCodSituacion to set
     */
    public void setStrCodSituacion(String pStrCodSituacion) {
        this.strCodSituacion = pStrCodSituacion;
    }
    /**
     * @return the strDescGrupoTecnologico
     */
    public String getStrDescGrupoTecnologico() {
        return strDescGrupoTecnologico;
    }
    /**
     * @param strDescGrupoTecnologico the pStrDescGrupoTecnologico to set
     */
    public void setStrDescGrupoTecnologico(String pStrDescGrupoTecnologico) {
        this.strDescGrupoTecnologico = pStrDescGrupoTecnologico;
    }
    /**
     * @return the strDescSituacion
     */
    public String getStrDescSituacion() {
        return strDescSituacion;
    }
    /**
     * @param strDescSituacion the pStrDescSituacion to set
     */
    public void setStrDescSituacion(String pStrDescSituacion) {
        this.strDescSituacion = pStrDescSituacion;
    }

}
