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
   17-12-2010			     Hugo Olivares      			Versión Inicial 
 * 
 **/
package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;


public class IntegracionSICSABO {

    private final LoggerHelper logger = LoggerHelper.getInstance();

    public final void loggerDebug(String mensaje) {
        logger.debug(mensaje, this.getClass().getName());
    }

    public final void loggerInfo(String mensaje) {
        logger.info(mensaje, this.getClass().getName());
    }

    public final void loggerError(String mensaje) {
        logger.error(mensaje, this.getClass().getName());
    }
}
