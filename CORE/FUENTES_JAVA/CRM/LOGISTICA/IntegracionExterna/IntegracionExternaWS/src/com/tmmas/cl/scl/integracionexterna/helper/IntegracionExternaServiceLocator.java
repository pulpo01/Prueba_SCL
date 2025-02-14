package com.tmmas.cl.scl.integracionexterna.helper;

import javax.naming.Context;
import javax.naming.InitialContext;

import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionexterna.negocio.session.IntegracionExternaLocal;
import com.tmmas.cl.scl.integracionexterna.negocio.session.IntegracionExternaLocalHome;

public class IntegracionExternaServiceLocator {

    private GlobalProperties global = GlobalProperties.getInstance();
    private final LoggerHelper logger = LoggerHelper.getInstance();
    private final String nombreClase = this.getClass().getName();

    public IntegracionExternaServiceLocator() {

    }

 // Metodo que obtiene interface local del EJB
    public IntegracionExternaLocal getIntegracionExternaLocal() throws IntegracionExternaException {
        logger.debug("getIntegracionExternaLocal():inicio", nombreClase);
        final Context context;
        IntegracionExternaLocalHome integracionExternaLocalHome = null;
        IntegracionExternaLocal integracionExternaLocal = null;

        try {
            context = new InitialContext();
            logger.debug("jndi.integracionExternaBeanLocal: " + global.getValor("jndi.integracionExternaBeanLocal"), nombreClase);
            logger.debug("Antes de obtener Bean Local", nombreClase);

            integracionExternaLocalHome = (IntegracionExternaLocalHome) context.lookup(global.getValor("jndi.integracionExternaBeanLocal"));
            integracionExternaLocal = integracionExternaLocalHome.create();
            logger.debug("Despues de obtener Bean Local", nombreClase);

        } catch (Exception e) {
            e.printStackTrace();
            logger.debug("Error: ", nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            throw new IntegracionExternaException("ERR.0003", 0, global.getValor("ERR.0003"));
        }

        logger.debug("getIntegracionExternaLocal():fin", nombreClase);
        return integracionExternaLocal;
    }

}
