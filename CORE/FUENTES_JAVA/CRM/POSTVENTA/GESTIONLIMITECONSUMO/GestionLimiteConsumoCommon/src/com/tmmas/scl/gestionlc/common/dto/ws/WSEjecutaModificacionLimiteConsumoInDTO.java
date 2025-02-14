package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

public class WSEjecutaModificacionLimiteConsumoInDTO implements Serializable {


    private static final long serialVersionUID = 1L;
    private String strNumAbonado;
    private String strMonto;
    private String strUserName;
    private String strComentario;
    /**
     * @return the strNumAbonado
     */
    public String getStrNumAbonado() {
        return strNumAbonado;
    }
    /**
     * @param strNumAbonado the strNumAbonado to set
     */
    public void setStrNumAbonado(String strNumAbonado) {
        this.strNumAbonado = strNumAbonado;
    }
    /**
     * @return the strMonto
     */
    public String getStrMonto() {
        return strMonto;
    }
    /**
     * @param strMonto the strMonto to set
     */
    public void setStrMonto(String strMonto) {
        this.strMonto = strMonto;
    }
    /**
     * @return the strUserName
     */
    public String getStrUserName() {
        return strUserName;
    }
    /**
     * @param strUserName the strUserName to set
     */
    public void setStrUserName(String strUserName) {
        this.strUserName = strUserName;
    }
    /**
     * @return the strComentario
     */
    public String getStrComentario() {
        return strComentario;
    }
    /**
     * @param strComentario the strComentario to set
     */
    public void setStrComentario(String strComentario) {
        this.strComentario = strComentario;
    }

}
