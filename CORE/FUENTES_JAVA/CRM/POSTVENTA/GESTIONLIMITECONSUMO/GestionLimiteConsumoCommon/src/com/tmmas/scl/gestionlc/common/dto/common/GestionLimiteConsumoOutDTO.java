/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
   21-12-2010       Hugo Olivares       Versión Inicial 
 *
 **/
package com.tmmas.scl.gestionlc.common.dto.common;

public class GestionLimiteConsumoOutDTO implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private int iEvento;
    private String strCodError = "0";
    private String strDesError = "";

    public int getIEvento() {
        return iEvento;
    }

    public void setIEvento(int evento) {
        iEvento = evento;
    }

    public String getStrCodError() {
        return this.strCodError;
    }

    public void setStrCodError(String strCodError) {
        this.strCodError = strCodError;
    }

    public String getStrDesError() {
        return this.strDesError;
    }

    public void setStrDesError(String strDesError) {
        this.strDesError = strDesError;
    }

}
