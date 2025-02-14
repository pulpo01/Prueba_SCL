package com.tmmas.cl.scl.tol.ServiceBundle.negocio.util;

import com.tmmas.cl.framework.util.MessageResourcesConfig;
import java.io.Serializable;

public class Global implements Serializable
{

    private static final long serialVersionUID = 1L;
    private static Global instance;
    private MessageResourcesConfig recurso;
    private final String archivoRecurso = "com.tmmas.cl.scl.tol.ServiceBundle.negocio.properties.negocio";
    
    public static synchronized Global getInstance()
    {
        if(instance == null)
            instance = new Global();
        return instance;
    }

    private Global()
    {
        recurso = new MessageResourcesConfig("com.tmmas.cl.scl.tol.ServiceBundle.negocio.properties.negocio");
    }

    public String getJndiFactory()
    {
        return recurso.obtenerValorClave("jndi.factory");
    }

    public String getJndiQueueInstallServiceBundle()
    {
        return recurso.obtenerValorClave("queue.installServiceBundle");
    }

    public String getJndiQueueUnInstallServiceBundle()
    {
        return recurso.obtenerValorClave("queue.uninstallServiceBundle");
    }

    public String getValor(String s)
    {
        return recurso.obtenerValorClave(s);
    }

    public String getInstallServiceBungleCode()
    {
        return recurso.obtenerValorClave("code.installServiceBundle");
    }

    public String getUnInstallServiceBungleCode()
    {
        return recurso.obtenerValorClave("code.uninstallServiceBundle");
    }

    public String getUninstallServiceBungleCode()
    {
        return recurso.obtenerValorClave("code.uninstallServiceBundle");
    }

    public String getCreateStorageAndFreeUnitStockCode()
    {
        return recurso.obtenerValorClave("code.createStorageAndFreeUnitStock");
    }

    public String getJndiQueueCreateStorageAndFreeUnitStock()
    {
        return recurso.obtenerValorClave("queue.createStorageAndFreeUnitStock");
    }


}