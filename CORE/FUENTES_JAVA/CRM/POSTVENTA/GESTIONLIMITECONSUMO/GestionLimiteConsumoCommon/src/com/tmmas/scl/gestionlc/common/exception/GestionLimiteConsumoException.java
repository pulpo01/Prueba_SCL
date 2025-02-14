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
 17-12-2010          Hugo Olivares              Versión Inicial 
 * 
 **/
package com.tmmas.scl.gestionlc.common.exception;

import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;

public class GestionLimiteConsumoException extends Exception {

    private static final long serialVersionUID = 1L;
    private String codigo;
    private int codigoEvento;
    private String descripcionEvento;
    private String message;
    private GlobalProperties global = GlobalProperties.getInstance();
    private Throwable cause;

    public GestionLimiteConsumoException() {

        super();
    }

    public GestionLimiteConsumoException(String pMessage) {

        super(pMessage);
        this.message = pMessage;
    }

    public GestionLimiteConsumoException(String pCodigo, int pCodigoEvento, String pDescripcionEvento) {
        super();

        this.codigo = pCodigo;
        this.codigoEvento = pCodigoEvento;
        this.descripcionEvento = pDescripcionEvento;
    }

    public GestionLimiteConsumoException(String pCodigo, int pCodigoEvento) {
        super();

        this.codigo = pCodigo;
        this.codigoEvento = pCodigoEvento;
        this.descripcionEvento = global.getValor(pCodigo);
    }

    public GestionLimiteConsumoException(Throwable pCause) {
        super(pCause);
        this.cause = pCause;
        this.codigo = "1";
        this.descripcionEvento = pCause.getMessage();
        // TODO Auto-generated constructor stub
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
