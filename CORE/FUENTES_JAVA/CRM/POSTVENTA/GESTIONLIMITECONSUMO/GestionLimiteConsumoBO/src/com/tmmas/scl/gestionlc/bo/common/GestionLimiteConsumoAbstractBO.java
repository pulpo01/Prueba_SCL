/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 *
 **/
package com.tmmas.scl.gestionlc.bo.common;

import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;

public class GestionLimiteConsumoAbstractBO {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();

    public void loggerDebug(String mensaje) {
        logger.debug(mensaje, this.getClass().getName());
    }

    public void loggerInfo(String mensaje) {
        logger.info(mensaje, this.getClass().getName());
    }

    public void loggerError(String mensaje) {
        logger.error(mensaje, this.getClass().getName());
    }

    public String getValorInterno(String propertie) {
        return global.getValor(propertie);
    }
}
