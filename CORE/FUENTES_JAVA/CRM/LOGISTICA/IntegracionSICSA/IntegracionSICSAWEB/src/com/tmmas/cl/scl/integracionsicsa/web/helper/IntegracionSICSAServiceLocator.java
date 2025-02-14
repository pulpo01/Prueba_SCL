package com.tmmas.cl.scl.integracionsicsa.web.helper;

import javax.naming.Context;
import javax.naming.InitialContext;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocalHome;

public class IntegracionSICSAServiceLocator {

    private GlobalProperties global = GlobalProperties.getInstance();
    private final LoggerHelper logger = LoggerHelper.getInstance();
    private final String nombreClase = this.getClass().getName();

    public IntegracionSICSAServiceLocator() {

    }

 // Metodo que obtiene interface local del EJB
    public IntegracionSICSALocal getIntegracionSICSALocal() throws IntegracionSICSAException {
        logger.debug("getIntegracionSICSALocal():inicio", nombreClase);
        final Context context;
        IntegracionSICSALocalHome integracionSICSALocalHome = null;
        IntegracionSICSALocal integracionSICSALocal = null;

        try {
            context = new InitialContext();
            logger.debug("jndi.integracionSICSABeanLocal: " + global.getValor("jndi.integracionSICSABeanLocal"), nombreClase);
            logger.debug("Antes de obtener Bean Local", nombreClase);

            integracionSICSALocalHome = (IntegracionSICSALocalHome) context.lookup(global.getValor("jndi.integracionSICSABeanLocal"));
            integracionSICSALocal = integracionSICSALocalHome.create();
            logger.debug("Despues de obtener Bean Local", nombreClase);

        } catch (Exception e) {
            e.printStackTrace();
            logger.debug("Error: ", nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            throw new IntegracionSICSAException("ERR.0003", 0, global.getValor("ERR.0003"));
        }

        logger.debug("getIntegracionSICSALocal():fin", nombreClase);
        return integracionSICSALocal;
    }

}
