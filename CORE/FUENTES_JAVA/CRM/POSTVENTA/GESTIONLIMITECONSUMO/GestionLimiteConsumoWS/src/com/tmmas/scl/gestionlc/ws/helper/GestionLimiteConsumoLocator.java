package com.tmmas.scl.gestionlc.ws.helper;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumo;
import com.tmmas.scl.gestionlc.ejb.session.AbonoLimiteConsumoHome;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumo;
import com.tmmas.scl.gestionlc.ejb.session.ModificacionLimiteConsumoHome;

public class GestionLimiteConsumoLocator {

    private GlobalProperties global = GlobalProperties.getInstance();
    private final LoggerHelper logger = LoggerHelper.getInstance();
    private final String nombreClase = this.getClass().getName();

    public GestionLimiteConsumoLocator() {

    }

    // Metodo que obtiene interface local del EJB ModificacionLimiteConsumo
    public ModificacionLimiteConsumo getModificacionLimiteConsumoFacade() throws GestionLimiteConsumoException {
        logger.debug("getModificacionLimiteConsumoFacade():inicio", nombreClase);

        Context context = null;
        ModificacionLimiteConsumo modificacionLimiteConsumo = null;

        try {
            context = new InitialContext();
            String jndi = global.getValorExterno("jndi.ModificacionLimiteConsumo");
            logger.debug("jndi.ModificacionLimiteConsumo: " + jndi, nombreClase);

            String url = global.getValorExterno("url.ModificacionLimiteConsumoProvider");
            logger.debug("url.ModificacionLimiteConsumoProvider: " + url, nombreClase);

            String initialContextFactory = global.getValorExterno("initial.context.factory");
            logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

            String securityPrincipal = global.getValorExterno("security.principal");
            logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

            String securityCredentials = global.getValorExterno("security.credentials");
            logger.debug("securityCredentials: " + securityCredentials, nombreClase);

            Hashtable env = new Hashtable();
            env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
            env.put(Context.PROVIDER_URL, url);
            env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
            env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

            context = new InitialContext(env);

            Object obj = context.lookup(jndi);

            logger.debug("Antes de obtener Bean Remoto", nombreClase);

            ModificacionLimiteConsumoHome modificacionLimiteConsumoHome = (ModificacionLimiteConsumoHome) PortableRemoteObject.narrow(obj,
                    ModificacionLimiteConsumoHome.class);

            logger.debug("Despues de obtener Bean Remoto", nombreClase);

            modificacionLimiteConsumo = modificacionLimiteConsumoHome.create();

        } catch (Exception e) {
            logger.debug("Error: ", nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getModificacionLimiteConsumoFacade():fin", nombreClase);

        return modificacionLimiteConsumo;
    }

    // Metodo que obtiene interface local del EJB AbonoLimiteConsumo
    public AbonoLimiteConsumo getAbonoLimiteConsumoFacade() throws GestionLimiteConsumoException {
        logger.debug("getAbonoLimiteConsumoFacade():inicio", nombreClase);

        Context context = null;
        AbonoLimiteConsumo abonoLimiteConsumo = null;

        try {
            context = new InitialContext();
            String jndi = global.getValorExterno("jndi.AbonoLimiteConsumo");
            logger.debug("jndi.AbonoLimiteConsumo: " + jndi, nombreClase);

            String url = global.getValorExterno("url.AbonoLimiteConsumoProvider");
            logger.debug("url.AbonoLimiteConsumoProvider: " + url, nombreClase);

            String initialContextFactory = global.getValorExterno("initial.context.factory");
            logger.debug("initialContextFactory: " + initialContextFactory, nombreClase);

            String securityPrincipal = global.getValorExterno("security.principal");
            logger.debug("securityPrincipal: " + securityPrincipal, nombreClase);

            String securityCredentials = global.getValorExterno("security.credentials");
            logger.debug("securityCredentials: " + securityCredentials, nombreClase);

            Hashtable env = new Hashtable();
            env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
            env.put(Context.PROVIDER_URL, url);
            env.put(Context.SECURITY_PRINCIPAL, securityPrincipal);
            env.put(Context.SECURITY_CREDENTIALS, securityCredentials);

            context = new InitialContext(env);

            Object obj = context.lookup(jndi);

            logger.debug("Antes de obtener Bean Remoto", nombreClase);

            AbonoLimiteConsumoHome abonoLimiteConsumoHome = (AbonoLimiteConsumoHome) PortableRemoteObject.narrow(obj, AbonoLimiteConsumoHome.class);

            logger.debug("Despues de obtener Bean Remoto", nombreClase);

            abonoLimiteConsumo = abonoLimiteConsumoHome.create();

        } catch (Exception e) {
            logger.debug("Error: ", nombreClase);
            logger.debug("Exception: " + e, nombreClase);
            throw new GestionLimiteConsumoException("ERR.0002", 0, global.getValor("ERR.0002"));
        }

        logger.debug("getAbonoLimiteConsumoFacade():fin", nombreClase);

        return abonoLimiteConsumo;
    }

}
