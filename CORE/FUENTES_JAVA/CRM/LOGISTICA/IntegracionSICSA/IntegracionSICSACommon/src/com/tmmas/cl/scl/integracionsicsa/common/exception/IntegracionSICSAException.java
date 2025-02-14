package com.tmmas.cl.scl.integracionsicsa.common.exception;

import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;


/**
 * Copyright © 2011 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones,
 * SA. Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile Todos los
 * derechos reservados.
 * 
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en
 * concordancia con los t&eacute;rminos de derechos de licencias que sean
 * adquiridos con TM-mAs.
 * 
 * Fecha ------------------- Autor ------------------------- Cambios ----------
 * 02/09/2011 			Hugo Olivares 					Versión Inicial
 * 
 **/
public class IntegracionSICSAException extends Exception {

    private static final long serialVersionUID = 1L;
    private String codigo;
    private int codigoEvento;
    private String descripcionEvento;
    private String message;
    private GlobalProperties global = GlobalProperties.getInstance();

    public IntegracionSICSAException() {

        super();
    }

    public IntegracionSICSAException(String pMessage) {

        super(pMessage);
        this.message = pMessage;
    }
    
    public IntegracionSICSAException(String pCodigo, int pCodigoEvento, String pDescripcionEvento) {
        super();

        this.codigo = pCodigo;
        this.codigoEvento = pCodigoEvento;
        this.descripcionEvento = pDescripcionEvento;
    }

    public IntegracionSICSAException(String pCodigo, int pCodigoEvento) {
        super();

        this.codigo = pCodigo;
        this.codigoEvento = pCodigoEvento;
        this.descripcionEvento = global.getValor(codigo);
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String pCodigo) {
        this.codigo = pCodigo;
    }

    public int getCodigoEvento() {
        return codigoEvento;
    }

    public void setCodigoEvento(int pCodigoEvento) {
        this.codigoEvento = pCodigoEvento;
    }

    public String getDescripcionEvento() {
        return descripcionEvento;
    }

    public void setDescripcionEvento(String pDescripcionEvento) {
        this.descripcionEvento = pDescripcionEvento;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String pMessage) {
        this.message = pMessage;
    }

}
