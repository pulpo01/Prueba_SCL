package com.tmmas.cl.scl.integracionexterna.common.dto.ws;

public class SalidaIntegracionExternaDTO implements java.io.Serializable {

    private static final long serialVersionUID = 1L;
    
    private int iEvento;
    private String strCodError = "0";
    private String strDesError = "OK";

    public int getIEvento() {
        return iEvento;
    }

    public void setIEvento(int evento) {
        iEvento = evento;
    }

    public String getStrCodError() {
        return strCodError;
    }

    public void setStrCodError(String strCodError) {
        this.strCodError = strCodError;
    }

    public String getStrDesError() {
        return strDesError;
    }

    public void setStrDesError(String strDesError) {
        this.strDesError = strDesError;
    }

}
