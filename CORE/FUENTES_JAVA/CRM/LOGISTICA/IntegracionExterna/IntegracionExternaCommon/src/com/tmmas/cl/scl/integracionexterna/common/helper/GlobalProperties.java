/**
 * @(#)GlobalProperties.java 2009
 *
 * Copyright 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 */

package com.tmmas.cl.scl.integracionexterna.common.helper;

/**
 * La clase GlobalProperties provee unos m�todo de acceso a valores de 
 * propiedades contenidas en un archivo interno y externo para el proyecto
 * Archivo interno: com/tmmas/cl/scl/cambioSerie/common/properties/SpnSclBWSInterno.properties
 * Archivo externo: <user.dir>/propiedades/SpnSclBWSExterno.properties
 *
 * @author  Everis
 * @version 1.0, 13/09/2010
 * @cambio  Versi�n Inicial
 */

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

public final class GlobalProperties {
    
    private static GlobalProperties instance;
    private static String propertiesExterno = "/propiedades/IntegracionExternaExterno.properties";
    private ResourceBundle recurso;

    // --------------------------------------------------------------------------
    private GlobalProperties() {
        Properties propertieExterno = new Properties();
        FileInputStream propFile = null;
        try {
            propFile = new FileInputStream(System.getProperty("user.dir") + propertiesExterno);
            propertieExterno.load(propFile);
            propFile.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        final String archivoRecurso = propertieExterno.getProperty("GE.properties.interno.GE");
        recurso = ResourceBundle.getBundle(archivoRecurso);
    }

    // --------------------------------------------------------------------------
    public static synchronized GlobalProperties getInstance() {
        if (instance == null) {
            instance = new GlobalProperties();
        }
        return instance;
    }

    public String getValor(String valorClave) {
        try {
            String valor = this.recurso.getString(valorClave);
            return valor;
        } catch (Exception e) {
            return null;
        }
    }

    public int getValorInt(String valorClave) {
        try {
            int valor = Integer.parseInt(this.recurso.getString(valorClave));
            return valor;
        } catch (Exception e) {
            return 0;
        }
    }

    public String getValorExterno(String str) {
        Properties propertieExterno = new Properties();
        FileInputStream propFile = null;
        try {
            propFile = new FileInputStream(System.getProperty("user.dir") + propertiesExterno);
            propertieExterno.load(propFile);
            propFile.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return propertieExterno.getProperty(str);
    }

}
